Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA84FC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 07:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243345AbiCHHlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbiCHHk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 02:40:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461E939838
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 23:40:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so26967820wrg.11
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 23:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Fxlxj1FThT+VFVxtG0FmA74Pe0Of9J0GFbRj6Lqk2d8=;
        b=YbgHX7okOT+tiUevTa4142CeWu5vfsjnf7sVOFptV9OBqc4ZhkNykpIt1JZqLzN2M6
         lTOml9gvS1CIneiNQt7C/6Ej4VDlW6bMZJyftv8fULBqK4jjlt3BzmCLZdf3I4MqG8NX
         DZ97HrP9Vo5r2LtlVgCLrGfe7QLeEJ1MAXmFsZpRrFxQN3PwnvGqHE3bRr6rUFd/FQI1
         553XvoN/e8Q7pFvriqrZ364XjEtKYCT9vrwoXfeR55gXVEd2fwEhWol/3jSefY1OekJT
         raskbig/In5IrQuSy/X3G5BhFLL8XL/lnRg3ibVjHRYTIYO3zXXiwslHZYQBuU83qeuc
         DASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Fxlxj1FThT+VFVxtG0FmA74Pe0Of9J0GFbRj6Lqk2d8=;
        b=rMgKQFyXLymysuHiBEjPviJReC9MjuZH72+SfuAwtOH9JwjHV4eIHkin1i1h7Zy2Xn
         ++NDoh2MhyVVuh9GCsi++0OXQbKECgHUTHyGJSLiHhFnjwFBDIbKjmR2tzXvr8pcvBP8
         XpiORoORXfYzvCqKJcAEqxC2rbHSSHW0d++jreHx1X2uJeUhktXamvRDxH20cJC53pzJ
         KAI/IhFqsYJPqjrrfy4hvN28yqLKxDOeAWTsQBT6y88ToUBNgm1Cs5MS9fesW7Xbae2M
         f5wAZff/uef35+9EFbpTLEhNWwZW2jaO7FwcBwMnhuLVsUpSDXa9hzzQdb2r9C3O5qpK
         6dFQ==
X-Gm-Message-State: AOAM531Y7gfLm9y4TOBz7M2VNPH2/DKGdYn8tUkBf0ycYXBdUL/7Dj7U
        hG9bk71RaYNHRCfwLi6LAjXVLtxqCA0=
X-Google-Smtp-Source: ABdhPJzdMpvNxyj/Noxy1N5kQPVxLJ0+hsB3gGvEnuv900BvrLdBAA0dC+k+9aVNJGvXfHJpy2F0IQ==
X-Received: by 2002:a05:6000:11cc:b0:1f0:6492:761a with SMTP id i12-20020a05600011cc00b001f06492761amr10941508wrx.412.1646725198708;
        Mon, 07 Mar 2022 23:39:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f186-20020a1c38c3000000b00382a9b91515sm1364485wma.37.2022.03.07.23.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:39:58 -0800 (PST)
Message-Id: <e7d3ff70914e1ba4622c2cb6cd30453089e5a53f.1646725188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 07:39:48 +0000
Subject: [PATCH 9/9] Documentation: some sparsity wording clarifications
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Improve the wording for a couple paragraphs in two different manuals
relating to sparse behavior.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-read-tree.txt       |  9 +++++----
 Documentation/git-sparse-checkout.txt | 10 +++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 99bb387134d..cbafb1aed49 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -375,10 +375,11 @@ have finished your work-in-progress), attempt the merge again.
 SPARSE CHECKOUT
 ---------------
 
-Note: The `update-index` and `read-tree` primitives for supporting the
-skip-worktree bit predated the introduction of
-linkgit:git-sparse-checkout[1].  Users are encouraged to use
-`sparse-checkout` in preference to these low-level primitives.
+Note: The skip-worktree capabilities in linkgit:git-update-index[1]
+and `read-tree` predated the introduction of
+linkgit:git-sparse-checkout[1].  Users are encouraged to use the
+`sparse-checkout` command in preference to these plumbing commands for
+sparse-checkout/skip-worktree related needs.
 
 "Sparse checkout" allows populating the working directory sparsely.
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 11792187224..06f23660f63 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -15,11 +15,11 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-This command is used to create sparse checkouts, which means that it
-changes the working tree from having all tracked files present, to only
-have a subset of them.  It can also switch which subset of files are
-present, or undo and go back to having all tracked files present in the
-working copy.
+This command is used to create sparse checkouts, which change the
+working tree from having all tracked files present to only having a
+subset of those files.  It can also switch which subset of files are
+present, or undo and go back to having all tracked files present in
+the working copy.
 
 The subset of files is chosen by providing a list of directories in
 cone mode (the default), or by providing a list of patterns in
-- 
gitgitgadget
