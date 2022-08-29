Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6AFECAAD4
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiH2Uy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH2UyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9EA81B20
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s23so4815227wmj.4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=VBmlkK5/i+WZz4kX9tb0g/+bYeVRK7sjPeTnmm/LLl0=;
        b=dcXijBNJ/LSblEe40i4HjsT1qgRMVPYq93vWRO0/08bLENk7Lt8GcCoWn+nLK3f7xj
         CIB2RYfpTBG3ayOgv3kS3Q70mL/bYAqBoABtU1JJ6WSVn5eAm+PrFJkRxCuSfAVDUB/j
         o5R+xWGbDJJd11jOMB7BooygbV1P1fqEN5/b60ugHJn0jD80QdQMr9/nV2fh2tcGFppe
         2cnxLtHfdtQGM8JkIxM8lPVpF/tcPlqYajH0WFN0nyN5zhDsMumTg9r2F2nnSsrEw7rJ
         8B04NiqrFC2O/xOkZLWStiGUUMZNRlDFyXC2nDt6syAkI4cCPtrWbKVICd/c8PaCAaGz
         HLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=VBmlkK5/i+WZz4kX9tb0g/+bYeVRK7sjPeTnmm/LLl0=;
        b=b/rLYPRuSADgsK86G0wa15tgLmPn5qiOFo2A3bKQpJHH7qHmUUA72cIx+hSgXP/bvK
         9zqC/UT7eAcM3lejk36sZWB8KF/owM5RW6wEQUumY2DTvsi+DMudQZAiXmWE0CNggfOQ
         GTKORzKYy7IcepieT7VSNzkD+lQBY8WsVAPzMtNq9ryTc4AnpA3zxOfp+QYmle2r+tkE
         +nXqk3a6TzD+XCN5CzoGHdHLGhIEvTq//3j/x8aFdRzOuqsNX4eZ+BFhT29gYN9TP4+B
         3x7IhxmzvNkZPNs1U0NMxrxy5fJwtcL6qsJwN5XKAfLODtP+xavVBc0Kq0wqEr6wToXV
         Zp7g==
X-Gm-Message-State: ACgBeo3gyU9BIcyo6x1Q7oKYwhD/NHp5TeuS3jtKFMc741XlVkg4SqXV
        5pD/Y6ySL3dFVeRYvwrWHYDUldPPcpo=
X-Google-Smtp-Source: AA6agR7aPrgfvpcjy56Ep/RDYNL7YDTBfaFcqJCfI9EYJGoXG4YnxJCbyrkMrrcgsvyVemYDM8ZA1w==
X-Received: by 2002:a05:600c:34c5:b0:3a5:fd9d:7b2b with SMTP id d5-20020a05600c34c500b003a5fd9d7b2bmr7848653wmq.1.1661806459632;
        Mon, 29 Aug 2022 13:54:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b003a319b67f64sm407366wms.0.2022.08.29.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:19 -0700 (PDT)
Message-Id: <35f068eb0318653ee0474b30d3420d210f47f8e4.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:12 +0000
Subject: [PATCH 2/6] repo-settings: add submodule_propagate_branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

When processes recurse into submodules, the child processes have to
use the same value of "submodule.propagateBranches" as the parent
process regardless of whether the process is spawned in the superproject
or submodule, otherwise the behavior may be inconsistent if the
repositories don't agree on the config.

We haven't needed a way to propagate the config because because the only
command that reads "submodule.propagateBranches" is "git branch", which
only has one mode of operation with "--recurse-submodules". However, a
future commit will teach "submodule.propagateBranches" to "git submodule
update", making this necessary.

Propagate "submodule.propagateBranches" to child processes by adding a
corresponding GIT_INTERNAL_* environment variable and repository
setting, and setting the environment variable inside
prepare_submodule_repo_env(). Then, refactor builtin/branch.c to read
the repository setting.

Using an internal environment variable is a potentially leaky
abstraction because environment variables can come from sources besides
the parent process. A more robust solution would be to teach Git that
the repository is a submodule and to only read
"submodule.propagateBranches" from the superproject config. There is WIP
for this on the ML [1].

Another alternative would be to pass "-c submodule.propagateBranches" to
all child processes. This is error-prone because many different
processes are invoked directly or indirectly by "git submodule update"
(e.g. "git submodule--helper clone", "git clone", "git checkout"). With
an environment variable, we can avoid this work because
prepare_submodule_repo_env() is already called for submodule child
processes.

[1] https://lore.kernel.org/git/20220310004423.2627181-1-emilyshaffer@google.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/branch.c | 11 +++--------
 cache.h          |  1 +
 repo-settings.c  | 11 ++++++-----
 repository.h     |  1 +
 submodule.c      |  2 ++
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e998..1201e41ef8c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -40,7 +40,6 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static struct object_id head_oid;
 static int recurse_submodules = 0;
-static int submodule_propagate_branches = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -106,10 +105,6 @@ static int git_branch_config(const char *var, const char *value, void *cb)
 		recurse_submodules = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcasecmp(var, "submodule.propagateBranches")) {
-		submodule_propagate_branches = git_config_bool(var, value);
-		return 0;
-	}
 
 	return git_color_default_config(var, value, cb);
 }
@@ -714,7 +709,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-
+	prepare_repo_settings(the_repository);
 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
 	    !show_current && !unset_upstream && argc == 0)
 		list = 1;
@@ -730,7 +725,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (recurse_submodules_explicit) {
-		if (!submodule_propagate_branches)
+		if (!the_repository->settings.submodule_propagate_branches)
 			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
 		if (noncreate_actions)
 			die(_("--recurse-submodules can only be used to create branches"));
@@ -738,7 +733,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	recurse_submodules =
 		(recurse_submodules || recurse_submodules_explicit) &&
-		submodule_propagate_branches;
+		the_repository->settings.submodule_propagate_branches;
 
 	if (filter.abbrev == -1)
 		filter.abbrev = DEFAULT_ABBREV;
diff --git a/cache.h b/cache.h
index 302810b353a..023f8feba42 100644
--- a/cache.h
+++ b/cache.h
@@ -505,6 +505,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define GIT_SUPER_PREFIX_ENVIRONMENT "GIT_INTERNAL_SUPER_PREFIX"
+#define GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT "GIT_INTERNAL_SUBMODULE_PROPAGATE_BRANCHES"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/repo-settings.c b/repo-settings.c
index 43bc881bfc9..2fde9bcdbf6 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -60,16 +60,17 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
+	repo_cfg_bool(r, "submodule.propagateBranches", &r->settings.submodule_propagate_branches, 0);
 
 	/*
-	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
-	 * either it *or* the config sets
-	 * r->settings.core_multi_pack_index if true. We don't take
-	 * the environment variable if it exists (even if false) over
-	 * any config, as in most other cases.
+	 * Boolean settings from config and environment variables. Only
+	 * take the environment variable if it is true, otherwise, use
+	 * the config.
 	 */
 	if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0))
 		r->settings.core_multi_pack_index = 1;
+	if (git_env_bool(GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT, 0))
+		r->settings.submodule_propagate_branches = 1;
 
 	/*
 	 * Non-boolean config
diff --git a/repository.h b/repository.h
index 797f471cce9..bf36b9ee6d7 100644
--- a/repository.h
+++ b/repository.h
@@ -36,6 +36,7 @@ struct repo_settings {
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
+	int submodule_propagate_branches;
 
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
diff --git a/submodule.c b/submodule.c
index 3fa5db3ecdf..510c1b04a76 100644
--- a/submodule.c
+++ b/submodule.c
@@ -504,6 +504,8 @@ static void print_submodule_diff_summary(struct repository *r, struct rev_info *
 
 void prepare_submodule_repo_env(struct strvec *out)
 {
+	if (the_repository->settings.submodule_propagate_branches)
+		strvec_pushf(out, "%s=1", GIT_SUBMODULE_PROPAGATE_BRANCHES_ENVIRONMENT);
 	prepare_other_repo_env(out, DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
-- 
gitgitgadget

