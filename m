Received: from sender4-pp-e105.zoho.com (sender4-pp-e105.zoho.com [136.143.188.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA132FA37
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636424; cv=pass; b=GCVLrhO36j1fnhz43QyvjbvhuYBXNpREqiW9WvuSD8oNtPFphjDYVfJ461xXzITqIiMxQLwUifo0VCy41xU+QF8KgmYZ8VMj5bBWOrMSHHUGyO7TddDnKtcrn6zQsNbJNKtaOgPtX8cAtCjJzdnLU4aoRFs33QYfNZIoyZCuGY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636424; c=relaxed/simple;
	bh=D5lvmTtGrKXA+kIU5eBWRg3mm7d3u1qXn2352cMd320=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osUEGy5hsSzWY5UnbbUZ+mU5Rr9AVea+07bEH0KD2EypfeNmbFn2InY1M2NJ6donQX+oV/F/Us4et8uIEG4z2Xl7Q/pbNq+ByiY4omnNj/cx/62dBkMJluqB+HQPISg6dUJVsdmeu+oTb/Qm1tjoPDkCH5Dha6XWa4/QYnjIk48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OvE4eCIg; arc=pass smtp.client-ip=136.143.188.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OvE4eCIg"
ARC-Seal: i=1; a=rsa-sha256; t=1769636391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OCBSEnWVZ7fcXgQs7G1RK5rjlnjbqCa+14Ajy38Mxg0KGxI3BbZMQyrNhKhct/72gTDXA+YnYYzYXdQ/mFQG/9y1qQ0IinOI29mE2jkx+juAL3TjnbkCxYSXMcpnMNABGttG8cgNOwd2c9bnj65wmIEcoWu/Me7WC0VncbelZxo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636391; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iPSoNJKHsVvF7mKSCXAwapauppmRYQsETguyVopZ3t4=; 
	b=HNZXsSfuaMMlGVWY1eeJryXKLmMxRExsg3y6SEm7Brt/PzMKgfe5YT+lhx2m4A3Aqk08999RfQpGG3JNgDqbge+JStqjTIs3DQkOUqD8Qj4yrMq+iyusmJVRQ3jKbs4AIhvJmxTSrdKSEHTArZOeCgHjZhqMpWazSLmESAue250=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636391;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iPSoNJKHsVvF7mKSCXAwapauppmRYQsETguyVopZ3t4=;
	b=OvE4eCIg99+EV4J8kDNlDCpV7jlo5NTCIsMnB7SNKWxY1hSJGVgvZ2g1AAd0JqlM
	3CIS05ThOC1RRrqr+rD8HOVsnCSuBp4EHsCNDxe7SwhMi9uq2xvSNZ3gS7ZfSoEqWvb
	4hu1sq0SKy1Dcpqj7xfT+sJnVm1Vx1CsMX1nlnO0=
Received: by mx.zohomail.com with SMTPS id 1769636388328130.37783904507785;
	Wed, 28 Jan 2026 13:39:48 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 00/12] Convert remaining hooks to hook.h
Date: Wed, 28 Jan 2026 23:39:15 +0200
Message-ID: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
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

v8 is just cleanups, function helpers and a bug fix, otherwise the new
design introduced in v7 is still the same. Especially I tried to clarify
the "muxer" sideband thread confusion with better explanations in comments
and commit messages.

Many thanks to all who contributed, it is appreciated!

This is based on the latest master branch, there are no conflicts with
next and seen, the code is available on GitHub and CI passes.

GitHub: https://github.com/10ne1/git/tree/dev/aratiu/hooks-conversion-v8
CI run: https://github.com/10ne1/git/actions/runs/21455314718

Changes in v8:
* Extensive parallel hook testing on Windows revealed a rare segfault triggered
  by non-posix poll behavior, due to not checking the opts->feed_pipe() pointer
  before calling it. It's fixed now by null-checking the pointer. (Adrian)
* Split t1800-hook test additions inte smaller independent tests, improved code
  reuse & symmetry and split long lines (Junio)
* Improve header description of stdout_to_stderr (Patrick)
* Replaced .ungroup = options->jobs <= 1, with .ungroup = options->jobs == 1
  because jobs can't be lower than 1, so the test is a bit clearer. (Adrian)
* Introduce a new "child_is_sending_output" run-command helper  (Emily, Junio)
* Rename muxer thread and associated var to sideband_async for clarity
  and reword commits to avoid "muxer" confusion (Emily, Adrian)
* Factored out common sideband async logic into helpers (Emily, Adrian)
* Fixed Suggested-by -> Helped-by tags and authorship (Adrian, Kristoffer)
* Commit message rewording improvements, tried to more clearly explain the
  new design (Emily, Junio, Patrick, Kristoffer)

Range-diff v7 -> v8:
 1:  aff497683c <  -:  ---------- t1800: add hook output stream tests
 -:  ---------- >  1:  235337faa0 t1800: add hook output stream tests
 2:  a76027c3c6 !  2:  b880fe5210 run-command: add first helper for pp child states
    @@ Metadata
     Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
    -    run-command: add first helper for pp child states
    +    run-command: add helper for pp child states
     
         There is a recurring pattern of testing parallel process child states
         and file descriptors to determine if a child is running, receiving any
         input or if it's ready for cleanup.
     
    -    Name the pp_child structure and introduce a first helper to make these
    -    checks more readable. Next commits will add more helpers and checks.
    +    Name the pp_child structure and introduce a helper to make the checks
    +    more readable.
     
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
 3:  a0969bbf3f =  3:  66c9f35c44 run-command: add stdin callback for parallelization
 4:  43156cdfc4 =  4:  2f8b92923f hook: provide stdin via callback
 5:  0cfd9ade6e =  5:  1e0425700d hook: convert 'post-rewrite' hook in sequencer.c to hook API
 6:  bb059a7508 !  6:  957a8d4636 hook: allow separate std[out|err] streams
    @@ Metadata
      ## Commit message ##
         hook: allow separate std[out|err] streams
     
    -    The hook API assumed that all hooks merge stdout to stderr.
    +    The hook API assumes that all hooks merge stdout to stderr.
     
         This assumption is proven wrong by pre-push: some of its users
         actually expect separate stdout and stderr streams and merging
    @@ hook.h: struct run_hooks_opt
      
     +	/**
     +	 * Send the hook's stdout to stderr.
    ++	 *
    ++	 * This is the default behavior for all hooks except pre-push,
    ++	 * which has separate stdout and stderr streams for backwards
    ++	 * compatibility reasons.
     +	 */
     +	unsigned int stdout_to_stderr:1;
     +
 7:  7d14404316 =  7:  44005c911b transport: convert pre-push to hook API
 8:  c4a43509b8 =  8:  580197c9f7 reference-transaction: use hook API instead of run-command
 9:  9336d6d752 !  9:  097cd066e3 hook: add jobs option
    @@ Commit message
         This allows us to both pave the way for parallel hook execution
         (that will be a follow-up patch series building upon this) and to
         finish the API conversion of builtin/receive-pack.c, keeping the
    -    output muxer thread design as Peff suggested.
    +    output async sideband thread ("muxer") design as Peff suggested.
     
    -    When .jobs == 1 nothing changes, the simple "copy_to_sideband" mux
    +    When .jobs==1 nothing changes, the "copy_to_sideband" async thread
         still outputs directly via sideband channel 2, keeping the current
    -    (mostly) real-time output characteristics, avoids unecessary poll
    +    (mostly) real-time output characteristics, avoids unnecessary poll
         delays or deadlock risks.
     
    -    When .jobs > 1, a more complex muxer is needed, to buffer the hook
    +    When .jobs > 1, a more complex muxer is needed to buffer the hook
         output and avoid interleaving. After working on this mux I quickly
         realized I was re-implementing run-command with ungroup=0 so that
    -    ideas was dropped in favor of run-command which outputs to stderr.
    -    Then run-command's stderr just connects to the simple muxer input.
    +    idea was dropped in favor of run-command which outputs to stderr.
     
    -    Maybe it's better to understand using ascii graphics:
    +    In other words, run-command itself already can buffer/deinterleave
    +    pp child outputs (ungroup=0), so we can just connect its stderr to
    +    the sideband async task when jobs > 1.
    +
    +    Maybe it helps to illustrate how it works with ascii graphics:
     
          [ Sequential (jobs = 1) ]             [ Parallel (jobs > 1) ]
     
    @@ Commit message
          |                           |                                 |
          |                           | (dup2'd to pipe)                |
          |                           v                                 |
    -     |               +-------------------------+                   |
    -     |               | sideband "muxer" thread |                   |
    -     |               +-------------------------+                   |
    +     |               +-----------------------+                     |
    +     |               | sideband async thread |                     |
    +     |               +-----------------------+                     |
          +-------------------------------------------------------------+
     
    -    When use_sideband == 0, the sideband muxer thread is missing, so
    -    the same architecture just outputs via the parent stderr stream.
    +    When use_sideband == 0, the sideband async thread is missing, so
    +    this same architecture just outputs via the parent stderr stream.
     
         See the following commits for the hook API conversions doing this,
         using pre-existing sideband thread logic from `copy_to_sideband`.
    @@ hook.c: int run_hooks_opt(struct repository *r, const char *hook_name,
     -		.processes = 1,
     -		.ungroup = 1,
     +		.processes = options->jobs,
    -+		.ungroup = options->jobs <= 1,
    ++		.ungroup = options->jobs == 1,
      
      		.get_next_task = pick_next_hook,
      		.start_failure = notify_start_failure,
10:  1fac0e1894 ! 10:  b7ffb59fb5 run-command: poll child stdin in addition to stdout
    @@ Metadata
     Author: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## Commit message ##
    -    run-command: poll child stdin in addition to stdout
    +    run-command: poll child input in addition to output
     
         Child input feeding might hit the 100ms output poll timeout as a
         side-effect of the ungroup=0 design when feeding multiple children
         in parallel and buffering their outputs.
     
    -    This throttles the write throughtput as reported by Kristoffer.
    +    This throttles the write throughput as reported by Kristoffer.
     
         Peff also noted that the parent might block if the write pipe is full
         and cause a deadlock if both parent + child wait for one another.
    @@ Commit message
         responsiveness for (sideband) output.
     
         It's worth noting that in our current design, sequential execution
    -    is not affected by this because it still uses the ungroup=1 behavior.
    +    is not affected by this because it still uses the ungroup=1 behavior,
    +    so there are no run-command induced buffering delays since the child
    +    sequentially outputs directly to the parent-inherited fds.
     
         Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
         Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## run-command.c ##
    +@@ run-command.c: static int child_is_receiving_input(const struct parallel_child *pp_child)
    + {
    + 	return child_is_working(pp_child) && pp_child->process.in > 0;
    + }
    ++static int child_is_sending_output(const struct parallel_child *pp_child)
    ++{
    ++	/*
    ++	 * all pp children which buffer output through run_command via ungroup=0
    ++	 * redirect stdout to stderr, so we just need to check process.err.
    ++	 */
    ++	return child_is_working(pp_child) && pp_child->process.err > 0;
    ++}
    + 
    + struct parallel_processes {
    + 	size_t nr_processes;
     @@ run-command.c: static void pp_init(struct parallel_processes *pp,
      
      	CALLOC_ARRAY(pp->children, n);
    @@ run-command.c: static void pp_buffer_stdin(struct parallel_processes *pp,
     -	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
     +	/* for each potential child slot, prepare two pollfd entries */
     +	for (size_t i = 0; i < opts->processes; i++) {
    -+		if (child_is_working(&pp->children[i]) &&
    -+		    pp->children[i].process.err > 0) {
    ++		if (child_is_sending_output(&pp->children[i])) {
     +			pp->pfd[2*i].fd = pp->children[i].process.err;
     +			pp->pfd[2*i].events = POLLIN | POLLHUP;
     +		} else {
    @@ run-command.c: static void pp_buffer_stdin(struct parallel_processes *pp,
      	for (size_t i = 0; i < opts->processes; i++) {
     +		/* Handle input feeding (stdin) */
     +		if (pp->pfd[2*i+1].revents & (POLLOUT | POLLHUP | POLLERR)) {
    -+			int ret = opts->feed_pipe(pp->children[i].process.in,
    -+						  opts->data,
    -+						  pp->children[i].data);
    -+			if (ret < 0)
    -+				die_errno("feed_pipe");
    -+			if (ret) {
    ++			if (opts->feed_pipe) {
    ++				int ret = opts->feed_pipe(pp->children[i].process.in,
    ++							  opts->data,
    ++							  pp->children[i].data);
    ++				if (ret < 0)
    ++					die_errno("feed_pipe");
    ++				if (ret) {
    ++					/* done feeding */
    ++					close(pp->children[i].process.in);
    ++					pp->children[i].process.in = 0;
    ++				}
    ++			} else {
    ++				/*
    ++				 * No feed_pipe means there is nothing to do, so
    ++				 * close the fd. Child input can be fed by other
    ++				 * methods, such as opts->path_to_stdin which
    ++				 * slurps a file via dup2, so clean up here.
    ++				 */
     +				close(pp->children[i].process.in);
     +				pp->children[i].process.in = 0;
     +			}
11:  d9e48a9224 <  -:  ---------- receive-pack: convert update hooks to new API
 -:  ---------- > 11:  b496510399 receive-pack: convert update hooks to new API
12:  f8887c53e6 ! 12:  fa24bf9032 receive-pack: convert receive hooks to hook API
    @@
      ## Metadata ##
    -Author: Adrian Ratiu <adrian.ratiu@collabora.com>
    +Author: Emily Shaffer <nasamuffin@google.com>
     
      ## Commit message ##
         receive-pack: convert receive hooks to hook API
    @@ Commit message
         signals, manage custom struct child_process, call find_hook(),
         prepares for specifying hooks via configs, etc.).
     
    -    See the previous four commits for a more details explanation how
    -    this all works.
    +    See the previous three commits for a more in-depth explanation of
    +    how this all works.
     
    -    Suggested-by: Jeff King <peff@peff.net>
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
     
      ## builtin/receive-pack.c ##
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
     +	struct command *iter = commands;
     +	struct receive_hook_feed_state feed_state;
    -+	struct async muxer;
    -+	int ret;
    ++	struct async sideband_async;
    ++	int sideband_async_started = 0;
     +	int saved_stderr = -1;
    -+	int muxer_started = 0;
    ++	int ret;
      
     -	strbuf_init(&state.buf, 0);
     -	state.cmd = commands;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +
     +	prepare_push_cert_sha1(&opt);
     +
    -+	if (use_sideband) {
    -+		memset(&muxer, 0, sizeof(muxer));
    -+		muxer.proc = copy_to_sideband;
    -+		muxer.in = -1;
    -+		if (!start_async(&muxer)) {
    -+			muxer_started = 1;
    -+			saved_stderr = dup(STDERR_FILENO);
    -+			if (saved_stderr >= 0)
    -+				dup2(muxer.in, STDERR_FILENO);
    -+			close(muxer.in);
    -+		}
    -+	}
    ++	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
     +
     +	/* set up stdin callback */
     +	feed_state.cmd = commands;
    @@ builtin/receive-pack.c: static int run_receive_hook(struct command *commands,
     +	ret = run_hooks_opt(the_repository, hook_name, &opt);
     +
     +	strbuf_release(&feed_state.buf);
    -+	if (saved_stderr >= 0) {
    -+		dup2(saved_stderr, STDERR_FILENO);
    -+		close(saved_stderr);
    -+	}
    -+	if (muxer_started)
    -+		finish_async(&muxer);
    ++	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
     +
     +	return ret;
      }


Adrian Ratiu (6):
  t1800: add hook output stream tests
  run-command: add helper for pp child states
  hook: allow separate std[out|err] streams
  reference-transaction: use hook API instead of run-command
  hook: add jobs option
  run-command: poll child input in addition to output

Emily Shaffer (6):
  run-command: add stdin callback for parallelization
  hook: provide stdin via callback
  hook: convert 'post-rewrite' hook in sequencer.c to hook API
  transport: convert pre-push to hook API
  receive-pack: convert update hooks to new API
  receive-pack: convert receive hooks to hook API

 builtin/receive-pack.c      | 283 ++++++++++++++++++------------------
 hook.c                      |  32 +++-
 hook.h                      |  57 ++++++++
 refs.c                      | 102 ++++++-------
 run-command.c               | 174 ++++++++++++++++++----
 run-command.h               |  21 +++
 sequencer.c                 |  42 +++---
 t/helper/test-run-command.c |  52 ++++++-
 t/t0061-run-command.sh      |  31 ++++
 t/t1800-hook.sh             | 137 +++++++++++++++++
 transport.c                 |  95 ++++++------
 11 files changed, 743 insertions(+), 283 deletions(-)

-- 
2.52.0.732.gb351b5166d.dirty

