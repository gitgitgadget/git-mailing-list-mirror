Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE73570CC
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710649; cv=pass; b=mqY60N9OldJ4bs+C9ln96xk7d93toQLIJ5GA57w0k1RSDSSA9jcjaud/SrCset8tdgBe1bMcgSTRGEBJWRt5DrIVPvv+NzkTv7GWrx+EelNLAdbdiODrHXsGK8zJl77p3HDaZHel5ti44KRx7tDYlNGElGA+fWYnCjSFi9Mo/Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710649; c=relaxed/simple;
	bh=mvmJz+Ma7UAFMRvT78AIwXdyT9Lr8G+or2Vu8Oc24sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJl2X3k9GVpRCTMPpnQqSkX9OVqDUOdNNr2hSdPoJfMko3eVyrY98l6C8BnE/+KldE560XPuRdQXjV5zjRHxSRlWeX+KHV8GIs3H4XuTxc6NPJzavBNuv444mChGXmsfLsvOsY3/r11qmMtF88A3QWATqFEVEEUr7g7pujRM4JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=MJZGTLn7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="MJZGTLn7"
ARC-Seal: i=1; a=rsa-sha256; t=1760710637; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AXV6V6f5q7BR1bjKTimDknK6/hehaqpQtQnO5wnOQcOUJcsdvypMKSgzKHbuU1Uxq6MdfwxPZye50hz7uNVKMZIqgQPWQd1iHmbxp9hTW503Hz/20s3Oiyn9ogoRdkxRZ5+6JufRE9Ok9Idchp0go6bSqCTE8yrhBI95rfqAuIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710637; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JPwFLcJe0QejfdVBsDvsU+m5h7n50mMEl7yCAMb4y2s=; 
	b=kR0E1wLHLYISCfbs9uK0DAbNm9M/PB3uwVepYAVeCDuFWzTj8Aefh9NzvQ6ui13Gm0GDR7l0HTv0FitjJ/33B1MsNr3n2WSBWsWzexyQhm3VShRtOss8k9YVXiWzZO5v7MZNvlYYIAHTIue3RcbAti6eNoCJIjwX7enhmCH+zrs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710637;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JPwFLcJe0QejfdVBsDvsU+m5h7n50mMEl7yCAMb4y2s=;
	b=MJZGTLn7uTzvRoan8pDkdOtzo6CTlRz1G2Yn/pSX7QhNqWPd0M708Ma2qNsNBGZC
	eLumYbIg3HVqY13V/fXAfTopHS6AdaVUKxa16NMQ4V1mkQo1X8ysoZpOjoobo91Ss3Z
	d4y98pCSfXiAfq8Ivxr1LQtNyvdXsm2Eqbu6B3AE=
Received: by mx.zohomail.com with SMTPS id 176071063404019.714169008198496;
	Fri, 17 Oct 2025 07:17:14 -0700 (PDT)
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
Subject: [PATCH v2 03/10] hook: convert 'post-rewrite' hook in sequencer.c to hook API
Date: Fri, 17 Oct 2025 17:15:37 +0300
Message-ID: <20251017141544.1538542-4-adrian.ratiu@collabora.com>
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

Replace the custom run-command calls used by post-rewrite with
the newer and simpler hook_run_opt(), which does not need to
create a custom 'struct child_process' or call find_hook().

Another benefit of using the hook API is that hook_run_opt()
handles the SIGPIPE toggle logic.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 sequencer.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5476d39ba9..71ed31c774 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1292,32 +1292,40 @@ int update_head_with_reflog(const struct commit *old_head,
 	return ret;
 }
 
+static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct strbuf *to_pipe = hook_cb->options->feed_pipe_ctx;
+	int ret;
+
+	if (!to_pipe)
+		BUG("pipe_from_strbuf called without feed_pipe_ctx");
+
+	ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len);
+	if (ret < 0 && errno != EPIPE)
+		return ret;
+
+	return 1; /* done writing */
+}
+
 static int run_rewrite_hook(const struct object_id *oldoid,
 			    const struct object_id *newoid)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int code;
 	struct strbuf sb = STRBUF_INIT;
-	const char *hook_path = find_hook(the_repository, "post-rewrite");
 
-	if (!hook_path)
-		return 0;
+	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
 
-	strvec_pushl(&proc.args, hook_path, "amend", NULL);
-	proc.in = -1;
-	proc.stdout_to_stderr = 1;
-	proc.trace2_hook_name = "post-rewrite";
+	opt.feed_pipe_ctx = &sb;
+	opt.feed_pipe = pipe_from_strbuf;
+
+	strvec_push(&opt.args, "amend");
+
+	code = run_hooks_opt(the_repository, "post-rewrite", &opt);
 
-	code = start_command(&proc);
-	if (code)
-		return code;
-	strbuf_addf(&sb, "%s %s\n", oid_to_hex(oldoid), oid_to_hex(newoid));
-	sigchain_push(SIGPIPE, SIG_IGN);
-	write_in_full(proc.in, sb.buf, sb.len);
-	close(proc.in);
 	strbuf_release(&sb);
-	sigchain_pop(SIGPIPE);
-	return finish_command(&proc);
+	return code;
 }
 
 void commit_post_rewrite(struct repository *r,
-- 
2.49.1

