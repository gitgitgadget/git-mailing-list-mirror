Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90477207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 09:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428809AbdDYJpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 05:45:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36306 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176238AbdDYJpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 05:45:06 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so15969855wrc.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww7eQn5OEdFMkqQRFDIw+CyjeAi/jxS+DXS2QptGUog=;
        b=L5wfY+OGC6T1nzzlEahZ/LTRnARhVpNCGN//Ef9k/aTWviJ7XnJYrQ8SuR1jzweVhO
         duXQB+KRNNn7RTYD0vHwlwVv9F4845K5itD5WvZBQ0BpTLr8qwEZN3wGbKeKNS9qLY8W
         XklfiIl3TdP27dE1LddmqoaLsoPGLwRJ6QDjHLWf8mSK9bxuJfWG5EGaE8rlNLsvSN6Y
         kAyFSTddFcziwUNOYg2a4avky3oZtXz7VWqHtFU4KWV4c9XuhgyrWAnJXHRC+3fYpLlf
         T9/GvqbR9tEWaW8uh5B9LL7ywgL5bo56Fvk8xQxXK9p2knxasl7yCpvbb0ijYV7eIWQ6
         /Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ww7eQn5OEdFMkqQRFDIw+CyjeAi/jxS+DXS2QptGUog=;
        b=FzphWMQVTYpD1gruAtxYQOuf8oju7btlgRc5vcfcvw0MhIrY8xSTQ1hElSLcU+NoEl
         2qDDn686BBgq9+6y4KQAQX644JXeVDdP5opFX4Z4u5sacbGW7jOd7sbX27JPYHT1v8HB
         sp6PUQq/gOW2ZkkhNbMbkvkOpNpowPHU2P3Bbs5+TjPKu4rwVwEgobzQabxMJUkCZqpc
         Aqfx2Jzacog1dg2OU3KMYQhYwXuzVfItDErDTI0+NUOAz4bvBdozZFyFr06qwgF3ir/A
         oeJBmVUB3QhiPv+gP7nbFOMN0pV7pLEwhb9GkcqhwMpsZN2exnjy8gy1oq0nfxaLAzP6
         kjJA==
X-Gm-Message-State: AN3rC/7tXdYSYub6QrcAQlfswlcSy87F+4FGyMR3jnnJdNlHxVruMeWI
        zoo0xJrgCictpw==
X-Received: by 10.223.136.75 with SMTP id e11mr9384235wre.14.1493113504354;
        Tue, 25 Apr 2017 02:45:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l45sm8142656wre.2.2017.04.25.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 02:45:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] test: remove unused parameter from the wildmatch test
Date:   Tue, 25 Apr 2017 09:44:53 +0000
Message-Id: <20170425094453.9823-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the unused second parameter to the match() function. Since
commit 70a8fc999d ("stop using fnmatch (either native or compat)",
2014-02-15) this hasn't been used, but was previously used to indicate
ok/fail if the fnmatch() backend was in use.

The "x" argument meant that the test would be skipped for
fnmatch(). Support for that was implicitly added in commit
feabcc173b ("Integrate wildmatch to git", 2012-10-15) by leaving out
an "else" condition, and made use of starting in commit
b79c0c3755 ("wildmatch: properly fold case everywhere", 2013-05-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 356 +++++++++++++++++++++++++--------------------------
 1 file changed, 178 insertions(+), 178 deletions(-)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index ef509df351..a54fe1845f 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -6,12 +6,12 @@ test_description='wildmatch tests'
 
 match() {
     if [ $1 = 1 ]; then
-	test_expect_success "wildmatch:     match '$3' '$4'" "
-	    test-wildmatch wildmatch '$3' '$4'
+	test_expect_success "wildmatch:     match '$2' '$3'" "
+	    test-wildmatch wildmatch '$2' '$3'
 	"
     else
-	test_expect_success "wildmatch:  no match '$3' '$4'" "
-	    ! test-wildmatch wildmatch '$3' '$4'
+	test_expect_success "wildmatch:  no match '$2' '$3'" "
+	    ! test-wildmatch wildmatch '$2' '$3'
 	"
     fi
 }
@@ -41,176 +41,176 @@ pathmatch() {
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
@@ -235,20 +235,20 @@ pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
 pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
 
 # Case-sensitivy features
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
2.11.0

