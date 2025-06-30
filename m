Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BEFE56A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311733; cv=none; b=LO+BEmsGq9kg6ZVGoNpsthhxAWgeKum/6BH0RxWqmIif1GyHhfzOjv2RUR/AXA5Hgr249h9FB0/jnLjvnneDq9tBWJpWEScvAE1h45ghDYwMuUwJlr6ug8knpzLIiR1a+j21JRQ48Hud4RB9lfe4Xdj00m1qyrkU1IS4H+LaXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311733; c=relaxed/simple;
	bh=LStDzzuiYJscGvE1k8TJ9fjHfUeY4fU9ebYJhrCGZNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8qZ3fQlzZX7E+/FZFkisZWAQY+deOV6jQ2WUean1OiAMBRSbklvzWVluh2QUZ6GOLGeqUW+23TvkbWdjn31HSuyRBMYw/hZzS182S1T1HoWOoBxdOl9Y9wODVsTOl8GVNDupkcTKNTX3+WoD70xc1H8FmcrtaFc+b1A50uOZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhDQwO4P; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhDQwO4P"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3226049b3a.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311731; x=1751916531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F+Bp6JwLADtGYt0k8oukPDq5McMj7Awt/9Okcb8+tA=;
        b=UhDQwO4Pvn4tQUQUTA4ky85MSJVqX0kAAqWzs4PdEBXIZ3UARet3kYTlC2TF2OZWtJ
         a19cCwg7pf+Q9xXz99mh6r3whzIgB+JV+O19RpOrTi+i6P9ZaknGYWynuIvUk797LCZ0
         VOV3ZFoPF74/HtcxH++YfzM5hrzBoVHdT/nFT3dyWlxABD1o8Vmz319GRTqpSF6y81H/
         UJlOcO58RRKFtFXIJ2s2fNZ4ZxBeXQorUVK/U7rKJCyGMwqyBM/GIChhkwPRTDA4Jvye
         CXnJSCkkTQWm+P1nabtet9SRgnjNrPdYk8QWD63QD8bz7j2GLwpUUzpk5OsCKm0ssGDs
         GOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311731; x=1751916531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F+Bp6JwLADtGYt0k8oukPDq5McMj7Awt/9Okcb8+tA=;
        b=lpd2soKnljEIgf4BsYNcStNeWvE+Ri2NFVe8yPEoXW5/Qx6J7z10jEpIZle++mVpXI
         WOunnbsTRnI6NMPYvzx2zEjrzZ1mdrPrNlgdZKqVNEgtq2Uda5UVSUDlU8oX8cKxACBv
         HDfA5pkEFI4WzmTn2Gk5AEWboJvofv83eg02tVAlpKsz+P18SX2DiGMBV9MaeVI++X0t
         eD4jHKG2/W5FNF0ser6PyhXuss4UIExSW6LQ/24lvPm+XMOe7RF3zF/0Z6Fw+JK8sGIE
         yH4bJahnUptSh4U7/8TSHCVnUh3eBQCIPkXewIw9HHbBLNxISuwDTcYiD5qDW7mCKNZG
         SPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW49sGSOdCYTwptTCF9uqx1TuvlnWovPiEXsXwMtQnTWfIqjPF9hFJ5s6NJZy0188zDczI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqXLCzvrLPpjr5LLtlEm+enT3bF2ZtpI/HllfCDX40+ojeTFA
	2nqbHf+bgB4pgCXaJarZuLdir+Ic4BEaWd4y/60Njum0qYXdsF8Phe8f
X-Gm-Gg: ASbGncuk7qPN8Us1w3FtW+adj9NhmgiMRNkXJImGfrdGpteHEpkB7n6FuecP4jux6M/
	MA6fcuVv0wSHyiDObvKKKHuLFq/dkI/1v0QB3X+en5B8LW79+qd1lykpB/HDdeGZwFYwwkvfiKu
	YT0L9kk6puXXWqrDxxubJrAyMeZiISeTAMBVAa0Lz1fMFSReWQh0d+c4jhmjNx0N9RU++O43/xK
	ztlcJ3crSyDSeWh/82jTM3UjppA6c075hICTihLxrtJazF9PoWSCCNdC4vF5hR1aDFZerGYJq99
	hRt7Ix0KdyjrH65HXsv3VLNeBHqHUh+DINdOTlx9yXwBg0sw9kOopY/7IUYAyqUQzB+HRJJT2Eh
	0Jw==
X-Google-Smtp-Source: AGHT+IFqUwz4oyo/B4ildUQIO66aSouS3tBLRpAFv2ldCw4eyLBlS3ufYsmO3DfhtmaAW+M+Jmsb4Q==
X-Received: by 2002:a05:6a20:4392:b0:1f5:9098:e448 with SMTP id adf61e73a8af0-220a114326dmr20671968637.5.1751311730834;
        Mon, 30 Jun 2025 12:28:50 -0700 (PDT)
Received: from thinku.localdomain ([110.226.180.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b27dsm9757779b3a.84.2025.06.30.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:28:50 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v5 0/3] environment: remove sparse-checkout related global variables
Date: Tue,  1 Jul 2025 00:57:45 +0530
Message-ID: <cover.1751309770.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603131806.14915-1-ayu.chandekar@gmail.com>
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to remove global variables related to sparse-checkout from the global scope and to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from a few files.

It contains three patches:

1 - Remove the global variable 'core_apply_sparse_checkout' and move its setting to the 'struct repo_settings'. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "builtin/backfill.c". 

2 - Remove the global variable 'core_sparse_checkout_cone' and move its setting to the 'struct repo_settings'.

3 - Remove the global variable 'sparse_expect_files_outside_of_patterns` and localize it in the function which calls it. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "sparse-index.c"

Thanks a lot to Christian for mentoring, and to Junio, Patrick and Ben for reviewing.

Ayush Chandekar (2):
  environment: move access to "core.sparsecheckoutcone" into
    repo_settings
  environment: remove the global variable
    'sparse_expect_files_outside_of_patterns'
  environment: move access to "core.sparsecheckout" into repo_settings

 builtin/backfill.c        |  7 ++----
 builtin/clone.c           |  3 ++-
 builtin/grep.c            |  4 ++--
 builtin/mv.c              |  6 ++---
 builtin/sparse-checkout.c | 49 +++++++++++++++++++--------------------
 builtin/worktree.c        |  2 +-
 config.c                  | 24 -------------------
 dir.c                     |  5 ++--
 environment.c             |  3 ---
 environment.h             |  4 ----
 repo-settings.c           |  2 ++
 repo-settings.h           |  3 +++
 sparse-index.c            | 10 ++++----
 unpack-trees.c            |  3 ++-
 wt-status.c               |  3 ++-
 15 files changed, 52 insertions(+), 76 deletions(-)

-- 

Summary of range-diff:
* Ensure that `prepare_repo_settings()` is called in all code paths before accessing `settings.sparse_checkout` and `settings.sparse_checkout_cone`.

Range-diff with v4:
1:  e221c68ab5 ! 1:  ba9929d128 environment: move access to "core.sparsecheckout" into repo_settings
    @@ Commit message
         `core_apply_sparse_checkout` and is populated in config.c. Refactor the
         code to store it in the variable `sparse_checkout` in the struct
         `repo_settings`.
    -    It's fine not to lazily load it from the config, as the variable
    -    is used quite commonly.
    +
    +    Call `prepare_repo_settings()` where necessary to ensure the `struct
    +    repo_settings` is initialized before use:
    +    - In "builtin/backfill.c", "builtin/mv.c" and "builtin/clone.c" call
    +      `prepare_repo_settings()` since their respective `cmd_*()` functions
    +      did not call it earlier.
    +    - In "dir.c", the function using 'settings.sparse_checkout' is invoked
    +      in multiple files that do not call `prepare_repo_settings()`, hence
    +      add a call directly to that function.
    +    - In "sparse-checkout.c", add a call to `prepare_repo_settings()` inside
    +      `is_sparse_index_allowed()`, as it is used widely and relies on the
    +      setting.
    +    - In "wt-status.c", call `prepare_repo_settings()` before accessing
    +      the setting because the function using it is commonly used.
    +
    +    Avoid reduntant calls to `prepare_repo_settings()` where it is already
    +    present:
    +    - In "builtin/worktree.c", it is already invoked in `cmd_worktree()`
    +      before the setting is accessed.
    +    - In "unpack-tress.c", the function accessing the setting already calls
    +      it.
     
         This also allows us to remove the definition `#define
         USE_THE_REPOSITORY_VARIABLE` from the file 'builtin/backfill.c'.
    @@ builtin/backfill.c: int cmd_backfill(int argc, const char **argv, const char *pr
     
      ## builtin/clone.c ##
     @@ builtin/clone.c: static int git_sparse_checkout_init(const char *repo)
    + 	int result = 0;
    + 	strvec_pushl(&cmd.args, "-C", repo, "sparse-checkout", "set", NULL);
    + 
    ++	prepare_repo_settings(the_repository);
    + 	/*
      	 * We must apply the setting in the current process
      	 * for the later checkout to use the sparse-checkout file.
      	 */
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 *	of these submodules are expanded unexpectedly.
      	 *
     -	 * 2. "core_apply_sparse_checkout"
    -+	 * 2. "sparse_checkout"
    ++	 * 2. "settings.sparse_checkout"
      	 *	When running `grep` in the superproject, this setting is
      	 *	populated using the superproject's configs. However, once
      	 *	initialized, this config is globally accessible and is read by
     
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc,
    + 						       &st,
    + 						       0);
      		rename_index_entry_at(the_repository->index, pos, dst);
    - 
    +-
    ++		prepare_repo_settings(the_repository);
      		if (ignore_sparse &&
     -		    core_apply_sparse_checkout &&
     +		    the_repository->settings.sparse_checkout &&
    @@ builtin/sparse-checkout.c: static int sparse_checkout_disable(int argc, const ch
      
      	add_pattern("/*", empty_base, 0, &pl, 0);
      
    +-	prepare_repo_settings(the_repository);
    + 	the_repository->settings.sparse_index = 0;
    + 
    + 	if (update_working_directory(&pl))
     
      ## builtin/worktree.c ##
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
    @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      int init_sparse_checkout_patterns(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout)
    ++	prepare_repo_settings(istate->repo);
     +	if (!istate->repo->settings.sparse_checkout)
      		return 1;
      	if (istate->sparse_checkout_patterns)
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
    ++	prepare_repo_settings(istate->repo);
     +	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    +@@ sparse-index.c: int is_sparse_index_allowed(struct index_state *istate, int flags)
    + 		/*
    + 		 * Only convert to sparse if index.sparse is set.
    + 		 */
    +-		prepare_repo_settings(istate->repo);
    + 		if (!istate->repo->settings.sparse_index)
    + 			return 0;
    + 	}
     @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct index_state *ista
      
      void clear_skip_worktree_from_present_files(struct index_state *istate)
    @@ wt-status.c: static void wt_status_check_sparse_checkout(struct repository *r,
      	int i;
      
     -	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
    ++	prepare_repo_settings(r);
     +	if (!r->settings.sparse_checkout || r->index->cache_nr == 0) {
      		/*
      		 * Don't compute percentage of checked out files if we
2:  9a63884341 ! 2:  5a2f61443b environment: move access to "core.sparsecheckoutcone" into repo_settings
    @@ Commit message
         `core_sparse_checkout_cone` and is populated in config.c. Refactor the
         code to store it in the variable `sparse_checkout_cone` in the struct
         `repo_settings`.
    -    It's fine not to lazily load it from the config, as the variable
    -    is used quite commonly.
    +
    +    Call `prepare_repo_settings()` where necessary to ensure the `struct
    +    repo_settings` is initialized before use:
    +    - In "dir.c", the function accessing the setting is usually called after
    +      `prepare_repo_settings()`, except for one code path in
    +      "unpack-trees.c", so add a call there.
    +
    +    Avoid redundant calls to `prepare_repo_settings()` where it is already
    +    present:
    +    - In "builtin/mv.c" and "builtin/sparse-checkout.c", it is already
    +      invoked in their respective `cmd_*()` functions.
    +    - In "sparse-index.c", `prepare_repo_settings` is already called before
    +      the setting is accessed.
     
         This change is part of an ongoing effort to eliminate global variables,
         improve modularity and help libify the codebase.
    @@ builtin/grep.c: static int grep_submodule(struct grep_opt *opt,
      	 *	sparse-checkout state.
      	 *
     -	 * 3. "core_sparse_checkout_cone"
    -+	 * 3. "sparse_checkout_cone"
    ++	 * 3. "settings.sparse_checkout_cone"
      	 *	ditto.
      	 *
      	 * Note that this list is not exhaustive.
     
      ## builtin/mv.c ##
     @@ builtin/mv.c: int cmd_mv(int argc,
    - 
    + 		prepare_repo_settings(the_repository);
      		if (ignore_sparse &&
      		    the_repository->settings.sparse_checkout &&
     -		    core_sparse_checkout_cone) {
    @@ repo-settings.h: struct repo_settings {
     
      ## sparse-index.c ##
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate)
    - 
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
    + 	prepare_repo_settings(istate->repo);
     -	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
     +	if (!istate->repo->settings.sparse_checkout || !istate->repo->settings.sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    +
    + ## unpack-trees.c ##
    +@@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
    + 		BUG("update_sparsity() called wrong");
    + 
    + 	trace_performance_enter();
    ++	prepare_repo_settings(the_repository);
    + 
    + 	/* If we weren't given patterns, use the recorded ones */
    + 	if (!pl) {
3:  578c087188 = 3:  45c84a6615 environment: remove the global variable 'sparse_expect_files_outside_of_patterns'


2.49.0

