Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33D7C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 13:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiGLNHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiGLNHO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:07:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A2B41BB
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so4938305wrv.4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2uRRWueLbS1MmS8wlJxUl94o4kalllPCtK153o7kM6c=;
        b=OZpEKTbTmHhiJs3e/4Wb8pw3/reHslTgjO6Ll8wtm2w41gILvxfcCxZl9vwm9gCEor
         Ap3/iuaam9x1S2haFwYuE8Rv5Th5DOk6Bz50Rr7ja1GEtbPq3kwCyE1AC8tGZ27mFRBL
         z4t4vfzJnwlMNv/YtqWpnKwpT886cJrtbBLjluMdm2mMhHYTQV8mXhWUwgnNutkCZwF0
         7k5lj2yEr91gI+UUbZkSLhPq6VCAMWYeloZEyYUjKE3Nh6afcl8ANddlz6T6gUGyBL5v
         LyX7zPm/z5+p6yXw52Y0YjKW+O2fr4DV8c7J4lXFmw03SbtwlKieF6cEQn78PbogLlyb
         B4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2uRRWueLbS1MmS8wlJxUl94o4kalllPCtK153o7kM6c=;
        b=H7ViyeQbFHV0Cn8F/zPOWMTFBKq0cQSJRVoEy4KisC1cIzvG4XemuSH3jEv3QF4yc1
         w3wLbyO8L+ScuEoqcLliJdhZD8NTcKuYorXdADQ7msrB1VAMutaLD50jURNy2uCo6124
         KO861HwC9KEt0pAcFt5CkgVbWb6e13DIKegvAEnFxPqzeb+W+1tk5Bw73Y0PaN9weDgY
         U8/9H1yBoSi9FLgP/NESmQ/ZYZScNg8rYBTcJAf31uCUpnM2ppLMZNG7S8fXZgaTW9v+
         DX71zGN6f2t2yVt/JS9NcNSI74W2I30/tz7gYbul7dAA7P+/1gwjrpEEaU2g6KM9JL8t
         DQ+g==
X-Gm-Message-State: AJIora+pvJzM0tV/tw6KpcB5oFDkGj88r1IXo1NtwBRbAN5FizsYUmhB
        glZs+1QKeQ4gaUEVGnn9BIKdnx43Rf8=
X-Google-Smtp-Source: AGRyM1ulUpPGmPHktoDO0acf9avutGvulSbf6ZXiA76fj14Ncii7d0lVZYctmabcG63d6fvVjRhx7g==
X-Received: by 2002:a05:6000:88:b0:21d:691c:38d5 with SMTP id m8-20020a056000008800b0021d691c38d5mr22297205wrx.450.1657631231470;
        Tue, 12 Jul 2022 06:07:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c3ba100b0039c5cecf206sm9521566wms.4.2022.07.12.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 06:07:10 -0700 (PDT)
Message-Id: <540a3be256f8a0ca57ae0ed90cc04190a28e91e1.1657631226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 Jul 2022 13:06:55 +0000
Subject: [PATCH v4 02/12] t2407: test branches currently using apply backend
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
 t/t2407-worktree-heads.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 100ab286d5c..a67ce5fb003 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -61,7 +61,17 @@ test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in bisect' '
 	grep "cannot force update the branch '\''wt-4'\'' checked out at.*wt-4" err
 '
 
-test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase' '
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (apply)' '
+	test_when_finished git -C wt-2 rebase --abort &&
+
+	# This will fail part-way through due to a conflict.
+	test_must_fail git -C wt-2 rebase --apply conflict-2 &&
+
+	test_must_fail git branch -f wt-2 HEAD 2>err &&
+	grep "cannot force update the branch '\''wt-2'\'' checked out at.*wt-2" err
+'
+
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite: worktree in rebase (merge)' '
 	test_when_finished git -C wt-2 rebase --abort &&
 
 	# This will fail part-way through due to a conflict.
-- 
gitgitgadget

