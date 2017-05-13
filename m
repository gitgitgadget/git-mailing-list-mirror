Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECF420188
	for <e@80x24.org>; Sat, 13 May 2017 23:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758281AbdEMXPv (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:51 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33711 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758139AbdEMXPs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id a46so11217934qte.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IirsIPm7nzB9R9XbUPwLNg45aP/ZddmN6/psVZIvAiE=;
        b=N7jaja2k+T/jT/p8z7dKzgK2KMmGFFQPVB5lA6JqZ+T/QydXOfiAMzNBj+WtBU6joY
         0oDHIwlrTxn4M6a7Djn6LpAZal1mwRWSix5gvxBK0ZnwWlDbc7wQHCoAvHIYdz4VF/56
         Jssy2PdcpixTcv2wS5GEciMlvyDxafeBIu4PPG/RHd76DbqtNg/5Spp+DwMO7e0ttXjz
         mE+624bkVH9Ljo/ctfxmMOlnTy/MxbkoTudT6YD7AtZs97oBa4qQ/3iFAVPIba1E6JZn
         ertu916AoX3DuMUkbR49v5tblHbXiLCC418SL0fjbjde4YptTfOKPPm2L9RBazAzi8Mt
         pKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IirsIPm7nzB9R9XbUPwLNg45aP/ZddmN6/psVZIvAiE=;
        b=Iv/4moW1i3JmVc5RXnyyMPZfEVcXCi20rKmJr0tFvUeTfQ2O1KuQMUq7SCwsI+p4X+
         OqIQnYALipv1ivqW5fZaWq9dqDdlNJeW2GX1Istz217pBlREpPs4Hyf4+tjDiPF36/jt
         89cDjqjJYXUbJi0/LyXHvcz3TSrWpEH9RyUccb3nmYQOH9TgkBr4s5Id9Vt+g6kzhLA5
         OmqvXLPWfGRQJpJ5Zh72yKL6WC+SQyhiZyaXbSauUKsjSEq28fT+o8O0ktpcbYtwmPTB
         4Kaz690yAnJh4P7emYz/zMTk96v/Zz+5AOC0pBe81xfgas9+1GHch389XI++yXD2ZFe9
         mswg==
X-Gm-Message-State: AODbwcD6DrIVP+09kbasKQft2PjFo5H0KDxfAQtpHI7Y1hPz1bulLu0C
        kYDOOlFIxJAfMQ==
X-Received: by 10.200.34.60 with SMTP id o57mr9831423qto.41.1494717342986;
        Sat, 13 May 2017 16:15:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:42 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/29] test-lib: rename the LIBPCRE prerequisite to PCRE
Date:   Sat, 13 May 2017 23:14:43 +0000
Message-Id: <20170513231509.7834-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
 t/t7810-grep.sh                 | 28 ++++++++++++++--------------
 t/t7812-grep-icase-non-ascii.sh |  4 ++--
 t/t7813-grep-icase-iso.sh       |  2 +-
 t/test-lib.sh                   |  2 +-
 5 files changed, 20 insertions(+), 20 deletions(-)

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
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cee42097b0..c84c4d99f9 100755
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
@@ -1118,11 +1118,11 @@ test_expect_success 'grep invalidpattern properly dies with grep.patternType=ext
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
 
@@ -1191,13 +1191,13 @@ test_expect_success 'grep pattern with grep.patternType=fixed, =basic, =perl, =e
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
@@ -1208,7 +1208,7 @@ test_expect_success LIBPCRE 'grep pattern with grep.patternType=fixed, =basic, =
 	test_cmp expected actual
 '
 
-test_expect_success LIBPCRE 'grep -P pattern with grep.patternType=fixed' '
+test_expect_success PCRE 'grep -P pattern with grep.patternType=fixed' '
 	echo "ab:a+b*c" >expected &&
 	git \
 		-c grep.patterntype=fixed \
@@ -1343,12 +1343,12 @@ space: line with leading space2
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

