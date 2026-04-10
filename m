Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1533B6BE8
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812059; cv=pass; b=JuhJl8SqyqtQZRl7lWGZiFe83U8ithBo/jnc3hjTXEZe7y/xNqFoC6kC2Om8Ow4yvzBAjCA5vs1Qi6Vmtxjr8A+ywYZoTz0pOy4QI+xw9iZ38p4F6iXabi+w7KykvMGdJYNXIXTfKDrtxEa8lFkv3QRaaNXgn8tmFjIHy4H7O4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812059; c=relaxed/simple;
	bh=YYl0PvB95KGYkeFVdi4+Py3xcXBn0T+hs7z697sUzVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRaWVHsrNkY/EBcKtIIF10bZy1KytRakDAz8+Wdph5y8HARURptFEYaZ+lQmHT9EQNssamuL3dHLBguP3OEb4tDB7iZOtjC/esf/s68QzxJLbgEM++uXjYmnLUW1K6ucE5EUrILX75Ski92xFpMs28TQa/gh/FvDvooNqHts+RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=klC6ONfk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="klC6ONfk"
ARC-Seal: i=1; a=rsa-sha256; t=1775812039; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dWuNRuxW9lHOJPkB4xTca1uXNCyVNIJ/QVJT5pDJFCVq3Fdfom/QhiHsyHQHM6svY4FiLOfNM54Cqbm68RQ3LLTvsuMpJ78upOahInI1gONYZDbN1DZ26kOyOVn83pk+/BnWvLPpndVG6QIxCJtsBMTd7VWlNftXarhYVuzK4fM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775812039; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hsobgXWXIWLIk2vPZxRtp85bwA+WBvrBthUFA8gs6uk=; 
	b=WOMQ8izsP6SH6Thz21Rb+qWCuHWnXHX3jVu1fU+C71OwNgCchXs31rbMimyAAhqp9CSNGF1iL8dkbud4Id4M0KtVfDVAIq5bDNlrvMLg+SacUj0pv0bmEMXpeP3h2f5uMnKycBzvNB2G4NkhSgbDkC0sc3M9XItJuQOMAZwqpPU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775812039;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hsobgXWXIWLIk2vPZxRtp85bwA+WBvrBthUFA8gs6uk=;
	b=klC6ONfkX+w9qtwpWN5HHhcik2Kjv8Q1RkgwWB5rFQUfEHnVZrQvCbM4Mui/G4y+
	JsJirSHl0gy+V8cadGrjGXWPrbSuRhQAuiT5nt1kAwKWl2U7JejqODKsBukBL/wA3dM
	figOjs1gzYQWmzmIbpAml6aaIErRW22/aaJZD8GM=
Received: by mx.zohomail.com with SMTPS id 177581203701218.364137537250485;
	Fri, 10 Apr 2026 02:07:17 -0700 (PDT)
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
Subject: [PATCH v7 11/13] hook: add hook.<event>.enabled switch
Date: Fri, 10 Apr 2026 12:06:06 +0300
Message-ID: <20260410090608.75283-12-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410090608.75283-1-adrian.ratiu@collabora.com>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260410090608.75283-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a hook.<event>.enabled config key that disables all hooks for
a given event, when set to false, acting as a high-level switch
above the existing per-hook hook.<friendly-name>.enabled.

Event-disabled hooks are shown in "git hook list" with an
"event-disabled" tab-separated prefix before the name:

$ git hook list test-hook
event-disabled  hook-1
event-disabled  hook-2

With --show-scope:

$ git hook list --show-scope test-hook
local   event-disabled  hook-1

When a hook is both per-hook disabled and event-disabled, only
"event-disabled" is shown: the event-level switch is the more
relevant piece of information, and the per-hook "disabled" status
will surface once the event is re-enabled.

Using an event name as a friendly-name (e.g. hook.<event>.enabled)
can cause ambiguity, so a fatal error is issued when using a known
event name and a warning is issued for unknown event name, since
a collision cannot be detected with certainty for unknown events.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc | 20 ++++++++
 builtin/hook.c                 | 20 +++++---
 hook.c                         | 47 +++++++++++++++++--
 hook.h                         |  1 +
 repository.c                   |  1 +
 repository.h                   |  4 ++
 t/t1800-hook.sh                | 83 ++++++++++++++++++++++++++++++++++
 7 files changed, 165 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index d4fa29d936..e0db3afa19 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -15,6 +15,12 @@ hook.<friendly-name>.event::
 	events, specify the key more than once. An empty value resets
 	the list of events, clearing any previously defined events for
 	`hook.<friendly-name>`. See linkgit:git-hook[1].
++
+The `<friendly-name>` must not be the same as a known hook event name
+(e.g. do not use `hook.pre-commit.event`). Using a known event name as
+a friendly-name is a fatal error because it creates an ambiguity with
+`hook.<event>.enabled` and `hook.<event>.jobs`. For unknown event names,
+a warning is issued when `<friendly-name>` matches the event value.
 
 hook.<friendly-name>.enabled::
 	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
@@ -33,6 +39,20 @@ hook.<friendly-name>.parallel::
 	found in the hooks directory do not need to, and run in parallel when
 	the effective job count is greater than 1. See linkgit:git-hook[1].
 
+hook.<event>.enabled::
+	Switch to enable or disable all hooks for the `<event>` hook event.
+	When set to `false`, no hooks fire for that event, regardless of any
+	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
+	See linkgit:git-hook[1].
++
+Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
+not a hook friendly-name. Since using a known event name as a
+friendly-name is disallowed (see `hook.<friendly-name>.event` above),
+there is no ambiguity between event-level and per-hook `.enabled`
+settings for known events. For unknown events, if a friendly-name
+matches the event name despite the warning, `.enabled` is treated
+as per-hook only.
+
 hook.<event>.jobs::
 	Specifies how many hooks can be run simultaneously for the `<event>`
 	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
diff --git a/builtin/hook.c b/builtin/hook.c
index 1839412dca..8e47e22e2a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -87,14 +87,22 @@ static int list(int argc, const char **argv, const char *prefix,
 			const char *name = h->u.configured.friendly_name;
 			const char *scope = show_scope ?
 				config_scope_name(h->u.configured.scope) : NULL;
+			/*
+			 * Show the most relevant disable reason. Event-level
+			 * takes precedence: if the whole event is off, that
+			 * is what the user needs to know. The per-hook
+			 * "disabled" surfaces once the event is re-enabled.
+			 */
+			const char *disability =
+				h->u.configured.event_disabled ? "event-disabled\t" :
+				h->u.configured.disabled       ? "disabled\t"       :
+								 "";
 			if (scope)
-				printf("%s\t%s%s%c", scope,
-				       h->u.configured.disabled ? "disabled\t" : "",
-				       name, line_terminator);
+				printf("%s\t%s%s%c", scope, disability, name,
+				       line_terminator);
 			else
-				printf("%s%s%c",
-				       h->u.configured.disabled ? "disabled\t" : "",
-				       name, line_terminator);
+				printf("%s%s%c", disability, name,
+				       line_terminator);
 			break;
 		}
 		default:
diff --git a/hook.c b/hook.c
index 19076f8f2b..bc990d4ed4 100644
--- a/hook.c
+++ b/hook.c
@@ -133,7 +133,9 @@ struct hook_config_cache_entry {
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
- * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
+ * disabled_hooks: set of all names with hook.<name>.enabled = false; after
+ *                 parsing, names that are not friendly-names become event-level
+ *                 disables stored in r->disabled_events. This collects all.
  * parallel_hooks: friendly-name to parallel flag.
  * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
@@ -189,8 +191,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			strmap_for_each_entry(&data->event_hooks, &iter, e)
 				unsorted_string_list_remove(e->value, hook_name, 0);
 		} else {
-			struct string_list *hooks =
-				strmap_get(&data->event_hooks, value);
+			struct string_list *hooks;
+
+			if (is_known_hook(hook_name))
+				die(_("hook friendly-name '%s' collides with "
+				      "a known event name; please choose a "
+				      "different friendly-name"),
+				    hook_name);
+
+			if (!strcmp(hook_name, value))
+				warning(_("hook friendly-name '%s' is the "
+					  "same as its event; this may cause "
+					  "ambiguity with hook.%s.enabled"),
+					hook_name, hook_name);
+
+			hooks = strmap_get(&data->event_hooks, value);
 
 			if (!hooks) {
 				CALLOC_ARRAY(hooks, 1);
@@ -345,6 +360,22 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 	warn_jobs_on_friendly_names(&cb_data);
 
+	/*
+	 * Populate disabled_events: names in disabled_hooks that are not
+	 * friendly-names are event-level switches (hook.<event>.enabled = false).
+	 * Names that are friendly-names are already handled per-hook via the
+	 * hook_config_cache_entry.disabled flag below.
+	 */
+	if (r) {
+		string_list_clear(&r->disabled_events, 0);
+		string_list_init_dup(&r->disabled_events);
+		for (size_t i = 0; i < cb_data.disabled_hooks.nr; i++) {
+			const char *n = cb_data.disabled_hooks.items[i].string;
+			if (!is_friendly_name(&cb_data, n))
+				string_list_append(&r->disabled_events, n);
+		}
+	}
+
 	/* Construct the cache from parsed configs. */
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		struct string_list *hook_names = e->value;
@@ -446,6 +477,8 @@ static void list_hooks_add_configured(struct repository *r,
 {
 	struct strmap *cache = get_hook_config_cache(r);
 	struct string_list *configured_hooks = strmap_get(cache, hookname);
+	bool event_is_disabled = r ? !!unsorted_string_list_lookup(&r->disabled_events,
+								   hookname) : 0;
 
 	/* Iterate through configured hooks and initialize internal states */
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
@@ -472,6 +505,7 @@ static void list_hooks_add_configured(struct repository *r,
 			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
 		hook->u.configured.disabled = entry->disabled;
+		hook->u.configured.event_disabled = event_is_disabled;
 		hook->parallel = entry->parallel;
 
 		string_list_append(list, friendly_name)->util = hook;
@@ -484,6 +518,8 @@ static void list_hooks_add_configured(struct repository *r,
 	if (!r || !r->gitdir) {
 		hook_cache_clear(cache);
 		free(cache);
+		if (r)
+			string_list_clear(&r->disabled_events, 0);
 	}
 }
 
@@ -515,7 +551,7 @@ int hook_exists(struct repository *r, const char *name)
 	for (size_t i = 0; i < hooks->nr; i++) {
 		struct hook *h = hooks->items[i].util;
 		if (h->kind == HOOK_TRADITIONAL ||
-		    !h->u.configured.disabled) {
+		    (!h->u.configured.disabled && !h->u.configured.event_disabled)) {
 			exists = 1;
 			break;
 		}
@@ -538,7 +574,8 @@ static int pick_next_hook(struct child_process *cp,
 		if (hook_cb->hook_to_run_index >= hook_list->nr)
 			return 0;
 		h = hook_list->items[hook_cb->hook_to_run_index++].util;
-	} while (h->kind == HOOK_CONFIGURED && h->u.configured.disabled);
+	} while (h->kind == HOOK_CONFIGURED &&
+		 (h->u.configured.disabled || h->u.configured.event_disabled));
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
diff --git a/hook.h b/hook.h
index 5a93f56618..b4372b636f 100644
--- a/hook.h
+++ b/hook.h
@@ -32,6 +32,7 @@ struct hook {
 			const char *command;
 			enum config_scope scope;
 			bool disabled;
+			bool event_disabled;
 		} configured;
 	} u;
 
diff --git a/repository.c b/repository.c
index 4030db4460..db57b8308b 100644
--- a/repository.c
+++ b/repository.c
@@ -427,6 +427,7 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->hook_config_cache);
 	}
 	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
+	string_list_clear(&repo->disabled_events, 0);
 
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
diff --git a/repository.h b/repository.h
index 6b67ec02e2..4969d8b8eb 100644
--- a/repository.h
+++ b/repository.h
@@ -2,6 +2,7 @@
 #define REPOSITORY_H
 
 #include "strmap.h"
+#include "string-list.h"
 #include "repo-settings.h"
 #include "environment.h"
 
@@ -178,6 +179,9 @@ struct repository {
 	/* Cached map of event-name -> jobs count (as uintptr_t) from hook.<event>.jobs. */
 	struct strmap event_jobs;
 
+	/* Cached list of event names with hook.<event>.enabled = false. */
+	struct string_list disabled_events;
+
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
 	struct promisor_remote_config *promisor_remote_config;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 89fedc48ff..c4ff25f6b0 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1058,4 +1058,87 @@ test_expect_success 'hook.<event>.jobs does not warn for a real event name' '
 	test_grep ! "friendly-name" err
 '
 
+test_expect_success 'hook.<event>.enabled=false skips all hooks for event' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_must_be_empty out
+'
+
+test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled true &&
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep "ran" err
+'
+
+test_expect_success 'hook.<event>.enabled=false does not affect other events' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.other-event.enabled false &&
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep "ran" err
+'
+
+test_expect_success 'hook.<friendly-name>.enabled=false still disables that hook' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo hook-1" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "echo hook-2" &&
+	test_config hook.hook-1.enabled false &&
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep ! "hook-1" err &&
+	test_grep "hook-2" err
+'
+
+test_expect_success 'git hook list shows event-disabled hooks as event-disabled' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook list --allow-unknown-hook-name test-hook >actual &&
+	test_grep "^event-disabled	hook-1$" actual &&
+	test_grep "^event-disabled	hook-2$" actual
+'
+
+test_expect_success 'git hook list shows scope with event-disabled' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook list --allow-unknown-hook-name --show-scope test-hook >actual &&
+	test_grep "^local	event-disabled	hook-1$" actual
+'
+
+test_expect_success 'git hook list still shows hooks when event is disabled' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook list --allow-unknown-hook-name test-hook >actual &&
+	test_grep "event-disabled" actual
+'
+
+test_expect_success 'friendly-name matching known event name is rejected' '
+	test_config hook.pre-commit.event pre-commit &&
+	test_config hook.pre-commit.command "echo oops" &&
+	test_must_fail git hook run pre-commit 2>err &&
+	test_grep "collides with a known event name" err
+'
+
+test_expect_success 'friendly-name matching known event name is rejected even for different event' '
+	test_config hook.pre-commit.event post-commit &&
+	test_config hook.pre-commit.command "echo oops" &&
+	test_must_fail git hook run post-commit 2>err &&
+	test_grep "collides with a known event name" err
+'
+
+test_expect_success 'friendly-name matching unknown event warns' '
+	test_config hook.test-hook.event test-hook &&
+	test_config hook.test-hook.command "echo ran" &&
+	git hook run --allow-unknown-hook-name test-hook >out 2>err &&
+	test_grep "same as its event" err
+'
+
 test_done
-- 
2.52.0

