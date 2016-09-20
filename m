Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 776EC209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932982AbcITTDQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:03:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35241 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932536AbcITTDD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:03:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so4912613wmq.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7q/gps3z0DfT8BJKCnd1LQKL1h4lBhjFsllT/GnpUPo=;
        b=y3ek3+Z0RNZT/Z1OiOYlZGOAzia1ynmiGIU27lLk2GIl8bZ8vO+rGZzEwGHMNpGntS
         ROkPq7CFx/O9qG6A9gX+rzQhJvhc/Z1gcKNw7dJLMifJpP0ZK3FGTR8ZU1kmzqZdofET
         YVVlXD1LR1UdMhoEphmWfQ76EkCsviIaO7ocDPJGTBJELqBsv32yV51EtjtCxlBGXO/D
         uJ29MRRYiDtMY3YfiHEYReOjWLHJ8EuOoRb/32z6TZ6RYSLCJja6SnfUymUI55QQxOQ/
         175j5sy4sHT3u8o60XOekYYHwctIadKBtWx5SuXFTFtlhbJjcGLFk6rAofIfldBER/cu
         39Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7q/gps3z0DfT8BJKCnd1LQKL1h4lBhjFsllT/GnpUPo=;
        b=iBzv44db/NmPO8QaVM1keUwK0pUHUMnt9DF7kCnnRDSU3oLNF+Uf65dhTnITymJJFS
         F+z97V9a7KpWCrsjvwUGcoodk8NkG3OnGcdQCi0PkAb1Y9W1FSW9QuR82ha49WZe+9Cv
         SiCZrdlKr+xvUacmdZlzWsfHB9jh7zzaqRR530HSzeBi+zqlRTvwQW+bYWNN9BHL1A+s
         ENROEBa8es/GSsfHzI81Xv+xduZFejbVNLJWqBIz5GwGmpa6vS0bZfjuZcD/qhpqzegO
         NUhPxBKkEj9oPtXdulAatI0CrvPR5eSwzLWJ9H+MOrbmNOBON7Gr0aRrx9GS/ZSrEYim
         kf4g==
X-Gm-Message-State: AE9vXwNrmFr06BUhyuN9k/rpeDjqpL5dw7hE2q7+UOr3OMb2GhWy24F0W6nmnX4n/MTOxw==
X-Received: by 10.194.68.8 with SMTP id r8mr29492953wjt.190.1474398181554;
        Tue, 20 Sep 2016 12:03:01 -0700 (PDT)
Received: from slxBook4.fritz.box (p508BA5EF.dip0.t-ipconnect.de. [80.139.165.239])
        by smtp.gmail.com with ESMTPSA id gg10sm29820728wjd.4.2016.09.20.12.03.00
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 20 Sep 2016 12:03:01 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        jnareb@gmail.com, mlbright@gmail.com, tboegi@web.de,
        ramsay@ramsayjones.plus.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 09/11] convert: modernize tests
Date:   Tue, 20 Sep 2016 21:02:45 +0200
Message-Id: <20160920190247.82189-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160920190247.82189-1-larsxschneider@gmail.com>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Use `test_config` to set the config, check that files are empty with
`test_must_be_empty`, compare files with `test_cmp`, and remove spaces
after ">" and "<".

Please note that the "rot13" filter configured in "setup" keeps using
`git config` instead of `test_config` because subsequent tests might
depend on it.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t0021-conversion.sh | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e799e59..dc50938 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -38,8 +38,8 @@ script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
 
 test_expect_success check '
 
-	cmp test.o test &&
-	cmp test.o test.t &&
+	test_cmp test.o test &&
+	test_cmp test.o test.t &&
 
 	# ident should be stripped in the repository
 	git diff --raw --exit-code :test :test.i &&
@@ -47,10 +47,10 @@ test_expect_success check '
 	embedded=$(sed -ne "$script" test.i) &&
 	test "z$id" = "z$embedded" &&
 
-	git cat-file blob :test.t > test.r &&
+	git cat-file blob :test.t >test.r &&
 
-	./rot13.sh < test.o > test.t &&
-	cmp test.r test.t
+	./rot13.sh <test.o >test.t &&
+	test_cmp test.r test.t
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that
@@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
 
 	# delete the files and check them out again, using a smudge filter
 	# that will count the args and echo the command-line back to us
-	git config filter.argc.smudge "sh ./argc.sh %f" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -141,7 +141,7 @@ test_expect_success 'filter shell-escaped filenames' '
 	test_cmp expect "$special" &&
 
 	# do the same thing, but with more args in the filter expression
-	git config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
+	test_config filter.argc.smudge "sh ./argc.sh %f --my-extra-arg" &&
 	rm "$normal" "$special" &&
 	git checkout -- "$normal" "$special" &&
 
@@ -154,9 +154,9 @@ test_expect_success 'filter shell-escaped filenames' '
 '
 
 test_expect_success 'required filter should filter data' '
-	git config filter.required.smudge ./rot13.sh &&
-	git config filter.required.clean ./rot13.sh &&
-	git config filter.required.required true &&
+	test_config filter.required.smudge ./rot13.sh &&
+	test_config filter.required.clean ./rot13.sh &&
+	test_config filter.required.required true &&
 
 	echo "*.r filter=required" >.gitattributes &&
 
@@ -165,17 +165,17 @@ test_expect_success 'required filter should filter data' '
 
 	rm -f test.r &&
 	git checkout -- test.r &&
-	cmp test.o test.r &&
+	test_cmp test.o test.r &&
 
 	./rot13.sh <test.o >expected &&
 	git cat-file blob :test.r >actual &&
-	cmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'required filter smudge failure' '
-	git config filter.failsmudge.smudge false &&
-	git config filter.failsmudge.clean cat &&
-	git config filter.failsmudge.required true &&
+	test_config filter.failsmudge.smudge false &&
+	test_config filter.failsmudge.clean cat &&
+	test_config filter.failsmudge.required true &&
 
 	echo "*.fs filter=failsmudge" >.gitattributes &&
 
@@ -186,9 +186,9 @@ test_expect_success 'required filter smudge failure' '
 '
 
 test_expect_success 'required filter clean failure' '
-	git config filter.failclean.smudge cat &&
-	git config filter.failclean.clean false &&
-	git config filter.failclean.required true &&
+	test_config filter.failclean.smudge cat &&
+	test_config filter.failclean.clean false &&
+	test_config filter.failclean.required true &&
 
 	echo "*.fc filter=failclean" >.gitattributes &&
 
@@ -197,8 +197,8 @@ test_expect_success 'required filter clean failure' '
 '
 
 test_expect_success 'filtering large input to small output should use little memory' '
-	git config filter.devnull.clean "cat >/dev/null" &&
-	git config filter.devnull.required true &&
+	test_config filter.devnull.clean "cat >/dev/null" &&
+	test_config filter.devnull.required true &&
 	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
 	echo "30MB filter=devnull" >.gitattributes &&
 	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
@@ -207,7 +207,7 @@ test_expect_success 'filtering large input to small output should use little mem
 test_expect_success 'filter that does not read is fine' '
 	test-genrandom foo $((128 * 1024 + 1)) >big &&
 	echo "big filter=epipe" >.gitattributes &&
-	git config filter.epipe.clean "echo xyzzy" &&
+	test_config filter.epipe.clean "echo xyzzy" &&
 	git add big &&
 	git cat-file blob :big >actual &&
 	echo xyzzy >expect &&
@@ -215,20 +215,20 @@ test_expect_success 'filter that does not read is fine' '
 '
 
 test_expect_success EXPENSIVE 'filter large file' '
-	git config filter.largefile.smudge cat &&
-	git config filter.largefile.clean cat &&
+	test_config filter.largefile.smudge cat &&
+	test_config filter.largefile.clean cat &&
 	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
 	echo "2GB filter=largefile" >.gitattributes &&
 	git add 2GB 2>err &&
-	! test -s err &&
+	test_must_be_empty err &&
 	rm -f 2GB &&
 	git checkout -- 2GB 2>err &&
-	! test -s err
+	test_must_be_empty err
 '
 
 test_expect_success "filter: clean empty file" '
-	git config filter.in-repo-header.clean  "echo cleaned && cat" &&
-	git config filter.in-repo-header.smudge "sed 1d" &&
+	test_config filter.in-repo-header.clean  "echo cleaned && cat" &&
+	test_config filter.in-repo-header.smudge "sed 1d" &&
 
 	echo "empty-in-worktree    filter=in-repo-header" >>.gitattributes &&
 	>empty-in-worktree &&
@@ -240,8 +240,8 @@ test_expect_success "filter: clean empty file" '
 '
 
 test_expect_success "filter: smudge empty file" '
-	git config filter.empty-in-repo.clean "cat >/dev/null" &&
-	git config filter.empty-in-repo.smudge "echo smudged && cat" &&
+	test_config filter.empty-in-repo.clean "cat >/dev/null" &&
+	test_config filter.empty-in-repo.smudge "echo smudged && cat" &&
 
 	echo "empty-in-repo filter=empty-in-repo" >>.gitattributes &&
 	echo dead data walking >empty-in-repo &&
-- 
2.10.0

