Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C0188596
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004903; cv=pass; b=RSYYIUFGl5hhsJThknKoMThD0hPTfDYGfmqkpRmlOnhHmqDSzHvjOa6gM3/XoI5XlOgszYl6zoYXrr6BXfVRUfBBbS5Gj8lNEUPQMmvuia1qHcOhtBXLMmB+XTHBjfA4KLILz/RZ/h+pyByxVlfBy3rB99qLbSnzdbpKbq/ouw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004903; c=relaxed/simple;
	bh=CPoSM70PdpAdjMhUuEPfs38bZeK69XZNyWUee9g3Sjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwGp4gXAJLflj5+cetUV7Skfa/ZoJouvkiLEHEzDlsOGI4nky2snUP2tcrcw/GERZVSSPGxgRM9qvAimpb1kwgHwyCn9G+6K0kE4CYJA7fkmQDP8jpXqmNgzq5qsAJM90cnYFTKhpJD+hdq+X6rINVdCX2g0rXb9IQgCSjYoqPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AcYdlIh2; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AcYdlIh2"
ARC-Seal: i=1; a=rsa-sha256; t=1764004891; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=By1afexsbB3vsZ9T877Y08LKUjPZi2HDHsLNocPd/B0Jo34/IyOr0bifrxjvCoc1LFV0xx4q6s6cN7g0Emen1Q9ayKyLbhWJFAOTBjSmw3tHNcBvVP68bARmlBmvsJZicBKJA1ow/6AEG0KDPYjcFdHUf3nEdr7zR0rUbiYE5+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004891; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LwXoyqyO2o2GuTyvshIA+2bJ4pKbnDAlHAPeZnV8Aac=; 
	b=jp2z1mkjED6In0zy6EkXnF+vnWbWZ+cCJVLEVDL1daUU4VEqhjk4/qJZgSeG/w+zqBcHOfWvBcjs5gM8zged1gdC3YZGSM+21jXJuiDug5+hh4RPpF2OhHt2yR1Sl1ElyTgF/1ue1U7eE1V7UxYfyM9nFnJ5v/yvuSkZ2HWBN8Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004891;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LwXoyqyO2o2GuTyvshIA+2bJ4pKbnDAlHAPeZnV8Aac=;
	b=AcYdlIh2DoU8UuLltVy1GLlOpQLSjVvJrLyD+ddPHZ/1KYvW/Y0z6JPsNDFkaURR
	B+6NG7hH2i1Nz7y7g4QSs0zlQCfd9yc2vU1vnu6d6/2PkH1eHGQwfKiaLOwE3/mMI5O
	E8z0bR/up91HFXP3SEJ79N8rGqXXrfd9UKcxQsNI=
Received: by mx.zohomail.com with SMTPS id 1764004877528272.0478057293318;
	Mon, 24 Nov 2025 09:21:17 -0800 (PST)
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
Subject: [PATCH v3 07/10] run-command: allow capturing of collated output
Date: Mon, 24 Nov 2025 19:20:40 +0200
Message-ID: <20251124172043.1650014-8-adrian.ratiu@collabora.com>
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
 run-command.h               | 17 +++++++++++++++++
 t/helper/test-run-command.c | 15 +++++++++++++++
 t/t0061-run-command.sh      |  7 +++++++
 4 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index 9bf5911727..a7bf642647 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1578,7 +1578,10 @@ static void pp_cleanup(struct parallel_processes *pp,
 	 * When get_next_task added messages to the buffer in its last
 	 * iteration, the buffered output is non empty.
 	 */
-	strbuf_write(&pp->buffered_output, stderr);
+	if (opts->consume_output)
+		opts->consume_output(&pp->buffered_output, opts->data);
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
+		if (opts->consume_output)
+			opts->consume_output(&pp->children[i].err, opts->data);
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
+			if (opts->consume_output) {
+				opts->consume_output(&pp->children[i].err, opts->data);
+				opts->consume_output(&pp->buffered_output, opts->data);
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
 
+	if (opts->ungroup && opts->consume_output)
+		BUG("ungroup and reading output are mutualy exclusive");
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
diff --git a/run-command.h b/run-command.h
index e536ed7544..67df2f005e 100644
--- a/run-command.h
+++ b/run-command.h
@@ -436,6 +436,17 @@ typedef int (*feed_pipe_fn)(int child_in,
 				void *pp_cb,
 				void *pp_task_cb);
 
+/**
+ * If this callback is provided, output is collated into a new pipe instead
+ * of the process stderr. Then `consume_output_fn` will be called repeatedly
+ * with output contained in the `output` arg. It will also be called with an
+ * empty `output` to allow for keepalives or similar operations if necessary.
+ *
+ * pp_cb is the callback cookie as passed into run_processes_parallel.
+ * No task cookie is provided because the callback receives collated output.
+ */
+typedef void (*consume_output_fn)(struct strbuf *output, void *pp_cb);
+
 /**
  * This callback is called on every child process that finished processing.
  *
@@ -495,6 +506,12 @@ struct run_process_parallel_opts
 	 */
 	feed_pipe_fn feed_pipe;
 
+	/*
+	 * consume_output: see consume_output_fn() above. This can be NULL
+	 * to omit any special handling.
+	 */
+	consume_output_fn consume_output;
+
 	/**
 	 * task_finished: See task_finished_fn() above. This can be
 	 * NULL to omit any special handling.
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 4a56456894..49eace8dce 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -58,6 +58,16 @@ static int no_job(struct child_process *cp UNUSED,
 	return 0;
 }
 
+static void test_divert_output(struct strbuf *output, void *cb UNUSED)
+{
+	FILE *output_file;
+
+	output_file = fopen("./output_file", "a");
+
+	strbuf_write(output, output_file);
+	fclose(output_file);
+}
+
 static int task_finished(int result UNUSED,
 			 struct strbuf *err,
 			 void *pp_cb UNUSED,
@@ -198,6 +208,7 @@ static int testsuite(int argc, const char **argv)
 		.get_next_task = next_test,
 		.start_failure = test_failed,
 		.feed_pipe = test_stdin_pipe_feed,
+		.consume_output = test_divert_output,
 		.task_finished = test_finished,
 		.data = &suite,
 	};
@@ -514,6 +525,10 @@ int cmd__run_command(int argc, const char **argv)
 		opts.get_next_task = parallel_next;
 		opts.task_finished = task_finished_quiet;
 		opts.feed_pipe = test_stdin_pipe_feed;
+	} else if (!strcmp(argv[1], "run-command-divert-output")) {
+		opts.get_next_task = parallel_next;
+		opts.consume_output = test_divert_output;
+		opts.task_finished = task_finished_quiet;
 	} else {
 		ret = 1;
 		fprintf(stderr, "check usage\n");
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 2f77fde0d9..74529e219e 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -164,6 +164,13 @@ test_expect_success 'run_command runs ungrouped in parallel with more tasks than
 	test_line_count = 4 err
 '
 
+test_expect_success 'run_command can divert output' '
+	test_when_finished rm output_file &&
+	test-tool run-command run-command-divert-output 3 sh -c "printf \"%s\n%s\n\" Hello World" 2>actual &&
+	test_must_be_empty actual &&
+	test_cmp expect output_file
+'
+
 test_expect_success 'run_command listens to stdin' '
 	cat >expect <<-\EOF &&
 	preloaded output of a child
-- 
2.51.0

