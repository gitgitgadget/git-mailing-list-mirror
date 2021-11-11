Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F987C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E42B6135E
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhKKR6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhKKR6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:58:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C54C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:55:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4988052wmz.2
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JaAO+ghn5WGoH7DgvuHxLhsRkWsdpi3vsY85ahZT9lU=;
        b=KPVSNbUGqwVZw2HbBbDA2+JO1elrmM4aXinMJK2B6m4vqkam1dTB1I//rMxj+hewB5
         G23cI3xtUpbzM/tRvYFmlAk/F9psbDx3ZiNpvmHur8gf1FfdC8BSziXJT141soo1/7oY
         M4DXGu9gmSNTSb3+9uHMxpR2d9SejUaVqZeIT63EIfA/kvvIfpiCud0TSY8YZEb/PtPo
         r7G2kyJwYVrt1k3IdMg2u0XqjJSktWQyP4+KiG2jemMmATW5wk5Ak1wMh6kAmyssjMPy
         BY4GYzUPalIVh1z8C2Orrqn11V/CoxDw0XTiNfzgy4UOX77Zx4MXILBbnWW9hJ24sb80
         gaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JaAO+ghn5WGoH7DgvuHxLhsRkWsdpi3vsY85ahZT9lU=;
        b=zovTc4xXiPRswiKm8j5FgBRZ/j7XD5KEVp7MCOjlMWGBsuYhRwlKsdWwJfImA39bvj
         PEqNsPwzatSiVtvSfgb/6rww4b9kY5WOJDNdJbt/2zUu4dKBMZyBHs6+v1y0MElnDSQH
         uvKuRoeVsHQwoYwGW358WmJIcxiHGpf53d4FXVJcG0OorJp9UYQfHb86CWgiBBiRtZwM
         qHLQcg62jCfia40HYHUi72MI+T5K/THOtMRFSK2ad14+F9Z/xma9lwqH/adLD7Ijm85x
         3kJa643vU/O0id1viB/2/3In19L683yR2JyxTEll10Hk+HM7Ttm/tBJXnqddH107Tpeu
         BtDQ==
X-Gm-Message-State: AOAM531iHodGyKgxkOwLYLs4tPMvl7YuxcxAqMRpNZuWY2gRUfJjPSNt
        iGK3MiJkd4bCiGuNE7txCicb+qNOwVc=
X-Google-Smtp-Source: ABdhPJyTSnRR9hCAHv49YHca3EGkf1H+mSe+thoFg0uxs8XMGnxoog0LwvOB8/m91DU4QqY7Y2EOLQ==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr10042086wmr.159.1636653332239;
        Thu, 11 Nov 2021 09:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm4500042wmg.30.2021.11.11.09.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 09:55:31 -0800 (PST)
Message-Id: <pull.1127.v2.git.git.1636653331034.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
References: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
From:   "Samuel Yvon via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Nov 2021 17:55:30 +0000
Subject: [PATCH v2] builtin-commit: re-read file index before run_status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Samuel Yvon <samuelyvon9@gmail.com>,
        Samuel Yvon <samuelyvon9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Samuel Yvon <samuelyvon9@gmail.com>

Changes made within a pre-commit hook are not reflected within
the editor (for instance, with `git commit --verbose`) because
the index is re-read after the status has been written.

This has the consequence of not displaying the actual changes made
by the pre-commit hook, but committing them anyways.

While it is often argued that the hook's purpose is not to automatically
write content to the repository, it is acknowledged that using the
pre-commit to apply mechanical fixes on top of the existing changes
is a supported use case, along with verifying the content.

I think not seeing these mechanical fixes before commiting is incorrect.
A developer might expect the commit to look a certain way but if the
pre-commit goes wrong the invalid changes will go unnoticed until
committed.

The comment suggesting that the cache must be reset after run_status
and before the editor being launched was added in ec84bd00,
(git-commit: Refactor creation of log message., 2008-02-05). It is
unclear why the run_status must be called *after* the cache reset.
However, calling run_status after the cache reset does not update
the status line to state of the current index in the case a
pre-commit hook is ran and changes files in the staging area.

Signed-off-by: Samuel Yvon <samuelyvon9@gmail.com>
---
    builtin-commit: re-read file index before run_status
    
    Changes made within a pre-commit hook are not reflected within the
    editor (for instance, with git commit --verbose) because the index is
    re-read after the editor has been used.
    
    This has the consequence of not displaying the actual changes made by
    the pre-commit hook, but committing them anyways.
    
    While it is often argued that the hook's purpose is not to automatically
    write content to the repository, it is acknowledged that using the
    pre-commit to apply mechanical fixes on top of the existing changes is a
    supported use case, along with verifying the content.
    
    I think not seeing these mechanical fixes before commiting is incorrect.
    A developer might expect the commit to look a certain way but if the
    pre-commit goes wrong the invalid changes will go unnoticed until
    committed.
    
    I had a small exchange in the Google Group before submitting this Pr.
    Here is a link for cross-referencing:
    https://groups.google.com/g/git-mentoring/c/FsP83I9mN6c
    
    As a side note, I do not know who manages the Github Repo but the
    following description threw me off a little bit:
    
    Git Source Code Mirror - This is a publish-only repository and all pull requests are ignored. 
    
    
    since after looking deeper it seems the PRs are not ignored.
    
    Changes since v1:
    
     * Edited the title to more accurately reflect the changes
     * More details in commit messages
    
    Signed-off-by: Samuel Yvon samuelyvon9@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1127%2FSamuelYvon%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1127/SamuelYvon/maint-v2
Pull-Request: https://github.com/git/git/pull/1127

Range-diff vs v1:

 1:  271bcf89d1e ! 1:  f09244a0ba3 builtin-commit: re-read file index before launching editor
     @@ Metadata
      Author: Samuel Yvon <samuelyvon9@gmail.com>
      
       ## Commit message ##
     -    builtin-commit: re-read file index before launching editor
     +    builtin-commit: re-read file index before run_status
      
          Changes made within a pre-commit hook are not reflected within
          the editor (for instance, with `git commit --verbose`) because
     -    the index is re-read after the editor has been used.
     +    the index is re-read after the status has been written.
      
          This has the consequence of not displaying the actual changes made
          by the pre-commit hook, but committing them anyways.
     @@ Commit message
          pre-commit goes wrong the invalid changes will go unnoticed until
          committed.
      
     +    The comment suggesting that the cache must be reset after run_status
     +    and before the editor being launched was added in ec84bd00,
     +    (git-commit: Refactor creation of log message., 2008-02-05). It is
     +    unclear why the run_status must be called *after* the cache reset.
     +    However, calling run_status after the cache reset does not update
     +    the status line to state of the current index in the case a
     +    pre-commit hook is ran and changes files in the staging area.
     +
          Signed-off-by: Samuel Yvon <samuelyvon9@gmail.com>
      
       ## builtin/commit.c ##


 builtin/commit.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7c9b1e7be3a..e75b11d1c60 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -728,8 +728,17 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
-		return 0;
+	if (!no_verify && find_hook("pre-commit")) {
+		if(run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+			return 0;
+
+		/*
+		 * Re-read the index as pre-commit hook could have updated it,
+		 * and write it out as a tree.
+		 */
+		discard_cache();
+		read_cache_from(index_file);
+	}
 
 	if (squash_message) {
 		/*
@@ -1051,14 +1060,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
-		/*
-		 * Re-read the index as pre-commit hook could have updated it,
-		 * and write it out as a tree.  We must do this before we invoke
-		 * the editor and after we invoke run_status above.
-		 */
-		discard_cache();
-	}
 	read_cache_from(index_file);
 
 	if (update_main_cache_tree(0)) {

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget
