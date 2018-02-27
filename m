Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888711F576
	for <e@80x24.org>; Tue, 27 Feb 2018 08:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeB0IKj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 03:10:39 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:41826 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeB0IKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 03:10:39 -0500
Received: by mail-io0-f181.google.com with SMTP id q24so12949326ioh.8
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GEWeTIxPjqODnZS5sRO3Ngvbve7bhv+Y5KaXSm3VW5w=;
        b=ZZBr91XpAEJeDt+cszNEaYUR0NV2R57wKv3nFW56JX/xbUXKXmQHOnP2A991i6a3pu
         /Tv+MVcz3epdKVvoEyTe51I/gAK2X0OOebf9Xw8xBUCIKt8xrNgNFD14gNwZFgwG9cO6
         VE94KnuERhL0/jXyPZrwj0YAfmAZiVajCfxeDJcmXIk/DCq9E4gAacVw49RFvKb4NfAp
         701q/M1o2rAauSKS/EYWyB44z5tSNchH6T61b8GIUdDnKifVUr7C86KumS7zTJC9M/Bl
         wzPYfFDVXXlT9pRxTKkP2qNfWSDKS7h8SVYLeE3tX1dm0KBvgidaTYFKhmfoBa5u462o
         YxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GEWeTIxPjqODnZS5sRO3Ngvbve7bhv+Y5KaXSm3VW5w=;
        b=JEg1CxB099hbhh0De9pzkuTV1UJLl7qWJjefVCxdK1tyR2yqy5hLE4nkthkG6iYB6D
         jMtit5o57ekIRGickuDHY1m2cPYnDSI7dqE+wB39W9HFWZaiXeXG0sKqrcxW46/DLVIz
         8qSHFM1CYzOksekxRFNfC0bJCxLllBOhcdHhFFZ7dirTGlxWX5fa30J0t3HU2s0hWcYY
         s0N3wh6ITMzn1zrt0+FeZKLD9PHdzynQLy4MdmdlLBT30pks9xXU6YcQ84FZTgz7InSG
         BpiOCCxntlBSTecAUyDj/u6wuEvE8bAfheNG0dQYVIyhOex0kQCzx6ay3eWx9KO1FvYa
         THZw==
X-Gm-Message-State: APf1xPDP4wWi4oEGh8WjEfmdphxQwPOCuB2/Vxl58TBa7lJY0UL4Inxq
        vUMuJUd8unYtZwvRLG1P4EF46rmp
X-Google-Smtp-Source: AG47ELuaQSLv0mC4wyiZlukJw+BcsCnU4l7URUx4joK/xLugDbAixxUveSm2qJLC95PVEYwW9r/Gcg==
X-Received: by 10.107.9.65 with SMTP id j62mr15147288ioi.91.1519719037771;
        Tue, 27 Feb 2018 00:10:37 -0800 (PST)
Received: from jekeller-home.localdomain (50-39-161-65.bvtn.or.frontiernet.net. [50.39.161.65])
        by smtp.gmail.com with ESMTPSA id 189sm6816475iob.55.2018.02.27.00.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Feb 2018 00:10:36 -0800 (PST)
From:   Jacob Keller <jacob.keller@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] test case highlighting possible strategy to rebase merge
Date:   Tue, 27 Feb 2018 00:10:29 -0800
Message-Id: <1519719029-19141-1-git-send-email-jacob.keller@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test case highlighting how the process outlined by Sergey Organov
could be used to re-create merges without losing any context.

The test currently only uses new files, with the exception of one part
involving an evil merge. Unfortunately I'm not sure how to represent
merge conflicts that need to be handled. It looks like it should when
there is enough context that the changes don't have direct textual
conflict, but I was unable to figure out how to produce such a change
directly in the test case.

I think this method shows a lot of promise, and is worth investigating
more to see if we can actually make it work in practice without
requiring separate steps.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 t/t7900-rebasing-merge.sh | 178 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100755 t/t7900-rebasing-merge.sh

diff --git a/t/t7900-rebasing-merge.sh b/t/t7900-rebasing-merge.sh
new file mode 100755
index 0000000..7639425
--- /dev/null
+++ b/t/t7900-rebasing-merge.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+
+test_description='test showcasing safe method to rebase a merge'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo "file1" >a &&
+	echo "file2" >b &&
+	test_tick &&
+	git add a b &&
+	git commit -m "initial" &&
+	git branch initial &&
+	git branch branch1 &&
+	git branch branch2 &&
+	git checkout branch1 &&
+	test_tick &&
+	echo "a change in file1" >>a &&
+	git add a &&
+	git commit -m "commit1" &&
+	test_tick &&
+	echo "another change in file1" >>a &&
+	git add a &&
+	git commit -m "commit2" &&
+	git checkout branch2 &&
+	test_tick &&
+	echo "a change in file2" >>b &&
+	git add b &&
+	git commit -m "commit3" &&
+	git checkout -B simple-merge branch1 &&
+	git merge -m "simple merge branch2 into branch1" branch2 &&
+	cat >expected <<-\EOF &&
+	file1
+	a change in file1
+	another change in file1
+	EOF
+	test_cmp expected a &&
+	cat >expected <<-\EOF &&
+	file2
+	a change in file2
+	EOF
+	test_cmp expected b
+'
+
+test_expect_success 'trivial rebase case' '
+	git checkout -B new-initial initial &&
+	echo "newfile3" >c &&
+	test_tick &&
+	git add c &&
+	git commit -m "a new file" &&
+	git checkout -B new-branch1 branch1 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	git cherry-pick -m1 --keep-redundant-commits simple-merge &&
+	git checkout -B new-branch2 branch2 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	git cherry-pick -m2 --keep-redundant-commits simple-merge &&
+	git checkout -B rebased-simple-merge new-branch1 &&
+	git merge --no-ff -m "rebased simple merge new-branch2 into new-branch1" new-branch2 &&
+	git reset --soft HEAD^ &&
+	git update-ref refs/heads/rebased-simple-merge "$(git commit-tree -m "finalized rebased simple merge new-branch2 into new-branch1" "$(git write-tree)" -p "$(git rev-parse new-branch1^)" -p "$(git rev-parse new-branch2^)")" &&
+	git checkout rebased-simple-merge &&
+	cat >expected <<-\EOF &&
+	file1
+	a change in file1
+	another change in file1
+	EOF
+	test_cmp expected a &&
+	cat >expected <<-\EOF &&
+	file2
+	a change in file2
+	EOF
+	test_cmp expected b &&
+	cat >expected <<-\EOF &&
+	newfile3
+	EOF
+	test_cmp expected c
+'
+
+test_expect_success 'evil merge rebase case' '
+	git checkout -B evil-merge simple-merge &&
+	test_tick &&
+	echo "evil change to file2" >>b &&
+	git add b &&
+	git commit --amend -m "evil mergbe branch2 into branch1" &&
+	git checkout -B new-initial initial &&
+	echo "newfile3" >c &&
+	test_tick &&
+	git add c &&
+	git commit -m "a new file" &&
+	git checkout -B new-branch1 branch1 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	git cherry-pick -m1 --keep-redundant-commits evil-merge &&
+	git checkout -B new-branch2 branch2 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	git cherry-pick -m2 --keep-redundant-commits evil-merge &&
+	git checkout -B rebased-evil-merge new-branch1 &&
+	git merge --no-ff -m "rebased simple merge new-branch2 into new-branch1" new-branch2 &&
+	git reset --soft HEAD^ &&
+	git update-ref refs/heads/rebased-evil-merge "$(git commit-tree -m "finalized rebased simple merge new-branch2 into new-branch1" "$(git write-tree)" -p "$(git rev-parse new-branch1^)" -p "$(git rev-parse new-branch2^)")" &&
+	git checkout rebased-evil-merge &&
+	cat >expected <<-\EOF &&
+	file1
+	a change in file1
+	another change in file1
+	EOF
+	test_cmp expected a &&
+	cat >expected <<-\EOF &&
+	file2
+	a change in file2
+	evil change to file2
+	EOF
+	test_cmp expected b &&
+	cat >expected <<-\EOF &&
+	newfile3
+	EOF
+	test_cmp expected c
+'
+test_expect_success 'rebase add commit to branch1 case' '
+	git checkout -B new-initial initial &&
+	echo "newfile3" >c &&
+	test_tick &&
+	git add c &&
+	git commit -m "a new file" &&
+	git checkout -B new-branch1 branch1 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	cat >d <<-\EOF &&
+	rebasefile4
+	a new file added in rebase
+	EOF
+	git add d &&
+	git commit -m "a new commit added to branch1" &&
+	test_tick &&
+	git cherry-pick -m1 --keep-redundant-commits simple-merge &&
+	git checkout -B new-branch2 branch2 &&
+	test_tick &&
+	git rebase new-initial &&
+	test_tick &&
+	git cherry-pick -m2 --keep-redundant-commits simple-merge &&
+	git checkout -B rebased-add-commit-merge new-branch1 &&
+	git merge --no-ff -m "rebased add commit merge new-branch2 into new-branch1" new-branch2 &&
+	git reset --soft HEAD^ &&
+	git update-ref refs/heads/rebased-add-commit-merge "$(git commit-tree -m "finalized rebased add commit merge new-branch2 into new-branch1" "$(git write-tree)" -p "$(git rev-parse new-branch1^)" -p "$(git rev-parse new-branch2^)")" &&
+	git checkout rebased-add-commit-merge &&
+	cat >expected <<-\EOF &&
+	file1
+	a change in file1
+	another change in file1
+	EOF
+	test_cmp expected a &&
+	cat >expected <<-\EOF &&
+	file2
+	a change in file2
+	EOF
+	test_cmp expected b &&
+	cat >expected <<-\EOF &&
+	newfile3
+	EOF
+	test_cmp expected c &&
+	cat >expected <<-\EOF &&
+	rebasefile4
+	a new file added in rebase
+	EOF
+	test_cmp expected d
+'
+
+test_done
+
+
-- 
2.7.4

