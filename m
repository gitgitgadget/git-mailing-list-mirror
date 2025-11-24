Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7C299A84
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004904; cv=pass; b=R0gw0WyZ+uRcKQQXqgVAtjaPmusCwN58PDpGPOq6vu1cxdW71cAOPSBLj7pj6aLc8o7s6AlCKP8LPFEjZdsNZFTERoGTkeyBOhcQEGGcXZEk37z2e4r0fhoUL1mHwXrY3BLLm45oZ3S1tDunIQjeHKUYn7Z6JNBtQhizy9M6EgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004904; c=relaxed/simple;
	bh=kzJUqN54agUJddH67j3/pENo447CEWbYzXLrm1FQ0K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3nzYmNcOqAySrgdtuOlVa/NVuW6pTI+PMe2OGY721vBHDyHQ/0cKkVnpO4opPk1UlurPd8jGKt5oCtnn0qQJx75uZtaUBNh5L5ZgLL8gOjXAaPDONjNBgct70mhXi1d6/7azuGcrWJdrd3Rqg3CnUV9dSnNUZo1SdTBdSfYE70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bvjOMyXb; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bvjOMyXb"
ARC-Seal: i=1; a=rsa-sha256; t=1764004887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LqDLNpDfNi8DU+hwaDWNkGFLW1oXBj97ySXvEAz0e9w5nRhmOTRPoD7Fal3euu2Fzfo6m8JV8eTOWZiRCAm+DXb02vsPYzsH1mrEk2gxFkSA+lpmUO2z8XpndLZfctC4zT6W405fbrz3BYWVqgoV6+TAglSTk8xhXPh7HN6SBdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004887; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=elgfVfSxtRGpzkvhQsjtTm2yhDX+5eIDz27XLYOwWnM=; 
	b=ZwoHnVLurya0h+i16MV9lBv3+S13ttQFMSRXZeakr8VAyFi+fqQt0o556zAWIOsoLsFkATFKcVhmGHfhjAbdlRODRwJjjvZ/6NriA6BXgYj0CoE8ABwlOnouKjP8UJOZk0Jml0SuEZjVpzP4jMdLYNDl8TvMh0Drd89vkeavKJE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004887;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=elgfVfSxtRGpzkvhQsjtTm2yhDX+5eIDz27XLYOwWnM=;
	b=bvjOMyXbVGSeF9dZdoqOm9J5IihRU4EQNdv8O3x9cMH1BbAf/0npAsJPrFNB/hK5
	ik9Gxjr2pZtEA9BooTuK1GYW8xygUIRdvophppC+X768DxLi317s5fTvi5ytX1D8ehg
	uO7GQCcHCJQmLAGV7XPOU1Tn3aVVi4v8brL/157A=
Received: by mx.zohomail.com with SMTPS id 1764004886427135.9579495638202;
	Mon, 24 Nov 2025 09:21:26 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 10/10] receive-pack: convert receive hooks to hook API
Date: Mon, 24 Nov 2025 19:20:43 +0200
Message-ID: <20251124172043.1650014-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124172043.1650014-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

This converts the last remaining hooks to the new hook API, for
the same benefits as the previous conversions (no need to toggle
signals, manage custom struct child_process, call find_hook(),
prepares for specifyinig hooks via configs, etc.).

I noticed a performance degradation when processing large amounts
of hook input with just 1 line per callback, due to run-command's
poll loop, therefore I batched 500 lines per callback, to ensure
similar pipe throughput as before and to avoid hook child waiting
on stdin.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 221 ++++++++++++++++++-----------------------
 1 file changed, 99 insertions(+), 122 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d95df748cd..be8a270a43 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -748,7 +748,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -774,23 +774,23 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(sigcheck.payload);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT=%s",
 			     oid_to_hex(&push_cert_oid));
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_SIGNER=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_SIGNER=%s",
 			     sigcheck.signer ? sigcheck.signer : "");
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_KEY=%s",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_KEY=%s",
 			     sigcheck.key ? sigcheck.key : "");
-		strvec_pushf(&proc->env, "GIT_PUSH_CERT_STATUS=%c",
+		strvec_pushf(&opt->env, "GIT_PUSH_CERT_STATUS=%c",
 			     sigcheck.result);
 		if (push_cert_nonce) {
-			strvec_pushf(&proc->env,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE=%s",
 				     push_cert_nonce);
-			strvec_pushf(&proc->env,
+			strvec_pushf(&opt->env,
 				     "GIT_PUSH_CERT_NONCE_STATUS=%s",
 				     nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				strvec_pushf(&proc->env,
+				strvec_pushf(&opt->env,
 					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 					     nonce_stamp_slop);
 		}
@@ -802,119 +802,71 @@ struct receive_hook_feed_state {
 	struct ref_push_report *report;
 	int skip_broken;
 	struct strbuf buf;
-	const struct string_list *push_options;
 };
 
-typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
-			     struct receive_hook_feed_state *feed_state)
+static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct async muxer;
-	int code;
-	const char *hook_path = find_hook(the_repository, hook_name);
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct receive_hook_feed_state *state = hook_cb->options->feed_pipe_cb_data;
+	struct command *cmd = state->cmd;
+	unsigned int lines_batch_size = 500;
 
-	if (!hook_path)
-		return 0;
+	strbuf_reset(&state->buf);
 
-	strvec_push(&proc.args, hook_path);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = hook_name;
-
-	if (feed_state->push_options) {
-		size_t i;
-		for (i = 0; i < feed_state->push_options->nr; i++)
-			strvec_pushf(&proc.env,
-				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
-				     (uintmax_t)i,
-				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
-			     (uintmax_t)feed_state->push_options->nr);
-	} else
-		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
+	/* batch lines to avoid going through run-command's poll loop for each line */
+	for (unsigned int i = 0; i < lines_batch_size; i++) {
+		while (cmd &&
+		       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
+			cmd = cmd->next;
 
-	if (tmp_objdir)
-		strvec_pushv(&proc.env, tmp_objdir_env(tmp_objdir));
+		if (!cmd)
+			break;  /* no more commands left */
 
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		code = start_async(&muxer);
-		if (code)
-			return code;
-		proc.err = muxer.in;
-	}
+		if (!state->report)
+			state->report = cmd->report;
 
-	prepare_push_cert_sha1(&proc);
+		if (state->report) {
+			struct object_id *old_oid;
+			struct object_id *new_oid;
+			const char *ref_name;
 
-	code = start_command(&proc);
-	if (code) {
-		if (use_sideband)
-			finish_async(&muxer);
-		return code;
-	}
+			old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
+			new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
+			ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
 
-	sigchain_push(SIGPIPE, SIG_IGN);
+			strbuf_addf(&state->buf, "%s %s %s\n",
+				    oid_to_hex(old_oid), oid_to_hex(new_oid),
+				    ref_name);
 
-	while (1) {
-		const char *buf;
-		size_t n;
-		if (feed(feed_state, &buf, &n))
-			break;
-		if (write_in_full(proc.in, buf, n) < 0)
-			break;
+			state->report = state->report->next;
+			if (!state->report)
+				cmd = cmd->next;
+		} else {
+			strbuf_addf(&state->buf, "%s %s %s\n",
+				    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
+				    cmd->ref_name);
+			cmd = cmd->next;
+		}
 	}
-	close(proc.in);
-	if (use_sideband)
-		finish_async(&muxer);
 
-	sigchain_pop(SIGPIPE);
+	state->cmd = cmd;
 
-	return finish_command(&proc);
+	if (state->buf.len > 0) {
+		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
+		if (ret < 0) {
+			if (errno == EPIPE)
+				return 1; /* child closed pipe */
+			return ret;
+		}
+	}
+
+	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
-static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
 {
-	struct receive_hook_feed_state *state = state_;
-	struct command *cmd = state->cmd;
-
-	while (cmd &&
-	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
-		cmd = cmd->next;
-	if (!cmd)
-		return -1; /* EOF */
-	if (!bufp)
-		return 0; /* OK, can feed something. */
-	strbuf_reset(&state->buf);
-	if (!state->report)
-		state->report = cmd->report;
-	if (state->report) {
-		struct object_id *old_oid;
-		struct object_id *new_oid;
-		const char *ref_name;
-
-		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
-		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
-		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
-		strbuf_addf(&state->buf, "%s %s %s\n",
-			    oid_to_hex(old_oid), oid_to_hex(new_oid),
-			    ref_name);
-		state->report = state->report->next;
-		if (!state->report)
-			state->cmd = cmd->next;
-	} else {
-		strbuf_addf(&state->buf, "%s %s %s\n",
-			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
-			    cmd->ref_name);
-		state->cmd = cmd->next;
-	}
-	if (bufp) {
-		*bufp = state->buf.buf;
-		*sizep = state->buf.len;
-	}
-	return 0;
+	if (output && output->len)
+		send_sideband(1, 2, output->buf, output->len, use_sideband);
 }
 
 static int run_receive_hook(struct command *commands,
@@ -922,26 +874,51 @@ static int run_receive_hook(struct command *commands,
 			    int skip_broken,
 			    const struct string_list *push_options)
 {
-	struct receive_hook_feed_state state;
-	int status;
-
-	strbuf_init(&state.buf, 0);
-	state.cmd = commands;
-	state.skip_broken = skip_broken;
-	state.report = NULL;
-	if (feed_receive_hook(&state, NULL, NULL))
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct command *iter = commands;
+	struct receive_hook_feed_state *feed_state;
+	int ret;
+
+	/* if there are no valid commands, don't invoke the hook at all. */
+	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
+		iter = iter->next;
+	if (!iter)
 		return 0;
-	state.cmd = commands;
-	state.push_options = push_options;
-	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
-	strbuf_release(&state.buf);
-	return status;
-}
 
-static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
-{
-	if (output && output->len)
-		send_sideband(1, 2, output->buf, output->len, use_sideband);
+	if (push_options) {
+		int i;
+		for (i = 0; i < push_options->nr; i++)
+			strvec_pushf(&opt.env, "GIT_PUSH_OPTION_%d=%s", i,
+				     push_options->items[i].string);
+		strvec_pushf(&opt.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
+					     (uintmax_t)push_options->nr);
+	} else
+		strvec_push(&opt.env, "GIT_PUSH_OPTION_COUNT");
+
+	if (tmp_objdir)
+		strvec_pushv(&opt.env, tmp_objdir_env(tmp_objdir));
+
+	prepare_push_cert_sha1(&opt);
+
+	/* set up sideband printer */
+	if (use_sideband)
+		opt.consume_output = hook_output_to_sideband;
+
+	/* set up stdin callback */
+	feed_state = xmalloc(sizeof(struct receive_hook_feed_state));
+	feed_state->cmd = commands;
+	feed_state->skip_broken = skip_broken;
+	feed_state->report = NULL;
+	strbuf_init(&feed_state->buf, 0);
+	opt.feed_pipe_cb_data = feed_state;
+	opt.feed_pipe = feed_receive_hook_cb;
+
+	ret = run_hooks_opt(the_repository, hook_name, &opt);
+
+	strbuf_release(&feed_state->buf);
+	FREE_AND_NULL(opt.feed_pipe_cb_data);
+
+	return ret;
 }
 
 static int run_update_hook(struct command *cmd)
-- 
2.51.0

