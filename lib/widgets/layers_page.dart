import 'dart:ui';

import 'package:creator_flow/creator_page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayersPage extends StatelessWidget {
  const LayersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var pageState = context.watch<CreatorPageState>();
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.84),
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          SafeArea(
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Column(
                children: [
                  // add appbar
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ReorderableListView(
                      shrinkWrap: true,
                      onReorder: (oldIndex, newIndex) {
                        pageState.changeLayerIndex(oldIndex, newIndex);
                      },
                      children:
                          pageState.canvasWidgets.asMap().entries.map((entry) {
                        int index = entry.key;
                        WidgetData e = entry.value;
                        return Container(
                          key: ValueKey(index),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.menu,
                                color: Colors.white30,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: e.type == WidgetType.text
                                    ? Text(
                                        e.data.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Image.network(
                                        e.data.toString(),
                                        height: 100,
                                        width: 100,
                                      ),
                              ),
                              IconButton(
                                onPressed: () {
                                  pageState.removeTransformationState(index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
