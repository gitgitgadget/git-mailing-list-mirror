Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650EC318EF0
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468562; cv=pass; b=UoMBs8rqYG2NvVOSBFKGXGYfFR9FpUu/2RjU2FiPFSAnx3c1c1aG9tzpGFjU4rz+k7UMJtTXXxzbY5HP/olNY1zmzwenPx65rptodJlhGGmXwAEDa9b9qLlwcj/8VwXByz8viycSUTGFMyDpKva1aslO7HuzFx+gDNXPhAhO09k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468562; c=relaxed/simple;
	bh=9ZDzamn+ZxWdJSiS5/1pnQBbOGkChu7aY/3fTa4dlis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUHMwfsHspF5m16+9rB3yza90WG41yXNQEF3A7+TFr48A/oBO8JKuMpLQhZCTJJytG7KCBBaAkIxecKHIQQPk26fyizmPE5LW3ruPs33J3uaSPKcw+HGv3eIO3jc4MJicqvXk4MkvU6+y0b+l0LRil85ZCh7i9eL7jSAWrQ9SDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=XvobgizX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="XvobgizX"
ARC-Seal: i=1; a=rsa-sha256; t=1774468545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RR5mbL0JXM692sV7n3zCgF1BV9iAlSTBjAa1ZKe5ebCPQ90I3iNpMGolf38JxWv/vjQNz58g/jM9HscRdYnZEDvBSWcyhRR9TwiTM9W8cftixUefgH4zikhJFvbDuaLeQ8QTKRtCPjNJvXjuQmI8nnP+DCFkO6XIPeEdVQhEPpc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468545; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=amrmW5BOwy9zqp1qv+nkwUn9XX7ZDpUmyEDzEJ7qx6I=; 
	b=UOGX7b/oygGckYD/4qh0rPdCciRYy3zG1EgSbQF7dASs0ff/h9y+RSKih+zjv86u10GrGfzKaTkKRM47EI+uqI72dZ2/2WhSYotSVFThkEWfK0ovYI76LE9NXSaHbnpYnN2ZgqDaPYtmOBodVDHsRDvf6tnPC2jxJn1LaB5qRxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468545;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=amrmW5BOwy9zqp1qv+nkwUn9XX7ZDpUmyEDzEJ7qx6I=;
	b=XvobgizX4OLgw26RuoJGyWFBTz9iacyDrN6BOkszIHwOGsQwoQ2K/iKuTT1gpqtm
	Ze8IwqLf4t804lTyk2npnpojBdGLA/64jqprsUe0dPq4J64QdXJNZ+VsyVL8Gp7ugAo
	CIteIVtEffOkZ4k/gSUOKxtrCbUubCsg/ivXqitY=
Received: by mx.zohomail.com with SMTPS id 1774468543902982.76366071116;
	Wed, 25 Mar 2026 12:55:43 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/12] hook: fix minor style issues
Date: Wed, 25 Mar 2026 21:54:54 +0200
Message-ID: <20260325195503.1139418-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix some minor style nits pointed out by Patrick, Junio and Eric:
  * Use CALLOC_ARRAY instead of xcalloc.
  * Init struct members during declaration.
  * Simplify if condition boolean logic.
  * Missing curly braces in if/else stmts.
  * Unnecessary header includes.
  * Capitalization and full-stop in error/warn messages.
  * Curly brace on separate line when defining struct.
  * Comment spelling: free'd -> freed.
  * Sort the included headers.
  * Blank line fixes to improve readability.

These contain no logic changes, the code behaves the same as before.

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c         |  6 ++--
 builtin/receive-pack.c | 65 ++++++++++++++++++++++--------------------
 hook.c                 | 34 +++++++++++-----------
 hook.h                 |  5 ++--
 refs.c                 |  3 +-
 t/t1800-hook.sh        |  2 +-
 transport.c            |  3 +-
 7 files changed, 61 insertions(+), 57 deletions(-)

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
index a1ffe4570f..cb3656a034 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -3,46 +3,45 @@
 
 #include "builtin.h"
 #include "abspath.h"
-
+#include "commit.h"
+#include "commit-reach.h"
 #include "config.h"
+#include "connect.h"
+#include "connected.h"
 #include "environment.h"
+#include "exec-cmd.h"
+#include "fsck.h"
 #include "gettext.h"
+#include "gpg-interface.h"
 #include "hex.h"
-#include "lockfile.h"
-#include "pack.h"
-#include "refs.h"
-#include "pkt-line.h"
-#include "sideband.h"
-#include "run-command.h"
 #include "hook.h"
-#include "exec-cmd.h"
-#include "commit.h"
+#include "lockfile.h"
 #include "object.h"
-#include "remote.h"
-#include "connect.h"
-#include "string-list.h"
-#include "oid-array.h"
-#include "connected.h"
-#include "strvec.h"
-#include "version.h"
-#include "gpg-interface.h"
-#include "sigchain.h"
-#include "fsck.h"
-#include "tmp-objdir.h"
-#include "oidset.h"
-#include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "oid-array.h"
+#include "oidset.h"
+#include "pack.h"
+#include "packfile.h"
+#include "parse-options.h"
+#include "pkt-line.h"
 #include "protocol.h"
-#include "commit-reach.h"
+#include "refs.h"
+#include "remote.h"
+#include "run-command.h"
 #include "server-info.h"
+#include "setup.h"
+#include "shallow.h"
+#include "sideband.h"
+#include "sigchain.h"
+#include "string-list.h"
+#include "strvec.h"
+#include "tmp-objdir.h"
 #include "trace.h"
 #include "trace2.h"
+#include "version.h"
 #include "worktree.h"
-#include "shallow.h"
-#include "setup.h"
-#include "parse-options.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
@@ -904,11 +903,14 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
 static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
 {
 	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
-	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
+	struct receive_hook_feed_state *data;
+
+	CALLOC_ARRAY(data, 1);
 	data->report = init_state->report;
 	data->cmd = init_state->cmd;
 	data->skip_broken = init_state->skip_broken;
 	strbuf_init(&data->buf, 0);
+
 	return data;
 }
 
@@ -928,7 +930,11 @@ static int run_receive_hook(struct command *commands,
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
@@ -961,9 +967,6 @@ static int run_receive_hook(struct command *commands,
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
 	/* set up stdin callback */
-	feed_init_state.cmd = commands;
-	feed_init_state.skip_broken = skip_broken;
-	strbuf_init(&feed_init_state.buf, 0);
 	opt.feed_pipe_ctx = &feed_init_state;
 	opt.feed_pipe = feed_receive_hook_cb;
 	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
diff --git a/hook.c b/hook.c
index 67cc9a66df..935237fc1d 100644
--- a/hook.c
+++ b/hook.c
@@ -1,16 +1,16 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
+#include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hook.h"
-#include "path.h"
 #include "parse.h"
+#include "path.h"
 #include "run-command.h"
-#include "config.h"
+#include "setup.h"
 #include "strbuf.h"
 #include "strmap.h"
-#include "environment.h"
-#include "setup.h"
 
 const char *find_hook(struct repository *r, const char *name)
 {
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
@@ -227,8 +227,9 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 	/* Construct the cache from parsed configs. */
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		struct string_list *hook_names = e->value;
-		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
+		struct string_list *hooks;
 
+		CALLOC_ARRAY(hooks, 1);
 		string_list_init_dup(hooks);
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
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
@@ -311,7 +312,9 @@ static void list_hooks_add_configured(struct repository *r,
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
 		const char *friendly_name = configured_hooks->items[i].string;
 		const char *command = configured_hooks->items[i].util;
-		struct hook *hook = xcalloc(1, sizeof(struct hook));
+		struct hook *hook;
+
+		CALLOC_ARRAY(hook, 1);
 
 		if (options && options->feed_pipe_cb_data_alloc)
 			hook->feed_pipe_cb_data =
@@ -343,7 +346,7 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 	if (!hookname)
 		BUG("null hookname was provided to hook_list()!");
 
-	hook_head = xmalloc(sizeof(struct string_list));
+	CALLOC_ARRAY(hook_head, 1);
 	string_list_init_dup(hook_head);
 
 	/* Add hooks from the config, e.g. hook.myhook.event = pre-commit */
@@ -493,8 +496,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	 * Ensure cb_data copy and free functions are either provided together,
 	 * or neither one is provided.
 	 */
-	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
-	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
+	if (!options->feed_pipe_cb_data_alloc != !options->feed_pipe_cb_data_free)
 		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
 
 	if (options->invoked_hook)
diff --git a/hook.h b/hook.h
index e949f5d488..1c447cbb6b 100644
--- a/hook.h
+++ b/hook.h
@@ -1,9 +1,9 @@
 #ifndef HOOK_H
 #define HOOK_H
-#include "strvec.h"
 #include "run-command.h"
 #include "string-list.h"
 #include "strmap.h"
+#include "strvec.h"
 
 struct repository;
 
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
index cb1befba8c..e53936d87b 100644
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

