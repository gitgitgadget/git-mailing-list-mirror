Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8A1C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIGOiD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIGOh6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:37:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F57697E
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:37:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e20so20687038wri.13
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=G3OLmWDCfCxJlg0OWgG2Cy81Hz+/s9c27v9c9GZ5qyfeXPqJDzKhyabACXgppMV6Ow
         0DI0MIyte8tZkiJ25C2+G0s1ApJ2VVJfWtmOZIqEyHJFD5olr/31srxeeZMCGKLDs7l1
         NRVJU7WDRbMAveRHRfX0WZpCZ2TTummtcIpXim+XFiP/UuHTVwB7nKHdQG+NIzF1bnph
         xCMPmZd6pnqr+dKHQ54SB95SWaB4lWXrqwDrnCvVuKBkw///zmQHnwl/ZJ3PlXkRzBpk
         naKw8X7SQteqV7xtA2/eGX0SKVugqTw9ZbQvNYgDU1SrC8tjnrrCUomORN5v8VA9yfWf
         bOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=AvfvMKPO/EYkSLbNnB0AHkRvURkOzv+qqzmg4tQNhn3JZRPFoLmLh3P3VGgxJxhaH1
         QchMRsviiqigecZSloRs4pGIDW42UYXOsFVf15mH2kBFliNUcZhIc0tMp5IJmvODutzn
         hbKnSF8ovx5PfLgqhvi0/k6TuMHgTBmYnSsWWkqgd6G8VIduJQjB3lSwo7AwDbIy7pOD
         ZJWC6OZeRFzAIcA9liz/n9QEtuzaDxaMVHEXfmBSCHiRDYFskkQL+vzU/YPXOBj6810J
         VLr5Ggv15No2b8qOdBnIjQuM1C1YiH4vKEaBm4uvdEDero7b7ltPTX5dJo5I8rjhsuJ/
         BL1Q==
X-Gm-Message-State: ACgBeo3ibflprG+9+Og/6H7+O7A0wrGErhLX3rAcE1e6l9CMqfn/wqEE
        QmZrerk9BfCL3OsHRJE8OAkdgk6tThE=
X-Google-Smtp-Source: AA6agR4uxz2U6frj6TDNZDyw5SHNfN5IhT/FERgAoXkK+nla1UsrA23ZBOVWH3eD+2Zg9lEugbyBbw==
X-Received: by 2002:adf:d088:0:b0:228:a789:ce1f with SMTP id y8-20020adfd088000000b00228a789ce1fmr2245625wrh.461.1662561475134;
        Wed, 07 Sep 2022 07:37:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c3acd00b003a643ac2b08sm18388607wms.8.2022.09.07.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:37:54 -0700 (PDT)
Message-Id: <d6f2f716c77cbd0a19b3b6032f69f6dd9b257e96.1662561470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 14:37:45 +0000
Subject: [PATCH v2 2/7] t3416: set $EDITOR in subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As $EDITOR is exported, setting it in one test affects all subsequent
tests. Avoid this by always setting it in a subshell. Also remove a
couple of unnecessary call to set_fake_editor where the editor does
not change the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index dc67d2308f3..01eb9513d6c 100755
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
@@ -102,7 +106,6 @@ test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --onto main...side J 2>err &&
 	grep "need exactly one merge base" err
 '
@@ -157,8 +160,10 @@ test_expect_success 'rebase -i --keep-base main from topic' '
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
@@ -172,8 +177,10 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
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
@@ -188,9 +195,13 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --keep-base main 2>err &&
 	grep "need exactly one merge base with branch" err
 '
 
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget

