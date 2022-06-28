Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBF4C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbiF1N2H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346450AbiF1N13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01EC3335E
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:03 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n1so17667161wrg.12
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5H1/BkGNzKZHdO7ThWj9L1t8uHwFXO4zO/yDHCP54Rw=;
        b=SilxFcIUqc9l2yJ+nHxNDYypWi06Sr5ji15AQHLz7P7Mu2OP+ojpsTFTTg2wIq1VlB
         e9LchsyEvP5OFe0+xq8V50HPojD7JiVH6VmR8FqXN0FJbIvcHxjLp2TRmLXRx8HlShdF
         l4i0N7WUEX1G8JqZx9v3O6+lz4SQ6Uh0VkLzquWgj4rhXJEOw43VAZeoJHEtuknRlPyQ
         nZDS0HBFVni1StdW843ir1iCrpjpqW75O9RyLn/mlrft/onqpvUiDQsWi1HFqsWxykAN
         kJXNSYZHba+v6COLfuTZFZ6K0hKO+yEd+Uz94KjJayuvmTLgkvJ4Hz7NMIjgMtxJgZTp
         Ht0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5H1/BkGNzKZHdO7ThWj9L1t8uHwFXO4zO/yDHCP54Rw=;
        b=cfo7N9FX4S4kdSuI86becn9NMzik4yyL4fuieWztw88d2ltZKUxLU7YdppY1WBhT3s
         fxtElnf6/eE2c+QB3Lm/0cgn4F46h6lib8WxVVKiV4nv9ZXQw6K7fTKn5uDZd+3LTGhk
         tD4zYnGtoYomjpLh0RP1RXY7wyLdqz5M7zPkyHCfe94+hDMBa9DoQsXNkg5fFXJfUYW4
         2/RQv0j1yWaice30YTKcfAwU+kaDPMhYkoQMdrV9LUKBIh8Tk1WHsbNbzytKBrc1VTsx
         KlnGdPOgjxzcIF+7ZzzCtnwlb1YoyKoSy23GrQEcvkJVY5a5MKz55qqXbZq6H/tJEF2M
         oLBA==
X-Gm-Message-State: AJIora9ZE5DgkVWz1Q8Q83jYWchptu3B/9HBHF38Q34XV8UlZz6N89qt
        p2opyU3cig0FNv4nIexIuKj5z6gWotOhow==
X-Google-Smtp-Source: AGRyM1uZYy87pJdagF81T5//YBqT3hdfJ710vV0oJr/eUaeE3kdWCTuPI8amIZg65rs6xxVbTvwHcw==
X-Received: by 2002:a5d:518f:0:b0:21b:8a8c:ce4 with SMTP id k15-20020a5d518f000000b0021b8a8c0ce4mr18200882wrv.614.1656422761921;
        Tue, 28 Jun 2022 06:26:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k19-20020a7bc413000000b003a02b135747sm17129003wmi.46.2022.06.28.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:01 -0700 (PDT)
Message-Id: <fbaedc7f1f02efec251cb4df665fd3cb71f1d3b3.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:52 +0000
Subject: [PATCH v3 1/8] t2407: test branches currently using apply backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The tests in t2407 that verify the branch_checked_out() helper in the
case of bisects and rebases were added by 9347303db89 (branch: check for
bisects and rebases, 2022-06-08). However, that commit failed to check
for rebases that are using the 'apply' backend.

Add a test that checks the apply backend. The implementation was already
correct here, but it is good to have regression tests before modifying
the implementation further.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t2407-worktree-heads.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index b6be42f74a2..4f59bc21303 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -54,7 +54,18 @@ test_expect_success 'refuse to overwrite: worktree in bisect' '
 	grep "cannot force update the branch '\''fake-2'\'' checked out at.*wt-4" err
 '
 
-test_expect_success 'refuse to overwrite: worktree in rebase' '
+test_expect_success 'refuse to overwrite: worktree in rebase (apply)' '
+	test_when_finished rm -rf .git/worktrees/wt-*/rebase-apply &&
+
+	mkdir -p .git/worktrees/wt-3/rebase-apply &&
+	echo refs/heads/fake-1 >.git/worktrees/wt-3/rebase-apply/head-name &&
+	echo refs/heads/fake-2 >.git/worktrees/wt-3/rebase-apply/onto &&
+
+	test_must_fail git branch -f fake-1 HEAD 2>err &&
+	grep "cannot force update the branch '\''fake-1'\'' checked out at.*wt-3" err
+'
+
+test_expect_success 'refuse to overwrite: worktree in rebase (merge)' '
 	test_when_finished rm -rf .git/worktrees/wt-*/rebase-merge &&
 
 	mkdir -p .git/worktrees/wt-3/rebase-merge &&
-- 
gitgitgadget

