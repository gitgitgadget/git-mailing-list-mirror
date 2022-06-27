Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6A1C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiF0XUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbiF0XUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 19:20:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E3A24096
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o4so11166096wrh.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5JutwRJpD/70ZgoFS+vtRHakI4NctN9EOqcsuj5G/J0=;
        b=ONh1Kb0Jggc9UoRvP+wJxJBCtxF+mQuw0Ye/EenRzM1khfhCr9WNfgUB3qjVMPQnNZ
         yTguxsTAav8BO5MR5Y4ZXekMS39kZ3vdxZzpvUSQS2RN4ixShPj5ZJAe3W4+pDBrNBai
         GVpST6rkl8KnIOClu0htVemFLGk7qRAyqHknsBStJvaJRiVXO+l91Ihx9FGL6mrw6fL0
         aiVwLOKh9n1U27wa0bafTaMWdsuDaoSkWpLUwyd7iy6yZoiX7XZtRQFIxJ/Mi9jDdBLk
         P8BEhK+/BKUX2gBA9LZWr0CxlRkEzYkcr2ttqLKYQ9FS70XJdqHK1jAHFSWx5qlGKXzI
         9j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5JutwRJpD/70ZgoFS+vtRHakI4NctN9EOqcsuj5G/J0=;
        b=Uw0U6mU4sVAC8bsx7vMIpsNmvcevLj49dRoSCyhSlk3V0IrwLUGwb2f75eMB8CRoHa
         S/36DkzWEAF19+dEJuYCxPcg/wbNTHoT6+gt2pwVOB9DQoUZK3mNfW2nEo8NiM7Low7J
         rAWtg5syX6VRC1cLkettVImZaTtxjLDCgF+ghIxs2TXdqkrBnrcJyp46KdNc1VZgi+NC
         0kfwlBPqFrIn6t4IJFj940IprcqL2Ep6BInAAZQpz+O9IFaFiJfHw1GbsHUVq45/a2yL
         XeQdqOw5SRiuWEgLXB04+pFMElNKvT8swkJ0vQClrLVvsl1G6k+MduNTTSUAfUuhWY77
         HOcg==
X-Gm-Message-State: AJIora+cFSFSB5g7chXNsu17csxVaIzSIcWf/HoAXmuFTC6VsfQmHIW3
        yw7sReFb1rxAht4kQhS9ssNvNQ7a3B3BAg==
X-Google-Smtp-Source: AGRyM1tCjy+usQ8btJoPlXOOSFOQXWwkxJCnU6s1Jp5vciJ5wNKkAfEqcN4GJjfWmFKPBK3Z7Y1Ayw==
X-Received: by 2002:adf:dece:0:b0:21b:a4b0:f7e3 with SMTP id i14-20020adfdece000000b0021ba4b0f7e3mr14891981wrn.197.1656372022493;
        Mon, 27 Jun 2022 16:20:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfcc82000000b0021b9662a0c7sm11653389wrj.78.2022.06.27.16.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 16:20:22 -0700 (PDT)
Message-Id: <57988287fc01a8baf5c4fd7326772c80bc015f3c.1656372017.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 23:20:16 +0000
Subject: [PATCH 4/5] submodule--helper update: use --super-prefix
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

Unlike the other subcommands, "git submodule--helper update" uses the
"--recursive-prefix" flag instead of "--super-prefix". The two flags are
otherwise identical (they only serve to compute the 'display path' of a
submodule), except that there is a dedicated helper function to get the
value of "--super-prefix".

This inconsistency exists because "git submodule update" used to pass
"--recursive-prefix" between shell and C (introduced in [1]) before
"--super-prefix" was introduced (in [2]), and for simplicity, we kept
this name when "git submodule--helper update" was created.

Remove "--recursive-prefix" and its associated code from "git
submodule--helper update", replacing it with "--super-prefix".

To use "--super-prefix", module_update is marked with
SUPPORT_SUPER_PREFIX. Note that module_clone must also be marked with
SUPPORT_SUPER_PREFIX, otherwise the "git submodule--helper clone"
subprocess will fail check because "--super-prefix" is propagated via
the environment.

[1] 48308681b0 (git submodule update: have a dedicated helper for
cloning, 2016-02-29)
[2] 74866d7579 (git: make super-prefix option, 2016-10-07)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fa8256526e9..81ea4669aab 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -477,22 +477,18 @@ static int starts_with_dot_dot_slash(const char *const path)
 
 struct init_cb {
 	const char *prefix;
-	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   const char *superprefix, unsigned int flags)
+			   unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	/* try superprefix from the environment, if it is not passed explicitly */
-	if (!superprefix)
-		superprefix = get_super_prefix();
-	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
+	displaypath = do_get_submodule_displaypath(path, prefix, get_super_prefix());
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -566,7 +562,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
@@ -1880,7 +1876,6 @@ struct submodule_update_clone {
 
 struct update_data {
 	const char *prefix;
-	const char *recursive_prefix;
 	const char *displaypath;
 	const char *update_default;
 	struct object_id suboid;
@@ -1956,7 +1951,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 
 	displaypath = do_get_submodule_displaypath(ce->name,
 						   suc->update_data->prefix,
-						   suc->update_data->recursive_prefix);
+						   get_super_prefix());
 
 	if (ce_stage(ce)) {
 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
@@ -2399,11 +2394,11 @@ static void ensure_core_worktree(const char *path)
 
 static void update_data_to_args(struct update_data *update_data, struct strvec *args)
 {
-	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
-	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->displaypath)
-		strvec_pushf(args, "--recursive-prefix=%s/",
+		strvec_pushf(args, "--super-prefix=%s/",
 			     update_data->displaypath);
+	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
+	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
 	if (update_data->quiet)
 		strvec_push(args, "--quiet");
 	if (update_data->force)
@@ -2449,7 +2444,7 @@ static int update_submodule(struct update_data *update_data)
 
 	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
 								update_data->prefix,
-								update_data->recursive_prefix);
+								get_super_prefix());
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
@@ -2573,10 +2568,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "prefix", &opt.prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
-			   N_("path"),
-			   N_("path into the working tree, across nested "
-			      "submodule boundaries")),
 		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
@@ -2655,7 +2646,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
-		info.superprefix = opt.recursive_prefix;
 		if (opt.quiet)
 			info.flags |= OPT_QUIET;
 
@@ -3352,9 +3342,9 @@ struct cmd_struct {
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
-	{"clone", module_clone, 0},
+	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update", module_update, 0},
+	{"update", module_update, SUPPORT_SUPER_PREFIX},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
-- 
gitgitgadget

