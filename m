Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EFC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiF0XUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiF0XU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512124093
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n1so15090980wrg.12
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zo91zgT3j+dK4VHiPk16G+LAMPUeaUatKo//jodID5g=;
        b=F+eRzJGMo4+ErF3giCwqKJgdSWXiy0NkOUsyKOOdHh9MmruCpZwSUHeukwZ+HGIQUT
         niqt1ciARnLOoj800Qh86qkLjVMAZ+Krlh3elc6X5dAziNB6GV0a6aIWRmMJpiSqAOrB
         rgpELM6Z6ov/Nloe+cvrHHbEF6WkvE3evVnVeiKIIGFbLnGvgtbyt6I1mH0wPrXtpawC
         p0dBHwVpeSc3QjFG2BhkkQJh+h/1aGuCBMlOv8VHjh8t7GfEsnW4a8O6i5S8KNdqjCqk
         2vUCsZ5JQr3YdUkKsJO8iABgFeF/w7JL9JdWH3scQGVUXUNf73NMDF0lizu7xqCa280d
         d74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zo91zgT3j+dK4VHiPk16G+LAMPUeaUatKo//jodID5g=;
        b=tShVbSnULKVTMUvZU/HhCnjrTnweZfbdS8RAC0OSCqo2NsVaP6AMIi1auE7eyoyBue
         1KpAxV2KCI3isAMeJn7ljoqalA7w8I/7n3GMi0mWhRq+0ljgZAACgg5MCsAE3LMdyrWm
         BU+fN+viEZvPZvs7WL20lTnUD+XuDsYfg2lQmgY7T1Z01T9UqQMMAVypDEXpyEm/HvBb
         uyR2xKN2Zm/xLL6t3zR0cr7Kzs6VhXIII/F7glPbpkmxs2xyOm3riIv08MK3CLmdQ91k
         1KWu0mFOmfWKGl8JUAWtBjcj+THhERQVarDnumrpHBitsJBDE/IZen+7NnIUnPsaKBnz
         URTQ==
X-Gm-Message-State: AJIora8Xn/ZRVcb6T1IQEtNvE+av9BGYu/vga1OkL1NScKzGoqv32Hrq
        cFYVT7GAmC4Y1z0hocqMeEK6H3CvAMjy8A==
X-Google-Smtp-Source: AGRyM1ukTvIbjP62eb2OkknbasE812NYjnBbJpHLWzQX8uzNk3l6o2XxWP9/cTtZ3EljxWPResrNhA==
X-Received: by 2002:adf:ef11:0:b0:21b:a557:b06d with SMTP id e17-20020adfef11000000b0021ba557b06dmr14839789wro.434.1656372023522;
        Mon, 27 Jun 2022 16:20:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d420c000000b0021b8d1b0568sm12012604wrq.52.2022.06.27.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:22 -0700 (PDT)
Message-Id: <9fa13380b02174a4ff9cbe153166689561d23535.1656372017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:17 +0000
Subject: [PATCH 5/5] submodule--helper: remove display path helper
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
index 81ea4669aab..73b36f47600 100644
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
 
@@ -1949,9 +1943,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
-	displaypath = do_get_submodule_displaypath(ce->name,
-						   suc->update_data->prefix,
-						   get_super_prefix());
+	displaypath =
+		get_submodule_displaypath(ce->name, suc->update_data->prefix);
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
@@ -2442,9 +2435,8 @@ static int update_submodule(struct update_data *update_data)
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
