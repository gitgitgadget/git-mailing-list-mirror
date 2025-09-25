Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E331326C
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758823411; cv=pass; b=ssBydqTLt2r/V4zrV+HhsSRXSTNyWTitBh/EOlpG4SS8tmc1VpF+st1wDozCt4nkzcIv7TCP1+YivGP0hi2EqnpwK/JDDTzl82zBvS3Pqt3qt2LBnVOfeI8SS0Xm+e1nKeAIQejMjQCg7LAucXFC40QaG+ze3CpR1YDM7VrVcvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758823411; c=relaxed/simple;
	bh=heMEBA7yc8I2Bd3mhW0Qe43mVxnTtjjIT5ajtkrPs20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gD+4u2PExxJBN9sSIT+E7MRXarxG0imedcuKrPt8E0wJosk44n5/70+OwvL7VVQn0vFCLAWFaHzgr/eBBsauCymqlhaBgPm02R5bfKuyNJLdOAoKHEbzQ4EaXPv5EX9J7Qr04jltz6E+G2wvqzi+PJKdWhqd1G/2r4IWMjjKD3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fUBS7ZJr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fUBS7ZJr"
ARC-Seal: i=1; a=rsa-sha256; t=1758823397; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AKWFdWYIUySQhOLtK3QcxfzdF3qrQjjAdS99R4XHxgnuxobD23JNQ8b0/X52bkRPekrpZM3AfOzIBGSxum9F6W0u7q5VfBPGzP2uJ8zS4GS2Fj0qiDwnibFrT7Siyepd90yrti3Z5e6PVOJ1lHIojNAecoX5HfoEMadt4xscqLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758823397; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7Nu7EL0Bjc8H4KKoMfh3gwmy+JcYsym+EbH1mHhAMsY=; 
	b=J6eCqxrUfGna5t8TFaTHiABnbvRCxSvrc1uEtbfMtB1WdGRQ29b2RSsigH1UYwJd8VeJpLEoDwcfXeoHpgl1b2exH430G5Cezq6HEEm/CHxBPWjFuD6BwAti60nUQAjo4MO/FMU1CFwUHQlJnx1OPifyNvfgaZk2ruTcKWAqBEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758823397;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7Nu7EL0Bjc8H4KKoMfh3gwmy+JcYsym+EbH1mHhAMsY=;
	b=fUBS7ZJrsKV4vaLr9uiD3yxMqLdOunfqRjRT21Z4sEGF0ChWPywz87LBt+V4VyTK
	K+mfLq68LDVP0g2oi7FMI70GWYoi7DH8p0QdJIv3yHetPQihdiD99wVnjL/rdXumeCs
	q/OVb+W7Iyh5Bi1C4A/L0BD93eWSLffL/pXqnKYI=
Received: by mx.zohomail.com with SMTPS id 175882339373147.90313334624227;
	Thu, 25 Sep 2025 11:03:13 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 10/10] receive-pack: convert receive hooks to hook.h
Date: Thu, 25 Sep 2025 21:02:57 +0300
Message-ID: <20250925180257.13844-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 243 +++++++++++++++++++++--------------------
 1 file changed, 122 insertions(+), 121 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 78d4df349e..5e5ce34371 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -749,7 +749,7 @@ static int check_cert_push_options(const struct string_list *push_options)
 	return retval;
 }
 
-static void prepare_push_cert_sha1(struct child_process *proc)
+static void prepare_push_cert_sha1(struct run_hooks_opt *opt)
 {
 	static int already_done;
 
@@ -775,168 +775,126 @@ static void prepare_push_cert_sha1(struct child_process *proc)
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
 	}
 }
 
+struct receive_hook_feed_context {
+	struct command *cmd;
+	int skip_broken;
+};
+
 struct receive_hook_feed_state {
 	struct command *cmd;
 	struct ref_push_report *report;
 	int skip_broken;
 	struct strbuf buf;
-	const struct string_list *push_options;
 };
 
-typedef int (*feed_fn)(void *, const char **, size_t *);
-static int run_and_feed_hook(const char *hook_name, feed_fn feed,
-			     struct receive_hook_feed_state *feed_state)
+static int feed_receive_hook(int hook_stdin_fd, struct receive_hook_feed_state *state, int lines_batch_size)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	struct async muxer;
-	int code;
-	const char *hook_path = find_hook(the_repository, hook_name);
+	struct command *cmd = state->cmd;
 
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
+	/* batch lines to avoid going through run-command's ppoll for each line */
+	for (int i = 0; i < lines_batch_size; i++) {
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
+
+	if (state->buf.len > 0) {
+		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
+		if (ret < 0) {
+			if (errno == EPIPE)
+				return 1; /* child closed pipe */
+			return ret;
+		}
+	}
 
-	return finish_command(&proc);
+	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
 }
 
-static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
+static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
 {
-	struct receive_hook_feed_state *state = state_;
-	struct command *cmd = state->cmd;
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct receive_hook_feed_state *feed_state = hook_cb->options->feed_pipe_cb_data;
 
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
+	/* first-time setup */
+	if (!hook_cb->options->feed_pipe_cb_data) {
+		struct receive_hook_feed_context *ctx = hook_cb->options->feed_pipe_ctx;
+		if (!ctx)
+			BUG("run_hooks_opt.feed_pipe_ctx required for receive hook");
+
+		hook_cb->options->feed_pipe_cb_data = xmalloc(sizeof(struct receive_hook_feed_state));
+		feed_state = hook_cb->options->feed_pipe_cb_data;
+		strbuf_init(&feed_state->buf, 0);
+		feed_state->cmd = ctx->cmd;
+		feed_state->skip_broken = ctx->skip_broken;
+		feed_state->report = NULL;
 	}
-	return 0;
-}
 
-static int run_receive_hook(struct command *commands,
-			    const char *hook_name,
-			    int skip_broken,
-			    const struct string_list *push_options)
-{
-	struct receive_hook_feed_state state;
-	int status;
+	/* batch 500 lines at once to avoid going through the run-command ppoll loop too often */
+	if (feed_receive_hook(hook_stdin_fd, feed_state, 500) == 0)
+		return 0; /* still have more data to feed */
 
-	strbuf_init(&state.buf, 0);
-	state.cmd = commands;
-	state.skip_broken = skip_broken;
-	state.report = NULL;
-	if (feed_receive_hook(&state, NULL, NULL))
-		return 0;
-	state.cmd = commands;
-	state.push_options = push_options;
-	status = run_and_feed_hook(hook_name, feed_receive_hook, &state);
-	strbuf_release(&state.buf);
-	return status;
+	strbuf_release(&feed_state->buf);
+
+	if (hook_cb->options->feed_pipe_cb_data)
+		FREE_AND_NULL(hook_cb->options->feed_pipe_cb_data);
+
+	return 1; /* done feeding, run-command can close pipe */
 }
 
 static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
@@ -972,6 +930,49 @@ static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
 	send_sideband(1, 2, output->buf, output->len, use_sideband);
 }
 
+static int run_receive_hook(struct command *commands,
+			    const char *hook_name,
+			    int skip_broken,
+			    const struct string_list *push_options)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct receive_hook_feed_context ctx;
+	struct command *iter = commands;
+
+	/* if there are no valid commands, don't invoke the hook at all. */
+	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
+		iter = iter->next;
+	if (!iter)
+		return 0;
+
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
+		opt.consume_sideband = hook_output_to_sideband;
+
+	/* set up stdin callback */
+	ctx.cmd = commands;
+	ctx.skip_broken = skip_broken;
+	opt.feed_pipe = feed_receive_hook_cb;
+	opt.feed_pipe_ctx = &ctx;
+
+	return run_hooks_opt(the_repository, hook_name, &opt);
+}
+
 static int run_update_hook(struct command *cmd)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
-- 
2.49.1

