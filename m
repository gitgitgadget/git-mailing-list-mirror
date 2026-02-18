Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D833507C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453475; cv=pass; b=A0spGYAxLKGWo3qc09OQyXAnuz1R8bTnuMZNpH5woKjBVuwl8b3lFd2sNalOoUkIh7zV8F6g+u0uU9uFjtEKy4oSHlyTb5vaocIvnGNlj17qFJ8qTAycU9rTuYNyJaavoOAlQiiVe6JbTPIgySE/AFNKLHNSumQtUX3PIqNR/6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453475; c=relaxed/simple;
	bh=oGfx0p7xHQwYpR4V3BImEIkBiE8tIzFQTFic5c0oxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp58252lFsuBKj66Rea+ik+6482oQ9nN8zvopQw+B2Q+wejRcyoaxPz1m19kGdUtSQGoS8ctjsZlrMQuMhQzW7Jx7O2ovGygfrOuGFdLgXdVfzNOTEPV93Ac1BZbF7Jz2J6Xeh3YFcUBB26HW6wn0y3VkQm4FsyFLjYA8ytMYqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WA7+xpn7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WA7+xpn7"
ARC-Seal: i=1; a=rsa-sha256; t=1771453448; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NK8LvXH2MAz3oXRhYgkxE8QqK5GdqDCNIBC1OKnkHToap8nl5RtwPAsQHLtz4ktZZhH3T/rQ1u+NcGhKff4npNGVHWUhp3cic6KQIJgU6M+5jfRqA7kf4buun+bmlN4dd+568lrREKOEZF6rV0TB4hIQh12CNsqLmI+x1ueMMfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453448; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/SDr+5EPb/CSkDgGPHbs5uOc34Vy2l6zilKWVh3XOUo=; 
	b=hlS7YyQpxupKLBG88As2QoSgDVusHv/oQYhV0cJAJjZYqg+DKL4E2GhIuPCyJJTxqDgw6GYhVj2vXuLWvc1iD/dyBzyXTJpGYrvpoo+TWuMLMFqRsy4y1cks4UJccOnN1bOB7qrpGu2U2Q/hIwRFZbP5IW4I5bs2bBObkXdduLg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453448;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/SDr+5EPb/CSkDgGPHbs5uOc34Vy2l6zilKWVh3XOUo=;
	b=WA7+xpn7ydikiFlQQFV+fR1DZYtJ+p3KtJNOZbWhpPQ2gkixdffzjYtWGvIw4Vu+
	Mnb8SGxEXJZ+PaKYfJ2XSi4gRbCLgO8CgLylWQ6hiUZipGakSgJuaRR04/tYXRYEjgm
	glkOVu54Hw7ts4xknfk/5d/VVRAMaR9pLfw8KHlE=
Received: by mx.zohomail.com with SMTPS id 177145344663131.922085762244592;
	Wed, 18 Feb 2026 14:24:06 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 0/8] Specify hooks via configs
Date: Thu, 19 Feb 2026 00:23:44 +0200
Message-ID: <20260218222352.55393-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

v2 addresses all feedback received in v1.

This series adds a new feature: the ability to specify commands to run
for hook events via config entries (including shell commands).

So instead of dropping a shell script or a custom program in .git/hooks
you can now tell git via config files to run a program or shell script
(can be specified directly in the config) when you run hook "foo".

This also means you can setup global hooks to run in multiple repos via
global configs and there's an option to disable them if necessary.

For simplicity, because this series is becoming rather big, hooks are
still executed sequentially (.jobs == 1). Parallel execution is added
in another patch series.

This is based on the latest v8 hooks-conversion series [1] which has
not yet landed in next or master.

Branch pused to GitHub: [2]
Succesful CI run: [3]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Peff, Kristoffer, Chris and many others.

Thank you,
Adrian

1: https://lore.kernel.org/git/20250925125352.1728840-1-adrian.ratiu@collabora.com/T/#m41f793907f46fd04f44ff1b06c53d20af38e6cb2
2: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/config-hooks-v2
3: https://github.com/10ne1/git/actions/runs/22158690260

Changes in v2:
* Introduce a "struct hook" with typing information & helper fun types (Junio)
* Detect hook config friendly-name and command in the same place (Junio, Patrick)
* Simplified run_hooks_opt() to use list index instead of item pointers (Patrick)
* Simplified pick_next_hook() to only contain next pp child setup logic (Patrick)
* Reworked git hook list to not rely on empty strings to distinguish hooks (Junio)
* Added a hook config cache to avoid re-reading cfg on each hook call (Patrick)
* New commit: Split internal state alloc/free callbacks into own commit (Patrick)
* New commit: Add hook.<name>.enabled (Patrick)
* New commit: Add -z option to git hook list (Patrick)
* New commit: "event = " config entries reset the value  (Patrick)
* Split default hook detection into its own helper from list_hooks (Adrian)
* Moved hook internal state alloc/free where struct hook is defined (Patrick)
* Changed semantics of e copy/free cb API to avoid copying (alloc/free) (Patrick)
* Replace the empty "friendly-name" for the legacy hooks with the path (Patrick)
* Dropped the notify_start_failure() msg because it's not worth the complexity
  and reverted back to the previous hook cb call convention (Patrick)
* Fixed codepaths to avoid using the_repository in favor of repo arg (Patrick)
* Fixed a very small conflict with upstream master branch due to the
  addition of the new "history" command (Adrian)
* Removed the extra repository pointer added to hook.h (Adrian)
* Added a more tests exercising git hook list/run (Patrick)
* Moved r->gitdir check to commit which allows out-of-repo invocations (Patrick)
* Reworded commit and error messages for better clarity, added warnings (Patrick)
* Reordered commits for better reading (Adrian)
* Small documentation improvements and code style fixes (Patrick)

Range-diff v1 -> v2:
1:  3b9816d835 < -:  ---------- hook: run a list of hooks
-:  ---------- > 1:  6fe0e2eea4 hook: add internal state alloc/free callbacks
-:  ---------- > 2:  2917d45a19 hook: run a list of hooks to prepare for multihook support
2:  fbc84e68ef ! 3:  19d41e85e1 hook: introduce "git hook list"
    @@ Metadata
     Author: Emily Shaffer <nasamuffin@google.com>
     
      ## Commit message ##
    -    hook: introduce "git hook list"
    +    hook: add "git hook list" command
     
    -    If more than one hook will be run, it may be useful to see a list of
    -    which hooks should be run. At very least, it will be useful for us to
    -    test the semantics of multihooks ourselves.
    +    The previous commit introduced an ability to run multiple commands for
    +    hook events and next commit will introduce the ability to define hooks
    +    from configs, in addition to the "traditional" hooks from the hookdir.
     
    -    For now, only list the hooks which will run in the order they will run
    -    in; later, it might be useful to include more information like where the
    -    hooks were configured and whether or not they will run.
    +    Introduce a new command "git hook list" to make inspecting hooks easier
    +    both for users and for the tests we will add.
    +
    +    Further commits will expand on this, e.g. by adding a -z output mode.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
    @@ Documentation/git-hook.adoc: Any positional arguments to the hook should be pass
      
     +list::
     +	Print a list of hooks which will be run on `<hook-name>` event. If no
    -+	hooks are configured for that event, print nothing and return 1.
    ++	hooks are configured for that event, print a warning and return 1.
     +
      OPTIONS
      -------
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
      	NULL
      };
      
    -+static const char *const builtin_hook_list_usage[] = {
    -+	BUILTIN_HOOK_LIST_USAGE,
    -+	NULL
    -+};
    -+
     +static int list(int argc, const char **argv, const char *prefix,
    -+		 struct repository *repo UNUSED)
    ++		 struct repository *repo)
     +{
    ++	static const char *const builtin_hook_list_usage[] = {
    ++		BUILTIN_HOOK_LIST_USAGE,
    ++		NULL
    ++	};
     +	struct string_list *head;
     +	struct string_list_item *item;
     +	const char *hookname = NULL;
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
     +
     +	hookname = argv[0];
     +
    -+	head = list_hooks(the_repository, hookname);
    ++	head = list_hooks(repo, hookname, NULL);
     +
     +	if (!head->nr) {
    ++		warning(_("No hooks found for event '%s'"), hookname);
     +		ret = 1; /* no hooks found */
     +		goto cleanup;
     +	}
     +
     +	for_each_string_list_item(item, head) {
    -+		printf("%s\n", *item->string ? item->string
    -+			     : _("hook from hookdir"));
    ++		struct hook *h = item->util;
    ++
    ++		switch (h->kind) {
    ++		case HOOK_TRADITIONAL:
    ++			printf("%s\n", _("hook from hookdir"));
    ++			break;
    ++		default:
    ++			BUG("unknown hook kind");
    ++		}
     +	}
     +
     +cleanup:
    -+	string_list_clear(head, 1);
    ++	hook_list_clear(head, NULL);
     +	free(head);
     +	return ret;
     +}
    @@ builtin/hook.c: int cmd_hook(int argc,
      
     
      ## hook.c ##
    -@@ hook.c: const char *find_hook(struct repository *r, const char *name)
    - 	return path.buf;
    +@@ hook.c: static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
    + 	free(h);
    + }
    + 
    +-static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
    ++void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
    + {
    + 	struct string_list_item *item;
    + 
    +@@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hookname,
    + 	string_list_append(hook_list, hook_path)->util = h;
      }
      
     -/*
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
     - * The caller is responsible for freeing the memory of the returned list
     - * using string_list_clear() and free().
     - */
    --static struct string_list *list_hooks(struct repository *r, const char *hookname)
    -+struct string_list *list_hooks(struct repository *r, const char *hookname)
    +-static struct string_list *list_hooks(struct repository *r, const char *hookname,
    ++struct string_list *list_hooks(struct repository *r, const char *hookname,
    + 			       struct run_hooks_opt *options)
      {
      	struct string_list *hook_head;
    - 
     
      ## hook.h ##
     @@ hook.h: struct hook_cb_data {
    - 	struct repository *repository;
    + 	struct run_hooks_opt *options;
      };
      
     -/*
    @@ hook.h: struct hook_cb_data {
     + * The caller is responsible for freeing the memory of the returned list
     + * using string_list_clear() and free().
     + */
    -+struct string_list *list_hooks(struct repository *r, const char *hookname);
    ++struct string_list *list_hooks(struct repository *r, const char *hookname,
    ++			       struct run_hooks_opt *options);
    ++
    ++/**
    ++ * Frees the memory allocated for the hook list, including the `struct hook`
    ++ * items and their internal state.
    ++ */
    ++void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
     +
     +/**
       * Returns the path to the hook file, or NULL if the hook is missing
    @@ t/t1800-hook.sh: test_expect_success 'git hook usage' '
      	grep "unknown option" err
      '
      
    ++test_expect_success 'git hook list: nonexistent hook' '
    ++	cat >stderr.expect <<-\EOF &&
    ++	warning: No hooks found for event '\''test-hook'\''
    ++	EOF
    ++	test_expect_code 1 git hook list test-hook 2>stderr.actual &&
    ++	test_cmp stderr.expect stderr.actual
    ++'
    ++
    ++test_expect_success 'git hook list: traditional hook from hookdir' '
    ++	test_hook test-hook <<-EOF &&
    ++	echo Test hook
    ++	EOF
    ++
    ++	cat >expect <<-\EOF &&
    ++	hook from hookdir
    ++	EOF
    ++	git hook list test-hook >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'git hook run: nonexistent hook' '
    + 	cat >stderr.expect <<-\EOF &&
    + 	error: cannot find a hook named test-hook
3:  d6b3fbf6b1 ! 4:  0c98b18bf5 hook: include hooks from the config
    @@
      ## Metadata ##
    -Author: Emily Shaffer <nasamuffin@google.com>
    +Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
         hook: include hooks from the config
    @@ Commit message
         lines and will be run sequentially (.jobs == 1) like before.
         Running the hooks in parallel will be enabled in a future patch.
     
    +    The "traditional" hook from the hookdir is run last, if present.
    +
    +    A strmap cache is added to struct repository to avoid re-reading
    +    the configs on each rook run. This is useful for hooks like the
    +    ref-transaction which gets executed multiple times per process.
    +
         Examples:
     
           $ git config --get-regexp "^hook\."
    @@ Commit message
      ## Documentation/config/hook.adoc (new) ##
     @@
     +hook.<name>.command::
    -+	A command to execute whenever `hook.<name>` is invoked. `<name>` should
    -+	be a unique "friendly" name which you can use to identify this hook
    -+	command. (You can specify when to invoke this command with
    -+	`hook.<name>.event`.) The value can be an executable on your device or a
    -+	oneliner for your shell. If more than one value is specified for the
    -+	same `<name>`, the last value parsed will be the only command executed.
    -+	See linkgit:git-hook[1].
    ++	The command to execute for `hook.<name>`. `<name>` is a unique
    ++	"friendly" name that identifies this hook. (The hook events that
    ++	trigger the command are configured with `hook.<name>.event`.) The
    ++	value can be an executable path or a shell oneliner. If more than
    ++	one value is specified for the same `<name>`, only the last value
    ++	parsed is used. See linkgit:git-hook[1].
     +
     +hook.<name>.event::
    -+	The hook events which should invoke `hook.<name>`. `<name>` should be a
    -+	unique "friendly" name which you can use to identify this hook. The
    -+	value should be the name of a hook event, like "pre-commit" or "update".
    -+	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
    -+	On the specified event, the associated `hook.<name>.command` will be
    -+	executed. More than one event can be specified if you wish for
    -+	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
    ++	The hook events that trigger `hook.<name>`. The value is the name
    ++	of a hook event, like "pre-commit" or "update". (See
    ++	linkgit:githooks[5] for a complete list of hook events.) On the
    ++	specified event, the associated `hook.<name>.command` is executed.
    ++	This is a multi-valued key. To run `hook.<name>` on multiple
    ++	events, specify the key more than once. See linkgit:git-hook[1].
     
      ## Documentation/git-hook.adoc ##
     @@ Documentation/git-hook.adoc: DESCRIPTION
    @@ Documentation/git-hook.adoc: DESCRIPTION
     +`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
     +
     +----
    -+git config hook.<some-name>.command <path-to-script>
    -+git config --add hook.<some-name>.event <hook-event>
    ++git config set hook.<some-name>.command <path-to-script>
    ++git config set --append hook.<some-name>.event <hook-event>
     +----
     +
     +This way you can share the script between multiple repos. That is, `cp
     +~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
     +
     +----
    -+git config hook.my-script.command ~/my-script.sh
    -+git config --add hook.my-script.event pre-commit
    ++git config set hook.my-script.command ~/my-script.sh
    ++git config set --append hook.my-script.event pre-commit
     +----
     +
      SUBCOMMANDS
    @@ Documentation/git-hook.adoc: DESCRIPTION
     -	Run the `<hook-name>` hook. See linkgit:githooks[5] for
     -	supported hook names.
     +	Runs hooks configured for `<hook-name>`, in the order they are
    -+	discovered during the config parse.
    ++	discovered during the config parse. The default `<hook-name>` from
    ++	the hookdir is run last. See linkgit:githooks[5] for supported
    ++	hook names.
      +
      
      Any positional arguments to the hook should be passed after a
    @@ Documentation/git-hook.adoc: OPTIONS
      --------
      linkgit:githooks[5]
     
    + ## builtin/hook.c ##
    +@@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix,
    + 		case HOOK_TRADITIONAL:
    + 			printf("%s\n", _("hook from hookdir"));
    + 			break;
    ++		case HOOK_CONFIGURED:
    ++			printf("%s\n", h->u.configured.friendly_name);
    ++			break;
    + 		default:
    + 			BUG("unknown hook kind");
    + 		}
    +
      ## hook.c ##
    -@@ hook.c: const char *find_hook(struct repository *r, const char *name)
    - 	return path.buf;
    +@@
    + #include "gettext.h"
    + #include "hook.h"
    + #include "path.h"
    ++#include "parse.h"
    + #include "run-command.h"
    + #include "config.h"
    + #include "strbuf.h"
    ++#include "strmap.h"
    + #include "environment.h"
    + #include "setup.h"
    + 
    +@@ hook.c: static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
    + 
    + 	if (h->kind == HOOK_TRADITIONAL)
    + 		free((void *)h->u.traditional.path);
    ++	else if (h->kind == HOOK_CONFIGURED) {
    ++		free((void *)h->u.configured.friendly_name);
    ++		free((void *)h->u.configured.command);
    ++	}
    + 
    + 	if (cb_data_free)
    + 		cb_data_free(h->feed_pipe_cb_data);
    +@@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hookname,
    + 	string_list_append(hook_list, hook_path)->util = h;
      }
      
    -+struct hook_config_cb
    ++static void unsorted_string_list_remove(struct string_list *list,
    ++					const char *str)
     +{
    -+	const char *hook_event;
    -+	struct string_list *list;
    -+};
    ++	struct string_list_item *item = unsorted_string_list_lookup(list, str);
    ++	if (item)
    ++		unsorted_string_list_delete_item(list, item - list->items, 0);
    ++}
     +
     +/*
    -+ * Callback for git_config which adds configured hooks to a hook list.  Hooks
    -+ * can be configured by specifying both hook.<friendly-name>.command = <path>
    -+ * and hook.<friendly-name>.event = <hook-event>.
    ++ * Callback struct to collect all hook.* keys in a single config pass.
    ++ * commands: friendly-name to command map.
    ++ * event_hooks: event-name to list of friendly-names map.
    ++ * disabled_hooks: set of friendly-names with hook.name.enabled = false.
     + */
    -+static int hook_config_lookup(const char *key, const char *value,
    -+			      const struct config_context *ctx UNUSED,
    -+			      void *cb_data)
    ++struct hook_all_config_cb {
    ++	struct strmap commands;
    ++	struct strmap event_hooks;
    ++	struct string_list disabled_hooks;
    ++};
    ++
    ++/* repo_config() callback that collects all hook.* configuration in one pass. */
    ++static int hook_config_lookup_all(const char *key, const char *value,
    ++				  const struct config_context *ctx UNUSED,
    ++				  void *cb_data)
     +{
    -+	struct hook_config_cb *data = cb_data;
    -+	const char *name, *event_key;
    -+	size_t name_len = 0;
    -+	struct string_list_item *item;
    ++	struct hook_all_config_cb *data = cb_data;
    ++	const char *name, *subkey;
     +	char *hook_name;
    ++	size_t name_len = 0;
     +
    -+	/*
    -+	 * Don't bother doing the expensive parse if there's no
    -+	 * chance that the config matches 'hook.myhook.event = hook_event'.
    -+	 */
    -+	if (!value || strcmp(value, data->hook_event))
    ++	if (parse_config_key(key, "hook", &name, &name_len, &subkey))
     +		return 0;
     +
    -+	/* Look for "hook.friendly-name.event = hook_event" */
    -+	if (parse_config_key(key, "hook", &name, &name_len, &event_key) ||
    -+	    strcmp(event_key, "event"))
    -+		return 0;
    ++	if (!value)
    ++		return config_error_nonbool(key);
     +
    -+	/* Extract the hook name */
    ++	/* Extract name, ensuring it is null-terminated. */
     +	hook_name = xmemdupz(name, name_len);
     +
    -+	/* Remove the hook if already in the list, so we append in config order. */
    -+	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
    -+		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
    ++	if (!strcmp(subkey, "event")) {
    ++		struct string_list *hooks =
    ++			strmap_get(&data->event_hooks, value);
     +
    -+	/* The list takes ownership of hook_name, so append with nodup */
    -+	string_list_append_nodup(data->list, hook_name);
    ++		if (!hooks) {
    ++			hooks = xcalloc(1, sizeof(*hooks));
    ++			string_list_init_dup(hooks);
    ++			strmap_put(&data->event_hooks, value, hooks);
    ++		}
     +
    ++		/* Re-insert if necessary to preserve last-seen order. */
    ++		unsorted_string_list_remove(hooks, hook_name);
    ++		string_list_append(hooks, hook_name);
    ++	} else if (!strcmp(subkey, "command")) {
    ++		/* Store command overwriting the old value */
    ++		char *old = strmap_put(&data->commands, hook_name,
    ++				       xstrdup(value));
    ++		free(old);
    ++	}
    ++
    ++	free(hook_name);
     +	return 0;
     +}
     +
    - struct string_list *list_hooks(struct repository *r, const char *hookname)
    ++/*
    ++ * The hook config cache maps each hook event name to a string_list where
    ++ * every item's string is the hook's friendly-name and its util pointer is
    ++ * the corresponding command string. Both strings are owned by the map.
    ++ *
    ++ * Disabled hooks and hooks missing a command are already filtered out at
    ++ * parse time, so callers can iterate the list directly.
    ++ */
    ++void hook_cache_clear(struct strmap *cache)
    ++{
    ++	struct hashmap_iter iter;
    ++	struct strmap_entry *e;
    ++
    ++	strmap_for_each_entry(cache, &iter, e) {
    ++		struct string_list *hooks = e->value;
    ++		string_list_clear(hooks, 1); /* free util (command) pointers */
    ++		free(hooks);
    ++	}
    ++	strmap_clear(cache, 0);
    ++}
    ++
    ++/* Populate `cache` with the complete hook configuration */
    ++static void build_hook_config_map(struct repository *r, struct strmap *cache)
    ++{
    ++	struct hook_all_config_cb cb_data;
    ++	struct hashmap_iter iter;
    ++	struct strmap_entry *e;
    ++
    ++	strmap_init(&cb_data.commands);
    ++	strmap_init(&cb_data.event_hooks);
    ++	string_list_init_dup(&cb_data.disabled_hooks);
    ++
    ++	/* Parse all configs in one run. */
    ++	repo_config(r, hook_config_lookup_all, &cb_data);
    ++
    ++	/* Construct the cache from parsed configs. */
    ++	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
    ++		struct string_list *hook_names = e->value;
    ++		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
    ++
    ++		string_list_init_dup(hooks);
    ++
    ++		for (size_t i = 0; i < hook_names->nr; i++) {
    ++			const char *hname = hook_names->items[i].string;
    ++			char *command;
    ++
    ++			command = strmap_get(&cb_data.commands, hname);
    ++			if (!command)
    ++				die(_("'hook.%s.command' must be configured or "
    ++				      "'hook.%s.event' must be removed;"
    ++				      " aborting."), hname, hname);
    ++
    ++			/* util stores the command; owned by the cache. */
    ++			string_list_append(hooks, hname)->util =
    ++				xstrdup(command);
    ++		}
    ++
    ++		strmap_put(cache, e->key, hooks);
    ++	}
    ++
    ++	strmap_clear(&cb_data.commands, 1);
    ++	string_list_clear(&cb_data.disabled_hooks, 0);
    ++	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
    ++		string_list_clear(e->value, 0);
    ++		free(e->value);
    ++	}
    ++	strmap_clear(&cb_data.event_hooks, 0);
    ++}
    ++
    ++/* Return the hook config map for `r`, populating it first if needed. */
    ++static struct strmap *get_hook_config_cache(struct repository *r)
    ++{
    ++	struct strmap *cache = NULL;
    ++
    ++	if (r) {
    ++		/*
    ++		 * For in-repo calls, the map is stored in r->hook_config_cache,
    ++		 * so repeated invocations don't parse the configs, so allocate
    ++		 * it just once on the first call.
    ++		 */
    ++		if (!r->hook_config_cache) {
    ++			r->hook_config_cache = xcalloc(1, sizeof(*cache));
    ++			strmap_init(r->hook_config_cache);
    ++			build_hook_config_map(r, r->hook_config_cache);
    ++		}
    ++		cache = r->hook_config_cache;
    ++	}
    ++
    ++	return cache;
    ++}
    ++
    ++static void list_hooks_add_configured(struct repository *r,
    ++				      const char *hookname,
    ++				      struct string_list *list,
    ++				      struct run_hooks_opt *options)
    ++{
    ++	struct strmap *cache = get_hook_config_cache(r);
    ++	struct string_list *configured_hooks = strmap_get(cache, hookname);
    ++
    ++	/* Iterate through configured hooks and initialize internal states */
    ++	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
    ++		const char *friendly_name = configured_hooks->items[i].string;
    ++		const char *command = configured_hooks->items[i].util;
    ++		struct hook *hook = xcalloc(1, sizeof(struct hook));
    ++
    ++		if (options && options->feed_pipe_cb_data_alloc)
    ++			hook->feed_pipe_cb_data =
    ++				options->feed_pipe_cb_data_alloc(
    ++					options->feed_pipe_ctx);
    ++
    ++		hook->kind = HOOK_CONFIGURED;
    ++		hook->u.configured.friendly_name = xstrdup(friendly_name);
    ++		hook->u.configured.command = xstrdup(command);
    ++
    ++		string_list_append(list, friendly_name)->util = hook;
    ++	}
    ++}
    ++
    + struct string_list *list_hooks(struct repository *r, const char *hookname,
    + 			       struct run_hooks_opt *options)
      {
    --	struct string_list *hook_head;
    -+	struct hook_config_cb cb_data;
    +@@ hook.c: struct string_list *list_hooks(struct repository *r, const char *hookname,
    + 	hook_head = xmalloc(sizeof(struct string_list));
    + 	string_list_init_dup(hook_head);
      
    - 	if (!hookname)
    - 		BUG("null hookname was provided to hook_list()!");
    - 
    --	hook_head = xmalloc(sizeof(struct string_list));
    --	string_list_init_dup(hook_head);
    -+	cb_data.hook_event = hookname;
    -+	cb_data.list = xmalloc(sizeof(struct string_list));
    -+	string_list_init_dup(cb_data.list);
    -+
    -+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
    -+	repo_config(r, hook_config_lookup, &cb_data);
    - 
    - 	/*
    - 	 * Add the default hook from hookdir. It does not have a friendly name
    - 	 * like the hooks specified via configs, so add it with an empty name.
    - 	 */
    - 	if (r->gitdir && find_hook(r, hookname))
    --		string_list_append(hook_head, "");
    -+		string_list_append(cb_data.list, "");
    - 
    --	return hook_head;
    -+	return cb_data.list;
    - }
    ++	/* Add hooks from the config, e.g. hook.myhook.event = pre-commit */
    ++	list_hooks_add_configured(r, hookname, hook_head, options);
    ++
    + 	/* Add the default "traditional" hooks from hookdir. */
    + 	list_hooks_add_default(r, hookname, hook_head, options);
      
    - int hook_exists(struct repository *r, const char *name)
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
    - 			hook_path = absolute_path(hook_path);
    + 	cp->dir = hook_cb->options->dir;
      
    - 		strvec_push(&cp->args, hook_path);
    -+	} else {
    -+		/* ...from config */
    -+		struct strbuf cmd_key = STRBUF_INIT;
    -+		char *command = NULL;
    -+
    + 	/* Add hook exec paths or commands */
    +-	if (h->kind == HOOK_TRADITIONAL)
    ++	if (h->kind == HOOK_TRADITIONAL) {
    + 		strvec_push(&cp->args, h->u.traditional.path);
    ++	} else if (h->kind == HOOK_CONFIGURED) {
     +		/* to enable oneliners, let config-specified hooks run in shell. */
     +		cp->use_shell = true;
    ++		strvec_push(&cp->args, h->u.configured.command);
    ++	}
    + 
    + 	if (!cp->args.nr)
    + 		BUG("hook must have at least one command or exec path");
    +
    + ## hook.h ##
    +@@
    + #include "strvec.h"
    + #include "run-command.h"
    + #include "string-list.h"
    ++#include "strmap.h"
    + 
    + struct repository;
    + 
    +@@ hook.h: struct repository;
    +  * Represents a hook command to be run.
    +  * Hooks can be:
    +  * 1. "traditional" (found in the hooks directory)
    +- * 2. "configured" (defined in Git's configuration, not yet implemented).
    ++ * 2. "configured" (defined in Git's configuration via hook.<name>.event).
    +  * The 'kind' field determines which part of the union 'u' is valid.
    +  */
    + struct hook {
    + 	enum {
    + 		HOOK_TRADITIONAL,
    ++		HOOK_CONFIGURED,
    + 	} kind;
    + 	union {
    + 		struct {
    + 			const char *path;
    + 		} traditional;
    ++		struct {
    ++			const char *friendly_name;
    ++			const char *command;
    ++		} configured;
    + 	} u;
    + 
    + 	/**
    +@@ hook.h: struct string_list *list_hooks(struct repository *r, const char *hookname,
    +  */
    + void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
    + 
    ++/**
    ++ * Frees the hook configuration cache stored in `struct repository`.
    ++ * Called by repo_clear().
    ++ */
    ++void hook_cache_clear(struct strmap *cache);
     +
    -+		strbuf_addf(&cmd_key, "hook.%s.command", to_run->string);
    -+		if (repo_config_get_string(hook_cb->repository,
    -+					   cmd_key.buf, &command)) {
    -+			die(_("'hook.%s.command' must be configured or"
    -+			      "'hook.%s.event' must be removed; aborting.\n"),
    -+			    to_run->string, to_run->string);
    -+		}
    -+		strbuf_release(&cmd_key);
    -+
    -+		strvec_push_nodup(&cp->args, command);
    + /**
    +  * Returns the path to the hook file, or NULL if the hook is missing
    +  * or disabled. Note that this points to static storage that will be
    +
    + ## repository.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "abspath.h"
    + #include "repository.h"
    ++#include "hook.h"
    + #include "odb.h"
    + #include "config.h"
    + #include "object.h"
    +@@ repository.c: void repo_clear(struct repository *repo)
    + 		FREE_AND_NULL(repo->index);
      	}
      
    - 	if (!cp->args.nr)
    ++	if (repo->hook_config_cache) {
    ++		hook_cache_clear(repo->hook_config_cache);
    ++		FREE_AND_NULL(repo->hook_config_cache);
    ++	}
    ++
    + 	if (repo->promisor_remote_config) {
    + 		promisor_remote_clear(repo->promisor_remote_config);
    + 		FREE_AND_NULL(repo->promisor_remote_config);
    +
    + ## repository.h ##
    +@@ repository.h: struct repository {
    + 	/* True if commit-graph has been disabled within this process. */
    + 	int commit_graph_disabled;
    + 
    ++	/*
    ++	 * Lazily-populated cache mapping hook event names to configured hooks.
    ++	 * NULL until first hook use.
    ++	 */
    ++	struct strmap *hook_config_cache;
    ++
    + 	/* Configurations related to promisor remotes. */
    + 	char *repository_format_partial_clone;
    + 	struct promisor_remote_config *promisor_remote_config;
     
      ## t/t1800-hook.sh ##
     @@
    @@ t/t1800-hook.sh
      	test_expect_code 129 git hook run --unknown 2>err &&
      	test_expect_code 129 git hook list &&
      	test_expect_code 129 git hook list -h &&
    +@@ t/t1800-hook.sh: test_expect_success 'git hook list: traditional hook from hookdir' '
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'git hook list: configured hook' '
    ++	test_config hook.myhook.command "echo Hello" &&
    ++	test_config hook.myhook.event test-hook --add &&
    ++
    ++	echo "myhook" >expect &&
    ++	git hook list test-hook >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'git hook run: nonexistent hook' '
    + 	cat >stderr.expect <<-\EOF &&
    + 	error: cannot find a hook named test-hook
     @@ t/t1800-hook.sh: test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
      	test_hook_tty commit -m"B.new"
      '
    @@ t/t1800-hook.sh: test_expect_success TTY 'git commit: stdout and stderr are conn
     +'
     +
     +test_expect_success 'stdin to multiple hooks' '
    -+	test_config hook.stdin-a.event "test-hook" --add &&
    -+	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" --add &&
    -+	test_config hook.stdin-b.event "test-hook" --add &&
    -+	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
    ++	test_config hook.stdin-a.event "test-hook" &&
    ++	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" &&
    ++	test_config hook.stdin-b.event "test-hook" &&
    ++	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" &&
     +
     +	cat >input <<-\EOF &&
     +	1
    @@ t/t1800-hook.sh: test_expect_success TTY 'git commit: stdout and stderr are conn
     +
     +test_expect_success 'rejects hooks with no commands configured' '
     +	test_config hook.broken.event "test-hook" &&
    -+	echo broken >expected &&
    -+	git hook list test-hook >actual &&
    -+	test_cmp expected actual &&
    -+	test_must_fail git hook run test-hook
    ++	test_must_fail git hook list test-hook 2>actual &&
    ++	test_grep "hook.broken.command" actual &&
    ++	test_must_fail git hook run test-hook 2>actual &&
    ++	test_grep "hook.broken.command" actual
     +'
     +
      test_expect_success 'git hook run a hook with a bad shebang' '
4:  d85dd19ffe < -:  ---------- hook: allow out-of-repo 'git hook' invocations
-:  ---------- > 5:  f71ada4cb8 hook: allow disabling config hooks
-:  ---------- > 6:  82a7d6167f hook: allow event = "" to overwrite previous values
-:  ---------- > 7:  8d1704384e hook: allow out-of-repo 'git hook' invocations
-:  ---------- > 8:  7bf527c59e hook: add -z option to "git hook list"

Adrian Ratiu (5):
  hook: add internal state alloc/free callbacks
  hook: include hooks from the config
  hook: allow disabling config hooks
  hook: allow event = "" to overwrite previous values
  hook: add -z option to "git hook list"

Emily Shaffer (3):
  hook: run a list of hooks to prepare for multihook support
  hook: add "git hook list" command
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config/hook.adoc |  24 +++
 Documentation/git-hook.adoc    | 137 +++++++++++-
 builtin/hook.c                 |  66 ++++++
 builtin/receive-pack.c         |  33 ++-
 git.c                          |   2 +-
 hook.c                         | 379 ++++++++++++++++++++++++++++++---
 hook.h                         | 104 ++++++++-
 refs.c                         |  24 ++-
 repository.c                   |   6 +
 repository.h                   |   6 +
 t/t1800-hook.sh                | 244 ++++++++++++++++++++-
 transport.c                    |  27 ++-
 12 files changed, 990 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/config/hook.adoc

-- 
2.52.0.732.gb351b5166d.dirty

