Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F921E0DEA
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804875; cv=pass; b=epoP1qi7TSQ8G7Xz9Brn85OKF/a+is47pun8Sh02NZAQDG2nItWmzSrHIeIc/Ffp5q1AB/mYXLTzaoUGus+qgFYn9+Ui3bFPc+qd7Pxioll5vR3QoVmzRrt0Eql2Xp3pUQDKs8c2VDaE2SHKahwUazHUs2Wc4RFobezthxsP4xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804875; c=relaxed/simple;
	bh=nA53JVf/FKi63vK07WIesAPOYAFPJ0ZJStMjiBFanM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+KJlVUO8kA7AHXrAhIP+fkVkIW00mUvwT/gyT3+rjnbdCIDYSoIgrZ/kkda7XtC7zpRaa9b7godALhjmPNfKFBX/4nBx81dgfWtEIceH7ElpA+WRlytAC/Riya0Nd8q32fruisrJjHH29X3XqJqKTSSrpwava5QXMlmDr36hoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AOrwnYO4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AOrwnYO4"
ARC-Seal: i=1; a=rsa-sha256; t=1758804863; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nkEjiZ3c+tCwGmUZ5/SigAh0vecK6DDgcEvNHeWeKl1v4GaSighPftD2VR9i+Z6KtXYd6PboZh3M4sFDGWCOKriO7Egwu8y8QSiESgHuIYh7EfUW2qdUAVK9yWn5OBkUEtTjw65SOMHsqpdyc/g+4oVaTYSrHQYo5GYvptcFsAs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804863; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aX0A4km7mJqVrd3rR1s7fWwUZjC98qajTj6BiWa4+kg=; 
	b=gcnvgQz6PtOpBO2nXu3ACSvnIcBrn1gpfkRuZXzEaBrK/f1tXMrK4UcXTYD0X62FBl+Yt46bgLZKTzDIQCJ72w9Kjh0ynLqT72c7mO1EWbgiBB7IUGjngrn8atzKbtwPXrOZ2zJp9ZHI8b0hKNZL5rTFi2OqQcxqN0OvJjnXc0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804863;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aX0A4km7mJqVrd3rR1s7fWwUZjC98qajTj6BiWa4+kg=;
	b=AOrwnYO4Z2guG3nrELEmXIiYWcMNshs07FkHOtvuJsp9M8U9z5NkaUU9140Cr9W5
	4q0tlCdh38tud07MU0TNP0WZ0Kd9nrKqMt0WCwx5FoZHIp8XcX1JuDb4MBud/ZeG6OD
	H7M+64EKJWYt9w9+gfXai9ueOZ8R9X50lJum/8HI=
Received: by mx.zohomail.com with SMTPS id 1758804861899829.2667567553722;
	Thu, 25 Sep 2025 05:54:21 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c to hook.h
Date: Thu, 25 Sep 2025 15:53:46 +0300
Message-ID: <20250925125352.1728840-4-adrian.ratiu@collabora.com>
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

By using 'hook.h' for 'post-rewrite', we simplify hook invocations by
not needing to put together our own 'struct child_process'.

The signal handling that's being removed by this commit now takes
place in run-command.h:run_processes_parallel(), so it is OK to remove
them here.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 sequencer.c | 62 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9ae40a91b2..93cd6ab1f2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1298,32 +1298,46 @@ int update_head_with_reflog(const struct commit *old_head,
 	return ret;
 }
 
+static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb, void *pp_task_cb UNUSED)
+{
+	struct hook_cb_data *hook_cb = pp_cb;
+	struct strbuf *to_pipe = hook_cb->options->feed_pipe_ctx;
+	int ret;
+
+	if (!to_pipe || !to_pipe->len)
+		return 1; /* nothing to feed */
+
+	ret = write_in_full(hook_stdin_fd, to_pipe->buf, to_pipe->len);
+	if (ret < 0) {
+		if (errno == EPIPE) {
+			return 1; /* child closed pipe, nothing more to feed */
+		}
+		return ret;
+	}
+
+	/* Reset the input buffer to avoid sending it again */
+	strbuf_reset(to_pipe);
+	return ret;
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
@@ -5140,16 +5154,16 @@ static int pick_commits(struct repository *r,
 		flush_rewritten_pending();
 		if (!stat(rebase_path_rewritten_list(), &st) &&
 				st.st_size > 0) {
-			struct child_process child = CHILD_PROCESS_INIT;
+			struct child_process notes_cp = CHILD_PROCESS_INIT;
 			struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
 
-			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
-			child.git_cmd = 1;
-			strvec_push(&child.args, "notes");
-			strvec_push(&child.args, "copy");
-			strvec_push(&child.args, "--for-rewrite=rebase");
+			notes_cp.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			notes_cp.git_cmd = 1;
+			strvec_push(&notes_cp.args, "notes");
+			strvec_push(&notes_cp.args, "copy");
+			strvec_push(&notes_cp.args, "--for-rewrite=rebase");
 			/* we don't care if this copying failed */
-			run_command(&child);
+			run_command(&notes_cp);
 
 			hook_opt.path_to_stdin = rebase_path_rewritten_list();
 			strvec_push(&hook_opt.args, "rebase");
-- 
2.49.1

