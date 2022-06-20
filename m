Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88ABC43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 04:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiFTEBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiFTEBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 00:01:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916946325
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 21:01:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q15so5087222wmj.2
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 21:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ut9jmlHNQR3+pZS0PWJoI073wbhyOQpZ9PK1PKpbaRE=;
        b=RN2j7W4QfRTYJwI67r/+dbqhJZQhQnW6S0cnwxGyo6J0rhhwMuUarubCenHVZwF6x0
         OFxKJoakbbH4a/dV/KIVIOYD31VhLWwmh1BeW5Pd4V7nfiqFIqJJJ4hDoXVU4M/cGKLo
         DW9q+1L/WJck4oq1T8D/MA0nqEt+xlctYBGzMKQ/76Y7I5HQAUJHijp4kY1/3TqYw6lh
         USPWytJ4uzxAdlYIWcvD5kcq5qy9PMNW6xalzk8nFMGNPbrLck32cU24RvMqQQaL0OYH
         FBdLAZ7jaBf11wUbGe24zpiXPjAIkQr4F4L64tFvovYpTLXfL+WCkrS3JUQDTJzuiEYd
         F7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ut9jmlHNQR3+pZS0PWJoI073wbhyOQpZ9PK1PKpbaRE=;
        b=kZYY7xfB9e9AK/V4Mx9MRF7crzoF9R55ae564ttdzn2O+U2ck3xvyn+PqopuEtamdD
         MDffRtDhkm3rgL4jVJz0zZmu1Xg5V2VkR0qATe/sSn4ZXkX5E7JokU+EPANjdPykjbAf
         EsnldMC1pa81kwVH0jstAyRVM+0HTCVXWODO0Lci40hAGdN9MVViNVFNEs0NX17F7eFT
         9naaTJ73+pxcl1VVWmBtjMokGf9y2nXnq3x15k7MZyzngijV6YOoRbwQFWzETG763Jr1
         svG7p6JwYuDtC0EyDo0jMvbEtrLoeyKXHHUnRZiJZhJc5XYO7vQbE3IeUIEYUrFLVbY6
         t6pw==
X-Gm-Message-State: AOAM530ooxeyY+d6rV3HgPKSoHda1JTNDDCZXF1oGiSBlklRTZ3DFXZG
        7N6Y1KnwQOdxy0IG68mgHp2oxq3mL85M9A==
X-Google-Smtp-Source: ABdhPJx7tOBHsfdHXYoxmkvjiEUEpKtv+of8LTb/ep1hjtFH4irCoeA4ZE6fOqvSGl1Jiau2kQU5OQ==
X-Received: by 2002:a05:600c:5021:b0:39c:6571:e0b0 with SMTP id n33-20020a05600c502100b0039c6571e0b0mr33597690wmr.177.1655697675407;
        Sun, 19 Jun 2022 21:01:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h204-20020a1c21d5000000b0039c693a54ecsm17104451wmh.23.2022.06.19.21.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 21:01:13 -0700 (PDT)
Message-Id: <pull.1265.git.1655697671724.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 04:01:11 +0000
Subject: [PATCH] rev-parse: documentation adjustment - mention remote tracking
 with @{u}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The documentation explained the conversion from remote branch path to
local tracking ref path for @{push}, but not for @{upstream}.

Add the note to @{upstream}, and reference it in @{push} to avoid undue
repetition.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    rev-parse: documentation adjustment - mention remote tracking with @{u}
    
    Small clarification in the doc for git rev-parse.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1265%2FTaoK%2Ftao-upstreak-doc-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1265/TaoK/tao-upstreak-doc-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1265

 Documentation/revisions.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index f5f17b65a12..33809036f04 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -97,18 +97,19 @@ some output processing may assume ref names in UTF-8.
 
 '[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
-  refers to the branch that the branch specified by branchname is set to build on
-  top of (configured with `branch.<name>.remote` and
-  `branch.<name>.merge`).  A missing branchname defaults to the
-  current one. These suffixes are also accepted when spelled in uppercase, and
-  they mean the same thing no matter the case.
+  refers to the remote branch that the branch specified by branchname
+  is set to build on top of (configured with `branch.<name>.remote` and
+  `branch.<name>.merge`). As `branch.<name>.merge` is the branch path on the
+  remote, it is first converted to a local tracking branch (i.e., something in
+  `refs/remotes/`). A missing branchname defaults to the current one. These
+  suffixes are also accepted when spelled in uppercase, and they mean the same
+  thing no matter the case.
 
 '[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
-  `HEAD` if no branchname is specified). Since our push destination is
-  in a remote repository, of course, we report the local tracking branch
-  that corresponds to that branch (i.e., something in `refs/remotes/`).
+  `HEAD` if no branchname is specified). Like for '@\{upstream\}', we report
+  the local tracking branch that corresponds to that remote branch.
 +
 Here's an example to make it more clear:
 +

base-commit: 5b71c59bc3b9365075e2a175aa7b6f2b0c84ce44
-- 
gitgitgadget
