Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941B81F2B88
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804884; cv=pass; b=K4D08peOL1CTEY6DMq+5BJkMpmmu6sMO07sODLzQjWb5W/C73yzHfnbxavORTd97wpbkJVc8re7ZmmPVDwenas9Go9l9XGbRHUXzLZezFEOLwPoSQVsjcib0rUrtcIKXvfv1+nIwIDKjCx9vZSKV8zjg1vnpjlMyq35NZv/OnNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804884; c=relaxed/simple;
	bh=+hrC7fhaFX7u6dhC8pEOr6Jr+ZcLP57IHCFNx4UZQek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn6twHCg60TlgCnRxs5uEMeOgf9Fjr1lit1CBVE+xz6Va0yRkVMq2/0oGRi1+jXPIdc9OOjyjyPdFwNJANRrQSba9uDzh7If7PTIhN9t369PLFL+pNF7vHVYf0FY7jgw52CCc6r6clbc7Fo1l8Ngk45nDezSlHfI5S6YMZ8IgUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=EO72mDup; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="EO72mDup"
ARC-Seal: i=1; a=rsa-sha256; t=1758804871; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IrQHfYgkHOaxGoEvTT8b72DQllD9qGQsMQGb5kpFW/g8V8a1npi9gB5DQiDUu1DnbRG5Ss4+eNmr+AQSMtheFiQl4IU4/8Fg4FHkFduh+XFR5w5kIfX+n7gHDRaHTlC5lwYe71pWC865zvQZuTNcZaCZVHjU+YUd6YI5pENXvck=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804871; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fMLhQX84vHpPUwhokE/4r3ZSVs2eroaehcTMyWsTjWI=; 
	b=nMgK2NT86ZBxEtJkOBYx75wDj9hnUM/7B5sTbmg7c/+v3ETuf1nXoRrEkydAM2lA0Hj6hqy3TRAcUfNeZgaSxkZqIa7Tj+i4sXMuYFSsTgOlRUn+RXZQE8cp1Tnf44liwA7Tw8d93UHqVflOboX2xcqRushQ9yi8Hgv8tM30vNs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804871;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fMLhQX84vHpPUwhokE/4r3ZSVs2eroaehcTMyWsTjWI=;
	b=EO72mDupZVBfcaws3SJUapaOJdotS/Yb4OoXgAQj94peZ4ZKegzbNSxsGZ2NkQla
	Sw0hK7kjn0oBmfEs0AF4B7wQp3jx1+/gA8zCpSJYEbBtajUqdUU/cGa4Oiat6xiaDg1
	2rkeX3KjqxuWnoA6kLMZVmyVjn27stkIKQ41dIRg=
Received: by mx.zohomail.com with SMTPS id 17588048698091013.292786616713;
	Thu, 25 Sep 2025 05:54:29 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 06/10] run-command: allow capturing of collated output
Date: Thu, 25 Sep 2025 15:53:49 +0300
Message-ID: <20250925125352.1728840-7-adrian.ratiu@collabora.com>
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

Some callers, for example server-side hooks which wish to relay hook
output to clients across a transport, want to capture what would
normally print to stderr and do something else with it. Allow that via a
callback.

By calling the callback regardless of whether there's output available,
we allow clients to send e.g. a keepalive if necessary.

Because we expose a strbuf, not a fd or FILE*, there's no need to create
a temporary pipe or similar - we can just skip the print to stderr and
instead hand it to the caller.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/fetch.c             |  2 +-
 builtin/submodule--helper.c |  2 +-
 hook.c                      |  2 +-
 run-command.c               | 33 ++++++++++++++++++++++++---------
 run-command.h               | 22 +++++++++++++++++++++-
 submodule.c                 |  2 +-
 t/helper/test-run-command.c | 15 +++++++++++++++
 t/t0061-run-command.sh      |  7 +++++++
 8 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24645c4653..53bd5552c4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2129,7 +2129,7 @@ static int fetch_multiple(struct string_list *list, int max_children,
 
 	if (max_children != 1 && list->nr != 1) {
 		struct parallel_fetch_state state = { argv.v, list, 0, 0, config };
-		const struct run_process_parallel_opts opts = {
+		struct run_process_parallel_opts opts = {
 			.tr2_category = "fetch",
 			.tr2_label = "parallel/fetch",
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..76cae9f015 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2700,7 +2700,7 @@ static int update_submodules(struct update_data *update_data)
 {
 	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
-	const struct run_process_parallel_opts opts = {
+	struct run_process_parallel_opts opts = {
 		.tr2_category = "submodule",
 		.tr2_label = "parallel/update",
 
diff --git a/hook.c b/hook.c
index 54568d5bc0..199c210b97 100644
--- a/hook.c
+++ b/hook.c
@@ -135,7 +135,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	};
 	const char *const hook_path = find_hook(r, hook_name);
 	int ret = 0;
-	const struct run_process_parallel_opts opts = {
+	struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
diff --git a/run-command.c b/run-command.c
index 6c455a0e43..c0ef771ff4 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1578,7 +1578,10 @@ static void pp_cleanup(struct parallel_processes *pp,
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (opts->consume_sideband)
+		opts->consume_sideband(&pp->buffered_output, opts->data);
+	else
+		strbuf_write(&pp->buffered_output, stderr);
 	strbuf_release(&pp->buffered_output);
 
 	sigchain_pop_common();
@@ -1717,13 +1720,17 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	}
 }
 
-static void pp_output(const struct parallel_processes *pp)
+static void pp_output(const struct parallel_processes *pp,
+		      const struct run_process_parallel_opts *opts)
 {
 	size_t i = pp->output_owner;
 
 	if (pp->children[i].state == GIT_CP_WORKING &&
 	    pp->children[i].err.len) {
-		strbuf_write(&pp->children[i].err, stderr);
+		if (opts->consume_sideband)
+			opts->consume_sideband(&pp->children[i].err, opts->data);
+		else
+			strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1771,11 +1778,15 @@ static int pp_collect_finished(struct parallel_processes *pp,
 		} else {
 			const size_t n = opts->processes;
 
-			strbuf_write(&pp->children[i].err, stderr);
+			/* Output errors, then all other finished child processes */
+			if (opts->consume_sideband) {
+				opts->consume_sideband(&pp->children[i].err, opts->data);
+				opts->consume_sideband(&pp->buffered_output, opts->data);
+			} else {
+				strbuf_write(&pp->children[i].err, stderr);
+				strbuf_write(&pp->buffered_output, stderr);
+			}
 			strbuf_reset(&pp->children[i].err);
-
-			/* Output all other finished child processes */
-			strbuf_write(&pp->buffered_output, stderr);
 			strbuf_reset(&pp->buffered_output);
 
 			/*
@@ -1819,10 +1830,10 @@ static void pp_handle_child_IO(struct parallel_processes *pp,
 	}
 
 	pp_buffer_stderr(pp, opts, output_timeout);
-	pp_output(pp);
+	pp_output(pp, opts);
 }
 
-void run_processes_parallel(const struct run_process_parallel_opts *opts)
+void run_processes_parallel(struct run_process_parallel_opts *opts)
 {
 	int i, code;
 	int output_timeout = 100;
@@ -1841,6 +1852,10 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	/* ungroup and reading sideband are mutualy exclusive, so disable ungroup */
+	if (opts->ungroup && opts->consume_sideband)
+		opts->ungroup = 0;
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
diff --git a/run-command.h b/run-command.h
index 4679987c8e..ad0bab14b0 100644
--- a/run-command.h
+++ b/run-command.h
@@ -436,6 +436,20 @@ typedef int (*feed_pipe_fn)(int child_in,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * If this callback is provided, instead of collating process output to stderr,
+ * they will be collated into a new pipe. consume_sideband_fn will be called
+ * repeatedly. When output is available on that pipe, it will be contained in
+ * 'output'. But it will be called with an empty 'output' too, to allow for
+ * keepalives or similar operations if necessary.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel.
+ *
+ * Since this callback is provided with the collated output, no task cookie is
+ * provided.
+ */
+typedef void (*consume_sideband_fn)(struct strbuf *output, void *pp_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -495,6 +509,12 @@ struct run_process_parallel_opts
 	 */
 	feed_pipe_fn feed_pipe;
 
+	/*
+	 * consume_sideband: see consume_sideband_fn() above. This can be NULL
+	 * to omit any special handling.
+	 */
+	consume_sideband_fn consume_sideband;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
@@ -529,7 +549,7 @@ struct run_process_parallel_opts
  * emitting their own output, including dealing with any race
  * conditions due to writing in parallel to stdout and stderr.
  */
-void run_processes_parallel(const struct run_process_parallel_opts *opts);
+void run_processes_parallel(struct run_process_parallel_opts *opts);
 
 /**
  * Convenience function which prepares env for a command to be run in a
diff --git a/submodule.c b/submodule.c
index fff3c75570..8ff4418e41 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1821,7 +1821,7 @@ int fetch_submodules(struct repository *r,
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
-	const struct run_process_parallel_opts opts = {
+	struct run_process_parallel_opts opts = {
 		.tr2_category = "submodule",
 		.tr2_label = "parallel/fetch",
 
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index dfdb03b3ab..95152a0395 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -58,6 +58,16 @@ static int no_job(struct child_process *cp UNUSED,
 	return 0;
 }
 
+static void test_consume_sideband(struct strbuf *output, void *cb UNUSED)
+{
+	FILE *sideband;
+
+	sideband = fopen("./sideband", "a");
+
+	strbuf_write(output, sideband);
+	fclose(sideband);
+}
+
 static int task_finished(int result UNUSED,
 			 struct strbuf *err,
 			 void *pp_cb UNUSED,
@@ -198,6 +208,7 @@ static int testsuite(int argc, const char **argv)
 		.get_next_task = next_test,
 		.start_failure = test_failed,
 		.feed_pipe = test_stdin_pipe_feed,
+		.consume_sideband = test_consume_sideband,
 		.task_finished = test_finished,
 		.data = &suite,
 	};
@@ -514,6 +525,10 @@ int cmd__run_command(int argc, const char **argv)
 		opts.get_next_task = parallel_next;
 		opts.task_finished = task_finished_quiet;
 		opts.feed_pipe = test_stdin_pipe_feed;
+	} else if (!strcmp(argv[1], "run-command-sideband")) {
+		opts.get_next_task = parallel_next;
+		opts.consume_sideband = test_consume_sideband;
+		opts.task_finished = task_finished_quiet;
 	} else {
 		ret = 1;
 		fprintf(stderr, "check usage\n");
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 282afecefc..38249e4798 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -164,6 +164,13 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command can divert output' '
+	test_when_finished rm sideband &&
+	test-tool run-command run-command-sideband 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_must_be_empty actual &&
+	test_cmp expect sideband
+'
+
 cat >expect <<-EOF
 preloaded output of a child
 listening for stdin:
-- 
2.49.1

