Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E460E33A71C
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032511; cv=pass; b=q69Diw5eER77/WyL1sAOurWQTq7bncjfvQyw5NaiPJcBp9JL8QYAIbFSYUFkzIuTVzDxODeMGD6ANQM0ulYXiCLICpDYQrE14kxB87HeStbeIsl3EKyfVeEm+Oe1T7ohGpXz9jsqTwNRnPEqBZn0HvXIEt0rjaDj1xoAxF/3iAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032511; c=relaxed/simple;
	bh=qsZS2khkOn8PO2waXkwz82nhrJiTkBiXSqq+hHPlIL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/yxvqJRPhD4uGOpkfhQXMcwK1TzxRCfLwDBLNq3O+lb0Vqb96mwSNh00rvrLOeHdCGFyQV7egneybNTBWVtTzpRw4PXiEu+HUvfdvdzL+9j7Sm3R8Syg2Xrj0tuNx38AWYI46sCk6C/4Pi67lnWuEx489Sk75kOiLbBVH8kKzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=GoUiUN+q; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="GoUiUN+q"
ARC-Seal: i=1; a=rsa-sha256; t=1769032491; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LYOYSMtepD+sXgCJTS8iUiIdDrGB3CGtkcd4q537e7lEk017L4be+K5i2BwboefhGlX0aExLgrDZhP/tKqufioyXWDjsckISy+RAyw9P5aFRuK7xMWMJOh5SPHo4cbecNCRq+DuN+ZEEFdi+S48VbEaZTpYnw1NyH+os2W9NN+k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032491; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eP1CPxbiZrtvoBqkeJO48eEHv5g30fNu1DdkfVwC7Ok=; 
	b=aqn9B3yHmONsqwoBmUZTh37AALObuNsGTWhTe4UTJWORKcTuUwATRZ+AudLgPC4i5DJl5fPBI2c7R/gwjOvlzob/DITgPQ8ndhizgrdcYqBARHEPjNF9fDNWak5SlW2udHCpoeS9Fdo7GbB+L7coKlwrZjDDhB+ff2OgX8lz1AI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032491;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=eP1CPxbiZrtvoBqkeJO48eEHv5g30fNu1DdkfVwC7Ok=;
	b=GoUiUN+qUBFs+I7MseFR7r8XtGAXC1h6lVh4WFWjqX0MpyoOaw6+Cj4mBnaoSm2e
	5D0NDGO2UIX+SQDnfR1dUMkqem04LCUWli8ld4KrAKEDU3owCWIu3XvgW59VJ64pfpG
	x6nQeeMjOzlYyJmWLcnB6dyG8Gqpj6MWjRTDX8lI=
Received: by mx.zohomail.com with SMTPS id 1769032489619765.6450408378217;
	Wed, 21 Jan 2026 13:54:49 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 00/12] Convert remaining hooks to hook.h
Date: Wed, 21 Jan 2026 23:54:24 +0200
Message-ID: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
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

Hello everyone,

This series finishes the hook.[ch] conversion for the remaining hooks in
preparation for adding config-based hooks and enabling parallel hook
execution where possible (those will be separate series from this one).

v7 squashes post-merge fixes (yes this series was merged then reverted)
and improves hook communication according to the new muxer-based design
suggested by Peff (many thanks!)

It is based on the latest master branch, there are no conflicts with
next and seen, the code is available on GitHub and CI passes.

GitHub: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v6
CI run: https://github.com/10ne1/git/actions/runs/21225502607

Changes in v7:
* Significantly reworked sideband output and hook / run-command child
  communication and synchronization according to Peff's design (Peff)
* Squashed fix for -Werror=analyzer-deref-before-check into commit which
  introduced it (correctmost, Junio)
* Squashed fix which allows stdout and stderr to be separate streams for
  pre-push. (Chris, Junio)
* New commit: add hook output stream tests (Patrick, Junio)
* Dropped unused includes from refs.c (Karthik, Szabo)
* Minor comment and commit message fixes, ASCII art (Adrian)

Range-diff v6 -> v7:
 -:  ---------- >  1:  aff497683c t1800: add hook output stream tests
 1:  8c16f1bcbf =  2:  a76027c3c6 run-command: add first helper for pp child states
 2:  5e6e05ba92 =  3:  a0969bbf3f run-command: add stdin callback for parallelization
 3:  3669acfe6a =  4:  43156cdfc4 hook: provide stdin via callback
 4:  bf9d8680e4 =  5:  0cfd9ade6e hook: convert 'post-rewrite' hook in sequencer.c to hook API
 -:  ---------- >  6:  bb059a7508 hook: allow separate std[out|err] streams
 5:  bdcc1cff34 !  7:  7d14404316 transport: convert pre-push to hook API
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -		ret = x;
     +	opt.feed_pipe = pre_push_hook_feed_stdin;
     +	opt.feed_pipe_cb_data = &data;
    ++
    ++	/*
    ++	 * pre-push hooks expect stdout & stderr to be separate, so don't merge
    ++	 * them to keep backwards compatibility with existing hooks.
    ++	 */
    ++	opt.stdout_to_stderr = 0;
      
     -	sigchain_pop(SIGPIPE);
     +	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 6:  9c1d5e8726 !  8:  c4a43509b8 reference-transaction: use hook API instead of run-command
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## refs.c ##
    +@@
    + #include "iterator.h"
    + #include "refs.h"
    + #include "refs/refs-internal.h"
    +-#include "run-command.h"
    + #include "hook.h"
    + #include "object-name.h"
    + #include "odb.h"
    +@@
    + #include "strvec.h"
    + #include "repo-settings.h"
    + #include "setup.h"
    +-#include "sigchain.h"
    + #include "date.h"
    + #include "commit.h"
    + #include "wildmatch.h"
     @@ refs.c: static int ref_update_reject_duplicates(struct string_list *refnames,
      	return 0;
      }
 7:  0b986bf0fb <  -:  ---------- hook: allow overriding the ungroup option
 8:  5f07d07acc <  -:  ---------- run-command: allow capturing of collated output
 9:  c4ff1e2270 <  -:  ---------- hooks: allow callers to capture output
10:  15c831ca15 <  -:  ---------- receive-pack: convert update hooks to new API
 -:  ---------- >  9:  9336d6d752 hook: add jobs option
 -:  ---------- > 10:  1fac0e1894 run-command: poll child stdin in addition to stdout
 -:  ---------- > 11:  d9e48a9224 receive-pack: convert update hooks to new API
11:  432dc14871 ! 12:  f8887c53e6 receive-pack: convert receive hooks to hook API
    @@
      ## Metadata ##
    -Author: Emily Shaffer <nasamuffin@google.com>
    +Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
         receive-pack: convert receive hooks to hook API
    @@ Commit message
         This converts the last remaining hooks to the new hook API, for
         the same benefits as the previous conversions (no need to toggle
         signals, manage custom struct child_process, call find_hook(),
    -    prepares for specifyinig hooks via configs, etc.).
    +    prepares for specifying hooks via configs, etc.).
     
    -    I noticed a performance degradation when processing large amounts
    -    of hook input with just 1 line per callback, due to run-command's
    -    poll loop, therefore I batched 500 lines per callback, to ensure
    -    similar pipe throughput as before and to avoid hook child waiting
    -    on stdin.
    +    See the previous four commits for a more details explanation how
    +    this all works.
     
    +    Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -	struct async muxer;
     -	int code;
     -	const char *hook_path = find_hook(the_repository, hook_name);
    -+	struct receive_hook_feed_state *state = pp_task_cb;
    -+	struct command *cmd = state->cmd;
    -+	unsigned int lines_batch_size = 500;
    - 
    +-
     -	if (!hook_path)
     -		return 0;
    -+	strbuf_reset(&state->buf);
    - 
    +-
     -	strvec_push(&proc.args, hook_path);
     -	proc.in = -1;
     -	proc.stdout_to_stderr = 1;
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -			     (uintmax_t)feed_state->push_options->nr);
     -	} else
     -		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
    -+	/* batch lines to avoid going through run-command's poll loop for each line */
    -+	for (unsigned int i = 0; i < lines_batch_size; i++) {
    -+		while (cmd &&
    -+		       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
    -+			cmd = cmd->next;
    - 
    +-
     -	if (tmp_objdir)
     -		strvec_pushv(&proc.env, tmp_objdir_env(tmp_objdir));
    -+		if (!cmd)
    -+			break;  /* no more commands left */
    - 
    +-
     -	if (use_sideband) {
     -		memset(&muxer, 0, sizeof(muxer));
     -		muxer.proc = copy_to_sideband;
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -			return code;
     -		proc.err = muxer.in;
     -	}
    -+		if (!state->report)
    -+			state->report = cmd->report;
    - 
    +-
     -	prepare_push_cert_sha1(&proc);
    -+		if (state->report) {
    -+			struct object_id *old_oid;
    -+			struct object_id *new_oid;
    -+			const char *ref_name;
    - 
    +-
     -	code = start_command(&proc);
     -	if (code) {
     -		if (use_sideband)
     -			finish_async(&muxer);
     -		return code;
     -	}
    -+			old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
    -+			new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
    -+			ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
    - 
    +-
     -	sigchain_push(SIGPIPE, SIG_IGN);
    -+			strbuf_addf(&state->buf, "%s %s %s\n",
    -+				    oid_to_hex(old_oid), oid_to_hex(new_oid),
    -+				    ref_name);
    - 
    +-
     -	while (1) {
     -		const char *buf;
     -		size_t n;
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -			break;
     -		if (write_in_full(proc.in, buf, n) < 0)
     -			break;
    -+			state->report = state->report->next;
    -+			if (!state->report)
    -+				cmd = cmd->next;
    -+		} else {
    -+			strbuf_addf(&state->buf, "%s %s %s\n",
    -+				    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
    -+				    cmd->ref_name);
    -+			cmd = cmd->next;
    -+		}
    - 	}
    +-	}
     -	close(proc.in);
     -	if (use_sideband)
     -		finish_async(&muxer);
    - 
    +-
     -	sigchain_pop(SIGPIPE);
    -+	state->cmd = cmd;
    - 
    +-
     -	return finish_command(&proc);
     -}
     -
     -static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
     -{
     -	struct receive_hook_feed_state *state = state_;
    --	struct command *cmd = state->cmd;
    --
    --	while (cmd &&
    --	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
    --		cmd = cmd->next;
    --	if (!cmd)
    ++	struct receive_hook_feed_state *state = pp_task_cb;
    + 	struct command *cmd = state->cmd;
    + 
    ++	strbuf_reset(&state->buf);
    ++
    + 	while (cmd &&
    + 	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
    + 		cmd = cmd->next;
    ++
    + 	if (!cmd)
     -		return -1; /* EOF */
     -	if (!bufp)
     -		return 0; /* OK, can feed something. */
     -	strbuf_reset(&state->buf);
    --	if (!state->report)
    --		state->report = cmd->report;
    --	if (state->report) {
    --		struct object_id *old_oid;
    --		struct object_id *new_oid;
    --		const char *ref_name;
    --
    --		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
    --		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
    --		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
    --		strbuf_addf(&state->buf, "%s %s %s\n",
    --			    oid_to_hex(old_oid), oid_to_hex(new_oid),
    --			    ref_name);
    --		state->report = state->report->next;
    --		if (!state->report)
    ++		return 1;  /* no more commands left */
    ++
    + 	if (!state->report)
    + 		state->report = cmd->report;
    ++
    + 	if (state->report) {
    + 		struct object_id *old_oid;
    + 		struct object_id *new_oid;
    +@@ builtin/receive-pack.c: static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    + 		old_oid = state->report->old_oid ? state->report->old_oid : &cmd->old_oid;
    + 		new_oid = state->report->new_oid ? state->report->new_oid : &cmd->new_oid;
    + 		ref_name = state->report->ref_name ? state->report->ref_name : cmd->ref_name;
    ++
    + 		strbuf_addf(&state->buf, "%s %s %s\n",
    + 			    oid_to_hex(old_oid), oid_to_hex(new_oid),
    + 			    ref_name);
    ++
    + 		state->report = state->report->next;
    + 		if (!state->report)
     -			state->cmd = cmd->next;
    --	} else {
    --		strbuf_addf(&state->buf, "%s %s %s\n",
    --			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
    --			    cmd->ref_name);
    ++			cmd = cmd->next;
    + 	} else {
    + 		strbuf_addf(&state->buf, "%s %s %s\n",
    + 			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
    + 			    cmd->ref_name);
     -		state->cmd = cmd->next;
    --	}
    ++		cmd = cmd->next;
    + 	}
     -	if (bufp) {
     -		*bufp = state->buf.buf;
     -		*sizep = state->buf.len;
    ++
    ++	state->cmd = cmd;
    ++
     +	if (state->buf.len > 0) {
     +		int ret = write_in_full(hook_stdin_fd, state->buf.buf, state->buf.len);
     +		if (ret < 0) {
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     +	return state->cmd ? 0 : 1;  /* 0 = more to come, 1 = EOF */
      }
      
    - static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
    + static int run_receive_hook(struct command *commands,
     @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      			    int skip_broken,
      			    const struct string_list *push_options)
      {
     -	struct receive_hook_feed_state state;
     -	int status;
    --
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	struct command *iter = commands;
    ++	struct receive_hook_feed_state feed_state;
    ++	struct async muxer;
    ++	int ret;
    ++	int saved_stderr = -1;
    ++	int muxer_started = 0;
    + 
     -	strbuf_init(&state.buf, 0);
     -	state.cmd = commands;
     -	state.skip_broken = skip_broken;
     -	state.report = NULL;
     -	if (feed_receive_hook(&state, NULL, NULL))
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct command *iter = commands;
    -+	struct receive_hook_feed_state feed_state;
    -+	int ret;
    -+
     +	/* if there are no valid commands, don't invoke the hook at all. */
     +	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
     +		iter = iter->next;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +
     +	prepare_push_cert_sha1(&opt);
     +
    -+	/* set up sideband printer */
    -+	if (use_sideband)
    -+		opt.consume_output = hook_output_to_sideband;
    ++	if (use_sideband) {
    ++		memset(&muxer, 0, sizeof(muxer));
    ++		muxer.proc = copy_to_sideband;
    ++		muxer.in = -1;
    ++		if (!start_async(&muxer)) {
    ++			muxer_started = 1;
    ++			saved_stderr = dup(STDERR_FILENO);
    ++			if (saved_stderr >= 0)
    ++				dup2(muxer.in, STDERR_FILENO);
    ++			close(muxer.in);
    ++		}
    ++	}
     +
     +	/* set up stdin callback */
     +	feed_state.cmd = commands;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +	ret = run_hooks_opt(the_repository, hook_name, &opt);
     +
     +	strbuf_release(&feed_state.buf);
    ++	if (saved_stderr >= 0) {
    ++		dup2(saved_stderr, STDERR_FILENO);
    ++		close(saved_stderr);
    ++	}
    ++	if (muxer_started)
    ++		finish_async(&muxer);
     +
     +	return ret;
      }

Adrian Ratiu (8):
  t1800: add hook output stream tests
  run-command: add first helper for pp child states
  hook: allow separate std[out|err] streams
  reference-transaction: use hook API instead of run-command
  hook: add jobs option
  run-command: poll child stdin in addition to stdout
  receive-pack: convert update hooks to new API
  receive-pack: convert receive hooks to hook API

Emily Shaffer (4):
  run-command: add stdin callback for parallelization
  hook: provide stdin via callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook API
  transport: convert pre-push to hook API

 builtin/receive-pack.c      | 287 ++++++++++++++++++------------------
 hook.c                      |  32 +++-
 hook.h                      |  53 +++++++
 refs.c                      | 102 ++++++-------
 run-command.c               | 155 +++++++++++++++----
 run-command.h               |  21 +++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  52 ++++++-
 t/t0061-run-command.sh      |  31 ++++
 t/t1800-hook.sh             | 127 ++++++++++++++++
 transport.c                 |  95 ++++++------
 11 files changed, 715 insertions(+), 282 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

