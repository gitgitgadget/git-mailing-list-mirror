Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082C863CB
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390781; cv=pass; b=K/MD3V7pD3CteaVVHY0QoW4s0TqCMsH0092J9Wr65DrlMPxlTXCslY8sF6qXAv3NmaXP8zWevy4Zf0vcTcBpg9R1I3o3hEgferJ9Ije1cGDTy7AiZ7D3svNVgzXprpPL8cfGMccMpCJ0AHZfaLZSXQlhw+9nitKORNNmDxYcVCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390781; c=relaxed/simple;
	bh=q+/sSkGfE0rJIx1jK2iJVBANGJxx60/T19HWHFTtMT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo8L9sZTOpBmDAwv/roeNbl/x+UF8IZQtbuquHyjT+pY5p72A4EpEApxNFvqB8AXuLGJYw5z5+iJlDh/YQ23IVUyjWPsG8GmCGa/Ei9a93YhDZj0eVrVBe5EboJiF/z+R2ssjSMaLe8D1JTzp/0g8FwzFRxbw+iTrDIYeBXuuIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=c2CkPCq5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="c2CkPCq5"
ARC-Seal: i=1; a=rsa-sha256; t=1772390759; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OM5Xq+laDMM9q9tbTlEcTf67V/j95Z9dyHU4IJdSWTqt/RgY1jLDx4riCHsOtSKbMLHrvLT5jRe/P2z4uk+n4nfDU9FkOZbx42tFlPI84QvpKbLQsA5lvCf4drcMj0lljymclx/4Bz4wXY7VD6rvTfjB66L2lyWn1atzXQh6D8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390759; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kf53P9CsaTYFrA5Wspjkka+M6U6YN91xfI/MPaazdSc=; 
	b=JdHu9L8Ln/orOtlcJ4FdgWITmX15ZCSTh0roMh7N24scbVvID/D+jdL2deywDh2RrIkeGWa/mR/8k7Mjmf8p9bX9ZSUgTZPvQnoyYj9zDITt3itcFQkT0duCMfLXuc4WxLRpdFEICmuiBEdmnV+USnInD76EfmvdtsArNP0K8Rg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390759;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kf53P9CsaTYFrA5Wspjkka+M6U6YN91xfI/MPaazdSc=;
	b=c2CkPCq5eTFeYVq/0JXAQylOFtqnRcZsDYU6AFw7qapKhEYR5F3IMZqUeAo0Imuq
	82/EwXWQssiIMQN8rS0ECn+xq/qp5yMgWhQ7PyQKON4ZklilyAPjeX0goqNu9Jl2lky
	dVca9HwDr6OTsNhGYX8aFZhM5yl6l5dDjE07inYE=
Received: by mx.zohomail.com with SMTPS id 1772390757363247.76821096590265;
	Sun, 1 Mar 2026 10:45:57 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 00/12][next] Specify hooks via configs
Date: Sun,  1 Mar 2026 20:44:48 +0200
Message-ID: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
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

v3 addresses all feedback received in v2 (details below, including range-diff).

This series adds a new feature: the ability to specify commands to run
for hook events via config entries (including shell commands).

So instead of dropping a shell script or a custom program in .git/hooks
you can now tell git via config files to run a program or shell script
(can be specified directly in the config) when you run hook "foo".

This also means you can setup global hooks to run in multiple repos via
global configs and there's an option to disable them if necessary.

For simplicity, because this series is becoming rather big, hooks are
still executed sequentially (.jobs == 1). Parallel execution is added
in another follow-up patch series.

This is based on the latest next branch because it depends on some
commits which haven't yet landed in master.

Branch pused to GitHub: [1]
Succesful CI run: [2]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Peff, Kristoffer, Chris and many others.

Thank you,
Adrian

1: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/config-hooks-v3
2: https://github.com/10ne1/git/actions/runs/22549045872

Changes in v3:
* Rebased on next (no conflicts) because the hook dep series landed (Junio)
* Simplify cb data alloc/free function check to use the form (!A != !B) (Junio)
* New commit: `git hook list` lists disabled hooks (Patrick, Junio)
* New commit: store hook config scope and list it with git hook list (Junio)
* New commit: introduce struct hook_config_cache_entry eariler; this used to
  be done in the parallel hooks series, however we need it earlier in this
  for the  config scope + disabled hooks caching and listing (Junio, Patrick)
* Move disable_hooks def to the commit which introduces the feature (Patrick)
* Add comment about alloc/free cb data ownership to hook.h (Adrian)
* Replaced xcalloc() and xmalloc() with CALLOC_ARRAY() in all patches (Patrick)
* Static initialize struct receive_hook_feed_state in receive hook (Patrick)
* Rename cb_data_free/alloc() -> hook_data_free/alloc() callbacks (Patrick)
* Rename hook_clear() -> hook_free() (Patrick)
* Move unsorted_string_list_remove() helper to string-list.{c,h} (Patrick)
* Always prefer the free() variants instead of clear() (Junio)
* Use the standard string_list_clear_func() instead of my own hook_list_clear(),
  to do this I had to store a pointer to the free() cb in struct hook. (Patrick)
* Drop the use of hook_cache_clear(), it should have been hook_cache_free(),
  however it's not necessary after the above string_list_clear_func() (Junio)
* Trigger a BUG() when a hook type is unknown in pick_next_hook() (Patrick)
* Replaced hook.<name>.* -> hook.<friendly-name>.* (Junio)
* Removed unnecessary abspath.h include addition in builtin/hook.c (Adrian)
* Added more tests for various configured hooks corner-cases (Adrian)
* Minor typos and style fixes (Patrick)

 1:  6fe0e2eea4 !  1:  4c9e2b4c95 hook: add internal state alloc/free callbacks
    @@ builtin/receive-pack.c: static int feed_receive_hook_cb(int hook_stdin_fd, void
     +static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
     +{
     +	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
    -+	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
    ++	struct receive_hook_feed_state *data;
    ++	CALLOC_ARRAY(data, 1);
     +	data->report = init_state->report;
     +	data->cmd = init_state->cmd;
     +	data->skip_broken = init_state->skip_broken;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
      	struct command *iter = commands;
     -	struct receive_hook_feed_state feed_state;
    -+	struct receive_hook_feed_state feed_init_state = { 0 };
    ++	struct receive_hook_feed_state feed_init_state = {
    ++		.cmd = commands,
    ++		.skip_broken = skip_broken,
    ++		.buf = STRBUF_INIT,
    ++	};
      	struct async sideband_async;
      	int sideband_async_started = 0;
      	int saved_stderr = -1;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     -	feed_state.report = NULL;
     -	strbuf_init(&feed_state.buf, 0);
     -	opt.feed_pipe_cb_data = &feed_state;
    -+	feed_init_state.cmd = commands;
    -+	feed_init_state.skip_broken = skip_broken;
     +	opt.feed_pipe_ctx = &feed_init_state;
      	opt.feed_pipe = feed_receive_hook_cb;
     +	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
     +	 * Ensure cb_data copy and free functions are either provided together,
     +	 * or neither one is provided.
     +	 */
    -+	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
    -+	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
    ++	if (!options->feed_pipe_cb_data_alloc != !options->feed_pipe_cb_data_free)
     +		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
     +
     +	if (options->feed_pipe_cb_data_alloc)
    @@ hook.h
      
      struct repository;
      
    -+typedef void (*cb_data_free_fn)(void *data);
    -+typedef void *(*cb_data_alloc_fn)(void *init_ctx);
    ++typedef void (*hook_data_free_fn)(void *data);
    ++typedef void *(*hook_data_alloc_fn)(void *init_ctx);
     +
      struct run_hooks_opt
      {
    @@ hook.h: struct run_hooks_opt
     +	 * If provided, this function will be called to alloc & initialize the
     +	 * `feed_pipe_cb_data` for each hook.
     +	 *
    ++	 * The caller must provide a `feed_pipe_cb_data_free` callback to free
    ++	 * this memory (missing callback will trigger a bug). Use only the cb to
    ++	 * free the memory, do not free it manually in the caller.
    ++	 *
     +	 * The `feed_pipe_ctx` pointer can be used to pass initialization data.
     +	 */
    -+	cb_data_alloc_fn feed_pipe_cb_data_alloc;
    ++	hook_data_alloc_fn feed_pipe_cb_data_alloc;
     +
     +	/**
     +	 * Called to free the memory initialized by `feed_pipe_cb_data_alloc`.
     +	 *
     +	 * Must always be provided when `feed_pipe_cb_data_alloc` is provided.
     +	 */
    -+	cb_data_free_fn feed_pipe_cb_data_free;
    ++	hook_data_free_fn feed_pipe_cb_data_free;
      };
      
      #define RUN_HOOKS_OPT_INIT { \
    @@ refs.c: static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, v
      
     +static void *transaction_feed_cb_data_alloc(void *feed_pipe_ctx UNUSED)
     +{
    -+	struct transaction_feed_cb_data *data = xmalloc(sizeof(*data));
    ++	struct transaction_feed_cb_data *data;
    ++	CALLOC_ARRAY(data, 1);
     +	strbuf_init(&data->buf, 0);
     +	data->index = 0;
     +	return data;
    @@ transport.c: static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb
      
     +static void *pre_push_hook_data_alloc(void *feed_pipe_ctx)
     +{
    -+	struct feed_pre_push_hook_data *data = xmalloc(sizeof(*data));
    ++	struct feed_pre_push_hook_data *data;
    ++	CALLOC_ARRAY(data, 1);
     +	strbuf_init(&data->buf, 0);
     +	data->refs = (struct ref *)feed_pipe_ctx;
     +	return data;
 2:  2917d45a19 !  2:  d1579a4435 hook: run a list of hooks to prepare for multihook support
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
      	return path.buf;
      }
      
    -+static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
    ++/*
    ++ * Frees a struct hook stored as the util pointer of a string_list_item.
    ++ * Suitable for use as a string_list_clear_func_t callback.
    ++ */
    ++static void hook_free(void *p, const char *str UNUSED)
     +{
    ++	struct hook *h = p;
    ++
     +	if (!h)
     +		return;
     +
     +	if (h->kind == HOOK_TRADITIONAL)
     +		free((void *)h->u.traditional.path);
     +
    -+	if (cb_data_free)
    -+		cb_data_free(h->feed_pipe_cb_data);
    ++	if (h->data_free)
    ++		h->data_free(h->feed_pipe_cb_data);
     +
     +	free(h);
     +}
     +
    -+static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
    -+{
    -+	struct string_list_item *item;
    -+
    -+	for_each_string_list_item(item, hooks)
    -+		hook_clear(item->util, cb_data_free);
    -+
    -+	string_list_clear(hooks, 0);
    -+}
    -+
     +/* Helper to detect and add default "traditional" hooks from the hookdir. */
     +static void list_hooks_add_default(struct repository *r, const char *hookname,
     +				   struct string_list *hook_list,
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
     +	if (!hook_path)
     +		return;
     +
    -+	h = xcalloc(1, sizeof(struct hook));
    ++	CALLOC_ARRAY(h, 1);
     +
     +	/*
     +	 * If the hook is to run in a specific dir, a relative path can
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
     +	/* Setup per-hook internal state cb data */
     +	if (options && options->feed_pipe_cb_data_alloc)
     +		h->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
    ++	if (options)
    ++		h->data_free = options->feed_pipe_cb_data_free;
     +
     +	h->kind = HOOK_TRADITIONAL;
     +	h->u.traditional.path = xstrdup(hook_path);
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
     +	if (!hookname)
     +		BUG("null hookname was provided to hook_list()!");
     +
    -+	hook_head = xmalloc(sizeof(struct string_list));
    ++	CALLOC_ARRAY(hook_head, 1);
     +	string_list_init_dup(hook_head);
     +
     +	/* Add the default "traditional" hooks from hookdir. */
    @@ hook.c: const char *find_hook(struct repository *r, const char *name)
     -	return !!find_hook(r, name);
     +	struct string_list *hooks = list_hooks(r, name, NULL);
     +	int exists = hooks->nr > 0;
    -+	hook_list_clear(hooks, NULL);
    ++	string_list_clear_func(hooks, hook_free);
     +	free(hooks);
     +	return exists;
      }
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
     +	/* Add hook exec paths or commands */
     +	if (h->kind == HOOK_TRADITIONAL)
     +		strvec_push(&cp->args, h->u.traditional.path);
    ++	else
    ++		BUG("unknown hook kind");
     +
     +	if (!cp->args.nr)
     +		BUG("hook must have at least one command or exec path");
    @@ hook.c: static void run_hooks_opt_clear(struct run_hooks_opt *options)
      	const struct run_process_parallel_opts opts = {
      		.tr2_category = "hook",
     @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
    - 	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
    + 	if (!options->feed_pipe_cb_data_alloc != !options->feed_pipe_cb_data_free)
      		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
      
     -	if (options->feed_pipe_cb_data_alloc)
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		*options->invoked_hook = 0;
      
     -	if (!hook_path && !options->error_if_missing)
    --		goto cleanup;
    --
    --	if (!hook_path) {
    --		ret = error("cannot find a hook named %s", hook_name);
     +	cb_data.hook_command_list = list_hooks(r, hook_name, options);
     +	if (!cb_data.hook_command_list->nr) {
     +		if (options->error_if_missing)
     +			ret = error("cannot find a hook named %s", hook_name);
      		goto cleanup;
    - 	}
    - 
    +-
    +-	if (!hook_path) {
    +-		ret = error("cannot find a hook named %s", hook_name);
    +-		goto cleanup;
    +-	}
    +-
     -	cb_data.hook_path = hook_path;
     -	if (options->dir) {
     -		strbuf_add_absolute_path(&abs_path, hook_path);
     -		cb_data.hook_path = abs_path.buf;
    --	}
    --
    + 	}
    + 
      	run_processes_parallel(&opts);
      	ret = cb_data.rc;
      cleanup:
     -	strbuf_release(&abs_path);
    -+	hook_list_clear(cb_data.hook_command_list, options->feed_pipe_cb_data_free);
    ++	string_list_clear_func(cb_data.hook_command_list, hook_free);
     +	free(cb_data.hook_command_list);
      	run_hooks_opt_clear(options);
      	return ret;
    @@ hook.h
      
      struct repository;
      
    + typedef void (*hook_data_free_fn)(void *data);
    + typedef void *(*hook_data_alloc_fn)(void *init_ctx);
    + 
     +/**
     + * Represents a hook command to be run.
     + * Hooks can be:
    @@ hook.h
     +	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
     +	 */
     +	void *feed_pipe_cb_data;
    ++
    ++	/**
    ++	 * Callback to free `feed_pipe_cb_data`.
    ++	 *
    ++	 * It is called automatically and points to the `feed_pipe_cb_data_free`
    ++	 * provided via the `run_hook_opt` parameter.
    ++	 */
    ++	hook_data_free_fn data_free;
     +};
     +
    - typedef void (*cb_data_free_fn)(void *data);
    - typedef void *(*cb_data_alloc_fn)(void *init_ctx);
    - 
    + struct run_hooks_opt
    + {
    + 	/* Environment vars to be set for each hook */
     @@ hook.h: struct run_hooks_opt
      	 */
      	void *feed_pipe_ctx;
    @@ hook.h: struct hook_cb_data {
      	struct run_hooks_opt *options;
      };
      
    +-/*
    ++/**
    +  * Returns the path to the hook file, or NULL if the hook is missing
    +  * or disabled. Note that this points to static storage that will be
    +  * overwritten by further calls to find_hook and run_hook_*.
 3:  19d41e85e1 !  3:  b2ab0d3736 hook: add "git hook list" command
    @@ Documentation/git-hook.adoc: Any positional arguments to the hook should be pass
     
      ## builtin/hook.c ##
     @@
    - #include "hook.h"
    - #include "parse-options.h"
    - #include "strvec.h"
    -+#include "abspath.h"
      
      #define BUILTIN_HOOK_RUN_USAGE \
      	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
     +	 * arguments later they probably should be caught by parse_options.
     +	 */
     +	if (argc != 1)
    -+		usage_msg_opt(_("You must specify a hook event name to list."),
    ++		usage_msg_opt(_("you must specify a hook event name to list."),
     +			      builtin_hook_list_usage, list_options);
     +
     +	hookname = argv[0];
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
     +	head = list_hooks(repo, hookname, NULL);
     +
     +	if (!head->nr) {
    -+		warning(_("No hooks found for event '%s'"), hookname);
    ++		warning(_("no hooks found for event '%s'"), hookname);
     +		ret = 1; /* no hooks found */
     +		goto cleanup;
     +	}
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
     +	}
     +
     +cleanup:
    -+	hook_list_clear(head, NULL);
    ++	string_list_clear_func(head, hook_free);
     +	free(head);
     +	return ret;
     +}
    @@ builtin/hook.c: int cmd_hook(int argc,
      
     
      ## hook.c ##
    -@@ hook.c: static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
    - 	free(h);
    +@@ hook.c: const char *find_hook(struct repository *r, const char *name)
    + 	return path.buf;
      }
      
    --static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
    -+void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
    +-/*
    +- * Frees a struct hook stored as the util pointer of a string_list_item.
    +- * Suitable for use as a string_list_clear_func_t callback.
    +- */
    +-static void hook_free(void *p, const char *str UNUSED)
    ++void hook_free(void *p, const char *str UNUSED)
      {
    - 	struct string_list_item *item;
    + 	struct hook *h = p;
      
     @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hookname,
      	string_list_append(hook_list, hook_path)->util = h;
    @@ hook.h: struct hook_cb_data {
      	struct run_hooks_opt *options;
      };
      
    --/*
    ++/**
    ++ * Frees a struct hook stored as the util pointer of a string_list_item.
    ++ * Suitable for use as a string_list_clear_func_t callback.
    ++ */
    ++void hook_free(void *p, const char *str);
    ++
     +/**
     + * Provides a list of hook commands to run for the 'hookname' event.
     + *
    @@ hook.h: struct hook_cb_data {
     +struct string_list *list_hooks(struct repository *r, const char *hookname,
     +			       struct run_hooks_opt *options);
     +
    -+/**
    -+ * Frees the memory allocated for the hook list, including the `struct hook`
    -+ * items and their internal state.
    -+ */
    -+void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
    -+
    -+/**
    + /**
       * Returns the path to the hook file, or NULL if the hook is missing
       * or disabled. Note that this points to static storage that will be
    -  * overwritten by further calls to find_hook and run_hook_*.
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'git hook usage' '
    @@ t/t1800-hook.sh: test_expect_success 'git hook usage' '
      
     +test_expect_success 'git hook list: nonexistent hook' '
     +	cat >stderr.expect <<-\EOF &&
    -+	warning: No hooks found for event '\''test-hook'\''
    ++	warning: no hooks found for event '\''test-hook'\''
     +	EOF
     +	test_expect_code 1 git hook list test-hook 2>stderr.actual &&
     +	test_cmp stderr.expect stderr.actual
 -:  ---------- >  4:  818bee4066 string-list: add unsorted_string_list_remove()
 4:  0c98b18bf5 !  5:  1ed0264a9f hook: include hooks from the config
    @@ Commit message
         "hook.<friendly-name>.command = <path-to-hook>" and
         "hook.<friendly-name>.event = <hook-event>" lines.
     
    -    Hooks will be started in config order of the "hook.<name>.event"
    +    Hooks will be started in config order of the "hook.<friendly-name>.event"
         lines and will be run sequentially (.jobs == 1) like before.
         Running the hooks in parallel will be enabled in a future patch.
     
    @@ Commit message
     
      ## Documentation/config/hook.adoc (new) ##
     @@
    -+hook.<name>.command::
    -+	The command to execute for `hook.<name>`. `<name>` is a unique
    ++hook.<friendly-name>.command::
    ++	The command to execute for `hook.<friendly-name>`. `<friendly-name>` is a unique
     +	"friendly" name that identifies this hook. (The hook events that
    -+	trigger the command are configured with `hook.<name>.event`.) The
    ++	trigger the command are configured with `hook.<friendly-name>.event`.) The
     +	value can be an executable path or a shell oneliner. If more than
    -+	one value is specified for the same `<name>`, only the last value
    ++	one value is specified for the same `<friendly-name>`, only the last value
     +	parsed is used. See linkgit:git-hook[1].
     +
    -+hook.<name>.event::
    -+	The hook events that trigger `hook.<name>`. The value is the name
    ++hook.<friendly-name>.event::
    ++	The hook events that trigger `hook.<friendly-name>`. The value is the name
     +	of a hook event, like "pre-commit" or "update". (See
     +	linkgit:githooks[5] for a complete list of hook events.) On the
    -+	specified event, the associated `hook.<name>.command` is executed.
    -+	This is a multi-valued key. To run `hook.<name>` on multiple
    ++	specified event, the associated `hook.<friendly-name>.command` is executed.
    ++	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
     +	events, specify the key more than once. See linkgit:git-hook[1].
     
      ## Documentation/git-hook.adoc ##
    @@ Documentation/git-hook.adoc: DESCRIPTION
     +message (during the `commit-msg` hook event).
     +
     +Commands are run in the order Git encounters their associated
    -+`hook.<name>.event` configs during the configuration parse (see
    ++`hook.<friendly-name>.event` configs during the configuration parse (see
     +linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
     +added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
     +to determine which command to run.
    @@ Documentation/git-hook.adoc: DESCRIPTION
     +would evaluate the output of each when deciding whether to proceed with the
     +commit.
     +
    -+For a full list of hook events which you can set your `hook.<name>.event` to,
    ++For a full list of hook events which you can set your `hook.<friendly-name>.event` to,
     +and how hooks are invoked during those events, see linkgit:githooks[5].
     +
    -+Git will ignore any `hook.<name>.event` that specifies an event it doesn't
    ++Git will ignore any `hook.<friendly-name>.event` that specifies an event it doesn't
     +recognize. This is intended so that tools which wrap Git can use the hook
     +infrastructure to run their own hooks; see "WRAPPERS" for more guidance.
     +
    @@ hook.c
      #include "environment.h"
      #include "setup.h"
      
    -@@ hook.c: static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
    +@@ hook.c: void hook_free(void *p, const char *str UNUSED)
    + 	if (!h)
    + 		return;
      
    - 	if (h->kind == HOOK_TRADITIONAL)
    +-	if (h->kind == HOOK_TRADITIONAL)
    ++	if (h->kind == HOOK_TRADITIONAL) {
      		free((void *)h->u.traditional.path);
    -+	else if (h->kind == HOOK_CONFIGURED) {
    ++	} else if (h->kind == HOOK_CONFIGURED) {
     +		free((void *)h->u.configured.friendly_name);
     +		free((void *)h->u.configured.command);
     +	}
      
    - 	if (cb_data_free)
    - 		cb_data_free(h->feed_pipe_cb_data);
    + 	if (h->data_free)
    + 		h->data_free(h->feed_pipe_cb_data);
     @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hookname,
      	string_list_append(hook_list, hook_path)->util = h;
      }
      
    -+static void unsorted_string_list_remove(struct string_list *list,
    -+					const char *str)
    -+{
    -+	struct string_list_item *item = unsorted_string_list_lookup(list, str);
    -+	if (item)
    -+		unsorted_string_list_delete_item(list, item - list->items, 0);
    -+}
    -+
     +/*
     + * Callback struct to collect all hook.* keys in a single config pass.
     + * commands: friendly-name to command map.
     + * event_hooks: event-name to list of friendly-names map.
    -+ * disabled_hooks: set of friendly-names with hook.name.enabled = false.
     + */
     +struct hook_all_config_cb {
     +	struct strmap commands;
     +	struct strmap event_hooks;
    -+	struct string_list disabled_hooks;
     +};
     +
     +/* repo_config() callback that collects all hook.* configuration in one pass. */
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +		}
     +
     +		/* Re-insert if necessary to preserve last-seen order. */
    -+		unsorted_string_list_remove(hooks, hook_name);
    ++		unsorted_string_list_remove(hooks, hook_name, 0);
     +		string_list_append(hooks, hook_name);
     +	} else if (!strcmp(subkey, "command")) {
     +		/* Store command overwriting the old value */
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +
     +	strmap_init(&cb_data.commands);
     +	strmap_init(&cb_data.event_hooks);
    -+	string_list_init_dup(&cb_data.disabled_hooks);
     +
     +	/* Parse all configs in one run. */
     +	repo_config(r, hook_config_lookup_all, &cb_data);
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +	/* Construct the cache from parsed configs. */
     +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
     +		struct string_list *hook_names = e->value;
    -+		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
    ++		struct string_list *hooks;
    ++		CALLOC_ARRAY(hooks, 1);
     +
     +		string_list_init_dup(hooks);
     +
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +	}
     +
     +	strmap_clear(&cb_data.commands, 1);
    -+	string_list_clear(&cb_data.disabled_hooks, 0);
     +	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
     +		string_list_clear(e->value, 0);
     +		free(e->value);
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +		 * it just once on the first call.
     +		 */
     +		if (!r->hook_config_cache) {
    -+			r->hook_config_cache = xcalloc(1, sizeof(*cache));
    ++			CALLOC_ARRAY(r->hook_config_cache, 1);
     +			strmap_init(r->hook_config_cache);
     +			build_hook_config_map(r, r->hook_config_cache);
     +		}
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
     +	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
     +		const char *friendly_name = configured_hooks->items[i].string;
     +		const char *command = configured_hooks->items[i].util;
    -+		struct hook *hook = xcalloc(1, sizeof(struct hook));
    ++		struct hook *hook;
    ++		CALLOC_ARRAY(hook, 1);
     +
     +		if (options && options->feed_pipe_cb_data_alloc)
     +			hook->feed_pipe_cb_data =
     +				options->feed_pipe_cb_data_alloc(
     +					options->feed_pipe_ctx);
    ++		if (options)
    ++			hook->data_free = options->feed_pipe_cb_data_free;
     +
     +		hook->kind = HOOK_CONFIGURED;
     +		hook->u.configured.friendly_name = xstrdup(friendly_name);
    @@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hoo
      			       struct run_hooks_opt *options)
      {
     @@ hook.c: struct string_list *list_hooks(struct repository *r, const char *hookname,
    - 	hook_head = xmalloc(sizeof(struct string_list));
    + 	CALLOC_ARRAY(hook_head, 1);
      	string_list_init_dup(hook_head);
      
     +	/* Add hooks from the config, e.g. hook.myhook.event = pre-commit */
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      
      	/* Add hook exec paths or commands */
     -	if (h->kind == HOOK_TRADITIONAL)
    -+	if (h->kind == HOOK_TRADITIONAL) {
    ++	switch (h->kind) {
    ++	case HOOK_TRADITIONAL:
      		strvec_push(&cp->args, h->u.traditional.path);
    -+	} else if (h->kind == HOOK_CONFIGURED) {
    +-	else
    ++		break;
    ++	case HOOK_CONFIGURED:
     +		/* to enable oneliners, let config-specified hooks run in shell. */
     +		cp->use_shell = true;
     +		strvec_push(&cp->args, h->u.configured.command);
    ++		break;
    ++	default:
    + 		BUG("unknown hook kind");
     +	}
      
      	if (!cp->args.nr)
    @@ hook.h
      
      struct repository;
      
    -@@ hook.h: struct repository;
    +@@ hook.h: typedef void *(*hook_data_alloc_fn)(void *init_ctx);
       * Represents a hook command to be run.
       * Hooks can be:
       * 1. "traditional" (found in the hooks directory)
     - * 2. "configured" (defined in Git's configuration, not yet implemented).
    -+ * 2. "configured" (defined in Git's configuration via hook.<name>.event).
    ++ * 2. "configured" (defined in Git's configuration via hook.<friendly-name>.event).
       * The 'kind' field determines which part of the union 'u' is valid.
       */
      struct hook {
    @@ hook.h: struct repository;
      	} u;
      
      	/**
    -@@ hook.h: struct string_list *list_hooks(struct repository *r, const char *hookname,
    -  */
    - void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
    +@@ hook.h: void hook_free(void *p, const char *str);
    + struct string_list *list_hooks(struct repository *r, const char *hookname,
    + 			       struct run_hooks_opt *options);
      
     +/**
     + * Frees the hook configuration cache stored in `struct repository`.
    @@ t/t1800-hook.sh
      test_expect_success 'git hook usage' '
      	test_expect_code 129 git hook &&
      	test_expect_code 129 git hook run &&
    - 	test_expect_code 129 git hook run -h &&
    -+	test_expect_code 129 git hook list -h &&
    - 	test_expect_code 129 git hook run --unknown 2>err &&
    - 	test_expect_code 129 git hook list &&
    - 	test_expect_code 129 git hook list -h &&
     @@ t/t1800-hook.sh: test_expect_success 'git hook list: traditional hook from hookdir' '
      	test_cmp expect actual
      '
    @@ t/t1800-hook.sh: test_expect_success TTY 'git commit: stdout and stderr are conn
     +	test_cmp expected actual
     +'
     +
    ++test_expect_success 'configured hooks run before hookdir hook' '
    ++	setup_hookdir &&
    ++	test_config hook.first.event "pre-commit" &&
    ++	test_config hook.first.command "echo first" &&
    ++	test_config hook.second.event "pre-commit" &&
    ++	test_config hook.second.command "echo second" &&
    ++
    ++	cat >expected <<-\EOF &&
    ++	first
    ++	second
    ++	hook from hookdir
    ++	EOF
    ++
    ++	git hook list pre-commit >actual &&
    ++	test_cmp expected actual &&
    ++
    ++	cat >expected <<-\EOF &&
    ++	first
    ++	second
    ++	"Legacy Hook"
    ++	EOF
    ++
    ++	git hook run pre-commit 2>actual &&
    ++	test_cmp expected actual
    ++'
    ++
     +test_expect_success 'stdin to multiple hooks' '
     +	test_config hook.stdin-a.event "test-hook" &&
     +	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" &&
 5:  f71ada4cb8 !  6:  260b845b9e hook: allow disabling config hooks
    @@ Commit message
         might want to disable them without removing from the config,
         like locally disabling a global hook.
     
    -    Add a hook.<name>.enabled config which defaults to true and
    +    Add a hook.<friendly-name>.enabled config which defaults to true and
         can be optionally set for each configured hook.
     
         Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.event::
    - 	specified event, the associated `hook.<name>.command` is executed.
    - 	This is a multi-valued key. To run `hook.<name>` on multiple
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.event::
    + 	specified event, the associated `hook.<friendly-name>.command` is executed.
    + 	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
      	events, specify the key more than once. See linkgit:git-hook[1].
     +
    -+hook.<name>.enabled::
    -+	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
    ++hook.<friendly-name>.enabled::
    ++	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
     +	Set to `false` to disable the hook without removing its
     +	configuration. This is particularly useful when a hook is defined
     +	in a system or global config file and needs to be disabled for a
     +	specific repository. See linkgit:git-hook[1].
     
      ## hook.c ##
    +@@ hook.c: static void list_hooks_add_default(struct repository *r, const char *hookname,
    +  * Callback struct to collect all hook.* keys in a single config pass.
    +  * commands: friendly-name to command map.
    +  * event_hooks: event-name to list of friendly-names map.
    ++ * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
    +  */
    + struct hook_all_config_cb {
    + 	struct strmap commands;
    + 	struct strmap event_hooks;
    ++	struct string_list disabled_hooks;
    + };
    + 
    + /* repo_config() callback that collects all hook.* configuration in one pass. */
     @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
      		char *old = strmap_put(&data->commands, hook_name,
      				       xstrdup(value));
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
      
      	free(hook_name);
     @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 
    + 	strmap_init(&cb_data.commands);
    + 	strmap_init(&cb_data.event_hooks);
    ++	string_list_init_dup(&cb_data.disabled_hooks);
    + 
    + 	/* Parse all configs in one run. */
    + 	repo_config(r, hook_config_lookup_all, &cb_data);
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
      			const char *hname = hook_names->items[i].string;
      			char *command;
      
    @@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *c
      			command = strmap_get(&cb_data.commands, hname);
      			if (!command)
      				die(_("'hook.%s.command' must be configured or "
    +@@ hook.c: static void build_hook_config_map(struct repository *r, struct strmap *cache)
    + 	}
    + 
    + 	strmap_clear(&cb_data.commands, 1);
    ++	string_list_clear(&cb_data.disabled_hooks, 0);
    + 	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
    + 		string_list_clear(e->value, 0);
    + 		free(e->value);
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'rejects hooks with no commands configured' '
 6:  82a7d6167f !  7:  dcc595751e hook: allow event = "" to overwrite previous values
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.<name>.event::
    +@@ Documentation/config/hook.adoc: hook.<friendly-name>.event::
      	linkgit:githooks[5] for a complete list of hook events.) On the
    - 	specified event, the associated `hook.<name>.command` is executed.
    - 	This is a multi-valued key. To run `hook.<name>` on multiple
    + 	specified event, the associated `hook.<friendly-name>.command` is executed.
    + 	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
     -	events, specify the key more than once. See linkgit:git-hook[1].
     +	events, specify the key more than once. An empty value resets
     +	the list of events, clearing any previously defined events for
    -+	`hook.<name>`. See linkgit:git-hook[1].
    ++	`hook.<friendly-name>`. See linkgit:git-hook[1].
      
    - hook.<name>.enabled::
    - 	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
    + hook.<friendly-name>.enabled::
    + 	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
     
      ## hook.c ##
     @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
     +			struct strmap_entry *e;
     +
     +			strmap_for_each_entry(&data->event_hooks, &iter, e)
    -+				unsorted_string_list_remove(e->value, hook_name);
    ++				unsorted_string_list_remove(e->value, hook_name, 0);
     +		} else {
     +			struct string_list *hooks =
     +				strmap_get(&data->event_hooks, value);
     +
     +			if (!hooks) {
    -+				hooks = xcalloc(1, sizeof(*hooks));
    ++				CALLOC_ARRAY(hooks, 1);
     +				string_list_init_dup(hooks);
     +				strmap_put(&data->event_hooks, value, hooks);
     +			}
    @@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
     -			string_list_init_dup(hooks);
     -			strmap_put(&data->event_hooks, value, hooks);
     +			/* Re-insert if necessary to preserve last-seen order. */
    -+			unsorted_string_list_remove(hooks, hook_name);
    ++			unsorted_string_list_remove(hooks, hook_name, 0);
     +			string_list_append(hooks, hook_name);
      		}
     -
     -		/* Re-insert if necessary to preserve last-seen order. */
    --		unsorted_string_list_remove(hooks, hook_name);
    +-		unsorted_string_list_remove(hooks, hook_name, 0);
     -		string_list_append(hooks, hook_name);
      	} else if (!strcmp(subkey, "command")) {
      		/* Store command overwriting the old value */
      		char *old = strmap_put(&data->commands, hook_name,
    +@@ hook.c: static int hook_config_lookup_all(const char *key, const char *value,
    + 			break;
    + 		case 1: /* enabled: undo a prior disabled entry */
    + 			unsorted_string_list_remove(&data->disabled_hooks,
    +-						    hook_name);
    ++						    hook_name, 0);
    + 			break;
    + 		default:
    + 			break; /* ignore unrecognised values */
     
      ## t/t1800-hook.sh ##
     @@ t/t1800-hook.sh: test_expect_success 'git hook list reorders on duplicate event declarations' '
 7:  8d1704384e !  8:  c668b2fec1 hook: allow out-of-repo 'git hook' invocations
    @@ hook.c: static struct strmap *get_hook_config_cache(struct repository *r)
     +		 * Out-of-repo calls (no gitdir) allocate and return a temporary
     +		 * map cache which gets free'd immediately by the caller.
     +		 */
    -+		cache = xcalloc(1, sizeof(*cache));
    ++		CALLOC_ARRAY(cache, 1);
     +		strmap_init(cache);
     +		build_hook_config_map(r, cache);
      	}
 8:  7bf527c59e =  9:  807116ff79 hook: add -z option to "git hook list"
 -:  ---------- > 10:  57a27ad1d6 hook: refactor hook_config_cache from strmap to named struct
 -:  ---------- > 11:  260300c890 hook: store and display scope for configured hooks in git hook list
 -:  ---------- > 12:  7c79801a63 hook: show disabled hooks in "git hook list"

Adrian Ratiu (9):
  hook: add internal state alloc/free callbacks
  string-list: add unsorted_string_list_remove()
  hook: include hooks from the config
  hook: allow disabling config hooks
  hook: allow event = "" to overwrite previous values
  hook: add -z option to "git hook list"
  hook: refactor hook_config_cache from strmap to named struct
  hook: store and display scope for configured hooks in git hook list
  hook: show disabled hooks in "git hook list"

Emily Shaffer (3):
  hook: run a list of hooks to prepare for multihook support
  hook: add "git hook list" command
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config/hook.adoc |  24 ++
 Documentation/git-hook.adoc    | 142 ++++++++++-
 builtin/hook.c                 |  79 ++++++
 builtin/receive-pack.c         |  36 ++-
 git.c                          |   2 +-
 hook.c                         | 423 ++++++++++++++++++++++++++++++---
 hook.h                         | 127 +++++++++-
 refs.c                         |  25 +-
 repository.c                   |   6 +
 repository.h                   |   7 +
 string-list.c                  |   9 +
 string-list.h                  |   8 +
 t/t1800-hook.sh                | 315 +++++++++++++++++++++++-
 transport.c                    |  28 ++-
 14 files changed, 1168 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/config/hook.adoc

-- 
2.52.0.732.gb351b5166d.dirty

