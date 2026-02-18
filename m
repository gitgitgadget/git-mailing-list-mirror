Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F933507C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453469; cv=pass; b=tfTBzy9dx2FkU6AX0J0ZGILG9Hh81QRlh4oKHMbkFh+7hagHsXgPOS7+w2Nw2EK9qB8gE6el7PLcQR0ybJeIrlZgM9UN+76N2fUDdUv2HOy9olsKoGVh5apNt9L0p5Rpo/ZB6OALEeeMJralx5oBSAWZTH8ud8S/3kbJS8ysHuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453469; c=relaxed/simple;
	bh=/EgxHK6UPN2hR0zKHpe9u2JZFSDA0c5x00Bc+LAmYGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLrH2iqgPO9+7LXxRDhgkdl5LhhALQmHpnW48HKTd+gAQ411znGOD00DkLL1pKG6Dp+cGyioZ+KiPNL/fUDYHNv0cb8ryWzHsMt7meT38gWr54OtXT9aNpapph/x1BF9XzhHMQjogbW5GjedcpjDH63Rgji8tPl19onC/KakkmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VtT9gZhN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VtT9gZhN"
ARC-Seal: i=1; a=rsa-sha256; t=1771453450; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V1IKyIV6Asjy/OzCTtvHmFiPXMf5eFMZR3Tgc7/RQEzXU/UP+pOp3shxDS2nbeZD9eBS+4hvl/SMf2JckKUUDTUESHkBiAn9JX+s9Zj1XDOWSl6VYvhkU8BdCZ8IXxso3QqzKgz9yetIHBSGsq/e+zZh4mazlfTwDwRplERNXOQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453450; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rZtEaB5Qq5AUSZ2ags9BSlXVu276+xSUknzV7ba6KRA=; 
	b=KLsX1PsDx4arjEkb18fH/TlyOLerMmJAzXgK9X5K3VeJKBCFE2ph2NrnGvJNC2Me7slTorU5EENooSUeakVaXTYOAji1jXdDteVtYV46pJqxwn9x7bIjcLL2a8I3kfXfY3tA2WHK+0zQHie96K73xiAEaoEtLiZgMuXcRllJcfs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453450;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rZtEaB5Qq5AUSZ2ags9BSlXVu276+xSUknzV7ba6KRA=;
	b=VtT9gZhNrThl7Y8TXaJelzJdzmFlKlns3ex6Di8omH6r/qXVy0aiNUq+Tfx/KMJ7
	0EoS5ek33d3g/bMJ+Zpmpa7Kqm+OCMSVppBDwwW5ot5dqsF2t7uBwe4b0Ej6IIso1as
	op0XrjBBuNv/hwZ47i72VuoI3QWn0FFxypIx24dA=
Received: by mx.zohomail.com with SMTPS id 1771453449040907.6039564970638;
	Wed, 18 Feb 2026 14:24:09 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 1/8] hook: add internal state alloc/free callbacks
Date: Thu, 19 Feb 2026 00:23:45 +0200
Message-ID: <20260218222352.55393-2-adrian.ratiu@collabora.com>
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

Some hooks use opaque structs to keep internal state between callbacks.

Because hooks ran sequentially (jobs == 1) with one command per hook,
these internal states could be allocated on the stack for each hook run.

Next commits add the ability to run multiple commands for each hook, so
the states cannot be shared or stored on the stack anymore, especially
since down the line we will also enable parallel execution (jobs > 1).

Add alloc/free helpers for each hook, doing a "deep" alloc/init & free
of their internal opaque struct.

The alloc callback takes a context pointer, to initialize the struct at
at the time of resource acquisition.

These callbacks must always be provided together: no alloc without free
and no free without alloc, otherwise a BUG() is triggered.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 33 ++++++++++++++++++++++++++-------
 hook.c                 | 13 +++++++++++++
 hook.h                 | 25 ++++++++++++++++++++++++-
 refs.c                 | 24 +++++++++++++++++++-----
 transport.c            | 27 ++++++++++++++++++++-------
 5 files changed, 102 insertions(+), 20 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2d2b33d73d..f23772bc56 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -901,6 +901,26 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
 	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
+static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
+{
+	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
+	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
+	data->report = init_state->report;
+	data->cmd = init_state->cmd;
+	data->skip_broken = init_state->skip_broken;
+	strbuf_init(&data->buf, 0);
+	return data;
+}
+
+static void receive_hook_feed_state_free(void *data)
+{
+	struct receive_hook_feed_state *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
@@ -908,7 +928,7 @@ static int run_receive_hook(struct command *commands,
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	struct command *iter = commands;
-	struct receive_hook_feed_state feed_state;
+	struct receive_hook_feed_state feed_init_state = { 0 };
 	struct async sideband_async;
 	int sideband_async_started = 0;
 	int saved_stderr = -1;
@@ -938,16 +958,15 @@ static int run_receive_hook(struct command *commands,
 	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
 	/* set up stdin callback */
-	feed_state.cmd = commands;
-	feed_state.skip_broken = skip_broken;
-	feed_state.report = NULL;
-	strbuf_init(&feed_state.buf, 0);
-	opt.feed_pipe_cb_data = &feed_state;
+	feed_init_state.cmd = commands;
+	feed_init_state.skip_broken = skip_broken;
+	opt.feed_pipe_ctx = &feed_init_state;
 	opt.feed_pipe = feed_receive_hook_cb;
+	opt.feed_pipe_cb_data_alloc = receive_hook_feed_state_alloc;
+	opt.feed_pipe_cb_data_free = receive_hook_feed_state_free;
 
 	ret = run_hooks_opt(the_repository, hook_name, &opt);
 
-	strbuf_release(&feed_state.buf);
 	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
 
 	return ret;
diff --git a/hook.c b/hook.c
index cde7198412..83ff658866 100644
--- a/hook.c
+++ b/hook.c
@@ -133,6 +133,8 @@ static int notify_hook_finished(int result,
 
 static void run_hooks_opt_clear(struct run_hooks_opt *options)
 {
+	if (options->feed_pipe_cb_data_free)
+		options->feed_pipe_cb_data_free(options->feed_pipe_cb_data);
 	strvec_clear(&options->env);
 	strvec_clear(&options->args);
 }
@@ -172,6 +174,17 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options->jobs)
 		BUG("run_hooks_opt must be called with options.jobs >= 1");
 
+	/*
+	 * Ensure cb_data copy and free functions are either provided together,
+	 * or neither one is provided.
+	 */
+	if ((options->feed_pipe_cb_data_alloc && !options->feed_pipe_cb_data_free) ||
+	    (!options->feed_pipe_cb_data_alloc && options->feed_pipe_cb_data_free))
+		BUG("feed_pipe_cb_data_alloc and feed_pipe_cb_data_free must be set together");
+
+	if (options->feed_pipe_cb_data_alloc)
+		options->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 20eb56fd63..a6bdc6f90f 100644
--- a/hook.h
+++ b/hook.h
@@ -5,6 +5,9 @@
 
 struct repository;
 
+typedef void (*cb_data_free_fn)(void *data);
+typedef void *(*cb_data_alloc_fn)(void *init_ctx);
+
 struct run_hooks_opt
 {
 	/* Environment vars to be set for each hook */
@@ -88,10 +91,30 @@ struct run_hooks_opt
 	 * It can be accessed directly via the third callback arg 'pp_task_cb':
 	 * struct ... *state = pp_task_cb;
 	 *
-	 * The caller is responsible for managing the memory for this data.
+	 * The caller is responsible for managing the memory for this data by
+	 * providing alloc/free callbacks to `run_hooks_opt`.
+	 *
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/**
+	 * Some hooks need to create a fresh `feed_pipe_cb_data` internal state,
+	 * so they can keep track of progress without affecting one another.
+	 *
+	 * If provided, this function will be called to alloc & initialize the
+	 * `feed_pipe_cb_data` for each hook.
+	 *
+	 * The `feed_pipe_ctx` pointer can be used to pass initialization data.
+	 */
+	cb_data_alloc_fn feed_pipe_cb_data_alloc;
+
+	/**
+	 * Called to free the memory initialized by `feed_pipe_cb_data_alloc`.
+	 *
+	 * Must always be provided when `feed_pipe_cb_data_alloc` is provided.
+	 */
+	cb_data_free_fn feed_pipe_cb_data_free;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
diff --git a/refs.c b/refs.c
index d432cfb78f..3c124fab29 100644
--- a/refs.c
+++ b/refs.c
@@ -2514,24 +2514,38 @@ static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_
 	return 0; /* no more input to feed */
 }
 
+static void *transaction_feed_cb_data_alloc(void *feed_pipe_ctx UNUSED)
+{
+	struct transaction_feed_cb_data *data = xmalloc(sizeof(*data));
+	strbuf_init(&data->buf, 0);
+	data->index = 0;
+	return data;
+}
+
+static void transaction_feed_cb_data_free(void *data)
+{
+	struct transaction_feed_cb_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_transaction_hook(struct ref_transaction *transaction,
 				const char *state)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-	struct transaction_feed_cb_data feed_ctx = { 0 };
 	int ret = 0;
 
 	strvec_push(&opt.args, state);
 
 	opt.feed_pipe = transaction_hook_feed_stdin;
 	opt.feed_pipe_ctx = transaction;
-	opt.feed_pipe_cb_data = &feed_ctx;
-
-	strbuf_init(&feed_ctx.buf, 0);
+	opt.feed_pipe_cb_data_alloc = transaction_feed_cb_data_alloc;
+	opt.feed_pipe_cb_data_free = transaction_feed_cb_data_free;
 
 	ret = run_hooks_opt(transaction->ref_store->repo, "reference-transaction", &opt);
 
-	strbuf_release(&feed_ctx.buf);
 	return ret;
 }
 
diff --git a/transport.c b/transport.c
index ecf9e1f21c..1581aa0886 100644
--- a/transport.c
+++ b/transport.c
@@ -1357,21 +1357,36 @@ static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void
 	return 0;
 }
 
+static void *pre_push_hook_data_alloc(void *feed_pipe_ctx)
+{
+	struct feed_pre_push_hook_data *data = xmalloc(sizeof(*data));
+	strbuf_init(&data->buf, 0);
+	data->refs = (struct ref *)feed_pipe_ctx;
+	return data;
+}
+
+static void pre_push_hook_data_free(void *data)
+{
+	struct feed_pre_push_hook_data *d = data;
+	if (!d)
+		return;
+	strbuf_release(&d->buf);
+	free(d);
+}
+
 static int run_pre_push_hook(struct transport *transport,
 			     struct ref *remote_refs)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-	struct feed_pre_push_hook_data data;
 	int ret = 0;
 
 	strvec_push(&opt.args, transport->remote->name);
 	strvec_push(&opt.args, transport->url);
 
-	strbuf_init(&data.buf, 0);
-	data.refs = remote_refs;
-
 	opt.feed_pipe = pre_push_hook_feed_stdin;
-	opt.feed_pipe_cb_data = &data;
+	opt.feed_pipe_ctx = remote_refs;
+	opt.feed_pipe_cb_data_alloc = pre_push_hook_data_alloc;
+	opt.feed_pipe_cb_data_free = pre_push_hook_data_free;
 
 	/*
 	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
@@ -1381,8 +1396,6 @@ static int run_pre_push_hook(struct transport *transport,
 
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-	strbuf_release(&data.buf);
-
 	return ret;
 }
 
-- 
2.52.0.732.gb351b5166d.dirty

