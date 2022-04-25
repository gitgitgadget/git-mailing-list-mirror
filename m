Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A2DC433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 12:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiDYMtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbiDYMtf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 08:49:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB82E1FCC1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 05:45:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso12409364wme.5
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TEm+KN3i/YDgmZ/F9kfEfmhCk8vi6YzeGC2Hyysdvlg=;
        b=KjK8f57YqtGGS9qa1yOFUNGGmfGbZj1D5/FNcALfSVc5SpCSkJ60lnJsYx8nzw1x2j
         f73or2KJbon5nwcsUkb5ujE88VFetvUNxHKEJDKVkZtV2HBrne98JpTTdbqyYBAlNnf+
         FTBxv5Iz5ygWCxJ9H0iS7MWkby0mUOX3Kx0fZIntG3080teWp7yhTpGDAwcB4l+pWeDT
         BbSByIPkX6YfFuPavpllSA2HQKZwrw62RZRb7moZjpHlJ4Dn4tFCn6s5A2aolDAkzjTs
         F9Siyve0eZlLaoCM+zfVZvaNWeAWunWXSjPW3WZO3936qEd6QjiGU2MMV382pAEZ+RTn
         pTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TEm+KN3i/YDgmZ/F9kfEfmhCk8vi6YzeGC2Hyysdvlg=;
        b=0J0pEH2ZMu2o+cE3cbrfO9adSxM7NIvSeYk5F95O1Y+50gv4RckCJxeonvRoeXOmDh
         vHtrsnaKYDj+XBTd5K2SC+bmGF2/mh8PqMRtrcVDCpz2gu5UnFnVXBt+SokIIcCgIh2T
         F/0VPoWjK2GuP0iAzBFaDyySg209eaVN8SngTB4MuhAururq8WHldtiTGjTid6HFvn7v
         /XOXyVHKESoSa4gXelzyfOt4zNX2KyDqyF1ogP+iHfWGlfTUy8Y5PJK2hn758wIbaTk1
         TrfK9dsFRUGL4iFyrE39b0j/RdHDenRWrccLRJWDnhl5mfJqh5qCi1+Z6SznzHOqxVJb
         1cng==
X-Gm-Message-State: AOAM533pLKARzoWnOHfycD5gGJAkuweJIjtR/BnnFZQtR9w5kOl4AO1P
        vP2X5vtq51SxpFCBXxq6JxGfhGBMX4U=
X-Google-Smtp-Source: ABdhPJwocFS2SMtuKCSgTcuGH2Z+1uOX0/XQZLNira8nHFElyZ8m0SLTZOEl2pUilsWYf+btdT5kvw==
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id c11-20020a05600c0a4b00b0037bea2b5583mr26076133wmq.139.1650890742831;
        Mon, 25 Apr 2022 05:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020adfa2c8000000b0020ad7121495sm4895868wra.23.2022.04.25.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 05:45:42 -0700 (PDT)
Message-Id: <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
In-Reply-To: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 12:45:41 +0000
Subject: [PATCH v2] submodule--helper: fix initialization of
 warn_if_uninitialized
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

The .warn_if_uninitialized member was introduced by 48308681
(git submodule update: have a dedicated helper for cloning,
2016-02-29) to submodule_update_clone struct and initialized to
false.  When c9911c93 (submodule--helper: teach update_data more
options, 2022-03-15) moved it to update_data struct, it started
to initialize it to true but this change was not explained in
its log message.

The member is set to true only when pathspec was given, and is
used when a submodule that matched the pathspec is found
uninitialized to give diagnostic message.  "submodule update"
without pathspec is supposed to iterate over all submodules
(i.e. without pathspec limitation) and update only the
initialized submodules, and finding uninitialized submodules
during the iteration is a totally expected and normal thing that
should not be warned.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    submodule--helper: fix initialization of warn_if_uninitialized
    
    The .warn_if_uninitialized member was introduced by 48308681 (git
    submodule update: have a dedicated helper for cloning, 2016-02-29) to
    submodule_update_clone struct and initialized to false. When c9911c93
    (submodule--helper: teach update_data more options, 2022-03-15) moved it
    to update_data struct, it started to initialize it to true but this
    change was not explained in its log message.
    
    The member is set to true only when pathspec was given, and is used when
    a submodule that matched the pathspec is found uninitialized to give
    diagnostic message. "submodule update" without pathspec is supposed to
    iterate over all submodules (i.e. without pathspec limitation) and
    update only the initialized submodules, and finding uninitialized
    submodules during the iteration is a totally expected and normal thing
    that should not be warned.
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1258%2Forgads%2Fsub-no-warn-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1258/orgads/sub-no-warn-v2
Pull-Request: https://github.com/git/git/pull/1258

Range-diff vs v1:

 1:  089a52a50b4 ! 1:  1e34c9cad18 submodule--helper: fix initialization of warn_if_uninitialized
     @@ Metadata
       ## Commit message ##
          submodule--helper: fix initialization of warn_if_uninitialized
      
     -    This field is supposed to be off by default, and it is only enabled when
     -    running `git submodule update <path>`, and path is not initialized.
     +    The .warn_if_uninitialized member was introduced by 48308681
     +    (git submodule update: have a dedicated helper for cloning,
     +    2016-02-29) to submodule_update_clone struct and initialized to
     +    false.  When c9911c93 (submodule--helper: teach update_data more
     +    options, 2022-03-15) moved it to update_data struct, it started
     +    to initialize it to true but this change was not explained in
     +    its log message.
      
     -    Commit c9911c9358 changed it to enabled by default. This affects for
     -    example git checkout, which displays the following warning for each
     -    uninitialized submodule:
     -
     -    Submodule path 'sub' not initialized
     -    Maybe you want to use 'update --init'?
     -
     -    Amends c9911c9358e611390e2444f718c73900d17d3d60.
     +    The member is set to true only when pathspec was given, and is
     +    used when a submodule that matched the pathspec is found
     +    uninitialized to give diagnostic message.  "submodule update"
     +    without pathspec is supposed to iterate over all submodules
     +    (i.e. without pathspec limitation) and update only the
     +    initialized submodules, and finding uninitialized submodules
     +    during the iteration is a totally expected and normal thing that
     +    should not be warned.
      
          Signed-off-by: Orgad Shaneh <orgads@gmail.com>
      
     @@ builtin/submodule--helper.c: struct update_data {
       	.single_branch = -1, \
       	.max_jobs = 1, \
      -	.warn_if_uninitialized = 1, \
     -+	.warn_if_uninitialized = 0, \
       }
       
       static void next_submodule_warn_missing(struct submodule_update_clone *suc,


 builtin/submodule--helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2c87ef9364f..1a8e5d06214 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2026,7 +2026,6 @@ struct update_data {
 	.references = STRING_LIST_INIT_DUP, \
 	.single_branch = -1, \
 	.max_jobs = 1, \
-	.warn_if_uninitialized = 1, \
 }
 
 static void next_submodule_warn_missing(struct submodule_update_clone *suc,

base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
-- 
gitgitgadget
