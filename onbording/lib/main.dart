import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    const PageBuilder(
      title: "Good Morning",
      description: "Hello sir have a good day",
      image: "assets/images/sammy-dog-1.gif",
    ),
    const PageBuilder(
      title: "Good Afternoon",
      description: "Hello sir have a good day",
      image: "assets/images/sammy-dog-6.gif",
    ),
    const PageBuilder(
      title: "Good Evening",
      description: "Hello sir have a good day",
      image:
          "assets/images/sammy-man-and-dog-delivering-packages-on-a-moped.gif",
    ),
  ];
  int _currentIndex = 0;
  late final PageController _pageController;
  String buttonText = "Skip";

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                if (index == pages.length - 1) {
                  buttonText = "Finish";
                } else {
                  buttonText = "Skip";
                }
                _currentIndex = index;
              });
            },
            children: pages,
          ),
          Container(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(buttonText),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(),
                  onDotClicked: (index) => setState(() {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }),
                ),
                _currentIndex == pages.length - 1
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text("Next"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PageBuilder extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const PageBuilder(
      {super.key,
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Center(child: Image.asset(image, height: 300)),
          Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Center(
            child: Text(
              description,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
