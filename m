Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC92720A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 21:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXVYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 16:24:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46977 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXVYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Dec 2018 16:24:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so12468144wrt.13
        for <git@vger.kernel.org>; Mon, 24 Dec 2018 13:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JbcdzMgCs+kIfigbTgy1eqeYjHZVD25JsGrwaLVP94c=;
        b=KIA7rToC0PXKr4Ta9cakNcs1kIIojD2rttugVhWscqL88MiNmy8U4lJ4VW48/U83Z9
         rFrPmRqyOwAetK0se8ABvdE1ta1t+b0KCFNb6OmL86nFvCeIKT/ntMne3DrNAWeEN2jb
         ctfX9E0G/oeBFjr0TH7uDmGkiR0NNmWSS+M0pEbQaFNLJZ/nL9aw2ryFvkwhuCv3ZJvG
         TRspmK1/Yhew0r5RjGtvKeavb+SIksY3J7+rnjl/MUyxLNyRU7A14JJvub3OiBuzevWI
         Z7QYLRxGkhgFqxfLlWaDDJxliFNGV1zsbdKe5BL52zBF8C0lOdyUt8lsoQaIbQJdD0/M
         deMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbcdzMgCs+kIfigbTgy1eqeYjHZVD25JsGrwaLVP94c=;
        b=gKS31YTtE5nS7nn+JoJiZDWbAm4rYuLQTWjMAvJ0D0yapei32dcDpz9jWl2I2h/VZE
         71vnG6dGLZfa6zeB5K2Asyqmq1CwKZ5bLSmttq69aAD2mCF7Igag5YaLLsH3EGmjIscH
         maOZMWPvDubZC3Qqv+2Yf6/XiO6XOM7WH4HPwkLm8GB1zm6ctOv03t6ysv2Ul8ALnG6F
         ihRlgex7+vmWinF6PnuO1R5SIDWwTY1NRHI6+i7IY4PDfmx/nnH//diW/+mEqKCHflCd
         1Zb58xULZnpsVBcVOSp3iVad6qJfD3UfzSb7DsNXlSYjDCqeRtHY8z5kiFGu5Vlh2XmR
         ZR7w==
X-Gm-Message-State: AJcUukfVMTA7L1WPgCVFxma+lNuGvPxvzqL1VuzdwSLOPCBkE31iIsFw
        vHs6Ud0FN81XVy1yCo3jIThQEfTx
X-Google-Smtp-Source: ALg8bN5518t78yOZDTX5CJseIpVWGwnOMUyhQ4uyrsLBaMtmoarYwwwZ8JEN+w8d1QF624MvuaO91w==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr13520017wrj.58.1545686677554;
        Mon, 24 Dec 2018 13:24:37 -0800 (PST)
Received: from localhost.localdomain ([95.86.80.136])
        by smtp.gmail.com with ESMTPSA id n5sm23637815wrr.94.2018.12.24.13.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:24:37 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 1/2] t5403: Refactor
Date:   Mon, 24 Dec 2018 23:24:24 +0200
Message-Id: <20181224212425.16596-2-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181224212425.16596-1-orgads@gmail.com>
References: <20181224212425.16596-1-orgads@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

* Replace multiple clones and commits by test_commits.
* Replace 3 invocations of awk by read.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 80 +++++++++++++----------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fc898c9eac..9f9a5163c5 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,77 +7,55 @@ test_description='Test the post-checkout hook.'
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo Data for commit0. >a &&
-	echo Data for commit0. >b &&
-	git update-index --add a &&
-	git update-index --add b &&
-	tree0=$(git write-tree) &&
-	commit0=$(echo setup | git commit-tree $tree0) &&
-	git update-ref refs/heads/master $commit0 &&
-	git clone ./. clone1 &&
-	git clone ./. clone2 &&
-	GIT_DIR=clone2/.git git branch new2 &&
-	echo Data for commit1. >clone2/b &&
-	GIT_DIR=clone2/.git git add clone2/b &&
-	GIT_DIR=clone2/.git git commit -m new2
-'
-
-for clone in 1 2; do
-    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
-#!/bin/sh
-echo $@ > $GIT_DIR/post-checkout.args
-EOF
-    chmod u+x clone${clone}/.git/hooks/post-checkout
-done
-
-test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
+	mv .git/hooks-disabled .git/hooks &&
+	write_script .git/hooks/post-checkout <<-\EOF &&
+	echo $@ >.git/post-checkout.args
+	EOF
+	test_commit one &&
+	test_commit two &&
+	test_commit three three
 '
 
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new && test $flag = 1
+	git checkout master &&
+	test -e .git/post-checkout.args &&
+	read old new flag <.git/post-checkout.args &&
+	test $old = $new && test $flag = 1 &&
+	rm -f .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
+	git checkout master &&
+	test -e .git/post-checkout.args &&
+	rm -f .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
-	GIT_DIR=clone1/.git git checkout -b new1 &&
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
-	test $old = $new && test $flag = 1
+	git checkout -b new1 &&
+	read old new flag <.git/post-checkout.args &&
+	test $old = $new && test $flag = 1 &&
+	rm -f .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
-	GIT_DIR=clone2/.git git checkout new2 &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old != $new && test $flag = 1
+	git checkout two &&
+	read old new flag <.git/post-checkout.args &&
+	test $old != $new && test $flag = 1 &&
+	rm -f .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-	GIT_DIR=clone2/.git git checkout master b &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
-	test $old = $new && test $flag = 0
+	git checkout master -- three &&
+	read old new flag <.git/post-checkout.args &&
+	test $old = $new && test $flag = 0 &&
+	rm -f .git/post-checkout.args
 '
 
 if test "$(git config --bool core.filemode)" = true; then
 mkdir -p templates/hooks
-cat >templates/hooks/post-checkout <<'EOF'
-#!/bin/sh
-echo $@ > $GIT_DIR/post-checkout.args
+write_script templates/hooks/post-checkout <<-\EOF
+echo $@ >$GIT_DIR/post-checkout.args
 EOF
-chmod +x templates/hooks/post-checkout
 
 test_expect_success 'post-checkout hook is triggered by clone' '
 	git clone --template=templates . clone3 &&
-- 
2.20.1

