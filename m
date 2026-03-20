Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69F3BBA0A
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014864; cv=pass; b=KD4sUqUwe8u8qjIgAkVRcTpFpKW0hjlhLj4Ins5wClgy3Iy0/ClGzKhnCwDCNFF7u0WG0fsYX189IQ4R9rtkzhMDu7MpHT+nnUJolv4MXBfoI2s1mPvQaj6sqNF8WMSBKWjCagbGKrsm+S17pZX4J2kikgwndNrtaZtZjZy/ML0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014864; c=relaxed/simple;
	bh=EL0hm9wRhhpw3rQxPFzSbb6ng36ukFeYdtcV7D19nBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9dKnsDM7Hh7Mh2GHhITeQ/IMUPlkbZovfeQL84oH2tuRqo+jmoH33cVsB2GPtrVIdlxXM/QgOaUsv8XgTQ9eAOURWI3lQ7lFpS3T+K1BANMv+tFZj1UK/aeSwZqaaM3/Py9YP0UcSz+c4/LRL9IBDXTDIrXdYNzG/N/ZT+BkYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AMDLboCy; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AMDLboCy"
ARC-Seal: i=1; a=rsa-sha256; t=1774014842; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HwJyn+OaPuAja/hyyBWx6lwnAyvuHBof6h4DWE8MY49HcqlijLZGYHeTVwsyvQUytVvnIlyFuL3JDhEKmsfddXPMwsQbfIg1B5ay0V+RfwksXigF3CqSyB90MH+eprxOaouOrBtfYTiEZz4f2i3hrcxci3yWPI1MyLAEksrbTrQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774014842; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mzlRvMy6OvmkIE7H948MdsWeAz7YA62bnCqctZffkTk=; 
	b=OA2GHfzcNRSRbuGDUlPZtBW7jco+ieanTaibGAVllSkIuKKq0jzr1SFb8sgkfp3tE7zVooV6CWGo7c4JpvMvQBVY6nn1TRSBYHe0NSim10IcMjQomPpTe98eeaiBJSKBEhlTKPKXAi8O5nm8E3dC1oNXNWeK+VE7nlO6kMQ/GuU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774014842;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mzlRvMy6OvmkIE7H948MdsWeAz7YA62bnCqctZffkTk=;
	b=AMDLboCytwTmFNK5sZ3S1Q3KUviAX/xVgo96/GgOCGlMng6GWJOXSUIks6hEA8z3
	E3TPVQPYwf7wX6UNvk9681Dq4aWy1PM9N+OCFS4AFr7g6+4bNYat6wl4BwO3zePGIc2
	vIJdRrToyMafXgasOZu8l19aLbhBolEVLGzjPI6Q=
Received: by mx.zohomail.com with SMTPS id 177401484127654.43912100388104;
	Fri, 20 Mar 2026 06:54:01 -0700 (PDT)
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
Subject: [PATCH v4 9/9] hook: add hook.<event>.enabled switch
Date: Fri, 20 Mar 2026 15:53:11 +0200
Message-ID: <20260320135311.331463-10-adrian.ratiu@collabora.com>
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

Reuses is_friendly_name() from the previous commit to distinguish
event names from friendly-names when processing .enabled settings.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc | 12 +++++++
 builtin/hook.c                 | 20 +++++++----
 hook.c                         | 30 ++++++++++++++--
 hook.h                         |  1 +
 repository.c                   |  1 +
 repository.h                   |  4 +++
 t/t1800-hook.sh                | 62 ++++++++++++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index d4fa29d936..0a9f04b154 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -33,6 +33,18 @@ hook.<friendly-name>.parallel::
 	found in the hooks directory do not need to, and run in parallel when
 	the effective job count is greater than 1. See linkgit:git-hook[1].
 
+hook.<event>.enabled::
+	Switch to enable or disable all hooks for the `<event>` hook event.
+	When set to `false`, no hooks fire for that event, regardless of any
+	per-hook `hook.<friendly-name>.enabled` settings. Defaults to `true`.
+	See linkgit:git-hook[1].
++
+Note on naming: `<event>` must be the event name (e.g. `pre-commit`),
+not a hook friendly-name. A name that also carries `.command`, `.event`,
+or `.parallel` is treated as a friendly-name and its `.enabled` value
+applies only to that individual hook. See `hook.<friendly-name>.enabled`
+above.
+
 hook.<event>.jobs::
 	Specifies how many hooks can be run simultaneously for the `<event>`
 	hook event (e.g. `hook.post-receive.jobs = 4`). Overrides `hook.jobs`
diff --git a/builtin/hook.c b/builtin/hook.c
index 4baf60bf36..0def50bcac 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -77,14 +77,22 @@ static int list(int argc, const char **argv, const char *prefix,
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
index 3d73447086..a3abe89777 100644
--- a/hook.c
+++ b/hook.c
@@ -127,7 +127,9 @@ struct hook_config_cache_entry {
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
- * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
+ * disabled_hooks: set of all names with hook.<name>.enabled = false; after
+ *                 parsing, names that are not friendly-names become event-level
+ *                 disables stored in cache->event_disabled. This collects all.
  * parallel_hooks: friendly-name to parallel flag.
  * event_jobs: event-name to per-event jobs count (stored as uintptr_t, NULL == unset).
  * jobs: value of the global hook.jobs key. Defaults to 0 if unset (stored in r->hook_jobs).
@@ -332,6 +334,22 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 	warn_jobs_on_friendly_names(&cb_data);
 
+	/*
+	 * Populate event_disabled: names in disabled_hooks that are not
+	 * friendly-names are event-level switches (hook.<event>.enabled = false).
+	 * Names that are friendly-names are already handled per-hook via the
+	 * hook_config_cache_entry.disabled flag below.
+	 */
+	if (r) {
+		string_list_clear(&r->event_disabled, 0);
+		string_list_init_dup(&r->event_disabled);
+		for (size_t i = 0; i < cb_data.disabled_hooks.nr; i++) {
+			const char *n = cb_data.disabled_hooks.items[i].string;
+			if (!is_friendly_name(&cb_data, n))
+				string_list_append(&r->event_disabled, n);
+		}
+	}
+
 	/* Construct the cache from parsed configs. */
 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
 		struct string_list *hook_names = e->value;
@@ -433,6 +451,8 @@ static void list_hooks_add_configured(struct repository *r,
 {
 	struct strmap *cache = get_hook_config_cache(r);
 	struct string_list *configured_hooks = strmap_get(cache, hookname);
+	int event_is_disabled = r ? !!unsorted_string_list_lookup(&r->event_disabled,
+								   hookname) : 0;
 
 	/* Iterate through configured hooks and initialize internal states */
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
@@ -458,6 +478,7 @@ static void list_hooks_add_configured(struct repository *r,
 			entry->command ? xstrdup(entry->command) : NULL;
 		hook->u.configured.scope = entry->scope;
 		hook->u.configured.disabled = entry->disabled;
+		hook->u.configured.event_disabled = event_is_disabled;
 		hook->parallel = entry->parallel;
 
 		string_list_append(list, friendly_name)->util = hook;
@@ -470,6 +491,8 @@ static void list_hooks_add_configured(struct repository *r,
 	if (!r || !r->gitdir) {
 		hook_cache_clear(cache);
 		free(cache);
+		if (r)
+			string_list_clear(&r->event_disabled, 0);
 	}
 }
 
@@ -501,7 +524,7 @@ int hook_exists(struct repository *r, const char *name)
 	for (size_t i = 0; i < hooks->nr; i++) {
 		struct hook *h = hooks->items[i].util;
 		if (h->kind == HOOK_TRADITIONAL ||
-		    !h->u.configured.disabled) {
+		    (!h->u.configured.disabled && !h->u.configured.event_disabled)) {
 			exists = 1;
 			break;
 		}
@@ -524,7 +547,8 @@ static int pick_next_hook(struct child_process *cp,
 		if (hook_cb->hook_to_run_index >= hook_list->nr)
 			return 0;
 		h = hook_list->items[hook_cb->hook_to_run_index++].util;
-	} while (h->kind == HOOK_CONFIGURED && h->u.configured.disabled);
+	} while (h->kind == HOOK_CONFIGURED &&
+		 (h->u.configured.disabled || h->u.configured.event_disabled));
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
diff --git a/hook.h b/hook.h
index fefcd004c0..6bff3d15e4 100644
--- a/hook.h
+++ b/hook.h
@@ -32,6 +32,7 @@ struct hook {
 			const char *command;
 			enum config_scope scope;
 			unsigned int disabled:1;
+			unsigned int event_disabled:1;
 		} configured;
 	} u;
 
diff --git a/repository.c b/repository.c
index ff3c357dfc..c4468e29c1 100644
--- a/repository.c
+++ b/repository.c
@@ -426,6 +426,7 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->hook_config_cache);
 	}
 	strmap_clear(&repo->event_jobs, 0); /* values are uintptr_t, not heap ptrs */
+	string_list_clear(&repo->event_disabled, 0);
 
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
diff --git a/repository.h b/repository.h
index 6b67ec02e2..745af10842 100644
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
+	struct string_list event_disabled;
+
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
 	struct promisor_remote_config *promisor_remote_config;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index e8005199c7..44355b8bd5 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1026,4 +1026,66 @@ test_expect_success 'hook.<event>.jobs does not warn for a real event name' '
 	test_grep ! "friendly-name" err
 '
 
+test_expect_success 'hook.<event>.enabled=false skips all hooks for event' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook run test-hook >out 2>err &&
+	test_must_be_empty out
+'
+
+test_expect_success 'hook.<event>.enabled=true does not suppress hooks' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled true &&
+	git hook run test-hook >out 2>err &&
+	test_grep "ran" err
+'
+
+test_expect_success 'hook.<event>.enabled=false does not affect other events' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.other-event.enabled false &&
+	git hook run test-hook >out 2>err &&
+	test_grep "ran" err
+'
+
+test_expect_success 'hook.<friendly-name>.enabled=false still disables that hook' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo hook-1" &&
+	test_config hook.hook-2.event test-hook &&
+	test_config hook.hook-2.command "echo hook-2" &&
+	test_config hook.hook-1.enabled false &&
+	git hook run test-hook >out 2>err &&
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
+	git hook list test-hook >actual &&
+	test_grep "^event-disabled	hook-1$" actual &&
+	test_grep "^event-disabled	hook-2$" actual
+'
+
+test_expect_success 'git hook list shows scope with event-disabled' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook list --show-scope test-hook >actual &&
+	test_grep "^local	event-disabled	hook-1$" actual
+'
+
+test_expect_success 'git hook list still shows hooks when event is disabled' '
+	test_config hook.hook-1.event test-hook &&
+	test_config hook.hook-1.command "echo ran" &&
+	test_config hook.test-hook.enabled false &&
+	git hook list test-hook >actual &&
+	test_grep "event-disabled" actual
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

