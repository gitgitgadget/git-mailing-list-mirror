Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C112CDBE
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720202; cv=pass; b=rhp3r7+VM5CIGotgbVJ6WfmyWtMVOYS/dUZV0e5HaLC0NYU7AhyjZjlVXr5lifUcyPJRgPsrzTZlCYD/clMUdX1VAbCYGHDR1+ya/uuM/cekT0QdiJhyV/c9JPcNZBGZ/4VGEKGEg5rWvQuJURjuHymKO2uirKCkxa4NSBXReqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720202; c=relaxed/simple;
	bh=hfXGv/VWeRGpy3H0wN/9CnD7hCzTY2v0XO8jQz7mQcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcfnww3tlE9+0Za4RQow3RXl4SKFOESQ+taTSgcd4uVaK7tN1Zj6ELwytTfbuXiheGnVbIi4bESfp1xfz1ycnnRLK/ayVh6ZFQoad/lWsP4jBhTj2z1gcxS0IUCuCJTSqjKfYu2nI8AgvRUAR4VBQQSRE+zavrjt6uUBU9s5+wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AWHa5ElL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AWHa5ElL"
ARC-Seal: i=1; a=rsa-sha256; t=1771720182; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i7aW1HXd+1Jy4D9pYj7JtrRWxOKN4niwdAPiQUlaLnOen3e2goRJifVZgFgEeOKm62RJygUUEwUJlKQuH4Ov4gQcyfFHJY8T3V5zQnmrwzMa0sobfpGYP0kM6ddgDgK39Y10oAJIY5xQBslZC9nMDA5S2K5kfaVrL2BJ7xUeUKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771720182; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RCr+2pHEu0o56f6uDCMoU8r+EDSh7QweUWty6IE88R8=; 
	b=HYwAhxdkTncp2Fl4NqwmNkn1176Gsw33cpESVS/zwRooS0MfqwxvaJX3bidJb+kS2LWXZdxvDHZsL8S3GtiJV4vdn0l0kqSDTpf8rLf/Qd59pZ4zfQ/gW0bNy1STTA2tZORMrUiBH/e72CeUEn3vazvEIxz0tTlKARk7CkLzLkU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771720182;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RCr+2pHEu0o56f6uDCMoU8r+EDSh7QweUWty6IE88R8=;
	b=AWHa5ElLJgRb6o4aTDJ/sjzxN3n1UPOdOf/yYZKDzm4icMSPOQDBXyp7Xs09l47e
	xYxQ4uG/TrWgVVl+cfqiTrR2ffi72DkFxnn26hinO7AiAAf4ViaU0mXO+NGYn4YVsTO
	Cn+wKN3/TCHIPkITLnRtNiO4i7qr3w9QbFQjYb2g=
Received: by mx.zohomail.com with SMTPS id 1771720157289694.5867523293965;
	Sat, 21 Feb 2026 16:29:17 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 00/10] Run hooks in parallel
Date: Sun, 22 Feb 2026 02:28:54 +0200
Message-ID: <20260222002904.1879356-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series enables running hook commands in parallel and is based on
the v2 series enabling config hooks [1], which added the ability to run
a list of hooks for each event.

In v2 I've addressed all the feedback received in v1, the biggest design
change being that it's all disabled by default and users need to enable
parallelism via the documented mechanisms.

I also split the logic into more commits to make things easier to review,
that is the main reason why this grew from 4 to 10 patches.

Branch pushed to GitHub containing all dependency patches: [2]
Successful CI run: [3]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Phillip, Brian, Peff and many others.

Thank you,
Adrian

1: https://lore.kernel.org/git/20260204165126.1548805-1-adrian.ratiu@collabora.com/T/#m8ceab5819683cd70473055f780444ad7bccf7284
2: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/parallel-hooks-v2
3: https://github.com/10ne1/git/actions/runs/22266919210

Changes in v2:
* Default hooks to sequential execution (jobs == 1) like before (Patrick, Phillip)
* Parallel execution becomes an opt-in feature (Patrick, Phillip)
* Reworked RUN_HOOKS_OPT_INIT macros to reflect the above design (Adrian)
* Simplify get_hook_jobs() after the above redesign decisions (Adrian)
* Documented hooks which are always run sequentially (Patrick)
* New commits: split the big "add parallel hooks" commit into smaller ones (Adrian)
* New commit: add a memleak fix (Adrian)
* Added a struct hook_config_cache_entry because we're storing more
  than 1 command per hook inthe cache now (Adrian)
* Cache is used for all hook.* configs which are read in 1 pass (Adrian)
* Improved parallel tests to use sentinel files instead of plain sleeps
  to make them more reliable (Adrian)
* Added more hook tests to improve coverage (Adrian)
* Rebased on latest master and fixed trivial conficts with a newly added
  submodule extension in the master branch (Adrian)
* Reworded commit messages to reflect the new design (Patrick)
* Minor style cleanups, improve code comments (Patrick, Adrian)

Range-diff v1 -> v2:
 -:  ---------- >  1:  f28b0270f9 repository: fix repo_init() memleak due to missing _clear()
 1:  a632a9b937 !  2:  c7cc106224 config: add a repo_config_get_uint() helper
    @@ Metadata
      ## Commit message ##
         config: add a repo_config_get_uint() helper
     
    -    Next commit adds a 'hook.jobs' config option of type 'unsigned int',
    +    Next commits add a 'hook.jobs' config option of type 'unsigned int',
         so add a helper to parse it since the API only supports int and ulong.
     
         An alternative is to make 'hook.jobs' an 'int' or parse it as an 'int'
 2:  724e8403e0 <  -:  ---------- hook: allow parallel hook execution
 -:  ---------- >  3:  2fe5aa34d6 hook: refactor hook_config_cache from strmap to named struct
 -:  ---------- >  4:  23853aa170 hook: parse the hook.jobs config
 -:  ---------- >  5:  71380942dc hook: allow parallel hook execution
 -:  ---------- >  6:  820064f1c9 hook: mark non-parallelizable hooks
 -:  ---------- >  7:  b328f3451f hook: add -j/--jobs option to git hook run
 -:  ---------- >  8:  ff27b34a8d hook: add per-event jobs config
 3:  edea5408e1 !  9:  2bc572e46e hook: introduce extensions.hookStdoutToStderr
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/extensions.adoc ##
    -@@ Documentation/config/extensions.adoc: relativeWorktrees:::
    - 	repaired with either the `--relative-paths` option or with the
    - 	`worktree.useRelativePaths` config set to `true`.
    +@@ Documentation/config/extensions.adoc: The extension can be enabled automatically for new repositories by setting
    + `init.defaultSubmodulePathConfig` to `true`, for example by running
    + `git config --global init.defaultSubmodulePathConfig true`.
      
     +hookStdoutToStderr:::
     +	If enabled, the stdout of all hooks is redirected to stderr. This
    @@ Documentation/config/extensions.adoc: relativeWorktrees:::
     
      ## Documentation/config/hook.adoc ##
     @@ Documentation/config/hook.adoc: hook.jobs::
    - 	Specifies how many hooks can be run simultaneously during parallelized
    - 	hook execution. If unspecified, defaults to the number of processors on
    - 	the current system.
    + +
    + This setting has no effect unless all configured hooks for the event have
    + `hook.<name>.parallel` set to `true`.
     ++
     +This has no effect for hooks requiring separate output streams (like `pre-push`)
     +unless `extensions.hookStdoutToStderr` is enabled.
     
      ## repository.c ##
     @@ repository.c: int repo_init(struct repository *repo,
    - 	repo->repository_format_worktree_config = format.worktree_config;
      	repo->repository_format_relative_worktrees = format.relative_worktrees;
      	repo->repository_format_precious_objects = format.precious_objects;
    + 	repo->repository_format_submodule_path_cfg = format.submodule_path_cfg;
     +	repo->repository_format_hook_stdout_to_stderr = format.hook_stdout_to_stderr;
      
      	/* take ownership of format.partial_clone */
    @@ repository.c: int repo_init(struct repository *repo,
     
      ## repository.h ##
     @@ repository.h: struct repository {
    - 	int repository_format_worktree_config;
      	int repository_format_relative_worktrees;
      	int repository_format_precious_objects;
    + 	int repository_format_submodule_path_cfg;
     +	int repository_format_hook_stdout_to_stderr;
      
      	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
    @@ repository.h: struct repository {
     
      ## setup.c ##
     @@ setup.c: static enum extension_result handle_extension(const char *var,
    - 	} else if (!strcmp(ext, "relativeworktrees")) {
    - 		data->relative_worktrees = git_config_bool(var, value);
    + 	} else if (!strcmp(ext, "submodulepathconfig")) {
    + 		data->submodule_path_cfg = git_config_bool(var, value);
      		return EXTENSION_OK;
     +	} else if (!strcmp(ext, "hookstdouttostderr")) {
     +		data->hook_stdout_to_stderr = git_config_bool(var, value);
    @@ setup.c: static enum extension_result handle_extension(const char *var,
      	return EXTENSION_UNKNOWN;
      }
     @@ setup.c: const char *setup_git_directory_gently(int *nongit_ok)
    - 				repo_fmt.worktree_config;
    - 			the_repository->repository_format_relative_worktrees =
      				repo_fmt.relative_worktrees;
    + 			the_repository->repository_format_submodule_path_cfg =
    + 				repo_fmt.submodule_path_cfg;
     +			the_repository->repository_format_hook_stdout_to_stderr =
     +				repo_fmt.hook_stdout_to_stderr;
      			/* take ownership of repo_fmt.partial_clone */
      			the_repository->repository_format_partial_clone =
      				repo_fmt.partial_clone;
     @@ setup.c: void check_repository_format(struct repository_format *fmt)
    - 		fmt->worktree_config;
    + 		fmt->submodule_path_cfg;
      	the_repository->repository_format_relative_worktrees =
      		fmt->relative_worktrees;
     +	the_repository->repository_format_hook_stdout_to_stderr =
    @@ setup.c: void check_repository_format(struct repository_format *fmt)
     
      ## setup.h ##
     @@ setup.h: struct repository_format {
    - 	char *partial_clone; /* value of extensions.partialclone */
      	int worktree_config;
      	int relative_worktrees;
    + 	int submodule_path_cfg;
     +	int hook_stdout_to_stderr;
      	int is_bare;
      	int hash_algo;
    @@ t/t1800-hook.sh: test_expect_success 'client hooks: pre-push expects separate st
      '
      
     +test_expect_success 'client hooks: extension makes pre-push merge stdout to stderr' '
    -+	test_when_finished "rm -f stdout.actual stderr.actual" &&
    ++	test_when_finished "rm -rf remote2 stdout.actual stderr.actual" &&
     +	git init --bare remote2 &&
     +	git remote add origin2 remote2 &&
     +	test_commit B &&
    -+	# repositoryformatversion=1 might be already set (eg default sha256)
    -+	# so check before using test_config to set it
    -+	{ test "$(git config core.repositoryformatversion)" = 1 ||
    -+	  test_config core.repositoryformatversion 1; } &&
     +	git config set core.repositoryformatversion 1 &&
     +	test_config extensions.hookStdoutToStderr true &&
     +	setup_hooks pre-push &&
    @@ t/t1800-hook.sh: test_expect_success 'client hooks: pre-push expects separate st
     +'
     +
     +test_expect_success 'client hooks: pre-push defaults to serial execution' '
    -+	test_when_finished "rm -rf repo-serial" &&
    ++	test_when_finished "rm -rf remote-serial repo-serial" &&
     +	git init --bare remote-serial &&
     +	git init repo-serial &&
     +	git -C repo-serial remote add origin ../remote-serial &&
     +	test_commit -C repo-serial A &&
     +
    -+	# Setup 2 pre-push hooks
    -+	write_script repo-serial/.git/hooks/pre-push <<-EOF &&
    -+	sleep 2
    -+	echo "Hook 1" >&2
    -+	EOF
    ++	# Setup 2 pre-push hooks; no parallel=true so they must run serially.
    ++	# Use sentinel/detector pattern: hook-1 (sentinel, configured) runs first
    ++	# because configured hooks precede traditional hooks in list order; hook-2
    ++	# (detector) runs second and checks whether hook-1 has finished.
    ++	git -C repo-serial config hook.hook-1.event pre-push &&
    ++	git -C repo-serial config hook.hook-1.command \
    ++	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
     +	git -C repo-serial config hook.hook-2.event pre-push &&
    -+	git -C repo-serial config hook.hook-2.command "sleep 2; echo Hook 2 >&2" &&
    ++	git -C repo-serial config hook.hook-2.command \
    ++	    "$(sentinel_detector sentinel hook.order)" &&
     +
     +	git -C repo-serial config hook.jobs 2 &&
     +
    -+	start=$(date +%s) &&
     +	git -C repo-serial push origin HEAD >out 2>err &&
    -+	end=$(date +%s) &&
    -+
    -+	duration=$((end - start)) &&
    -+	# Serial >= 4s, parallel < 4s.
    -+	test $duration -ge 4
    ++	echo serial >expect &&
    ++	test_cmp expect repo-serial/hook.order
     +'
     +
      test_expect_success 'client hooks: commit hooks expect stdout redirected to stderr' '
    @@ t/t1800-hook.sh: test_expect_success 'client hooks: pre-push expects separate st
     
      ## transport.c ##
     @@ transport.c: static int run_pre_push_hook(struct transport *transport,
    - 	opt.copy_feed_pipe_cb_data = copy_pre_push_hook_data;
    - 	opt.free_feed_pipe_cb_data = free_pre_push_hook_data;
    + 	opt.feed_pipe_cb_data_alloc = pre_push_hook_data_alloc;
    + 	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;
      
     -	/*
     -	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
     -	 * them to keep backwards compatibility with existing hooks.
     -	 */
     -	opt.stdout_to_stderr = 0;
    -+	/* merge stdout to stderr only when extensions.StdoutToStderr is enabled */
    ++	/* merge stdout to stderr only when extensions.hookStdoutToStderr is enabled */
     +	opt.stdout_to_stderr = the_repository->repository_format_hook_stdout_to_stderr;
      
      	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 4:  4c85640615 ! 10:  35dbc4a6c5 hook: allow runtime enabling extensions.hookStdoutToStderr
    @@ Documentation/config/extensions.adoc: in parallel to be grouped (de-interleaved)
      	If enabled, then worktrees will load config settings from the
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.jobs::
    +@@ Documentation/config/hook.adoc: This setting has no effect unless all configured hooks for the event have
      +
      This has no effect for hooks requiring separate output streams (like `pre-push`)
      unless `extensions.hookStdoutToStderr` is enabled.
    @@ Documentation/config/hook.adoc: hook.jobs::
     +	parallel execution for hooks like `pre-push`.
     
      ## hook.c ##
    -@@ hook.c: static unsigned int get_hook_jobs(struct repository *r, struct run_hooks_opt *op
    - {
    - 	unsigned int jobs = options->jobs;
    +@@ hook.c: struct hook_config_cache_entry {
    +  * event_jobs: event-name to per-event jobs count (heap-allocated unsigned int *,
    +  *             where NULL == unset).
    +  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
    ++ * force_stdout_to_stderr: value of hook.forceStdoutToStderr. Defaults to 0.
    +  */
    + struct hook_all_config_cb {
    + 	struct strmap commands;
    +@@ hook.c: struct hook_all_config_cb {
    + 	struct strmap parallel_hooks;
    + 	struct strmap event_jobs;
    + 	unsigned int jobs;
    ++	int force_stdout_to_stderr;
    + };
      
    -+	/*
    -+	 * Allow hook.forceStdoutToStderr to enable extensions.hookStdoutToStderr
    -+	 * for existing repositories (runtime override).
    -+	 */
    -+	if (!options->stdout_to_stderr) {
    -+		int v = 0;
    -+		repo_config_get_bool(r, "hook.forceStdoutToStderr", &v);
    -+		options->stdout_to_stderr = v;
    -+	}
    + /* repo_config() callback that collects all hook.* configuration in one pass. */
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 				warning(_("hook.jobs must be positive, ignoring: 0"));
    + 			else
    + 				data->jobs = v;
    ++		} else if (!strcmp(subkey, "forcestdouttostderr") && value) {
    ++			int v = git_parse_maybe_bool(value);
    ++			if (v >= 0)
    ++				data->force_stdout_to_stderr = v;
    + 		}
    + 		return 0;
    + 	}
    +@@ hook.c: static void build_hook_config_map(struct repository *r,
    + 
    + 	cache->jobs = cb_data.jobs;
    + 	cache->event_jobs = cb_data.event_jobs;
    ++	cache->force_stdout_to_stderr = cb_data.force_stdout_to_stderr;
    + 
    + 	strmap_clear(&cb_data.commands, 1);
    + 	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
    +@@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
    + 	strvec_clear(&options->args);
    + }
    + 
    ++static void hook_force_apply_stdout_to_stderr(struct repository *r,
    ++					      struct run_hooks_opt *options)
    ++{
    ++	int force = 0;
    ++
    ++	if (r && r->gitdir && r->hook_config_cache)
    ++		force = r->hook_config_cache->force_stdout_to_stderr;
    ++	else
    ++		repo_config_get_bool(r, "hook.forceStdoutToStderr", &force);
    ++
    ++	if (force)
    ++		options->stdout_to_stderr = 1;
    ++}
     +
    + /* Determine how many jobs to use for hook execution. */
    + static unsigned int get_hook_jobs(struct repository *r,
    + 				  struct run_hooks_opt *options,
    +@@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
    + 	unsigned int jobs;
    + 
      	/*
    - 	 * Hooks which configure stdout_to_stderr=0 (like pre-push), expect separate
    - 	 * output streams. Unless extensions.StdoutToStderr is enabled (which forces
    +-	 * Hooks needing separate output streams must run sequentially. Next
    +-	 * commits will add an extension to allow parallelizing these as well.
    ++	 * Apply hook.forceStdoutToStderr before anything else: it affects
    ++	 * whether we can run in parallel or not.
    + 	 */
    ++	hook_force_apply_stdout_to_stderr(r, options);
    ++
    ++	/* Hooks needing separate output streams must run sequentially. */
    + 	if (!options->stdout_to_stderr)
    + 		return 1;
    + 
    +
    + ## hook.h ##
    +@@ hook.h: struct hook_config_cache {
    + 	struct strmap hooks; /* maps event name -> string_list of hooks */
    + 	struct strmap event_jobs; /* maps event name -> heap-allocated unsigned int * */
    + 	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
    ++	int force_stdout_to_stderr; /* hook.forceStdoutToStderr config value */
    + };
    + 
    + /**
     
      ## setup.c ##
     @@ setup.c: void initialize_repository_version(int hash_algo,
    - {
      	struct strbuf repo_version = STRBUF_INIT;
      	int target_version = GIT_REPO_VERSION;
    + 	int default_submodule_path_config = 0;
     +	int default_hook_stdout_to_stderr = 0;
      
      	/*
      	 * Note that we initialize the repository version to 1 when the ref
     @@ setup.c: void initialize_repository_version(int hash_algo,
    - 		clear_repository_format(&repo_fmt);
    + 		repo_config_set(the_repository, "extensions.submodulepathconfig", "true");
      	}
      
     +	repo_config_get_bool(the_repository, "hook.forceStdoutToStderr",
    @@ setup.c: void initialize_repository_version(int hash_algo,
      
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 config runs hooks in parallel' '
    - 	test $duration -lt 4
    +@@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs still requires hook.<name>.parallel=true'
    + 	test_cmp expect hook.order
      '
      
     +test_expect_success '`git init` respects hook.forceStdoutToStderr' '
    @@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 config runs hooks in parallel'
     +'
     +
     +test_expect_success 'hook.forceStdoutToStderr enables pre-push parallel runs' '
    -+	test_when_finished "rm -rf repo-parallel" &&
    ++	test_when_finished "rm -rf repo-parallel remote-parallel" &&
     +	git init --bare remote-parallel &&
     +	git init repo-parallel &&
     +	git -C repo-parallel remote add origin ../remote-parallel &&
     +	test_commit -C repo-parallel A &&
     +
    -+	write_script repo-parallel/.git/hooks/pre-push <<-EOF &&
    -+	sleep 2
    -+	echo "Hook 1" >&2
    -+	EOF
    ++	write_sentinel_hook repo-parallel/.git/hooks/pre-push &&
     +	git -C repo-parallel config hook.hook-2.event pre-push &&
    -+	git -C repo-parallel config hook.hook-2.command "sleep 2; echo Hook 2 >&2" &&
    ++	git -C repo-parallel config hook.hook-2.command \
    ++	    "$(sentinel_detector sentinel hook.order)" &&
    ++	git -C repo-parallel config hook.hook-2.parallel true &&
     +
     +	git -C repo-parallel config hook.jobs 2 &&
     +	git -C repo-parallel config hook.forceStdoutToStderr true &&
     +
    -+	start=$(date +%s) &&
     +	git -C repo-parallel push origin HEAD >out 2>err &&
    -+	end=$(date +%s) &&
    -+
    -+	duration=$((end - start)) &&
    -+	# Serial >= 4s, parallel < 4s.
    -+	test $duration -lt 4
    ++	echo parallel >expect &&
    ++	test_cmp expect repo-parallel/hook.order
     +'
     +
      test_done

Adrian Ratiu (7):
  repository: fix repo_init() memleak due to missing _clear()
  config: add a repo_config_get_uint() helper
  hook: refactor hook_config_cache from strmap to named struct
  hook: parse the hook.jobs config
  hook: add per-event jobs config
  hook: introduce extensions.hookStdoutToStderr
  hook: allow runtime enabling extensions.hookStdoutToStderr

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

 Documentation/config/extensions.adoc |  15 +
 Documentation/config/hook.adoc       |  49 +++
 Documentation/git-hook.adoc          |  18 +-
 builtin/am.c                         |   8 +-
 builtin/checkout.c                   |  19 +-
 builtin/clone.c                      |   6 +-
 builtin/hook.c                       |   5 +-
 builtin/receive-pack.c               |   3 +-
 builtin/worktree.c                   |   2 +-
 commit.c                             |   2 +-
 config.c                             |  28 ++
 config.h                             |  13 +
 hook.c                               | 213 +++++++++++--
 hook.h                               |  38 ++-
 parse.c                              |   9 +
 parse.h                              |   1 +
 repository.c                         |   2 +
 repository.h                         |   4 +-
 setup.c                              |  17 +
 setup.h                              |   1 +
 t/t1800-hook.sh                      | 446 ++++++++++++++++++++++++++-
 transport.c                          |   7 +-
 22 files changed, 843 insertions(+), 63 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

