From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2.5 1/8] t4051: rewrite, add more tests
Date: Tue, 31 May 2016 22:00:38 +0200
Message-ID: <574DED66.6050008@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de> <5749B1EA.10707@web.de>
 <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 22:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7pvK-0005yq-KZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbcEaUBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 16:01:24 -0400
Received: from mout.web.de ([212.227.15.4]:53555 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbcEaUBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 16:01:21 -0400
Received: from [192.168.178.36] ([79.213.120.243]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MCeX4-1bH9WM3lUw-009P0A; Tue, 31 May 2016 22:01:05
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:0sD5OYr/AGt6GyaTuKUde0SgZJvcab1pGWPmCCNI6/j1wGw14HU
 xMc+Ossp3fYl4qi5OYh/3UbWxHwdih1tqSnED3VQtGdMQlH4OZvLwi951kZIYyCLjvsMT/V
 K3UjpszQVAD057YUODepLGiiigJK+BWQUlGBGezDF/WXqdiWkOv0wZD4yJkdatNvCR/zFsr
 6rO/0PBSJat0OSDsppL8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9c4CsUaooR0=:EZxiiQBAhJAUBExSjXO0fi
 VidRga71qz/K9odBO/saWt2tn7jJHwy0u0jDbZoOd/8qjT33QiPL1xnpRcNu3iTi8Q6f8NteM
 RMqGmNzRWONevadDkm2wJlTXPNcOINRckg5UjQI3axI9LGOzocgftmwWgwOOFonFVfVu3nAJ/
 i7oKvY5RebcGU2XrcXd1y4LSdXOQia0LoOrbRIlvAgleZ6YDVAO7bVQinbA/MHhR+WNWlUkzJ
 B8GSAUZbTs/t9RbiDevQfvYB4Ds/g6DFWP93vL3nCFIejnqVQGYUS2IUykIeGVazuO1AP7iOW
 xhAB11U6G/H49ZaqjHNxkZC/1pGHB/DohxAEDyryZ/bXGlVeEDTRYtBv5++2WcxkTSeiyLJXI
 +WVK/JmeWrNnp7ucJNvge4lTZ7vFOnqbfPamyqgp78kYdTI+gki0mdeskp6eyoZRNk8j2gTyZ
 JXFzBJAWyz/MWyUF3/Jj3F7QH1i9A0JH8yrl9ExzjQhFmSxv7NZNquWuL0omJQk9ZE7bgvTZb
 IyHM0sVriwu1/csHFJZxIwC0RaLmRuL+yhy9ZWbINK90J2qf404k2k7TkaIAkhcgLSfHLGVpM
 93uy2kKJDpmfvIay8HlYNSj0ahPt0U/kEHtInEwK4rObEJDx6tlMHfcD1q96aQ3dLMmdhgDna
 qDKp8hQ8l1wlEuMK7MySXXDzgcF+aTdp780Lz6zgaYkKwYnKDxP4Vj1eK0/+EVLG8H85IpyTX
 wlk+st3STwrXZH3Q9MJDMOn+lUYysMlBMjTnE93uJh9Cmz28qEFIYSnT4+O5oTUdUWOJo3Xe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296009>

Remove the tests that checked against a fixed result and replace them
with more focused checks of desired properties of the created diffs.
That way we get more detailed and meaningful diagnostics.

Store test file contents in files in a subdirectory in order to avoid
cluttering the test script with them.

Use tagged commits to store the changes to test diff -W against instead
of using changes to the worktree.  Use the worktree instead to try and
apply the generated patch in order to validate it.

Document unwanted features: trailing empty lines, too much context for
appended functions, insufficient context at the end with -U0.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Replacement for the first patch addressing review comments, the other
seven patches are unchanged.

 t/t4051-diff-function-context.sh | 216 +++++++++++++++++++++++++--------------
 t/t4051/appended1.c              |  15 +++
 t/t4051/appended2.c              |  35 +++++++
 t/t4051/dummy.c                  |   7 ++
 t/t4051/hello.c                  |  21 ++++
 t/t4051/includes.c               |  20 ++++
 6 files changed, 240 insertions(+), 74 deletions(-)
 create mode 100644 t/t4051/appended1.c
 create mode 100644 t/t4051/appended2.c
 create mode 100644 t/t4051/dummy.c
 create mode 100644 t/t4051/hello.c
 create mode 100644 t/t4051/includes.c

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index 001d678..ca01725 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -3,90 +3,158 @@
 test_description='diff function context'
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/diff-lib.sh
 
+dir="$TEST_DIRECTORY/t4051"
 
-cat <<\EOF >hello.c
-#include <stdio.h>
-
-static int a(void)
-{
-	/*
-	 * Dummy.
-	 */
+commit_and_tag () {
+	tag=$1 &&
+	shift &&
+	git add "$@" &&
+	test_tick &&
+	git commit -m "$tag" &&
+	git tag "$tag"
 }
 
-static int hello_world(void)
-{
-	/* Classic. */
-	printf("Hello world.\n");
-
-	/* Success! */
-	return 0;
+first_context_line () {
+	awk '
+		found {print; exit}
+		/^@@/ {found = 1}
+	'
 }
-static int b(void)
-{
-	/*
-	 * Dummy, too.
-	 */
+
+last_context_line () {
+	sed -ne \$p
 }
 
-int main(int argc, char **argv)
-{
-	a();
-	b();
-	return hello_world();
+check_diff () {
+	name=$1
+	desc=$2
+	options="-W $3"
+
+	test_expect_success "$desc" '
+		git diff $options "$name^" "$name" >"$name.diff"
+	'
+
+	test_expect_success ' diff applies' '
+		test_when_finished "git reset --hard" &&
+		git checkout --detach "$name^" &&
+		git apply --index "$name.diff" &&
+		git diff --exit-code "$name"
+	'
 }
-EOF
 
 test_expect_success 'setup' '
-	git add hello.c &&
-	test_tick &&
-	git commit -m initial &&
-
-	grep -v Classic <hello.c >hello.c.new &&
-	mv hello.c.new hello.c
-'
-
-cat <<\EOF >expected
-diff --git a/hello.c b/hello.c
---- a/hello.c
-+++ b/hello.c
-@@ -10,8 +10,7 @@ static int a(void)
- static int hello_world(void)
- {
--	/* Classic. */
- 	printf("Hello world.\n");
- 
- 	/* Success! */
- 	return 0;
- }
-EOF
-
-test_expect_success 'diff -U0 -W' '
-	git diff -U0 -W >actual &&
-	compare_diff_patch actual expected
-'
-
-cat <<\EOF >expected
-diff --git a/hello.c b/hello.c
---- a/hello.c
-+++ b/hello.c
-@@ -9,9 +9,8 @@ static int a(void)
- 
- static int hello_world(void)
- {
--	/* Classic. */
- 	printf("Hello world.\n");
- 
- 	/* Success! */
- 	return 0;
- }
-EOF
-
-test_expect_success 'diff -W' '
-	git diff -W >actual &&
-	compare_diff_patch actual expected
+	cat "$dir/includes.c" "$dir/dummy.c" "$dir/dummy.c" "$dir/hello.c" \
+		"$dir/dummy.c" "$dir/dummy.c" >file.c &&
+	commit_and_tag initial file.c &&
+
+	grep -v "delete me from hello" <file.c >file.c.new &&
+	mv file.c.new file.c &&
+	commit_and_tag changed_hello file.c &&
+
+	grep -v "delete me from includes" <file.c >file.c.new &&
+	mv file.c.new file.c &&
+	commit_and_tag changed_includes file.c &&
+
+	cat "$dir/appended1.c" >>file.c &&
+	commit_and_tag appended file.c &&
+
+	cat "$dir/appended2.c" >>file.c &&
+	commit_and_tag extended file.c &&
+
+	grep -v "Begin of second part" <file.c >file.c.new &&
+	mv file.c.new file.c &&
+	commit_and_tag long_common_tail file.c
+'
+
+check_diff changed_hello 'changed function'
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin of hello" changed_hello.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^ .*End of hello" changed_hello.diff
+'
+
+test_expect_success ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" changed_hello.diff) -le 1
+'
+
+test_expect_success ' context does not include preceding empty lines' '
+	test "$(first_context_line <changed_hello.diff)" != " "
+'
+
+test_expect_failure ' context does not include trailing empty lines' '
+	test "$(last_context_line <changed_hello.diff)" != " "
+'
+
+check_diff changed_includes 'changed includes'
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin.h" changed_includes.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^ .*End.h" changed_includes.diff
+'
+
+test_expect_success ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" changed_includes.diff) -le 1
+'
+
+test_expect_failure ' context does not include trailing empty lines' '
+	test "$(last_context_line <changed_includes.diff)" != " "
+'
+
+check_diff appended 'appended function'
+
+test_expect_success ' context includes begin' '
+	grep "^[+].*Begin of first part" appended.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^[+].*End of first part" appended.diff
+'
+
+test_expect_failure ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" appended.diff) -le 1
+'
+
+check_diff extended 'appended function part'
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin of first part" extended.diff
+'
+
+test_expect_success ' context includes end' '
+	grep "^[+].*End of second part" extended.diff
+'
+
+test_expect_failure ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" extended.diff) -le 2
+'
+
+test_expect_success ' context does not include preceding empty lines' '
+	test "$(first_context_line <extended.diff)" != " "
+'
+
+check_diff long_common_tail 'change with long common tail and no context' -U0
+
+test_expect_success ' context includes begin' '
+	grep "^ .*Begin of first part" long_common_tail.diff
+'
+
+test_expect_failure ' context includes end' '
+	grep "^ .*End of second part" long_common_tail.diff
+'
+
+test_expect_success ' context does not include other functions' '
+	test $(grep -c "^[ +-].*Begin" long_common_tail.diff) -le 2
+'
+
+test_expect_success ' context does not include preceding empty lines' '
+	test "$(first_context_line <long_common_tail.diff.diff)" != " "
 '
 
 test_done
diff --git a/t/t4051/appended1.c b/t/t4051/appended1.c
new file mode 100644
index 0000000..a9f56f1
--- /dev/null
+++ b/t/t4051/appended1.c
@@ -0,0 +1,15 @@
+
+int appended(void) // Begin of first part
+{
+	int i;
+	char *s = "a string";
+
+	printf("%s\n", s);
+
+	for (i = 99;
+	     i >= 0;
+	     i--) {
+		printf("%d bottles of beer on the wall\n", i);
+	}
+
+	printf("End of first part\n");
diff --git a/t/t4051/appended2.c b/t/t4051/appended2.c
new file mode 100644
index 0000000..e651f71
--- /dev/null
+++ b/t/t4051/appended2.c
@@ -0,0 +1,35 @@
+	printf("Begin of second part\n");
+
+	/*
+	 * Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
+	 * sed diam nonumy eirmod tempor invidunt ut labore et dolore
+	 * magna aliquyam erat, sed diam voluptua. At vero eos et
+	 * accusam et justo duo dolores et ea rebum. Stet clita kasd
+	 * gubergren, no sea takimata sanctus est Lorem ipsum dolor
+	 * sit amet.
+	 *
+	 * Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
+	 * sed diam nonumy eirmod tempor invidunt ut labore et dolore
+	 * magna aliquyam erat, sed diam voluptua. At vero eos et
+	 * accusam et justo duo dolores et ea rebum. Stet clita kasd
+	 * gubergren, no sea takimata sanctus est Lorem ipsum dolor
+	 * sit amet.
+	 *
+	 * Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
+	 * sed diam nonumy eirmod tempor invidunt ut labore et dolore
+	 * magna aliquyam erat, sed diam voluptua. At vero eos et
+	 * accusam et justo duo dolores et ea rebum. Stet clita kasd
+	 * gubergren, no sea takimata sanctus est Lorem ipsum dolor
+	 * sit amet.
+	 *
+	 * Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
+	 * sed diam nonumy eirmod tempor invidunt ut labore et dolore
+	 * magna aliquyam erat, sed diam voluptua. At vero eos et
+	 * accusam et justo duo dolores et ea rebum. Stet clita kasd
+	 * gubergren, no sea takimata sanctus est Lorem ipsum dolor
+	 * sit amet.
+	 *
+	 */
+
+	return 0;
+}	// End of second part
diff --git a/t/t4051/dummy.c b/t/t4051/dummy.c
new file mode 100644
index 0000000..a43016e
--- /dev/null
+++ b/t/t4051/dummy.c
@@ -0,0 +1,7 @@
+
+static int dummy(void)	// Begin of dummy
+{
+	int rc = 0;
+
+	return rc;
+}	// End of dummy
diff --git a/t/t4051/hello.c b/t/t4051/hello.c
new file mode 100644
index 0000000..63b1a1e
--- /dev/null
+++ b/t/t4051/hello.c
@@ -0,0 +1,21 @@
+
+static void hello(void)	// Begin of hello
+{
+	/*
+	 * Classic.
+	 */
+	putchar('H');
+	putchar('e');
+	putchar('l');
+	putchar('l');
+	putchar('o');
+	putchar(' ');
+	/* delete me from hello */
+	putchar('w');
+	putchar('o');
+	putchar('r');
+	putchar('l');
+	putchar('d');
+	putchar('.');
+	putchar('\n');
+}	// End of hello
diff --git a/t/t4051/includes.c b/t/t4051/includes.c
new file mode 100644
index 0000000..efc68f8
--- /dev/null
+++ b/t/t4051/includes.c
@@ -0,0 +1,20 @@
+#include <Begin.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdarg.h>
+/* delete me from includes */
+#include <string.h>
+#include <sys/types.h>
+#include <dirent.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <assert.h>
+#include <regex.h>
+#include <utime.h>
+#include <syslog.h>
+#include <End.h>
-- 
2.8.3
