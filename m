Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2D0C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiLEPeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLEPdu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 10:33:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044B1EEC2
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 07:33:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg10so9026843wmb.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmXvLCEuGLOuFU2bDKVfe6rwzfmUw727wMAbna6KoWY=;
        b=Y3hqz+hADsmSf2xR5NzR8faul53PAHtLVvoRI3X66D3ZqT7gqZQoJc1/yzv64zDWKz
         L1ee/lanqodllQa0g7AHOiWCDn+bsqIpUc0+kfbzcKWkwlBzpbTXYiS8yu4WBotoe4f4
         N53Icm+ywnM5p4rCUuO4n/WWDqImYoDAquOmNohQSTE4dp/JKbMbLT96yPFzDe7VlyK5
         8Llrjqt0kwfmF0cGpthYEoSGAWjmBXh2oq9eKvWLtbV1BGbYjYAft47TvRddfqW0Y8Zt
         4WNeaa6V7nCngX3Q5rzgdo3GZCKF+I/7SGJackywYuSh+bSI3hLi2k/SilmngWo9JeIt
         gjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmXvLCEuGLOuFU2bDKVfe6rwzfmUw727wMAbna6KoWY=;
        b=dttCsc1PaLLZsxxXsTgijqfo/wpdiSXfTKLfgLzYvP59QAJV0hImSXFwP59H/Utuul
         3JXyZeUZ0vmgXqW808ptp1KZRRCrWBvrGQsyzXmK/f9lCogZm8vH3OHWODQp1dt3K8jp
         Em+TIJCS0dJQyFlYg+ond1cDF35iM/Yb9uKjrYYeldsIU5DeBfsNYfsa3GG3PT/LzJ1X
         jj31wNtLshoTsEpYtQcgH4VbpWemQUesa74XgKjRIh6twYtRrOiH3/75HyPSR55Dllsz
         bifeLEt7+YIg8j/nTeEN/2HXcVEqKuwsNR/rR+SIEuTU5rQDLCOtHWnlB0Rfi/N2VviD
         Kokg==
X-Gm-Message-State: ANoB5pk8gXNiWEUfvKRz2Qw08D5qI3dxk83HU5GFRBpmAWZ5+QcJPAJe
        vNfWqXYfsf6+KuGYFwx7YKpwtzOCF5o=
X-Google-Smtp-Source: AA0mqf6FTDwJFNT/0sn+wfRxmYwX6256pwg0bOGNaVjR2huGkDDBpjyeRnlYcT0qjrky8NLbxwEQ8g==
X-Received: by 2002:a05:600c:3ca0:b0:3cf:615f:54fb with SMTP id bg32-20020a05600c3ca000b003cf615f54fbmr52121563wmb.76.1670254390346;
        Mon, 05 Dec 2022 07:33:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b002422b462975sm13924231wrv.34.2022.12.05.07.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 07:33:09 -0800 (PST)
Message-Id: <pull.1390.v2.git.git.1670254388605.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.git.1670251713061.gitgitgadget@gmail.com>
References: <pull.1390.git.git.1670251713061.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 15:33:08 +0000
Subject: [PATCH v2] maintenance: use xcalloc instead of xmalloc where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

We can avoid having to call memset by calling xcalloc directly

Signed-off-by: Seija doremylover123@gmail.com
---
    maintenance: use xcalloc instead of xmalloc where possible
    
    We can avoid having to call memset by calling xcalloc directly
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v2
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v1:

 1:  f56282194a7 ! 1:  ee8a7af6435 maintenance: use xcalloc instead of xmalloc where possible
     @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
       struct remote_state *remote_state_new(void)
       {
      -	struct remote_state *r = xmalloc(sizeof(*r));
     --
     ++	struct remote_state *r;
     + 
      -	memset(r, 0, sizeof(*r));
     -+	struct remote_state *r = xcalloc(1, sizeof(*r));
     ++	CALLOC_ARRAY(r, 1);
       
       	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
       	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
      
       ## submodule.c ##
     -@@ submodule.c: static const struct submodule *get_non_gitmodules_submodule(const char *path)
     +@@ submodule.c: struct fetch_task {
     +  */
     + static const struct submodule *get_non_gitmodules_submodule(const char *path)
     + {
     +-	struct submodule *ret = NULL;
     ++	struct submodule *ret;
     + 	const char *name = default_name_or_path(path);
     + 
       	if (!name)
       		return NULL;
       
      -	ret = xmalloc(sizeof(*ret));
      -	memset(ret, 0, sizeof(*ret));
     -+	ret = xcalloc(1, sizeof(*ret));
     ++	CALLOC_ARRAY(ret, 1);
       	ret->path = name;
       	ret->name = name;
       


 remote.c    | 4 ++--
 submodule.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index 60869beebe7..475a1d18af0 100644
--- a/remote.c
+++ b/remote.c
@@ -2741,9 +2741,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..d43774c7527 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1458,14 +1458,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 

base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
-- 
gitgitgadget
