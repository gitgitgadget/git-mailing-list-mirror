Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3943421A0A
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032528; cv=pass; b=lQvNo701e8GDDdhWesyMd63Oys/9G4AOacMk9XktAunUJSehQpoGgfC7F6yw9BH3zWcV5M/OkuffJJIcT6aBiWPA2LC766O6rZUHYNBV3e0z7c73LihDiz210hRymG71Xp6Nf4nCJqlIie2fzeyGNgwsW5rvmyBnugKz002sZ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032528; c=relaxed/simple;
	bh=y2Irrr7+AbLhVJ1ig1g9/E+we2OI23jSju+0NsfnWeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFRhP0hjgjzgVudja1Ik3/Xd/O2YaJJ0eREI0OX5Qobn4FWy3M2mJc5NpwrKvqZRl9rFzUfmPfCn4ORz+Yhh21tvbUc931TbpMOjosagQOdv/0QtEf+z8YYyDKU5gcsgq5xBrYLn3HcW8omhGgBkcSbgYc6L2iV9JtwMMGZUDjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HOdowCgy; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HOdowCgy"
ARC-Seal: i=1; a=rsa-sha256; t=1769032513; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TcQnlQBf2mO/eoTJfPTWDEh4L+w07Kp6u7JpcHWzpDF6qT40SJcCNK7bHPPMitZ8+f7uVxNFRMKKcuVR9ybLhdDNwUsf5n3fa786pNydbVOopjuGeAwdNAtfeuqmP7SQInnE1tYa/1y6K1a18D03hMQq66VtA+leveTOgMOfnxg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032513; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sHXQR7Vh1jGbC7rW/5UFseEWfdU0hL4anp8b3qxyuNo=; 
	b=UnTEqtcEgBimd8FpTnfzwnBNVEGg74/uQm12ySnndQPbty8uvFaJxuyfOL+yVJYsOb4FxzK8/uLPGKWiEWxdpvNG63VXaS+X6FLBvtIEVuFcrXthhPWMtk6bJJ36KbhNx9IljwJnoa5kB9j+JcE2/OqL0ynK8fMtwuZ/HDZxs3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032513;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sHXQR7Vh1jGbC7rW/5UFseEWfdU0hL4anp8b3qxyuNo=;
	b=HOdowCgylJj9uDkDxDFVXncyp1o7eRTk9c9LtL4SwWuBVrlU/lnE/BCkrmjLqmtd
	drcrcs1xoOBB+ICTHNFbYHmvmf/bcsEBB9vxsRb+UP/gPW8hEx2p5W5Sjd5y87/133R
	Ix5RbmcqmAtdBxXAIuuW8F92Wt6sljT9CWtVUsNo=
Received: by mx.zohomail.com with SMTPS id 1769032512318859.5348866946554;
	Wed, 21 Jan 2026 13:55:12 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 10/12] run-command: poll child stdin in addition to stdout
Date: Wed, 21 Jan 2026 23:54:34 +0200
Message-ID: <20260121215436.1473800-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
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

This throttles the write throughtput as reported by Kristoffer.

Peff also noted that the parent might block if the write pipe is full
and cause a deadlock if both parent + child wait for one another.

Thus we refactor the run-command I/O loop so it polls on both child
input and output fds to eliminate the risk of artificial 100ms
latencies and unnecessarily blocking the main process.

This ensures that parallel hooks are fed data ASAP while maintaining
responsiveness for (sideband) output.

It's worth noting that in our current design, sequential execution
is not affected by this because it still uses the ungroup=1 behavior.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 run-command.c | 61 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/run-command.c b/run-command.c
index aaf0e4ecee..dfd2aeda07 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1562,7 +1562,7 @@ static void pp_init(struct parallel_processes *pp,
 
 	CALLOC_ARRAY(pp->children, n);
 	if (!opts->ungroup)
-		CALLOC_ARRAY(pp->pfd, n);
+		CALLOC_ARRAY(pp->pfd, n * 2);
 
 	for (size_t i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
@@ -1707,21 +1707,52 @@ static void pp_buffer_stdin(struct parallel_processes *pp,
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
+		if (child_is_working(&pp->children[i]) &&
+		    pp->children[i].process.err > 0) {
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
+			int ret = opts->feed_pipe(pp->children[i].process.in,
+						  opts->data,
+						  pp->children[i].data);
+			if (ret < 0)
+				die_errno("feed_pipe");
+			if (ret) {
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
@@ -1814,21 +1845,15 @@ static int pp_collect_finished(struct parallel_processes *pp,
 
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
@@ -1836,7 +1861,7 @@ static void pp_handle_child_IO(struct parallel_processes *pp,
 void run_processes_parallel(const struct run_process_parallel_opts *opts)
 {
 	int i, code;
-	int output_timeout = 100;
+	int timeout = 100;
 	int spawn_cap = 4;
 	struct parallel_processes_for_signal pp_sig;
 	struct parallel_processes pp = {
@@ -1876,7 +1901,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
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

