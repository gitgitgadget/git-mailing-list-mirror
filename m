Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CB223DD6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453468; cv=pass; b=KuE3q5AayyrYWPWliXL/o1OcOxrujMZtOhR7vB+XrgMQPTPi8ywsLAQpzwDauSY+KDmuUArwlVhGuru4szSZPMCCF1BaAAplVBoFTp7+xuQj1qsh61uar8Nky0r8sChy3vqKSu/KHo7cwnhBljT6uKbMU0cciX7rj1Ttj4iTSK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453468; c=relaxed/simple;
	bh=7m0LtbIHOgRO+GzrAoTTDNRRYlr56FTeAUa3Lj30PzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ppy+C1i9nguAi85W3Y7mL0vc0WmP6FfiHkrrsQZLNuoVrjZG9Au1P9Wo0AkiBSm1VL6Tx9iy53J5cVyfwa5c5vFbUajZaN9m/t10EoUvvLVECrvv8KGtDYgikRT/a8HGmOaLAmXGacpZSMj8XYRKxjStudUHuaa0VbZIp6UG+Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Xd9D1Z9j; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Xd9D1Z9j"
ARC-Seal: i=1; a=rsa-sha256; t=1771453452; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cqa/6KpDFWQ/8QoRg0DCPH3VUaSFLfGFdU2EezqVszDsNOrGUt/YWiWL+DTMO31IvGbJtUcpnv8ADTJcJk7K4l9ppVu0aFRi4M2oUAYmOspfKDKXywAKgFnSt60JL7vUp7BpsgksVrALdxSPq90P6i4ATUwoJ6whyrxknVAVGOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453452; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3eEDGRL7ii6AsxHyNVQfwKwPBS8dKm75iSvXx+VhrZw=; 
	b=Hh5Axltjpc7NOHLJoHwNwqCGbmdenCOnVZu4w6VvB0OPr9w5tprGMfCFmCm+PuIt6drcUb/W5Bw9QSSrhSq5/l4rzzvwN94efrhiWso/xu3qazHzUjEI91NRqY0tMwx3by0SdcJOaL9KSGE8cQALau/g1O3UKUpspNrqbIddbI0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453452;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3eEDGRL7ii6AsxHyNVQfwKwPBS8dKm75iSvXx+VhrZw=;
	b=Xd9D1Z9je6woxL2RQ8DvK9l2Ru0/OcdPL1eiIC9PaNJNd+0rH0rU4ili629+e+jx
	SNAnzlQhaeBaQ2jwJXrssjba0Q1TNVISQh97vdiu58N6ZYVkb1sMtdm0FnUnEiUB4GI
	SH+mOQriNkiPR+zODwd2KXOmUbo4xHjdIwKKLPqM=
Received: by mx.zohomail.com with SMTPS id 1771453451245526.8705542752672;
	Wed, 18 Feb 2026 14:24:11 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 2/8] hook: run a list of hooks to prepare for multihook support
Date: Thu, 19 Feb 2026 00:23:46 +0200
Message-ID: <20260218222352.55393-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

Hooks are limited to run one command (the default from the hookdir) for
each event. This limitation makes it impossible to run multiple commands
via config files, which the next commits will add.

Implement the ability to run a list of hooks in hook.[ch]. For now, the
list contains only one entry representing the "default" hook from the
hookdir, so there is no user-visible change in this commit.

All hook commands still run sequentially like before. A separate patch
series will enable running them in parallel.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 139 ++++++++++++++++++++++++++++++++++++++++++++-------------
 hook.h |  59 ++++++++++++++++++------
 2 files changed, 153 insertions(+), 45 deletions(-)

diff --git a/hook.c b/hook.c
index 83ff658866..c008a7232d 100644
--- a/hook.c
+++ b/hook.c
@@ -47,9 +47,97 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
+static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
+{
+	if (!h)
+		return;
+
+	if (h->kind == HOOK_TRADITIONAL)
+		free((void *)h->u.traditional.path);
+
+	if (cb_data_free)
+		cb_data_free(h->feed_pipe_cb_data);
+
+	free(h);
+}
+
+static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, hooks)
+		hook_clear(item->util, cb_data_free);
+
+	string_list_clear(hooks, 0);
+}
+
+/* Helper to detect and add default "traditional" hooks from the hookdir. */
+static void list_hooks_add_default(struct repository *r, const char *hookname,
+				   struct string_list *hook_list,
+				   struct run_hooks_opt *options)
+{
+	const char *hook_path = find_hook(r, hookname);
+	struct hook *h;
+
+	if (!hook_path)
+		return;
+
+	h = xcalloc(1, sizeof(struct hook));
+
+	/*
+	 * If the hook is to run in a specific dir, a relative path can
+	 * become invalid in that dir, so convert to an absolute path.
+	 */
+	if (options && options->dir)
+		hook_path = absolute_path(hook_path);
+
+	/* Setup per-hook internal state cb data */
+	if (options && options->feed_pipe_cb_data_alloc)
+		h->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
+
+	h->kind = HOOK_TRADITIONAL;
+	h->u.traditional.path = xstrdup(hook_path);
+
+	string_list_append(hook_list, hook_path)->util = h;
+}
+
+/*
+ * Provides a list of hook commands to run for the 'hookname' event.
+ *
+ * This function consolidates hooks from two sources:
+ * 1. The config-based hooks (not yet implemented).
+ * 2. The "traditional" hook found in the repository hooks directory
+ *    (e.g., .git/hooks/pre-commit).
+ *
+ * The list is ordered by execution priority.
+ *
+ * The caller is responsible for freeing the memory of the returned list
+ * using string_list_clear() and free().
+ */
+static struct string_list *list_hooks(struct repository *r, const char *hookname,
+			       struct run_hooks_opt *options)
+{
+	struct string_list *hook_head;
+
+	if (!hookname)
+		BUG("null hookname was provided to hook_list()!");
+
+	hook_head = xmalloc(sizeof(struct string_list));
+	string_list_init_dup(hook_head);
+
+	/* Add the default "traditional" hooks from hookdir. */
+	list_hooks_add_default(r, hookname, hook_head, options);
+
+	return hook_head;
+}
+
 int hook_exists(struct repository *r, const char *name)
 {
-	return !!find_hook(r, name);
+	struct string_list *hooks = list_hooks(r, name, NULL);
+	int exists = hooks->nr > 0;
+	hook_list_clear(hooks, NULL);
+	free(hooks);
+	return exists;
 }
 
 static int pick_next_hook(struct child_process *cp,
@@ -58,11 +146,14 @@ static int pick_next_hook(struct child_process *cp,
 			  void **pp_task_cb)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
-	const char *hook_path = hook_cb->hook_path;
+	struct string_list *hook_list = hook_cb->hook_command_list;
+	struct hook *h;
 
-	if (!hook_path)
+	if (hook_cb->hook_to_run_index >= hook_list->nr)
 		return 0;
 
+	h = hook_list->items[hook_cb->hook_to_run_index++].util;
+
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
 
@@ -85,21 +176,20 @@ static int pick_next_hook(struct child_process *cp,
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
-	strvec_push(&cp->args, hook_path);
+	/* Add hook exec paths or commands */
+	if (h->kind == HOOK_TRADITIONAL)
+		strvec_push(&cp->args, h->u.traditional.path);
+
+	if (!cp->args.nr)
+		BUG("hook must have at least one command or exec path");
+
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
 
 	/*
 	 * Provide per-hook internal state via task_cb for easy access, so
 	 * hook callbacks don't have to go through hook_cb->options.
 	 */
-	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
-
-	/*
-	 * This pick_next_hook() will be called again, we're only
-	 * running one hook, so indicate that no more work will be
-	 * done.
-	 */
-	hook_cb->hook_path = NULL;
+	*pp_task_cb = h->feed_pipe_cb_data;
 
 	return 1;
 }
@@ -133,8 +223,6 @@ static int notify_hook_finished(int result,
 
 static void run_hooks_opt_clear(struct run_hooks_opt *options)
 {
-	if (options->feed_pipe_cb_data_free)
-		options->feed_pipe_cb_data_free(options->feed_pipe_cb_data);
 	strvec_clear(&options->env);
 	strvec_clear(&options->args);
 }
@@ -142,13 +230,11 @@ static void run_hooks_opt_clear(struct run_hooks_opt *options)
 int run_hooks_opt(struct repository *r, const char *hook_name,
 		  struct run_hooks_opt *options)
 {
-	struct strbuf abs_path = STRBUF_INIT;
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
 		.options = options,
 	};
-	const char *const hook_path = find_hook(r, hook_name);
 	int ret = 0;
 	const struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
@@ -182,30 +268,21 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
 		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
 
-	if (options->feed_pipe_cb_data_alloc)
-		options->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
-
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
-	if (!hook_path && !options->error_if_missing)
-		goto cleanup;
-
-	if (!hook_path) {
-		ret = error("cannot find a hook named %s", hook_name);
+	cb_data.hook_command_list = list_hooks(r, hook_name, options);
+	if (!cb_data.hook_command_list->nr) {
+		if (options->error_if_missing)
+			ret = error("cannot find a hook named %s", hook_name);
 		goto cleanup;
 	}
 
-	cb_data.hook_path = hook_path;
-	if (options->dir) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		cb_data.hook_path = abs_path.buf;
-	}
-
 	run_processes_parallel(&opts);
 	ret = cb_data.rc;
 cleanup:
-	strbuf_release(&abs_path);
+	hook_list_clear(cb_data.hook_command_list, options->feed_pipe_cb_data_free);
+	free(cb_data.hook_command_list);
 	run_hooks_opt_clear(options);
 	return ret;
 }
diff --git a/hook.h b/hook.h
index a6bdc6f90f..3256d2dddb 100644
--- a/hook.h
+++ b/hook.h
@@ -2,9 +2,41 @@
 #define HOOK_H
 #include "strvec.h"
 #include "run-command.h"
+#include "string-list.h"
 
 struct repository;
 
+/**
+ * Represents a hook command to be run.
+ * Hooks can be:
+ * 1. "traditional" (found in the hooks directory)
+ * 2. "configured" (defined in Git's configuration, not yet implemented).
+ * The 'kind' field determines which part of the union 'u' is valid.
+ */
+struct hook {
+	enum {
+		HOOK_TRADITIONAL,
+	} kind;
+	union {
+		struct {
+			const char *path;
+		} traditional;
+	} u;
+
+	/**
+	 * Opaque data pointer used to keep internal state across callback calls.
+	 *
+	 * It can be accessed directly via the third hook callback arg:
+	 * struct ... *state = pp_task_cb;
+	 *
+	 * The caller is responsible for managing the memory for this data by
+	 * providing alloc/free callbacks to `run_hooks_opt`.
+	 *
+	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
+	 */
+	void *feed_pipe_cb_data;
+};
+
 typedef void (*cb_data_free_fn)(void *data);
 typedef void *(*cb_data_alloc_fn)(void *init_ctx);
 
@@ -85,19 +117,6 @@ struct run_hooks_opt
 	 */
 	void *feed_pipe_ctx;
 
-	/**
-	 * Opaque data pointer used to keep internal state across callback calls.
-	 *
-	 * It can be accessed directly via the third callback arg 'pp_task_cb':
-	 * struct ... *state = pp_task_cb;
-	 *
-	 * The caller is responsible for managing the memory for this data by
-	 * providing alloc/free callbacks to `run_hooks_opt`.
-	 *
-	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
-	 */
-	void *feed_pipe_cb_data;
-
 	/**
 	 * Some hooks need to create a fresh `feed_pipe_cb_data` internal state,
 	 * so they can keep track of progress without affecting one another.
@@ -128,7 +147,19 @@ struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
 	const char *hook_name;
-	const char *hook_path;
+
+	/**
+	 * A list of hook commands/paths to run for the 'hook_name' event.
+	 *
+	 * The 'string' member of each item holds the path (for traditional hooks)
+	 * or the unique friendly-name for hooks specified in configs.
+	 * The 'util' member of each item points to the corresponding struct hook.
+	 */
+	struct string_list *hook_command_list;
+
+	/* Iterator/cursor for the above list, pointing to the next hook to run. */
+	size_t hook_to_run_index;
+
 	struct run_hooks_opt *options;
 };
 
-- 
2.52.0.732.gb351b5166d.dirty

