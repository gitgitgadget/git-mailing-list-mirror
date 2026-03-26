Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B4385539
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520430; cv=pass; b=nxtQiw0Reh+d2DQzW7oxv3L6hNPPXZEIMZaIthVhGBHZEkDWEjQxWLlNHG8/gyx5yndRkHLs37GJlP5ZccWD9sThE1Dqx3iRMPz5ckLLwIN4qI+jDru0Q75WKmAb+xQXHrrue/YCf39G/IfMHDz8Veu6Z99zZ1n9ej5e/yb79iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520430; c=relaxed/simple;
	bh=H37lR3JTp5eEeRk+6pNu78975Eh6VmU2q2z9321QhqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTa6sA4Or8NhUJon1UmcKdc6mzgaYYOUbbJiLHIHFcRAF8f9MpZVL0UQbv0VLRNmrbMnbrZ4cRKZIuXS+VFWPfRhRcbUzdnJIqcBt/bOG4eQ8RmHeaOq4dQqs/M3KdroJtNg4gdVPvkc0JIL0VjIZ3WqH0/d/NXDWF4CnJmV17E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RrpORY5U; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RrpORY5U"
ARC-Seal: i=1; a=rsa-sha256; t=1774520405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rv80Td5wbKDZd+1mWiJE/5Shwj+x1JcvT8cw22B4CzmdKAO+ZgrmY6ArXFI4K8Wkm4g/OSCDbbwBAfLcqXNqdG/g56RULnKG5bzkIqyP00UMlmjYDY1zbS6dGIi6zEEdf1xsIrAkMQXyNUfnwjFCThkU3vd3enPoT7m9u5i4QhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774520405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f3dRBEs/oBRTUt+lLQ2Xsr+2YhJsZG2wjTbIejyuyKI=; 
	b=EneoQln2g7+iOm58g59U2fU/FsPy/L/oWGxYhoDJAsfGQ6/h5rKgncHNQY0hoklGcSvJXFeesxhAp4dNyveRDRZhB/de268oi3o1XnuIFtrLObcPh1UgeUC3+HguFXNcplt/YXp0/ZWsudPe44u7k7If+ySGMl9yF36ONhS0Mkw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774520405;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=f3dRBEs/oBRTUt+lLQ2Xsr+2YhJsZG2wjTbIejyuyKI=;
	b=RrpORY5UWWS0HeEvkQalIkw+n60yLz+oIQQNyTvxpkx28ExrMewlbX4IEZmMAbDm
	zes+w4Y8+J3gjUtNGL7p5+QSconjf5RPTOrytxhKRpcsed2GUMGn6UQf8NcisGA2w/q
	BjiOd//A4RY63KMeHIQEF3DM0njUdCJy+cLkVdFs=
Received: by mx.zohomail.com with SMTPS id 17745204033956.9567887422193735;
	Thu, 26 Mar 2026 03:20:03 -0700 (PDT)
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
Subject: [PATCH v5 00/12] Run hooks in parallel
Date: Thu, 26 Mar 2026 12:18:07 +0200
Message-ID: <20260326101819.1307742-1-adrian.ratiu@collabora.com>
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
the latest config-hooks cleanup series v3 [1].

v5 addresses all the feedback received in v4 and adds a few minor new
features. That's the main reason this series now increased to 12 patches.

I kindly ask the community to stop proposing new features and focus on
polishing / cleaning up the existing ones. New features can be added
in subsequent patches. :)

Branch pushed to GitHub: [2]
Successful CI run: [3]

1: https://lore.kernel.org/git/20260309005416.2760030-1-adrian.ratiu@collabora.com/T/#m78d2c342f05524bf8a8e2c4d0d4be12b599c5e5b
2: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v5
3: https://github.com/10ne1/git/actions/runs/23587892089

Changes in v5:
* Rebased on config-cleanups-v3, fixed minor conflicts and test failures
  due to the new --allow-unknown-hook-name check (Adrian)
* Added back the first commit which I accidentally dropped in v4 (Junio)
* Replaced unsigned int:1 with a proper bool in all places (Patrick)
* Renamed the caching struct event_disabled -> disabled_events (Junio)
* New commit: exposed is_known_hook() via hook.h so it can be reused (Adrian)
* New commit: jobs = -1 now defaults to online_cpus() (Patrick)
* Added is_known_hook(), introduced in commit above, to hook.h because it
  will be used by another commit later in this series (Adrian)
* Rework hook name and event name collision to die() for known hooks and
  warn() for unknown hooks instead of assuming they're hook names (Patrick)
* Avoid potential r == NULL dereference in repo_config_get_uint (Patrick)
* Simplify options->jobs = 1; default setting in get_hook_jobs() (Adrian)
* Warn when hook.*.parallel is unparseable (Patrick)
* Mention in the hook run CLI -j doc that it overrides the config (Patrick)
* Minor whitespace, capitalization, commit msg fixes (Patrick)

Range-diff v4 -> v5:
 1:  ec274c24e5 =  1:  f5624a2a1f repository: fix repo_init() memleak due to missing _clear()
 2:  81d92a4465 =  2:  8ae5eec9c9 config: add a repo_config_get_uint() helper
 3:  3bc27f6997 =  3:  f9278a22ea hook: parse the hook.jobs config
 4:  74e6f8689a !  4:  7cbe7d2f7c hook: allow parallel hook execution
    @@ Commit message
         users to run hooks in parallel (opt-in).
     
         Users need to decide which hooks to run in parallel, by specifying
    -    "parallel = true" in the config, because git cannot know if their
    +    "parallel = true" in the config, because Git cannot know if their
         specific hooks are safe to run or not in parallel (for e.g. two hooks
         might write to the same file or call the same program).
     
    @@ hook.c
     @@ hook.c: struct hook_config_cache_entry {
      	char *command;
      	enum config_scope scope;
    - 	unsigned int disabled:1;
    -+	unsigned int parallel:1;
    + 	bool disabled;
    ++	bool parallel;
      };
      
      /*
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
     +	} else if (!strcmp(subkey, "parallel")) {
     +		int v = git_parse_maybe_bool(value);
     +		if (v >= 0)
    -+			strmap_put(&data->parallel_hooks, hook_name, (void *)(uintptr_t)v);
    ++			strmap_put(&data->parallel_hooks, hook_name,
    ++				   (void *)(uintptr_t)v);
    ++		else
    ++			warning(_("hook.%s.parallel must be a boolean,"
    ++				  " ignoring: '%s'"),
    ++				hook_name, value);
      	}
      
      	free(hook_name);
    @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *c
      			struct hook_config_cache_entry *entry;
      			char *command;
      
    -+			int is_par = !!strmap_get(&cb_data.parallel_hooks, hname);
    - 			int is_disabled =
    ++			bool is_par = !!strmap_get(&cb_data.parallel_hooks, hname);
    + 			bool is_disabled =
      				!!unsorted_string_list_lookup(
      					&cb_data.disabled_hooks, hname);
     @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    @@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
     +	 * fallback to a direct config lookup (out-of-repo).
     +	 * Default to 1 (serial execution) on failure.
     +	 */
    -+	if (r && r->gitdir && r->hook_config_cache)
    -+		/* Use the already-parsed cache (in-repo) */
    -+		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
    -+	else
    -+		/* No cache present (out-of-repo call), use direct cfg lookup */
    -+		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
    -+			options->jobs = 1;
    ++	options->jobs = 1;
    ++	if (r) {
    ++		if (r->gitdir && r->hook_config_cache && r->hook_jobs)
    ++			options->jobs = r->hook_jobs;
    ++		else
    ++			repo_config_get_uint(r, "hook.jobs", &options->jobs);
    ++	}
     +
     +	/*
     +	 * Cap to serial any configured hook not marked as parallel = true.
    @@ hook.h: struct hook {
     +	 * event. Only useful for configured (named) hooks. Traditional hooks
     +	 * always default to 0 (serial). Set via `hook.<name>.parallel = true`.
     +	 */
    -+	unsigned int parallel:1;
    ++	bool parallel;
     +
      	/**
      	 * Opaque data pointer used to keep internal state across callback calls.
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +
     +	test_config hook.jobs 1 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo serial >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +
     +	test_config hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +
     +	test_config hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +
     +	test_config hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo serial >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +
     +	test_config hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo serial >expect &&
     +	test_cmp expect hook.order
     +'
 5:  508d6476c6 =  5:  fd39771388 hook: allow pre-push parallel execution
 6:  2d7b3d6d83 =  6:  54c08cb72b hook: mark non-parallelizable hooks
 7:  97507d8d31 !  7:  5957cd9c72 hook: add -j/--jobs option to git hook run
    @@ Documentation/git-hook.adoc: git-hook - Run git hooks
      SYNOPSIS
      --------
      [verse]
    --'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
    -+'git hook' run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
    +-'git hook' run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
    ++'git hook' run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]
     +	<hook-name> [-- <hook-args>]
    - 'git hook' list [-z] [--show-scope] <hook-name>
    + 'git hook' list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>
      
      DESCRIPTION
     @@ Documentation/git-hook.adoc: OPTIONS
    @@ Documentation/git-hook.adoc: OPTIONS
     ++
     +Specify how many hooks to run simultaneously. If this flag is not specified,
     +the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If
    -+neither is specified, defaults to 1 (serial execution). Some hooks always run
    -+sequentially regardless of this flag or the `hook.jobs` config, because git
    -+knows they cannot safely run in parallel: `applypatch-msg`, `pre-commit`,
    -+`prepare-commit-msg`, `commit-msg`, `post-commit`, `post-checkout`, and
    -+`push-to-checkout`.
    ++neither is specified, defaults to 1 (serial execution).
    +++
    ++When greater than 1, it overrides the per-hook `hook.<friendly-name>.parallel`
    ++setting, allowing all hooks for the event to run concurrently, even if they
    ++are not individually marked as parallel.
    +++
    ++Some hooks always run sequentially regardless of this flag or the
    ++`hook.jobs` config, because git knows they cannot safely run in parallel:
    ++`applypatch-msg`, `pre-commit`, `prepare-commit-msg`, `commit-msg`,
    ++`post-commit`, `post-checkout`, and `push-to-checkout`.
     +
      WRAPPERS
      --------
      
     @@ Documentation/git-hook.adoc: running:
    - git hook run mywrapper-start-tests \
    + git hook run --allow-unknown-hook-name mywrapper-start-tests \
        # providing something to stdin
        --stdin some-tempfile-123 \
     -  # execute hooks in serial
    @@ builtin/hook.c
      #include "parse-options.h"
      
      #define BUILTIN_HOOK_RUN_USAGE \
    --	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
    -+	N_("git hook run [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
    +-	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
    ++	N_("git hook run [--allow-unknown-hook-name] [--ignore-missing] [--to-stdin=<path>] [(-j|--jobs) <n>]\n" \
     +	   "<hook-name> [-- <hook-args>]")
      #define BUILTIN_HOOK_LIST_USAGE \
    - 	N_("git hook list [-z] [--show-scope] <hook-name>")
    + 	N_("git hook list [--allow-unknown-hook-name] [-z] [--show-scope] <hook-name>")
      
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix,
      			 N_("silently ignore missing requested <hook-name>")),
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +		    "echo \"Hook 3 Start\"; sleep 3; echo \"Hook 3 End\"" &&
     +	test_config hook.hook-3.parallel true &&
     +
    -+	git hook run -j3 test-hook >out 2>err.parallel &&
    ++	git hook run --allow-unknown-hook-name -j3 test-hook >out 2>err.parallel &&
     +
     +	# Verify Hook 1 output is grouped
     +	sed -n "/Hook 1 Start/,/Hook 1 End/p" err.parallel >hook1_out &&
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	3
     +	EOF
     +
    -+	git hook run -j1 test-hook 2>actual &&
    ++	git hook run --allow-unknown-hook-name -j1 test-hook 2>actual &&
     +	test_cmp expected actual
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	    "$(sentinel_detector sentinel hook.order)" &&
     +	test_config hook.hook-2.parallel true &&
     +
    -+	git hook run -j2 test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
     +	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	# hook-2 also has no parallel=true
     +
     +	# -j2 overrides parallel=false; hooks run in parallel with a warning.
    -+	git hook run -j2 test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
     +	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	test_config hook.hook-2.command "true" &&
     +	# neither hook has parallel=true
     +
    -+	git hook run -j2 test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name -j2 test-hook >out 2>err &&
     +	grep "hook .hook-1. is not marked as parallel=true" err &&
     +	grep "hook .hook-2. is not marked as parallel=true" err
     +'
 8:  734adfad1b !  8:  a58f05e9d5 hook: add per-event jobs config
    @@ hook.c: struct hook_all_config_cb {
      };
      
     @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    - 		int v = git_parse_maybe_bool(value);
    - 		if (v >= 0)
    - 			strmap_put(&data->parallel_hooks, hook_name, (void *)(uintptr_t)v);
    + 			warning(_("hook.%s.parallel must be a boolean,"
    + 				  " ignoring: '%s'"),
    + 				hook_name, value);
     +	} else if (!strcmp(subkey, "jobs")) {
     +		unsigned int v;
     +		if (!git_parse_uint(value, &v))
    -+			warning(_("hook.%s.jobs must be a positive integer, ignoring: '%s'"),
    ++			warning(_("hook.%s.jobs must be a positive integer,"
    ++				  " ignoring: '%s'"),
     +				hook_name, value);
     +		else if (!v)
    -+			warning(_("hook.%s.jobs must be positive, ignoring: 0"), hook_name);
    ++			warning(_("hook.%s.jobs must be positive,"
    ++				  " ignoring: 0"), hook_name);
     +		else
     +			strmap_put(&data->event_jobs, hook_name,
     +				   (void *)(uintptr_t)v);
    @@ hook.c: static void warn_non_parallel_hooks_override(unsigned int jobs,
      {
      	/*
     @@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
    - 	 * fallback to a direct config lookup (out-of-repo).
    - 	 * Default to 1 (serial execution) on failure.
      	 */
    --	if (r && r->gitdir && r->hook_config_cache)
    -+	if (r && r->gitdir && r->hook_config_cache) {
    - 		/* Use the already-parsed cache (in-repo) */
    -+		void *event_jobs = strmap_get(&r->event_jobs, hook_name);
    - 		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
    --	else
    -+		if (event_jobs)
    -+			options->jobs = (unsigned int)(uintptr_t)event_jobs;
    -+	} else {
    - 		/* No cache present (out-of-repo call), use direct cfg lookup */
    -+		unsigned int event_jobs;
    -+		char *key;
    + 	options->jobs = 1;
    + 	if (r) {
    +-		if (r->gitdir && r->hook_config_cache && r->hook_jobs)
    +-			options->jobs = r->hook_jobs;
    +-		else
    ++		if (r->gitdir && r->hook_config_cache) {
    ++			void *event_jobs;
     +
    - 		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
    - 			options->jobs = 1;
    - 
    -+		key = xstrfmt("hook.%s.jobs", hook_name);
    -+		if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
    -+			options->jobs = event_jobs;
    -+		free(key);
    -+	}
    ++			if (r->hook_jobs)
    ++				options->jobs = r->hook_jobs;
    ++
    ++			event_jobs = strmap_get(&r->event_jobs, hook_name);
    ++			if (event_jobs)
    ++				options->jobs = (unsigned int)(uintptr_t)event_jobs;
    ++		} else {
    ++			unsigned int event_jobs;
    ++			char *key;
     +
    + 			repo_config_get_uint(r, "hook.jobs", &options->jobs);
    ++
    ++			key = xstrfmt("hook.%s.jobs", hook_name);
    ++			if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
    ++				options->jobs = event_jobs;
    ++			free(key);
    ++		}
    + 	}
    + 
      	/*
      	 * Cap to serial any configured hook not marked as parallel = true.
      	 * This enforces the parallel = false default, even for "traditional"
    @@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 is ignored for force-serial ho
     +	test_config hook.jobs 1 &&
     +	test_config hook.test-hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 is ignored for force-serial ho
     +	test_config hook.jobs 4 &&
     +	test_config hook.test-hook.jobs 1 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo serial >expect &&
     +	test_cmp expect hook.order
     +'
    @@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 is ignored for force-serial ho
     +	# Per-event jobs=2 but no hook has parallel=true: must still run serially.
     +	test_config hook.test-hook.jobs 2 &&
     +
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	echo serial >expect &&
     +	test_cmp expect hook.order
     +'
 9:  d6d3196b17 !  9:  4fb39ad98d hook: warn when hook.<friendly-name>.jobs is set
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs still requires hook.<nam
     +test_expect_success 'hook.<friendly-name>.jobs warns when name has .command' '
     +	test_config hook.my-hook.command "true" &&
     +	test_config hook.my-hook.jobs 2 &&
    -+	git hook run --ignore-missing test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
     +	test_grep "hook.my-hook.jobs.*friendly-name" err
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs still requires hook.<nam
     +	test_config hook.my-hook.event test-hook &&
     +	test_config hook.my-hook.command "true" &&
     +	test_config hook.my-hook.jobs 2 &&
    -+	git hook run --ignore-missing test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
     +	test_grep "hook.my-hook.jobs.*friendly-name" err
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs still requires hook.<nam
     +	test_config hook.my-hook.command "true" &&
     +	test_config hook.my-hook.parallel true &&
     +	test_config hook.my-hook.jobs 2 &&
    -+	git hook run --ignore-missing test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
     +	test_grep "hook.my-hook.jobs.*friendly-name" err
     +'
     +
     +test_expect_success 'hook.<event>.jobs does not warn for a real event name' '
     +	test_config hook.test-hook.jobs 2 &&
    -+	git hook run --ignore-missing test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name --ignore-missing test-hook >out 2>err &&
     +	test_grep ! "friendly-name" err
     +'
     +
 -:  ---------- > 10:  d3c6e8f3e2 hook: move is_known_hook() to hook.c for wider use
10:  b64689d0c8 ! 11:  312acd15b4 hook: add hook.<event>.enabled switch
    @@ Commit message
         relevant piece of information, and the per-hook "disabled" status
         will surface once the event is re-enabled.
     
    -    Reuses is_friendly_name() from the previous commit to distinguish
    -    event names from friendly-names when processing .enabled settings.
    +    Using an event name as a friendly-name (e.g. hook.<event>.enabled)
    +    can cause ambiguity, so a fatal error is issued when using a known
    +    event name and a warning is issued for unknown event name, since
    +    a collision cannot be detected with certainty for unknown events.
     
    +    Suggested-by: Patrick Steinhardt <ps@pks.im>
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.event::
    + 	events, specify the key more than once. An empty value resets
    + 	the list of events, clearing any previously defined events for
    + 	`hook.<friendly-name>`. See linkgit:git-hook[1].
    +++
    ++The `<friendly-name>` must not be the same as a known hook event name
    ++(e.g. do not use `hook.pre-commit.event`). Using a known event name as
    ++a friendly-name is a fatal error because it creates an ambiguity with
    ++`hook.<event>.enabled` and `hook.<event>.jobs`. For unknown event names,
    ++a warning is issued when `<friendly-name>` matches the event value.
    + 
    + hook.<friendly-name>.enabled::
    + 	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
     @@ Documentation/config/hook.adoc: hook.<friendly-name>.parallel::
      	found in the hooks directory do not need to, and run in parallel when
      	the effective job count is greater than 1. See linkgit:git-hook[1].
    @@ Documentation/config/hook.adoc: hook.<friendly-name>.parallel::
     +	See linkgit:git-hook[1].
     ++
     +Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
    -+not a hook friendly-name. A name that also carries `.command`, `.event`,
    -+or `.parallel` is treated as a friendly-name and its `.enabled` value
    -+applies only to that individual hook. See `hook.<friendly-name>.enabled`
    -+above.
    ++not a hook friendly-name. Since using a known event name as a
    ++friendly-name is disallowed (see `hook.<friendly-name>.event` above),
    ++there is no ambiguity between event-level and per-hook `.enabled`
    ++settings for known events. For unknown events, if a friendly-name
    ++matches the event name despite the warning, `.enabled` is treated
    ++as per-hook only.
     +
      hook.<event>.jobs::
      	Specifies how many hooks can be run simultaneously for the `<event>`
    @@ hook.c: struct hook_config_cache_entry {
     - * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
     + * disabled_hooks: set of all names with hook.<name>.enabled = false; after
     + *                 parsing, names that are not friendly-names become event-level
    -+ *                 disables stored in cache->event_disabled. This collects all.
    ++ *                 disables stored in r->disabled_events. This collects all.
       * parallel_hooks: friendly-name to parallel flag.
       * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
       * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 			strmap_for_each_entry(&data->event_hooks, &iter, e)
    + 				unsorted_string_list_remove(e->value, hook_name, 0);
    + 		} else {
    +-			struct string_list *hooks =
    +-				strmap_get(&data->event_hooks, value);
    ++			struct string_list *hooks;
    ++
    ++			if (is_known_hook(hook_name))
    ++				die(_("hook friendly-name '%s' collides with "
    ++				      "a known event name; please choose a "
    ++				      "different friendly-name"),
    ++				    hook_name);
    ++
    ++			if (!strcmp(hook_name, value))
    ++				warning(_("hook friendly-name '%s' is the "
    ++					  "same as its event; this may cause "
    ++					  "ambiguity with hook.%s.enabled"),
    ++					hook_name, hook_name);
    ++
    ++			hooks = strmap_get(&data->event_hooks, value);
    + 
    + 			if (!hooks) {
    + 				CALLOC_ARRAY(hooks, 1);
     @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      
      	warn_jobs_on_friendly_names(&cb_data);
      
     +	/*
    -+	 * Populate event_disabled: names in disabled_hooks that are not
    ++	 * Populate disabled_events: names in disabled_hooks that are not
     +	 * friendly-names are event-level switches (hook.<event>.enabled = false).
     +	 * Names that are friendly-names are already handled per-hook via the
     +	 * hook_config_cache_entry.disabled flag below.
     +	 */
     +	if (r) {
    -+		string_list_clear(&r->event_disabled, 0);
    -+		string_list_init_dup(&r->event_disabled);
    ++		string_list_clear(&r->disabled_events, 0);
    ++		string_list_init_dup(&r->disabled_events);
     +		for (size_t i = 0; i < cb_data.disabled_hooks.nr; i++) {
     +			const char *n = cb_data.disabled_hooks.items[i].string;
     +			if (!is_friendly_name(&cb_data, n))
    -+				string_list_append(&r->event_disabled, n);
    ++				string_list_append(&r->disabled_events, n);
     +		}
     +	}
     +
    @@ hook.c: static void list_hooks_add_configured(struct repository *r,
      {
      	struct strmap *cache = get_hook_config_cache(r);
      	struct string_list *configured_hooks = strmap_get(cache, hookname);
    -+	int event_is_disabled = r ? !!unsorted_string_list_lookup(&r->event_disabled,
    ++	bool event_is_disabled = r ? !!unsorted_string_list_lookup(&r->disabled_events,
     +								   hookname) : 0;
      
      	/* Iterate through configured hooks and initialize internal states */
    @@ hook.c: static void list_hooks_add_configured(struct repository *r,
      		hook_cache_clear(cache);
      		free(cache);
     +		if (r)
    -+			string_list_clear(&r->event_disabled, 0);
    ++			string_list_clear(&r->disabled_events, 0);
      	}
      }
      
    @@ hook.h
     @@ hook.h: struct hook {
      			const char *command;
      			enum config_scope scope;
    - 			unsigned int disabled:1;
    -+			unsigned int event_disabled:1;
    + 			bool disabled;
    ++			bool event_disabled;
      		} configured;
      	} u;
      
    @@ repository.c: void repo_clear(struct repository *repo)
      		FREE_AND_NULL(repo->hook_config_cache);
      	}
      	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
    -+	string_list_clear(&repo->event_disabled, 0);
    ++	string_list_clear(&repo->disabled_events, 0);
      
      	if (repo->promisor_remote_config) {
      		promisor_remote_clear(repo->promisor_remote_config);
    @@ repository.h: struct repository {
      	struct strmap event_jobs;
      
     +	/* Cached list of event names with hook.<event>.enabled = false. */
    -+	struct string_list event_disabled;
    ++	struct string_list disabled_events;
     +
      	/* Configurations related to promisor remotes. */
      	char *repository_format_partial_clone;
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command "echo ran" &&
     +	test_config hook.test-hook.enabled false &&
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	test_must_be_empty out
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command "echo ran" &&
     +	test_config hook.test-hook.enabled true &&
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	test_grep "ran" err
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command "echo ran" &&
     +	test_config hook.other-event.enabled false &&
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	test_grep "ran" err
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-2.event test-hook &&
     +	test_config hook.hook-2.command "echo hook-2" &&
     +	test_config hook.hook-1.enabled false &&
    -+	git hook run test-hook >out 2>err &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
     +	test_grep ! "hook-1" err &&
     +	test_grep "hook-2" err
     +'
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-2.event test-hook &&
     +	test_config hook.hook-2.command "echo ran" &&
     +	test_config hook.test-hook.enabled false &&
    -+	git hook list test-hook >actual &&
    ++	git hook list --allow-unknown-hook-name test-hook >actual &&
     +	test_grep "^event-disabled	hook-1$" actual &&
     +	test_grep "^event-disabled	hook-2$" actual
     +'
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command "echo ran" &&
     +	test_config hook.test-hook.enabled false &&
    -+	git hook list --show-scope test-hook >actual &&
    ++	git hook list --allow-unknown-hook-name --show-scope test-hook >actual &&
     +	test_grep "^local	event-disabled	hook-1$" actual
     +'
     +
    @@ t/t1800-hook.sh: test_expect_success 'hook.<event>.jobs does not warn for a real
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command "echo ran" &&
     +	test_config hook.test-hook.enabled false &&
    -+	git hook list test-hook >actual &&
    ++	git hook list --allow-unknown-hook-name test-hook >actual &&
     +	test_grep "event-disabled" actual
     +'
    ++
    ++test_expect_success 'friendly-name matching known event name is rejected' '
    ++	test_config hook.pre-commit.event pre-commit &&
    ++	test_config hook.pre-commit.command "echo oops" &&
    ++	test_must_fail git hook run pre-commit 2>err &&
    ++	test_grep "collides with a known event name" err
    ++'
    ++
    ++test_expect_success 'friendly-name matching known event name is rejected even for different event' '
    ++	test_config hook.pre-commit.event post-commit &&
    ++	test_config hook.pre-commit.command "echo oops" &&
    ++	test_must_fail git hook run post-commit 2>err &&
    ++	test_grep "collides with a known event name" err
    ++'
    ++
    ++test_expect_success 'friendly-name matching unknown event warns' '
    ++	test_config hook.test-hook.event test-hook &&
    ++	test_config hook.test-hook.command "echo ran" &&
    ++	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
    ++	test_grep "same as its event" err
    ++'
     +
      test_done
 -:  ---------- > 12:  f54844d13e hook: allow hook.jobs=-1 to use all available CPU cores

Adrian Ratiu (9):
  repository: fix repo_init() memleak due to missing _clear()
  config: add a repo_config_get_uint() helper
  hook: parse the hook.jobs config
  hook: allow pre-push parallel execution
  hook: add per-event jobs config
  hook: warn when hook.<friendly-name>.jobs is set
  hook: move is_known_hook() to hook.c for wider use
  hook: add hook.<event>.enabled switch
  hook: allow hook.jobs=-1 to use all available CPU cores

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

 Documentation/config/hook.adoc |  76 +++++
 Documentation/git-hook.adoc    |  23 +-
 Makefile                       |   2 +-
 builtin/am.c                   |   8 +-
 builtin/checkout.c             |  19 +-
 builtin/clone.c                |   6 +-
 builtin/hook.c                 |  46 ++-
 builtin/receive-pack.c         |   3 +-
 builtin/worktree.c             |   2 +-
 commit.c                       |   2 +-
 config.c                       |  28 ++
 config.h                       |  13 +
 hook.c                         | 286 ++++++++++++++++-
 hook.h                         |  38 ++-
 parse.c                        |   9 +
 parse.h                        |   1 +
 repository.c                   |   3 +
 repository.h                   |  10 +
 t/t1800-hook.sh                | 546 ++++++++++++++++++++++++++++++++-
 transport.c                    |   6 +-
 20 files changed, 1069 insertions(+), 58 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

