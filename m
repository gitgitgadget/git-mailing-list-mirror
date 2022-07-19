Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2AC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiGSSdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGSSdu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:33:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A015A2DF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id id17so2388217wmb.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2UUSkn8ScIFAe2WU+SPqQszPoZhEEitNoSzZ6/SYFg=;
        b=YPl1Uvj3UmQ+AwJpAya5+sALMBd9uSzRld2Z6zQnOWZNJ48E0TZZD10DbBaAStlp8a
         Dk/4jDV6c2TPRU9ota6wxo853aPuSJau5IIR5M7yVUip2NDjsQjGwErrA9PPgIrmUNJg
         e0Jp3XLhhkYKQtpq+w8XYFb/xHZS7H9IgHQWO1rAmW5qxshbk2tGutglaC0Hbc9DkJCF
         6qXw5BQHm0zej7z0RMTpp2cQjeRUUG5Ew2zHb7dlknRhDRIH+swqS1TPm0nGAv0FKcni
         Y2JTpXt18OKacfK9KgdPWICgjDV3m9juXzrLjUd88BglDQ7oqU+7n4rL6UeMZKxlKaVl
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2UUSkn8ScIFAe2WU+SPqQszPoZhEEitNoSzZ6/SYFg=;
        b=xWNwvBRmRnRkVOIXjXrsF9U7VSTXK5ypqEO5q/KqQFYo9rZwJjRPn9mgdnfgMHAEpU
         Vsm4XSMBuDRs/vgKVTGGhaDoP/qYor8vJ1J61Oy9eJ4psvkmUruaumQ5xiFASdpwfXwI
         yesEI12LyPNSqC+uTfwe+3o3WDz7IV72MuszqAElVkdV8ptfn/lkwPe3LfuzzkBgDVRf
         6/UqnOmBv0cv3RxqmBxj4rbPT32yh5Dg3Fna/3CgOiOZmhRuQun0aK5nlc4PHhQ/JXWC
         FJT1V0W9RGLBEIOdhr7LRMYIMziCsRSHdIFLQW1/Dkxf0BTgnUFoqw9IKTGXeunOUIZC
         xEgg==
X-Gm-Message-State: AJIora9oPi/JEH0eVyJcyT9iJr24Rq8rzhsQSdNe9Fk7ZoBY6ECbXVSb
        tHcm2FnmurWO2aAmZl0DWHJZonLURUA=
X-Google-Smtp-Source: AGRyM1vuzI+StEiFX7pWQfj6PVYfZW1yeue4i2BNMPKQWpAqaicdZQqBRw+3hmou3gWi17kjPlv8Fw==
X-Received: by 2002:a05:600c:892:b0:3a2:fb4c:2381 with SMTP id l18-20020a05600c089200b003a2fb4c2381mr561386wmp.89.1658255627824;
        Tue, 19 Jul 2022 11:33:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4337401wms.3.2022.07.19.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:46 -0700 (PDT)
Message-Id: <9e53a27017ac18eefef2c077a905efecab07861d.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:33 +0000
Subject: [PATCH v5 01/12] t2407: test bisect and rebase as black-boxes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The tests added by d2ba271aad0 (branch: check for bisects and rebases,
2022-06-14) modified hidden state to verify the branch_checked_out()
helper. While this indeed checks that the method implementation is _as
designed_, it doesn't show that it is _correct_. Specifically, if 'git
bisect' or 'git rebase' change their back-end for preserving refs, then
these tests do not demonstrate that drift as a bug in
branch_checked_out().

Modify the tests in t2407 to actually rely on a paused bisect or rebase.
This requires adding the !SANITIZE_LEAK prereq for tests using those
builtins. The logic is still tested for leaks in the final test which
does set up that back-end directly for an error state that should not be
possible using Git commands.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2407-worktree-heads.sh | 57 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index b6be42f74a2..100ab286d5c 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -7,13 +7,18 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup' '
 	test_commit init &&
-	git branch -f fake-1 &&
-	git branch -f fake-2 &&
 
 	for i in 1 2 3 4
 	do
+		git checkout -b conflict-$i &&
+		echo "not I" >$i.t &&
+		git add $i.t &&
+		git commit -m "will conflict" &&
+
+		git checkout - &&
 		test_commit $i &&
 		git branch wt-$i &&
+		git branch fake-$i &&
 		git worktree add wt-$i wt-$i || return 1
 	done &&
 
@@ -44,26 +49,26 @@ test_expect_success 'refuse to overwrite: checked out in worktree' '
 	done
 '
 
-test_expect_success 'refuse to overwrite: worktree in bisect' '
-	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
+	test_when_finished git -C wt-4 bisect reset &&
 
-	touch .git/worktrees/wt-4/BISECT_LOG &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+	# Set up a bisect so HEAD no longer points to wt-4.
+	git -C wt-4 bisect start &&
+	git -C wt-4 bisect bad wt-4 &&
+	git -C wt-4 bisect good wt-1 &&
 
-	test_must_fail git branch -f fake-2 HEAD 2>err &&
-	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
+	test_must_fail git branch -f wt-4 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
 '
 
-test_expect_success 'refuse to overwrite: worktree in rebase' '
-	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase' '
+	test_when_finished git -C wt-2 rebase --abort &&
 
-	mkdir -p .git/worktrees/wt-3/rebase-merge &&
-	touch .git/worktrees/wt-3/rebase-merge/interactive &&
-	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-merge/head-name &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-merge/onto &&
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-2 rebase conflict-2 &&
 
-	test_must_fail git branch -f fake-1 HEAD 2>err &&
-	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
+	test_must_fail git branch -f wt-2 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
@@ -77,24 +82,24 @@ test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: checked out' '
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in bisect' '
-	test_when_finished rm -rf .git/worktrees/wt-*/BISECT_* &&
+	test_when_finished git -C wt-4 bisect reset &&
 
-	touch .git/worktrees/wt-4/BISECT_LOG &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/BISECT_START &&
+	# Set up a bisect so HEAD no longer points to wt-4.
+	git -C wt-4 bisect start &&
+	git -C wt-4 bisect bad wt-4 &&
+	git -C wt-4 bisect good wt-1 &&
 
-	test_must_fail git fetch server +refs/heads/fake-2:refs/heads/fake-2 2>err &&
+	test_must_fail git fetch server +refs/heads/wt-4:refs/heads/wt-4 2>err &&
 	grep "refusing to fetch into branch" err
 '
 
 test_expect_success !SANITIZE_LEAK 'refuse to fetch over ref: worktree in rebase' '
-	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
+	test_when_finished git -C wt-3 rebase --abort &&
 
-	mkdir -p .git/worktrees/wt-4/rebase-merge &&
-	touch .git/worktrees/wt-4/rebase-merge/interactive &&
-	echo refs/heads/fake-1 >.git/worktrees/wt-4/rebase-merge/head-name &&
-	echo refs/heads/fake-2 >.git/worktrees/wt-4/rebase-merge/onto &&
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-3 rebase conflict-3 &&
 
-	test_must_fail git fetch server +refs/heads/fake-1:refs/heads/fake-1 2>err &&
+	test_must_fail git fetch server +refs/heads/wt-3:refs/heads/wt-3 2>err &&
 	grep "refusing to fetch into branch" err
 '
 
-- 
gitgitgadget

