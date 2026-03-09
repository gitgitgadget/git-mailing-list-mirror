Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CB3C6A5A
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063549; cv=pass; b=NESrmfsb88z2yCNHyH8hdcOnCQlcd83q3OE3gNtu+dj65RSEWrEWbpROgYxkxjXwvv4yMR+aWjchZvdhQl9Wc+i0zSLVkdvRufN7a+5dyOnwzR0YAwBTYMAovC0R/omlDs47lbvTqrN2e3eKk8+AA++tzilUX/zZooQt+oL2cus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063549; c=relaxed/simple;
	bh=t4UyPhQtCO3LgBlPaeJ76vN6yOPvKHY/QegvrXJnMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joOc4yuSovWp+2GiXQPMo88A1n7niZtuNEgKGe3Q4gTzE5TLqiO73UyN2uf1/W+59jEoAvIg9RZyeDma1vcCU9msz3XpylSE3M9cMo+8mR6eaOLhUMk8tkrM2CNbEMnT9e9XBQmdsg1DEaCLS62OuEec3mi3oybgIIHy15iHY14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IO4ZeX0v; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IO4ZeX0v"
ARC-Seal: i=1; a=rsa-sha256; t=1773063527; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mh+R+A4bWXZhs7nbCH2hTctAPlT/m5kmHmgUR82/T618K/CulKPf7NEasRtLLjwz7KHviOF5y8c31jEy0SJqqikBEXdUD91J+P4HMbFWPR4I0o0cmb+jwB1uMaj2zHkeSeNkGtzaxHoyVGOJ7XYJcJvXOng8OqV/zuNSZgr0WSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773063527; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wWvlEk75Zc1dvaEXXAAOqIjo7/x/ePV3qEQXKeMrkYE=; 
	b=Wz4UG1cD4qs8MuR9+MGXnnMtJq8K+UL5q9wHfbEEFJAE/kEuXrJoSQPS+i3QBKrX+y3xKLGEFLx0v1zWX97pmHdygCWOMuT4vMgLSiRipwJd/oN5vU1WAcWQ4atyhVOtJgR52d0E+p3/cH9DYpz4Who29lmK2I8K4ajpGXKjL4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773063527;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wWvlEk75Zc1dvaEXXAAOqIjo7/x/ePV3qEQXKeMrkYE=;
	b=IO4ZeX0vL728VG44FkZyMXMeckAxIc9IvJOpWx4Rna8Rnqc5PojlCfrGw5n3jtHz
	VEwlv7pFSYecjir2MGW6icqzmht3qAp/dwq8JIGhatwSkNDPWlqa4oygJmZ8v5uOeSL
	DOQY1JbtEar8uIqPhbbMO2ky3k5tV5mSeQj1GbPM=
Received: by mx.zohomail.com with SMTPS id 177306352601312.38773217439325;
	Mon, 9 Mar 2026 06:38:46 -0700 (PDT)
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
Subject: [PATCH v3 7/9] hook: add per-event jobs config
Date: Mon,  9 Mar 2026 15:37:37 +0200
Message-ID: <20260309133739.294555-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309133739.294555-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260309133739.294555-1-adrian.ratiu@collabora.com>
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
 hook.c                         | 47 +++++++++++++++++++++++----
 hook.h                         |  1 +
 t/t1800-hook.sh                | 59 ++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index d2e4b33240..ca97ea6f1e 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -33,9 +33,28 @@ hook.<name>.parallel::
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
 	git knows they cannot safely be parallelized: `applypatch-msg`,
 	`pre-commit`, `prepare-commit-msg`, `commit-msg`, `post-commit`,
diff --git a/hook.c b/hook.c
index 299cbf9e97..b70c4c15ec 100644
--- a/hook.c
+++ b/hook.c
@@ -129,6 +129,8 @@ struct hook_config_cache_entry {
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
  * parallel_hooks: friendly-name to parallel flag.
+ * event_jobs: event-name to per-event jobs count (heap-allocated unsigned int *,
+ *             where NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset.
  */
 struct hook_all_config_cb {
@@ -136,6 +138,7 @@ struct hook_all_config_cb {
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
 	struct strmap parallel_hooks;
+	struct strmap event_jobs;
 	unsigned int jobs;
 };
 
@@ -230,6 +233,20 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		int v = git_parse_maybe_bool(value);
 		if (v >= 0)
 			strmap_put(&data->parallel_hooks, hook_name, (void *)(uintptr_t)v);
+	} else if (!strcmp(subkey, "jobs")) {
+		unsigned int v;
+		if (!git_parse_uint(value, &v))
+			warning(_("hook.%s.jobs must be a positive integer, ignoring: '%s'"),
+				hook_name, value);
+		else if (!v)
+			warning(_("hook.%s.jobs must be positive, ignoring: 0"), hook_name);
+		else {
+			unsigned int *old;
+			unsigned int *p = xmalloc(sizeof(*p));
+			*p = v;
+			old = strmap_put(&data->event_jobs, hook_name, p);
+			free(old);
+		}
 	}
 
 	free(hook_name);
@@ -262,6 +279,7 @@ void hook_cache_clear(struct hook_config_cache *cache)
 		free(hooks);
 	}
 	strmap_clear(&cache->hooks, 0);
+	strmap_clear(&cache->event_jobs, 1); /* free heap-allocated unsigned int * values */
 }
 
 /* Populate `cache` with the complete hook configuration */
@@ -276,6 +294,7 @@ static void build_hook_config_map(struct repository *r,
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 	strmap_init(&cb_data.parallel_hooks);
+	strmap_init(&cb_data.event_jobs);
 
 	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
@@ -324,6 +343,7 @@ static void build_hook_config_map(struct repository *r,
 	}
 
 	cache->jobs = cb_data.jobs;
+	cache->event_jobs = cb_data.event_jobs;
 
 	strmap_clear(&cb_data.commands, 1);
 	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
@@ -556,6 +576,7 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
+				  const char *hook_name,
 				  struct string_list *hook_list)
 {
 	unsigned int jobs;
@@ -572,22 +593,36 @@ static unsigned int get_hook_jobs(struct repository *r,
 		return 1;
 
 	/*
-	 * Resolve effective job count: -jN (when given) overrides config.
-	 * Default to 1 when both config an -jN are missing.
+	 * Resolve effective job count: -j N (when given) overrides config.
+	 * hook.<event>.jobs overrides hook.jobs.
+	 * Unset configs and -jN default to 1.
 	 */
-	if (options->jobs > 1)
+	if (options->jobs > 1) {
 		jobs = options->jobs;
-	else if (r && r->gitdir && r->hook_config_cache)
+	} else if (r && r->gitdir && r->hook_config_cache) {
 		/* Use the already-parsed cache (in-repo) */
+		unsigned int *event_jobs = strmap_get(&r->hook_config_cache->event_jobs,
+						      hook_name);
 		jobs = r->hook_config_cache->jobs ? r->hook_config_cache->jobs : 1;
-	else
+		if (event_jobs)
+			jobs = *event_jobs;
+	} else {
 		/* No cache present (out-of-repo call), use direct cfg lookup */
+		unsigned int event_jobs;
+		char *key;
 		jobs = repo_config_get_uint(r, "hook.jobs", &jobs) ? 1 : jobs;
+		key = xstrfmt("hook.%s.jobs", hook_name);
+		if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
+			jobs = event_jobs;
+		free(key);
+	}
 
 	/*
 	 * Cap to serial any configured hook not marked as parallel = true.
 	 * This enforces the parallel = false default, even for "traditional"
 	 * hooks from the hookdir which cannot be marked parallel = true.
+	 * The same restriction applies whether jobs came from hook.jobs or
+	 * hook.<event>.jobs.
 	 */
 	for (size_t i = 0; jobs > 1 && i < hook_list->nr; i++) {
 		struct hook *h = hook_list->items[i].util;
@@ -609,7 +644,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.options = options,
 	};
 	int ret = 0;
-	unsigned int jobs = get_hook_jobs(r, options, hook_list);
+	unsigned int jobs = get_hook_jobs(r, options, hook_name, hook_list);
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
diff --git a/hook.h b/hook.h
index a0f6a9db47..e8603c4370 100644
--- a/hook.h
+++ b/hook.h
@@ -233,6 +233,7 @@ void hook_free(void *p, const char *str UNUSED);
  */
 struct hook_config_cache {
 	struct strmap hooks; /* maps event name -> string_list of hooks */
+	struct strmap event_jobs; /* maps event name -> heap-allocated unsigned int * */
 	unsigned int jobs; /* hook.jobs config value; 0 if unset (defaults to serial) */
 };
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index fbe8be25c8..195cc5333e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -893,4 +893,63 @@ test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)'
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
+	git hook run test-hook >out 2>err &&
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
+	git hook run test-hook >out 2>err &&
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
+	git hook run test-hook >out 2>err &&
+	echo serial >expect &&
+	test_cmp expect hook.order
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

