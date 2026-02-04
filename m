Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FE33C53C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223925; cv=pass; b=MVgf/1sz1woOQNI6I+fy8dockjU6YQBHaFeLg7St2yQ4pvzzx/bQtZsWKdO24/BexbKnjgGRUG+rQwry6Q17PfT80HzR3Cc2LmhuIE4K9fLJigkzoEsL0YrhvhhLobKpxobCBGtRP8dfCDNq2Otv7pz7t19ZYqLOwGes4/l11PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223925; c=relaxed/simple;
	bh=Px3m8c9hUDBitgD8+oHl2zj3TrXYiWpZZepwMDB6q4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW4gioRswowL0TjCSMFHfHbtTsnesEFLF0UeH10Q+ANFUsof57HFDs24vbz8nVRP8NDymuL1ui9rJ1B52Hmq5W7gya+CQu/MZ/94gIJRkgdpZulGu9PsdrdbbqvW3DPjfperH3r/TjNtgSDAzFokxsBrzu3p9Sj3k+6pZZoiIpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=TSKEZtqN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="TSKEZtqN"
ARC-Seal: i=1; a=rsa-sha256; t=1770223911; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j8/C9DecOYkg5dtDU0U1CATs9uA4ldjJOrAIst0hzTEwM7hG2HfRNeEG5rLGfunGh/aWKnBMsDCjl085Xr6NZv6c3eA2K6clUKrNHw8eU1RLja+d6vxRBj+0u0yvoaQNz5G3235unRUcvkVBrVLd9HpSBm1M1036b8IiRqnY0+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770223911; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ERBhRTRvlMo9+jS+YZhQF5/2pWgM6UNrxH3R7Ts3DSo=; 
	b=W4o/eI6Bum39u7s8HChLwtntCJc5wygwo8a5rQCFxpx6agtH6YMH1vz1B0fhtz4dA3PI/d6tJiJHrz1KeqNGZZIXthuaA4QQn/LokqoGETFomvSGCS+/zFSOG+VnI/Vk4tsKR/d5MgKwVg6A40W6PwQi4GEXkP+pqOq+e75lPuA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770223911;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ERBhRTRvlMo9+jS+YZhQF5/2pWgM6UNrxH3R7Ts3DSo=;
	b=TSKEZtqNrO6SjyZxLZM+87JlmNlSouzm3ha+9mNapZ9HobOdqfThf+oFsjSTPUQV
	5yHk4Xbmz6FLk7oVFLbJu4Kkd7zijVeWsz/2+ih5rnqQCj7brZF0rk5vLoLX2729l9r
	fSNWuCT/1dSrDKJSzmNTpN8U42oyL/1MtIcZX7l0=
Received: by mx.zohomail.com with SMTPS id 17702239097961018.5551127979115;
	Wed, 4 Feb 2026 08:51:49 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 3/4] hook: include hooks from the config
Date: Wed,  4 Feb 2026 18:51:25 +0200
Message-ID: <20260204165126.1548805-4-adrian.ratiu@collabora.com>
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

From: Emily Shaffer <emilyshaffer@google.com>

Teach the hook.[hc] library to parse configs to populate the list of
hooks to run for a given event.

Multiple commands can be specified for a given hook by providing
"hook.<friendly-name>.command = <path-to-hook>" and
"hook.<friendly-name>.event = <hook-event>" lines.

Hooks will be started in config order of the "hook.<name>.event"
lines and will be run sequentially (.jobs == 1) like before.
Running the hooks in parallel will be enabled in a future patch.

Examples:

  $ git config --get-regexp "^hook\."
  hook.bar.command=~/bar.sh
  hook.bar.event=pre-commit

  # Will run ~/bar.sh, then .git/hooks/pre-commit
  $ git hook run pre-commit

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  17 ++++
 Documentation/git-hook.adoc    | 126 ++++++++++++++++++++++++++++-
 hook.c                         |  78 ++++++++++++++++--
 t/t1800-hook.sh                | 140 ++++++++++++++++++++++++++++++++-
 4 files changed, 353 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/config/hook.adoc

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
new file mode 100644
index 0000000000..49c7ffd82e
--- /dev/null
+++ b/Documentation/config/hook.adoc
@@ -0,0 +1,17 @@
+hook.<name>.command::
+	A command to execute whenever `hook.<name>` is invoked. `<name>` should
+	be a unique "friendly" name which you can use to identify this hook
+	command. (You can specify when to invoke this command with
+	`hook.<name>.event`.) The value can be an executable on your device or a
+	oneliner for your shell. If more than one value is specified for the
+	same `<name>`, the last value parsed will be the only command executed.
+	See linkgit:git-hook[1].
+
+hook.<name>.event::
+	The hook events which should invoke `hook.<name>`. `<name>` should be a
+	unique "friendly" name which you can use to identify this hook. The
+	value should be the name of a hook event, like "pre-commit" or "update".
+	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
+	On the specified event, the associated `hook.<name>.command` will be
+	executed. More than one event can be specified if you wish for
+	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 93d734f687..5f339dc48b 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -17,12 +17,94 @@ DESCRIPTION
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
+`hook.<name>.event` configs during the configuration parse (see
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
+For a full list of hook events which you can set your `hook.<name>.event` to,
+and how hooks are invoked during those events, see linkgit:githooks[5].
+
+Git will ignore any `hook.<name>.event` that specifies an event it doesn't
+recognize. This is intended so that tools which wrap Git can use the hook
+infrastructure to run their own hooks; see "WRAPPERS" for more guidance.
+
+In general, when instructions suggest adding a script to
+`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
+
+----
+git config hook.<some-name>.command <path-to-script>
+git config --add hook.<some-name>.event <hook-event>
+----
+
+This way you can share the script between multiple repos. That is, `cp
+~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
+
+----
+git config hook.my-script.command ~/my-script.sh
+git config --add hook.my-script.event pre-commit
+----
+
 SUBCOMMANDS
 -----------
 
 run::
-	Run the `<hook-name>` hook. See linkgit:githooks[5] for
-	supported hook names.
+	Runs hooks configured for `<hook-name>`, in the order they are
+	discovered during the config parse.
 +
 
 Any positional arguments to the hook should be passed after a
@@ -46,6 +128,46 @@ OPTIONS
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
diff --git a/hook.c b/hook.c
index 949c907b59..9f59ebd0bd 100644
--- a/hook.c
+++ b/hook.c
@@ -47,24 +47,74 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
+struct hook_config_cb
+{
+	const char *hook_event;
+	struct string_list *list;
+};
+
+/*
+ * Callback for git_config which adds configured hooks to a hook list.  Hooks
+ * can be configured by specifying both hook.<friendly-name>.command = <path>
+ * and hook.<friendly-name>.event = <hook-event>.
+ */
+static int hook_config_lookup(const char *key, const char *value,
+			      const struct config_context *ctx UNUSED,
+			      void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *name, *event_key;
+	size_t name_len = 0;
+	struct string_list_item *item;
+	char *hook_name;
+
+	/*
+	 * Don't bother doing the expensive parse if there's no
+	 * chance that the config matches 'hook.myhook.event = hook_event'.
+	 */
+	if (!value || strcmp(value, data->hook_event))
+		return 0;
+
+	/* Look for "hook.friendly-name.event = hook_event" */
+	if (parse_config_key(key, "hook", &name, &name_len, &event_key) ||
+	    strcmp(event_key, "event"))
+		return 0;
+
+	/* Extract the hook name */
+	hook_name = xmemdupz(name, name_len);
+
+	/* Remove the hook if already in the list, so we append in config order. */
+	if ((item = unsorted_string_list_lookup(data->list, hook_name)))
+		unsorted_string_list_delete_item(data->list, item - data->list->items, 0);
+
+	/* The list takes ownership of hook_name, so append with nodup */
+	string_list_append_nodup(data->list, hook_name);
+
+	return 0;
+}
+
 struct string_list *list_hooks(struct repository *r, const char *hookname)
 {
-	struct string_list *hook_head;
+	struct hook_config_cb cb_data;
 
 	if (!hookname)
 		BUG("null hookname was provided to hook_list()!");
 
-	hook_head = xmalloc(sizeof(struct string_list));
-	string_list_init_dup(hook_head);
+	cb_data.hook_event = hookname;
+	cb_data.list = xmalloc(sizeof(struct string_list));
+	string_list_init_dup(cb_data.list);
+
+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
+	repo_config(r, hook_config_lookup, &cb_data);
 
 	/*
 	 * Add the default hook from hookdir. It does not have a friendly name
 	 * like the hooks specified via configs, so add it with an empty name.
 	 */
 	if (r->gitdir && find_hook(r, hookname))
-		string_list_append(hook_head, "");
+		string_list_append(cb_data.list, "");
 
-	return hook_head;
+	return cb_data.list;
 }
 
 int hook_exists(struct repository *r, const char *name)
@@ -125,6 +175,24 @@ static int pick_next_hook(struct child_process *cp,
 			hook_path = absolute_path(hook_path);
 
 		strvec_push(&cp->args, hook_path);
+	} else {
+		/* ...from config */
+		struct strbuf cmd_key = STRBUF_INIT;
+		char *command = NULL;
+
+		/* to enable oneliners, let config-specified hooks run in shell. */
+		cp->use_shell = true;
+
+		strbuf_addf(&cmd_key, "hook.%s.command", to_run->string);
+		if (repo_config_get_string(hook_cb->repository,
+					   cmd_key.buf, &command)) {
+			die(_("'hook.%s.command' must be configured or"
+			      "'hook.%s.event' must be removed; aborting.\n"),
+			    to_run->string, to_run->string);
+		}
+		strbuf_release(&cmd_key);
+
+		strvec_push_nodup(&cp->args, command);
 	}
 
 	if (!cp->args.nr)
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index d2d4a8760c..bc4862e982 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1,14 +1,31 @@
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
 	test_expect_code 129 git hook run -h &&
+	test_expect_code 129 git hook list -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
 	test_expect_code 129 git hook list &&
 	test_expect_code 129 git hook list -h &&
@@ -152,6 +169,126 @@ test_expect_success TTY 'git commit: stdout and stderr are connected to a TTY' '
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
+test_expect_success 'stdin to multiple hooks' '
+	test_config hook.stdin-a.event "test-hook" --add &&
+	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" --add &&
+	test_config hook.stdin-b.event "test-hook" --add &&
+	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
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
+	echo broken >expected &&
+	git hook list test-hook >actual &&
+	test_cmp expected actual &&
+	test_must_fail git hook run test-hook
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
@@ -169,6 +306,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 '
 
 test_expect_success 'stdin to hooks' '
+	mkdir -p .git/hooks &&
 	write_script .git/hooks/test-hook <<-\EOF &&
 	echo BEGIN stdin
 	cat
-- 
2.52.0.732.gb351b5166d.dirty

