import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobyfilx/cubits/cubits.dart';
import 'package:tobyfilx/data/data.dart';
import 'package:tobyfilx/widgets/content_header.dart';
import 'package:tobyfilx/widgets/content_list.dart';
import 'package:tobyfilx/widgets/custom_app_bar.dart';
import 'package:tobyfilx/widgets/previews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double scrollOffset = 0.0;
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        // setState(() {
        //   scrollOffset = scrollController.offset;
        // });

        context.bloc<AppBarCubit>().setOffset(scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        onPressed: () => print("cast"),
        child: const Icon(Icons.cast),
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0),
        // child: CustomAppBar(scrollOffset: scrollOffset),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) =>
              CustomAppBar(scrollOffset: scrollOffset),
        ),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title: "Previews",
                constentList: previews,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('myList'),
              title: "My List",
              contentList: myList,
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
              key: PageStorageKey('originals'),
              title: "Tobyflix Originals",
              contentList: originals,
              isOriginals: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('trending'),
                title: "Trending",
                contentList: trending,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
