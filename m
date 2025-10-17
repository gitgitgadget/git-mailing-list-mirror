Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B1335088
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710661; cv=pass; b=uSF7OoR1O+NMczik8ngAFgv6FUvsWy6fm0auyHyqjHQpDQ3EpcqWy4p3pLUTbeB4AGDUrQSF08TvxsKuKzK97skXmg+E/VyX9nVGG719eGJwr11EW5chh72CU32MbXHqI/f8WxPHDpMJbSEof48cmeHQh7ZX0ZTrccgpBaY55OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710661; c=relaxed/simple;
	bh=UCIwUOP0kiUiKfpWDLt7V7lRTMTN/aW8p+FdIAyaM64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuwwFEhlerFuHAyFY91y/2c7HHVdDyZErrhSzMuchPkVPb/DzLyrKpt53Gs8Ibr6Ga62p9AV+GL0c1YtstQ9w335KUgTcr3KvgY4B9uG+qQ1tWpJ8jF+fBnhQdCIOtH0Va+Ts4Mi6mcA4soQluaHQBkidarZV+eb1909DVzoQ20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CjXtZR1j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CjXtZR1j"
ARC-Seal: i=1; a=rsa-sha256; t=1760710649; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V1nztyqNZP9uZvuAdfRtrupDyBZVKCr88k60eioXee/ZQEMulg+wLlk8x7UmkXKVdT2QYGTvIrTYLWBK+0Lb+yPoehJeQg30jUT9YzYmpKODBlcN74XQUfrHhWsch2bVLhUEzlht5Ior3zgx2F5x6YTmPS3gsgs4Q3DfxC+RJto=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710649; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gmwx3j7+ICXVDKRdO+uKmp/kAm0t2VDWCJZQSKSkZyE=; 
	b=FE9bFiRWgw+cCWHW1TpBASiyFXZw7k+tf+tXgpNs9zAno6JTZi9UWnlpXz6fh0PA4/uyQaEFceB5VSDHTm4N09FTZoOgRH4JgTzr2ImAflk5/iXFI/mOBp1POaqPIuDNr1eCIdkLzAslhtB2BmNxFXO/nVnCDOki1oneriO1l2U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710649;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Gmwx3j7+ICXVDKRdO+uKmp/kAm0t2VDWCJZQSKSkZyE=;
	b=CjXtZR1jXAg3QEh+vACHQWVyKzO6FfKjox1YDuR8w/Kt5/Rz4UfwaN0iPkMAw0rY
	7YePoyDwh7lyCER2p2UC+YlUPYoO8/7NaNxVM3c59psFzP3X1bnl33U3VsOI1Q6eGf/
	raRkQCVJFcWu8lPqAHYIUdfAQujvWSyebxMHPi+Y=
Received: by mx.zohomail.com with SMTPS id 1760710646810968.2480071679918;
	Fri, 17 Oct 2025 07:17:26 -0700 (PDT)
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
Subject: [PATCH v2 07/10] run-command: allow capturing of collated output
Date: Fri, 17 Oct 2025 17:15:41 +0300
Message-ID: <20251017141544.1538542-8-adrian.ratiu@collabora.com>
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
 run-command.c               | 30 ++++++++++++++++++++++--------
 run-command.h               | 20 ++++++++++++++++++++
 t/helper/test-run-command.c | 15 +++++++++++++++
 t/t0061-run-command.sh      |  7 +++++++
 4 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index 5bc6db5bb1..f217adcad6 100644
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
@@ -1817,7 +1828,7 @@ static void pp_handle_child_IO(struct parallel_processes *pp,
 		}
 	} else {
 		pp_buffer_stderr(pp, opts, output_timeout);
-		pp_output(pp);
+		pp_output(pp, opts);
 	}
 }
 
@@ -1840,6 +1851,9 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	if (opts->ungroup && opts->consume_sideband)
+		BUG("ungroup and reading sideband are mutualy exclusive");
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
diff --git a/run-command.h b/run-command.h
index e536ed7544..2c2484478b 100644
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
index 2f77fde0d9..f133d71783 100755
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
 test_expect_success 'run_command listens to stdin' '
 	cat >expect <<-\EOF &&
 	preloaded output of a child
-- 
2.49.1

