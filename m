Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348C34DB4A
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325147; cv=none; b=Ac5rq9oP+Bln52/23H2EM//cRgF2yqBY+YG2vHK/JrIyc3jBFBZ87cwivTBQQKhmZeAP2daTJlcl8wnCVTsBhknPqTrHwfT80jhSyIzC0IO9Krha2AilS0RdNziAVyf7qSp11QFvpnPC0w2U7psqqXyDzkajrdvwCoWVQRzCeyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325147; c=relaxed/simple;
	bh=9KW88Oi/3ZXaarrrC4ZsvWG4Hpd/em+fpWGI4Vpm2J0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHdFk4k63YR4GJCMA4hbsJy0ZkXjpNWRII8bX2Mq4go6bQmh/+U9mLTphOmfpb3cUYJjD2DBfLZGOACYLLaq2B4G7KrMMcc3981WYt25TlfkA98wP0adTurekqXY75C0PKBfIGdFhtkzd7i5Ysza8cjc6RpamUi4H6nhK1i/g6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayH138E2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayH138E2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47bdbc90dcaso54333705e9.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325143; x=1768929943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBLQwLhTN6q/6GndgCAdusAWgKaKynnmHuXNr7E/FZM=;
        b=ayH138E2aSxwoGqWyTbtDr2BWeffWLyaleiuW6wGzHO6U6ODzv7k3PFIJ19pp/a+k8
         FBpAtKnYvPfkUdZRAYJVvqbJSPgQwY/3N3YTuJwk6ti4ldV+V2NIg67tll9KN3oAEzc1
         mSSLXIH5ueH7l5gcEg6okOFnCTvlJhKIv+IeNS1srMoO9NpZN5m751vCD55DZEkbIfnV
         PleV6wxiKb+mQYRk7FdsCfqfWYAV+jc5u0B76ErjXRmalGEYsq3/OxBxXeuFImVkzCDR
         3AJXSVZ8O7eD1Ow5nNDgeFUHeNelwt4s/1FIUefPXN67+x8+LUVbUktz1+b0mwiDaVpU
         FU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325143; x=1768929943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBLQwLhTN6q/6GndgCAdusAWgKaKynnmHuXNr7E/FZM=;
        b=GI7NGMaLp6HVHb7OQK8IHPLG3q9MsRgZ+fxdTQEDO87i7s7Tuz9bV+ERobXZd/yLLC
         Qfw5LcuUWlqZli4ynqQSMzCsbBrPuhQg3ZOiPxBqdq0QCIQs+BxgGpZbhd7ZA7e/QeQI
         kO2YmEYjOCULRt+nkGGzShRMHWAFC+8FNu6hJtJyLrf2xTpUuLLC6uCjEcTwYYNcM2PO
         PnJA+k98gqFjEOeYHjhCkVL1lc9FHIHwR8EnELdD8brs5wkO1YnTGjlCm8Qi1QdGnWYb
         VV4zY8ilXxhpNjV1g722iFp24rM0/3vrmBAVIPJDz1QxrNKoF3iJKvmHvaoVKxicHm4J
         ES7g==
X-Gm-Message-State: AOJu0YyTNVKYKDo55YrTL4CHploi4vuJWjSu7vXjNxcKmU5oua8Eciqv
	brro56cx+e1g8BcODLQDyghYJlKT1ZMHhDjxCFKNBd950TPK62xqCAPV
X-Gm-Gg: AY/fxX4iUGs/qORlmfBIEVGWE8V+UDOosxmH0bWceKpsD572odwnPQoDQLSU+srNinE
	tQHROPXZZZhJQ5cuObwQbKLvolpTBIheEgdHhPHKTN7dbYItbAe+JYq78od/mCwW0NbCqNSpK35
	z6LDBTI3JcmZj4gRAAp8D3xpJ7f3Oy7XCbiSGav7AgpEzitlotO61LyNq+1KUv6BJuOr3XJSwld
	xFVqJSOswSttzVfMaHBFaiU6aQ4I3ruUbdC3fANb8ZHhj+mvdtO1DBgjyxCQIxZagLuepZ6Io/e
	GnejLOoJdFjD36JV8eeu9as7jRy/c4/gxmeqiwNrHnUXe9s7CJxRSoY4JgMl96xUheUynAZuCDy
	MHbLASaLvBpgAcnmL2iPi+eunbl1ox01Mr6p1uhAzrEEw+xa9ZLuEu/CmCroTth333emwRS1/ep
	L2GYOt
X-Google-Smtp-Source: AGHT+IFsfS3tbReqqnuzjTcv8QZdMeHR44f7M0Pqw/P1eiO1S5MOJIRADejkw2bHuHG1VgO0zV0A6g==
X-Received: by 2002:a05:600c:4ed3:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-47d84b34785mr284685025e9.21.1768325142439;
        Tue, 13 Jan 2026 09:25:42 -0800 (PST)
Received: from ubuntu ([102.91.81.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86c6ff40sm346339225e9.2.2026.01.13.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:25:40 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 0/3] store git_default_config() parsed values in new config struct
Date: Tue, 13 Jan 2026 17:43:59 +0100
Message-Id: <cover.1768318762.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768217572.git.belkid98@gmail.com>
References: <cover.1768217572.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Git Community,
Over the course of my ongoing internship, which focused on moving global
variables in environment.h into local scope, I have attempted to move some
variables into the struct repo-settings.
However there have been some design concerns as regards the use of
`prepare_repo_settings()` with respect to when and where to call the
function, and also the change in behaviours when the variable is lazily
loaded as discussed in [1] and [2].

After different deliberations, Phillip Wood proposed creating a new config
struct [3], adding it to the repository struct and passing the repo struct to
`git_default_config()` to store the parsed config values per repo.
This ensures the current behaviours will be retained.

I have experimented with this approach for some values and I would
appreciate feedbacks about this approach before we can move forward
and use it for more variables related to `git_default_config()`.

For now, the parsed value is stored in `the_repository` in
`git_default_*_config()` and further efforts to pass the repository
parameter to `git_default_config()` as the callback parameter will
be looked into later on.
The link to the CI tests can be see in [4]

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
4. https://github.com/git/git/actions/runs/20953059862

Changes in v2:
==============
- Renamed new struct to repo_config_values
- Moved struct and functions declaration and definition to
  environment.[ch]
- embedded the new struct in the repository struct thereby removing the
  need to allocate memory on the heap

Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct
    repo_config_values`

 attr.c                      |  7 ++++---
 branch.h                    |  2 --
 builtin/backfill.c          |  3 +--
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  2 +-
 builtin/grep.c              |  2 +-
 builtin/mv.c                |  2 +-
 builtin/push.c              |  2 +-
 builtin/sparse-checkout.c   | 22 +++++++++++-----------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 dir.c                       |  2 +-
 environment.c               | 26 ++++++++++++++++----------
 environment.h               | 15 +++++++++++++--
 repository.c                |  1 +
 repository.h                |  4 ++++
 sparse-index.c              |  6 ++++--
 unpack-trees.c              |  2 +-
 wt-status.c                 |  2 +-
 20 files changed, 65 insertions(+), 43 deletions(-)

 Range diff versus v2
 ====================
1:  25fc10854e < -:  ---------- environment: stop storing `core.attributesFile` globally
-:  ---------- > 1:  b6f8deaa40 environment: stop storing `core.attributesFile` globally
2:  f25afc6f68 ! 2:  1e83c077f2 environment: stop using core.sparseCheckout globally
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>
     
      ## Commit message ##
    -    environment: stop using core.sparseCheckout globally
    +    environment: environment: stop using core.sparseCheckout globally
     
         The config value `core.sparseCheckout` is parsed in
         `git_default_core_config()` and stored globally in
    @@ Commit message
         when different Git repositories running in the same process access this
         variable.
     
    -    Move the parsed value into `struct config_values` which can be accessed
    -    per repo via `git_default_config()`. This would mean we do not need to
    -    remove code from `git_default_core_config()`, thereby retaining current
    -    behaviours.
    +    Move the parsed value into `struct repo_config_values` which holds all the
    +    values parsed by `git_default_config()` and can be accessed
    +    per repo via `git_default_config()`. This retains current
    +    behaviours while achieving the repository scoped access.
     
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Mentored-by: Christian Couder <christian.couder@gmail.com>
    @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
      
      	if (ctx.sparse < 0)
     -		ctx.sparse = core_apply_sparse_checkout;
    -+		ctx.sparse = repo->cfg_values->sparse_checkout;
    ++		ctx.sparse = repo->config_values.sparse_checkout;
      
      	result = do_backfill(&ctx);
      	backfill_context_clear(&ctx);
    @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
      	 * for the later checkout to use the sparse-checkout file.
      	 */
     -	core_apply_sparse_checkout = 1;
    -+	the_repository->cfg_values->sparse_checkout = 1;
    ++	the_repository->config_values.sparse_checkout = 1;
      
      	cmd.git_cmd = 1;
      	if (run_command(&cmd)) {
     
    + ## builtin/grep.c ##
    +@@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
    + 	 *	"forget" the sparse-index feature switch. As a result, the index
    + 	 *	of these submodules are expanded unexpectedly.
    + 	 *
    +-	 * 2. "core_apply_sparse_checkout"
    ++	 * 2. "sparse_checkout"
    + 	 *	When running `grep` in the superproject, this setting is
    + 	 *	populated using the superproject's configs. However, once
    + 	 *	initialized, this config is globally accessible and is read by
    +
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc,
      		rename_index_entry_at(the_repository->index, pos, dst);
      
      		if (ignore_sparse &&
     -		    core_apply_sparse_checkout &&
    -+			the_repository->cfg_values->sparse_checkout &&
    ++		    the_repository->config_values.sparse_checkout &&
      		    core_sparse_checkout_cone) {
      			/*
      			 * NEEDSWORK: we are *not* paying attention to
    @@ builtin/sparse-checkout.c: static int sparse_checkout_list(int argc, const char
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!the_repository->cfg_values->sparse_checkout)
    ++	if (!the_repository->config_values.sparse_checkout)
      		die(_("this worktree is not sparse"));
      
      	argc = parse_options(argc, argv, prefix,
    @@ builtin/sparse-checkout.c: static int set_config(struct repository *repo,
      static enum sparse_checkout_mode update_cone_mode(int *cone_mode) {
      	/* If not specified, use previous definition of cone mode */
     -	if (*cone_mode == -1 && core_apply_sparse_checkout)
    -+	if (*cone_mode == -1 && the_repository->cfg_values->sparse_checkout)
    ++	if (*cone_mode == -1 && the_repository->config_values.sparse_checkout)
      		*cone_mode = core_sparse_checkout_cone;
      
      	/* Set cone/non-cone mode appropriately */
     -	core_apply_sparse_checkout = 1;
    -+	the_repository->cfg_values->sparse_checkout = 1;
    ++	the_repository->config_values.sparse_checkout = 1;
      	if (*cone_mode == 1 || *cone_mode == -1) {
      		core_sparse_checkout_cone = 1;
      		return MODE_CONE_PATTERNS;
    @@ builtin/sparse-checkout.c: static int update_modes(struct repository *repo, int
      
      	/* Determine if we need to record the mode; ensure sparse checkout on */
     -	record_mode = (*cone_mode != -1) || !core_apply_sparse_checkout;
    -+	record_mode = (*cone_mode != -1) || !repo->cfg_values->sparse_checkout;
    ++	record_mode = (*cone_mode != -1) || !repo->config_values.sparse_checkout;
      
      	mode = update_cone_mode(cone_mode);
      	if (record_mode && set_config(repo, mode))
    @@ builtin/sparse-checkout.c: static int modify_pattern_list(struct repository *rep
      	}
      
     -	if (!core_apply_sparse_checkout) {
    -+	if (!repo->cfg_values->sparse_checkout) {
    ++	if (!repo->config_values.sparse_checkout) {
      		set_config(repo, MODE_ALL_PATTERNS);
     -		core_apply_sparse_checkout = 1;
    -+		repo->cfg_values->sparse_checkout = 1;
    ++		repo->config_values.sparse_checkout = 1;
      		changed_config = 1;
      	}
      
    @@ builtin/sparse-checkout.c: static int sparse_checkout_add(int argc, const char *
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo->cfg_values->sparse_checkout)
    ++	if (!repo->config_values.sparse_checkout)
      		die(_("no sparse-checkout to add to"));
      
      	repo_read_index(repo);
    @@ builtin/sparse-checkout.c: static int sparse_checkout_reapply(int argc, const ch
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo->cfg_values->sparse_checkout)
    ++	if (!repo->config_values.sparse_checkout)
      		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
      
      	reapply_opts.cone_mode = -1;
    @@ builtin/sparse-checkout.c: static int sparse_checkout_clean(int argc, const char
      
      	setup_work_tree();
     -	if (!core_apply_sparse_checkout)
    -+	if (!repo->cfg_values->sparse_checkout)
    ++	if (!repo->config_values.sparse_checkout)
      		die(_("must be in a sparse-checkout to clean directories"));
      	if (!core_sparse_checkout_cone)
      		die(_("must be in a cone-mode sparse-checkout to clean directories"));
    @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      
      	/*
     -	 * We do not exit early if !core_apply_sparse_checkout; due to the
    -+	 * We do not exit early if !repo->cfg_values->sparse_checkout; due to the
    ++	 * We do not exit early if !repo->config_values.sparse_checkout; due to the
      	 * ability for users to manually muck things up between
      	 *   direct editing of .git/info/sparse-checkout
      	 *   running read-tree -m u HEAD or update-index --skip-worktree
    @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      	hashmap_init(&pl.parent_hashmap, pl_hashmap_cmp, NULL, 0);
      	pl.use_cone_patterns = 0;
     -	core_apply_sparse_checkout = 1;
    -+	repo->cfg_values->sparse_checkout = 1;
    ++	repo->config_values.sparse_checkout = 1;
      
      	add_pattern("/*", empty_base, 0, &pl, 0);
      
    @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
      	 * the sparse-checkout patterns from the current worktree.
      	 */
     -	if (core_apply_sparse_checkout)
    -+	if (the_repository->cfg_values->sparse_checkout)
    ++	if (wt->repo->config_values.sparse_checkout)
      		copy_sparse_checkout(sb_repo.buf);
      
      	/*
     
    - ## config.h ##
    -@@ config.h: struct config_context {
    - struct config_values {
    - 	/* core config values */
    - 	char *attributes_file_path;
    -+	int sparse_checkout;
    - 
    - };
    - #define CONFIG_CONTEXT_INIT { 0 }
    -
      ## dir.c ##
     @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      
      int init_sparse_checkout_patterns(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout)
    -+	if (!istate->repo->cfg_values->sparse_checkout)
    ++	if (!istate->repo->config_values.sparse_checkout)
      		return 1;
      	if (istate->sparse_checkout_patterns)
      		return 0;
    @@ environment.c: static int git_default_core_config(const char *var, const char *v
      
     
      ## environment.h ##
    +@@ environment.h: struct strvec;
    + struct repo_config_values {
    + 	/* core config values */
    + 	char *attributes_file_path;
    ++	int sparse_checkout;
    + };
    + 
    + /*
     @@ environment.h: extern int precomposed_unicode;
      extern int protect_hfs;
      extern int protect_ntfs;
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
    -+	if (!istate->repo->cfg_values->sparse_checkout || !core_sparse_checkout_cone)
    ++	struct repo_config_values *cfg = &istate->repo->config_values;
    ++	if (!cfg->sparse_checkout || !core_sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct i
      void clear_skip_worktree_from_present_files(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout ||
    -+	if (!istate->repo->cfg_values->sparse_checkout ||
    ++	struct repo_config_values *cfg = &istate->repo->config_values;
    ++	if (!cfg->sparse_checkout ||
      	    sparse_expect_files_outside_of_patterns)
      		return;
      
    @@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpac
      		update_sparsity_for_prefix(o->prefix, o->src_index);
      
     -	if (!core_apply_sparse_checkout || !o->update)
    -+	if (!repo->cfg_values->sparse_checkout || !o->update)
    ++	if (!repo->config_values.sparse_checkout || !o->update)
      		o->skip_sparse_checkout = 1;
      	if (!o->skip_sparse_checkout) {
      		memset(&pl, 0, sizeof(pl));
     
      ## wt-status.c ##
    -@@
    - #include "lockfile.h"
    - #include "sequencer.h"
    - #include "fsmonitor-settings.h"
    -+#include "config.h"
    - 
    - #define AB_DELAY_WARNING_IN_MS (2 * 1000)
    - #define UF_DELAY_WARNING_IN_MS (2 * 1000)
     @@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
      	int skip_worktree = 0;
      	int i;
      
     -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
    -+	if (!r->cfg_values->sparse_checkout || r->index->cache_nr == 0) {
    ++	if (!r->config_values.sparse_checkout || r->index->cache_nr == 0) {
      		/*
      		 * Don't compute percentage of checked out files if we
      		 * aren't in a sparse checkout or would get division by 0.
3:  1c86c72f2d < -:  ---------- environment: move "branch.autoSetupMerge" into `struct config_values`
-:  ---------- > 3:  6e54e22ac7 environment: move "branch.autoSetupMerge" into `struct repo_config_values`

-- 
2.34.1

