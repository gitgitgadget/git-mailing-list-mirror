Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA23B27C5
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014847; cv=pass; b=RT027G4fkTSWvedmbA+ItHcAp22VT0/Ry03zRMzYlC6xGvtZ8IadG7sb9y4OmL4i4gDBUa3VEDBRuEUc7MyogtrlM/dxOPjMLaCEn5L6++pIiw8sZP5PVPyH12tVIPB66Vw96xTlpCvD/jY5UlfRzBLOiS++ymX5Zz8FcsCla3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014847; c=relaxed/simple;
	bh=HTf0UUBY+nkjKUKvz06BEIArGslEy/Ej+cjuQmHwJ/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9D31VVUorbVL8dGlWvxwneOFsvTv9ZxQS0eCGfzLtQP1qJILRm9owphaAoGyGfm/HusC7XlW/eNeAea1JJUuum/XOD8vakhobiylRxxfo1jGbQ6Tb8F8vdCP3kg7Yl9lY04UWcMjlQ0UmWY6kx2/ABHeAroXfI1yJHQZ2CRvOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BN0fNEfr; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BN0fNEfr"
ARC-Seal: i=1; a=rsa-sha256; t=1774014817; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SCmN8dN0v0oR333icFpEkhvlE8aXrkdmtay5LDtXj7hDixyLw3K+lz1uBDbi/Wp9SiOsXZIY5Bo5nIoE4jjowk6lNSCuTgnWAyxKVXPNJf/YFXJnrnlPqbnvaOulJzXNswwl4qCt+vjCMoYhoSbiTuvqSZnOYiu4c2c6G1PdwHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774014817; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=76EVTO9wbTf/QlWDUt6fYBKC0KenVRG7HDWUJK6ABFo=; 
	b=S0yjEeCkgnUU5xZebJdB2dBGWayHLcm/z9PTeSKoclLDOTs1WM1yIWd7Yb7xQ0VPNqECqZUM8ZnE2ym+TYxMIa11Yxv1lSMKexEI43ge5dUgztw/JmPTb0ZknUtwRcU3KYPAi1XpUi4qjgakD1jRxahgz1qOFIxCKEvTp/jqof8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774014817;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=76EVTO9wbTf/QlWDUt6fYBKC0KenVRG7HDWUJK6ABFo=;
	b=BN0fNEfryC4qNVZ1ZqCJGlzqsjATtXeHuTb/squHOdBOPNUTuZPVGn+pzkYVNthZ
	ZnaFsFyxTio1DjC+bb/QizZ9exqVWdET9vPcI8ofqkfk0PHmyEfehWRIJnaz7/f98K4
	aK5qw2p5ufEJ0ke9ZqZVvo6e/jdXxO0Z7PmYmqG8=
Received: by mx.zohomail.com with SMTPS id 1774014815938308.11533840803213;
	Fri, 20 Mar 2026 06:53:35 -0700 (PDT)
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
Subject: [PATCH v4 0/9] Run hooks in parallel
Date: Fri, 20 Mar 2026 15:53:02 +0200
Message-ID: <20260320135311.331463-1-adrian.ratiu@collabora.com>
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
the latest config hooks cleanup series v2 [1].

v4 has an important design change and addresses all feedback received
in v3. The design change is that I dropped the extension introduced in
previous patches for the following reasoning:

Hook stdout -> stderr backwards compatibility is preserved by default
when running sequentially (only known hook is pre-push which requires
different stdout vs stderr streams), however when users opt-in to run
hooks in parallel, hook stdout is redirected to stderr, so run-command
can buffer and de-interlace the parallel hook output.

Simpler said:
If you opt-in to parallel execution, parallel hook output goes to stderr.

Based on all discussions we had, I think this is the best compromise
between preserving backwards compatibility, avoiding extensions nobody
wants and also providing an incentive for users to migrate their hooks
by opting-in, without forcing them via breakage.

Branch pushed to GitHub: [2]
Successful CI run: [3] with the known MacOS REG_ENHANCED breakage exception.

Many thanks to all who contributed up to now,
Adrian

1: https://lore.kernel.org/git/20260309005416.2760030-1-adrian.ratiu@collabora.com/T/#m1827a9302ecfdf2c07e2f0158cd24b4eb435aa37
2: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v4
3: https://github.com/10ne1/git/actions/runs/23342695565

Changes in v4:
* Rebased on config-cleanups-v2 with a few small conflicts due to
  removing the redundant struct cache wrapping the strmap (Junio)
* Simplified parallel toggle strmap_get by using double negation (Junio)
* Simplified parallel = true loop detection early exit (Junio)
* Made the options->jobs override stronger and issued a warning when
  forcing a parallel=false hook to run in parallel via -jN (Junio)
* Added a new test for the above warning and updated the blocking test (Adrian)
* Dropped the extension since it's not necessary anymore (Junio, Adrian)
* New commit: users who opt-in to run hooks in parallel automatically get
  all the hook output on stderr. jobs == 1 is bacward compatible. (Adrian)
* New commit: warn when user mixes event and hook namespaces (Junio)
* New Commit: add hook.<event>.enabled switch (Junio)
* Simplified get_hook_jobs logic by setting options->jobs directly,
  so we don't need the extra jobs variable and shorthand ifs (Adrian)
* Removed heap allocations from event level .jobs config (Adrian)
* Minor documentation & code comment improvements, commit messages (Junio)

Range-diff v3 -> v4:
 1:  6686d92867 =  1:  ec274c24e5 repository: fix repo_init() memleak due to missing _clear()
 2:  61250bdd91 =  2:  81d92a4465 config: add a repo_config_get_uint() helper
 3:  2c49e2a523 !  3:  3bc27f6997 hook: parse the hook.jobs config
    @@ Commit message
         add to this item's documentation.
     
         Parse hook.jobs config key in hook_config_lookup_all() and store its
    -    value in hook_all_config_cb.jobs, then transfer it into
    -    hook_config_cache.jobs after the config pass completes.
    +    value in hook_all_config_cb.jobs, then transfer it into r->jobs after
    +    the config pass completes.
     
         This is mostly plumbing and the cached value is not yet used.
     
    @@ hook.c: struct hook_config_cache_entry {
       * commands: friendly-name to command map.
       * event_hooks: event-name to list of friendly-names map.
       * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
    -+ * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
    ++ * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
       */
      struct hook_all_config_cb {
      	struct strmap commands;
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
      	if (!value)
      		return config_error_nonbool(key);
      
    -@@ hook.c: void hook_cache_clear(struct hook_config_cache *cache)
    - static void build_hook_config_map(struct repository *r,
    - 				  struct hook_config_cache *cache)
    +@@ hook.c: void hook_cache_clear(struct strmap *cache)
    + /* Populate `cache` with the complete hook configuration */
    + static void build_hook_config_map(struct repository *r, struct strmap *cache)
      {
     -	struct hook_all_config_cb cb_data;
     +	struct hook_all_config_cb cb_data = { 0 };
      	struct hashmap_iter iter;
      	struct strmap_entry *e;
      
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      	strmap_init(&cb_data.event_hooks);
      	string_list_init_dup(&cb_data.disabled_hooks);
      
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      	repo_config(r, hook_config_lookup_all, &cb_data);
      
      	/* Construct the cache from parsed configs. */
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    - 		strmap_put(&cache->hooks, e->key, hooks);
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 		strmap_put(cache, e->key, hooks);
      	}
      
    -+	cache->jobs = cb_data.jobs;
    ++	if (r)
    ++		r->hook_jobs = cb_data.jobs;
     +
      	strmap_clear(&cb_data.commands, 1);
      	string_list_clear(&cb_data.disabled_hooks, 0);
      	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
     
    - ## hook.h ##
    -@@ hook.h: void hook_free(void *p, const char *str UNUSED);
    -  */
    - struct hook_config_cache {
    - 	struct strmap hooks; /* maps event name -> string_list of hooks */
    -+	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
    - };
    + ## repository.h ##
    +@@ repository.h: struct repository {
    + 	 */
    + 	struct strmap *hook_config_cache;
      
    - /**
    ++	/* Cached value of hook.jobs config (0 if unset, defaults to serial). */
    ++	unsigned int hook_jobs;
    ++
    + 	/* Configurations related to promisor remotes. */
    + 	char *repository_format_partial_clone;
    + 	struct promisor_remote_config *promisor_remote_config;
 4:  3c206fac62 !  4:  74e6f8689a hook: allow parallel hook execution
    @@ Documentation/config/hook.adoc: hook.<friendly-name>.enabled::
      	in a system or global config file and needs to be disabled for a
      	specific repository. See linkgit:git-hook[1].
      
    -+hook.<name>.parallel::
    -+	Whether the hook `hook.<name>` may run in parallel with other hooks
    ++hook.<friendly-name>.parallel::
    ++	Whether the hook `hook.<friendly-name>` may run in parallel with other hooks
     +	for the same event. Defaults to `false`. Set to `true` only when the
     +	hook script is safe to run concurrently with other hooks for the same
     +	event. If any hook for an event does not have this set to `true`,
    @@ Documentation/config/hook.adoc: hook.<friendly-name>.enabled::
      	hook execution. If unspecified, defaults to 1 (serial execution).
     ++
     +This setting has no effect unless all configured hooks for the event have
    -+`hook.<name>.parallel` set to `true`.
    ++`hook.<friendly-name>.parallel` set to `true`.
     
      ## hook.c ##
     @@ hook.c: struct hook_config_cache_entry {
      	char *command;
      	enum config_scope scope;
    - 	int disabled;
    + 	unsigned int disabled:1;
     +	unsigned int parallel:1;
      };
      
    @@ hook.c: struct hook_config_cache_entry {
       * event_hooks: event-name to list of friendly-names map.
       * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
     + * parallel_hooks: friendly-name to parallel flag.
    -  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
    +  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
       */
      struct hook_all_config_cb {
      	struct strmap commands;
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
      	}
      
      	free(hook_name);
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      	strmap_init(&cb_data.commands);
      	strmap_init(&cb_data.event_hooks);
      	string_list_init_dup(&cb_data.disabled_hooks);
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      
      	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
      	repo_config(r, hook_config_lookup_all, &cb_data);
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    - 			enum config_scope scope =
    - 				(enum config_scope)(uintptr_t)hook_names->items[i].util;
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      			struct hook_config_cache_entry *entry;
    -+			void *par = strmap_get(&cb_data.parallel_hooks, hname);
      			char *command;
      
    ++			int is_par = !!strmap_get(&cb_data.parallel_hooks, hname);
      			int is_disabled =
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    - 			entry->command = command ? xstrdup(command) : NULL;
    + 				!!unsorted_string_list_lookup(
    + 					&cb_data.disabled_hooks, hname);
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 			entry->command = xstrdup_or_null(command);
      			entry->scope = scope;
      			entry->disabled = is_disabled;
    -+			entry->parallel = (int)(uintptr_t)par;
    ++			entry->parallel = is_par;
      			string_list_append(hooks, hname)->util = entry;
      		}
      
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    - 	cache->jobs = cb_data.jobs;
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 		r->hook_jobs = cb_data.jobs;
      
      	strmap_clear(&cb_data.commands, 1);
     +	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
    @@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
     +				  struct run_hooks_opt *options,
     +				  struct string_list *hook_list)
     +{
    -+	unsigned int jobs;
    -+
     +	/*
    -+	 * Hooks needing separate output streams must run sequentially. Next
    -+	 * commits will add an extension to allow parallelizing these as well.
    ++	 * Hooks needing separate output streams must run sequentially.
    ++	 * Next commit will allow parallelizing these as well.
     +	 */
     +	if (!options->stdout_to_stderr)
     +		return 1;
     +
    -+	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
    ++	/*
    ++	 * An explicit job count overrides everything else: this covers both
    ++	 * FORCE_SERIAL callers (for hooks that must never run in parallel)
    ++	 * and the -j flag from the CLI. The CLI override is intentional: users
    ++	 * may want to serialize hooks declared parallel or to parallelize more
    ++	 * aggressively than the default.
    ++	 */
     +	if (options->jobs)
     +		return options->jobs;
     +
     +	/*
     +	 * Use hook.jobs from the already-parsed config cache (in-repo), or
    -+	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
    ++	 * fallback to a direct config lookup (out-of-repo).
    ++	 * Default to 1 (serial execution) on failure.
     +	 */
     +	if (r && r->gitdir && r->hook_config_cache)
     +		/* Use the already-parsed cache (in-repo) */
    -+		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
    ++		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
     +	else
     +		/* No cache present (out-of-repo call), use direct cfg lookup */
    -+		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
    ++		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
    ++			options->jobs = 1;
     +
     +	/*
     +	 * Cap to serial any configured hook not marked as parallel = true.
     +	 * This enforces the parallel = false default, even for "traditional"
     +	 * hooks from the hookdir which cannot be marked parallel = true.
     +	 */
    -+	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
    ++	for (size_t i = 0; i < hook_list->nr; i++) {
     +		struct hook *h = hook_list->items[i].util;
    -+		if (h->kind == HOOK_CONFIGURED && !h->parallel)
    -+			jobs = 1;
    ++		if (h->kind == HOOK_CONFIGURED && !h->parallel) {
    ++			options->jobs = 1;
    ++			break;
    ++		}
     +	}
     +
    -+	return jobs;
    ++	return options->jobs;
     +}
     +
      int run_hooks_opt(struct repository *r, const char *hook_name,
    @@ hook.h: struct hook {
      	/**
      	 * Opaque data pointer used to keep internal state across callback calls.
      	 *
    -@@ hook.h: struct run_hooks_opt
    +@@ hook.h: struct run_hooks_opt {
      	 *
      	 * If > 1, output will be buffered and de-interleaved (ungroup=0).
      	 * If == 1, output will be real-time (ungroup=1).
    @@ hook.h: struct run_hooks_opt
      	 */
      	unsigned int jobs;
      
    -@@ hook.h: struct run_hooks_opt
    +@@ hook.h: struct run_hooks_opt {
      	hook_data_free_fn feed_pipe_cb_data_free;
      };
      
 -:  ---------- >  5:  508d6476c6 hook: allow pre-push parallel execution
 5:  2385cb3bc8 !  6:  2d7b3d6d83 hook: mark non-parallelizable hooks
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.parallel::
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.parallel::
      hook.jobs::
      	Specifies how many hooks can be run simultaneously during parallelized
      	hook execution. If unspecified, defaults to 1 (serial execution).
     +	Some hooks always run sequentially regardless of this setting because
    -+	git knows they cannot safely be parallelized: `applypatch-msg`,
    -+	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
    -+	`post-checkout`, and `push-to-checkout`.
    ++	they operate on shared data and cannot safely be parallelized:
    +++
    ++--
    ++`applypatch-msg`;;
    ++`prepare-commit-msg`;;
    ++`commit-msg`;;
    ++	Receive a commit message file and may rewrite it in place.
    ++`pre-commit`;;
    ++`post-checkout`;;
    ++`push-to-checkout`;;
    ++`post-commit`;;
    ++	Access the working tree, index, or repository state.
    ++--
      +
      This setting has no effect unless all configured hooks for the event have
    - `hook.<name>.parallel` set to `true`.
    + `hook.<friendly-name>.parallel` set to `true`.
     
      ## builtin/am.c ##
     @@ builtin/am.c: static int run_applypatch_msg_hook(struct am_state *state)
    @@ commit.c: size_t ignored_log_message_bytes(const char *buf, size_t len)
      
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'one non-parallel hook forces the whole event to run seriall
    - 	test_cmp expect hook.order
    +@@ t/t1800-hook.sh: test_expect_success 'client hooks: pre-push runs in parallel when hook.jobs > 1'
    + 	test_cmp expect repo-parallel/hook.order
      '
      
     +test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)' '
 6:  c4f92834a7 !  7:  97507d8d31 hook: add -j/--jobs option to git hook run
    @@ Documentation/git-hook.adoc: git-hook - Run git hooks
      
      DESCRIPTION
     @@ Documentation/git-hook.adoc: OPTIONS
    - 	in parentheses after the friendly name of each configured hook, to show
    - 	where it was defined. Traditional hooks from the hookdir are unaffected.
    + 	mirroring the output style of `git config --show-scope`. Traditional
    + 	hooks from the hookdir are unaffected.
      
     +-j::
     +--jobs::
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix,
      	int ret;
     
      ## hook.c ##
    +@@ hook.c: static void merge_output_if_parallel(struct run_hooks_opt *options)
    + 		options->stdout_to_stderr = 1;
    + }
    + 
    ++static void warn_non_parallel_hooks_override(unsigned int jobs,
    ++					     struct string_list *hook_list)
    ++{
    ++	/* Don't warn for hooks running sequentially. */
    ++	if (jobs == 1)
    ++		return;
    ++
    ++	for (size_t i = 0; i < hook_list->nr; i++) {
    ++		struct hook *h = hook_list->items[i].util;
    ++		if (h->kind == HOOK_CONFIGURED && !h->parallel)
    ++			warning(_("hook '%s' is not marked as parallel=true, "
    ++				  "running in parallel anyway due to -j%u"),
    ++				h->u.configured.friendly_name, jobs);
    ++	}
    ++}
    ++
    + /* Determine how many jobs to use for hook execution. */
    + static unsigned int get_hook_jobs(struct repository *r,
    + 				  struct run_hooks_opt *options,
     @@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
    - 	if (!options->stdout_to_stderr)
    - 		return 1;
      
    --	/* An explicit job count (FORCE_SERIAL jobs=1, or -j from CLI). */
    --	if (options->jobs)
    --		return options->jobs;
    -+	/* Pinned serial: FORCE_SERIAL (internal) or explicit -j1 from CLI. */
    -+	if (options->jobs == 1)
    -+		return 1;
    + cleanup:
    + 	merge_output_if_parallel(options);
    ++	warn_non_parallel_hooks_override(options->jobs, hook_list);
    + 	return options->jobs;
    + }
      
    - 	/*
    --	 * Use hook.jobs from the already-parsed config cache (in-repo), or
    --	 * fall back to a direct config lookup (out-of-repo).  Default to 1.
    -+	 * Resolve effective job count: -jN (when given) overrides config.
    -+	 * Default to 1 when both config an -jN are missing.
    - 	 */
    --	if (r && r->gitdir && r->hook_config_cache)
    -+	if (options->jobs > 1)
    -+		jobs = options->jobs;
    -+	else if (r && r->gitdir && r->hook_config_cache)
    - 		/* Use the already-parsed cache (in-repo) */
    - 		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
    - 	else
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	test_cmp expect hook.order
     +'
     +
    -+test_expect_success 'git hook run -j2 is blocked by parallel=false' '
    ++test_expect_success 'git hook run -j2 overrides parallel=false' '
     +	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
     +	test_config hook.hook-1.event test-hook &&
     +	test_config hook.hook-1.command \
    @@ t/t1800-hook.sh: test_expect_success 'server push-to-checkout hook expects stdou
     +	    "$(sentinel_detector sentinel hook.order)" &&
     +	# hook-2 also has no parallel=true
     +
    -+	# -j2 must not override parallel=false on configured hooks.
    ++	# -j2 overrides parallel=false; hooks run in parallel with a warning.
     +	git hook run -j2 test-hook >out 2>err &&
    -+	echo serial >expect &&
    ++	echo parallel >expect &&
     +	test_cmp expect hook.order
     +'
    ++
    ++test_expect_success 'git hook run -j2 warns for hooks not marked parallel=true' '
    ++	test_config hook.hook-1.event test-hook &&
    ++	test_config hook.hook-1.command "true" &&
    ++	test_config hook.hook-2.event test-hook &&
    ++	test_config hook.hook-2.command "true" &&
    ++	# neither hook has parallel=true
    ++
    ++	git hook run -j2 test-hook >out 2>err &&
    ++	grep "hook .hook-1. is not marked as parallel=true" err &&
    ++	grep "hook .hook-2. is not marked as parallel=true" err
    ++'
     +
      test_expect_success 'hook.jobs=1 config runs hooks in series' '
      	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
 7:  7b3ea03bd3 !  8:  734adfad1b hook: add per-event jobs config
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.parallel::
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.parallel::
      	found in the hooks directory do not need to, and run in parallel when
      	the effective job count is greater than 1. See linkgit:git-hook[1].
      
    @@ Documentation/config/hook.adoc: hook.<name>.parallel::
      	hook execution. If unspecified, defaults to 1 (serial execution).
     +	Can be overridden on a per-event basis with `hook.<event>.jobs`.
      	Some hooks always run sequentially regardless of this setting because
    - 	git knows they cannot safely be parallelized: `applypatch-msg`,
    - 	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
    + 	they operate on shared data and cannot safely be parallelized:
    + +
     
      ## hook.c ##
     @@ hook.c: struct hook_config_cache_entry {
       * event_hooks: event-name to list of friendly-names map.
       * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
       * parallel_hooks: friendly-name to parallel flag.
    -+ * event_jobs: event-name to per-event jobs count (heap-allocated unsigned int *,
    -+ *             where NULL == unset).
    -  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
    ++ * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
    +  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
       */
      struct hook_all_config_cb {
     @@ hook.c: struct hook_all_config_cb {
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
     +				hook_name, value);
     +		else if (!v)
     +			warning(_("hook.%s.jobs must be positive, ignoring: 0"), hook_name);
    -+		else {
    -+			unsigned int *old;
    -+			unsigned int *p = xmalloc(sizeof(*p));
    -+			*p = v;
    -+			old = strmap_put(&data->event_jobs, hook_name, p);
    -+			free(old);
    -+		}
    ++		else
    ++			strmap_put(&data->event_jobs, hook_name,
    ++				   (void *)(uintptr_t)v);
      	}
      
      	free(hook_name);
    -@@ hook.c: void hook_cache_clear(struct hook_config_cache *cache)
    - 		free(hooks);
    - 	}
    - 	strmap_clear(&cache->hooks, 0);
    -+	strmap_clear(&cache->event_jobs, 1); /* free heap-allocated unsigned int * values */
    - }
    - 
    - /* Populate `cache` with the complete hook configuration */
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      	strmap_init(&cb_data.event_hooks);
      	string_list_init_dup(&cb_data.disabled_hooks);
      	strmap_init(&cb_data.parallel_hooks);
    @@ hook.c: static void build_hook_config_map(struct repository *r,
      
      	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
      	repo_config(r, hook_config_lookup_all, &cb_data);
    -@@ hook.c: static void build_hook_config_map(struct repository *r,
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 		strmap_put(cache, e->key, hooks);
      	}
      
    - 	cache->jobs = cb_data.jobs;
    -+	cache->event_jobs = cb_data.event_jobs;
    +-	if (r)
    ++	if (r) {
    + 		r->hook_jobs = cb_data.jobs;
    ++		r->event_jobs = cb_data.event_jobs;
    ++	}
      
      	strmap_clear(&cb_data.commands, 1);
      	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
    -@@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
    +@@ hook.c: static void warn_non_parallel_hooks_override(unsigned int jobs,
      /* Determine how many jobs to use for hook execution. */
      static unsigned int get_hook_jobs(struct repository *r,
      				  struct run_hooks_opt *options,
     +				  const char *hook_name,
      				  struct string_list *hook_list)
      {
    - 	unsigned int jobs;
    -@@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
    - 		return 1;
    - 
      	/*
    --	 * Resolve effective job count: -jN (when given) overrides config.
    --	 * Default to 1 when both config an -jN are missing.
    -+	 * Resolve effective job count: -j N (when given) overrides config.
    -+	 * hook.<event>.jobs overrides hook.jobs.
    -+	 * Unset configs and -jN default to 1.
    +@@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
    + 	 * fallback to a direct config lookup (out-of-repo).
    + 	 * Default to 1 (serial execution) on failure.
      	 */
    --	if (options->jobs > 1)
    -+	if (options->jobs > 1) {
    - 		jobs = options->jobs;
    --	else if (r && r->gitdir && r->hook_config_cache)
    -+	} else if (r && r->gitdir && r->hook_config_cache) {
    +-	if (r && r->gitdir && r->hook_config_cache)
    ++	if (r && r->gitdir && r->hook_config_cache) {
      		/* Use the already-parsed cache (in-repo) */
    -+		unsigned int *event_jobs = strmap_get(&r->hook_config_cache->event_jobs,
    -+						      hook_name);
    - 		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
    ++		void *event_jobs = strmap_get(&r->event_jobs, hook_name);
    + 		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
     -	else
     +		if (event_jobs)
    -+			jobs = *event_jobs;
    ++			options->jobs = (unsigned int)(uintptr_t)event_jobs;
     +	} else {
      		/* No cache present (out-of-repo call), use direct cfg lookup */
     +		unsigned int event_jobs;
     +		char *key;
    - 		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
    ++
    + 		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
    + 			options->jobs = 1;
    + 
     +		key = xstrfmt("hook.%s.jobs", hook_name);
     +		if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
    -+			jobs = event_jobs;
    ++			options->jobs = event_jobs;
     +		free(key);
     +	}
    - 
    ++
      	/*
      	 * Cap to serial any configured hook not marked as parallel = true.
      	 * This enforces the parallel = false default, even for "traditional"
    @@ hook.c: static unsigned int get_hook_jobs(struct repository *r,
     +	 * The same restriction applies whether jobs came from hook.jobs or
     +	 * hook.<event>.jobs.
      	 */
    - 	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
    + 	for (size_t i = 0; i < hook_list->nr; i++) {
      		struct hook *h = hook_list->items[i].util;
     @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		.options = options,
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		.tr2_category = "hook",
      		.tr2_label = hook_name,
     
    - ## hook.h ##
    -@@ hook.h: void hook_free(void *p, const char *str UNUSED);
    -  */
    - struct hook_config_cache {
    - 	struct strmap hooks; /* maps event name -> string_list of hooks */
    -+	struct strmap event_jobs; /* maps event name -> heap-allocated unsigned int * */
    - 	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
    - };
    + ## repository.c ##
    +@@ repository.c: void repo_clear(struct repository *repo)
    + 		hook_cache_clear(repo->hook_config_cache);
    + 		FREE_AND_NULL(repo->hook_config_cache);
    + 	}
    ++	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
      
    + 	if (repo->promisor_remote_config) {
    + 		promisor_remote_clear(repo->promisor_remote_config);
    +
    + ## repository.h ##
    +@@ repository.h: struct repository {
    + 	/* Cached value of hook.jobs config (0 if unset, defaults to serial). */
    + 	unsigned int hook_jobs;
    + 
    ++	/* Cached map of event-name -> jobs count (as uintptr_t) from hook.<event>.jobs. */
    ++	struct strmap event_jobs;
    ++
    + 	/* Configurations related to promisor remotes. */
    + 	char *repository_format_partial_clone;
    + 	struct promisor_remote_config *promisor_remote_config;
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)'
 8:  d5cf01444f <  -:  ---------- hook: introduce extensions.hookStdoutToStderr
 9:  1cef7b5e22 <  -:  ---------- hook: allow runtime enabling extensions.hookStdoutToStderr
 -:  ---------- >  9:  d6d3196b17 hook: warn when hook.<friendly-name>.jobs is set
 -:  ---------- > 10:  b64689d0c8 hook: add hook.<event>.enabled switch

Adrian Ratiu (6):
  config: add a repo_config_get_uint() helper
  hook: parse the hook.jobs config
  hook: allow pre-push parallel execution
  hook: add per-event jobs config
  hook: warn when hook.<friendly-name>.jobs is set
  hook: add hook.<event>.enabled switch

Emily Shaffer (3):
  hook: allow parallel hook execution
  hook: mark non-parallelizable hooks
  hook: add -j/--jobs option to git hook run

 Documentation/config/hook.adoc |  66 +++++
 Documentation/git-hook.adoc    |  18 +-
 builtin/am.c                   |   8 +-
 builtin/checkout.c             |  19 +-
 builtin/clone.c                |   6 +-
 builtin/hook.c                 |  25 +-
 builtin/receive-pack.c         |   3 +-
 builtin/worktree.c             |   2 +-
 commit.c                       |   2 +-
 config.c                       |  28 ++
 config.h                       |  13 +
 hook.c                         | 222 ++++++++++++++-
 hook.h                         |  32 ++-
 parse.c                        |   9 +
 parse.h                        |   1 +
 repository.c                   |   2 +
 repository.h                   |  10 +
 t/t1800-hook.sh                | 476 ++++++++++++++++++++++++++++++++-
 transport.c                    |   6 +-
 19 files changed, 903 insertions(+), 45 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

