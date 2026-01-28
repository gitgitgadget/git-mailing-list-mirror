Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499533B6CE
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636432; cv=pass; b=twMNcUgv5bvNJ86EMlLuaX01SktPA2a4fX8fiEhbahIC7ct/6VZFV4aXMy7C3dT+3eS27FXo2S0okbC1+fPW7TRVwXyWw2At+q4LjrMd+CScM1Gk4a0wVlKzu6V05hzZlG7a3f4HgtNVnTQCYk+oomAAJbgI9DKNzA+mjiDqE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636432; c=relaxed/simple;
	bh=Ab7rVmCJLl9NM21ttLx6Hd/azsR9MRvDlXcB6BDZlGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw+ayVj8KwhJvAof5Wz0KrJxx6A6RYTtoUqnNUIbq+4th/xrArl/qUmkWw4s8kTdXEfhiXiioDD8m2o9sYrL4FfwL+ZbSwyEqFcToXhiyEsnIiA+eBxG1mcUxbuNTDX37yz62NczkPNDQqXZW/BYnzfRMC7PprhTlqGAQG9Ax/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=CbKBZ/H3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="CbKBZ/H3"
ARC-Seal: i=1; a=rsa-sha256; t=1769636417; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EBcPK7pXvW6Vs6Ij5dFi98F0wX7IhV/kXTKzAjy/B7QvVfQOsunF+xLFO+Yg6Qz5v1QnOPpDcvyyytAIokBaPfaSvG961gsYrapgHw0XNzsN1thTEP1GkCK4S2PPcEKQ+6e137bjXyNPRZJaJvyEV9CACsSh0tGZFQr6uwOhrNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636417; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ad7uh1ZHlqrWDEqtGd/FxQVAq6tQ9+/NmeBdQbohjSU=; 
	b=EPBLxP6tuZiHCbtWliVPxcdAeGyn0Pqh1qp0Jn8SpX9S9B9vDOT9CX3wo6jBqPbPizvdEHjnlsTbw6AX8dRlOm42c6xfuAIdfzgU3ZhlFOPc62rNGKISHVzyqKklVBORfEn1Tdb8blYvuabDheDiHYPm0Uy0a4CHRg5iYOE9vu0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636417;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Ad7uh1ZHlqrWDEqtGd/FxQVAq6tQ9+/NmeBdQbohjSU=;
	b=CbKBZ/H3sw1h5p0cOo+UQ6xFQLqS7hmyaeIgZ/K7secdqJkpMuPpiW86oMvcB5WO
	f1xjxA2Hh+p3zhObmdtoDQazixTn+UViW5bufBqUQ9beGcQfftGI86w9N3K1PXQjSNS
	UxE3RjVNkoYGI7831tCQtU2vtil9l5T/I9KlS8OQ=
Received: by mx.zohomail.com with SMTPS id 1769636415590682.0345432358582;
	Wed, 28 Jan 2026 13:40:15 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 10/12] run-command: poll child input in addition to output
Date: Wed, 28 Jan 2026 23:39:25 +0200
Message-ID: <20260128213927.3026875-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Child input feeding might hit the 100ms output poll timeout as a
side-effect of the ungroup=0 design when feeding multiple children
in parallel and buffering their outputs.

This throttles the write throughput as reported by Kristoffer.

Peff also noted that the parent might block if the write pipe is full
and cause a deadlock if both parent + child wait for one another.

Thus we refactor the run-command I/O loop so it polls on both child
input and output fds to eliminate the risk of artificial 100ms
latencies and unnecessarily blocking the main process.

This ensures that parallel hooks are fed data ASAP while maintaining
responsiveness for (sideband) output.

It's worth noting that in our current design, sequential execution
is not affected by this because it still uses the ungroup=1 behavior,
so there are no run-command induced buffering delays since the child
sequentially outputs directly to the parent-inherited fds.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c | 80 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/run-command.c b/run-command.c
index aaf0e4ecee..3356463d43 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1499,6 +1499,14 @@ static int child_is_receiving_input(const struct parallel_child *pp_child)
 {
 	return child_is_working(pp_child) && pp_child->process.in > 0;
 }
+static int child_is_sending_output(const struct parallel_child *pp_child)
+{
+	/*
+	 * all pp children which buffer output through run_command via ungroup=0
+	 * redirect stdout to stderr, so we just need to check process.err.
+	 */
+	return child_is_working(pp_child) && pp_child->process.err > 0;
+}
 
 struct parallel_processes {
 	size_t nr_processes;
@@ -1562,7 +1570,7 @@ static void pp_init(struct parallel_processes *pp,
 
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
-		CALLOC_ARRAY(pp->pfd, n);
+		CALLOC_ARRAY(pp->pfd, n * 2);
 
 	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1707,21 +1715,63 @@ static void pp_buffer_stdin(struct parallel_processes *pp,
 	}
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp,
-			     const struct run_process_parallel_opts *opts,
-			     int output_timeout)
+static void pp_buffer_io(struct parallel_processes *pp,
+			 const struct run_process_parallel_opts *opts,
+			 int timeout)
 {
-	while (poll(pp->pfd, opts->processes, output_timeout) < 0) {
+	/* for each potential child slot, prepare two pollfd entries */
+	for (size_t i = 0; i < opts->processes; i++) {
+		if (child_is_sending_output(&pp->children[i])) {
+			pp->pfd[2*i].fd = pp->children[i].process.err;
+			pp->pfd[2*i].events = POLLIN | POLLHUP;
+		} else {
+			pp->pfd[2*i].fd = -1;
+		}
+
+		if (child_is_receiving_input(&pp->children[i])) {
+			pp->pfd[2*i+1].fd = pp->children[i].process.in;
+			pp->pfd[2*i+1].events = POLLOUT;
+		} else {
+			pp->pfd[2*i+1].fd = -1;
+		}
+	}
+
+	while (poll(pp->pfd, opts->processes * 2, timeout) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp, opts);
 		die_errno("poll");
 	}
 
-	/* Buffer output from all pipes. */
 	for (size_t i = 0; i < opts->processes; i++) {
+		/* Handle input feeding (stdin) */
+		if (pp->pfd[2*i+1].revents & (POLLOUT | POLLHUP | POLLERR)) {
+			if (opts->feed_pipe) {
+				int ret = opts->feed_pipe(pp->children[i].process.in,
+							  opts->data,
+							  pp->children[i].data);
+				if (ret < 0)
+					die_errno("feed_pipe");
+				if (ret) {
+					/* done feeding */
+					close(pp->children[i].process.in);
+					pp->children[i].process.in = 0;
+				}
+			} else {
+				/*
+				 * No feed_pipe means there is nothing to do, so
+				 * close the fd. Child input can be fed by other
+				 * methods, such as opts->path_to_stdin which
+				 * slurps a file via dup2, so clean up here.
+				 */
+				close(pp->children[i].process.in);
+				pp->children[i].process.in = 0;
+			}
+		}
+
+		/* Handle output reading (stderr) */
 		if (child_is_working(&pp->children[i]) &&
-		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
+		    pp->pfd[2*i].revents & (POLLIN | POLLHUP)) {
 			int n = strbuf_read_once(&pp->children[i].err,
 						 pp->children[i].process.err, 0);
 			if (n == 0) {
@@ -1814,21 +1864,15 @@ static int pp_collect_finished(struct parallel_processes *pp,
 
 static void pp_handle_child_IO(struct parallel_processes *pp,
 				const struct run_process_parallel_opts *opts,
-				int output_timeout)
+				int timeout)
 {
-	/*
-	 * First push input, if any (it might no-op), to child tasks to avoid them blocking
-	 * after input. This also prevents deadlocks when ungrouping below, if a child blocks
-	 * while the parent also waits for them to finish.
-	 */
-	pp_buffer_stdin(pp, opts);
-
 	if (opts->ungroup) {
+		pp_buffer_stdin(pp, opts);
 		for (size_t i = 0; i < opts->processes; i++)
 			if (child_is_ready_for_cleanup(&pp->children[i]))
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
 	} else {
-		pp_buffer_stderr(pp, opts, output_timeout);
+		pp_buffer_io(pp, opts, timeout);
 		pp_output(pp);
 	}
 }
@@ -1836,7 +1880,7 @@ static void pp_handle_child_IO(struct parallel_processes *pp,
 void run_processes_parallel(const struct run_process_parallel_opts *opts)
 {
 	int i, code;
-	int output_timeout = 100;
+	int timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes_for_signal pp_sig;
 	struct parallel_processes pp = {
@@ -1876,7 +1920,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 		}
 		if (!pp.nr_processes)
 			break;
-		pp_handle_child_IO(&pp, opts, output_timeout);
+		pp_handle_child_IO(&pp, opts, timeout);
 		code = pp_collect_finished(&pp, opts);
 		if (code) {
 			pp.shutdown = 1;
-- 
2.52.0.732.gb351b5166d.dirty

