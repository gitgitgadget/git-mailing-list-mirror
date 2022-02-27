Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64CC433FE
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 21:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiB0V5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiB0V5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 16:57:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E46E4D5
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:07 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s13so12600178wrb.6
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Em19lLcMqW9ZtBoxwCezKUkfBKndxDcsrBMBl5tkRY0=;
        b=AhEPr7qpHIeDqrgZZ9F9+PPCJYBshC4nLL+lXY6p/7Uc52/5+VNrJokMNtSsjmxbIP
         f45zMEVazh1D/vOsxy7ufwSU5WZYtggQW6c2saEyIB5421GJXRXUigBVoeV6pstkqaRq
         gNQ3tiXA67jsGqCvtg7DUImqJ0PjA74PlSG043DI4PaRwbW6afApVmbioqhmNLi0uAx8
         HfvXLM3zRMkyEICv20j0+Cf11vIbSANiOv5AUNHGC/4SzZNqEgvYWZFVWWUJUhm7gwCj
         mK2h0lv2APCbRyqIBqrgcXGEORG1b6GaCGMpLu/kZuf8vcy0xq8UPy9iog2UeSINOq+D
         N/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Em19lLcMqW9ZtBoxwCezKUkfBKndxDcsrBMBl5tkRY0=;
        b=Sup0dnU1w71Yk+ps+wMk0GIuB5a13uqXKLJXqfpfw7BPqjoxk00Tu/cMEYBM/DJpzG
         /GpKg5H8B9BUOduCEu1SlQ+RkUFKKHRC90uAr8/UqhmCflw7pE30/O3HiZjxLbz/pEe/
         ACXaOXlCpy5dLB2lKCsBOWi4YQPGnf35D2bf+0TGXpthD8DWDUwaXL2NlNj3zrl+Ef1J
         SS8Fst7vCKdMdcCD7bWrx8YEJRDfJ9BDRUyzm7x71X+LtlRSESbatp1F/fTgerziMcm6
         4RSgv4sC/d4nr7pQdZ9QXj8HjLgLk6t+KEY7PZz8JziCqNSJ9SiHJAi6xRgKEMOmR9Iu
         4cNw==
X-Gm-Message-State: AOAM530FwtNzgX6A0kFGK3FYD3hYBt1KLSE1ZgnoRXgrLZiPJS823YJz
        YHs6V3O6KuSZpYND9J5MTNn4umXOJlI=
X-Google-Smtp-Source: ABdhPJxqjgeZYIuEq2F8SM5om8ZHN97UK26g3sauuYiGI26PdXQ4zx0PZ3tpcb3uHSGVyZounehIWA==
X-Received: by 2002:adf:f689:0:b0:1ef:5d40:a0cd with SMTP id v9-20020adff689000000b001ef5d40a0cdmr11028553wrp.89.1645999025477;
        Sun, 27 Feb 2022 13:57:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3-20020adfbc03000000b001e4b0e4a7fdsm8868778wrg.93.2022.02.27.13.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:57:05 -0800 (PST)
Message-Id: <9795a08414a9269bc6ae929ea8e8b22ad6ec0762.1645999021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
References: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
        <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 21:57:01 +0000
Subject: [PATCH v3 3/3] untracked-cache: write index when populating empty
 untracked cache
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

It is expected that an empty/unpopulated untracked cache structure can
be written to the index - by update-index, or by a "git status" call
that sees the untracked cache should be enabled and is not, but is
running with options that make the untracked cache non-applicable in
that run (eg a pathspec).

Currently, if that happens, then subsequent "git status" calls end up
populating the untracked cache, but not writing the index (not saving
their work) - so the performance outcome is almost identical to the
cache being altogether disabled.

This continues until the index gets written with the untracked cache
populated, for some *other* reason, such as a working tree change.

Detect the condition where an empty untracked cache exists in the
index and we will collect the list of untracked paths, and queue an
index write under that condition, so that the collected untracked
paths can be written out to the untracked cache extension in the
index.

This change depends on previous fixes to t7519 for the "ignore .git
changes when invalidating UNTR" test case to pass - before this fix,
the test never actually did anything as it was not set up correctly.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d91295f2bcd..4eee45dec91 100644
--- a/dir.c
+++ b/dir.c
@@ -2781,7 +2781,8 @@ void remove_untracked_cache(struct index_state *istate)
 
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
-						      const struct pathspec *pathspec)
+						      const struct pathspec *pathspec,
+						      struct index_state *istate)
 {
 	struct untracked_cache_dir *root;
 	static int untracked_cache_disabled = -1;
@@ -2845,8 +2846,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 		return NULL;
 	}
 
-	if (!dir->untracked->root)
+	if (!dir->untracked->root) {
+		/* Untracked cache existed but is not initialized; fix that */
 		FLEX_ALLOC_STR(dir->untracked->root, name, "");
+		istate->cache_changed |= UNTRACKED_CHANGED;
+	}
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
@@ -2916,7 +2920,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
 		return dir->nr;
 	}
 
-	untracked = validate_untracked_cache(dir, len, pathspec);
+	untracked = validate_untracked_cache(dir, len, pathspec, istate);
 	if (!untracked)
 		/*
 		 * make sure untracked cache code path is disabled,
-- 
gitgitgadget
