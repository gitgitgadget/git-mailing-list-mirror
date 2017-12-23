Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24E181F404
	for <e@80x24.org>; Sat, 23 Dec 2017 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757244AbdLWVam (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 16:30:42 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33990 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757223AbdLWVag (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 16:30:36 -0500
Received: by mail-wr0-f177.google.com with SMTP id y21so30620539wrc.1
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeoiJZ1yl1W7dKzYI0WDlLQYqUoq57UI7sK90kKW2zY=;
        b=SZ0nEVJgZvcv8GuksMA+MbZDrQYkEhszIYAswVtgPLCkadqCVoAI85iaLoLzWlz/rH
         KK6ct1Qt4C7cXSbM1J0Dc6X5gkTPj0AvntLI1pboGb3zds9QewYqGprOk/qlv7Yztmkj
         UBk3kGWOxooWUdcDCoId9DTBIhARZqVOpNPOGrtdm0/C5PMctkO9/uFy87rx/2H0od36
         UXuaqdWqhC2Gc5zZM9YENfOiGU8d6ElkuqHlQkpAOEpuPHfU7USv5UvT9iD1fMvZmokD
         W1+sX1QJ0SVvl7C5vMikrydjiH/G3HXdAvTfA9WlPix/Pj1f2P3tLuLVyZWd9Ge7Y1Vp
         +xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeoiJZ1yl1W7dKzYI0WDlLQYqUoq57UI7sK90kKW2zY=;
        b=X+fDTrbNX98pcwaFVyIDnPdnSoMgt0Il4WtRI3JAcivZnKcR2Ch3Fyu6gBoXGRR8e1
         phV6o2I1j+hUX0DgaDYnG4G7yWlpebjx/QY4PgdeTnOlFWwzd9rl43uCY4MWgJ8nLsgr
         gY4nYSnoqA+Mb0VUEdnSO9BO4++bL6P2yJhpZCBCWy+P69zDKGPXPj/4Zqe0eIDDoKrG
         cW0ujXuMUJnxodb65j/MycwhFIrMOw9hKm+p+zZXOA3chLUWYc7JcstTQ5v5FXT8o7e0
         thhwI5yK22AKm+KXljtapYKzCgWvln20jbEDbyL/TY6iBov1HAX6huhhhU1nvKP4Uj4n
         WqTg==
X-Gm-Message-State: AKGB3mIebSYhrxi+MMobp3vq/Z/0pl0vhRe/z1mSip0knJGF4sZAlChS
        oq7egwz6eB42whwAK/2vHi86r6AD
X-Google-Smtp-Source: ACJfBosqn8wSckBWdIKkR8qj2bZaDTDmHxZaBSNHmjjyeG/z/L8rsJ4VNvj/16iYDksy3aOFPMR9HA==
X-Received: by 10.223.193.4 with SMTP id r4mr16897494wre.151.1514064633956;
        Sat, 23 Dec 2017 13:30:33 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c2sm29074950wrc.81.2017.12.23.13.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 13:30:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] wildmatch test: perform all tests under all wildmatch() modes
Date:   Sat, 23 Dec 2017 21:30:11 +0000
Message-Id: <20171223213012.1962-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
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
index 1624200a1e..47b479e423 100755
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
-		test_expect_success "wildmatch:     match '$2' '$3'" "
-			test-wildmatch wildmatch '$2' '$3'
+		test_expect_success "wildmatch:     match '$text' '$pattern'" "
+			test-wildmatch wildmatch '$text' '$pattern'
 		"
-	elif test "$1" = 0
+	elif test "$match_w_glob" = 0
 	then
-		test_expect_success "wildmatch:  no match '$2' '$3'" "
-			! test-wildmatch wildmatch '$2' '$3'
+		test_expect_success "wildmatch:  no match '$text' '$pattern'" "
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
-		test_expect_success "iwildmatch:    match '$2' '$3'" "
-			test-wildmatch iwildmatch '$2' '$3'
+		test_expect_success "iwildmatch:    match '$text' '$pattern'" "
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
-		test_expect_success "pathmatch:     match '$2' '$3'" "
-			test-wildmatch pathmatch '$2' '$3'
+		test_expect_success "pathmatch:     match '$text' '$pattern'" "
+			test-wildmatch pathmatch '$text' '$pattern'
 		"
-	elif test "$1" = 0
+	elif test "$match_w_pathmatch" = 0
 	then
-		test_expect_success "pathmatch:  no match '$2' '$3'" "
-			! test-wildmatch pathmatch '$2' '$3'
+		test_expect_success "pathmatch:  no match '$text' '$pattern'" "
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

