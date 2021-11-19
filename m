Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A028BC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8135361AA2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhKSSxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 13:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSSxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 13:53:18 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF6C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:50:16 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so8243939wmz.2
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=PZhdtoH3XJSApLQ2hUQ6eeKZHi+Rzx0GILO8uDfkXUo=;
        b=dEPgU2N5RWJiysMSqgH38VIQQs+iMdF1AprbYLOhCKaJtifBcunnCy+TDy8u7ScMwn
         y9FhhjeJ6uwz4gfDmzG+Py+U80aYInE6rwOIrFTaNFPLsaGmbtD2NIP/iKr/i1j26V9g
         z2YNZug+DLyt6NDBQhINjTIvtb2BARxsTZCDDFKFqPlBuKWVHVgQSRqbtHuMuQwN5UNr
         sEFIhlLIQ7J1z/+vVPVZcnd5124LedZxTwTujm5jFAoYQWKg/0zoe2GUAXNoyEJieDEF
         tDUGoRk2UM+PPvp4gzQZh99wv92YRA0c/U3EaqxnBxu6IJ6jbbY4j8hk0SyhjbmvBZZJ
         GXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PZhdtoH3XJSApLQ2hUQ6eeKZHi+Rzx0GILO8uDfkXUo=;
        b=egEb0q1dNqYrKq8wSM2DJPyarc76uGkElgKiTHzE8NAVp8nVc/5QOD5Wle/V+krpel
         EZGh9cp901uFal97OjqoA9X5kyuWcZyL1LEHFItkQx+8ABeLQ3IddojcCIe5SEaXOlve
         e7+lU6HHjnXqu4EK8PGXf/GvXK6EcubgQa2eHy30Sv/vMZLgNdxQnyNSPaf0gXdDQOHT
         I5Xoowys+V+nK6av7oM//3BgwT6M0Xn+FePu/MuJ1C7B94U86945f+7B/P2pwVk859X2
         VBZeH7jkoUkLkJlVnjAIGp/lXc4ZaRUcd1zGAtyd6S79oKJOBr6TNoP8axbIs6a/ooCt
         hVbA==
X-Gm-Message-State: AOAM531G5OXkPVh7aAbUXwR5nC8taQ+3sEPgEqcBpuIMlFs97q9FXtnU
        JAJmFCYfDlrEvRVLP+yRU6iFXdCi0b8=
X-Google-Smtp-Source: ABdhPJw9gsWYZ+VHD/r5DVCu2yOVoWSgjZ/r8pUM9KqYBr2k6PT1Rgbyk/lLfUC+cbiM5aGKBSMKzg==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr2209379wmc.99.1637347814595;
        Fri, 19 Nov 2021 10:50:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm508077wru.51.2021.11.19.10.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:50:13 -0800 (PST)
Message-Id: <pull.1143.git.git.1637347813367.gitgitgadget@gmail.com>
From:   "hakre via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 18:50:13 +0000
Subject: [PATCH] ci(check-whitespace): update stale file top comments
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        hakre <hanskrentel@yahoo.de>, hakre <hanskrentel@yahoo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: hakre <hanskrentel@yahoo.de>

Earlier a066a90d (ci(check-whitespace): restrict to the intended
commits, 2021-07-14) changed the check-whitespace task to stop using a
shallow clone, and cc003621 (ci(check-whitespace): stop requiring a
read/write token, 2021-07-14) changed the way how the errors the task
discovered is signaled back to the user.

They however forgot to update the comment that outlines what is done in
the task. Correct them.

Signed-off-by: Hans Krentel (hakre) <hanskrentel@yahoo.de>
---
    ci(check-whitespace): update stale file top comments
    
    NOTE: In reference to
    https://lore.kernel.org/git/pull.1138.git.git.1636822837587.gitgitgadget@gmail.com
    as GitGitGadget had hiccups this is an update via a new PR on Github.
    Sorry for this added noise, this one supersedes the earlier one.
    
    Please find the actual (updated) description following (thanks to all
    helping hands involved):
    
    Earlier a066a90d (ci(check-whitespace): restrict to the intended
    commits, 2021-07-14) changed the check-whitespace task to stop using a
    shallow clone, and cc003621 (ci(check-whitespace): stop requiring a
    read/write token, 2021-07-14) changed the way how the errors the task
    discovered is signaled back to the user.
    
    They however forgot to update the comment that outlines what is done in
    the task. Correct them.
    
    Signed-off-by: Hans Krentel (hakre) hanskrentel@yahoo.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1143%2Fhakre%2Fpatch-1-gitgitgadget-vanilla-sky-technical-support-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1143/hakre/patch-1-gitgitgadget-vanilla-sky-technical-support-v1
Pull-Request: https://github.com/git/git/pull/1143

 .github/workflows/check-whitespace.yml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
index 8c4358d805c..ad3466ad16e 100644
--- a/.github/workflows/check-whitespace.yml
+++ b/.github/workflows/check-whitespace.yml
@@ -1,8 +1,9 @@
 name: check-whitespace
 
-# Get the repo with the commits(+1) in the series.
+# Get the repository with all commits to ensure that we can analyze
+# all of the commits contributed via the Pull Request.
 # Process `git log --check` output to extract just the check errors.
-# Add a comment to the pull request with the check errors.
+# Exit with failure upon white-space issues.
 
 on:
   pull_request:

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget
