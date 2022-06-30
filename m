Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A93C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiF3VUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237475AbiF3VUD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:20:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E24F1A1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i25so339734wrc.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nV+nD5lvdlWAYtyGig91Rn2goXZhBQdddCWXXt2jrvo=;
        b=arc4HmgA9KGM+Zs4EaR6R8d347N71BJNd+hZhzGwcNJcTNfWOKAEn/w1OxQW4DcODd
         pxcmPvLso3omoJGJorZlQhweq7pph/JI+gvDO+5yLwm9qc6pTJGDTF+cq762xF53yecI
         5c62THmhjBuUkoFFFap+HsPSwWjUJ/Af+FWVsk/L/nzJXVkzGIo9anEDcGqj2RCNhqkE
         TJygFMzm26VwEjI38Fbj+/4FLeEW9mQs4GkdJC6e4ds2es5E2K5kBj5wTXfswifT++EN
         IolAydhNhFPJAZVRYIZiQ2aoQC4wSfGwPeVOLo8653kc/b2gar90AqrnRLxVUDL6JqBs
         5LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nV+nD5lvdlWAYtyGig91Rn2goXZhBQdddCWXXt2jrvo=;
        b=PHkv7nrDLVzlRYEEcCD6CztReVSXQlNqqhC/J2B+lflk19Vn2BrnVdD/mijHEL70Nr
         VcNxhteHGvZVwQLm7b2qT9sqOaie4QiNF2UhnAGPHb2GrODstNho6G9ABU0hSpcj4dk8
         096UEmaptOYsSqnSlX1oSrEMAvd/qhVOnpRsA9x0djZ5JhLWWAi6qHJhVuRPq07WyASe
         UkFGPoJr6vg6FZKqpEwbykayyB0r57QIVIMhnWuBb5YqOR9qN4kxSeTYwWl/DxK3Ast6
         +hZ6ZMRgaUrmaBCNg/n8XZHStTat7A7toEmkVuv1KTzeSxS8zjWSrKZciMMNsMJUCQ2X
         kiQw==
X-Gm-Message-State: AJIora9V+553ThpjXN96dVB9/kG6oz19zAv3+L3qIJefxF9Q4BkFIzie
        MuvrfQDsqaK4en1LL5MIfVY3BtuF+iw=
X-Google-Smtp-Source: AGRyM1t0gJrBqSqIX8W0/3XetfiBS2g0ktsLnES0Z6Yna6I0eTclGdalQaHNNpDpi+DNYc26hv9cBw==
X-Received: by 2002:adf:dc09:0:b0:21b:9ec1:f4ab with SMTP id t9-20020adfdc09000000b0021b9ec1f4abmr10489853wri.558.1656624001124;
        Thu, 30 Jun 2022 14:20:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10-20020adffd0a000000b0021a3dd1c5d5sm20316457wrr.96.2022.06.30.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:20:00 -0700 (PDT)
Message-Id: <a21e8cd174db48ea0a771be67583cef0aa866173.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:38 +0000
Subject: [PATCH v2 18/18] submodule--helper: remove display path helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

All invocations of do_get_submodule_displaypath() pass
get_super_prefix() as the super_prefix arg, which is exactly the same
as get_submodule_displaypath().

Replace all calls to do_get_submodule_displaypath() with
get_submodule_displaypath(), and since it has no more callers, remove
it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 41177332dd8..3e0ceb52589 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -118,10 +118,11 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-static char *do_get_submodule_displaypath(const char *path,
-					  const char *prefix,
-					  const char *super_prefix)
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
+	const char *super_prefix = get_super_prefix();
+
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -137,13 +138,6 @@ static char *do_get_submodule_displaypath(const char *path,
 	}
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
-{
-	const char *super_prefix = get_super_prefix();
-	return do_get_submodule_displaypath(path, prefix, super_prefix);
-}
-
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -488,7 +482,7 @@ static void init_submodule(const char *path, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = do_get_submodule_displaypath(path, prefix, get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -1947,9 +1941,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
-	displaypath = do_get_submodule_displaypath(ce->name,
-						   suc->update_data->prefix,
-						   get_super_prefix());
+	displaypath =
+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
@@ -2461,9 +2454,8 @@ static int update_submodule(struct update_data *update_data)
 {
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
-								update_data->prefix,
-								get_super_prefix());
+	update_data->displaypath = get_submodule_displaypath(
+		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
gitgitgadget
