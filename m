Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9892339A8
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004874; cv=pass; b=HeZrpcPl7ewohNBazE6zqz/OPQLqFfiCAllrHsF0Bnt6ZzVdGP3O+HVVp+dIVAY/DZTkM627diBbKCxa4nFaySjDvDAjah8q/Iko9/JgT3me+T8nSBMOfxTPAbVbKHDPfmoTHtN5PeDrtSEHvvs/lI7XP+SLoWpPWQddWeaP1v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004874; c=relaxed/simple;
	bh=3yxJiZalz9sNl5uESwlukeyj6dJPQ19mvRaAUh4vHFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7UXw2P6H/QFyndYP62EZhRf3fhQ92/kxfbdqHbsjR2KrvY8RBBxlPgqpmST202vnhN7w1W1KlCIsmpciEjKu0poO/HWEKwZrBYHI/a0vvbtg1eDnaA/UJcL1acXO+np77pOEAfeuFZ9RE+pcacH3sAF7KxQLtXSVD6TsMwmkDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NkmYJQ9Y; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NkmYJQ9Y"
ARC-Seal: i=1; a=rsa-sha256; t=1764004857; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fUBV5x0faJ0qHCV7ZNxetkSEyROmw2mVjToUQnsf4zKiBzi2fLgLpaFZPj7GUYgW4kODvito0vkuwrDr7ONZGfa6O/1QfxCT6FQVsB30q6U8ZQ9Z8KzqBf2F2TGLnLCWFhay3lgeFyvEDYSi30OO/7di/sHDxGEn7Sv5oC/kU90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004857; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=utOibtR9G8WrIgsLiLS+vblFzp5KV4OTO/ClASNASN4=; 
	b=HcJ7CuFpct67ULOM8QxnV/yUbPFTN6beuZsIZR1JEB7dsPFsh6gteCUBJD/AsJD2efmJnf6nSUsIAzU1Tx4YU9WuV2WFSfVZljzWqnpyJyZN8HLiLwB5i78ZzJBAGj92EFgXYM31cz8TU0uqXeP5yTo/i6fJqDCl7ACQp3B7jI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004857;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=utOibtR9G8WrIgsLiLS+vblFzp5KV4OTO/ClASNASN4=;
	b=NkmYJQ9Y73GwZZ3tpGWjrcn0K7APxLX14uUJWEb1sIH7f5hPVScwtH7sRxayyk0q
	BQ9Ph02/wc/vAo/zX/zqq4RrPiraTC3TV/7G5yGqYNwhvLSs1/N8f57ck9ys6j3Pd0E
	ibSvLNAd1MlHT32k1wGKBO6kiaDrik3lL69olKHc=
Received: by mx.zohomail.com with SMTPS id 1764004855715724.9890981307033;
	Mon, 24 Nov 2025 09:20:55 -0800 (PST)
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
Subject: [PATCH v3 00/10] Convert remaining hooks to hook.h
Date: Mon, 24 Nov 2025 19:20:33 +0200
Message-ID: <20251124172043.1650014-1-adrian.ratiu@collabora.com>
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

This series finishes hook.[ch] conversion for remaining hooks in preparation for
adding config-based hooks and enabling hook parallelization where possible.

v3 addresses review feedback received in v2 plus some minor code simplifications
mentioned below. A v2->v3 range diff is also provided for reviewer convenience.

This is based on the latest master branch and I've checked for conflicts with
next and seen branches. The code is also available on GitHub [1] and a successful
CI run [2] is also available.

1: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v3
2: https://github.com/10ne1/git/actions/runs/19639495095

Changes between v2 -> v3:
* Fixed receive hook memory leaks by moving allocations to callers who own the mem (Junio)
* Simplified receive hook stdin callback by removing the redundant context addition (Adrian)
* Moved ref pointer from callback context to cb_data in the pre-push hook (Patrick)
* Renamed the run-command output API to remove the hook-specific sideband wording (Patrick)
* Added all REF_STATUS_REJECT_* statuses to pre_push hook (Adrian)
* Improved documentation for hook.h and run-command.h (Patrick)
* Small code cleanups for data types, conditionals, BUGs, commit msgs (Patrick, Kristoffer, Junio)

Range-diff between v2 -> v3:
 1:  0c280cf782 !  1:  42aef8fea9 run-command: add stdin callback for parallelization
    @@ run-command.c: static int pp_start_one(struct parallel_processes *pp,
     +			    const struct run_process_parallel_opts *opts)
     +{
     +	/* Buffer stdin for each pipe. */
    -+	for (ssize_t i = 0; i < opts->processes; i++) {
    ++	for (size_t i = 0; i < opts->processes; i++) {
     +		struct child_process *proc = &pp->children[i].process;
     +		int ret;
     +
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp UNUSED,
      		strbuf_addstr(err, "asking for a quick stop\n");
      	else
      		fprintf(stderr, "asking for a quick stop\n");
    -+	if (pp_task_cb)
    -+		FREE_AND_NULL(pp_task_cb);
    ++
    ++	FREE_AND_NULL(pp_task_cb);
    ++
      	return 1;
      }
      
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp UNUSED,
     +			       void *pp_cb UNUSED,
     +			       void *pp_task_cb)
     +{
    -+	if (pp_task_cb)
    -+		FREE_AND_NULL(pp_task_cb);
    ++	FREE_AND_NULL(pp_task_cb);
     +	return 0;
     +}
     +
 2:  94657d9279 !  2:  00c5b45987 hook: provide stdin via callback
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
      
     +	if (options->path_to_stdin && options->feed_pipe)
    -+		BUG("choose only one method to populate hook stdin");
    ++		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
     +
      	if (options->invoked_hook)
      		*options->invoked_hook = 0;
    @@ hook.h: struct run_hooks_opt
      	const char *path_to_stdin;
     +
     +	/**
    -+	 * Callback to ask for more content to pipe to each hook stdin.
    ++	 * Callback used to incrementally feed a child hook stdin pipe.
     +	 *
    -+	 * If a hook needs to consume large quantities of data (e.g. a
    -+	 * list of all refs received in a client push), feeding data via
    -+	 * in-memory strings or slurping to/from files via path_to_stdin
    -+	 * is inefficient, so this callback allows for piecemeal writes.
    ++	 * Useful especially if a hook consumes large quantities of data
    ++	 * (e.g. a list of all refs in a client push), so feeding it via
    ++	 * in-memory strings or slurping to/from files is inefficient.
    ++	 * While the callback allows piecemeal writing, it can also be
    ++	 * used for smaller inputs, where it gets called only once.
     +	 *
    -+	 * Add initalization context to hook.feed_pipe_ctx.
    ++	 * Add hook callback initalization context to `feed_pipe_ctx`.
    ++	 * Add Hook callback internal state to `feed_pipe_cb_data`.
     +	 *
    -+	 * The caller owns hook.feed_pipe_ctx and has to release any
    -+	 * resources after hooks finish execution.
     +	 */
     +	feed_pipe_fn feed_pipe;
    ++
    ++	/**
    ++	 * Opaque data pointer used to pass context to `feed_pipe_fn`.
    ++	 *
    ++	 * It can be accessed via the second callback arg:
    ++	 * ((struct hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_ctx;
    ++	 *
    ++	 * The caller is responsible for managing the memory for this data.
    ++	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
    ++	 */
     +	void *feed_pipe_ctx;
     +
     +	/**
    -+	 * Use this to keep internal state for your feed_pipe_fn callback.
    -+	 * Only useful when using run_hooks_opt.feed_pipe, otherwise ignore it.
    ++	 * Opaque data pointer used to keep internal state across callback calls.
    ++	 *
    ++	 * It can be accessed via the second callback arg:
    ++	 * ((struct hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_cb_data;
    ++	 *
    ++	 * The caller is responsible for managing the memory for this data.
    ++	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
     +	 */
     +	void *feed_pipe_cb_data;
      };
 3:  5ddbf1d1d9 =  3:  08792569df hook: convert 'post-rewrite' hook in sequencer.c to hook API
 4:  948eb95587 !  4:  8a76eb11cf transport: convert pre-push to hook API
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
      
     -static int run_pre_push_hook(struct transport *transport,
     -			     struct ref *remote_refs)
    -+static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    - {
    +-{
     -	int ret = 0, x;
     -	struct ref *r;
     -	struct child_process proc = CHILD_PROCESS_INIT;
    --	struct strbuf buf;
    ++struct feed_pre_push_hook_data {
    + 	struct strbuf buf;
     -	const char *hook_path = find_hook(the_repository, "pre-push");
    -+	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct ref *r = hook_cb->options->feed_pipe_ctx;
    -+	struct strbuf *buf = hook_cb->options->feed_pipe_cb_data;
    -+	int ret = 0;
    ++	const struct ref *refs;
    ++};
      
     -	if (!hook_path)
     -		return 0;
    -+	if (!r)
    -+		return 1; /* no more refs */
    ++static int pre_push_hook_feed_stdin(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    ++{
    ++	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct feed_pre_push_hook_data *data = hook_cb->options->feed_pipe_cb_data;
    ++	const struct ref *r = data->refs;
    ++	int ret = 0;
      
     -	strvec_push(&proc.args, hook_path);
     -	strvec_push(&proc.args, transport->remote->name);
     -	strvec_push(&proc.args, transport->url);
    -+	if (!buf)
    -+		BUG("pipe_task_cb must contain a valid strbuf");
    ++	if (!r)
    ++		return 1; /* no more refs */
      
     -	proc.in = -1;
     -	proc.trace2_hook_name = "pre-push";
    -+	hook_cb->options->feed_pipe_ctx = r->next;
    -+	strbuf_reset(buf);
    ++	data->refs = r->next;
      
     -	if (start_command(&proc)) {
     -		finish_command(&proc);
     -		return -1;
    --	}
    --
    ++	switch (r->status) {
    ++	case REF_STATUS_REJECT_ALREADY_EXISTS:
    ++	case REF_STATUS_REJECT_FETCH_FIRST:
    ++	case REF_STATUS_REJECT_NEEDS_FORCE:
    ++	case REF_STATUS_REJECT_NODELETE:
    ++	case REF_STATUS_REJECT_NONFASTFORWARD:
    ++	case REF_STATUS_REJECT_REMOTE_UPDATED:
    ++	case REF_STATUS_REJECT_SHALLOW:
    ++	case REF_STATUS_REJECT_STALE:
    ++	case REF_STATUS_UPTODATE:
    ++		return 0; /* skip refs which won't be pushed */
    ++	default:
    ++		break;
    + 	}
    + 
     -	sigchain_push(SIGPIPE, SIG_IGN);
    -+	if (!r->peer_ref) return 0;
    -+	if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) return 0;
    -+	if (r->status == REF_STATUS_REJECT_STALE) return 0;
    -+	if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) return 0;
    -+	if (r->status == REF_STATUS_UPTODATE) return 0;
    ++	if (!r->peer_ref)
    ++		return 0;
      
     -	strbuf_init(&buf, 256);
    -+	strbuf_addf(buf, "%s %s %s %s\n",
    ++	strbuf_reset(&data->buf);
    ++	strbuf_addf(&data->buf, "%s %s %s %s\n",
     +		    r->peer_ref->name, oid_to_hex(&r->new_oid),
     +		    r->name, oid_to_hex(&r->old_oid));
      
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -		if (r->status == REF_STATUS_REJECT_STALE) continue;
     -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
     -		if (r->status == REF_STATUS_UPTODATE) continue;
    -+	ret = write_in_full(hook_stdin_fd, buf->buf, buf->len);
    ++	ret = write_in_full(hook_stdin_fd, data->buf.buf, data->buf.len);
     +	if (ret < 0 && errno != EPIPE)
     +		return ret; /* We do not mind if a hook does not read all refs. */
      
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     +			     struct ref *remote_refs)
     +{
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct strbuf buf = STRBUF_INIT;
    ++	struct feed_pre_push_hook_data data;
     +	int ret = 0;
    - 
    --	strbuf_release(&buf);
    ++
     +	strvec_push(&opt.args, transport->remote->name);
     +	strvec_push(&opt.args, transport->url);
      
    +-	strbuf_release(&buf);
    ++	strbuf_init(&data.buf, 0);
    ++	data.refs = remote_refs;
    + 
     -	x = close(proc.in);
     -	if (!ret)
     -		ret = x;
     +	opt.feed_pipe = pre_push_hook_feed_stdin;
    -+	opt.feed_pipe_ctx = remote_refs;
    -+	opt.feed_pipe_cb_data = &buf;
    ++	opt.feed_pipe_cb_data = &data;
      
     -	sigchain_pop(SIGPIPE);
     +	ret = run_hooks_opt(the_repository, "pre-push", &opt);
    @@ transport.c: static void die_with_unpushed_submodules(struct string_list *needs_
     -	x = finish_command(&proc);
     -	if (!ret)
     -		ret = x;
    -+	strbuf_release(&buf);
    ++	strbuf_release(&data.buf);
      
      	return ret;
      }
 5:  64322e2659 =  5:  92452c6707 reference-transaction: use hook API instead of run-command
 6:  62306f1058 =  6:  6ec922ccef hook: allow overriding the ungroup option
 7:  eb284028a1 !  7:  3098e8f31a run-command: allow capturing of collated output
    @@ run-command.c: static void pp_cleanup(struct parallel_processes *pp,
      	 * iteration, the buffered output is non empty.
      	 */
     -	strbuf_write(&pp->buffered_output, stderr);
    -+	if (opts->consume_sideband)
    -+		opts->consume_sideband(&pp->buffered_output, opts->data);
    ++	if (opts->consume_output)
    ++		opts->consume_output(&pp->buffered_output, opts->data);
     +	else
     +		strbuf_write(&pp->buffered_output, stderr);
      	strbuf_release(&pp->buffered_output);
    @@ run-command.c: static void pp_buffer_stderr(struct parallel_processes *pp,
      	if (pp->children[i].state == GIT_CP_WORKING &&
      	    pp->children[i].err.len) {
     -		strbuf_write(&pp->children[i].err, stderr);
    -+		if (opts->consume_sideband)
    -+			opts->consume_sideband(&pp->children[i].err, opts->data);
    ++		if (opts->consume_output)
    ++			opts->consume_output(&pp->children[i].err, opts->data);
     +		else
     +			strbuf_write(&pp->children[i].err, stderr);
      		strbuf_reset(&pp->children[i].err);
    @@ run-command.c: static int pp_collect_finished(struct parallel_processes *pp,
      
     -			strbuf_write(&pp->children[i].err, stderr);
     +			/* Output errors, then all other finished child processes */
    -+			if (opts->consume_sideband) {
    -+				opts->consume_sideband(&pp->children[i].err, opts->data);
    -+				opts->consume_sideband(&pp->buffered_output, opts->data);
    ++			if (opts->consume_output) {
    ++				opts->consume_output(&pp->children[i].err, opts->data);
    ++				opts->consume_output(&pp->buffered_output, opts->data);
     +			} else {
     +				strbuf_write(&pp->children[i].err, stderr);
     +				strbuf_write(&pp->buffered_output, stderr);
    @@ run-command.c: void run_processes_parallel(const struct run_process_parallel_opt
      					   "max:%"PRIuMAX,
      					   (uintmax_t)opts->processes);
      
    -+	if (opts->ungroup && opts->consume_sideband)
    -+		BUG("ungroup and reading sideband are mutualy exclusive");
    ++	if (opts->ungroup && opts->consume_output)
    ++		BUG("ungroup and reading output are mutualy exclusive");
     +
      	/*
      	 * Child tasks might receive input via stdin, terminating early (or not), so
    @@ run-command.h: typedef int (*feed_pipe_fn)(int child_in,
      				void *pp_task_cb);
      
     +/**
    -+ * If this callback is provided, instead of collating process output to stderr,
    -+ * they will be collated into a new pipe. consume_sideband_fn will be called
    -+ * repeatedly. When output is available on that pipe, it will be contained in
    -+ * 'output'. But it will be called with an empty 'output' too, to allow for
    -+ * keepalives or similar operations if necessary.
    ++ * If this callback is provided, output is collated into a new pipe instead
    ++ * of the process stderr. Then `consume_output_fn` will be called repeatedly
    ++ * with output contained in the `output` arg. It will also be called with an
    ++ * empty `output` to allow for keepalives or similar operations if necessary.
     + *
     + * pp_cb is the callback cookie as passed into run_processes_parallel.
    -+ *
    -+ * Since this callback is provided with the collated output, no task cookie is
    -+ * provided.
    ++ * No task cookie is provided because the callback receives collated output.
     + */
    -+typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);
    ++typedef void (*consume_output_fn)(struct strbuf *output, void *pp_cb);
     +
      /**
       * This callback is called on every child process that finished processing.
    @@ run-command.h: struct run_process_parallel_opts
      	feed_pipe_fn feed_pipe;
      
     +	/*
    -+	 * consume_sideband: see consume_sideband_fn() above. This can be NULL
    ++	 * consume_output: see consume_output_fn() above. This can be NULL
     +	 * to omit any special handling.
     +	 */
    -+	consume_sideband_fn consume_sideband;
    ++	consume_output_fn consume_output;
     +
      	/**
      	 * task_finished: See task_finished_fn() above. This can be
    @@ t/helper/test-run-command.c: static int no_job(struct child_process *cp UNUSED,
      	return 0;
      }
      
    -+static void test_consume_sideband(struct strbuf *output, void *cb UNUSED)
    ++static void test_divert_output(struct strbuf *output, void *cb UNUSED)
     +{
    -+	FILE *sideband;
    ++	FILE *output_file;
     +
    -+	sideband = fopen("./sideband", "a");
    ++	output_file = fopen("./output_file", "a");
     +
    -+	strbuf_write(output, sideband);
    -+	fclose(sideband);
    ++	strbuf_write(output, output_file);
    ++	fclose(output_file);
     +}
     +
      static int task_finished(int result UNUSED,
    @@ t/helper/test-run-command.c: static int testsuite(int argc, const char **argv)
      		.get_next_task = next_test,
      		.start_failure = test_failed,
      		.feed_pipe = test_stdin_pipe_feed,
    -+		.consume_sideband = test_consume_sideband,
    ++		.consume_output = test_divert_output,
      		.task_finished = test_finished,
      		.data = &suite,
      	};
    @@ t/helper/test-run-command.c: int cmd__run_command(int argc, const char **argv)
      		opts.get_next_task = parallel_next;
      		opts.task_finished = task_finished_quiet;
      		opts.feed_pipe = test_stdin_pipe_feed;
    -+	} else if (!strcmp(argv[1], "run-command-sideband")) {
    ++	} else if (!strcmp(argv[1], "run-command-divert-output")) {
     +		opts.get_next_task = parallel_next;
    -+		opts.consume_sideband = test_consume_sideband;
    ++		opts.consume_output = test_divert_output;
     +		opts.task_finished = task_finished_quiet;
      	} else {
      		ret = 1;
    @@ t/t0061-run-command.sh: test_expect_success 'run_command runs ungrouped in paral
      '
      
     +test_expect_success 'run_command can divert output' '
    -+	test_when_finished rm sideband &&
    -+	test-tool run-command run-command-sideband 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
    ++	test_when_finished rm output_file &&
    ++	test-tool run-command run-command-divert-output 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
     +	test_must_be_empty actual &&
    -+	test_cmp expect sideband
    ++	test_cmp expect output_file
     +'
     +
      test_expect_success 'run_command listens to stdin' '
 8:  dc2de535a5 !  8:  1a21310174 hooks: allow callers to capture output
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
      		.get_next_task = pick_next_hook,
      		.start_failure = notify_start_failure,
      		.feed_pipe = options->feed_pipe,
    -+		.consume_sideband = options->consume_sideband,
    ++		.consume_output = options->consume_output,
      		.task_finished = notify_hook_finished,
      
      		.data = &cb_data,
     
      ## hook.h ##
     @@ hook.h: struct run_hooks_opt
    - 	 * Only useful when using run_hooks_opt.feed_pipe, otherwise ignore it.
    + 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
      	 */
      	void *feed_pipe_cb_data;
     +
    @@ hook.h: struct run_hooks_opt
     +	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
     +	 * for an example.
     +	 */
    -+	consume_sideband_fn consume_sideband;
    ++	consume_output_fn consume_output;
      };
      
      #define RUN_HOOKS_OPT_INIT { \
 9:  2f85907a2a !  9:  6a2895750a receive-pack: convert update hooks to new API
    @@ Commit message
         the specification of hooks via configs or running parallel hooks.
     
         Execution is still sequential through the current hook.[ch] via the
    -    run_proces_parallel_opts.processes=1 arg.
    +    run_process_parallel_opts.processes=1 arg.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      	if (use_sideband)
     -		copy_to_sideband(proc.err, -1, NULL);
     -	return finish_command(&proc);
    -+		opt.consume_sideband = hook_output_to_sideband;
    ++		opt.consume_output = hook_output_to_sideband;
     +
     +	return run_hooks_opt(the_repository, "update", &opt);
      }
    @@ builtin/receive-pack.c: static const char *update(struct command *cmd, struct sh
     -	proc.err = use_sideband ? -1 : 0;
     -	proc.trace2_hook_name = "post-update";
     +	if (use_sideband)
    -+		opt.consume_sideband = hook_output_to_sideband;
    ++		opt.consume_output = hook_output_to_sideband;
      
     -	if (!start_command(&proc)) {
     -		if (use_sideband)
10:  5dff0f4980 ! 10:  254e7dd351 receive-pack: convert receive hooks to hook API
    @@ Commit message
     
         I noticed a performance degradation when processing large amounts
         of hook input with just 1 line per callback, due to run-command's
    -    ppoll loop, therefore I batched 500 lines per callback, to ensure
    +    poll loop, therefore I batched 500 lines per callback, to ensure
         similar pipe throughput as before and to avoid hook child waiting
         on stdin.
     
    @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process
      					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
      					     nonce_stamp_slop);
      		}
    - 	}
    - }
    - 
    -+struct receive_hook_feed_context {
    -+	struct command *cmd;
    -+	int skip_broken;
    -+};
    -+
    - struct receive_hook_feed_state {
    - 	struct command *cmd;
    +@@ builtin/receive-pack.c: struct receive_hook_feed_state {
      	struct ref_push_report *report;
      	int skip_broken;
      	struct strbuf buf;
    @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process
     -typedef int (*feed_fn)(void *, const char **, size_t *);
     -static int run_and_feed_hook(const char *hook_name, feed_fn feed,
     -			     struct receive_hook_feed_state *feed_state)
    -+static int feed_receive_hook(int hook_stdin_fd, struct receive_hook_feed_state *state, int lines_batch_size)
    ++static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
      {
     -	struct child_process proc = CHILD_PROCESS_INIT;
     -	struct async muxer;
     -	int code;
     -	const char *hook_path = find_hook(the_repository, hook_name);
    ++	struct hook_cb_data *hook_cb = pp_cb;
    ++	struct receive_hook_feed_state *state = hook_cb->options->feed_pipe_cb_data;
     +	struct command *cmd = state->cmd;
    ++	unsigned int lines_batch_size = 500;
      
     -	if (!hook_path)
     -		return 0;
    @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process
     -			     (uintmax_t)feed_state->push_options->nr);
     -	} else
     -		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
    -+	/* batch lines to avoid going through run-command's ppoll for each line */
    -+	for (int i = 0; i < lines_batch_size; i++) {
    ++	/* batch lines to avoid going through run-command's poll loop for each line */
    ++	for (unsigned int i = 0; i < lines_batch_size; i++) {
     +		while (cmd &&
     +		       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
     +			cmd = cmd->next;
    @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process
      }
      
     -static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
    -+static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
    ++static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
      {
     -	struct receive_hook_feed_state *state = state_;
     -	struct command *cmd = state->cmd;
    -+	struct hook_cb_data *hook_cb = pp_cb;
    -+	struct receive_hook_feed_state *feed_state = hook_cb->options->feed_pipe_cb_data;
    - 
    +-
     -	while (cmd &&
     -	       state->skip_broken && (cmd->error_string || cmd->did_not_exist))
     -		cmd = cmd->next;
    @@ builtin/receive-pack.c: static void prepare_push_cert_sha1(struct child_process
     -	if (bufp) {
     -		*bufp = state->buf.buf;
     -		*sizep = state->buf.len;
    -+	/* first-time setup */
    -+	if (!hook_cb->options->feed_pipe_cb_data) {
    -+		struct receive_hook_feed_context *ctx = hook_cb->options->feed_pipe_ctx;
    -+		if (!ctx)
    -+			BUG("run_hooks_opt.feed_pipe_ctx required for receive hook");
    -+
    -+		hook_cb->options->feed_pipe_cb_data = xmalloc(sizeof(struct receive_hook_feed_state));
    -+		feed_state = hook_cb->options->feed_pipe_cb_data;
    -+		strbuf_init(&feed_state->buf, 0);
    -+		feed_state->cmd = ctx->cmd;
    -+		feed_state->skip_broken = ctx->skip_broken;
    -+		feed_state->report = NULL;
    - 	}
    +-	}
     -	return 0;
    -+
    -+	/* batch 500 lines at once to avoid going through the run-command ppoll loop too often */
    -+	if (feed_receive_hook(hook_stdin_fd, feed_state, 500) == 0)
    -+		return 0; /* still have more data to feed */
    -+
    -+	strbuf_release(&feed_state->buf);
    -+
    -+	if (hook_cb->options->feed_pipe_cb_data)
    -+		FREE_AND_NULL(hook_cb->options->feed_pipe_cb_data);
    -+
    -+	return 1; /* done feeding, run-command can close pipe */
    -+}
    -+
    -+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
    -+{
     +	if (output && output->len)
     +		send_sideband(1, 2, output->buf, output->len, use_sideband);
      }
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
      {
     -	struct receive_hook_feed_state state;
     -	int status;
    -+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    -+	struct receive_hook_feed_context ctx;
    -+	struct command *iter = commands;
    - 
    +-
     -	strbuf_init(&state.buf, 0);
     -	state.cmd = commands;
     -	state.skip_broken = skip_broken;
     -	state.report = NULL;
     -	if (feed_receive_hook(&state, NULL, NULL))
    ++	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
    ++	struct command *iter = commands;
    ++	struct receive_hook_feed_state *feed_state;
    ++	int ret;
    ++
     +	/* if there are no valid commands, don't invoke the hook at all. */
     +	while (iter && skip_broken && (iter->error_string || iter->did_not_exist))
     +		iter = iter->next;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +
     +	/* set up sideband printer */
     +	if (use_sideband)
    -+		opt.consume_sideband = hook_output_to_sideband;
    ++		opt.consume_output = hook_output_to_sideband;
     +
     +	/* set up stdin callback */
    -+	ctx.cmd = commands;
    -+	ctx.skip_broken = skip_broken;
    ++	feed_state = xmalloc(sizeof(struct receive_hook_feed_state));
    ++	feed_state->cmd = commands;
    ++	feed_state->skip_broken = skip_broken;
    ++	feed_state->report = NULL;
    ++	strbuf_init(&feed_state->buf, 0);
    ++	opt.feed_pipe_cb_data = feed_state;
     +	opt.feed_pipe = feed_receive_hook_cb;
    -+	opt.feed_pipe_ctx = &ctx;
     +
    -+	return run_hooks_opt(the_repository, hook_name, &opt);
    ++	ret = run_hooks_opt(the_repository, hook_name, &opt);
    ++
    ++	strbuf_release(&feed_state->buf);
    ++	FREE_AND_NULL(opt.feed_pipe_cb_data);
    ++
    ++	return ret;
      }
      
      static int run_update_hook(struct command *cmd)


Adrian Ratiu (2):
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
 builtin/receive-pack.c      | 271 +++++++++++++++---------------------
 commit.c                    |   3 +
 hook.c                      |  21 ++-
 hook.h                      |  51 +++++++
 refs.c                      | 101 +++++++-------
 run-command.c               | 110 +++++++++++++--
 run-command.h               |  39 ++++++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  67 ++++++++-
 t/t0061-run-command.sh      |  38 +++++
 transport.c                 |  95 +++++++------
 12 files changed, 562 insertions(+), 282 deletions(-)

-- 
2.51.0

