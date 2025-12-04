Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26D348880
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857783; cv=pass; b=T7lcVboNA6jG9NHC8kojiHti4nzoiawaHt5WT/BjAvIsY/puHhUp3W0vW2itF5uQCBE5WHMscL09OAM33QD1M/jDAZOKmEA0vAswCCnvgCrVL8bgZ0G0vuQ5Cn8WF8wfZadDorPMYlLRCpvkHiNvoFI3yM9+wT2pCjyFkc7Sk6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857783; c=relaxed/simple;
	bh=Z5hC86qJWA5h0S/rigLRjJ1sKOzC1wiqj3Nf1ew8dn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=be3d+CdtpqX6cY12rzVQFZgKLRm59ijIt50ZM7RVCHqny/L82l57709JRzFJW9bC99pZlsOXD7ncLV7Utt/+N4W4MyZcMXPanBWHO9+6mincNg7u3B3TzzT7CTi1Lhh8n2NRbBEybvvT9lCud/Jc+qVlDs14pwBJOJvqGGWjmVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KL/nbhPd; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KL/nbhPd"
ARC-Seal: i=1; a=rsa-sha256; t=1764857771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eo8jf8FaIupnw/fJgxyEaqU7+1cbnV2a6HAI97ncMigd2OiqiKK1LX4JsUUYjoxQkIPtMHATmNSlIDqgdIvkUZ34nZbAaepEJ5EC7v575nOVCMhcnLYgdr2nthjkWfsqBSgiAOSBfQrHCvOapLo5FDuAV+W7nm/nHnZV1IjChOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857771; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c4DM8NSX2RWEVIn/gd7KzFhDPb9MTv4K2O985kuKesQ=; 
	b=boJbAoIGFRGmeRDeZ3zg/TvZeNwHs3f3TLrbiB8AxZW2LZOl7DkI+ILkP4EEBIK7Ur0NF/21Row3FX2EgodLBvtiVnNKGEkKjEXf7Kv+QnBxtZIQ0k8ch2V9ZKD/SsbcK+OkwVmlhwVP5l3xMfyuEv/Q7TlgRT3f0ouPbRzM8h0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857771;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=c4DM8NSX2RWEVIn/gd7KzFhDPb9MTv4K2O985kuKesQ=;
	b=KL/nbhPdpnUWMHblKyBxYOZKAuXCLdy60ko9LLmd5/BWaikeJkmnFh/+j8lvxmlH
	hpzJDYaCmKptzhqU98pCM+hvlecHxH2Bz3QdL2FRKqNc9Jh4vVAzne3YvQlveuL0B1j
	IW2nYn47HCX8FvoxmH/TJLRHhF6CL+HvA7Df8l6w=
Received: by mx.zohomail.com with SMTPS id 1764857768621923.4661171173871;
	Thu, 4 Dec 2025 06:16:08 -0800 (PST)
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
Subject: [PATCH v4 08/11] run-command: allow capturing of collated output
Date: Thu,  4 Dec 2025 16:15:32 +0200
Message-ID: <20251204141535.1986263-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
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
index a608d37fb2..6b1e4a3453 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1595,7 +1595,10 @@ static void pp_cleanup(struct parallel_processes *pp,
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
@@ -1734,13 +1737,17 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	}
 }
 
-static void pp_output(const struct parallel_processes *pp)
+static void pp_output(const struct parallel_processes *pp,
+		      const struct run_process_parallel_opts *opts)
 {
 	size_t i = pp->output_owner;
 
 	if (child_is_working(&pp->children[i]) &&
 	    pp->children[i].err.len) {
-		strbuf_write(&pp->children[i].err, stderr);
+		if (opts->consume_output)
+			opts->consume_output(&pp->children[i].err, opts->data);
+		else
+			strbuf_write(&pp->children[i].err, stderr);
 		strbuf_reset(&pp->children[i].err);
 	}
 }
@@ -1788,11 +1795,15 @@ static int pp_collect_finished(struct parallel_processes *pp,
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
@@ -1829,7 +1840,7 @@ static void pp_handle_child_IO(struct parallel_processes *pp,
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
 	} else {
 		pp_buffer_stderr(pp, opts, output_timeout);
-		pp_output(pp);
+		pp_output(pp, opts);
 	}
 }
 
@@ -1852,6 +1863,9 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 					   "max:%"PRIuMAX,
 					   (uintmax_t)opts->processes);
 
+	if (opts->ungroup && opts->consume_output)
+		BUG("ungroup and reading output are mutualy exclusive");
+
 	/*
 	 * Child tasks might receive input via stdin, terminating early (or not), so
 	 * ignore the default SIGPIPE which gets handled by each feed_pipe_fn which
diff --git a/run-command.h b/run-command.h
index e1ca965b5b..7093252863 100644
--- a/run-command.h
+++ b/run-command.h
@@ -435,6 +435,17 @@ typedef int (*feed_pipe_fn)(int child_in,
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
@@ -494,6 +505,12 @@ struct run_process_parallel_opts
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

