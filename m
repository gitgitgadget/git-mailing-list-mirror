Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F0356A38
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775291434; cv=pass; b=tSp//yROjlAOfoSHh2qGJ+razuZRxA5JrmhxluGwmtFUfrKqzVCehfGIn935iR4wIJmGICqOVqqJnOrm4q4YC2KnYGQ4HJc4hhvkOYvXBaIIMD6CqxHjtoxzIEQuAuLt8V36Ox3oCzzrrF922sJ3m87GZdbAnook08jXKIEAU2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775291434; c=relaxed/simple;
	bh=rG3B+z7a0uB/Npb7acjXBUvQdDJx7stAYUTX7DXyzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6wBUWtgri9vIhMqKjJZrZ3C0+N9F05ZbnWAF6TM36TzjSWiO7R9v02uaWvNJO0XxZZAg0pnMTjaf31hyMlev3enRe5f6WSPIpVE90VqqaX/hzX7+3YwlgQvQ1jX3LCkT/kIErV5/QHO1OmXI3xjJYw6aypSy5JMNOhhNDrhzsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FVimPVgH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FVimPVgH"
ARC-Seal: i=1; a=rsa-sha256; t=1775291414; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iJQ+xwmwPOnOR3LklH7/I9GGD+aPX1h2uvZAvbWbs7BQI+5C6j5AZLL4G2pIufu0J+wJ81qes20jlrUIwxZP3tvthktALfX3+2DFZSy/z+8hvBwd+80dR7P/JRrypFLMAZH4Z4bMHtc/rF1tQXC9x9wnKrDjVY2McnyKvleVZJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775291414; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ErCt62Z37L3I+SQuoUBd+99cNQ0PLN+GfWKQFOKue3I=; 
	b=QmfzeEU6eoJzA+hbNjX8zXUXlCyvN/73RpiETe5+yVOGJl5bg+jbG9SGVRXRkoMHjazCTEcGyZQ5B7Hf+0Q3WwvM5BSgYh+44xVW5D73xsBy4GFpEo0vm2xe6oD2mEvUCDVBrKa79ippAathYhH6Th7cVaaYfyEHOR+wDpiGt1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775291414;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ErCt62Z37L3I+SQuoUBd+99cNQ0PLN+GfWKQFOKue3I=;
	b=FVimPVgHeuN150nGhQ2T6/N/gM60+nZG/MTCL3nabxOUsXcSYFInNorXsdDmgSnw
	Ww20W/Jf9Z7XQozznmI+8N1kFR8Sy34N+PVW3Cf7oGcq/hU6w9xj7AWPYnIHHFPZLlA
	Ul6FgP3EH6fc1PNtAzqZp+/OM/WARsRooDPYbCFs=
Received: by mx.zohomail.com with SMTPS id 1775291412597291.4108349822825;
	Sat, 4 Apr 2026 01:30:12 -0700 (PDT)
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
Subject: [PATCH v6 08/12] hook: add per-event jobs config
Date: Sat,  4 Apr 2026 11:29:30 +0300
Message-ID: <20260404082934.173788-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260404082934.173788-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260404082934.173788-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a hook.<event>.jobs count config that allows users to override the
global hook.jobs setting for specific hook events.

This allows finer-grained control over parallelism on a per-event basis.

For example, to run `post-receive` hooks with up to 4 parallel jobs
while keeping other events at their global default:

[hook]
    post-receive.jobs = 4

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc | 19 +++++++++++
 hook.c                         | 46 +++++++++++++++++++++++---
 repository.c                   |  1 +
 repository.h                   |  3 ++
 t/t1800-hook.sh                | 59 ++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 6f60775c28..d4fa29d936 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -33,9 +33,28 @@ hook.<friendly-name>.parallel::
 	found in the hooks directory do not need to, and run in parallel when
 	the effective job count is greater than 1. See linkgit:git-hook[1].
 
+hook.<event>.jobs::
+	Specifies how many hooks can be run simultaneously for the `<event>`
+	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
+	for this specific event. The same parallelism restrictions apply: this
+	setting has no effect unless all configured hooks for the event have
+	`hook.<friendly-name>.parallel` set to `true`. Must be a positive int,
+	zero is rejected with a warning. See linkgit:git-hook[1].
++
+Note on naming: although this key resembles `hook.<friendly-name>.*`
+(a per-hook setting), `<event>` must be the event name, not a hook
+friendly name. The key component is stored literally and looked up by
+event name at runtime with no translation between the two namespaces.
+A key like `hook.my-hook.jobs` is stored under `"my-hook"` but the
+lookup at runtime uses the event name (e.g. `"post-receive"`), so
+`hook.my-hook.jobs` is silently ignored even when `my-hook` is
+registered for that event. Use `hook.post-receive.jobs` or any other
+valid event name when setting `hook.<event>.jobs`.
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to 1 (serial execution).
+	Can be overridden on a per-event basis with `hook.<event>.jobs`.
 	Some hooks always run sequentially regardless of this setting because
 	they operate on shared data and cannot safely be parallelized:
 +
diff --git a/hook.c b/hook.c
index c0b71322cf..d98b011563 100644
--- a/hook.c
+++ b/hook.c
@@ -125,6 +125,7 @@ struct hook_config_cache_entry {
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
  * parallel_hooks: friendly-name to parallel flag.
+ * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
  */
 struct hook_all_config_cb {
@@ -132,6 +133,7 @@ struct hook_all_config_cb {
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
 	struct strmap parallel_hooks;
+	struct strmap event_jobs;
 	unsigned int jobs;
 };
 
@@ -231,6 +233,18 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			warning(_("hook.%s.parallel must be a boolean,"
 				  " ignoring: '%s'"),
 				hook_name, value);
+	} else if (!strcmp(subkey, "jobs")) {
+		unsigned int v;
+		if (!git_parse_uint(value, &v))
+			warning(_("hook.%s.jobs must be a positive integer,"
+				  " ignoring: '%s'"),
+				hook_name, value);
+		else if (!v)
+			warning(_("hook.%s.jobs must be positive,"
+				  " ignoring: 0"), hook_name);
+		else
+			strmap_put(&data->event_jobs, hook_name,
+				   (void *)(uintptr_t)v);
 	}
 
 	free(hook_name);
@@ -276,6 +290,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 	strmap_init(&cb_data.parallel_hooks);
+	strmap_init(&cb_data.event_jobs);
 
 	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
@@ -323,8 +338,10 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 		strmap_put(cache, e->key, hooks);
 	}
 
-	if (r)
+	if (r) {
 		r->hook_jobs = cb_data.jobs;
+		r->event_jobs = cb_data.event_jobs;
+	}
 
 	strmap_clear(&cb_data.commands, 1);
 	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
@@ -587,6 +604,7 @@ static void warn_non_parallel_hooks_override(unsigned int jobs,
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
+				  const char *hook_name,
 				  struct string_list *hook_list)
 {
 	/*
@@ -606,16 +624,34 @@ static unsigned int get_hook_jobs(struct repository *r,
 	 */
 	options->jobs = 1;
 	if (r) {
-		if (r->gitdir && r->hook_config_cache && r->hook_jobs)
-			options->jobs = r->hook_jobs;
-		else
+		if (r->gitdir && r->hook_config_cache) {
+			void *event_jobs;
+
+			if (r->hook_jobs)
+				options->jobs = r->hook_jobs;
+
+			event_jobs = strmap_get(&r->event_jobs, hook_name);
+			if (event_jobs)
+				options->jobs = (unsigned int)(uintptr_t)event_jobs;
+		} else {
+			unsigned int event_jobs;
+			char *key;
+
 			repo_config_get_uint(r, "hook.jobs", &options->jobs);
+
+			key = xstrfmt("hook.%s.jobs", hook_name);
+			if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
+				options->jobs = event_jobs;
+			free(key);
+		}
 	}
 
 	/*
 	 * Cap to serial any configured hook not marked as parallel = true.
 	 * This enforces the parallel = false default, even for "traditional"
 	 * hooks from the hookdir which cannot be marked parallel = true.
+	 * The same restriction applies whether jobs came from hook.jobs or
+	 * hook.<event>.jobs.
 	 */
 	for (size_t i = 0; i < hook_list->nr; i++) {
 		struct hook *h = hook_list->items[i].util;
@@ -642,7 +678,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.options = options,
 	};
 	int ret = 0;
-	unsigned int jobs = get_hook_jobs(r, options, hook_list);
+	unsigned int jobs = get_hook_jobs(r, options, hook_name, hook_list);
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
diff --git a/repository.c b/repository.c
index 192d6dc9c4..4030db4460 100644
--- a/repository.c
+++ b/repository.c
@@ -426,6 +426,7 @@ void repo_clear(struct repository *repo)
 		hook_cache_clear(repo->hook_config_cache);
 		FREE_AND_NULL(repo->hook_config_cache);
 	}
+	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
 
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
diff --git a/repository.h b/repository.h
index 58e46853d0..6b67ec02e2 100644
--- a/repository.h
+++ b/repository.h
@@ -175,6 +175,9 @@ struct repository {
 	/* Cached value of hook.jobs config (0 if unset, defaults to serial). */
 	unsigned int hook_jobs;
 
+	/* Cached map of event-name -> jobs count (as uintptr_t) from hook.<event>.jobs. */
+	struct strmap event_jobs;
+
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
 	struct promisor_remote_config *promisor_remote_config;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index a1734fd628..ab2b52bec6 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -969,4 +969,63 @@ test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)'
 	test_cmp expect hook.order
 '
 
+test_expect_success 'hook.<event>.jobs overrides hook.jobs for that event' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-1.parallel true &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+
+	# Global hook.jobs=1 (serial), but per-event override allows parallel.
+	test_config hook.jobs 1 &&
+	test_config hook.test-hook.jobs 2 &&
+
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	echo parallel >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'hook.<event>.jobs=1 forces serial even when hook.jobs>1' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	test_config hook.hook-1.parallel true &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	test_config hook.hook-2.parallel true &&
+
+	# Global hook.jobs=4 allows parallel, but per-event override forces serial.
+	test_config hook.jobs 4 &&
+	test_config hook.test-hook.jobs 1 &&
+
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
+test_expect_success 'hook.<event>.jobs still requires hook.<name>.parallel=true' '
+	test_when_finished "rm -f sentinel.started sentinel.done hook.order" &&
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command \
+	    "touch sentinel.started; sleep 2; touch sentinel.done" &&
+	# hook-1 intentionally has no parallel=true
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command \
+	    "$(sentinel_detector sentinel hook.order)" &&
+	# hook-2 also has no parallel=true
+
+	# Per-event jobs=2 but no hook has parallel=true: must still run serially.
+	test_config hook.test-hook.jobs 2 &&
+
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

