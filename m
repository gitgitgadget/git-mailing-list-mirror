Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B21C433EF
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 17:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 096CC6112F
	for <git@archiver.kernel.org>; Sat, 13 Nov 2021 17:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhKMRDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Nov 2021 12:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhKMRDd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Nov 2021 12:03:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00BC061766
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 09:00:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso12336360wmc.2
        for <git@vger.kernel.org>; Sat, 13 Nov 2021 09:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=S/Dq4YDnYmy1SHO+dodyfacojCXSs811xOZigQWR/Hg=;
        b=Y1fB2ke8U6QvnzcpDl6lHOGH6ALMcEj8IAshpdUPSdEYjTOjDC0tTBXPAH85doy1VC
         UAah/GknN4yMB574urwjjyUSIUHTphpx0ELb7FMECaITt7P/0QaPacihRyS2Y/iMwGti
         5tVmEqXZdyJE8WyBVb9wyuxHM5DiUjYcFSjFxCU+al1rDeSnAKSzr8MpXmQv30qms2E1
         lUVkNAEK7RRzl7vdSm1bvxRvJqxy/l4fYq7/UL8TW3uVRtSW3/aVeLlG2np/Ufnz0e9f
         DcIIK3DI/HBUQcMmn4WYbz3I7HRUbMOwH/wkoQlohWodmAQW8uPS+xgxsxB+XccxApYc
         OESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=S/Dq4YDnYmy1SHO+dodyfacojCXSs811xOZigQWR/Hg=;
        b=3tNG1D7tt2iAeBSLV/upP7t4bBLA/CHpVtni0SjT/UPjsublgzAF/Dmu2wITedPgVq
         DKH48+kTYr2we7q2X2yHHFYfaqBqOHdHS95qU2EC6sZzqN4dnVZPDnl60GCDtueFSKrA
         cA+Aflcnz+t0mkMTDd/+cRrVzbEXRG0i5ttLwP5L9dRZPb0Q9r3qXLK4/GVtXAh0cgSM
         xUhncA0iRnkZD8rnpFoKbmZwNZYgHb/LGiRrKISyI14S02D2IU5fDj6ETVnWze10rYYn
         Ll1ZUaPKSB/Vc+d2btotuugSDYgll2R7J61xKYhxeZOWfupNQ7rPfXxdtBUSx14NmSWl
         axIQ==
X-Gm-Message-State: AOAM531Plkf4z990xzcJzPwOQW2KkBnigEUsqEjhlnVI5qg2JQH6tMW9
        FwulfkNc7NMPuKyOMcj6rUPoWbn4UyI=
X-Google-Smtp-Source: ABdhPJzpfZrO5rTMOuqRPL4UrUYTvRZ2aO6yN9ZV3DTv7vX1JNmniNGngBgxg9aLvipTt+oxQDkGRA==
X-Received: by 2002:a7b:c756:: with SMTP id w22mr27793950wmk.34.1636822838596;
        Sat, 13 Nov 2021 09:00:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm9682062wru.21.2021.11.13.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 09:00:38 -0800 (PST)
Message-Id: <pull.1138.git.git.1636822837587.gitgitgadget@gmail.com>
From:   "hakre via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Nov 2021 17:00:37 +0000
Subject: [PATCH] ci(check-whitespace): update stale file top comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        hakre <hanskrentel@yahoo.de>, hakre <hanskrentel@yahoo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: hakre <hanskrentel@yahoo.de>

Part of these two recent commits

1. a066a90db6 (ci(check-whitespace): restrict to the intended commits,
   2021-07-15)
2. cc00362125 (ci(check-whitespace): stop requiring a read/write token,
   2021-07-15)

are well written messages that reflect the changes (compare: [1]).

Unfortunately those commits left the description in top file comments
unchanged which are still showing the previous picture.

To better display the current workflow upfront, those comments now
reflect that:

1. full (not shallow) clone to steadily check the intended commits
2. communicated result is the exit status (not a comment in the PR)

[1]: https://git-scm.com/docs/SubmittingPatches#describe-changes
CC: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: hakre <hanskrentel@yahoo.de>
---
    ci(check-whitespace): update stale file top comments
    
    Part of these two recent commits
    
     1. a066a90db6 (ci(check-whitespace): restrict to the intended commits,
        2021-07-15)
     2. cc00362125 (ci(check-whitespace): stop requiring a read/write token,
        2021-07-15)
    
    are well written messages that reflect the changes (compare: 1
    [https://git-scm.com/docs/SubmittingPatches#describe-changes]).
    
    Unfortunately those commits left the description in top file comments
    unchanged which are still showing the previous picture.
    
    To better display the current workflow upfront, those comments now
    reflect that:
    
     1. full (not shallow) clone to steadily check the intended commits
     2. communicated result is the exit status (not a comment in the PR)
    
    Signed-off-by: hakre hanskrentel@yahoo.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1138%2Fhakre%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1138/hakre/patch-1-v1
Pull-Request: https://github.com/git/git/pull/1138

 .github/workflows/check-whitespace.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 8c4358d805c..2dce03bc479 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -1,8 +1,8 @@
 name: check-whitespace
 
-# Get the repo with the commits(+1) in the series.
+# Get the repo with all commits to steady catch the series.
 # Process `git log --check` output to extract just the check errors.
-# Add a comment to the pull request with the check errors.
+# Give status 2 on check errors.
 
 on:
   pull_request:

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget
