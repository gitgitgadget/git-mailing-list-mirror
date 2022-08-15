Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F0C25B0E
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 15:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiHOPLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiHOPL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 11:11:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5DF13E88
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:27 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bv3so9416902wrb.5
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=gaLOdNNG0v0n0byAu9u0dJwUUSbbltut6YVDnKvnRxo=;
        b=pxPr4+lBiqfbGEGtCzXDy3ONPdtAZLkYZa3JOTS+sH9vquWCHTKwj6l9zSy6/mgtw/
         8FAxv/e/RYu6glw3vDTUW8AhaGD92uIm3pQdZw0Junx7ZY6a6QSGQKUky3R42lq6/gzd
         Crc3A9rdRm/Se/+Ueqbm3AX8MhCsKGCCsHIjNshbRF/UVfd7gtXKELKtF6G7dlb6xS4P
         Bpcd+fu3E4BuPmAy8tOo9eqhRwG3qx+ytZRoPXHaVAJuWwoRgIu+bo1ZPAi2oX/oGjQH
         DVWtFwGmAEtvBwjwoPqsJLfq7Eg1Qw0PhDN7ma7dnrYcQK00td4clmPT86H/UBYk7BIO
         r9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=gaLOdNNG0v0n0byAu9u0dJwUUSbbltut6YVDnKvnRxo=;
        b=d3D/+8lEqLA9FVcMSaYjE9XjKiNnX3//1uHJ0+qQsffb7dwPu7mv7vauQ1e6awTEc0
         6Vs7CPUiHEJmwpXSkKDf/faS6CrMkHK3YltVeGWicNydRrtWuWXPK2FEM52y4G9msKA4
         Py74kpN5bc822Lbrf62yeyZ6kMnqRYdCMHPqX0tx+q61oXn45wWT5cd+MoIMOqsiU7AT
         bdsQlRNrPbvbvbnboxuqaSc218Pjc3fpjpk17g4wkAFBAZQuO6pMxHTzRjEd5kIFOGk8
         x4G9DmwqYNBUZW0d6S1miUlHmOF1pPuCr/sz45uDiNnwxq8LzbTcY2ui37y51PqalZa9
         MABw==
X-Gm-Message-State: ACgBeo0zTeX7E5RTJtbajdVcu+HT5gwFJjzNPm9SapiCrna/wT3lFGLU
        L6+BbAtLitjMhW77ixWQXPwUJw8HUJA=
X-Google-Smtp-Source: AA6agR5HCdO3L/xXnMOnv3J1YvWquZvKugTXkiN05iYuJcUSUMLQe//J+ZV/sZROHCAC4MUOCqYpOQ==
X-Received: by 2002:a5d:5311:0:b0:224:f76e:ad6f with SMTP id e17-20020a5d5311000000b00224f76ead6fmr5446783wrv.54.1660576285842;
        Mon, 15 Aug 2022 08:11:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0a4700b003a5de95b105sm10571376wmq.41.2022.08.15.08.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:11:25 -0700 (PDT)
Message-Id: <c1d91a2b190c6ea4550e33260a48a51cd0653a21.1660576283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 15:11:19 +0000
Subject: [PATCH 1/5] t3416: set $EDITOR in subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As $EDITOR is exported setting it in one test affects all subsequent
tests. Avoid this by always setting it in a subshell and remove a
couple of unnecessary call to set_fake_editor.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 3e04802cb00..e1fc2dbd48e 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -79,8 +79,10 @@ test_expect_success 'rebase -i --onto main...topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main...topic F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main...topic F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -90,8 +92,10 @@ test_expect_success 'rebase -i --onto main...' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main... F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main... F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -102,7 +106,6 @@ test_expect_success 'rebase -i --onto main...side' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --onto main...side J
 '
 
@@ -156,8 +159,10 @@ test_expect_success 'rebase -i --keep-base main from topic' '
 	git checkout topic &&
 	git reset --hard G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -171,8 +176,10 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
 	git checkout main &&
 	git branch -f topic G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main topic &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main topic
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -187,8 +194,12 @@ test_expect_success 'rebase -i --keep-base main from side' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --keep-base main
 '
 
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget

