Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6331F404
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbeIIW1G (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:06 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:44176 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIIW1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:06 -0400
Received: by mail-lj1-f173.google.com with SMTP id q127-v6so15928936ljq.11
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7ueFhAXEXx5fnWhpQP9jIrpsOgrOCcwrcKd+gLk878=;
        b=mIx9IwGmaQnOYCN6FaqzXeHOv9guCmqlTv+jpVa0VuyeNq+tIZ6zaqlVrawsRs/9R0
         gGhUvKWui05y0slFYBO3xSSogD5omX23H98ylspk6kGKeLSfW3SL9j7HC5hD031KqrDZ
         iRHKP54k4pjRBob12cTt8Iiu42qJGnxNkkMK9nbFGUeTBtJ/MgInJCeBnimoJrUUe8kY
         CCYzZ0CwepEhzLWkuvNfYachEWnBMdsG1nqvqnA1+Kpg7mOAt+DFLhjg7t0fu2LOtuFm
         uq1D3sXL23z6m6Jl+FZlLnv8CBcpt6poFhYGL/NEIO2R0CkGS9klDG7N1Lxw37snnVux
         qXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7ueFhAXEXx5fnWhpQP9jIrpsOgrOCcwrcKd+gLk878=;
        b=M5QsMRfQQJc38Knh3xGfKPdyFUtPZXYOv5h6lwyrAbKUOKB+lUS8ZGpky+asQhZAtB
         TIv7DJLOJt23uGIuDAQdptdf4g2SgJ6wfEyCvgKSYko4B92X9nqP0f0KtpIafliBRhuf
         l7wUm/gxD6rPHjOKDjoamHK6hXSNeXbyY6T64egVT5TYnIlqOTHqDrR2+tgKo4Rq7ZT1
         MZ6AaZ89lwwXm9+FcDB8zMrW8KJP+5LEEzqss+NqteLP/4eMuUki7WU232d31x2/JMiZ
         XFOmicI3cNFDpArg5TciuiC0y+WAyXrLT85B9mHK4MUkhJqxSUQcKlAn02KYnEX1ukzq
         frUw==
X-Gm-Message-State: APzg51BUCb/lhDc46Diu9AUHZ1fTg2BSP0v0+b6tYm+zRuU+BxxTvIq8
        peIIUm2LNZd1jNgw99A22tnq4TND
X-Google-Smtp-Source: ANB0VdYTvygWZfQaWlUHSUBy/qGkMoYJZNGCVW+cNdcQYxD7B4T2HBqqMPuCZC3CgygDyBSTWkQNlA==
X-Received: by 2002:a2e:4557:: with SMTP id s84-v6mr10035751lja.47.1536514601500;
        Sun, 09 Sep 2018 10:36:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] t/helper: merge test-parse-options into test-tool
Date:   Sun,  9 Sep 2018 19:36:29 +0200
Message-Id: <20180909173631.1446-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909173631.1446-1-pclouds@gmail.com>
References: <20180909173631.1446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                      |  2 +-
 t/helper/test-parse-options.c |  5 ++-
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0040-parse-options.sh      | 70 +++++++++++++++++------------------
 5 files changed, 41 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index d9a4029895..1a8a7cb82d 100644
--- a/Makefile
+++ b/Makefile
@@ -721,6 +721,7 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
+TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
@@ -745,7 +746,6 @@ TEST_BUILTINS_OBJS += test-write-cache.o
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
-TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-tool
 
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 630c76d127..9cb8a0ea0f 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -1,3 +1,4 @@
+#include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
@@ -94,11 +95,11 @@ static void show(struct string_list *expect, int *status, const char *fmt, ...)
 	strbuf_release(&buf);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd__parse_options(int argc, const char **argv)
 {
 	const char *prefix = "prefix/";
 	const char *usage[] = {
-		"test-parse-options <options>",
+		"test-tool parse-options <options>",
 		"",
 		"A helper function for the parse-options API.",
 		NULL
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0ef53152c4..9cc21024e9 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -26,6 +26,7 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "online-cpus", cmd__online_cpus },
+	{ "parse-options", cmd__parse_options },
 	{ "path-utils", cmd__path_utils },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 7a0ac22ef7..527722f4b0 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -22,6 +22,7 @@ int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
+int cmd__parse_options(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 5b0560fa20..17d0c18feb 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -8,7 +8,7 @@ test_description='our own option parser'
 . ./test-lib.sh
 
 cat >expect <<\EOF
-usage: test-parse-options <options>
+usage: test-tool parse-options <options>
 
     A helper function for the parse-options API.
 
@@ -52,7 +52,7 @@ Standard options
 EOF
 
 test_expect_success 'test help' '
-	test_must_fail test-parse-options -h >output 2>output.err &&
+	test_must_fail test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_i18ncmp expect output
 '
@@ -64,7 +64,7 @@ check () {
 	shift &&
 	expect="$1" &&
 	shift &&
-	test-parse-options --expect="$what $expect" "$@"
+	test-tool parse-options --expect="$what $expect" "$@"
 }
 
 check_unknown_i18n() {
@@ -75,7 +75,7 @@ check_unknown_i18n() {
 		echo error: unknown switch \`${1#-}\' >expect ;;
 	esac &&
 	cat expect.err >>expect &&
-	test_must_fail test-parse-options $* >output 2>output.err &&
+	test_must_fail test-tool parse-options $* >output 2>output.err &&
 	test_must_be_empty output &&
 	test_i18ncmp expect output.err
 }
@@ -133,7 +133,7 @@ file: prefix/my.file
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -m 16k -b -vv -n -F my.file \
+	test-tool parse-options -s123 -b -i 1729 -m 16k -b -vv -n -F my.file \
 	>output 2>output.err &&
 	test_cmp expect output &&
 	test_must_be_empty output.err
@@ -153,7 +153,7 @@ file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
-	test-parse-options --boolean --integer 1729 --magnitude 16k \
+	test-tool parse-options --boolean --integer 1729 --magnitude 16k \
 		--boolean --string2=321 --verbose --verbose --no-dry-run \
 		--abbrev=10 --file fi.le --obsolete \
 		>output 2>output.err &&
@@ -162,9 +162,9 @@ test_expect_success 'long options' '
 '
 
 test_expect_success 'missing required value' '
-	test_expect_code 129 test-parse-options -s &&
-	test_expect_code 129 test-parse-options --string &&
-	test_expect_code 129 test-parse-options --file
+	test_expect_code 129 test-tool parse-options -s &&
+	test_expect_code 129 test-tool parse-options --string &&
+	test_expect_code 129 test-tool parse-options --file
 '
 
 cat >expect <<\EOF
@@ -184,7 +184,7 @@ arg 02: --boolean
 EOF
 
 test_expect_success 'intermingled arguments' '
-	test-parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
+	test-tool parse-options a1 --string 123 b1 --boolean -j 13 -- --boolean \
 		>output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
@@ -204,21 +204,21 @@ file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
-	test-parse-options --int 2 --boolean --no-bo >output 2>output.err &&
+	test-tool parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
-	test-parse-options --expect="integer: 2" --int=2
+	test-tool parse-options --expect="integer: 2" --int=2
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test_expect_code 129 test-parse-options --strin 123
+	test_expect_code 129 test-tool parse-options --strin 123
 '
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
-	test-parse-options --expect="string: 123" --st 123
+	test-tool parse-options --expect="string: 123" --st 123
 '
 
 cat >typo.err <<\EOF
@@ -226,7 +226,7 @@ error: did you mean `--boolean` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -boolean >output 2>output.err &&
+	test_must_fail test-tool parse-options -boolean >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
@@ -236,13 +236,13 @@ error: did you mean `--ambiguous` (with two dashes ?)
 EOF
 
 test_expect_success 'detect possible typos' '
-	test_must_fail test-parse-options -ambiguous >output 2>output.err &&
+	test_must_fail test-tool parse-options -ambiguous >output 2>output.err &&
 	test_must_be_empty output &&
 	test_cmp typo.err output.err
 '
 
 test_expect_success 'keep some options as arguments' '
-	test-parse-options --expect="arg 00: --quux" --quux
+	test-tool parse-options --expect="arg 00: --quux" --quux
 '
 
 cat >expect <<\EOF
@@ -260,7 +260,7 @@ arg 00: foo
 EOF
 
 test_expect_success 'OPT_DATE() works' '
-	test-parse-options -t "1970-01-01 00:00:01 +0000" \
+	test-tool parse-options -t "1970-01-01 00:00:01 +0000" \
 		foo -q >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
@@ -281,13 +281,13 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
-	test-parse-options --length=four -b -4 >output 2>output.err &&
+	test-tool parse-options --length=four -b -4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
-	test_must_fail test-parse-options --no-length >output 2>output.err &&
+	test_must_fail test-tool parse-options --no-length >output 2>output.err &&
 	test_must_be_empty output &&
 	test_must_be_empty output.err
 '
@@ -306,31 +306,31 @@ file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --no-or4 >output 2>output.err &&
+	test-tool parse-options --set23 -bbbbb --no-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
-	test-parse-options --set23 -bbbbb --neg-or4 >output 2>output.err &&
+	test-tool parse-options --set23 -bbbbb --neg-or4 >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'OPT_BIT() works' '
-	test-parse-options --expect="boolean: 6" -bb --or4
+	test-tool parse-options --expect="boolean: 6" -bb --or4
 '
 
 test_expect_success 'OPT_NEGBIT() works' '
-	test-parse-options --expect="boolean: 6" -bb --no-neg-or4
+	test-tool parse-options --expect="boolean: 6" -bb --no-neg-or4
 '
 
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
-	test-parse-options --expect="boolean: 6" + + + + + +
+	test-tool parse-options --expect="boolean: 6" + + + + + +
 '
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
-	test-parse-options --expect="integer: 12345" -12345
+	test-tool parse-options --expect="integer: 12345" -12345
 '
 
 cat >expect <<\EOF
@@ -347,7 +347,7 @@ file: (not set)
 EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
-	test-parse-options --no-ambig >output 2>output.err &&
+	test-tool parse-options --no-ambig >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
@@ -358,38 +358,38 @@ list: bar
 list: baz
 EOF
 test_expect_success '--list keeps list of strings' '
-	test-parse-options --list foo --list=bar --list=baz >output &&
+	test-tool parse-options --list foo --list=bar --list=baz >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--no-list resets list' '
-	test-parse-options --list=other --list=irrelevant --list=options \
+	test-tool parse-options --list=other --list=irrelevant --list=options \
 		--no-list --list=foo --list=bar --list=baz >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'multiple quiet levels' '
-	test-parse-options --expect="quiet: 3" -q -q -q
+	test-tool parse-options --expect="quiet: 3" -q -q -q
 '
 
 test_expect_success 'multiple verbose levels' '
-	test-parse-options --expect="verbose: 3" -v -v -v
+	test-tool parse-options --expect="verbose: 3" -v -v -v
 '
 
 test_expect_success '--no-quiet sets --quiet to 0' '
-	test-parse-options --expect="quiet: 0" --no-quiet
+	test-tool parse-options --expect="quiet: 0" --no-quiet
 '
 
 test_expect_success '--no-quiet resets multiple -q to 0' '
-	test-parse-options --expect="quiet: 0" -q -q -q --no-quiet
+	test-tool parse-options --expect="quiet: 0" -q -q -q --no-quiet
 '
 
 test_expect_success '--no-verbose sets verbose to 0' '
-	test-parse-options --expect="verbose: 0" --no-verbose
+	test-tool parse-options --expect="verbose: 0" --no-verbose
 '
 
 test_expect_success '--no-verbose resets multiple verbose to 0' '
-	test-parse-options --expect="verbose: 0" -v -v -v --no-verbose
+	test-tool parse-options --expect="verbose: 0" -v -v -v --no-verbose
 '
 
 test_done
-- 
2.19.0.rc0.337.ge906d732e7

