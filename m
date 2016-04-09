From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v13 1/6] t0040-test-parse-options.sh: fix style issues
Date: Sat, 9 Apr 2016 12:23:20 +0000
Message-ID: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 14:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aorvJ-0004iC-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 14:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbcDIMXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 08:23:24 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:42931
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751932AbcDIMXW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2016 08:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460204600;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=PZ4O0b5o5fh4EDb9BKLlD1+IUIg0mRb9ZORiA8im8jc=;
	b=B/lEZ/Y4R2j5vXFMlxDQ5xaxhwwHzfowoHToLFiWttsVR9sKEc1ZgfTItyowCex9
	KQe9H4yN+ujBq6sTZmxtfvv5Vb6Y0XyVLYRlO6TEnyY3UprWbBHEWTPkAf/rCiNSwwe
	FMigQvvDUyZi4rluQhbaySYhly5Tbbd4/8pGT7XM=
In-Reply-To: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291091>

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Changes wrt previous version (v12):
 - Use '\' when interpolation isn't required
---
 t/t0040-parse-options.sh | 76 ++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 9be6411..477fcff 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat > expect << EOF
+cat >expect <<\EOF
 usage: test-parse-options <options>
 
     --yes                 get a boolean
@@ -49,14 +49,14 @@ Standard options
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h > output 2> output.err &&
+	test_must_fail test-parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_i18ncmp expect output
 '
 
 mv expect expect.err
 
-cat >expect.template <<EOF
+cat >expect.template <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -156,7 +156,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
 	check magnitude: 3221225472 -m 3g
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -176,7 +176,7 @@ test_expect_success 'short options' '
 	test_must_be_empty output.err
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 2
 integer: 1729
 magnitude: 16384
@@ -204,7 +204,7 @@ test_expect_success 'missing required value' '
 	test_expect_code 129 test-parse-options --file
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 1
 integer: 13
 magnitude: 0
@@ -222,12 +222,12 @@ EOF
 
 test_expect_success 'intermingled arguments' '
 	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
-		> output 2> output.err &&
+		>output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 2
 magnitude: 0
@@ -241,13 +241,13 @@ file: (not set)
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
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -270,32 +270,32 @@ file: (not set)
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --st 123 > output 2> output.err &&
+	test-parse-options --st 123 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > typo.err << EOF
-error: did you mean \`--boolean\` (with two dashes ?)
+cat >typo.err <<\EOF
+error: did you mean `--boolean` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean > output 2> output.err &&
+	test_must_fail test-parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > typo.err << EOF
-error: did you mean \`--ambiguous\` (with two dashes ?)
+cat >typo.err <<\EOF
+error: did you mean `--ambiguous` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -ambiguous > output 2> output.err &&
+	test_must_fail test-parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -310,12 +310,12 @@ arg 00: --quux
 EOF
 
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --quux > output 2> output.err &&
+	test-parse-options --quux >output 2>output.err &&
 	test_must_be_empty output.err &&
-        test_cmp expect output
+	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -331,12 +331,12 @@ EOF
 
 test_expect_success 'OPT_DATE() works' '
 	test-parse-options -t "1970-01-01 00:00:01 +0000" \
-		foo -q > output 2> output.err &&
+		foo -q >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
 integer: 4
@@ -351,22 +351,22 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 > output 2> output.err &&
+	test-parse-options --length=four -b -4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 Callback: "not set", 1
 EOF
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length > output 2> output.err &&
+	test_must_fail test-parse-options --no-length >output 2>output.err &&
 	test_i18ncmp expect output &&
 	test_i18ncmp expect.err output.err
 '
 
-cat > expect <<EOF
+cat >expect <<\EOF
 boolean: 1
 integer: 23
 magnitude: 0
@@ -380,18 +380,18 @@ file: (not set)
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
+cat >expect <<\EOF
 boolean: 6
 integer: 0
 magnitude: 0
@@ -405,24 +405,24 @@ file: (not set)
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
+cat >expect <<\EOF
 boolean: 0
 integer: 12345
 magnitude: 0
@@ -436,12 +436,12 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options -12345 > output 2> output.err &&
+	test-parse-options -12345 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
+cat >expect <<\EOF
 boolean: 0
 integer: 0
 magnitude: 0
@@ -460,7 +460,7 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test_cmp expect output
 '
 
-cat >>expect <<'EOF'
+cat >>expect <<\EOF
 list: foo
 list: bar
 list: baz

--
https://github.com/git/git/pull/218
