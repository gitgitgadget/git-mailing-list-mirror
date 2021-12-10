Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09ADC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 03:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhLJEAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbhLJD75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 22:59:57 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B13AC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 19:56:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d24so13029167wra.0
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 19:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5VRL/COZrrE2C/RlI8KN2PlRId4Ot6isrchZ2ZL3zR4=;
        b=gvsG+/adBlRkDwiA3YyEZ2poDKZfFzo+hU+dlJZkVF4aqstvmSeXVeDxea4atzVaBk
         iIZwh3BKtolm+Xe0VmPRmPxKR4ngAEOfdROH0BxI7t9D+B7KZ7UFQUys0YFH26CUttDi
         CJHC/PucIzOh/GIC6tErMYC5i35n7wdD4mhrDSZjUixqfByPuGf7r9dyP7QiLBBvLFdW
         vjp0tolILwPWH700IS2MRfi6otWPLX8PMaxUGpUg7bXWm93IYsL/0gGAQ3iBPJsptRq9
         Y1w/+48eveJzmMnMRJPvGGEa6201VBEEEBK2H7sBHd4iMbNM2bnUbPUxROc6+XtfToEy
         tBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5VRL/COZrrE2C/RlI8KN2PlRId4Ot6isrchZ2ZL3zR4=;
        b=ggU2E+QlvTC2Qlg9gIXH03653BhgbhchfV1ULBoKh+RYn6FuuKE4gbnPfTP64JKUHe
         +1767XRNgCNetaiACBnezLiGDU+5v55C+fdttoCx+6Ev8ehPA31whqloM3aiiazibYTU
         wcgnEuAxzZnKO+/FHCwByDHQF7oyllL0kL9qM4dY5t+s4/0oUSAghm6d0dul9g2J/M5Y
         UzrKQHxo+StmQM++E584oPX7sr3V2wsZQMJO8z5paDIOhbMnyzCXVwuXrrzlMIeEtXSL
         ZZyY0TCM8CI5i4FxYMnhr3EAlV0wE2HNFhgqhIbfmCyFm2C2QpRp46XQ1Stkn3ULS+k4
         S4yA==
X-Gm-Message-State: AOAM531fB/2qg5x7KWMTCbE7m9kxViSbWCKzDLgFGatyaKJc8wF8ATiI
        yi41ax238hYfz3NtH0CwpFoO3XR1XqE=
X-Google-Smtp-Source: ABdhPJwWoZ3kZXtOe1CfwsxmFCdVYjBps84pCsWP/ah7HKR9vKmRoJgOjxR/ULVb3vOaE3/cDoMJOg==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr11113506wri.343.1639108580932;
        Thu, 09 Dec 2021 19:56:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm12045953wmq.34.2021.12.09.19.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:56:20 -0800 (PST)
Message-Id: <11a45920602981871582d11a79be9e95e33b8acc.1639108573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
        <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 03:56:12 +0000
Subject: [PATCH v3 09/10] Documentation: clarify/correct a few sparsity
 related statements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-clone.txt           | 8 ++++----
 Documentation/git-sparse-checkout.txt | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1ce..b348a71fc68 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -167,10 +167,10 @@ objects from the source repository into a pack in the cloned repository.
 	configuration variables are created.
 
 --sparse::
-	Initialize the sparse-checkout file so the working
-	directory starts with only the files in the root
-	of the repository. The sparse-checkout file can be
-	modified to grow the working directory as needed.
+	Employ a sparse-checkout, with only files in the toplevel
+	directory initially being present.  The
+	linkgit:git-sparse-checkout[1] command can be used to grow the
+	working directory as needed.
 
 --filter=<filter-spec>::
 	Use the partial clone feature and request that the server sends
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 72fcb6b2acc..9a4b43c105b 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -121,7 +121,7 @@ SPARSE CHECKOUT
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
 Git whether a file in the working directory is worth looking at. If
 the skip-worktree bit is set, then the file is ignored in the working
-directory. Git will not populate the contents of those files, which
+directory. Git will avoid populating the contents of those files, which
 makes a sparse checkout helpful when working in a repository with many
 files, but only a few are important to the current user.
 
-- 
gitgitgadget

