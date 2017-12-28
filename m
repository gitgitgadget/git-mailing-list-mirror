Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029891F406
	for <e@80x24.org>; Thu, 28 Dec 2017 23:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754805AbdL1X2t (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 18:28:49 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36243 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754232AbdL1X2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 18:28:46 -0500
Received: by mail-wr0-f196.google.com with SMTP id u19so34049030wrc.3
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 15:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aLpetw69Vg0rPI1/XGXH5CZQzwA2dfgmm9dRIZDyRpM=;
        b=d52+aicU98mL/UtrkvenmUO9SW/Vqe/94r9cLtVshE/Q7dveA81aH6Tza+54fvuQlg
         2+/ZpHPZlTaMhGZHA7mJjgFubiSp375A2P+1Mi41cJ0Brqgy4oHW4lpDPGHmwFm6QG/4
         7Q8LzU4WKPtf/AywUjzzfUmuOt2doF0WpC3QmX5ILsXfUXg4pXMnrvzEMSk/xKTVe6ZJ
         kQUnts/n/FUXJM1jyX2mJiDXRrMjwKwqMP971+ncC3FNNKJVBy8uJj83UFAfUyEE87Lf
         gJ3uQTKnr4Ehp8gTIRB0LlMv1SUgCgnLg+eETVVjuDbwRNI28zCXatEs3I3FY3P6DfcO
         Lnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aLpetw69Vg0rPI1/XGXH5CZQzwA2dfgmm9dRIZDyRpM=;
        b=L3UIorbKF06pEoc0mMXwLMYRYQs1sMcZzBDy8RPsB2re/tAYdLJGow9SJl4r+tOcm1
         dD1nmfn6NAoG9rD7dr084s1mpX3L1zxJcvsGhnSYkZX0+5XFXCxmWu6KjySLm6b/OUXk
         faqmO6rEDyQdi8E6huMDtvl2lMLwd0pmuhV9godFAvHIViGuUiVeB/mpqvT9OMsdggAq
         3nzduvoX0Ikdx/r3x/EGsshoKuFETsblCLqrB/DkRDbEkO0db3m9+ehI0YhalOHTQvyT
         CZuVZ6Yr/zE4X+RyAY4lafJ6jVjgWGM+8ELm77cr9dwLnq10YioPqWFDPPYaVX7AzOpA
         glHw==
X-Gm-Message-State: AKGB3mL7wWGzl3jG3AF5agP+eLK/5IEzOsJ6Pf8mqJd2rPePmgYIKMvQ
        qQudcV233EFI61p3OMtgwS3zGvmd
X-Google-Smtp-Source: ACJfBosQ63J85brn1QllrohG0KhyKbfn0LV+yMaakBed81qq3bwI4v3Ri3UjjegCkW+SqkQI9EAmMA==
X-Received: by 10.223.183.42 with SMTP id l42mr34860097wre.1.1514503724332;
        Thu, 28 Dec 2017 15:28:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c53sm23187346wrg.10.2017.12.28.15.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 15:28:43 -0800 (PST)
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
Subject: [PATCH v3 5/7] wildmatch test: remove dead fnmatch() test code
Date:   Thu, 28 Dec 2017 23:28:21 +0000
Message-Id: <20171228232823.14450-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171228232823.14450-1-avarab@gmail.com>
References: <20171228232823.14450-1-avarab@gmail.com>
In-Reply-To: <20171225002835.29005-1-avarab@gmail.com>
References: <20171225002835.29005-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused fnmatch() test parameter from the wildmatch
test. The code that used to test this was removed in 70a8fc999d ("stop
using fnmatch (either native or compat)", 2014-02-15).

As a --word-diff shows the only change to the body of the tests is the
removal of the second out of four parameters passed to match().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 356 +++++++++++++++++++++++++--------------------------
 1 file changed, 178 insertions(+), 178 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index 9691d8eda3..2f8a681c72 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -7,13 +7,13 @@ test_description='wildmatch tests'
 match() {
 	if test "$1" = 1
 	then
-		test_expect_success "wildmatch: match '$3' '$4'" "
-			test-wildmatch wildmatch '$3' '$4'
+		test_expect_success "wildmatch: match '$2' '$3'" "
+			test-wildmatch wildmatch '$2' '$3'
 		"
 	elif test "$1" = 0
 	then
-		test_expect_success "wildmatch: no match '$3' '$4'" "
-			! test-wildmatch wildmatch '$3' '$4'
+		test_expect_success "wildmatch: no match '$2' '$3'" "
+			! test-wildmatch wildmatch '$2' '$3'
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $1" 'false'
@@ -53,176 +53,176 @@ pathmatch() {
 }
 
 # Basic wildmat features
-match 1 1 foo foo
-match 0 0 foo bar
-match 1 1 '' ""
-match 1 1 foo '???'
-match 0 0 foo '??'
-match 1 1 foo '*'
-match 1 1 foo 'f*'
-match 0 0 foo '*f'
-match 1 1 foo '*foo*'
-match 1 1 foobar '*ob*a*r*'
-match 1 1 aaaaaaabababab '*ab'
-match 1 1 'foo*' 'foo\*'
-match 0 0 foobar 'foo\*bar'
-match 1 1 'f\oo' 'f\\oo'
-match 1 1 ball '*[al]?'
-match 0 0 ten '[ten]'
-match 0 1 ten '**[!te]'
-match 0 0 ten '**[!ten]'
-match 1 1 ten 't[a-g]n'
-match 0 0 ten 't[!a-g]n'
-match 1 1 ton 't[!a-g]n'
-match 1 1 ton 't[^a-g]n'
-match 1 x 'a]b' 'a[]]b'
-match 1 x a-b 'a[]-]b'
-match 1 x 'a]b' 'a[]-]b'
-match 0 x aab 'a[]-]b'
-match 1 x aab 'a[]a-]b'
-match 1 1 ']' ']'
+match 1 foo foo
+match 0 foo bar
+match 1 '' ""
+match 1 foo '???'
+match 0 foo '??'
+match 1 foo '*'
+match 1 foo 'f*'
+match 0 foo '*f'
+match 1 foo '*foo*'
+match 1 foobar '*ob*a*r*'
+match 1 aaaaaaabababab '*ab'
+match 1 'foo*' 'foo\*'
+match 0 foobar 'foo\*bar'
+match 1 'f\oo' 'f\\oo'
+match 1 ball '*[al]?'
+match 0 ten '[ten]'
+match 0 ten '**[!te]'
+match 0 ten '**[!ten]'
+match 1 ten 't[a-g]n'
+match 0 ten 't[!a-g]n'
+match 1 ton 't[!a-g]n'
+match 1 ton 't[^a-g]n'
+match 1 'a]b' 'a[]]b'
+match 1 a-b 'a[]-]b'
+match 1 'a]b' 'a[]-]b'
+match 0 aab 'a[]-]b'
+match 1 aab 'a[]a-]b'
+match 1 ']' ']'
 
 # Extended slash-matching features
-match 0 0 'foo/baz/bar' 'foo*bar'
-match 0 0 'foo/baz/bar' 'foo**bar'
-match 0 1 'foobazbar' 'foo**bar'
-match 1 1 'foo/baz/bar' 'foo/**/bar'
-match 1 0 'foo/baz/bar' 'foo/**/**/bar'
-match 1 0 'foo/b/a/z/bar' 'foo/**/bar'
-match 1 0 'foo/b/a/z/bar' 'foo/**/**/bar'
-match 1 0 'foo/bar' 'foo/**/bar'
-match 1 0 'foo/bar' 'foo/**/**/bar'
-match 0 0 'foo/bar' 'foo?bar'
-match 0 0 'foo/bar' 'foo[/]bar'
-match 0 0 'foo/bar' 'foo[^a-z]bar'
-match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
-match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
-match 1 0 'foo' '**/foo'
-match 1 x 'XXX/foo' '**/foo'
-match 1 0 'bar/baz/foo' '**/foo'
-match 0 0 'bar/baz/foo' '*/foo'
-match 0 0 'foo/bar/baz' '**/bar*'
-match 1 0 'deep/foo/bar/baz' '**/bar/*'
-match 0 0 'deep/foo/bar/baz/' '**/bar/*'
-match 1 0 'deep/foo/bar/baz/' '**/bar/**'
-match 0 0 'deep/foo/bar' '**/bar/*'
-match 1 0 'deep/foo/bar/' '**/bar/**'
-match 0 0 'foo/bar/baz' '**/bar**'
-match 1 0 'foo/bar/baz/x' '*/bar/**'
-match 0 0 'deep/foo/bar/baz/x' '*/bar/**'
-match 1 0 'deep/foo/bar/baz/x' '**/bar/*/*'
+match 0 'foo/baz/bar' 'foo*bar'
+match 0 'foo/baz/bar' 'foo**bar'
+match 0 'foobazbar' 'foo**bar'
+match 1 'foo/baz/bar' 'foo/**/bar'
+match 1 'foo/baz/bar' 'foo/**/**/bar'
+match 1 'foo/b/a/z/bar' 'foo/**/bar'
+match 1 'foo/b/a/z/bar' 'foo/**/**/bar'
+match 1 'foo/bar' 'foo/**/bar'
+match 1 'foo/bar' 'foo/**/**/bar'
+match 0 'foo/bar' 'foo?bar'
+match 0 'foo/bar' 'foo[/]bar'
+match 0 'foo/bar' 'foo[^a-z]bar'
+match 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+match 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
+match 1 'foo' '**/foo'
+match 1 'XXX/foo' '**/foo'
+match 1 'bar/baz/foo' '**/foo'
+match 0 'bar/baz/foo' '*/foo'
+match 0 'foo/bar/baz' '**/bar*'
+match 1 'deep/foo/bar/baz' '**/bar/*'
+match 0 'deep/foo/bar/baz/' '**/bar/*'
+match 1 'deep/foo/bar/baz/' '**/bar/**'
+match 0 'deep/foo/bar' '**/bar/*'
+match 1 'deep/foo/bar/' '**/bar/**'
+match 0 'foo/bar/baz' '**/bar**'
+match 1 'foo/bar/baz/x' '*/bar/**'
+match 0 'deep/foo/bar/baz/x' '*/bar/**'
+match 1 'deep/foo/bar/baz/x' '**/bar/*/*'
 
 # Various additional tests
-match 0 0 'acrt' 'a[c-c]st'
-match 1 1 'acrt' 'a[c-c]rt'
-match 0 0 ']' '[!]-]'
-match 1 x 'a' '[!]-]'
-match 0 0 '' '\'
-match 0 x '\' '\'
-match 0 x 'XXX/\' '*/\'
-match 1 x 'XXX/\' '*/\\'
-match 1 1 'foo' 'foo'
-match 1 1 '@foo' '@foo'
-match 0 0 'foo' '@foo'
-match 1 1 '[ab]' '\[ab]'
-match 1 1 '[ab]' '[[]ab]'
-match 1 x '[ab]' '[[:]ab]'
-match 0 x '[ab]' '[[::]ab]'
-match 1 x '[ab]' '[[:digit]ab]'
-match 1 x '[ab]' '[\[:]ab]'
-match 1 1 '?a?b' '\??\?b'
-match 1 1 'abc' '\a\b\c'
-match 0 0 'foo' ''
-match 1 0 'foo/bar/baz/to' '**/t[o]'
+match 0 'acrt' 'a[c-c]st'
+match 1 'acrt' 'a[c-c]rt'
+match 0 ']' '[!]-]'
+match 1 'a' '[!]-]'
+match 0 '' '\'
+match 0 '\' '\'
+match 0 'XXX/\' '*/\'
+match 1 'XXX/\' '*/\\'
+match 1 'foo' 'foo'
+match 1 '@foo' '@foo'
+match 0 'foo' '@foo'
+match 1 '[ab]' '\[ab]'
+match 1 '[ab]' '[[]ab]'
+match 1 '[ab]' '[[:]ab]'
+match 0 '[ab]' '[[::]ab]'
+match 1 '[ab]' '[[:digit]ab]'
+match 1 '[ab]' '[\[:]ab]'
+match 1 '?a?b' '\??\?b'
+match 1 'abc' '\a\b\c'
+match 0 'foo' ''
+match 1 'foo/bar/baz/to' '**/t[o]'
 
 # Character class tests
-match 1 x 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
-match 0 x 'a' '[[:digit:][:upper:][:space:]]'
-match 1 x 'A' '[[:digit:][:upper:][:space:]]'
-match 1 x '1' '[[:digit:][:upper:][:space:]]'
-match 0 x '1' '[[:digit:][:upper:][:spaci:]]'
-match 1 x ' ' '[[:digit:][:upper:][:space:]]'
-match 0 x '.' '[[:digit:][:upper:][:space:]]'
-match 1 x '.' '[[:digit:][:punct:][:space:]]'
-match 1 x '5' '[[:xdigit:]]'
-match 1 x 'f' '[[:xdigit:]]'
-match 1 x 'D' '[[:xdigit:]]'
-match 1 x '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
-match 1 x '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
-match 1 x '5' '[a-c[:digit:]x-z]'
-match 1 x 'b' '[a-c[:digit:]x-z]'
-match 1 x 'y' '[a-c[:digit:]x-z]'
-match 0 x 'q' '[a-c[:digit:]x-z]'
+match 1 'a1B' '[[:alpha:]][[:digit:]][[:upper:]]'
+match 0 'a' '[[:digit:][:upper:][:space:]]'
+match 1 'A' '[[:digit:][:upper:][:space:]]'
+match 1 '1' '[[:digit:][:upper:][:space:]]'
+match 0 '1' '[[:digit:][:upper:][:spaci:]]'
+match 1 ' ' '[[:digit:][:upper:][:space:]]'
+match 0 '.' '[[:digit:][:upper:][:space:]]'
+match 1 '.' '[[:digit:][:punct:][:space:]]'
+match 1 '5' '[[:xdigit:]]'
+match 1 'f' '[[:xdigit:]]'
+match 1 'D' '[[:xdigit:]]'
+match 1 '_' '[[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:graph:][:lower:][:print:][:punct:][:space:][:upper:][:xdigit:]]'
+match 1 '.' '[^[:alnum:][:alpha:][:blank:][:cntrl:][:digit:][:lower:][:space:][:upper:][:xdigit:]]'
+match 1 '5' '[a-c[:digit:]x-z]'
+match 1 'b' '[a-c[:digit:]x-z]'
+match 1 'y' '[a-c[:digit:]x-z]'
+match 0 'q' '[a-c[:digit:]x-z]'
 
 # Additional tests, including some malformed wildmats
-match 1 x ']' '[\\-^]'
-match 0 0 '[' '[\\-^]'
-match 1 x '-' '[\-_]'
-match 1 x ']' '[\]]'
-match 0 0 '\]' '[\]]'
-match 0 0 '\' '[\]]'
-match 0 0 'ab' 'a[]b'
-match 0 x 'a[]b' 'a[]b'
-match 0 x 'ab[' 'ab['
-match 0 0 'ab' '[!'
-match 0 0 'ab' '[-'
-match 1 1 '-' '[-]'
-match 0 0 '-' '[a-'
-match 0 0 '-' '[!a-'
-match 1 x '-' '[--A]'
-match 1 x '5' '[--A]'
-match 1 1 ' ' '[ --]'
-match 1 1 '$' '[ --]'
-match 1 1 '-' '[ --]'
-match 0 0 '0' '[ --]'
-match 1 x '-' '[---]'
-match 1 x '-' '[------]'
-match 0 0 'j' '[a-e-n]'
-match 1 x '-' '[a-e-n]'
-match 1 x 'a' '[!------]'
-match 0 0 '[' '[]-a]'
-match 1 x '^' '[]-a]'
-match 0 0 '^' '[!]-a]'
-match 1 x '[' '[!]-a]'
-match 1 1 '^' '[a^bc]'
-match 1 x '-b]' '[a-]b]'
-match 0 0 '\' '[\]'
-match 1 1 '\' '[\\]'
-match 0 0 '\' '[!\\]'
-match 1 1 'G' '[A-\\]'
-match 0 0 'aaabbb' 'b*a'
-match 0 0 'aabcaa' '*ba*'
-match 1 1 ',' '[,]'
-match 1 1 ',' '[\\,]'
-match 1 1 '\' '[\\,]'
-match 1 1 '-' '[,-.]'
-match 0 0 '+' '[,-.]'
-match 0 0 '-.]' '[,-.]'
-match 1 1 '2' '[\1-\3]'
-match 1 1 '3' '[\1-\3]'
-match 0 0 '4' '[\1-\3]'
-match 1 1 '\' '[[-\]]'
-match 1 1 '[' '[[-\]]'
-match 1 1 ']' '[[-\]]'
-match 0 0 '-' '[[-\]]'
+match 1 ']' '[\\-^]'
+match 0 '[' '[\\-^]'
+match 1 '-' '[\-_]'
+match 1 ']' '[\]]'
+match 0 '\]' '[\]]'
+match 0 '\' '[\]]'
+match 0 'ab' 'a[]b'
+match 0 'a[]b' 'a[]b'
+match 0 'ab[' 'ab['
+match 0 'ab' '[!'
+match 0 'ab' '[-'
+match 1 '-' '[-]'
+match 0 '-' '[a-'
+match 0 '-' '[!a-'
+match 1 '-' '[--A]'
+match 1 '5' '[--A]'
+match 1 ' ' '[ --]'
+match 1 '$' '[ --]'
+match 1 '-' '[ --]'
+match 0 '0' '[ --]'
+match 1 '-' '[---]'
+match 1 '-' '[------]'
+match 0 'j' '[a-e-n]'
+match 1 '-' '[a-e-n]'
+match 1 'a' '[!------]'
+match 0 '[' '[]-a]'
+match 1 '^' '[]-a]'
+match 0 '^' '[!]-a]'
+match 1 '[' '[!]-a]'
+match 1 '^' '[a^bc]'
+match 1 '-b]' '[a-]b]'
+match 0 '\' '[\]'
+match 1 '\' '[\\]'
+match 0 '\' '[!\\]'
+match 1 'G' '[A-\\]'
+match 0 'aaabbb' 'b*a'
+match 0 'aabcaa' '*ba*'
+match 1 ',' '[,]'
+match 1 ',' '[\\,]'
+match 1 '\' '[\\,]'
+match 1 '-' '[,-.]'
+match 0 '+' '[,-.]'
+match 0 '-.]' '[,-.]'
+match 1 '2' '[\1-\3]'
+match 1 '3' '[\1-\3]'
+match 0 '4' '[\1-\3]'
+match 1 '\' '[[-\]]'
+match 1 '[' '[[-\]]'
+match 1 ']' '[[-\]]'
+match 0 '-' '[[-\]]'
 
 # Test recursion and the abort code (use "wildtest -i" to see iteration counts)
-match 1 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 0 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
-match 1 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 0 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
-match 1 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n*t'
-match 0 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*n*t'
-match 0 x foo '*/*/*'
-match 0 x foo/bar '*/*/*'
-match 1 x foo/bba/arr '*/*/*'
-match 0 x foo/bb/aa/rr '*/*/*'
-match 1 x foo/bb/aa/rr '**/**/**'
-match 1 x abcXdefXghi '*X*i'
-match 0 x ab/cXd/efXg/hi '*X*i'
-match 1 x ab/cXd/efXg/hi '*/*X*/*/*i'
-match 1 x ab/cXd/efXg/hi '**/*X*/**/*i'
+match 1 '-adobe-courier-bold-o-normal--12-120-75-75-m-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 0 '-adobe-courier-bold-o-normal--12-120-75-75-X-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 0 '-adobe-courier-bold-o-normal--12-120-75-75-/-70-iso8859-1' '-*-*-*-*-*-*-12-*-*-*-m-*-*-*'
+match 1 'XXX/adobe/courier/bold/o/normal//12/120/75/75/m/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 0 'XXX/adobe/courier/bold/o/normal//12/120/75/75/X/70/iso8859/1' 'XXX/*/*/*/*/*/*/12/*/*/*/m/*/*/*'
+match 1 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txt' '**/*a*b*g*n*t'
+match 0 'abcd/abcdefg/abcdefghijk/abcdefghijklmnop.txtz' '**/*a*b*g*n*t'
+match 0 foo '*/*/*'
+match 0 foo/bar '*/*/*'
+match 1 foo/bba/arr '*/*/*'
+match 0 foo/bb/aa/rr '*/*/*'
+match 1 foo/bb/aa/rr '**/**/**'
+match 1 abcXdefXghi '*X*i'
+match 0 ab/cXd/efXg/hi '*X*i'
+match 1 ab/cXd/efXg/hi '*/*X*/*/*i'
+match 1 ab/cXd/efXg/hi '**/*X*/**/*i'
 
 pathmatch 1 foo foo
 pathmatch 0 foo fo
@@ -248,20 +248,20 @@ pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
 pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
 
 # Case-sensitivity features
-match 0 x 'a' '[A-Z]'
-match 1 x 'A' '[A-Z]'
-match 0 x 'A' '[a-z]'
-match 1 x 'a' '[a-z]'
-match 0 x 'a' '[[:upper:]]'
-match 1 x 'A' '[[:upper:]]'
-match 0 x 'A' '[[:lower:]]'
-match 1 x 'a' '[[:lower:]]'
-match 0 x 'A' '[B-Za]'
-match 1 x 'a' '[B-Za]'
-match 0 x 'A' '[B-a]'
-match 1 x 'a' '[B-a]'
-match 0 x 'z' '[Z-y]'
-match 1 x 'Z' '[Z-y]'
+match 0 'a' '[A-Z]'
+match 1 'A' '[A-Z]'
+match 0 'A' '[a-z]'
+match 1 'a' '[a-z]'
+match 0 'a' '[[:upper:]]'
+match 1 'A' '[[:upper:]]'
+match 0 'A' '[[:lower:]]'
+match 1 'a' '[[:lower:]]'
+match 0 'A' '[B-Za]'
+match 1 'a' '[B-Za]'
+match 0 'A' '[B-a]'
+match 1 'a' '[B-a]'
+match 0 'z' '[Z-y]'
+match 1 'Z' '[Z-y]'
 
 imatch 1 'a' '[A-Z]'
 imatch 1 'A' '[A-Z]'
-- 
2.15.1.424.g9478a66081

