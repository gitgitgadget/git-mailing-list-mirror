Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B0720970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbdDHN0V (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35106 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752282AbdDHN0P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so2448635wmi.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIby005LzFiuzu35l7N3cNtaQqWDv2Op5ArpNqu+ciw=;
        b=tdtbWImY0WRGR1JBtpy47B6ImC6+Zf78ThXnqDXf976gQSN3ZG8DjhcAyggWieYMm5
         a6LLRB2mYMGn80flQYSJT68OKjNthebUGj2eURyUfjYdmUu6jLMj6KwBkv86gYwbo2Md
         gmw75/k+7Lwebr72PwX/znGFr9wDLuXI7s0+NIjz427g5jtO7kKse33D7+uugMvPsDYk
         D4hBQQaaViZIXPyYE1KFVHk2H/Ai6GLhvvGwhQ56TNlcnxRJCRZfe8CkoPsqENOrAbBQ
         yjNVQ+XRV6dtjrp+yQyxHTM8lVO/Sofbal0hWNcrNl6qmmz0yfAcYynGguArx9c3F4HE
         206A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIby005LzFiuzu35l7N3cNtaQqWDv2Op5ArpNqu+ciw=;
        b=Lah4OkoOByjNr7mRooYVi2p0frdm0JwVTVBMNpBolEDvqfTN6NFpRLm3afbx+LxGOK
         RVRQSW365H5ylKE8DUCMyA9aJIU1NasaOhF7T3upBcLEOIMesAyGnU49ikXhMzBhHsLW
         J5UmNzLzjABdzz2NgTO0VrcieTH9xOVRWKQ9q2sEBDGkuxxM6bY2jf50z8zgk4Q8EUPa
         ve8ALNVceBuQ1BNbo/lRWI4r9nBBjLdYBTbHWmMgmYaVY6RsEXtiFTrmsD+7V+MT0Hse
         RUrX7+hYn6uV38HSw8/HSa9Gz/0SnZq4OHQFOkClhLJD56hDX1Ls3/a7xP60ySOy397S
         BkIg==
X-Gm-Message-State: AN3rC/51A3Kb8FQyXa521vKC9PccSP1OE8s7GZhVt+ETt4LpqZyY4GXsIA3Merkz42nNaA==
X-Received: by 10.28.28.16 with SMTP id c16mr3577824wmc.38.1491657973418;
        Sat, 08 Apr 2017 06:26:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/12] test-lib: rename the LIBPCRE prerequisite to PCRE
Date:   Sat,  8 Apr 2017 13:25:03 +0000
Message-Id: <20170408132506.5415-10-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
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
 t/t7810-grep.sh                 | 30 +++++++++++++++---------------
 t/t7812-grep-icase-non-ascii.sh |  4 ++--
 t/t7813-grep-icase-iso.sh       |  2 +-
 t/test-lib.sh                   |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

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
index 6f7c74e027..936666bb8a 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -265,7 +265,7 @@ test_expect_success 'log -F -E --grep=<ere> uses ere' '
 	test_cmp expect actual
 '
 
-test_expect_success LIBPCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
+test_expect_success PCRE 'log -F -E --perl-regexp --grep=<pcre> uses PCRE' '
 	echo second >expect &&
 	git log -1 --pretty="tformat:%s" -F -E --perl-regexp --grep="s(?=ec)econd" >actual &&
 	test_cmp expect actual
@@ -303,7 +303,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(.|.)" >actual.basic &&
 		git -c grep.patternType=extended log --pretty=tformat:%s \
 			--grep="\|2" >actual.extended &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			git -c grep.patternType=perl log --pretty=tformat:%s \
 				--grep="\((?=1)" >actual.perl
@@ -311,7 +311,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 		test_cmp expect.fixed actual.fixed &&
 		test_cmp expect.basic actual.basic &&
 		test_cmp expect.extended actual.extended &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			test_cmp expect.perl actual.perl
 		fi &&
@@ -338,7 +338,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(.|.)" >actual.basic.long-arg &&
 		git log --pretty=tformat:%s --extended-regexp \
 			--grep="\|2" >actual.extended.long-arg &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			git log --pretty=tformat:%s --perl-regexp \
 				--grep="\((?=1)" >actual.perl.long-arg
@@ -346,7 +346,7 @@ test_expect_success 'log with various grep.patternType configurations & command-
 		test_cmp expect.fixed actual.fixed.long-arg &&
 		test_cmp expect.basic actual.basic.long-arg &&
 		test_cmp expect.extended actual.extended.long-arg &&
-		if test_have_prereq LIBPCRE
+		if test_have_prereq PCRE
 		then
 			test_cmp expect.perl actual.perl.long-arg
 		fi
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index b50f1dff43..46f528183d 100755
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
@@ -1522,7 +1522,7 @@ test_expect_success 'grep with thread options' '
 	test_must_fail git -c grep.threads=1 grep --threads=-1 st.*dio
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

