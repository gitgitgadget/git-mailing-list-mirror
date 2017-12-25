Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94921F424
	for <e@80x24.org>; Mon, 25 Dec 2017 00:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdLYA3P (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Dec 2017 19:29:15 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:44743 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdLYA3G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Dec 2017 19:29:06 -0500
Received: by mail-wm0-f45.google.com with SMTP id t8so30331524wmc.3
        for <git@vger.kernel.org>; Sun, 24 Dec 2017 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EROvuluCFtLnhi4f0c/v278KOdfJ9cvQRBxolMDKYdk=;
        b=QV1IeHhGJKIxeLDGIKjVP+ldnt1GPVWNNaZX1zIFQJJJCARaBECRig//fKQiRstSVn
         pQMHr98PL6MV4BHLnMYe9Fkdlx9iuHjH+7OLFhEhsgCHKIylxZPWWpg/kT4oOGPV6s9l
         KGZh7zkeBG1lJnTfxiCzJBdWjRK5+uxLfhixsHI9I50q9bLvlVt7xUlIgpz332n/rVHb
         2E7B1PwuYaocSKBP5AHSug1t90EGM5x+ZC5iD59na7t7W4yNbQhV7K45xkeD66nQHSri
         xqRmZomCxKiZjxLcA6UAElDRZBKeCZGYHWgadj6neqwI0/cX9LAtdABzB5JEZvxU7i3a
         dTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EROvuluCFtLnhi4f0c/v278KOdfJ9cvQRBxolMDKYdk=;
        b=BIc54QMoVpDE+s+/Q+oNcMRsPjaTeuz7PPCehmkrfh540F5fH5dIn+BnyUurhXsiJo
         fpm3mvqgVxaKW+LAORsTG3aySjUe9kgwixhc7DsTQBmK3r4fQ/b5MLWowBxFLAHY3i1N
         QKE8y41r3VI7KOfRSuey8AzVzRuyINV59XZKAuDBirQNNyIHMWQfYP6zsGpTPVQHrwCL
         KpngEdoM5z9qUGAeaV5CqtgREKLTwPDRLgww806/GJ3yL2eERKAQUM3Kusagq0KK+S7V
         HUruFffMRR3UYbWe1DM5L181vD20VkeQ4HwrwSJgbeBnrF3Dr+CMUZBhjR1y2auk0DJO
         tAeA==
X-Gm-Message-State: AKGB3mJIZumTPgaGsdoZKMJ0FdGVHHcOy73f2SQKVlWAmtK3s6KUJNoy
        SrjXbosRbMgUTR5A5LHjxB8yH3O5
X-Google-Smtp-Source: ACJfBotKBbbdxRMQdiGkgWrFLGXS2r2zZWjjiqaHnaFkzQzHL+J9BZ8cbDqhhCPxTJCf8OyJhQkKtw==
X-Received: by 10.28.151.7 with SMTP id z7mr18500329wmd.5.1514161744200;
        Sun, 24 Dec 2017 16:29:04 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i65sm52923574wme.20.2017.12.24.16.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Dec 2017 16:29:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] wildmatch test: perform all tests under all wildmatch() modes
Date:   Mon, 25 Dec 2017 00:28:34 +0000
Message-Id: <20171225002835.29005-7-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
In-Reply-To: <20171223213012.1962-1-avarab@gmail.com>
References: <20171223213012.1962-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rewrite the wildmatch() test suite so that each test now tests all
combinations of the wildmatch() WM_CASEFOLD and WM_PATHNAME flags.

Before this change some test inputs were not tested on
e.g. WM_PATHNAME. Now the function is stress tested on all possible
inputs, and for each input we declare what the result should be if the
mode is case-insensitive, or pathname matching, or case-sensitive or
not matching pathnames.

Also before this change, nothing was testing case-insensitive
non-pathname matching, so I've added that to test-wildmatch.c and made
use of it.

This yields a rather scary patch, but there are no functional changes
here, just more test coverage. Some now-redundant tests were deleted
as a result of this change, since they were now duplicating an earlier
test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-wildmatch.c |   2 +
 t/t3070-wildmatch.sh      | 478 +++++++++++++++++++++++-----------------------
 2 files changed, 239 insertions(+), 241 deletions(-)

diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 921d7b3e7e..66d33dfcfd 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -16,6 +16,8 @@ int cmd_main(int argc, const char **argv)
 		return !!wildmatch(argv[3], argv[2], WM_PATHNAME | WM_CASEFOLD);
 	else if (!strcmp(argv[1], "pathmatch"))
 		return !!wildmatch(argv[3], argv[2], 0);
+	else if (!strcmp(argv[1], "ipathmatch"))
+		return !!wildmatch(argv[3], argv[2], WM_CASEFOLD);
 	else
 		return 1;
 }
diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 2f8a681c72..593b25b278 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -4,278 +4,274 @@ test_description='wildmatch tests'
 
 . ./test-lib.sh
 
-match() {
-	if test "$1" = 1
+wildtest() {
+	match_w_glob=$1
+	match_w_globi=$2
+	match_w_pathmatch=$3
+	match_w_pathmatchi=$4
+	text=$5
+	pattern=$6
+
+	if test "$match_w_glob" = 1
 	then
-		test_expect_success "wildmatch: match '$2' '$3'" "
-			test-wildmatch wildmatch '$2' '$3'
+		test_expect_success "wildmatch: match '$text' '$pattern'" "
+			test-wildmatch wildmatch '$text' '$pattern'
 		"
-	elif test "$1" = 0
+	elif test "$match_w_glob" = 0
 	then
-		test_expect_success "wildmatch: no match '$2' '$3'" "
-			! test-wildmatch wildmatch '$2' '$3'
+		test_expect_success "wildmatch: no match '$text' '$pattern'" "
+			! test-wildmatch wildmatch '$text' '$pattern'
 		"
 	else
-		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_glob" 'false'
 	fi
-}
 
-imatch() {
-	if test "$1" = 1
+	if test "$match_w_globi" = 1
 	then
-		test_expect_success "iwildmatch: match '$2' '$3'" "
-			test-wildmatch iwildmatch '$2' '$3'
+		test_expect_success "iwildmatch: match '$text' '$pattern'" "
+			test-wildmatch iwildmatch '$text' '$pattern'
 		"
-	elif test "$1" = 0
+	elif test "$match_w_globi" = 0
 	then
-		test_expect_success "iwildmatch: no match '$2' '$3'" "
-			! test-wildmatch iwildmatch '$2' '$3'
+		test_expect_success "iwildmatch: no match '$text' '$pattern'" "
+			! test-wildmatch iwildmatch '$text' '$pattern'
 		"
 	else
-		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_globi" 'false'
 	fi
-}
 
-pathmatch() {
-	if test "$1" = 1
+	if test "$match_w_pathmatch" = 1
 	then
-		test_expect_success "pathmatch: match '$2' '$3'" "
-			test-wildmatch pathmatch '$2' '$3'
+		test_expect_success "pathmatch: match '$text' '$pattern'" "
+			test-wildmatch pathmatch '$text' '$pattern'
 		"
-	elif test "$1" = 0
+	elif test "$match_w_pathmatch" = 0
 	then
-		test_expect_success "pathmatch: no match '$2' '$3'" "
-			! test-wildmatch pathmatch '$2' '$3'
+		test_expect_success "pathmatch: no match '$text' '$pattern'" "
+			! test-wildmatch pathmatch '$text' '$pattern'
 		"
 	else
-		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_pathmatch" 'false'
+	fi
+
+	if test "$match_w_pathmatchi" = 1
+	then
+		test_expect_success "ipathmatch:    match '$text' '$pattern'" "
+			test-wildmatch ipathmatch '$text' '$pattern'
+		"
+	elif test "$match_w_pathmatchi" = 0
+	then
+		test_expect_success "ipathmatch: no match '$text' '$pattern'" "
+			! test-wildmatch ipathmatch '$text' '$pattern'
+		"
+	else
+		test_expect_success "PANIC: Test framework error. Unknown matches value $match_w_pathmatchi" 'false'
 	fi
 }
 
-# Basic wildmat features
-match 1 foo foo
-match 0 foo bar
-match 1 '' ""
-match 1 foo '???'
-match 0 foo '??'
-match 1 foo '*'
-match 1 foo 'f*'
-match 0 foo '*f'
-match 1 foo '*foo*'
-match 1 foobar '*ob*a*r*'
-match 1 aaaaaaabababab '*ab'
-match 1 'foo*' 'foo\*'
-match 0 foobar 'foo\*bar'
-match 1 'f\oo' 'f\\oo'
-match 1 ball '*[al]?'
-match 0 ten '[ten]'
-match 0 ten '**[!te]'
-match 0 ten '**[!ten]'
-match 1 ten 't[a-g]n'
-match 0 ten 't[!a-g]n'
-match 1 ton 't[!a-g]n'
-match 1 ton 't[^a-g]n'
-match 1 'a]b' 'a[]]b'
-match 1 a-b 'a[]-]b'
-match 1 'a]b' 'a[]-]b'
-match 0 aab 'a[]-]b'
-match 1 aab 'a[]a-]b'
-match 1 ']' ']'
+# Basic wildmatch features
+wildtest 1 1 1 1 foo foo
+wildtest 0 0 0 0 foo bar
+wildtest 1 1 1 1 '' ""
+wildtest 1 1 1 1 foo '???'
+wildtest 0 0 0 0 foo '??'
+wildtest 1 1 1 1 foo '*'
+wildtest 1 1 1 1 foo 'f*'
+wildtest 0 0 0 0 foo '*f'
+wildtest 1 1 1 1 foo '*foo*'
+wildtest 1 1 1 1 foobar '*ob*a*r*'
+wildtest 1 1 1 1 aaaaaaabababab '*ab'
+wildtest 1 1 1 1 'foo*' 'foo\*'
+wildtest 0 0 0 0 foobar 'foo\*bar'
+wildtest 1 1 1 1 'f\oo' 'f\\oo'
+wildtest 1 1 1 1 ball '*[al]?'
+wildtest 0 0 0 0 ten '[ten]'
+wildtest 0 0 1 1 ten '**[!te]'
+wildtest 0 0 0 0 ten '**[!ten]'
+wildtest 1 1 1 1 ten 't[a-g]n'
+wildtest 0 0 0 0 ten 't[!a-g]n'
+wildtest 1 1 1 1 ton 't[!a-g]n'
+wildtest 1 1 1 1 ton 't[^a-g]n'
+wildtest 1 1 1 1 'a]b' 'a[]]b'
+wildtest 1 1 1 1 a-b 'a[]-]b'
+wildtest 1 1 1 1 'a]b' 'a[]-]b'
+wildtest 0 0 0 0 aab 'a[]-]b'
+wildtest 1 1 1 1 aab 'a[]a-]b'
+wildtest 1 1 1 1 ']' ']'
 
 # Extended slash-matching features
-match 0 'foo/baz/bar' 'foo*bar'
-match 0 'foo/baz/bar' 'foo**bar'
-match 0 'foobazbar' 'foo**bar'
-match 1 'foo/baz/bar' 'foo/**/bar'
-match 1 'foo/baz/bar' 'foo/**/**/bar'
-match 1 'foo/b/a/z/bar' 'foo/**/bar'
-match 1 'foo/b/a/z/bar' 'foo/**/**/bar'
-match 1 'foo/bar' 'foo/**/bar'
-match 1 'foo/bar' 'foo/**/**/bar'
-match 0 'foo/bar' 'foo?bar'
-match 0 'foo/bar' 'foo[/]bar'
-match 0 'foo/bar' 'foo[^a-z]bar'
-match 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
-match 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
-match 1 'foo' '**/foo'
-match 1 'XXX/foo' '**/foo'
-match 1 'bar/baz/foo' '**/foo'
-match 0 'bar/baz/foo' '*/foo'
-match 0 'foo/bar/baz' '**/bar*'
-match 1 'deep/foo/bar/baz' '**/bar/*'
-match 0 'deep/foo/bar/baz/' '**/bar/*'
-match 1 'deep/foo/bar/baz/' '**/bar/**'
-match 0 'deep/foo/bar' '**/bar/*'
-match 1 'deep/foo/bar/' '**/bar/**'
-match 0 'foo/bar/baz' '**/bar**'
-match 1 'foo/bar/baz/x' '*/bar/**'
-match 0 'deep/foo/bar/baz/x' '*/bar/**'
-match 1 'deep/foo/bar/baz/x' '**/bar/*/*'
+wildtest 0 0 1 1 'foo/baz/bar' 'foo*bar'
+wildtest 0 0 1 1 'foo/baz/bar' 'foo**bar'
+wildtest 0 0 1 1 'foobazbar' 'foo**bar'
+wildtest 1 1 1 1 'foo/baz/bar' 'foo/**/bar'
+wildtest 1 1 0 0 'foo/baz/bar' 'foo/**/**/bar'
+wildtest 1 1 1 1 'foo/b/a/z/bar' 'foo/**/bar'
+wildtest 1 1 1 1 'foo/b/a/z/bar' 'foo/**/**/bar'
+wildtest 1 1 0 0 'foo/bar' 'foo/**/bar'
+wildtest 1 1 0 0 'foo/bar' 'foo/**/**/bar'
+wildtest 0 0 1 1 'foo/bar' 'foo?bar'
+wildtest 0 0 1 1 'foo/bar' 'foo[/]bar'
+wildtest 0 0 1 1 'foo/bar' 'foo[^a-z]bar'
+wildtest 0 0 1 1 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+wildtest 1 1 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+wildtest 1 1 0 0 'foo' '**/foo'
+wildtest 1 1 1 1 'XXX/foo' '**/foo'
+wildtest 1 1 1 1 'bar/baz/foo' '**/foo'
+wildtest 0 0 1 1 'bar/baz/foo' '*/foo'
+wildtest 0 0 1 1 'foo/bar/baz' '**/bar*'
+wildtest 1 1 1 1 'deep/foo/bar/baz' '**/bar/*'
+wildtest 0 0 1 1 'deep/foo/bar/baz/' '**/bar/*'
+wildtest 1 1 1 1 'deep/foo/bar/baz/' '**/bar/**'
+wildtest 0 0 0 0 'deep/foo/bar' '**/bar/*'
+wildtest 1 1 1 1 'deep/foo/bar/' '**/bar/**'
+wildtest 0 0 1 1 'foo/bar/baz' '**/bar**'
+wildtest 1 1 1 1 'foo/bar/baz/x' '*/bar/**'
+wildtest 0 0 1 1 'deep/foo/bar/baz/x' '*/bar/**'
+wildtest 1 1 1 1 'deep/foo/bar/baz/x' '**/bar/*/*'
 
 # Various additional tests
-match 0 'acrt' 'a[c-c]st'
-match 1 'acrt' 'a[c-c]rt'
-match 0 ']' '[!]-]'
-match 1 'a' '[!]-]'
-match 0 '' '\'
-match 0 '\' '\'
-match 0 'XXX/\' '*/\'
-match 1 'XXX/\' '*/\\'
-match 1 'foo' 'foo'
-match 1 '@foo' '@foo'
-match 0 'foo' '@foo'
-match 1 '[ab]' '\[ab]'
-match 1 '[ab]' '[[]ab]'
-match 1 '[ab]' '[[:]ab]'
-match 0 '[ab]' '[[::]ab]'
-match 1 '[ab]' '[[:digit]ab]'
-match 1 '[ab]' '[\[:]ab]'
-match 1 '?a?b' '\??\?b'
-match 1 'abc' '\a\b\c'
-match 0 'foo' ''
-match 1 'foo/bar/baz/to' '**/t[o]'
+wildtest 0 0 0 0 'acrt' 'a[c-c]st'
+wildtest 1 1 1 1 'acrt' 'a[c-c]rt'
+wildtest 0 0 0 0 ']' '[!]-]'
+wildtest 1 1 1 1 'a' '[!]-]'
+wildtest 0 0 0 0 '' '\'
+wildtest 0 0 0 0 '\' '\'
+wildtest 0 0 0 0 'XXX/\' '*/\'
+wildtest 1 1 1 1 'XXX/\' '*/\\'
+wildtest 1 1 1 1 'foo' 'foo'
+wildtest 1 1 1 1 '@foo' '@foo'
+wildtest 0 0 0 0 'foo' '@foo'
+wildtest 1 1 1 1 '[ab]' '\[ab]'
+wildtest 1 1 1 1 '[ab]' '[[]ab]'
+wildtest 1 1 1 1 '[ab]' '[[:]ab]'
+wildtest 0 0 0 0 '[ab]' '[[::]ab]'
+wildtest 1 1 1 1 '[ab]' '[[:digit]ab]'
+wildtest 1 1 1 1 '[ab]' '[\[:]ab]'
+wildtest 1 1 1 1 '?a?b' '\??\?b'
+wildtest 1 1 1 1 'abc' '\a\b\c'
+wildtest 0 0 0 0 'foo' ''
+wildtest 1 1 1 1 'foo/bar/baz/to' '**/t[o]'
 
 # Character class tests
-match 1 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
-match 0 'a' '[[:digit:][:upper:][:space:]]'
-match 1 'A' '[[:digit:][:upper:][:space:]]'
-match 1 '1' '[[:digit:][:upper:][:space:]]'
-match 0 '1' '[[:digit:][:upper:][:spaci:]]'
-match 1 ' ' '[[:digit:][:upper:][:space:]]'
-match 0 '.' '[[:digit:][:upper:][:space:]]'
-match 1 '.' '[[:digit:][:punct:][:space:]]'
-match 1 '5' '[[:xdigit:]]'
-match 1 'f' '[[:xdigit:]]'
-match 1 'D' '[[:xdigit:]]'
-match 1 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
-match 1 '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
-match 1 '5' '[a-c[:digit:]x-z]'
-match 1 'b' '[a-c[:digit:]x-z]'
-match 1 'y' '[a-c[:digit:]x-z]'
-match 0 'q' '[a-c[:digit:]x-z]'
-
-# Additional tests, including some malformed wildmats
-match 1 ']' '[\\-^]'
-match 0 '[' '[\\-^]'
-match 1 '-' '[\-_]'
-match 1 ']' '[\]]'
-match 0 '\]' '[\]]'
-match 0 '\' '[\]]'
-match 0 'ab' 'a[]b'
-match 0 'a[]b' 'a[]b'
-match 0 'ab[' 'ab['
-match 0 'ab' '[!'
-match 0 'ab' '[-'
-match 1 '-' '[-]'
-match 0 '-' '[a-'
-match 0 '-' '[!a-'
-match 1 '-' '[--A]'
-match 1 '5' '[--A]'
-match 1 ' ' '[ --]'
-match 1 '$' '[ --]'
-match 1 '-' '[ --]'
-match 0 '0' '[ --]'
-match 1 '-' '[---]'
-match 1 '-' '[------]'
-match 0 'j' '[a-e-n]'
-match 1 '-' '[a-e-n]'
-match 1 'a' '[!------]'
-match 0 '[' '[]-a]'
-match 1 '^' '[]-a]'
-match 0 '^' '[!]-a]'
-match 1 '[' '[!]-a]'
-match 1 '^' '[a^bc]'
-match 1 '-b]' '[a-]b]'
-match 0 '\' '[\]'
-match 1 '\' '[\\]'
-match 0 '\' '[!\\]'
-match 1 'G' '[A-\\]'
-match 0 'aaabbb' 'b*a'
-match 0 'aabcaa' '*ba*'
-match 1 ',' '[,]'
-match 1 ',' '[\\,]'
-match 1 '\' '[\\,]'
-match 1 '-' '[,-.]'
-match 0 '+' '[,-.]'
-match 0 '-.]' '[,-.]'
-match 1 '2' '[\1-\3]'
-match 1 '3' '[\1-\3]'
-match 0 '4' '[\1-\3]'
-match 1 '\' '[[-\]]'
-match 1 '[' '[[-\]]'
-match 1 ']' '[[-\]]'
-match 0 '-' '[[-\]]'
+wildtest 1 1 1 1 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
+wildtest 0 1 0 1 'a' '[[:digit:][:upper:][:space:]]'
+wildtest 1 1 1 1 'A' '[[:digit:][:upper:][:space:]]'
+wildtest 1 1 1 1 '1' '[[:digit:][:upper:][:space:]]'
+wildtest 0 0 0 0 '1' '[[:digit:][:upper:][:spaci:]]'
+wildtest 1 1 1 1 ' ' '[[:digit:][:upper:][:space:]]'
+wildtest 0 0 0 0 '.' '[[:digit:][:upper:][:space:]]'
+wildtest 1 1 1 1 '.' '[[:digit:][:punct:][:space:]]'
+wildtest 1 1 1 1 '5' '[[:xdigit:]]'
+wildtest 1 1 1 1 'f' '[[:xdigit:]]'
+wildtest 1 1 1 1 'D' '[[:xdigit:]]'
+wildtest 1 1 1 1 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+wildtest 1 1 1 1 '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
+wildtest 1 1 1 1 '5' '[a-c[:digit:]x-z]'
+wildtest 1 1 1 1 'b' '[a-c[:digit:]x-z]'
+wildtest 1 1 1 1 'y' '[a-c[:digit:]x-z]'
+wildtest 0 0 0 0 'q' '[a-c[:digit:]x-z]'
 
-# Test recursion and the abort code (use "wildtest -i" to see iteration counts)
-match 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 1 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n*t'
-match 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*n*t'
-match 0 foo '*/*/*'
-match 0 foo/bar '*/*/*'
-match 1 foo/bba/arr '*/*/*'
-match 0 foo/bb/aa/rr '*/*/*'
-match 1 foo/bb/aa/rr '**/**/**'
-match 1 abcXdefXghi '*X*i'
-match 0 ab/cXd/efXg/hi '*X*i'
-match 1 ab/cXd/efXg/hi '*/*X*/*/*i'
-match 1 ab/cXd/efXg/hi '**/*X*/**/*i'
+# Additional tests, including some malformed wildmatch patterns
+wildtest 1 1 1 1 ']' '[\\-^]'
+wildtest 0 0 0 0 '[' '[\\-^]'
+wildtest 1 1 1 1 '-' '[\-_]'
+wildtest 1 1 1 1 ']' '[\]]'
+wildtest 0 0 0 0 '\]' '[\]]'
+wildtest 0 0 0 0 '\' '[\]]'
+wildtest 0 0 0 0 'ab' 'a[]b'
+wildtest 0 0 0 0 'a[]b' 'a[]b'
+wildtest 0 0 0 0 'ab[' 'ab['
+wildtest 0 0 0 0 'ab' '[!'
+wildtest 0 0 0 0 'ab' '[-'
+wildtest 1 1 1 1 '-' '[-]'
+wildtest 0 0 0 0 '-' '[a-'
+wildtest 0 0 0 0 '-' '[!a-'
+wildtest 1 1 1 1 '-' '[--A]'
+wildtest 1 1 1 1 '5' '[--A]'
+wildtest 1 1 1 1 ' ' '[ --]'
+wildtest 1 1 1 1 '$' '[ --]'
+wildtest 1 1 1 1 '-' '[ --]'
+wildtest 0 0 0 0 '0' '[ --]'
+wildtest 1 1 1 1 '-' '[---]'
+wildtest 1 1 1 1 '-' '[------]'
+wildtest 0 0 0 0 'j' '[a-e-n]'
+wildtest 1 1 1 1 '-' '[a-e-n]'
+wildtest 1 1 1 1 'a' '[!------]'
+wildtest 0 0 0 0 '[' '[]-a]'
+wildtest 1 1 1 1 '^' '[]-a]'
+wildtest 0 0 0 0 '^' '[!]-a]'
+wildtest 1 1 1 1 '[' '[!]-a]'
+wildtest 1 1 1 1 '^' '[a^bc]'
+wildtest 1 1 1 1 '-b]' '[a-]b]'
+wildtest 0 0 0 0 '\' '[\]'
+wildtest 1 1 1 1 '\' '[\\]'
+wildtest 0 0 0 0 '\' '[!\\]'
+wildtest 1 1 1 1 'G' '[A-\\]'
+wildtest 0 0 0 0 'aaabbb' 'b*a'
+wildtest 0 0 0 0 'aabcaa' '*ba*'
+wildtest 1 1 1 1 ',' '[,]'
+wildtest 1 1 1 1 ',' '[\\,]'
+wildtest 1 1 1 1 '\' '[\\,]'
+wildtest 1 1 1 1 '-' '[,-.]'
+wildtest 0 0 0 0 '+' '[,-.]'
+wildtest 0 0 0 0 '-.]' '[,-.]'
+wildtest 1 1 1 1 '2' '[\1-\3]'
+wildtest 1 1 1 1 '3' '[\1-\3]'
+wildtest 0 0 0 0 '4' '[\1-\3]'
+wildtest 1 1 1 1 '\' '[[-\]]'
+wildtest 1 1 1 1 '[' '[[-\]]'
+wildtest 1 1 1 1 ']' '[[-\]]'
+wildtest 0 0 0 0 '-' '[[-\]]'
 
-pathmatch 1 foo foo
-pathmatch 0 foo fo
-pathmatch 1 foo/bar foo/bar
-pathmatch 1 foo/bar 'foo/*'
-pathmatch 1 foo/bba/arr 'foo/*'
-pathmatch 1 foo/bba/arr 'foo/**'
-pathmatch 1 foo/bba/arr 'foo*'
-pathmatch 1 foo/bba/arr 'foo**'
-pathmatch 1 foo/bba/arr 'foo/*arr'
-pathmatch 1 foo/bba/arr 'foo/**arr'
-pathmatch 0 foo/bba/arr 'foo/*z'
-pathmatch 0 foo/bba/arr 'foo/**z'
-pathmatch 1 foo/bar 'foo?bar'
-pathmatch 1 foo/bar 'foo[/]bar'
-pathmatch 1 foo/bar 'foo[^a-z]bar'
-pathmatch 0 foo '*/*/*'
-pathmatch 0 foo/bar '*/*/*'
-pathmatch 1 foo/bba/arr '*/*/*'
-pathmatch 1 foo/bb/aa/rr '*/*/*'
-pathmatch 1 abcXdefXghi '*X*i'
-pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
-pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
+# Test recursion
+wildtest 1 1 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+wildtest 0 0 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+wildtest 0 0 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+wildtest 1 1 1 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+wildtest 0 0 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+wildtest 1 1 1 1 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n*t'
+wildtest 0 0 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*n*t'
+wildtest 0 0 0 0 foo '*/*/*'
+wildtest 0 0 0 0 foo/bar '*/*/*'
+wildtest 1 1 1 1 foo/bba/arr '*/*/*'
+wildtest 0 0 1 1 foo/bb/aa/rr '*/*/*'
+wildtest 1 1 1 1 foo/bb/aa/rr '**/**/**'
+wildtest 1 1 1 1 abcXdefXghi '*X*i'
+wildtest 0 0 1 1 ab/cXd/efXg/hi '*X*i'
+wildtest 1 1 1 1 ab/cXd/efXg/hi '*/*X*/*/*i'
+wildtest 1 1 1 1 ab/cXd/efXg/hi '**/*X*/**/*i'
 
-# Case-sensitivity features
-match 0 'a' '[A-Z]'
-match 1 'A' '[A-Z]'
-match 0 'A' '[a-z]'
-match 1 'a' '[a-z]'
-match 0 'a' '[[:upper:]]'
-match 1 'A' '[[:upper:]]'
-match 0 'A' '[[:lower:]]'
-match 1 'a' '[[:lower:]]'
-match 0 'A' '[B-Za]'
-match 1 'a' '[B-Za]'
-match 0 'A' '[B-a]'
-match 1 'a' '[B-a]'
-match 0 'z' '[Z-y]'
-match 1 'Z' '[Z-y]'
+# Extra pathmatch tests
+wildtest 0 0 0 0 foo fo
+wildtest 1 1 1 1 foo/bar foo/bar
+wildtest 1 1 1 1 foo/bar 'foo/*'
+wildtest 0 0 1 1 foo/bba/arr 'foo/*'
+wildtest 1 1 1 1 foo/bba/arr 'foo/**'
+wildtest 0 0 1 1 foo/bba/arr 'foo*'
+wildtest 0 0 1 1 foo/bba/arr 'foo**'
+wildtest 0 0 1 1 foo/bba/arr 'foo/*arr'
+wildtest 0 0 1 1 foo/bba/arr 'foo/**arr'
+wildtest 0 0 0 0 foo/bba/arr 'foo/*z'
+wildtest 0 0 0 0 foo/bba/arr 'foo/**z'
+wildtest 0 0 1 1 foo/bar 'foo?bar'
+wildtest 0 0 1 1 foo/bar 'foo[/]bar'
+wildtest 0 0 1 1 foo/bar 'foo[^a-z]bar'
+wildtest 0 0 1 1 ab/cXd/efXg/hi '*Xg*i'
 
-imatch 1 'a' '[A-Z]'
-imatch 1 'A' '[A-Z]'
-imatch 1 'A' '[a-z]'
-imatch 1 'a' '[a-z]'
-imatch 1 'a' '[[:upper:]]'
-imatch 1 'A' '[[:upper:]]'
-imatch 1 'A' '[[:lower:]]'
-imatch 1 'a' '[[:lower:]]'
-imatch 1 'A' '[B-Za]'
-imatch 1 'a' '[B-Za]'
-imatch 1 'A' '[B-a]'
-imatch 1 'a' '[B-a]'
-imatch 1 'z' '[Z-y]'
-imatch 1 'Z' '[Z-y]'
+# Extra case-sensitivity tests
+wildtest 0 1 0 1 'a' '[A-Z]'
+wildtest 1 1 1 1 'A' '[A-Z]'
+wildtest 0 1 0 1 'A' '[a-z]'
+wildtest 1 1 1 1 'a' '[a-z]'
+wildtest 0 1 0 1 'a' '[[:upper:]]'
+wildtest 1 1 1 1 'A' '[[:upper:]]'
+wildtest 0 1 0 1 'A' '[[:lower:]]'
+wildtest 1 1 1 1 'a' '[[:lower:]]'
+wildtest 0 1 0 1 'A' '[B-Za]'
+wildtest 1 1 1 1 'a' '[B-Za]'
+wildtest 0 1 0 1 'A' '[B-a]'
+wildtest 1 1 1 1 'a' '[B-a]'
+wildtest 0 1 0 1 'z' '[Z-y]'
+wildtest 1 1 1 1 'Z' '[Z-y]'
 
 test_done
-- 
2.15.1.424.g9478a66081

