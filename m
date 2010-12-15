From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] t4034: bulk verify builtin word regex sanity
Date: Wed, 15 Dec 2010 16:13:28 +0100
Message-ID: <43966a52d144d79d22c98a24cab53403537dfcac.1292424926.git.trast@student.ethz.ch>
References: <cover.1292424926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Scott Johnson <scottj75074@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 16:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSt3G-00060n-Bw
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 16:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab0LOPNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 10:13:40 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7134 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab0LOPNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 10:13:32 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:22 +0100
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 15 Dec
 2010 16:13:30 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292424926.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163783>

The builtin word regexes should be tested with some simple examples
against simple issues, like failing to match a non-space character.

Do this in bulk.  Many of these patterns are a rather ad-hoc
combination of a few simple lines of code, so they can certainly be
improved.  However, they already unearthed a typo in the ruby pattern
(previous commit).

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t4034-diff-words.sh  |   20 ++++++++++++++++++++
 t/t4034/bibtex/expect  |   15 +++++++++++++++
 t/t4034/bibtex/post    |   10 ++++++++++
 t/t4034/bibtex/pre     |    9 +++++++++
 t/t4034/cpp/expect     |   10 ++++++++++
 t/t4034/cpp/post       |    5 +++++
 t/t4034/cpp/pre        |    4 ++++
 t/t4034/csharp/expect  |   12 ++++++++++++
 t/t4034/csharp/post    |    8 ++++++++
 t/t4034/csharp/pre     |    8 ++++++++
 t/t4034/fortran/expect |   12 ++++++++++++
 t/t4034/fortran/post   |    7 +++++++
 t/t4034/fortran/pre    |    7 +++++++
 t/t4034/html/expect    |    7 +++++++
 t/t4034/html/post      |    2 ++
 t/t4034/html/pre       |    2 ++
 t/t4034/java/expect    |   11 +++++++++++
 t/t4034/java/post      |    6 ++++++
 t/t4034/java/pre       |    6 ++++++
 t/t4034/objc/expect    |   11 +++++++++++
 t/t4034/objc/post      |    7 +++++++
 t/t4034/objc/pre       |    7 +++++++
 t/t4034/pascal/expect  |   12 ++++++++++++
 t/t4034/pascal/post    |    7 +++++++
 t/t4034/pascal/pre     |    7 +++++++
 t/t4034/php/expect     |    7 +++++++
 t/t4034/php/post       |    2 ++
 t/t4034/php/pre        |    2 ++
 t/t4034/python/expect  |    8 ++++++++
 t/t4034/python/post    |    3 +++
 t/t4034/python/pre     |    3 +++
 t/t4034/ruby/expect    |    7 +++++++
 t/t4034/ruby/post      |    2 ++
 t/t4034/ruby/pre       |    2 ++
 t/t4034/tex/expect     |    9 +++++++++
 t/t4034/tex/post       |    4 ++++
 t/t4034/tex/pre        |    4 ++++
 37 files changed, 265 insertions(+), 0 deletions(-)
 create mode 100644 t/t4034/bibtex/expect
 create mode 100644 t/t4034/bibtex/post
 create mode 100644 t/t4034/bibtex/pre
 create mode 100644 t/t4034/cpp/expect
 create mode 100644 t/t4034/cpp/post
 create mode 100644 t/t4034/cpp/pre
 create mode 100644 t/t4034/csharp/expect
 create mode 100644 t/t4034/csharp/post
 create mode 100644 t/t4034/csharp/pre
 create mode 100644 t/t4034/fortran/expect
 create mode 100644 t/t4034/fortran/post
 create mode 100644 t/t4034/fortran/pre
 create mode 100644 t/t4034/html/expect
 create mode 100644 t/t4034/html/post
 create mode 100644 t/t4034/html/pre
 create mode 100644 t/t4034/java/expect
 create mode 100644 t/t4034/java/post
 create mode 100644 t/t4034/java/pre
 create mode 100644 t/t4034/objc/expect
 create mode 100644 t/t4034/objc/post
 create mode 100644 t/t4034/objc/pre
 create mode 100644 t/t4034/pascal/expect
 create mode 100644 t/t4034/pascal/post
 create mode 100644 t/t4034/pascal/pre
 create mode 100644 t/t4034/php/expect
 create mode 100644 t/t4034/php/post
 create mode 100644 t/t4034/php/pre
 create mode 100644 t/t4034/python/expect
 create mode 100644 t/t4034/python/post
 create mode 100644 t/t4034/python/pre
 create mode 100644 t/t4034/ruby/expect
 create mode 100644 t/t4034/ruby/post
 create mode 100644 t/t4034/ruby/pre
 create mode 100644 t/t4034/tex/expect
 create mode 100644 t/t4034/tex/post
 create mode 100644 t/t4034/tex/pre

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index ebe72ce..b085948 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -394,4 +394,24 @@ test_expect_success 'diff.wordRegexCheck unset is like "warn"' '
 
 '
 
+test_expect_success 'set diff.wordRegexCheck=error for language tests' '
+
+	git config diff.wordRegexCheck error
+
+'
+
+word_diff_for_language () {
+	cp $TEST_DIRECTORY/t4034/$1/pre $TEST_DIRECTORY/t4034/$1/post \
+		$TEST_DIRECTORY/t4034/$1/expect . &&
+	echo "* diff=$1" > .gitattributes &&
+	word_diff --color-words
+}
+
+for lang_dir in $TEST_DIRECTORY/t4034/*; do
+	lang=${lang_dir#$TEST_DIRECTORY/t4034/}
+	test_expect_success "diff driver '$lang' has sane word regex" "
+		word_diff_for_language $lang
+	"
+done
+
 test_done
diff --git a/t/t4034/bibtex/expect b/t/t4034/bibtex/expect
new file mode 100644
index 0000000..a157774
--- /dev/null
+++ b/t/t4034/bibtex/expect
@@ -0,0 +1,15 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 95cd55b..ddcba9b 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,9 +1,10 @@<RESET>
+@article{aldous1987uie,<RESET>
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},<RESET>
+  author={Aldous, <RED>D.<RESET><GREEN>David<RESET>},
+  journal={Information Theory, IEEE Transactions on},<RESET>
+  volume={<RED>33<RESET><GREEN>Bogus.<RESET>},
+  number={<RED>2<RESET><GREEN>4<RESET>},
+  pages={219--223},<RESET>
+  year=<GREEN>1987,<RESET>
+<GREEN>  note={This is in fact a rather funny read since ethernet works well in practice. The<RESET> {<RED>1987<RESET><GREEN>\em pre} reference is the right one, however.<RESET>}<RED>,<RESET>
+}<RESET>
diff --git a/t/t4034/bibtex/post b/t/t4034/bibtex/post
new file mode 100644
index 0000000..ddcba9b
--- /dev/null
+++ b/t/t4034/bibtex/post
@@ -0,0 +1,10 @@
+@article{aldous1987uie,
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},
+  author={Aldous, David},
+  journal={Information Theory, IEEE Transactions on},
+  volume={Bogus.},
+  number={4},
+  pages={219--223},
+  year=1987,
+  note={This is in fact a rather funny read since ethernet works well in practice. The {\em pre} reference is the right one, however.}
+}
diff --git a/t/t4034/bibtex/pre b/t/t4034/bibtex/pre
new file mode 100644
index 0000000..95cd55b
--- /dev/null
+++ b/t/t4034/bibtex/pre
@@ -0,0 +1,9 @@
+@article{aldous1987uie,
+  title={{Ultimate instability of exponential back-off protocol for acknowledgment-based transmission control of random access communication channels}},
+  author={Aldous, D.},
+  journal={Information Theory, IEEE Transactions on},
+  volume={33},
+  number={2},
+  pages={219--223},
+  year={1987},
+}
diff --git a/t/t4034/cpp/expect b/t/t4034/cpp/expect
new file mode 100644
index 0000000..e529842
--- /dev/null
+++ b/t/t4034/cpp/expect
@@ -0,0 +1,10 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 5517c3c..17aa265 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,5 @@<RESET>
+class Foo : public Thing{
+	Foo() : x(0<RED>&&1<RESET><GREEN>&42<RESET>) {
+		<GREEN>bar(x);<RESET>
+	}
+}<GREEN>;<RESET>
diff --git a/t/t4034/cpp/post b/t/t4034/cpp/post
new file mode 100644
index 0000000..17aa265
--- /dev/null
+++ b/t/t4034/cpp/post
@@ -0,0 +1,5 @@
+class Foo : public Thing{
+	Foo() : x(0&42) {
+		bar(x);
+	}
+};
diff --git a/t/t4034/cpp/pre b/t/t4034/cpp/pre
new file mode 100644
index 0000000..5517c3c
--- /dev/null
+++ b/t/t4034/cpp/pre
@@ -0,0 +1,4 @@
+class Foo:public Thing{
+	Foo():x(0&&1){}
+}
+
diff --git a/t/t4034/csharp/expect b/t/t4034/csharp/expect
new file mode 100644
index 0000000..c8b6b8f
--- /dev/null
+++ b/t/t4034/csharp/expect
@@ -0,0 +1,12 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 8ff9319..9869fa9 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -2,7 +2,7 @@<RESET> <RESET><MAGENTA>class Program<RESET>
+{<RESET>
+	static void Main()<RESET>
+	{<RESET>
+		Console.WriteLine("Hello, <GREEN>New<RESET> World!");
+		int i = <RED>5<RESET><GREEN>5+0<RESET>;
+	}<RESET>
+}<RESET>
diff --git a/t/t4034/csharp/post b/t/t4034/csharp/post
new file mode 100644
index 0000000..9869fa9
--- /dev/null
+++ b/t/t4034/csharp/post
@@ -0,0 +1,8 @@
+class Program
+{
+	static void Main()
+	{
+		Console.WriteLine("Hello, New World!");
+		int i = 5+0;
+	}
+}
diff --git a/t/t4034/csharp/pre b/t/t4034/csharp/pre
new file mode 100644
index 0000000..8ff9319
--- /dev/null
+++ b/t/t4034/csharp/pre
@@ -0,0 +1,8 @@
+class Program
+{
+	static void Main()
+	{
+		Console.WriteLine("Hello, World!");
+		int i=5;
+	}
+}
diff --git a/t/t4034/fortran/expect b/t/t4034/fortran/expect
new file mode 100644
index 0000000..5a25663
--- /dev/null
+++ b/t/t4034/fortran/expect
@@ -0,0 +1,12 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 08b4e5a..fb7cb51 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,7 +1,7 @@<RESET>
+program hello<RESET>
+   print *, "Hello World<RED>!<RESET><GREEN>?<RESET>"
+
+   DO10I = 1,10<RESET>
+   <RED>DO10I<RESET><GREEN>DO 10 I<RESET> = 1,10
+   <RED>DO10I<RESET><GREEN>DO 1 0 I<RESET> = 1,10
+end program hello<RESET>
diff --git a/t/t4034/fortran/post b/t/t4034/fortran/post
new file mode 100644
index 0000000..fb7cb51
--- /dev/null
+++ b/t/t4034/fortran/post
@@ -0,0 +1,7 @@
+program hello
+   print *, "Hello World?"
+
+   DO10I = 1,10
+   DO 10 I = 1,10
+   DO 1 0 I = 1,10
+end program hello
diff --git a/t/t4034/fortran/pre b/t/t4034/fortran/pre
new file mode 100644
index 0000000..08b4e5a
--- /dev/null
+++ b/t/t4034/fortran/pre
@@ -0,0 +1,7 @@
+program hello
+   print *, "Hello World!"
+
+   DO10I = 1,10
+   DO10I = 1,10
+   DO10I = 1,10
+end program hello
diff --git a/t/t4034/html/expect b/t/t4034/html/expect
new file mode 100644
index 0000000..78d28d4
--- /dev/null
+++ b/t/t4034/html/expect
@@ -0,0 +1,7 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 8bf936a..125bdd5 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,2 +1,2 @@<RESET>
+<li<RED>class="yws-maps"<RESET>><em></em><a href="#">yws-maps</a></li>
+<li<RED>class="ydn-delicious"<RESET>><em></em><a href="#">ydn-delicious</a></li>
diff --git a/t/t4034/html/post b/t/t4034/html/post
new file mode 100644
index 0000000..125bdd5
--- /dev/null
+++ b/t/t4034/html/post
@@ -0,0 +1,2 @@
+<li><em></em><a href="#">yws-maps</a></li>
+<li><em></em><a href="#">ydn-delicious</a></li>
diff --git a/t/t4034/html/pre b/t/t4034/html/pre
new file mode 100644
index 0000000..8bf936a
--- /dev/null
+++ b/t/t4034/html/pre
@@ -0,0 +1,2 @@
+<li class="yws-maps"><em></em><a href="#">yws-maps</a></li>
+<li class="ydn-delicious"><em></em><a href="#">ydn-delicious</a></li>
diff --git a/t/t4034/java/expect b/t/t4034/java/expect
new file mode 100644
index 0000000..9d99523
--- /dev/null
+++ b/t/t4034/java/expect
@@ -0,0 +1,11 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index ae11cd3..fd61213 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,6 +1,6 @@<RESET>
+public class HelloWorld {<RESET>
+   public static void main(String[] args) {<RESET>
+       System.out.println("Hello <RED>,<RESET><GREEN>--<RESET> world!");
+       int i = <RED>1+2<RESET><GREEN>1 + 2<RESET>;
+   }<RESET>
+}<RESET>
diff --git a/t/t4034/java/post b/t/t4034/java/post
new file mode 100644
index 0000000..fd61213
--- /dev/null
+++ b/t/t4034/java/post
@@ -0,0 +1,6 @@
+public class HelloWorld {
+   public static void main(String[] args) {
+       System.out.println("Hello -- world!");
+       int i = 1 + 2;
+   }
+}
diff --git a/t/t4034/java/pre b/t/t4034/java/pre
new file mode 100644
index 0000000..ae11cd3
--- /dev/null
+++ b/t/t4034/java/pre
@@ -0,0 +1,6 @@
+public class HelloWorld {
+   public static void main(String[] args) {
+       System.out.println("Hello, world!");
+       int i = 1+2;
+   }
+}
diff --git a/t/t4034/objc/expect b/t/t4034/objc/expect
new file mode 100644
index 0000000..a29fec5
--- /dev/null
+++ b/t/t4034/objc/expect
@@ -0,0 +1,11 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 8eb298d..e728a08 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -2,6 +2,6 @@<RESET>
+ <RESET>
+int main (void)<RESET>
+{<RESET>
+	int i = <RED>1+2<RESET><GREEN>1 + 2<RESET>;
+	printf ("Hello<GREEN>, new<RESET> world!\n");
+}<RESET>
diff --git a/t/t4034/objc/post b/t/t4034/objc/post
new file mode 100644
index 0000000..e728a08
--- /dev/null
+++ b/t/t4034/objc/post
@@ -0,0 +1,7 @@
+#import <stdio.h>
+ 
+int main (void)
+{
+	int i = 1 + 2;
+	printf ("Hello, new world!\n");
+}
diff --git a/t/t4034/objc/pre b/t/t4034/objc/pre
new file mode 100644
index 0000000..8eb298d
--- /dev/null
+++ b/t/t4034/objc/pre
@@ -0,0 +1,7 @@
+#import <stdio.h>
+ 
+int main (void)
+{
+	int i = 1+2;
+	printf ("Hello world!\n");
+}
diff --git a/t/t4034/pascal/expect b/t/t4034/pascal/expect
new file mode 100644
index 0000000..10953cf
--- /dev/null
+++ b/t/t4034/pascal/expect
@@ -0,0 +1,12 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 7c5fbef..bdd5df9 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,7 +1,7 @@<RESET>
+program HelloWorld;<RESET>
+var<RESET>
+   i : integer;
+begin<RESET>
+   i = i <RED>+1<RESET><GREEN>+ 1<RESET>;
+   writeln('Hello<GREEN>, new<RESET> world!');
+end.<RESET>
diff --git a/t/t4034/pascal/post b/t/t4034/pascal/post
new file mode 100644
index 0000000..bdd5df9
--- /dev/null
+++ b/t/t4034/pascal/post
@@ -0,0 +1,7 @@
+program HelloWorld;
+var
+   i : integer;
+begin
+   i = i + 1;
+   writeln('Hello, new world!');
+end.
diff --git a/t/t4034/pascal/pre b/t/t4034/pascal/pre
new file mode 100644
index 0000000..7c5fbef
--- /dev/null
+++ b/t/t4034/pascal/pre
@@ -0,0 +1,7 @@
+program HelloWorld;
+var
+   i: integer;
+begin
+   i = i+1;
+   writeln('Hello world!');
+end.
diff --git a/t/t4034/php/expect b/t/t4034/php/expect
new file mode 100644
index 0000000..171cfd5
--- /dev/null
+++ b/t/t4034/php/expect
@@ -0,0 +1,7 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 646a13d..1b1fe22 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,2 +1,2 @@<RESET>
+$i =<RED>$i+1<RESET><GREEN>CONSTANT + 1<RESET>;
+echo "Hello, <GREEN>New<RESET> World!\n";
diff --git a/t/t4034/php/post b/t/t4034/php/post
new file mode 100644
index 0000000..1b1fe22
--- /dev/null
+++ b/t/t4034/php/post
@@ -0,0 +1,2 @@
+$i =CONSTANT + 1;
+echo "Hello, New World!\n";
diff --git a/t/t4034/php/pre b/t/t4034/php/pre
new file mode 100644
index 0000000..646a13d
--- /dev/null
+++ b/t/t4034/php/pre
@@ -0,0 +1,2 @@
+$i=$i+1;
+echo "Hello, World!\n";
diff --git a/t/t4034/python/expect b/t/t4034/python/expect
new file mode 100644
index 0000000..bf6a30b
--- /dev/null
+++ b/t/t4034/python/expect
@@ -0,0 +1,8 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 2261a37..1076af0 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,3 +1,3 @@<RESET>
+<RED>foo.bar()<RESET><GREEN>foo . bar (stuff)<RESET>
+i = <RED>i+1<RESET><GREEN>i + 1<RESET>
+print "Hello, <GREEN>New<RESET> World!\n"
diff --git a/t/t4034/python/post b/t/t4034/python/post
new file mode 100644
index 0000000..1076af0
--- /dev/null
+++ b/t/t4034/python/post
@@ -0,0 +1,3 @@
+foo . bar (stuff)
+i = i + 1
+print "Hello, New World!\n"
diff --git a/t/t4034/python/pre b/t/t4034/python/pre
new file mode 100644
index 0000000..2261a37
--- /dev/null
+++ b/t/t4034/python/pre
@@ -0,0 +1,3 @@
+foo.bar()
+i = i+1
+print "Hello, World!\n"
diff --git a/t/t4034/ruby/expect b/t/t4034/ruby/expect
new file mode 100644
index 0000000..72ff72b
--- /dev/null
+++ b/t/t4034/ruby/expect
@@ -0,0 +1,7 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 1961e79..d954376 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,2 +1,2 @@<RESET>
+10.downto(<RED>1<RESET><GREEN>2<RESET>) { |x| puts x }
+puts 'Hello <GREEN>new<RESET> world'
diff --git a/t/t4034/ruby/post b/t/t4034/ruby/post
new file mode 100644
index 0000000..d954376
--- /dev/null
+++ b/t/t4034/ruby/post
@@ -0,0 +1,2 @@
+10.downto(2) { |x| puts x }
+puts 'Hello new world'
diff --git a/t/t4034/ruby/pre b/t/t4034/ruby/pre
new file mode 100644
index 0000000..1961e79
--- /dev/null
+++ b/t/t4034/ruby/pre
@@ -0,0 +1,2 @@
+10.downto(1) {|x| puts x}
+puts 'Hello world'
diff --git a/t/t4034/tex/expect b/t/t4034/tex/expect
new file mode 100644
index 0000000..604969b
--- /dev/null
+++ b/t/t4034/tex/expect
@@ -0,0 +1,9 @@
+<BOLD>diff --git a/pre b/post<RESET>
+<BOLD>index 2b2dfcb..65cab61 100644<RESET>
+<BOLD>--- a/pre<RESET>
+<BOLD>+++ b/post<RESET>
+<CYAN>@@ -1,4 +1,4 @@<RESET>
+\section{Something <GREEN>new<RESET>}
+<RED>\emph<RESET><GREEN>\textbf<RESET>{Macro style}
+{<RED>\em<RESET><GREEN>\bfseries<RESET> State toggle style}
+\\[<RED>1em<RESET><GREEN>1cm<RESET>]
diff --git a/t/t4034/tex/post b/t/t4034/tex/post
new file mode 100644
index 0000000..65cab61
--- /dev/null
+++ b/t/t4034/tex/post
@@ -0,0 +1,4 @@
+\section{Something new}
+\textbf{Macro style}
+{\bfseries State toggle style}
+\\[1cm]
diff --git a/t/t4034/tex/pre b/t/t4034/tex/pre
new file mode 100644
index 0000000..2b2dfcb
--- /dev/null
+++ b/t/t4034/tex/pre
@@ -0,0 +1,4 @@
+\section{Something}
+\emph{Macro style}
+{\em State toggle style}
+\\[1em]
-- 
1.7.3.3.807.g6ee1f
