Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497FC433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 20:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378534AbhLDUD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 15:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355813AbhLDUDx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 15:03:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70598C0611F7
        for <git@vger.kernel.org>; Sat,  4 Dec 2021 12:00:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so13385426wrb.2
        for <git@vger.kernel.org>; Sat, 04 Dec 2021 12:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zJiKSk3jn17B2YS9f23vblDHHajI/cQ+P5TWEQ6r3a0=;
        b=iSQT1YQ+SFeg6gJ8j1UTenPu4e1wPaRDrrZewdCnE/sbzSa5txtDT9cICA/QAfx5iy
         vYd+YuoSQCxl1p0PEkoW5WdWUJFrjVnr1zUYYpujZ0UhL7+trWkpZacAXBXfrk1vG1Bp
         77TDHYGKuw6F9BIYtPLfz7A3AvF8TTGAjPDQdf9g8P+VqgSY66qciDgpGCppJaSTnGUn
         syA9YkDdAg9GLhkYJ5f2G7+x+NhraZgDJQeb4/rljUXLPxLCtnm/JUvKygVgpLpXT9/O
         3ZRMqpyIsmrjDbCr0RF/Yms+tFU6n3vmRIrDXEKZ6GEmJjNiSbnMkAnJkNs9ePwpb6YF
         8S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zJiKSk3jn17B2YS9f23vblDHHajI/cQ+P5TWEQ6r3a0=;
        b=DAJ6AUiHTEfac8jmryF3+awmRgNk6uoWM0pbmWtMwIILG4u62TtCAW7x/0dUqf+pKM
         IBeSJH4yGSpZJVUTj/yX2IpEhMgkOSffRoubUn9hcd9u/GiA2zvFYJ00VFZBy1P4tElI
         QKNhlY39LVamU1TFX2K3Q2Wha8KwU9dqmeeBq76ROOcrkemBHpwrQU29jLXOFTsEL91R
         Y/QsaXCuoER81q88JUKenMRo/Jg/KEJRQq9L7sc4oytQIPr3lF7keBXw6TrpPocfeEXj
         jwq3vCftmb8K3SVJDoXuSCOzTypCofCZYysK82II3xgDQaVYJu/ppfs2r+S8o3qfWYhW
         FSEg==
X-Gm-Message-State: AOAM533C70lJS4vZNlPDN0D8xpNR3ZE0ejzOhnIzjYt5WWh6dhHcmX97
        GdPbpN3gviVCG+nvIo/3jh+R+R6M73E=
X-Google-Smtp-Source: ABdhPJyegG/GpiGV1StQnHKs0aNcIOUihcCAFMxU7ynN+ox2EBXu/iZO0DrEn7/QTdyrDkGDVAPldA==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr29581301wru.384.1638648025877;
        Sat, 04 Dec 2021 12:00:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7sm8629291wrg.31.2021.12.04.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 12:00:25 -0800 (PST)
Message-Id: <9d455f1fb518140dc98430dde7561cbf36642322.1638648020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Dec 2021 20:00:19 +0000
Subject: [PATCH 5/6] Documentation: clarify/correct a few sparsity related
 statements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

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
index d22c925ecf8..73e7645b77a 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -115,7 +115,7 @@ SPARSE CHECKOUT
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
 Git whether a file in the working directory is worth looking at. If
 the skip-worktree bit is set, then the file is ignored in the working
-directory. Git will not populate the contents of those files, which
+directory. Git will avoid populating the contents of those files, which
 makes a sparse checkout helpful when working in a repository with many
 files, but only a few are important to the current user.
 
-- 
gitgitgadget

