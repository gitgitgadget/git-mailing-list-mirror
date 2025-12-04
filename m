Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21C346A1E
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857765; cv=pass; b=CEKxUe1hd89v8EGAjdaQrKc83JkSSHLj+763HHjeMZKVQOgFdQxYhskQ/DhWS19c2MjjoBRFsyKRPmfvn5P/hFE6sD8E2Ywu/QC4tE3HCryPh3bw6schg2YO3+cre90wQsy9s/FCrd9DbadLa0Wd/V2b2X8+mx9Ycz7ncC2ik6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857765; c=relaxed/simple;
	bh=j+4TUGJ3cTrvJRICKdINAASwlo/JxRc7CZ2NoiZNLgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OOgs4xVPlAVTqLsbualoCv5aBygJeYZ6ezz4X0ngTYrvDZ586cjKJkxvKsAd0IOlw17CtHqePiuqQBlcJs4F5FzLm1pmlaQ0tBe5gk8DtHeNllrT3AfB//B+8EZ15CdyF3omMcq4ZTv+lrn0rotgACQ0EGTQfVuCBDVKVlGqRT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CNs3vuk5; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CNs3vuk5"
ARC-Seal: i=1; a=rsa-sha256; t=1764857748; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EjV0F0JZjZ9rY9E3Ie8C/zstgxO0duOC77H7OPyI5+HJlQzLmsLCqE04X1y5g88QsV3fOuyEdOhu3KSgFFB+zKl0OJAsWSPcLCo4ILRj/EOMo/EHl7p22UVnqxqjb9PvrUrOY5P+JTN9mlgoRob8hTjYDTBccdNJKjTcR0e08Zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857748; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GBOWrF7PomJcA2odWvgpLI+qyMlOfu+mSdPU/D5oMe8=; 
	b=nq4qs4S/F5NoHHTuMl5x71JNXMkXucfpRgEImG2cCosfnueWaxuQM96MHSpCBDkPZ3PJHj9FndBWZqpzilsYthHlbcamlaKGiVtOZYqrItz3jWA4LDR/0uCb7HdHZfXUuTU+6CWs1hKo7wnvdB1rz6s/74pAI97sn6qME1hVrBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857748;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GBOWrF7PomJcA2odWvgpLI+qyMlOfu+mSdPU/D5oMe8=;
	b=CNs3vuk5PFq6N9YYQJNxjSMfQHRFcx9h7IlP/n/0o7tdltWR6YcmuVBcSqpsisIX
	f6aXg8cHA9goK9ujQWtgUU0Vhg2sxi4pC0J/QR8HlfMps8xnDsnVIWbcu59PA+34ZdF
	NbPgzs1geN32NWRltZP6qSQ3f2Ugsd0VaxncGUtk=
Received: by mx.zohomail.com with SMTPS id 1764857747051174.79499831957548;
	Thu, 4 Dec 2025 06:15:47 -0800 (PST)
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
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v4 00/11] Convert remaining hooks to hook.h
Date: Thu,  4 Dec 2025 16:15:24 +0200
Message-ID: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
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
execution where possible (that will be a separate series from this one).

v4 is a minor cleanup refresh: details + range-diff below.

It is based on the latest master branch. There are no conflicts with
next and seen branches, the code is available on GitHub [1] and a
successful CI run [2] is also provided.

1: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v4
2: https://github.com/10ne1/git/actions/runs/19929313184

Changes in v4:
* Simplified hook callbacks by passing 'feed_pipe_cb_data' directly via pp_task_cb (Patrick & Adrian)
* Removed stale comment from run-command.h (Junio)
* Introduced new helpers for pp child states to improve readability (Junio)

v3 -> v4 range-diff:
 -:  ---------- >  1:  b252d447f5 run-command: add first helper for pp child states
 1:  42aef8fea9 !  2:  f6fd3b9b0f run-command: add stdin callback for parallelization
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## run-command.c ##
    +@@ run-command.c: static int child_is_working(const struct parallel_child *pp_child)
    + 	return pp_child->state == GIT_CP_WORKING;
    + }
    + 
    ++static int child_is_ready_for_cleanup(const struct parallel_child *pp_child)
    ++{
    ++	return child_is_working(pp_child) && !pp_child->process.in;
    ++}
    ++
    ++static int child_is_receiving_input(const struct parallel_child *pp_child)
    ++{
    ++	return child_is_working(pp_child) && pp_child->process.in > 0;
    ++}
    ++
    + struct parallel_processes {
    + 	size_t nr_processes;
    + 
     @@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
      	return 0;
      }
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
     +		struct child_process *proc = &pp->children[i].process;
     +		int ret;
     +
    -+		if (pp->children[i].state != GIT_CP_WORKING || proc->in <= 0)
    ++		if (!child_is_receiving_input(&pp->children[i]))
     +			continue;
     +
     +		/*
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp,
     +	pp_buffer_stdin(pp, opts);
     +
     +	if (opts->ungroup) {
    -+		for (size_t i = 0; i < opts->processes; i++) {
    -+			int child_ready_for_cleanup =
    -+				pp->children[i].state == GIT_CP_WORKING &&
    -+				pp->children[i].process.in == 0;
    -+
    -+			if (child_ready_for_cleanup)
    ++		for (size_t i = 0; i < opts->processes; i++)
    ++			if (child_is_ready_for_cleanup(&pp->children[i]))
     +				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
    -+		}
     +	} else {
     +		pp_buffer_stderr(pp, opts, output_timeout);
     +		pp_output(pp);
    @@ run-command.h: typedef int (*start_failure_fn)(struct strbuf *out,
     + *
     + * pp_cb is the callback cookie as passed into run_processes_parallel, and
     + * pp_task_cb is the callback cookie as passed into get_next_task_fn.
    -+ * The contents of 'send' will be read into the pipe and passed to the pipe.
     + *
     + * Returns < 0 for error
     + * Returns == 0 when there is more data to be fed (will be called again)
 2:  00c5b45987 !  3:  59c07b618e hook: provide stdin via callback
    @@ Commit message
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## hook.c ##
    +@@ hook.c: int hook_exists(struct repository *r, const char *name)
    + static int pick_next_hook(struct child_process *cp,
    + 			  struct strbuf *out UNUSED,
    + 			  void *pp_cb,
    +-			  void **pp_task_cb UNUSED)
    ++			  void **pp_task_cb)
    + {
    + 	struct hook_cb_data *hook_cb = pp_cb;
    + 	const char *hook_path = hook_cb->hook_path;
     @@ hook.c: static int pick_next_hook(struct child_process *cp,
      
      	cp->no_stdin = 1;
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	cp->stdout_to_stderr = 1;
      	cp->trace2_hook_name = hook_cb->hook_name;
      	cp->dir = hook_cb->options->dir;
    +@@ hook.c: static int pick_next_hook(struct child_process *cp,
    + 	strvec_push(&cp->args, hook_path);
    + 	strvec_pushv(&cp->args, hook_cb->options->args.v);
    + 
    ++	/*
    ++	 * Provide per-hook internal state via task_cb for easy access, so
    ++	 * hook callbacks don't have to go through hook_cb->options.
    ++	 */
    ++	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
    ++
    + 	/*
    + 	 * This pick_next_hook() will be called again, we're only
    + 	 * running one hook, so indicate that no more work will be
     @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      
      		.get_next_task = pick_next_hook,
    @@ hook.h: struct run_hooks_opt
     +	/**
     +	 * Opaque data pointer used to pass context to `feed_pipe_fn`.
     +	 *
    -+	 * It can be accessed via the second callback arg:
    ++	 * It can be accessed via the second callback arg 'pp_cb':
     +	 * ((struct hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_ctx;
     +	 *
     +	 * The caller is responsible for managing the memory for this data.
    @@ hook.h: struct run_hooks_opt
     +	/**
     +	 * Opaque data pointer used to keep internal state across callback calls.
     +	 *
    -+	 * It can be accessed via the second callback arg:
    -+	 * ((struct hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_cb_data;
    ++	 * It can be accessed directly via the third callback arg 'pp_task_cb':
    ++	 * struct ... *state = pp_task_cb;
     +	 *
     +	 * The caller is responsible for managing the memory for this data.
     +	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 3:  08792569df =  4:  8f591319a4 hook: convert 'post-rewrite' hook in sequencer.c to hook API
 4:  8a76eb11cf !  5:  2427717a26 transport: convert pre-push to hook API
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
      
     -	if (!hook_path)
     -		return 0;
    -+static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    ++static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
     +{
    -+	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct feed_pre_push_hook_data *data = hook_cb->options->feed_pipe_cb_data;
    ++	struct feed_pre_push_hook_data *data = pp_task_cb;
     +	const struct ref *r = data->refs;
     +	int ret = 0;
      
 5:  92452c6707 !  6:  22467bb074 reference-transaction: use hook API instead of run-command
    @@ refs.c: static int ref_update_reject_duplicates(struct string_list *refnames,
     +	struct strbuf buf;
     +};
     +
    -+static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    ++static int transaction_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb)
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	struct strbuf buf = STRBUF_INIT;
     -	const char *hook;
     -	int ret = 0;
     +	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct run_hooks_opt *opt = hook_cb->options;
    -+	struct ref_transaction *transaction = opt->feed_pipe_ctx;
    -+	struct transaction_feed_cb_data *feed_cb_data = opt->feed_pipe_cb_data;
    ++	struct ref_transaction *transaction = hook_cb->options->feed_pipe_ctx;
    ++	struct transaction_feed_cb_data *feed_cb_data = pp_task_cb;
     +	struct strbuf *buf = &feed_cb_data->buf;
     +	struct ref_update *update;
     +	size_t i = feed_cb_data->index++;
 6:  6ec922ccef =  7:  9b0b13379c hook: allow overriding the ungroup option
 7:  3098e8f31a !  8:  cae3c984e2 run-command: allow capturing of collated output
    @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
      {
      	size_t i = pp->output_owner;
      
    - 	if (pp->children[i].state == GIT_CP_WORKING &&
    + 	if (child_is_working(&pp->children[i]) &&
      	    pp->children[i].err.len) {
     -		strbuf_write(&pp->children[i].err, stderr);
     +		if (opts->consume_output)
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp,
      
      			/*
     @@ run-command.c: static void pp_handle_child_IO(struct parallel_processes *pp,
    - 		}
    + 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
      	} else {
      		pp_buffer_stderr(pp, opts, output_timeout);
     -		pp_output(pp);
 8:  1a21310174 =  9:  0383be2ebd hooks: allow callers to capture output
 9:  6a2895750a = 10:  d8e234c453 receive-pack: convert update hooks to new API
10:  254e7dd351 ! 11:  6bad9aed4d receive-pack: convert receive hooks to hook API
    @@ builtin/receive-pack.c: struct receive_hook_feed_state {
     -typedef int (*feed_fn)(void *, const char **, size_t *);
     -static int run_and_feed_hook(const char *hook_name, feed_fn feed,
     -			     struct receive_hook_feed_state *feed_state)
    -+static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    ++static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_task_cb)
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	struct async muxer;
     -	int code;
     -	const char *hook_path = find_hook(the_repository, hook_name);
    -+	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct receive_hook_feed_state *state = hook_cb->options->feed_pipe_cb_data;
    ++	struct receive_hook_feed_state *state = pp_task_cb;
     +	struct command *cmd = state->cmd;
     +	unsigned int lines_batch_size = 500;
      

Adrian Ratiu (3):
  run-command: add first helper for pp child states
  reference-transaction: use hook API instead of run-command
  hook: allow overriding the ungroup option

Emily Shaffer (8):
  run-command: add stdin callback for parallelization
  hook: provide stdin via callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook API
  transport: convert pre-push to hook API
  run-command: allow capturing of collated output
  hooks: allow callers to capture output
  receive-pack: convert update hooks to new API
  receive-pack: convert receive hooks to hook API

 builtin/hook.c              |   6 +
 builtin/receive-pack.c      | 270 +++++++++++++++---------------------
 commit.c                    |   3 +
 hook.c                      |  29 +++-
 hook.h                      |  51 +++++++
 refs.c                      | 100 ++++++-------
 run-command.c               | 142 +++++++++++++++----
 run-command.h               |  38 +++++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  67 ++++++++-
 t/t0061-run-command.sh      |  38 +++++
 transport.c                 |  94 +++++++------
 12 files changed, 587 insertions(+), 293 deletions(-)

-- 
2.51.0

