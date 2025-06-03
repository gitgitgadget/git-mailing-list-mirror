Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA813C8E8
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748956714; cv=none; b=U5tlBnKRJnkf+0syjysb4KYP6tg9c7DBNhUfJRx9B53tTDddKv89lgDn6z0x8L8jLjZ+4pA3f3tZgzbKXJghL6TEyOXWYL7t0McxQMCfva+0poQdW7KaBa7kXtahRYMwi2VHpmJZTLwgVyNzFGUIGTOU3aaMb+4mrN737gcKANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748956714; c=relaxed/simple;
	bh=TuPiucSZAEE4ik1S7sasUVVYcGX5T7o+vukoH6VH2M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0Bu76ESLkrHi0QTO2T1HJWaKvI2q+dye8P4PaCTQrnemZhA1n42vEActPkVO/lNDUnxbe4J4o2bsisaEUk1obSBJ17APmLsRcM0DQqT2kDZY+ZId7PT3wRNWYJoI62S7IrfY9kq5QscyMUJPTZI0sX0aJkmp3U3+6J8Ghxd0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5VrI34x; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5VrI34x"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311a6236effso3951210a91.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748956712; x=1749561512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzRZH0EQQLE4al0V7YmpKZ0oVWmsabpSETpTBcRearQ=;
        b=M5VrI34x7dFge+U67Lmfw2atNpVL2K07fSok/Le6ejkk5b1PFcDN6m1qXvUuNtkCMd
         oitT7a+kozTizSEmEY/9Km74zgMbpE95IOq0oF3NSt1u6NLCCxK/ltpF/mziNF2LByxR
         E5/jExxcYQCZ04oBDlRIX53vUbQmh3EQzmRc9oLNSYQR3AkeCa47zhc6JQ28lFhIqk9i
         Mng/wBsNKoo4Z0QB0mRi10bfBxe6Xiwv96f5y1IjywmLygjRSOMnPZ3SZEsk7+jqxWEn
         WK27+dVoMSA6z+PEZmGQ+64WyInRmD2y89pksjXQrCEbJwF0DA6l/ns+GU86V1c18gY2
         gBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748956712; x=1749561512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzRZH0EQQLE4al0V7YmpKZ0oVWmsabpSETpTBcRearQ=;
        b=wsgEQ7TrSM03PelZLyqWpZoAYsISiFSlogtvncWIzOZEsPs2hunZhoDS7o/5QF2q/8
         chaj66hhTUY58L+yfdqdsvTMyRoVL1VkFgNR9PgyLu/6EPCvEmqcRGNbMPS//tj7kSfq
         4BO0USC0koHMiZKMgRIGSDq4ewDF84uDV8qCUAWMXlYvrhxHOguPGdQH5GttxODs5dbp
         Yz7L+dkgcuQ6IfQHT8399MfvhKY/awUcYf9ZxTxYFwFdJOrGQob6CAJpF01xLv4aUnBD
         tZn3aY0B+8xap6gmxI+d3yx8pcR8wEcrQ4mm5ZGG/mnH6ZyQa6s0N0xQ6UBWznEeskWv
         QVzA==
X-Gm-Message-State: AOJu0YznNSPmAcX2M6eZuUhVjBgVnyJTP2+uV5z6NRTLcar8mHxY2wpD
	D6AOxfp/zaVnYcZHYzdq/Fajbk9SwyVbSwuUXKVfWgLUsusZ/eMw6sGSlGL4oMwC
X-Gm-Gg: ASbGncucGdjZ4db2hXi6rmkHQJYmLAefP+GEg4rX7y8m+gvor+gUHPjuEDrknKZcH9U
	hP0mq8vlKn887QEl6VDXGcuJAuORajgiVe54PUuivjIiC5mjQqOXX9NWk+uIMCxfs9mMXSvz/cC
	EkkTeU8VzIKPE1RVFZbPxwJTBzgHYuA+GbbWNJn6A6t5cwE1H6+brboj9srcqtLu1rP8LqdusTS
	v59D97fpLQ2YQ1o8ccGmlaUCMwjWXBLG5+No9ir1guHnOjtrrOWIS3sYY5Bi/u9eVfIEo8Uh9Q8
	1lanF7pbHdFv3MOzF8d61IqZP397piVQ2HMt0x2KI/L/qoedSfg1aYA17QPdEI8=
X-Google-Smtp-Source: AGHT+IFdgRIQQW4Gr0ySa+EghqefY8uXEtR8U+TIzGYd9KtMCD4x6icL4htmGCyMT5R03wED0OXZpQ==
X-Received: by 2002:a17:90a:e0f:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-312f2eea8c7mr1506913a91.31.1748956711627;
        Tue, 03 Jun 2025 06:18:31 -0700 (PDT)
Received: from Chandekar-PC.. ([2401:4900:1c97:f72b:32e3:d31a:6a1:2cd4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e3d4b6dsm7239465a91.45.2025.06.03.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 06:18:30 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH] environment: move access to "core.sparsecheckout" into repo_settings
Date: Tue,  3 Jun 2025 18:48:06 +0530
Message-ID: <20250603131806.14915-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setting "core.sparsecheckout" is stored in the global
`core_apply_sparse_checkout` and is populated in config.c. Refactor the
code to store it inside the struct `repo_settings`. Also, create
functions to set and get the value of the setting and update all the
occurrences.

This also allows us to remove the definition `#define
USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/backfill.c        |  5 +----
 builtin/clone.c           |  2 +-
 builtin/mv.c              |  2 +-
 builtin/sparse-checkout.c | 18 +++++++++---------
 builtin/worktree.c        |  2 +-
 config.c                  |  5 -----
 dir.c                     |  2 +-
 environment.c             |  1 -
 environment.h             |  1 -
 repo-settings.c           | 11 +++++++++++
 repo-settings.h           |  5 +++++
 sparse-index.c            |  4 ++--
 unpack-trees.c            |  2 +-
 wt-status.c               |  2 +-
 14 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index fa82ad2f6f..d397b8e721 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,6 +1,3 @@
-/* We need this macro to access core_apply_sparse_checkout */
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "builtin.h"
 #include "git-compat-util.h"
 #include "config.h"
@@ -139,7 +136,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	repo_config(repo, git_default_config, NULL);
 
 	if (ctx.sparse < 0)
-		ctx.sparse = core_apply_sparse_checkout;
+		ctx.sparse = repo_settings_get_apply_sparse_checkout(repo);
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
diff --git a/builtin/clone.c b/builtin/clone.c
index 91b9cd0d16..1d1cd880c4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -621,7 +621,7 @@ static int git_sparse_checkout_init(const char *repo)
 	 * We must apply the setting in the current process
 	 * for the later checkout to use the sparse-checkout file.
 	 */
-	core_apply_sparse_checkout = 1;
+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
 
 	cmd.git_cmd = 1;
 	if (run_command(&cmd)) {
diff --git a/builtin/mv.c b/builtin/mv.c
index 07548fe96a..dc9d0b1ab3 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -572,7 +572,7 @@ int cmd_mv(int argc,
 		rename_index_entry_at(the_repository->index, pos, dst);
 
 		if (ignore_sparse &&
-		    core_apply_sparse_checkout &&
+		    repo_settings_get_apply_sparse_checkout(the_repository) &&
 		    core_sparse_checkout_cone) {
 			/*
 			 * NEEDSWORK: we are *not* paying attention to
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 1bf01591b2..41e3a9d61d 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -62,7 +62,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
 	int res;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
 		die(_("this worktree is not sparse"));
 
 	argc = parse_options(argc, argv, prefix,
@@ -397,11 +397,11 @@ static int set_config(enum sparse_checkout_mode mode)
 
 static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
 	/* If not specified, use previous definition of cone mode */
-	if (*cone_mode == -1 && core_apply_sparse_checkout)
+	if (*cone_mode == -1 && repo_settings_get_apply_sparse_checkout(the_repository))
 		*cone_mode = core_sparse_checkout_cone;
 
 	/* Set cone/non-cone mode appropriately */
-	core_apply_sparse_checkout = 1;
+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
 	if (*cone_mode == 1 || *cone_mode == -1) {
 		core_sparse_checkout_cone = 1;
 		return MODE_CONE_PATTERNS;
@@ -415,7 +415,7 @@ static int update_modes(int *cone_mode, int *sparse_index)
 	int mode, record_mode;
 
 	/* Determine if we need to record the mode; ensure sparse checkout on */
-	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
+	record_mode = (*cone_mode != -1) || !repo_settings_get_apply_sparse_checkout(the_repository);
 
 	mode = update_cone_mode(cone_mode);
 	if (record_mode && set_config(mode))
@@ -695,9 +695,9 @@ static int modify_pattern_list(struct strvec *args, int use_stdin,
 		break;
 	}
 
-	if (!core_apply_sparse_checkout) {
+	if (!repo_settings_get_apply_sparse_checkout(the_repository)) {
 		set_config(MODE_ALL_PATTERNS);
-		core_apply_sparse_checkout = 1;
+		repo_settings_set_apply_sparse_checkout(the_repository, 1);
 		changed_config = 1;
 	}
 
@@ -793,7 +793,7 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix,
 	int ret;
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
 		die(_("no sparse-checkout to add to"));
 
 	repo_read_index(the_repository);
@@ -902,7 +902,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	};
 
 	setup_work_tree();
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
 	reapply_opts.cone_mode = -1;
@@ -961,7 +961,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	hashmap_init(&pl.recursive_hashmap, pl_hashmap_cmp, NULL, 0);
 	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
 	pl.use_cone_patterns = 0;
-	core_apply_sparse_checkout = 1;
+	repo_settings_set_apply_sparse_checkout(the_repository, 1);
 
 	add_pattern("/*", empty_base, 0, &pl, 0);
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 88a36ea9f8..a6044dbe5f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -536,7 +536,7 @@ static int add_worktree(const char *path, const char *refname,
 	 * If the current worktree has sparse-checkout enabled, then copy
 	 * the sparse-checkout patterns from the current worktree.
 	 */
-	if (core_apply_sparse_checkout)
+	if (repo_settings_get_apply_sparse_checkout(the_repository))
 		copy_sparse_checkout(sb_repo.buf);
 
 	/*
diff --git a/config.c b/config.c
index b18b5617fc..8fd4dd8c81 100644
--- a/config.c
+++ b/config.c
@@ -1612,11 +1612,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.sparsecheckoutcone")) {
 		core_sparse_checkout_cone = git_config_bool(var, value);
 		return 0;
diff --git a/dir.c b/dir.c
index a374972b62..2df307bb48 100644
--- a/dir.c
+++ b/dir.c
@@ -1503,7 +1503,7 @@ enum pattern_match_result path_matches_pattern_list(
 
 int init_sparse_checkout_patterns(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout)
+	if (!repo_settings_get_apply_sparse_checkout(the_repository))
 		return 1;
 	if (istate->sparse_checkout_patterns)
 		return 0;
diff --git a/environment.c b/environment.c
index c61d773e7e..a379a9149e 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int core_apply_sparse_checkout;
 int core_sparse_checkout_cone;
 int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
diff --git a/environment.h b/environment.h
index 3d98461a06..6a30512f3c 100644
--- a/environment.h
+++ b/environment.h
@@ -160,7 +160,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
diff --git a/repo-settings.c b/repo-settings.c
index 4129f8fb2b..406c70601c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -81,6 +81,7 @@ void prepare_repo_settings(struct repository *r)
 		      &r->settings.pack_use_bitmap_boundary_traversal,
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
+	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.core_apply_sparse_checkout, 0);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
@@ -227,3 +228,13 @@ void repo_settings_reset_shared_repository(struct repository *repo)
 {
 	repo->settings.shared_repository_initialized = 0;
 }
+
+int repo_settings_get_apply_sparse_checkout(struct repository *repo)
+{
+	return repo->settings.core_apply_sparse_checkout;
+}
+
+void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value)
+{
+	repo->settings.core_apply_sparse_checkout = value;
+}
diff --git a/repo-settings.h b/repo-settings.h
index 2bf24b2597..e4e797e85c 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -67,6 +67,7 @@ struct repo_settings {
 	unsigned long big_file_threshold;
 
 	char *hooks_path;
+	int core_apply_sparse_checkout;
 };
 #define REPO_SETTINGS_INIT { \
 	.shared_repository = -1, \
@@ -98,4 +99,8 @@ int repo_settings_get_shared_repository(struct repository *repo);
 void repo_settings_set_shared_repository(struct repository *repo, int value);
 void repo_settings_reset_shared_repository(struct repository *repo);
 
+/* Read, set or reset the value for "core.sparsecheckout". */
+int repo_settings_get_apply_sparse_checkout(struct repository *repo);
+void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value);
+
 #endif /* REPO_SETTINGS_H */
diff --git a/sparse-index.c b/sparse-index.c
index 5634abafaa..1565708190 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -150,7 +150,7 @@ static int index_has_unmerged_entries(struct index_state *istate)
 
 int is_sparse_index_allowed(struct index_state *istate, int flags)
 {
-	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
+	if (!repo_settings_get_apply_sparse_checkout(istate->repo) || !core_sparse_checkout_cone)
 		return 0;
 
 	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
@@ -668,7 +668,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
-	if (!core_apply_sparse_checkout ||
+	if (!repo_settings_get_apply_sparse_checkout(istate->repo) ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 471837f032..b3bf992067 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1924,7 +1924,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->prefix)
 		update_sparsity_for_prefix(o->prefix, o->src_index);
 
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!repo_settings_get_apply_sparse_checkout(repo) || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		memset(&pl, 0, sizeof(pl));
diff --git a/wt-status.c b/wt-status.c
index 454601afa1..afe98a1bb9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1773,7 +1773,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 	int skip_worktree = 0;
 	int i;
 
-	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
+	if (!repo_settings_get_apply_sparse_checkout(r) || r->index->cache_nr == 0) {
 		/*
 		 * Don't compute percentage of checked out files if we
 		 * aren't in a sparse checkout or would get division by 0.
-- 
2.43.0

