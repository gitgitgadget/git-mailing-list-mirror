Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D562238C1F
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390788; cv=pass; b=sImlbQ+FhdgrFe6V5G//tCvSKrAOybqvZxO6BcCTL2bizgc1+AawSTUEPFCOSZeIY+Yr/WTaglEK/wopSqJY8AmTe/G27jw6QLKibvY6o4LAvVikAePix7CL5o2ys1exRR2TGJn3YtYXFtTEPQqmUuU1spzOVHUu4mnaQDTnPkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390788; c=relaxed/simple;
	bh=QyEdmj6IunYS5FtvJt54RCFFfncWNB+nxVVLfTXTMrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7RYrXztLC2GtsXQxWaZJdiA/4BbbPAGX4wWMhOhETLObzsJNTdPhdQtZUsZUxMHE4vWxvfC8xLBuou1VJST051u+KPe7AmpmJqEDlXzmSbyPiYOwU3AEluf8cV7rIYoV+GRBTlPCqEuHABqI5B+I5KKd+lqF/sSu3ldTrf13+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iQr1F6LL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iQr1F6LL"
ARC-Seal: i=1; a=rsa-sha256; t=1772390769; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Zx/r3OxkBGnK2fnuhqAcQoF587RHsPXrXisfu5b1+PiY+v33+5anI5DCEACC0A7qXUv5lS1OToh4tUSC91M4ZEERDYS0W/yWjvoeNBwNPqPXydPrM7bX7XCqwICzqwFGdqKCc4d2D9bbVeJuLCe70gwH6GG10EQ0j2uBXL2mMi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390769; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ztBjUOUYpHw6N8OIlsCFZYrpS9+nqZ3MUU1K3L0iCyk=; 
	b=OmmVnsw4JR7K0TX2zUgyVo8+T7G1oDGCLxEfT/FA5clJRRjBzhWC2YGUW0prQQD6ODXCEu8vvK+KxRGoWmDAOACL5vP7bp/5hfZS3ThIZ7UKP5+EIpbIaWts0pO9w/TZqXiU05hpMc/CQW1JairNAADh15DkqI6S/sMsYFG1Zvk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390769;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ztBjUOUYpHw6N8OIlsCFZYrpS9+nqZ3MUU1K3L0iCyk=;
	b=iQr1F6LL+rzRThG4M01KLbcxMAmpakI1MuhyKxM9p9FuW01+apE+NVZQDtULsEZY
	xVrNUGugXlS8wDlAGuQWNlktzXfmhy68Gmo9g5RjCtsD/MqOHQrcTLmEMxYv7KpKsTb
	6ha8Qfv1ta/jcL0yq4ntOdN8ARhDv261RIQe4bF8=
Received: by mx.zohomail.com with SMTPS id 1772390768378123.1699723308111;
	Sun, 1 Mar 2026 10:46:08 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 05/12] hook: include hooks from the config
Date: Sun,  1 Mar 2026 20:44:53 +0200
Message-ID: <20260301184500.1488433-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Teach the hook.[hc] library to parse configs to populate the list of
hooks to run for a given event.

Multiple commands can be specified for a given hook by providing
"hook.<friendly-name>.command = <path-to-hook>" and
"hook.<friendly-name>.event = <hook-event>" lines.

Hooks will be started in config order of the "hook.<friendly-name>.event"
lines and will be run sequentially (.jobs == 1) like before.
Running the hooks in parallel will be enabled in a future patch.

The "traditional" hook from the hookdir is run last, if present.

A strmap cache is added to struct repository to avoid re-reading
the configs on each rook run. This is useful for hooks like the
ref-transaction which gets executed multiple times per process.

Examples:

  $ git config --get-regexp "^hook\."
  hook.bar.command=~/bar.sh
  hook.bar.event=pre-commit

  # Will run ~/bar.sh, then .git/hooks/pre-commit
  $ git hook run pre-commit

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  15 +++
 Documentation/git-hook.adoc    | 128 ++++++++++++++++++++-
 builtin/hook.c                 |   3 +
 hook.c                         | 196 ++++++++++++++++++++++++++++++++-
 hook.h                         |  14 ++-
 repository.c                   |   6 +
 repository.h                   |   6 +
 t/t1800-hook.sh                | 174 ++++++++++++++++++++++++++++-
 8 files changed, 535 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/config/hook.adoc

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
new file mode 100644
index 0000000000..7ac1b079cc
--- /dev/null
+++ b/Documentation/config/hook.adoc
@@ -0,0 +1,15 @@
+hook.<friendly-name>.command::
+	The command to execute for `hook.<friendly-name>`. `<friendly-name>` is a unique
+	"friendly" name that identifies this hook. (The hook events that
+	trigger the command are configured with `hook.<friendly-name>.event`.) The
+	value can be an executable path or a shell oneliner. If more than
+	one value is specified for the same `<friendly-name>`, only the last value
+	parsed is used. See linkgit:git-hook[1].
+
+hook.<friendly-name>.event::
+	The hook events that trigger `hook.<friendly-name>`. The value is the name
+	of a hook event, like "pre-commit" or "update". (See
+	linkgit:githooks[5] for a complete list of hook events.) On the
+	specified event, the associated `hook.<friendly-name>.command` is executed.
+	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
+	events, specify the key more than once. See linkgit:git-hook[1].
diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index eb0ffcb8a9..0eaf864c43 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -17,12 +17,96 @@ DESCRIPTION
 A command interface for running git hooks (see linkgit:githooks[5]),
 for use by other scripted git commands.
 
+This command parses the default configuration files for sets of configs like
+so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+
+In this example, `[hook "linter"]` represents one script - `~/bin/linter
+--cpp20` - which can be shared by many repos, and even by many hook events, if
+appropriate.
+
+To add an unrelated hook which runs on a different event, for example a
+spell-checker for your commit messages, you would write a configuration like so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+  [hook "spellcheck"]
+    event = commit-msg
+    command = ~/bin/spellchecker
+
+With this config, when you run 'git commit', first `~/bin/linter --cpp20` will
+have a chance to check your files to be committed (during the `pre-commit` hook
+event`), and then `~/bin/spellchecker` will have a chance to check your commit
+message (during the `commit-msg` hook event).
+
+Commands are run in the order Git encounters their associated
+`hook.<friendly-name>.event` configs during the configuration parse (see
+linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
+added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
+to determine which command to run.
+
+So if you wanted your linter to run when you commit as well as when you push,
+you would configure it like so:
+
+  [hook "linter"]
+    event = pre-commit
+    event = pre-push
+    command = ~/bin/linter --cpp20
+
+With this config, `~/bin/linter --cpp20` would be run by Git before a commit is
+generated (during `pre-commit`) as well as before a push is performed (during
+`pre-push`).
+
+And if you wanted to run your linter as well as a secret-leak detector during
+only the "pre-commit" hook event, you would configure it instead like so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+  [hook "no-leaks"]
+    event = pre-commit
+    command = ~/bin/leak-detector
+
+With this config, before a commit is generated (during `pre-commit`), Git would
+first start `~/bin/linter --cpp20` and second start `~/bin/leak-detector`. It
+would evaluate the output of each when deciding whether to proceed with the
+commit.
+
+For a full list of hook events which you can set your `hook.<friendly-name>.event` to,
+and how hooks are invoked during those events, see linkgit:githooks[5].
+
+Git will ignore any `hook.<friendly-name>.event` that specifies an event it doesn't
+recognize. This is intended so that tools which wrap Git can use the hook
+infrastructure to run their own hooks; see "WRAPPERS" for more guidance.
+
+In general, when instructions suggest adding a script to
+`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
+
+----
+git config set hook.<some-name>.command <path-to-script>
+git config set --append hook.<some-name>.event <hook-event>
+----
+
+This way you can share the script between multiple repos. That is, `cp
+~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
+
+----
+git config set hook.my-script.command ~/my-script.sh
+git config set --append hook.my-script.event pre-commit
+----
+
 SUBCOMMANDS
 -----------
 
 run::
-	Run the `<hook-name>` hook. See linkgit:githooks[5] for
-	supported hook names.
+	Runs hooks configured for `<hook-name>`, in the order they are
+	discovered during the config parse. The default `<hook-name>` from
+	the hookdir is run last. See linkgit:githooks[5] for supported
+	hook names.
 +
 
 Any positional arguments to the hook should be passed after a
@@ -46,6 +130,46 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+WRAPPERS
+--------
+
+`git hook run` has been designed to make it easy for tools which wrap Git to
+configure and execute hooks using the Git hook infrastructure. It is possible to
+provide arguments and stdin via the command line, as well as specifying parallel
+or series execution if the user has provided multiple hooks.
+
+Assuming your wrapper wants to support a hook named "mywrapper-start-tests", you
+can have your users specify their hooks like so:
+
+  [hook "setup-test-dashboard"]
+    event = mywrapper-start-tests
+    command = ~/mywrapper/setup-dashboard.py --tap
+
+Then, in your 'mywrapper' tool, you can invoke any users' configured hooks by
+running:
+
+----
+git hook run mywrapper-start-tests \
+  # providing something to stdin
+  --stdin some-tempfile-123 \
+  # execute hooks in serial
+  # plus some arguments of your own...
+  -- \
+  --testname bar \
+  baz
+----
+
+Take care to name your wrapper's hook events in a way which is unlikely to
+overlap with Git's native hooks (see linkgit:githooks[5]) - a hook event named
+`mywrappertool-validate-commit` is much less likely to be added to native Git
+than a hook event named `validate-commit`. If Git begins to use a hook event
+named the same thing as your wrapper hook, it may invoke your users' hooks in
+unintended and unsupported ways.
+
+CONFIGURATION
+-------------
+include::config/hook.adoc[]
+
 SEE ALSO
 --------
 linkgit:githooks[5]
diff --git a/builtin/hook.c b/builtin/hook.c
index 855116ba8c..4e49afb4a1 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -67,6 +67,9 @@ static int list(int argc, const char **argv, const char *prefix,
 		case HOOK_TRADITIONAL:
 			printf("%s\n", _("hook from hookdir"));
 			break;
+		case HOOK_CONFIGURED:
+			printf("%s\n", h->u.configured.friendly_name);
+			break;
 		default:
 			BUG("unknown hook kind");
 		}
diff --git a/hook.c b/hook.c
index 20c655918d..b67ec4ff22 100644
--- a/hook.c
+++ b/hook.c
@@ -4,9 +4,11 @@
 #include "gettext.h"
 #include "hook.h"
 #include "path.h"
+#include "parse.h"
 #include "run-command.h"
 #include "config.h"
 #include "strbuf.h"
+#include "strmap.h"
 #include "environment.h"
 #include "setup.h"
 
@@ -54,8 +56,12 @@ void hook_free(void *p, const char *str UNUSED)
 	if (!h)
 		return;
 
-	if (h->kind == HOOK_TRADITIONAL)
+	if (h->kind == HOOK_TRADITIONAL) {
 		free((void *)h->u.traditional.path);
+	} else if (h->kind == HOOK_CONFIGURED) {
+		free((void *)h->u.configured.friendly_name);
+		free((void *)h->u.configured.command);
+	}
 
 	if (h->data_free)
 		h->data_free(h->feed_pipe_cb_data);
@@ -95,6 +101,179 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
 }
 
+/*
+ * Callback struct to collect all hook.* keys in a single config pass.
+ * commands: friendly-name to command map.
+ * event_hooks: event-name to list of friendly-names map.
+ */
+struct hook_all_config_cb {
+	struct strmap commands;
+	struct strmap event_hooks;
+};
+
+/* repo_config() callback that collects all hook.* configuration in one pass. */
+static int hook_config_lookup_all(const char *key, const char *value,
+				  const struct config_context *ctx UNUSED,
+				  void *cb_data)
+{
+	struct hook_all_config_cb *data = cb_data;
+	const char *name, *subkey;
+	char *hook_name;
+	size_t name_len = 0;
+
+	if (parse_config_key(key, "hook", &name, &name_len, &subkey))
+		return 0;
+
+	if (!value)
+		return config_error_nonbool(key);
+
+	/* Extract name, ensuring it is null-terminated. */
+	hook_name = xmemdupz(name, name_len);
+
+	if (!strcmp(subkey, "event")) {
+		struct string_list *hooks =
+			strmap_get(&data->event_hooks, value);
+
+		if (!hooks) {
+			hooks = xcalloc(1, sizeof(*hooks));
+			string_list_init_dup(hooks);
+			strmap_put(&data->event_hooks, value, hooks);
+		}
+
+		/* Re-insert if necessary to preserve last-seen order. */
+		unsorted_string_list_remove(hooks, hook_name, 0);
+		string_list_append(hooks, hook_name);
+	} else if (!strcmp(subkey, "command")) {
+		/* Store command overwriting the old value */
+		char *old = strmap_put(&data->commands, hook_name,
+				       xstrdup(value));
+		free(old);
+	}
+
+	free(hook_name);
+	return 0;
+}
+
+/*
+ * The hook config cache maps each hook event name to a string_list where
+ * every item's string is the hook's friendly-name and its util pointer is
+ * the corresponding command string. Both strings are owned by the map.
+ *
+ * Disabled hooks and hooks missing a command are already filtered out at
+ * parse time, so callers can iterate the list directly.
+ */
+void hook_cache_clear(struct strmap *cache)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	strmap_for_each_entry(cache, &iter, e) {
+		struct string_list *hooks = e->value;
+		string_list_clear(hooks, 1); /* free util (command) pointers */
+		free(hooks);
+	}
+	strmap_clear(cache, 0);
+}
+
+/* Populate `cache` with the complete hook configuration */
+static void build_hook_config_map(struct repository *r, struct strmap *cache)
+{
+	struct hook_all_config_cb cb_data;
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+
+	strmap_init(&cb_data.commands);
+	strmap_init(&cb_data.event_hooks);
+
+	/* Parse all configs in one run. */
+	repo_config(r, hook_config_lookup_all, &cb_data);
+
+	/* Construct the cache from parsed configs. */
+	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
+		struct string_list *hook_names = e->value;
+		struct string_list *hooks;
+		CALLOC_ARRAY(hooks, 1);
+
+		string_list_init_dup(hooks);
+
+		for (size_t i = 0; i < hook_names->nr; i++) {
+			const char *hname = hook_names->items[i].string;
+			char *command;
+
+			command = strmap_get(&cb_data.commands, hname);
+			if (!command)
+				die(_("'hook.%s.command' must be configured or "
+				      "'hook.%s.event' must be removed;"
+				      " aborting."), hname, hname);
+
+			/* util stores the command; owned by the cache. */
+			string_list_append(hooks, hname)->util =
+				xstrdup(command);
+		}
+
+		strmap_put(cache, e->key, hooks);
+	}
+
+	strmap_clear(&cb_data.commands, 1);
+	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
+		string_list_clear(e->value, 0);
+		free(e->value);
+	}
+	strmap_clear(&cb_data.event_hooks, 0);
+}
+
+/* Return the hook config map for `r`, populating it first if needed. */
+static struct strmap *get_hook_config_cache(struct repository *r)
+{
+	struct strmap *cache = NULL;
+
+	if (r) {
+		/*
+		 * For in-repo calls, the map is stored in r->hook_config_cache,
+		 * so repeated invocations don't parse the configs, so allocate
+		 * it just once on the first call.
+		 */
+		if (!r->hook_config_cache) {
+			CALLOC_ARRAY(r->hook_config_cache, 1);
+			strmap_init(r->hook_config_cache);
+			build_hook_config_map(r, r->hook_config_cache);
+		}
+		cache = r->hook_config_cache;
+	}
+
+	return cache;
+}
+
+static void list_hooks_add_configured(struct repository *r,
+				      const char *hookname,
+				      struct string_list *list,
+				      struct run_hooks_opt *options)
+{
+	struct strmap *cache = get_hook_config_cache(r);
+	struct string_list *configured_hooks = strmap_get(cache, hookname);
+
+	/* Iterate through configured hooks and initialize internal states */
+	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
+		const char *friendly_name = configured_hooks->items[i].string;
+		const char *command = configured_hooks->items[i].util;
+		struct hook *hook;
+		CALLOC_ARRAY(hook, 1);
+
+		if (options && options->feed_pipe_cb_data_alloc)
+			hook->feed_pipe_cb_data =
+				options->feed_pipe_cb_data_alloc(
+					options->feed_pipe_ctx);
+		if (options)
+			hook->data_free = options->feed_pipe_cb_data_free;
+
+		hook->kind = HOOK_CONFIGURED;
+		hook->u.configured.friendly_name = xstrdup(friendly_name);
+		hook->u.configured.command = xstrdup(command);
+
+		string_list_append(list, friendly_name)->util = hook;
+	}
+}
+
 struct string_list *list_hooks(struct repository *r, const char *hookname,
 			       struct run_hooks_opt *options)
 {
@@ -106,6 +285,9 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 	CALLOC_ARRAY(hook_head, 1);
 	string_list_init_dup(hook_head);
 
+	/* Add hooks from the config, e.g. hook.myhook.event = pre-commit */
+	list_hooks_add_configured(r, hookname, hook_head, options);
+
 	/* Add the default "traditional" hooks from hookdir. */
 	list_hooks_add_default(r, hookname, hook_head, options);
 
@@ -158,10 +340,18 @@ static int pick_next_hook(struct child_process *cp,
 	cp->dir = hook_cb->options->dir;
 
 	/* Add hook exec paths or commands */
-	if (h->kind == HOOK_TRADITIONAL)
+	switch (h->kind) {
+	case HOOK_TRADITIONAL:
 		strvec_push(&cp->args, h->u.traditional.path);
-	else
+		break;
+	case HOOK_CONFIGURED:
+		/* to enable oneliners, let config-specified hooks run in shell. */
+		cp->use_shell = true;
+		strvec_push(&cp->args, h->u.configured.command);
+		break;
+	default:
 		BUG("unknown hook kind");
+	}
 
 	if (!cp->args.nr)
 		BUG("hook must have at least one command or exec path");
diff --git a/hook.h b/hook.h
index 36d40c98df..fa0fdfd691 100644
--- a/hook.h
+++ b/hook.h
@@ -3,6 +3,7 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "strmap.h"
 
 struct repository;
 
@@ -13,17 +14,22 @@ typedef void *(*hook_data_alloc_fn)(void *init_ctx);
  * Represents a hook command to be run.
  * Hooks can be:
  * 1. "traditional" (found in the hooks directory)
- * 2. "configured" (defined in Git's configuration, not yet implemented).
+ * 2. "configured" (defined in Git's configuration via hook.<friendly-name>.event).
  * The 'kind' field determines which part of the union 'u' is valid.
  */
 struct hook {
 	enum {
 		HOOK_TRADITIONAL,
+		HOOK_CONFIGURED,
 	} kind;
 	union {
 		struct {
 			const char *path;
 		} traditional;
+		struct {
+			const char *friendly_name;
+			const char *command;
+		} configured;
 	} u;
 
 	/**
@@ -197,6 +203,12 @@ void hook_free(void *p, const char *str);
 struct string_list *list_hooks(struct repository *r, const char *hookname,
 			       struct run_hooks_opt *options);
 
+/**
+ * Frees the hook configuration cache stored in `struct repository`.
+ * Called by repo_clear().
+ */
+void hook_cache_clear(struct strmap *cache);
+
 /**
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
diff --git a/repository.c b/repository.c
index 44e77cd05a..c86c6457ba 100644
--- a/repository.c
+++ b/repository.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
+#include "hook.h"
 #include "odb.h"
 #include "config.h"
 #include "object.h"
@@ -399,6 +400,11 @@ void repo_clear(struct repository *repo)
 		FREE_AND_NULL(repo->index);
 	}
 
+	if (repo->hook_config_cache) {
+		hook_cache_clear(repo->hook_config_cache);
+		FREE_AND_NULL(repo->hook_config_cache);
+	}
+
 	if (repo->promisor_remote_config) {
 		promisor_remote_clear(repo->promisor_remote_config);
 		FREE_AND_NULL(repo->promisor_remote_config);
diff --git a/repository.h b/repository.h
index 72a5e9d410..8f057a241d 100644
--- a/repository.h
+++ b/repository.h
@@ -162,6 +162,12 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
+	/*
+	 * Lazily-populated cache mapping hook event names to configured hooks.
+	 * NULL until first hook use.
+	 */
+	struct strmap *hook_config_cache;
+
 	/* Configurations related to promisor remotes. */
 	char *repository_format_partial_clone;
 	struct promisor_remote_config *promisor_remote_config;
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index d1380a4f0e..3a95cfe16d 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1,10 +1,26 @@
 #!/bin/sh
 
-test_description='git-hook command'
+test_description='git-hook command and config-managed multihooks'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+setup_hooks () {
+	test_config hook.ghi.command "/path/ghi"
+	test_config hook.ghi.event pre-commit --add
+	test_config hook.ghi.event test-hook --add
+	test_config_global hook.def.command "/path/def"
+	test_config_global hook.def.event pre-commit --add
+}
+
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
@@ -35,6 +51,15 @@ test_expect_success 'git hook list: traditional hook from hookdir' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list: configured hook' '
+	test_config hook.myhook.command "echo Hello" &&
+	test_config hook.myhook.event test-hook --add &&
+
+	echo "myhook" >expect &&
+	git hook list test-hook >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	error: cannot find a hook named test-hook
@@ -172,6 +197,152 @@ test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
 	test_hook_tty commit -m"B.new"
 '
 
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-\EOF &&
+	def
+	ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate event declarations' '
+	setup_hooks &&
+
+	# 'def' is usually configured globally; move it to the end by
+	# configuring it locally.
+	test_config hook.def.event "pre-commit" --add &&
+
+	cat >expected <<-\EOF &&
+	ghi
+	def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook can be configured for multiple events' '
+	setup_hooks &&
+
+	# 'ghi' should be included in both 'pre-commit' and 'test-hook'
+	git hook list pre-commit >actual &&
+	grep "ghi" actual &&
+	git hook list test-hook >actual &&
+	grep "ghi" actual
+'
+
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-\EOF &&
+	hook from hookdir
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions execute oneliners' '
+	test_config hook.oneliner.event "pre-commit" &&
+	test_config hook.oneliner.command "echo \"Hello World\"" &&
+
+	echo "Hello World" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions resolve paths' '
+	write_script sample-hook.sh <<-\EOF &&
+	echo \"Sample Hook\"
+	EOF
+
+	test_when_finished "rm sample-hook.sh" &&
+
+	test_config hook.sample-hook.event pre-commit &&
+	test_config hook.sample-hook.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	echo \"Sample Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hookdir hook included in git hook run' '
+	setup_hookdir &&
+
+	echo \"Legacy Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'configured hooks run before hookdir hook' '
+	setup_hookdir &&
+	test_config hook.first.event "pre-commit" &&
+	test_config hook.first.command "echo first" &&
+	test_config hook.second.event "pre-commit" &&
+	test_config hook.second.command "echo second" &&
+
+	cat >expected <<-\EOF &&
+	first
+	second
+	hook from hookdir
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual &&
+
+	cat >expected <<-\EOF &&
+	first
+	second
+	"Legacy Hook"
+	EOF
+
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'stdin to multiple hooks' '
+	test_config hook.stdin-a.event "test-hook" &&
+	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" &&
+	test_config hook.stdin-b.event "test-hook" &&
+	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" &&
+
+	cat >input <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-\EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=input test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rejects hooks with no commands configured' '
+	test_config hook.broken.event "test-hook" &&
+	test_must_fail git hook list test-hook 2>actual &&
+	test_grep "hook.broken.command" actual &&
+	test_must_fail git hook run test-hook 2>actual &&
+	test_grep "hook.broken.command" actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
@@ -189,6 +360,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 '
 
 test_expect_success 'stdin to hooks' '
+	mkdir -p .git/hooks &&
 	write_script .git/hooks/test-hook <<-\EOF &&
 	echo BEGIN stdin
 	cat
-- 
2.52.0.732.gb351b5166d.dirty

