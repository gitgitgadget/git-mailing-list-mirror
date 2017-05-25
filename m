Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C59E20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970171AbdEYTqd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38111 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036692AbdEYTq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:29 -0400
Received: by mail-wm0-f50.google.com with SMTP id e127so119838820wmg.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9+W8NoDWQRmidtFGBRDVqz8F+8djYYiwD81u9inhGc=;
        b=u+850ZjfoD/SvnuUxKU1gfnURsz+0h7bUoD+T/0J/FGgwhHad0BEwQsPkE0XokNNUz
         tFmz7kQRomeSNKkjzrq44R14qBBkTbR+k/n0HKjHG/Exk7HrqeCbaGWAFlyDcg07RDd8
         ujFyfI/BMKKbyO1zrX8Usf84KQEOlqLxg+T5q0Wuy+jCZb6zsPWSw5060mhSS7iStKOM
         G9xsfdiPgunBm3Pyzo9nY9RPMB3eU2fZ2AvBzI8Lhn4E3FdRmIQMwk7lI5xc26lfGp3j
         nYF1wj3ELxfBveQklggpBWkwckqS6QrqoKcHrvdQ+QxUPe99pWbPaxfsSGYHEeSGwP6m
         694Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9+W8NoDWQRmidtFGBRDVqz8F+8djYYiwD81u9inhGc=;
        b=r58ehXhMybDLrqGTf5HJ+B0j9QYiRA4oCBqOlEj21/wlJ7RNgOy10PpfaBeTLnmCCj
         rhZOAfb71NGu4rj524LVbVYda+dx7wrYXEw5gcnXCacPsarZ3ZPiYzeuXhECcHokn985
         fSFfYN0hD2KmAK/KLq+pTMQMQ7TxtawxvdkLl7yv9ifrDflcTn7wCeBXok+AqCXx+FZu
         /xzRSr/DI+QrQK1Sor46qxRXBTY1kGDuhlltUUNqRbD5MojxeBZXcesmj+bQN6GlfWCG
         uUaEHiHO+tpgEvdTWAhRWi80HbMEvFvZJUof3BKpmx71Hi6SMLvfGTHkmh0YTVhCFClO
         rWqQ==
X-Gm-Message-State: AODbwcCiXBPPwhc2ZMxh6xTz2qLBEfSiDKcDwBXeXh5kbmuXv9x00Raj
        t14hwb4ZDOflrw==
X-Received: by 10.28.175.136 with SMTP id y130mr11698918wme.112.1495741587753;
        Thu, 25 May 2017 12:46:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:26 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/31] grep: amend submodule recursion test for regex engine testing
Date:   Thu, 25 May 2017 19:45:14 +0000
Message-Id: <20170525194535.9324-11-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the submodule recursion test to prepare it for subsequent tests
of whether it passes along the grep.patternType to the submodule
greps.

This is the result of searching & replacing:

    foobar -> (1|2)d(3|4)
    foo    -> (1|2)
    bar    -> (3|4)

Currently there's no tests for whether e.g. -P or -E is correctly
passed along, tests for that will be added in a follow-up change, but
first add content to the tests which will match differently under
different regex engines.

Reuse the pattern established in an earlier commit of mine in this
series ("log: add exhaustive tests for pattern style options &
config", 2017-04-07). The pattern "(.|.)[\d]" will match this content
differently under fixed/basic/extended & perl.

This test code was originally added in commit 0281e487fd ("grep:
optionally recurse into submodules", 2016-12-16).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7814-grep-recurse-submodules.sh | 166 ++++++++++++++++++-------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 5b6eb3a65e..1472855e1d 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -9,13 +9,13 @@ submodules.
 . ./test-lib.sh
 
 test_expect_success 'setup directory structure and submodule' '
-	echo "foobar" >a &&
+	echo "(1|2)d(3|4)" >a &&
 	mkdir b &&
-	echo "bar" >b/b &&
+	echo "(3|4)" >b/b &&
 	git add a b &&
 	git commit -m "add a and b" &&
 	git init submodule &&
-	echo "foobar" >submodule/a &&
+	echo "(1|2)d(3|4)" >submodule/a &&
 	git -C submodule add a &&
 	git -C submodule commit -m "add a" &&
 	git submodule add ./submodule &&
@@ -24,18 +24,18 @@ test_expect_success 'setup directory structure and submodule' '
 
 test_expect_success 'grep correctly finds patterns in a submodule' '
 	cat >expect <<-\EOF &&
-	a:foobar
-	b/b:bar
-	submodule/a:foobar
+	a:(1|2)d(3|4)
+	b/b:(3|4)
+	submodule/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules >actual &&
+	git grep -e "(3|4)" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep and basic pathspecs' '
 	cat >expect <<-\EOF &&
-	submodule/a:foobar
+	submodule/a:(1|2)d(3|4)
 	EOF
 
 	git grep -e. --recurse-submodules -- submodule >actual &&
@@ -44,7 +44,7 @@ test_expect_success 'grep and basic pathspecs' '
 
 test_expect_success 'grep and nested submodules' '
 	git init submodule/sub &&
-	echo "foobar" >submodule/sub/a &&
+	echo "(1|2)d(3|4)" >submodule/sub/a &&
 	git -C submodule/sub add a &&
 	git -C submodule/sub commit -m "add a" &&
 	git -C submodule submodule add ./sub &&
@@ -54,117 +54,117 @@ test_expect_success 'grep and nested submodules' '
 	git commit -m "updated submodule" &&
 
 	cat >expect <<-\EOF &&
-	a:foobar
-	b/b:bar
-	submodule/a:foobar
-	submodule/sub/a:foobar
+	a:(1|2)d(3|4)
+	b/b:(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules >actual &&
+	git grep -e "(3|4)" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep and multiple patterns' '
 	cat >expect <<-\EOF &&
-	a:foobar
-	submodule/a:foobar
-	submodule/sub/a:foobar
+	a:(1|2)d(3|4)
+	submodule/a:(1|2)d(3|4)
+	submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --and -e "foo" --recurse-submodules >actual &&
+	git grep -e "(3|4)" --and -e "(1|2)" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep and multiple patterns' '
 	cat >expect <<-\EOF &&
-	b/b:bar
+	b/b:(3|4)
 	EOF
 
-	git grep -e "bar" --and --not -e "foo" --recurse-submodules >actual &&
+	git grep -e "(3|4)" --and --not -e "(1|2)" --recurse-submodules >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'basic grep tree' '
 	cat >expect <<-\EOF &&
-	HEAD:a:foobar
-	HEAD:b/b:bar
-	HEAD:submodule/a:foobar
-	HEAD:submodule/sub/a:foobar
+	HEAD:a:(1|2)d(3|4)
+	HEAD:b/b:(3|4)
+	HEAD:submodule/a:(1|2)d(3|4)
+	HEAD:submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree HEAD^' '
 	cat >expect <<-\EOF &&
-	HEAD^:a:foobar
-	HEAD^:b/b:bar
-	HEAD^:submodule/a:foobar
+	HEAD^:a:(1|2)d(3|4)
+	HEAD^:b/b:(3|4)
+	HEAD^:submodule/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD^ >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD^ >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree HEAD^^' '
 	cat >expect <<-\EOF &&
-	HEAD^^:a:foobar
-	HEAD^^:b/b:bar
+	HEAD^^:a:(1|2)d(3|4)
+	HEAD^^:b/b:(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD^^ >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD^^ >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree and pathspecs' '
 	cat >expect <<-\EOF &&
-	HEAD:submodule/a:foobar
-	HEAD:submodule/sub/a:foobar
+	HEAD:submodule/a:(1|2)d(3|4)
+	HEAD:submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD -- submodule >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD -- submodule >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree and pathspecs' '
 	cat >expect <<-\EOF &&
-	HEAD:submodule/a:foobar
-	HEAD:submodule/sub/a:foobar
+	HEAD:submodule/a:(1|2)d(3|4)
+	HEAD:submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD -- "submodule*a" >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD -- "submodule*a" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree and more pathspecs' '
 	cat >expect <<-\EOF &&
-	HEAD:submodule/a:foobar
+	HEAD:submodule/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD -- "submodul?/a" >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD -- "submodul?/a" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep tree and more pathspecs' '
 	cat >expect <<-\EOF &&
-	HEAD:submodule/sub/a:foobar
+	HEAD:submodule/sub/a:(1|2)d(3|4)
 	EOF
 
-	git grep -e "bar" --recurse-submodules HEAD -- "submodul*/sub/a" >actual &&
+	git grep -e "(3|4)" --recurse-submodules HEAD -- "submodul*/sub/a" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success !MINGW 'grep recurse submodule colon in name' '
 	git init parent &&
 	test_when_finished "rm -rf parent" &&
-	echo "foobar" >"parent/fi:le" &&
+	echo "(1|2)d(3|4)" >"parent/fi:le" &&
 	git -C parent add "fi:le" &&
 	git -C parent commit -m "add fi:le" &&
 
 	git init "su:b" &&
 	test_when_finished "rm -rf su:b" &&
-	echo "foobar" >"su:b/fi:le" &&
+	echo "(1|2)d(3|4)" >"su:b/fi:le" &&
 	git -C "su:b" add "fi:le" &&
 	git -C "su:b" commit -m "add fi:le" &&
 
@@ -172,30 +172,30 @@ test_expect_success !MINGW 'grep recurse submodule colon in name' '
 	git -C parent commit -m "add submodule" &&
 
 	cat >expect <<-\EOF &&
-	fi:le:foobar
-	su:b/fi:le:foobar
+	fi:le:(1|2)d(3|4)
+	su:b/fi:le:(1|2)d(3|4)
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	HEAD:fi:le:foobar
-	HEAD:su:b/fi:le:foobar
+	HEAD:fi:le:(1|2)d(3|4)
+	HEAD:su:b/fi:le:(1|2)d(3|4)
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules HEAD >actual &&
+	git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep history with moved submoules' '
 	git init parent &&
 	test_when_finished "rm -rf parent" &&
-	echo "foobar" >parent/file &&
+	echo "(1|2)d(3|4)" >parent/file &&
 	git -C parent add file &&
 	git -C parent commit -m "add file" &&
 
 	git init sub &&
 	test_when_finished "rm -rf sub" &&
-	echo "foobar" >sub/file &&
+	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
 
@@ -203,82 +203,82 @@ test_expect_success 'grep history with moved submoules' '
 	git -C parent commit -m "add submodule" &&
 
 	cat >expect <<-\EOF &&
-	dir/sub/file:foobar
-	file:foobar
+	dir/sub/file:(1|2)d(3|4)
+	file:(1|2)d(3|4)
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
 	git -C parent mv dir/sub sub-moved &&
 	git -C parent commit -m "moved submodule" &&
 
 	cat >expect <<-\EOF &&
-	file:foobar
-	sub-moved/file:foobar
+	file:(1|2)d(3|4)
+	sub-moved/file:(1|2)d(3|4)
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules >actual &&
+	git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules >actual &&
 	test_cmp expect actual &&
 
 	cat >expect <<-\EOF &&
-	HEAD^:dir/sub/file:foobar
-	HEAD^:file:foobar
+	HEAD^:dir/sub/file:(1|2)d(3|4)
+	HEAD^:file:(1|2)d(3|4)
 	EOF
-	git -C parent grep -e "foobar" --recurse-submodules HEAD^ >actual &&
+	git -C parent grep -e "(1|2)d(3|4)" --recurse-submodules HEAD^ >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep using relative path' '
 	test_when_finished "rm -rf parent sub" &&
 	git init sub &&
-	echo "foobar" >sub/file &&
+	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
 
 	git init parent &&
-	echo "foobar" >parent/file &&
+	echo "(1|2)d(3|4)" >parent/file &&
 	git -C parent add file &&
 	mkdir parent/src &&
-	echo "foobar" >parent/src/file2 &&
+	echo "(1|2)d(3|4)" >parent/src/file2 &&
 	git -C parent add src/file2 &&
 	git -C parent submodule add ../sub &&
 	git -C parent commit -m "add files and submodule" &&
 
 	# From top works
 	cat >expect <<-\EOF &&
-	file:foobar
-	src/file2:foobar
-	sub/file:foobar
+	file:(1|2)d(3|4)
+	src/file2:(1|2)d(3|4)
+	sub/file:(1|2)d(3|4)
 	EOF
-	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	git -C parent grep --recurse-submodules -e "(1|2)d(3|4)" >actual &&
 	test_cmp expect actual &&
 
 	# Relative path to top
 	cat >expect <<-\EOF &&
-	../file:foobar
-	file2:foobar
-	../sub/file:foobar
+	../file:(1|2)d(3|4)
+	file2:(1|2)d(3|4)
+	../sub/file:(1|2)d(3|4)
 	EOF
-	git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
+	git -C parent/src grep --recurse-submodules -e "(1|2)d(3|4)" -- .. >actual &&
 	test_cmp expect actual &&
 
 	# Relative path to submodule
 	cat >expect <<-\EOF &&
-	../sub/file:foobar
+	../sub/file:(1|2)d(3|4)
 	EOF
-	git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
+	git -C parent/src grep --recurse-submodules -e "(1|2)d(3|4)" -- ../sub >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'grep from a subdir' '
 	test_when_finished "rm -rf parent sub" &&
 	git init sub &&
-	echo "foobar" >sub/file &&
+	echo "(1|2)d(3|4)" >sub/file &&
 	git -C sub add file &&
 	git -C sub commit -m "add file" &&
 
 	git init parent &&
 	mkdir parent/src &&
-	echo "foobar" >parent/src/file &&
+	echo "(1|2)d(3|4)" >parent/src/file &&
 	git -C parent add src/file &&
 	git -C parent submodule add ../sub src/sub &&
 	git -C parent submodule add ../sub sub &&
@@ -286,19 +286,19 @@ test_expect_success 'grep from a subdir' '
 
 	# Verify grep from root works
 	cat >expect <<-\EOF &&
-	src/file:foobar
-	src/sub/file:foobar
-	sub/file:foobar
+	src/file:(1|2)d(3|4)
+	src/sub/file:(1|2)d(3|4)
+	sub/file:(1|2)d(3|4)
 	EOF
-	git -C parent grep --recurse-submodules -e "foobar" >actual &&
+	git -C parent grep --recurse-submodules -e "(1|2)d(3|4)" >actual &&
 	test_cmp expect actual &&
 
 	# Verify grep from a subdir works
 	cat >expect <<-\EOF &&
-	file:foobar
-	sub/file:foobar
+	file:(1|2)d(3|4)
+	sub/file:(1|2)d(3|4)
 	EOF
-	git -C parent/src grep --recurse-submodules -e "foobar" >actual &&
+	git -C parent/src grep --recurse-submodules -e "(1|2)d(3|4)" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.13.0.303.g4ebf302169

