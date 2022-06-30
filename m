Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04602C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiF3VUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbiF3VTy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8542E45787
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o4so398232wrh.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=U2SMOt3D2+JQiXyq7ZJfVCLmmaGmBPTWPAtt01OokPw=;
        b=jO24bCaLlXEfDU6AO6cnw44xIi7WSsVHcJthJrdNfhGJ+MSx5HxTteU/rvxjlPdym1
         nKXSnvMgiYeoyGZEzJGx7A/Qn/9SlCjU2pz3DjumweqsisPk1NWymQiMmKhpPC5bKTPp
         N9Z5kLG7IcIfIGRhxJ4hLV5/m2L/T6a3GOQ1ODfHQPQRXJPX9NEcN5Qr6sFuap9TnZGK
         fDJGBW3LF3mnZipXgyho/zNvVEJhswDUaLyT+fdGEj/kYnhI2xGcDLEjpxlnJY/eH7iy
         NE2UkmekHN+pnCuWFDaQA7JIhmqJVac1GdVjcw+fkM3MTfTRY0u2dEnMYCCEZdhKzhEQ
         BiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=U2SMOt3D2+JQiXyq7ZJfVCLmmaGmBPTWPAtt01OokPw=;
        b=OEXuGYiwo+d4TM+Lq6CaO6IIv0ZwWXI6ymytYIZhUEQKmNflEFOJQADH3k0hGEWPTX
         IboIMOk2hHEaXhx02gqXETItPdAhsBT/GIIPdRG36Mtcx9WJyU2f1N9OmHtgst8GCnG4
         jupYHE5m/Tlg0Zekq8viDo2RslSB1ByKf+hrJb64rHWXkzHqyuO6cMl2gEbZ7xCOfxES
         ZVtaz7BLBi8ik6RMLIljJ37blw1mhwErbsT+z/l9HD3dM0UEVLLfpkjkepTSpWIqM5rA
         RV7YR9002ErUyOYpiah7VfA1zCSTcVIvJAZN1fmVKw0j0mceYQQUQP+pFoxyeJfepDkD
         vo4A==
X-Gm-Message-State: AJIora95KKE0UR0Oyhq8AO/Yq61Uu9vXKYcnCbnaAmi3HYOwQKrDBGfu
        XDLAmJvVVqchDEKLiHtGI28L7KzgC1A=
X-Google-Smtp-Source: AGRyM1uvP9sSOs69URl1n5G1ZnKD8/stT7Cg3piyxyex8k9MtOwM5sUNUflKZV6gFEnmYH8nyJRO+A==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9239:8f28 with SMTP id i8-20020a0560001ac800b0021b92398f28mr10493142wry.517.1656623991722;
        Thu, 30 Jun 2022 14:19:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b0020d106c0386sm19874379wrs.89.2022.06.30.14.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:51 -0700 (PDT)
Message-Id: <b788fc671bf1862a72f9fe7256affd7d152b8a6f.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:30 +0000
Subject: [PATCH v2 10/18] submodule--helper: eliminate internal "--update"
 option
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Follow-up on the preceding commit which taught "git submodule--helper
update" to understand "--merge", "--checkout" and "--rebase" and use
those options instead of "--update=(rebase|merge|checkout|none)" when
the command invokes itself.

Unlike the preceding change this isn't strictly necessary to
eventually change "git-submodule.sh" so that it invokes "git
submodule--helper update" directly, but let's remove this
inconsistency in the command-line interface. We shouldn't need to
carry special synonyms for existing options in "git submodule--helper"
when that command can use the primary documented names instead.

But, as seen in the post-image this makes the control flow within
"builtin/submodule--helper.c" simpler, we can now write directly to
the "update_default" member of "struct update_data" when parsing the
options in "module_update()".

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 53179472d85..389b900602f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1818,7 +1818,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 static void determine_submodule_update_strategy(struct repository *r,
 						int just_cloned,
 						const char *path,
-						const char *update,
+						enum submodule_update_type update,
 						struct submodule_update_strategy *out)
 {
 	const struct submodule *sub = submodule_from_path(r, null_oid(), path);
@@ -1828,9 +1828,7 @@ static void determine_submodule_update_strategy(struct repository *r,
 	key = xstrfmt("submodule.%s.update", sub->name);
 
 	if (update) {
-		if (parse_submodule_update_strategy(update, out) < 0)
-			die(_("Invalid update mode '%s' for submodule path '%s'"),
-				update, path);
+		out->type = update;
 	} else if (!repo_config_get_string_tmp(r, key, &val)) {
 		if (parse_submodule_update_strategy(val, out) < 0)
 			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
@@ -1882,7 +1880,7 @@ struct update_data {
 	const char *prefix;
 	const char *recursive_prefix;
 	const char *displaypath;
-	const char *update_default;
+	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
 	struct submodule_update_strategy update_strategy;
@@ -2423,6 +2421,8 @@ static const char *submodule_update_type_to_label(enum submodule_update_type typ
 
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
+	enum submodule_update_type update_type = update_data->update_default;
+
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->recursive_prefix)
@@ -2446,8 +2446,10 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 		strvec_push(args, "--require-init");
 	if (update_data->depth)
 		strvec_pushf(args, "--depth=%d", update_data->depth);
-	if (update_data->update_default)
-		strvec_pushl(args, "--update", update_data->update_default, NULL);
+	if (update_type != SM_UPDATE_UNSPECIFIED)
+		strvec_pushf(args, "--%s",
+			     submodule_update_type_to_label(update_type));
+
 	if (update_data->references.nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, &update_data->references)
@@ -2599,7 +2601,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
-	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2618,16 +2619,13 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
-		OPT_STRING(0, "update", &opt.update_default,
-			   N_("string"),
-			   N_("rebase, merge, checkout or none")),
-		OPT_SET_INT(0, "checkout", &update_type,
+		OPT_SET_INT(0, "checkout", &opt.update_default,
 			N_("use the 'checkout' update strategy (default)"),
 			SM_UPDATE_CHECKOUT),
-		OPT_SET_INT('m', "merge", &update_type,
+		OPT_SET_INT('m', "merge", &opt.update_default,
 			N_("use the 'merge' update strategy"),
 			SM_UPDATE_MERGE),
-		OPT_SET_INT('r', "rebase", &update_type,
+		OPT_SET_INT('r', "rebase", &opt.update_default,
 			N_("use the 'rebase' update strategy"),
 			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
@@ -2679,13 +2677,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
-	if (update_type != SM_UPDATE_UNSPECIFIED)
-		opt.update_default = submodule_update_type_to_label(update_type);
-
 	if (opt.update_default)
-		if (parse_submodule_update_strategy(opt.update_default,
-						    &opt.update_strategy) < 0)
-			die(_("bad value for update parameter"));
+		opt.update_strategy.type = opt.update_default;
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
 		list_objects_filter_release(&filter_options);
-- 
gitgitgadget

