Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626BEC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbiBYRKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiBYRKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:10:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890A1688CC
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so2086351wms.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Em19lLcMqW9ZtBoxwCezKUkfBKndxDcsrBMBl5tkRY0=;
        b=bQE5Oobl1RQZVb50G4s39PQxGsL4lfhWTNYHgt5wU05QT/u9dm5c8NSma+paAu9BVb
         4c7asyRxuZW3/0GKOug9OyluuuGl+aNyNURRWbkh8rw+iRc2t+WlovSCRL9xED3Bq9J9
         MYvZE2D+5lFOgNmRRnVpXRtE2LLrM1IcLmbrsCNCpaUJ4W8yiHBHkxT8OgCZVIGthUcq
         ahkT6EkDxkuggLQv1A7uH6oGJBP0Fe3Fip3wb0BbRTqzg02aUrjzKSnB/Nqr2XNVRArG
         JLEUsv9bohxth1J1GWJHhhoWSu3aGt/UAF0PgQUkIcx+0H+X8wWc6gIfXfGk/EECIKR/
         bOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Em19lLcMqW9ZtBoxwCezKUkfBKndxDcsrBMBl5tkRY0=;
        b=dFEg6PMDWJrr3rZyPdKLe617uwNUvpdXcwkzdMsZT3+eQQkfGBS4fFqOzIzbCzvBdm
         Sh2Btp5IM/eCJGR+wX3SHVr/AOX5A36d2YSOtI+MH5Es28mFcJFOfQApBBt3SijU7YUo
         jjbtUbtI/TCvDfpkAwwgx5xVrubcBWFZ0ttNExeGgf0ueEq4yDzoy16EPsAaB1s5BSZG
         BAyz3FUdrQG/OmYZZOx2wLe48x787S6gfhcoVLK1hLe9j6urjTl/QObumizQ9lBU5J3N
         Vnl1fYSI/x8948WuEvpQK2Mc3gNvsBSHMwKAqh9509Gb+4yDH9qXCzRkS2o3ybDrLWVl
         xFwg==
X-Gm-Message-State: AOAM5310MXKBD3F2GYlE19XBzJ2Jue0NRbiSM1z6484ZSfArhwl65uet
        adgWfwaXFFWBZNt6i4D8nMhtGgt5uN4=
X-Google-Smtp-Source: ABdhPJx6qPEH3aXfwX1Uqi0Ens/Joct2Kgs7hYr4OV7VGH35KDKlKw1+Ej7vgeXUXv4DeyATUu+btA==
X-Received: by 2002:a05:600c:2d4c:b0:381:3f3a:4999 with SMTP id a12-20020a05600c2d4c00b003813f3a4999mr2009610wmg.13.1645809018958;
        Fri, 25 Feb 2022 09:10:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10-20020adfe94a000000b001ef57f562ccsm2764249wrn.51.2022.02.25.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:10:18 -0800 (PST)
Message-Id: <190b27e518a22e2253b318e8087446d761e918b2.1645809015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 17:10:14 +0000
Subject: [PATCH v2 3/3] untracked-cache: write index when populating empty
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
