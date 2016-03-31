From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v11 1/4] test-parse-options: print quiet as integer
Date: Thu, 31 Mar 2016 14:45:53 +0000
Message-ID: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 16:46:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldrE-0004ut-7v
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbcCaOp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:45:56 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:57720
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757136AbcCaOpz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 10:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459435553;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=ygSC0y5YAM+sHC9K9P5VY6JeLEqFZPEVWot5SGaddEs=;
	b=E/jAjQ7tTe+/2AsJfC5xmLLLexc95b6Cks5f4996jUNPYc3edcaCHAPfmYrCqqRt
	0I1KJoz55NzOO3kQ3S41psKYRoizEbBtcBcj6PNU9OuUr+EX0nQsPo8ozwJASo7o6Mj
	jMRv/NY7IkMo5tNViLgTQUPF20w5oJYjFkzEmklc=
In-Reply-To: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.31-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290394>

Current implementation of parse-options.c treats OPT__QUIET() as integer
and not boolean and thus it is more appropriate to print it as integer
to avoid confusion.

While at it, fix some style issues.
---
 t/t0040-parse-options.sh | 94 ++++++++++++++++++++++++------------------------
 test-parse-options.c     |  2 +-
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9be6411..2dcbdc0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect << EOF
+cat >expect <<EOF
 usage: test-parse-options <options>
 
     --yes                 get a boolean
@@ -49,7 +49,7 @@ Standard options
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	test_must_fail test-parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_i18ncmp expect output
 '
@@ -64,7 +64,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -156,7 +156,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
 	check magnitude: 3221225472 -m 3g
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -164,7 +164,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 2
-quiet: no
+quiet: 0
 dry run: yes
 file: prefix/my.file
 EOF
@@ -176,7 +176,7 @@ test_expect_success 'short options' '
 	test_must_be_empty output.err
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -184,7 +184,7 @@ timestamp: 0
 string: 321
 abbrev: 10
 verbose: 2
-quiet: no
+quiet: 0
 dry run: no
 file: prefix/fi.le
 EOF
@@ -204,7 +204,7 @@ test_expect_success 'missing required value' '
 	test_expect_code 129 test-parse-options --file
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 boolean: 1
 integer: 13
 magnitude: 0
@@ -212,7 +212,7 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: a1
@@ -222,12 +222,12 @@ EOF
 
 test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
-		> output 2> output.err &&
+		>output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 boolean: 0
 integer: 2
 magnitude: 0
@@ -235,19 +235,19 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo > output 2> output.err &&
+	test-parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --int=2 > output 2> output.err &&
+	test-parse-options --int=2 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -256,7 +256,7 @@ test_expect_success 'ambiguously abbreviated option' '
 	test_expect_code 129 test-parse-options --strin 123
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -264,38 +264,38 @@ timestamp: 0
 string: 123
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	test-parse-options --st 123 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > typo.err << EOF
+cat >typo.err <<EOF
 error: did you mean \`--boolean\` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
+	test_must_fail test-parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > typo.err << EOF
+cat >typo.err <<EOF
 error: did you mean \`--ambiguous\` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -ambiguous > output 2> output.err &&
+	test_must_fail test-parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -303,19 +303,19 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 arg 00: --quux
 EOF
 
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
+	test-parse-options --quux >output 2>output.err &&
 	test_must_be_empty output.err &&
-        test_cmp expect output
+	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -323,7 +323,7 @@ timestamp: 1
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: yes
+quiet: 1
 dry run: no
 file: (not set)
 arg 00: foo
@@ -331,12 +331,12 @@ EOF
 
 test_expect_success 'OPT_DATE() works' '
 	test-parse-options -t "1970-01-01 00:00:01 +0000" \
-		foo -q > output 2> output.err &&
+		foo -q >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
@@ -345,28 +345,28 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
+	test-parse-options --length=four -b -4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 Callback: "not set", 1
 EOF
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
 	test_i18ncmp expect.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 boolean: 1
 integer: 23
 magnitude: 0
@@ -374,24 +374,24 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 > output 2> output.err &&
+	test-parse-options --set23 -bbbbb --no-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --neg-or4 > output 2> output.err &&
+	test-parse-options --set23 -bbbbb --neg-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 boolean: 6
 integer: 0
 magnitude: 0
@@ -399,30 +399,30 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() works' '
-	test-parse-options -bb --or4 > output 2> output.err &&
+	test-parse-options -bb --or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options -bb --no-neg-or4 > output 2> output.err &&
+	test-parse-options -bb --no-neg-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
-	test-parse-options + + + + + + > output 2> output.err &&
+	test-parse-options + + + + + + >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<EOF
 boolean: 0
 integer: 12345
 magnitude: 0
@@ -430,13 +430,13 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 > output 2> output.err &&
+	test-parse-options -12345 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -449,7 +449,7 @@ timestamp: 0
 string: (not set)
 abbrev: 7
 verbose: 0
-quiet: no
+quiet: 0
 dry run: no
 file: (not set)
 EOF
@@ -460,7 +460,7 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test_cmp expect output
 '
 
-cat >>expect <<'EOF'
+cat >>expect <<EOF
 list: foo
 list: bar
 list: baz
diff --git a/test-parse-options.c b/test-parse-options.c
index 2c8c8f1..86afa98 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	printf("string: %s\n", string ? string : "(not set)");
 	printf("abbrev: %d\n", abbrev);
 	printf("verbose: %d\n", verbose);
-	printf("quiet: %s\n", quiet ? "yes" : "no");
+	printf("quiet: %d\n", quiet);
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
 

--
https://github.com/git/git/pull/218
