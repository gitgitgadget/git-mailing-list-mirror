Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA20E2F6911
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710641; cv=pass; b=WCOA3FZygYGLprrw8gkBMrA3xP3z9WRKCPdjsRJ7ljXeBBSCu565CS6hfl+LzwGfgXDF9gGF6D3K03jff06EHEExHHaCiFViQJrqeQuZeQM2dExK0SoPMTC5JFqCxoRZU642m9gRAqtRzUY1dWsOCYeLAPUCMl27RGVWNIhjOBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710641; c=relaxed/simple;
	bh=XRCI8R7ubTU4gnlzwvKxgRDU8BxL0GHDMsWhlDpNLkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCiUt+6IBB1DZt4aX6kDKdPYVIYC0v0msUHhdraW6LORu88T7KggIZ7Wvo4baXuEntTQ24XR8ZXwgEPatjPLahaHQr+J42N9EBwEhHHYPpJv/FPUWE80U6EslRALfPv9O8L32n8k4FFSfOT2HF72wPOvuEe+dR1cU2T8GFYtuoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=JlNjhHXH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="JlNjhHXH"
ARC-Seal: i=1; a=rsa-sha256; t=1760710628; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qc/3RwTN0p85VpU0qrSU1sp21dqim+BUeh3D5M9dGe9fsSnms9bqsfcxVp0/boFZu+HQMAhFaJ1FVW9A9HWirOupWkKsnXl0uk/kjo7NSyUS+bwAPMAOEPd2cvZSeg/7a29cUsvi3ycfFIHOsi7J8Lo6UAMrpTXkOIdO6igQ8JU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710628; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RX0dsl1ovGyGO9Tn9qEKWzgZ4yJ3bjpHYSWKNmM8ntY=; 
	b=M/UFPJTa1pSLsv72OlwDPjuIWIp67T/ULcc1AgQH8+zKM2B30jMRyoyWkJLLg5mO8H445SGXIj2fyNWOURTswjSbtti7zvJEifx/DrCAs4yeOJ4r+/za7XqXcTsSpWOlz6Nu367US2y+p5DuNVkKFpCe8WKtfJLqNSe1FMODf3w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710628;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RX0dsl1ovGyGO9Tn9qEKWzgZ4yJ3bjpHYSWKNmM8ntY=;
	b=JlNjhHXHT5jlIbWQdeLWgRWlLVjB2z47Vd0UZueslAil0qmQCLEfIQG40HxNRl5e
	anOCGX4puIRmKtepseyBBRfxrWoy/Xl3eBRHk8qEdYmPzRPvJmcLLbCNe94vztt04N0
	sqdTkMSlKCVFHKKiuI3++Ld0S8AC3adBxWdzFfF0=
Received: by mx.zohomail.com with SMTPS id 1760710625537755.6696679986443;
	Fri, 17 Oct 2025 07:17:05 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 01/10] run-command: add stdin callback for parallelization
Date: Fri, 17 Oct 2025 17:15:35 +0300
Message-ID: <20251017141544.1538542-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
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

If a user of the run_processes_parallel() API wants to pipe a large
amount of information to the stdin of each parallel command, that
data could exceed the pipe buffer of the process's stdin and can be
too big to store in-memory via strbuf & friends or to slurp to a file.

Generally this is solved by repeatedly writing to child_process.in
between calls to start_command() and finish_command(). For a specific
pre-existing example of this, see transport.c:run_pre_push_hook().

This adds a generic callback API to run_processes_parallel() to do
exactly that in a unified manner, similar to the existing callback APIs,
which can then be used by hooks.h to convert the remaining hooks to the
new, simpler parallel interface.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c               | 82 +++++++++++++++++++++++++++++++++----
 run-command.h               | 22 ++++++++++
 t/helper/test-run-command.c | 52 ++++++++++++++++++++++-
 t/t0061-run-command.sh      | 31 ++++++++++++++
 4 files changed, 178 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index ed9575bd6a..5bc6db5bb1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1652,6 +1652,44 @@ static int pp_start_one(struct parallel_processes *pp,
 	return 0;
 }
 
+static void pp_buffer_stdin(struct parallel_processes *pp,
+			    const struct run_process_parallel_opts *opts)
+{
+	/* Buffer stdin for each pipe. */
+	for (ssize_t i = 0; i < opts->processes; i++) {
+		struct child_process *proc = &pp->children[i].process;
+		int ret;
+
+		if (pp->children[i].state != GIT_CP_WORKING || proc->in <= 0)
+			continue;
+
+		/*
+		 * child input is provided via path_to_stdin when the feed_pipe cb is
+		 * missing, so we just signal an EOF.
+		 */
+		if (!opts->feed_pipe) {
+			close(proc->in);
+			proc->in = 0;
+			continue;
+		}
+
+		/**
+		 * Feed the pipe:
+		 *   ret < 0 means error
+		 *   ret == 0 means there is more data to be fed
+		 *   ret > 0 means feeding finished
+		 */
+		ret = opts->feed_pipe(proc->in, opts->data, pp->children[i].data);
+		if (ret < 0)
+			die_errno("feed_pipe");
+
+		if (ret) {
+			close(proc->in);
+			proc->in = 0;
+		}
+	}
+}
+
 static void pp_buffer_stderr(struct parallel_processes *pp,
 			     const struct run_process_parallel_opts *opts,
 			     int output_timeout)
@@ -1722,6 +1760,7 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		pp->children[i].state = GIT_CP_FREE;
 		if (pp->pfd)
 			pp->pfd[i].fd = -1;
+		pp->children[i].process.in = 0;
 		child_process_init(&pp->children[i].process);
 
 		if (opts->ungroup) {
@@ -1756,6 +1795,32 @@ static int pp_collect_finished(struct parallel_processes *pp,
 	return result;
 }
 
+static void pp_handle_child_IO(struct parallel_processes *pp,
+				const struct run_process_parallel_opts *opts,
+				int output_timeout)
+{
+	/*
+	 * First push input, if any (it might no-op), to child tasks to avoid them blocking
+	 * after input. This also prevents deadlocks when ungrouping below, if a child blocks
+	 * while the parent also waits for them to finish.
+	 */
+	pp_buffer_stdin(pp, opts);
+
+	if (opts->ungroup) {
+		for (size_t i = 0; i < opts->processes; i++) {
+			int child_ready_for_cleanup =
+				pp->children[i].state == GIT_CP_WORKING &&
+				pp->children[i].process.in == 0;
+
+			if (child_ready_for_cleanup)
+				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
+		}
+	} else {
+		pp_buffer_stderr(pp, opts, output_timeout);
+		pp_output(pp);
+	}
+}
+
 void run_processes_parallel(const struct run_process_parallel_opts *opts)
 {
 	int i, code;
@@ -1775,6 +1840,13 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	/*
+	 * Child tasks might receive input via stdin, terminating early (or not), so
+	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
+	 * actually writes the data to children stdin fds.
+	 */
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	pp_init(&pp, opts, &pp_sig);
 	while (1) {
 		for (i = 0;
@@ -1792,13 +1864,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		}
 		if (!pp.nr_processes)
 			break;
-		if (opts->ungroup) {
-			for (size_t i = 0; i < opts->processes; i++)
-				pp.children[i].state = GIT_CP_WAIT_CLEANUP;
-		} else {
-			pp_buffer_stderr(&pp, opts, output_timeout);
-			pp_output(&pp);
-		}
+		pp_handle_child_IO(&pp, opts, output_timeout);
 		code = pp_collect_finished(&pp, opts);
 		if (code) {
 			pp.shutdown = 1;
@@ -1809,6 +1875,8 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 
 	pp_cleanup(&pp, opts);
 
+	sigchain_pop(SIGPIPE);
+
 	if (do_trace2)
 		trace2_region_leave(tr2_category, tr2_label, NULL);
 }
diff --git a/run-command.h b/run-command.h
index 0df25e445f..e536ed7544 100644
--- a/run-command.h
+++ b/run-command.h
@@ -420,6 +420,22 @@ typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * This callback is repeatedly called on every child process who requests
+ * start_command() to create a pipe by setting child_process.in < 0.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel, and
+ * pp_task_cb is the callback cookie as passed into get_next_task_fn.
+ * The contents of 'send' will be read into the pipe and passed to the pipe.
+ *
+ * Returns < 0 for error
+ * Returns == 0 when there is more data to be fed (will be called again)
+ * Returns > 0 when finished (child closed fd or no more data to be fed)
+ */
+typedef int (*feed_pipe_fn)(int child_in,
+				void *pp_cb,
+				void *pp_task_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -473,6 +489,12 @@ struct run_process_parallel_opts
 	 */
 	start_failure_fn start_failure;
 
+	/*
+	 * feed_pipe: see feed_pipe_fn() above. This can be NULL to omit any
+	 * special handling.
+	 */
+	feed_pipe_fn feed_pipe;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3719f23cc2..dfdb03b3ab 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -23,19 +23,26 @@ static int number_callbacks;
 static int parallel_next(struct child_process *cp,
 			 struct strbuf *err,
 			 void *cb,
-			 void **task_cb UNUSED)
+			 void **task_cb)
 {
 	struct child_process *d = cb;
 	if (number_callbacks >= 4)
 		return 0;
 
 	strvec_pushv(&cp->args, d->args.v);
+	cp->in = d->in;
+	cp->no_stdin = d->no_stdin;
 	if (err)
 		strbuf_addstr(err, "preloaded output of a child\n");
 	else
 		fprintf(stderr, "preloaded output of a child\n");
 
 	number_callbacks++;
+
+	/* test_stdin callback will use this to count remaining lines */
+	*task_cb = xmalloc(sizeof(int));
+	*(int*)(*task_cb) = 2;
+
 	return 1;
 }
 
@@ -54,15 +61,48 @@ static int no_job(struct child_process *cp UNUSED,
 static int task_finished(int result UNUSED,
 			 struct strbuf *err,
 			 void *pp_cb UNUSED,
-			 void *pp_task_cb UNUSED)
+			 void *pp_task_cb)
 {
 	if (err)
 		strbuf_addstr(err, "asking for a quick stop\n");
 	else
 		fprintf(stderr, "asking for a quick stop\n");
+	if (pp_task_cb)
+		FREE_AND_NULL(pp_task_cb);
 	return 1;
 }
 
+static int task_finished_quiet(int result UNUSED,
+			       struct strbuf *err UNUSED,
+			       void *pp_cb UNUSED,
+			       void *pp_task_cb)
+{
+	if (pp_task_cb)
+		FREE_AND_NULL(pp_task_cb);
+	return 0;
+}
+
+static int test_stdin_pipe_feed(int hook_stdin_fd, void *cb UNUSED, void *task_cb)
+{
+	int *lines_remaining = task_cb;
+
+	if (*lines_remaining) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addf(&buf, "sample stdin %d\n", --(*lines_remaining));
+		if (write_in_full(hook_stdin_fd, buf.buf, buf.len) < 0) {
+			if (errno == EPIPE) {
+				/* child closed stdin, nothing more to do */
+				strbuf_release(&buf);
+				return 1;
+			}
+			die_errno("write");
+		}
+		strbuf_release(&buf);
+	}
+
+	return !(*lines_remaining);
+}
+
 struct testsuite {
 	struct string_list tests, failed;
 	int next;
@@ -157,6 +197,7 @@ static int testsuite(int argc, const char **argv)
 	struct run_process_parallel_opts opts = {
 		.get_next_task = next_test,
 		.start_failure = test_failed,
+		.feed_pipe = test_stdin_pipe_feed,
 		.task_finished = test_finished,
 		.data = &suite,
 	};
@@ -460,12 +501,19 @@ int cmd__run_command(int argc, const char **argv)
 
 	if (!strcmp(argv[1], "run-command-parallel")) {
 		opts.get_next_task = parallel_next;
+		opts.task_finished = task_finished_quiet;
 	} else if (!strcmp(argv[1], "run-command-abort")) {
 		opts.get_next_task = parallel_next;
 		opts.task_finished = task_finished;
 	} else if (!strcmp(argv[1], "run-command-no-jobs")) {
 		opts.get_next_task = no_job;
 		opts.task_finished = task_finished;
+	} else if (!strcmp(argv[1], "run-command-stdin")) {
+		proc.in = -1;
+		proc.no_stdin = 0;
+		opts.get_next_task = parallel_next;
+		opts.task_finished = task_finished_quiet;
+		opts.feed_pipe = test_stdin_pipe_feed;
 	} else {
 		ret = 1;
 		fprintf(stderr, "check usage\n");
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 76d4936a87..2f77fde0d9 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -164,6 +164,37 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command listens to stdin' '
+	cat >expect <<-\EOF &&
+	preloaded output of a child
+	listening for stdin:
+	sample stdin 1
+	sample stdin 0
+	preloaded output of a child
+	listening for stdin:
+	sample stdin 1
+	sample stdin 0
+	preloaded output of a child
+	listening for stdin:
+	sample stdin 1
+	sample stdin 0
+	preloaded output of a child
+	listening for stdin:
+	sample stdin 1
+	sample stdin 0
+	EOF
+
+	write_script stdin-script <<-\EOF &&
+	echo "listening for stdin:"
+	while read line
+	do
+		echo "$line"
+	done
+	EOF
+	test-tool run-command run-command-stdin 2 ./stdin-script 2>actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 asking for a quick stop
-- 
2.49.1

