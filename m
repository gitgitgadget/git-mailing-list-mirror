Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8B3AA50D
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007601; cv=pass; b=FrFktOVUf82teWIp7X92qeNSNMpZfsP8fyTFzxdNGGh05LIyL0DlsH7rTpKn8VqAjRGhz4skx9lbs/pymjLtA5dmVY4xPsyashkYpcK2yknazr9wpSbcVtp4AAVjzZBgT9Tt6kfF3WcBjsSJs94AH0Pt1klXpRVk3+flL9Mo8LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007601; c=relaxed/simple;
	bh=xaftxUGeAO5a5GEgF/Tvr1PrplUXC9Zs7575oJ4Vzs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY5HiIlj8yfCzJlyZsXdX3+SHM6u83YmtMj0893zqkuntrtzZQ5NuaNL2x/hEZ+KXzrs/Dbbj46j/4QHE2h3vRPY0ROuyV30P2deQCuWYlyEGc8fy36BeCJZILTDrmVsvKdFLK6XrzHT1aXlXL9IiHF9cthdGlF+z3K2I/lRQtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LLgQW0qH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LLgQW0qH"
ARC-Seal: i=1; a=rsa-sha256; t=1774007574; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hNgKDdx4xcFIdC2MPP1Xv80GcUFnv+c7h6jM7KdFVr15d/uH+yPrtz72ERDajRdFu/tpmO1p/nvLagIs2xfMGRmKsxcC1aprRxppzsHAUM328o1kvimfSnq+kWcm2GX0GS9VJUoMTYKNsiptl6Zu3LowzGaqen1xoNfE/na7G6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007574; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/D2vrXIm11HknRpGWiKkq6T92P2wsPPMuaCrIfiwgkk=; 
	b=L28r0xN8YB9DhxFFERdbhwf5b6wqARAWcupLNK2TfV5pqhRXvkjQ2jZejS9u9V4594oAAh/uMurVmU6zCl+JMkUhBx9Mvo7XmUxaJxw2mOcBUF+EU1k/5lDj7ixXpUoF+zc3Yb7eypEltIQiHsAgOF3cPK/UHCyKjIoL0Ns/nJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007574;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/D2vrXIm11HknRpGWiKkq6T92P2wsPPMuaCrIfiwgkk=;
	b=LLgQW0qHiObIgnLlBjjKCXczhroZ9hICx0Rf1fUx8T7DCASFv03cudiFbFAH6unx
	Kl2E1Et0AvrLHm7vM+shsnObHzSxd+z25cFySGMZ5cWkwVgzrkJ1ZuH/zXzVWcgs6Qc
	kqX23L8MgOcAw2y+6DllrgRV7siwEp/5BCPXpco8=
Received: by mx.zohomail.com with SMTPS id 1774007571898918.2304836945846;
	Fri, 20 Mar 2026 04:52:51 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 02/10] hook: fix minor style issues
Date: Fri, 20 Mar 2026 13:52:03 +0200
Message-ID: <20260320115211.177351-3-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix some minor style nits pointed by Patrick, Junio and Eric:
  * Use CALLOC_ARRAY instead of xcalloc.
  * Init struct members during declaration.
  * Simplify if condition boolean logic.
  * Missing curly braces in if/else stmts.
  * Unnecessary header includes.
  * Capitalization and full-stop in error/warn messages.
  * Curly brace on separate line when defining struct.
  * Comment spelling: free'd -> freed.

These contain no logic changes, the code behaves the same as before.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c         |  6 ++----
 builtin/receive-pack.c | 11 +++++++----
 hook.c                 | 25 +++++++++++++------------
 hook.h                 |  3 +--
 refs.c                 |  3 ++-
 t/t1800-hook.sh        |  2 +-
 transport.c            |  3 ++-
 7 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 83020dfb4f..e641614b84 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -5,8 +5,6 @@
 #include "gettext.h"
 #include "hook.h"
 #include "parse-options.h"
-#include "strvec.h"
-#include "abspath.h"
 
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
@@ -51,7 +49,7 @@ static int list(int argc, const char **argv, const char *prefix,
 	 * arguments later they probably should be caught by parse_options.
 	 */
 	if (argc != 1)
-		usage_msg_opt(_("You must specify a hook event name to list."),
+		usage_msg_opt(_("you must specify a hook event name to list"),
 			      builtin_hook_list_usage, list_options);
 
 	hookname = argv[0];
@@ -59,7 +57,7 @@ static int list(int argc, const char **argv, const char *prefix,
 	head = list_hooks(repo, hookname, NULL);
 
 	if (!head->nr) {
-		warning(_("No hooks found for event '%s'"), hookname);
+		warning(_("no hooks found for event '%s'"), hookname);
 		ret = 1; /* no hooks found */
 		goto cleanup;
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..991d6ca7d5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -904,7 +904,8 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
 static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
 {
 	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
-	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
+	struct receive_hook_feed_state *data;
+	CALLOC_ARRAY(data, 1);
 	data->report = init_state->report;
 	data->cmd = init_state->cmd;
 	data->skip_broken = init_state->skip_broken;
@@ -928,7 +929,11 @@ static int run_receive_hook(struct command *commands,
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct command *iter = commands;
-	struct receive_hook_feed_state feed_init_state = { 0 };
+	struct receive_hook_feed_state feed_init_state = {
+		.cmd = commands,
+		.skip_broken = skip_broken,
+		.buf = STRBUF_INIT,
+	};
 	struct async sideband_async;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
@@ -961,8 +966,6 @@ static int run_receive_hook(struct command *commands,
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
 	/* set up stdin callback */
-	feed_init_state.cmd = commands;
-	feed_init_state.skip_broken = skip_broken;
 	opt.feed_pipe_ctx = &feed_init_state;
 	opt.feed_pipe = feed_receive_hook_cb;
 	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
diff --git a/hook.c b/hook.c
index 67cc9a66df..349db729f6 100644
--- a/hook.c
+++ b/hook.c
@@ -57,9 +57,9 @@ static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
 	if (!h)
 		return;
 
-	if (h->kind == HOOK_TRADITIONAL)
+	if (h->kind == HOOK_TRADITIONAL) {
 		free((void *)h->u.traditional.path);
-	else if (h->kind == HOOK_CONFIGURED) {
+	} else if (h->kind == HOOK_CONFIGURED) {
 		free((void *)h->u.configured.friendly_name);
 		free((void *)h->u.configured.command);
 	}
@@ -91,7 +91,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	if (!hook_path)
 		return;
 
-	h = xcalloc(1, sizeof(struct hook));
+	CALLOC_ARRAY(h, 1);
 
 	/*
 	 * If the hook is to run in a specific dir, a relative path can
@@ -154,7 +154,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 				strmap_get(&data->event_hooks, value);
 
 			if (!hooks) {
-				hooks = xcalloc(1, sizeof(*hooks));
+				CALLOC_ARRAY(hooks, 1);
 				string_list_init_dup(hooks);
 				strmap_put(&data->event_hooks, value, hooks);
 			}
@@ -227,7 +227,8 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	/* Construct the cache from parsed configs. */
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		struct string_list *hook_names = e->value;
-		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
+		struct string_list *hooks;
+		CALLOC_ARRAY(hooks, 1);
 
 		string_list_init_dup(hooks);
 
@@ -281,7 +282,7 @@ static struct strmap *get_hook_config_cache(struct repository *r)
 		 * it just once on the first call.
 		 */
 		if (!r->hook_config_cache) {
-			r->hook_config_cache = xcalloc(1, sizeof(*cache));
+			CALLOC_ARRAY(r->hook_config_cache, 1);
 			strmap_init(r->hook_config_cache);
 			build_hook_config_map(r, r->hook_config_cache);
 		}
@@ -289,9 +290,9 @@ static struct strmap *get_hook_config_cache(struct repository *r)
 	} else {
 		/*
 		 * Out-of-repo calls (no gitdir) allocate and return a temporary
-		 * map cache which gets free'd immediately by the caller.
+		 * cache which gets freed immediately by the caller.
 		 */
-		cache = xcalloc(1, sizeof(*cache));
+		CALLOC_ARRAY(cache, 1);
 		strmap_init(cache);
 		build_hook_config_map(r, cache);
 	}
@@ -311,7 +312,8 @@ static void list_hooks_add_configured(struct repository *r,
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
 		const char *friendly_name = configured_hooks->items[i].string;
 		const char *command = configured_hooks->items[i].util;
-		struct hook *hook = xcalloc(1, sizeof(struct hook));
+		struct hook *hook;
+		CALLOC_ARRAY(hook, 1);
 
 		if (options && options->feed_pipe_cb_data_alloc)
 			hook->feed_pipe_cb_data =
@@ -343,7 +345,7 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 	if (!hookname)
 		BUG("null hookname was provided to hook_list()!");
 
-	hook_head = xmalloc(sizeof(struct string_list));
+	CALLOC_ARRAY(hook_head, 1);
 	string_list_init_dup(hook_head);
 
 	/* Add hooks from the config, e.g. hook.myhook.event = pre-commit */
@@ -493,8 +495,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	 * Ensure cb_data copy and free functions are either provided together,
 	 * or neither one is provided.
 	 */
-	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
-	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
+	if (!options->feed_pipe_cb_data_alloc != !options->feed_pipe_cb_data_free)
 		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
 
 	if (options->invoked_hook)
diff --git a/hook.h b/hook.h
index e949f5d488..40823ebde7 100644
--- a/hook.h
+++ b/hook.h
@@ -46,8 +46,7 @@ struct hook {
 typedef void (*cb_data_free_fn)(void *data);
 typedef void *(*cb_data_alloc_fn)(void *init_ctx);
 
-struct run_hooks_opt
-{
+struct run_hooks_opt {
 	/* Environment vars to be set for each hook */
 	struct strvec env;
 
diff --git a/refs.c b/refs.c
index 6fb8f9d10c..33c7961802 100644
--- a/refs.c
+++ b/refs.c
@@ -2591,7 +2591,8 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 
 static void *transaction_feed_cb_data_alloc(void *feed_pipe_ctx UNUSED)
 {
-	struct transaction_feed_cb_data *data = xmalloc(sizeof(*data));
+	struct transaction_feed_cb_data *data;
+	CALLOC_ARRAY(data, 1);
 	strbuf_init(&data->buf, 0);
 	data->index = 0;
 	return data;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index b1583e9ef9..952bf97b86 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -34,7 +34,7 @@ test_expect_success 'git hook usage' '
 
 test_expect_success 'git hook list: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
-	warning: No hooks found for event '\''test-hook'\''
+	warning: no hooks found for event '\''test-hook'\''
 	EOF
 	test_expect_code 1 git hook list test-hook 2>stderr.actual &&
 	test_cmp stderr.expect stderr.actual
diff --git a/transport.c b/transport.c
index 107f4fa5dc..56a4015389 100644
--- a/transport.c
+++ b/transport.c
@@ -1360,7 +1360,8 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 
 static void *pre_push_hook_data_alloc(void *feed_pipe_ctx)
 {
-	struct feed_pre_push_hook_data *data = xmalloc(sizeof(*data));
+	struct feed_pre_push_hook_data *data;
+	CALLOC_ARRAY(data, 1);
 	strbuf_init(&data->buf, 0);
 	data->refs = (struct ref *)feed_pipe_ctx;
 	return data;
-- 
2.52.0.732.gb351b5166d.dirty

