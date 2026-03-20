Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D683BB9E0
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014861; cv=pass; b=GscTtvN+bfic1U1mPcxM6q38j/AyMa5TmjEr2Kf8QpK0oDGqY+xlnPwnzBOxKmXD66Vy3gEswN8AWwrfdu64SfgUOdta0Dnr61w2lBgiHF9osEaAfmOHNe626UPLPRwagbQNGWqX1idoIYGCn4CK1eBiZNpGX/arGUr5ObK9EV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014861; c=relaxed/simple;
	bh=cFJJJH09puI6XXDh/lQ9Gqwe0me99AQeQEavJTfySyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwiRj4uVnV9QLgbVLXnQy5JDZoC1oeWJ5aSvdA15qfbbHKXUJdCdckXoJW3jVwnQZNLCWSeDfmHAcEy1c9/PkIISbBZ6yP1gio8uN2FivkCfBETERA2V5R8ulCUFXmKa9x8JVBaIW+XgLVu5nZsYoQbfAMkUEQUgCvxY1ej1xBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=V8NzRrXZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="V8NzRrXZ"
ARC-Seal: i=1; a=rsa-sha256; t=1774014838; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TnV57YH7kUls8JKr2LH77ndu5oYp5sGm6BhM+KrJBg3UllsLRKnm0Do0qVJJJpboWiqCUqGqpTybjE0Yn94N7s7+nWruTEnFVwewgZAWyZkxdoo4321NHTPM1XoJbvrC41vDotjnRaDGCVbERZ18NdcLerFNBAR9uNyQKiD1of0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774014838; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KjTfQeeTkrEHAiw4hhjRzA/S8ed9bAayxnEbwwBQVgg=; 
	b=D5v+4G/2AeaOAzyQvFu/7BwD7vQF6vMsI1890+g6sfnXIi873yFmtzTVFYFTl23neqSnDs6hTgac6Pl75Uijp3xgHwcHuLHsOzwjZJ/B6XV1Va3PrNPUC0VHec9KFNkqvw+hjEjjMqJh7+uzH97L9lNwDT1uSnOwE3TAIKgl7iM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774014838;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KjTfQeeTkrEHAiw4hhjRzA/S8ed9bAayxnEbwwBQVgg=;
	b=V8NzRrXZ1laxWHmjfZS0bgJIQVBPrxh93TkXahAffb1LKzyBxFdVK1xIsgXcqm2b
	eEr0j4sciTOegxZ5SSqopm3Lt5DcbJZrQQJ40+unmV0WMWD+ZHBUqcwJMDJ2Y79fHTd
	PkBt19aSDSYNtnen/YKIMkxG2Jozu95X4P5o3hy8=
Received: by mx.zohomail.com with SMTPS id 1774014836021828.2504248114111;
	Fri, 20 Mar 2026 06:53:56 -0700 (PDT)
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
Subject: [PATCH v4 7/9] hook: add per-event jobs config
Date: Fri, 20 Mar 2026 15:53:09 +0200
Message-ID: <20260320135311.331463-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320135311.331463-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260320135311.331463-1-adrian.ratiu@collabora.com>
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
 hook.c                         | 38 +++++++++++++++++++---
 repository.c                   |  1 +
 repository.h                   |  3 ++
 t/t1800-hook.sh                | 59 ++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 4 deletions(-)

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
index 0b581a6c43..e40c1f3a85 100644
--- a/hook.c
+++ b/hook.c
@@ -129,6 +129,7 @@ struct hook_config_cache_entry {
  * event_hooks: event-name to list of friendly-names map.
  * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
  * parallel_hooks: friendly-name to parallel flag.
+ * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
  */
 struct hook_all_config_cb {
@@ -136,6 +137,7 @@ struct hook_all_config_cb {
 	struct strmap event_hooks;
 	struct string_list disabled_hooks;
 	struct strmap parallel_hooks;
+	struct strmap event_jobs;
 	unsigned int jobs;
 };
 
@@ -230,6 +232,16 @@ static int hook_config_lookup_all(const char *key, const char *value,
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
+		else
+			strmap_put(&data->event_jobs, hook_name,
+				   (void *)(uintptr_t)v);
 	}
 
 	free(hook_name);
@@ -275,6 +287,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	strmap_init(&cb_data.event_hooks);
 	string_list_init_dup(&cb_data.disabled_hooks);
 	strmap_init(&cb_data.parallel_hooks);
+	strmap_init(&cb_data.event_jobs);
 
 	/* Parse all configs in one run, capturing hook.* including hook.jobs. */
 	repo_config(r, hook_config_lookup_all, &cb_data);
@@ -322,8 +335,10 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 		strmap_put(cache, e->key, hooks);
 	}
 
-	if (r)
+	if (r) {
 		r->hook_jobs = cb_data.jobs;
+		r->event_jobs = cb_data.event_jobs;
+	}
 
 	strmap_clear(&cb_data.commands, 1);
 	strmap_clear(&cb_data.parallel_hooks, 0); /* values are uintptr_t, not heap ptrs */
@@ -585,6 +600,7 @@ static void warn_non_parallel_hooks_override(unsigned int jobs,
 /* Determine how many jobs to use for hook execution. */
 static unsigned int get_hook_jobs(struct repository *r,
 				  struct run_hooks_opt *options,
+				  const char *hook_name,
 				  struct string_list *hook_list)
 {
 	/*
@@ -602,18 +618,32 @@ static unsigned int get_hook_jobs(struct repository *r,
 	 * fallback to a direct config lookup (out-of-repo).
 	 * Default to 1 (serial execution) on failure.
 	 */
-	if (r && r->gitdir && r->hook_config_cache)
+	if (r && r->gitdir && r->hook_config_cache) {
 		/* Use the already-parsed cache (in-repo) */
+		void *event_jobs = strmap_get(&r->event_jobs, hook_name);
 		options->jobs = r->hook_jobs ? r->hook_jobs : 1;
-	else
+		if (event_jobs)
+			options->jobs = (unsigned int)(uintptr_t)event_jobs;
+	} else {
 		/* No cache present (out-of-repo call), use direct cfg lookup */
+		unsigned int event_jobs;
+		char *key;
+
 		if (repo_config_get_uint(r, "hook.jobs", &options->jobs))
 			options->jobs = 1;
 
+		key = xstrfmt("hook.%s.jobs", hook_name);
+		if (!repo_config_get_uint(r, key, &event_jobs) && event_jobs)
+			options->jobs = event_jobs;
+		free(key);
+	}
+
 	/*
 	 * Cap to serial any configured hook not marked as parallel = true.
 	 * This enforces the parallel = false default, even for "traditional"
 	 * hooks from the hookdir which cannot be marked parallel = true.
+	 * The same restriction applies whether jobs came from hook.jobs or
+	 * hook.<event>.jobs.
 	 */
 	for (size_t i = 0; i < hook_list->nr; i++) {
 		struct hook *h = hook_list->items[i].util;
@@ -640,7 +670,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.options = options,
 	};
 	int ret = 0;
-	unsigned int jobs = get_hook_jobs(r, options, hook_list);
+	unsigned int jobs = get_hook_jobs(r, options, hook_name, hook_list);
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
diff --git a/repository.c b/repository.c
index fb4356ca55..ff3c357dfc 100644
--- a/repository.c
+++ b/repository.c
@@ -425,6 +425,7 @@ void repo_clear(struct repository *repo)
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
index a0a7301701..cf4dc1ce6f 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -937,4 +937,63 @@ test_expect_success 'hook.jobs=2 is ignored for force-serial hooks (pre-commit)'
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

