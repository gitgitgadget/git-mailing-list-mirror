Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274551F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935153AbeF3JVQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36322 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934569AbeF3JUx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:53 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so8475837lfh.3
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+lDjajzLwMMLr3y2CxfIVtw1axD0tfI/FvtHAZj134=;
        b=DB1Fr38UhRbxwqC6hUcz1Wl/4fycIqWA2uRaBK5OrGdvSekzWMF4X/NX/5Eiw4wgoK
         u+Mx7vRd7DitnlIIx6nXQ3cfibyZfsIjdtGU8A09F9TtJYUfew6903J5AqZFyng7sOCB
         sdRMrZipunSQj4Jp3KEEg+SYmAknP1RhGUxDSJiR8rduYNBl17Lo43ewpGWPZfacN27L
         ec/LJMwpGTuMOD6ixN6riGjKLXObwwKWaoCwZCSeUKBe0oOkbkKJdP9T6me2sqrAhw3L
         nRf7im2Wo+JH7WNk0pn8H0KnBj4qriVnfSmGRa7PYXgnVpUUTnjNWDr5w7AD13khMYUS
         NCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+lDjajzLwMMLr3y2CxfIVtw1axD0tfI/FvtHAZj134=;
        b=AHYIA1PxIGCEe5fX6EMN7DJj9zhZdJC8LIWNes33htq/PhbEhOoHfOrXwrhI8hzRVv
         4EP45oAaddDOLcC7n19yQy9Fzu7BDJoDIE5OPbMy3/Blj+qYhqnQmgG7dtVfCDeR7Xy9
         CpYTaodfk141Mp/OFztm7dmpdg15gxu5QF+f42yz3b+T6jdnNKamOWcDrL3fm/Ww8SiU
         6WTND0Xk4d4ulKEeCPgj87YGsrzz0EvytWT29tKavRE03R7A0LFrmrKEqJeayR8lTbIE
         e/4olVQ8BWFPk9SKkpetYgAOtMgssFtqzgyBU079y4dOIEgB5vUFy5qhWT3gmTwWzcaP
         8chw==
X-Gm-Message-State: APt69E2jRsULHhieVDc9943TNAHbGa8V43hNSkho9Mu6e0e6dtq1w2lQ
        zgDwHHzZtTJKC5dcG8q+Lng9Qg==
X-Google-Smtp-Source: AAOMgpflxNf6sVqV+mx7k8NHsySOyNIGM7dxe7iE35LJePDX5JCq2eBfFhY9OXn9bUCv+vh3rVTKRg==
X-Received: by 2002:a19:d7d1:: with SMTP id q78-v6mr11572557lfi.40.1530350451690;
        Sat, 30 Jun 2018 02:20:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 12/12] submodule.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:31 +0200
Message-Id: <20180630092031.29910-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 submodule.h | 112 ++++++++++++++++++++++++++--------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/submodule.h b/submodule.h
index 7856b8a0b3..d266e6dca5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -33,62 +33,62 @@ struct submodule_update_strategy {
 };
 #define SUBMODULE_UPDATE_STRATEGY_INIT {SM_UPDATE_UNSPECIFIED, NULL}
 
-extern int is_gitmodules_unmerged(const struct index_state *istate);
-extern int is_staging_gitmodules_ok(struct index_state *istate);
-extern int update_path_in_gitmodules(const char *oldpath, const char *newpath);
-extern int remove_path_from_gitmodules(const char *path);
-extern void stage_updated_gitmodules(struct index_state *istate);
-extern void set_diffopt_flags_from_submodule_config(struct diff_options *,
-		const char *path);
-extern int git_default_submodule_config(const char *var, const char *value, void *cb);
+int is_gitmodules_unmerged(const struct index_state *istate);
+int is_staging_gitmodules_ok(struct index_state *istate);
+int update_path_in_gitmodules(const char *oldpath, const char *newpath);
+int remove_path_from_gitmodules(const char *path);
+void stage_updated_gitmodules(struct index_state *istate);
+void set_diffopt_flags_from_submodule_config(struct diff_options *,
+					     const char *path);
+int git_default_submodule_config(const char *var, const char *value, void *cb);
 
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
-extern int is_submodule_active(struct repository *repo, const char *path);
+int is_submodule_active(struct repository *repo, const char *path);
 /*
  * Determine if a submodule has been populated at a given 'path' by checking if
  * the <path>/.git resolves to a valid git repository.
  * If return_error_code is NULL, die on error.
  * Otherwise the return error code is the same as of resolve_gitdir_gently.
  */
-extern int is_submodule_populated_gently(const char *path, int *return_error_code);
-extern void die_in_unpopulated_submodule(const struct index_state *istate,
-					 const char *prefix);
-extern void die_path_inside_submodule(const struct index_state *istate,
-				      const struct pathspec *ps);
-extern enum submodule_update_type parse_submodule_update_type(const char *value);
-extern int parse_submodule_update_strategy(const char *value,
-		struct submodule_update_strategy *dst);
-extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
-extern void handle_ignore_submodules_arg(struct diff_options *, const char *);
-extern void show_submodule_summary(struct diff_options *o, const char *path,
-		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule);
-extern void show_submodule_inline_diff(struct diff_options *o, const char *path,
-		struct object_id *one, struct object_id *two,
-		unsigned dirty_submodule);
+int is_submodule_populated_gently(const char *path, int *return_error_code);
+void die_in_unpopulated_submodule(const struct index_state *istate,
+				  const char *prefix);
+void die_path_inside_submodule(const struct index_state *istate,
+			       const struct pathspec *ps);
+enum submodule_update_type parse_submodule_update_type(const char *value);
+int parse_submodule_update_strategy(const char *value,
+				    struct submodule_update_strategy *dst);
+const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
+void handle_ignore_submodules_arg(struct diff_options *, const char *);
+void show_submodule_summary(struct diff_options *o, const char *path,
+			    struct object_id *one, struct object_id *two,
+			    unsigned dirty_submodule);
+void show_submodule_inline_diff(struct diff_options *o, const char *path,
+				struct object_id *one, struct object_id *two,
+				unsigned dirty_submodule);
 /* Check if we want to update any submodule.*/
-extern int should_update_submodules(void);
+int should_update_submodules(void);
 /*
  * Returns the submodule struct if the given ce entry is a submodule
  * and it should be updated. Returns NULL otherwise.
  */
-extern const struct submodule *submodule_from_ce(const struct cache_entry *ce);
-extern void check_for_new_submodule_commits(struct object_id *oid);
-extern int fetch_populated_submodules(struct repository *r,
-				      const struct argv_array *options,
-				      const char *prefix,
-				      int command_line_option,
-				      int default_option,
-				      int quiet, int max_parallel_jobs);
-extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
-extern int submodule_uses_gitfile(const char *path);
+const struct submodule *submodule_from_ce(const struct cache_entry *ce);
+void check_for_new_submodule_commits(struct object_id *oid);
+int fetch_populated_submodules(struct repository *r,
+			       const struct argv_array *options,
+			       const char *prefix,
+			       int command_line_option,
+			       int default_option,
+			       int quiet, int max_parallel_jobs);
+unsigned is_submodule_modified(const char *path, int ignore_untracked);
+int submodule_uses_gitfile(const char *path);
 
 #define SUBMODULE_REMOVAL_DIE_ON_ERROR (1<<0)
 #define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<1)
 #define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
-extern int bad_to_remove_submodule(const char *path, unsigned flags);
+int bad_to_remove_submodule(const char *path, unsigned flags);
 
 int add_submodule_odb(const char *path);
 
@@ -96,17 +96,17 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-extern int submodule_touches_in_range(struct object_id *a,
-				      struct object_id *b);
-extern int find_unpushed_submodules(struct oid_array *commits,
-				    const char *remotes_name,
-				    struct string_list *needs_pushing);
+int submodule_touches_in_range(struct object_id *a,
+			       struct object_id *b);
+int find_unpushed_submodules(struct oid_array *commits,
+			     const char *remotes_name,
+			     struct string_list *needs_pushing);
 struct refspec;
-extern int push_unpushed_submodules(struct oid_array *commits,
-				    const struct remote *remote,
-				    const struct refspec *rs,
-				    const struct string_list *push_options,
-				    int dry_run);
+int push_unpushed_submodules(struct oid_array *commits,
+			     const struct remote *remote,
+			     const struct refspec *rs,
+			     const struct string_list *push_options,
+			     int dry_run);
 /*
  * Given a submodule path (as in the index), return the repository
  * path of that submodule in 'buf'. Return -1 on error or when the
@@ -116,28 +116,28 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
 
 #define SUBMODULE_MOVE_HEAD_DRY_RUN (1<<0)
 #define SUBMODULE_MOVE_HEAD_FORCE   (1<<1)
-extern int submodule_move_head(const char *path,
-			       const char *old,
-			       const char *new_head,
-			       unsigned flags);
+int submodule_move_head(const char *path,
+			const char *old,
+			const char *new_head,
+			unsigned flags);
 
 /*
  * Prepare the "env_array" parameter of a "struct child_process" for executing
  * a submodule by clearing any repo-specific environment variables, but
  * retaining any config in the environment.
  */
-extern void prepare_submodule_repo_env(struct argv_array *out);
+void prepare_submodule_repo_env(struct argv_array *out);
 
 #define ABSORB_GITDIR_RECURSE_SUBMODULES (1<<0)
-extern void absorb_git_dir_into_superproject(const char *prefix,
-					     const char *path,
-					     unsigned flags);
+void absorb_git_dir_into_superproject(const char *prefix,
+				      const char *path,
+				      unsigned flags);
 
 /*
  * Return the absolute path of the working tree of the superproject, which this
  * project is a submodule of. If this repository is not a submodule of
  * another repository, return NULL.
  */
-extern const char *get_superproject_working_tree(void);
+const char *get_superproject_working_tree(void);
 
 #endif
-- 
2.18.0.rc2.476.g39500d3211

