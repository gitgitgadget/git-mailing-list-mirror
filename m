Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AA3207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031504AbdDTVZB (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:25:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33365 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947828AbdDTVY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id o81so987886wmb.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6yB9XuE7JA0P3QxAbetz19PNWIJpb4NGTFubKSLpvY=;
        b=gWYQ6dFyOSicZSa75o7244UR++436VNVU2Gvkn0QU80g36TXnOXZtsz1I+J7BEshmr
         wy++TEPKXcbMPCPHm53sBNQ45ornLfusdWQfWTeg6R2Xte0Khx56u6BN4Zgcsi5ilfYN
         8obEVaiuJ+qaRc5O7ZhD+WljHFOVxe412eUXo4AfXekddF10z5yQSeaJPvBSMeOsUmDj
         CfzxTw1fAvkPC6u0nqgw4hBk62OMss687U/F6koGRU1hTurYUpgCcQg7LxpXRYI95Qtc
         RJL5aFKJ8feTSomM01UMsftzsf02bBqYpswL6hqSekjcOrOSz7TfaPtj9KZYwaAhvrTj
         lKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6yB9XuE7JA0P3QxAbetz19PNWIJpb4NGTFubKSLpvY=;
        b=IpE/6UxPbwNWf4hwIGjzHxS9UyQlWMy5HdYOc9hE02JA4l7XFAbOSfrmWFl94iD7QS
         gzUZPsdrfkrZ7EMd+BFkIbC3ORqu9aD41AQX32TwPg46jhg1bF7rWvKWSXBS/GnFDk/Z
         NDHlCDhgDPVfGYGSmjV8f9vW0Rzx5fgwGtuuy/+gyKeleVq3FZiZsQY/+88KVbD7VDlg
         QWYe3bYNJ5oG/MRi4d3QvCWHQc18zcy6xWdx13VS5E5SEB6Wn9T8ILfbWTxxPgn+KZKf
         xsfQFUQ+s2EMda7g8Arr38XQmqEIkiFVPB0rnyEfzYWV6rsaq53jgaUGMhrB1WL3+tcq
         FpUA==
X-Gm-Message-State: AN3rC/5UZiOHEYQphZWQkZ2Ce7GSSVQxdtFA/fFSclNif1F07AgACgYR
        JzSag6J1Lhg5Nw==
X-Received: by 10.28.207.136 with SMTP id f130mr5208757wmg.51.1492723491398;
        Thu, 20 Apr 2017 14:24:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/18] test-lib: rename the LIBPCRE prerequisite to PCRE
Date:   Thu, 20 Apr 2017 21:23:38 +0000
Message-Id: <20170420212345.7408-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the LIBPCRE prerequisite to PCRE. This is for preparation for
libpcre2 support, where having just "LIBPCRE" would be confusing as it
implies v1 of the library.

None of these tests are incompatible between versions 1 & 2 of
libpcre, it's less confusing to give them a more general name to make
it clear that they work on both library versions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README                        |  4 ++--
 t/t4202-log.sh                  | 10 +++++-----
 t/t7810-grep.sh                 | 32 ++++++++++++++++----------------
 t/t7812-grep-icase-non-ascii.sh |  4 ++--
 t/t7813-grep-icase-iso.sh       |  2 +-
 t/test-lib.sh                   |  2 +-
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/t/README b/t/README
index ab386c3681..a90cb62583 100644
--- a/t/README
+++ b/t/README
@@ -803,9 +803,9 @@ use these, and "test_set_prereq" for how to define your own.
    Test is not run by root user, and an attempt to write to an
    unwritable file is expected to fail correctly.
 
- - LIBPCRE
+ - PCRE
 
-   Git was compiled with USE_LIBPCRE=YesPlease. Wrap any tests
+   Git was compiled with support for PCRE. Wrap any tests
    that use git-grep --perl-regexp or git-grep -P in these.
 
  - CASE_INSENSITIVE_FS
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 06acc848b8..0b5f808ca3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -266,7 +266,7 @@ test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	test_cmp expect actual
 '
 
-test_expect_success LIBPCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
+test_expect_success PCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
 	test_when_finished "rm -rf num_commits" &&
 	git init num_commits &&
 	(
@@ -314,7 +314,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(.|.)" >actual.basic &&
 		git -c grep.patternType=extended log --pretty=tformat:%s \
 			--grep="\|2" >actual.extended &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			git -c grep.patternType=perl log --pretty=tformat:%s \
 				--grep="[\d]\|" >actual.perl
@@ -322,7 +322,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 		test_cmp expect.fixed actual.fixed &&
 		test_cmp expect.basic actual.basic &&
 		test_cmp expect.extended actual.extended &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			test_cmp expect.perl actual.perl
 		fi &&
@@ -349,7 +349,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(.|.)" >actual.basic.long-arg &&
 		git log --pretty=tformat:%s --extended-regexp \
 			--grep="\|2" >actual.extended.long-arg &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			git log --pretty=tformat:%s --perl-regexp \
 				--grep="[\d]\|" >actual.perl.long-arg
@@ -357,7 +357,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 		test_cmp expect.fixed actual.fixed.long-arg &&
 		test_cmp expect.basic actual.basic.long-arg &&
 		test_cmp expect.extended actual.extended.long-arg &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			test_cmp expect.perl actual.perl.long-arg
 		fi
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7199356d35..f929b447e9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -275,7 +275,7 @@ do
 		test_cmp expected actual
 	'
 
-	test_expect_success LIBPCRE "grep $L with grep.patterntype=perl" '
+	test_expect_success PCRE "grep $L with grep.patterntype=perl" '
 		echo "${HC}ab:a+b*c" >expected &&
 		git -c grep.patterntype=perl grep "a\x{2b}b\x{2a}c" $H ab >actual &&
 		test_cmp expected actual
@@ -1053,12 +1053,12 @@ hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
 EOF
 
-test_expect_success LIBPCRE 'grep --perl-regexp pattern' '
+test_expect_success PCRE 'grep --perl-regexp pattern' '
 	git grep --perl-regexp "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P pattern' '
+test_expect_success PCRE 'grep -P pattern' '
 	git grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '
@@ -1070,13 +1070,13 @@ test_expect_success 'grep pattern with grep.extendedRegexp=true' '
 	test_cmp empty actual
 '
 
-test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=true' '
+test_expect_success PCRE 'grep -P pattern with grep.extendedRegexp=true' '
 	git -c grep.extendedregexp=true \
 		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P -v pattern' '
+test_expect_success PCRE 'grep -P -v pattern' '
 	{
 		echo "ab:a+b*c"
 		echo "ab:a+bc"
@@ -1085,7 +1085,7 @@ test_expect_success LIBPCRE 'grep -P -v pattern' '
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P -i pattern' '
+test_expect_success PCRE 'grep -P -i pattern' '
 	cat >expected <<-EOF &&
 	hello.c:	printf("Hello world.\n");
 	EOF
@@ -1093,7 +1093,7 @@ test_expect_success LIBPCRE 'grep -P -i pattern' '
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P -w pattern' '
+test_expect_success PCRE 'grep -P -w pattern' '
 	{
 		echo "hello_world:Hello world"
 		echo "hello_world:HeLLo world"
@@ -1102,7 +1102,7 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE flag is not set)' '
+test_expect_success PCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE flag is not set)' '
 	git grep -P -h "(?P<one>.)(?P=one)" hello_world >actual &&
 	test_cmp hello_world actual &&
 	git grep -P -h "(.)\1" hello_world >actual &&
@@ -1125,11 +1125,11 @@ test_expect_success 'grep invalidpattern properly dies with grep.patternType=ext
 	test_must_fail git -c grep.patterntype=extended grep "a["
 '
 
-test_expect_success LIBPCRE 'grep -P invalidpattern properly dies ' '
+test_expect_success PCRE 'grep -P invalidpattern properly dies ' '
 	test_must_fail git grep -P "a["
 '
 
-test_expect_success LIBPCRE 'grep invalidpattern properly dies with grep.patternType=perl' '
+test_expect_success PCRE 'grep invalidpattern properly dies with grep.patternType=perl' '
 	test_must_fail git -c grep.patterntype=perl grep "a["
 '
 
@@ -1198,13 +1198,13 @@ test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =perl, =e
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
+test_expect_success PCRE 'grep -G -F -E -P pattern' '
 	echo "d0:0" >expected &&
 	git grep -G -F -E -P "[\d]" d0 >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =extended, =perl' '
+test_expect_success PCRE 'grep pattern with grep.patternType=fixed, =basic, =extended, =perl' '
 	echo "d0:0" >expected &&
 	git \
 		-c grep.patterntype=fixed \
@@ -1215,7 +1215,7 @@ test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed' '
+test_expect_success PCRE 'grep -P pattern with grep.patternType=fixed' '
 	echo "ab:a+b*c" >expected &&
 	git \
 		-c grep.patterntype=fixed \
@@ -1350,12 +1350,12 @@ space: line with leading space2
 space: line with leading space3
 EOF
 
-test_expect_success LIBPCRE 'grep -E "^ "' '
+test_expect_success PCRE 'grep -E "^ "' '
 	git grep -E "^ " space >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P "^ "' '
+test_expect_success PCRE 'grep -P "^ "' '
 	git grep -P "^ " space >actual &&
 	test_cmp expected actual
 '
@@ -1512,7 +1512,7 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE "grep with grep.patternType synonyms perl/pcre/pcre1" '
+test_expect_success PCRE "grep with grep.patternType synonyms perl/pcre/pcre1" '
 	echo "#include <stdio.h>" >expected &&
 	git -c grep.patternType=perl  grep -h --no-line-number "st(?=dio)" >actual &&
 	test_cmp expected actual &&
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 169fd8d706..04a61cb8e0 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -20,13 +20,13 @@ test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: HALLÓ HEIMUR!"
 '
 
-test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 icase' '
+test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre utf-8 icase' '
 	git grep --perl-regexp    "TILRAUN: H.lló Heimur!" &&
 	git grep --perl-regexp -i "TILRAUN: H.lló Heimur!" &&
 	git grep --perl-regexp -i "TILRAUN: H.LLÓ HEIMUR!"
 '
 
-test_expect_success GETTEXT_LOCALE,LIBPCRE 'grep pcre utf-8 string with "+"' '
+test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre utf-8 string with "+"' '
 	test_write_lines "TILRAUN: Hallóó Heimur!" >file2 &&
 	git add file2 &&
 	git grep -l --perl-regexp "TILRAUN: H.lló+ Heimur!" >actual &&
diff --git a/t/t7813-grep-icase-iso.sh b/t/t7813-grep-icase-iso.sh
index efef7fb81f..701e08a8e5 100755
--- a/t/t7813-grep-icase-iso.sh
+++ b/t/t7813-grep-icase-iso.sh
@@ -11,7 +11,7 @@ test_expect_success GETTEXT_ISO_LOCALE 'setup' '
 	export LC_ALL
 '
 
-test_expect_success GETTEXT_ISO_LOCALE,LIBPCRE 'grep pcre string' '
+test_expect_success GETTEXT_ISO_LOCALE,PCRE 'grep pcre string' '
 	git grep --perl-regexp -i "TILRAUN: H.ll� Heimur!" &&
 	git grep --perl-regexp -i "TILRAUN: H.LL� HEIMUR!"
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 13b5696822..6abf1d1918 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1010,7 +1010,7 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
+test -n "$USE_LIBPCRE" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

