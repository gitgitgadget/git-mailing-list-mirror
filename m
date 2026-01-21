Received: from sender4-pp-f119.zoho.com (sender4-pp-f119.zoho.com [136.143.188.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C800426687
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032531; cv=pass; b=G14SacgzxqN41Pa9hgktz+g2r4+LMyPEjXMI+sw23ObmQG7xSaoAnakBb+Jgo1pXk0XytJ0ZmEyOAghWHVRLGt9oQmogTagtqevxWKjr+ueL8SPs4e+7qiOJEIdStAkUZeBwfJMRXd9tG0YiHAMy0Mqm+KCcPb3v3kk9KU8K0Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032531; c=relaxed/simple;
	bh=rLskWMUQh/9rG65izvQrSXBPdjMn9h2vQgGQtmM/r3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHp+495cz2PnhwZJMLwFZolrIuKsmmB4t8lN5cW2GleG4EJt+UDwm+Art8F86rfU8DTnEIEE5+C5HOolDdGzTTkUJXnHbKtWsN61PsSXHXy9Yzc25MViDtgDtF363FZzfLK+PNg+k3+JPtw3wpXkLOCxLjLfpLqrySC551pcFvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=inL2rLQ5; arc=pass smtp.client-ip=136.143.188.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="inL2rLQ5"
ARC-Seal: i=1; a=rsa-sha256; t=1769032515; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oG3KtKVQ0vZ2WtL/7PMaaPK5MNxmDGtq9KcZbe7017SM1ait9IJSVQq+gs5imZQGcKJqqFvZtnNi84vP1B9OLtuKkelcU6MDdEzLbLeHT3DOnWxpgrwiWdGT82Sx/JKe4c5LLiN4z9snpOMUSi56z6G1ggiALFoCdz6cH8HxNrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032515; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+T3pzjPnk2f1BOMvXusMlgM1I5KFNzLPjpv7GhNLHqk=; 
	b=M9t8w70KwnNSDMpgFXFL41aOaPeULMHXe4SKMfWaW84NOCHRiAw2k0aX34N0lm1MbiDLIelZECVYDvP60LzhgYBjDx/DUFQysc00TCgC7DS+2S3BgUzmT2QT9dlpdZEmma/9BPSAtKj4f6+7N8suKKDuzGdXGrDNu/OV0b4KFHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032515;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+T3pzjPnk2f1BOMvXusMlgM1I5KFNzLPjpv7GhNLHqk=;
	b=inL2rLQ5RjBxCy1kmQTlI8YXZBa2LQ9fl2hrDAL86x7B50E03R+trNJbpGFhwHx5
	QDgfaklg/Uk+dar37926ZsLZyE8RtV2mhbg73wyHQdGUSkurAXBfQGcX1foyyzXvER5
	jM9KJT/A78Vi6Q4jztOhiI6fI1bo5e1R1fiQhcak=
Received: by mx.zohomail.com with SMTPS id 1769032514510677.9065036313206;
	Wed, 21 Jan 2026 13:55:14 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v7 11/12] receive-pack: convert update hooks to new API
Date: Wed, 21 Jan 2026 23:54:35 +0200
Message-ID: <20260121215436.1473800-12-adrian.ratiu@collabora.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The hook API avoids creating a custom struct child_process and other
internal hook plumbing (e.g. calling find_hook()) and prepares for
the specification of hooks via configs or running parallel hooks.

Execution is still sequential through the run_hooks_opt .jobs == 1,
which is the unchanged default for all hooks.

When jobs==1 the async muxer thread reads the hook stderr and writes
to sideband 2, so run-command's poll loop is avoided and there's no
need for ungroup=0 when running sequentially (Jeff's suggestion).

When running in parallel, run-command with ungroup=0 will capture
and de-interleave the output of each hook, then write to the parent
stderr which is redirected via dup2 to the sideband muxer, so that
parallel hook output is presented clearly to the client.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 91 +++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9c49174616..bcd019786e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -941,29 +941,41 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct async muxer;
 	int code;
-	const char *hook_path = find_hook(the_repository, "update");
+	int saved_stderr = -1;
+	int muxer_started = 0;
 
-	if (!hook_path)
-		return 0;
+	strvec_pushl(&opt.args,
+		     cmd->ref_name,
+		     oid_to_hex(&cmd->old_oid),
+		     oid_to_hex(&cmd->new_oid),
+		     NULL);
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, cmd->ref_name);
-	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
-	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		if (!start_async(&muxer)) {
+			muxer_started = 1;
+			saved_stderr = dup(STDERR_FILENO);
+			if (saved_stderr >= 0)
+				dup2(muxer.in, STDERR_FILENO);
+			close(muxer.in);
+		}
+	}
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "update";
+	code = run_hooks_opt(the_repository, "update", &opt);
 
-	code = start_command(&proc);
-	if (code)
-		return code;
-	if (use_sideband)
-		copy_to_sideband(proc.err, -1, NULL);
-	return finish_command(&proc);
+	if (saved_stderr >= 0) {
+		dup2(saved_stderr, STDERR_FILENO);
+		close(saved_stderr);
+	}
+	if (muxer_started)
+		finish_async(&muxer);
+
+	return code;
 }
 
 static struct command *find_command_by_refname(struct command *list,
@@ -1639,34 +1651,41 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 static void run_update_post_hook(struct command *commands)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct async muxer;
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook(the_repository, "post-update");
-	if (!hook)
-		return;
+	int saved_stderr = -1;
+	int muxer_started = 0;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string || cmd->did_not_exist)
 			continue;
-		if (!proc.args.nr)
-			strvec_push(&proc.args, hook);
-		strvec_push(&proc.args, cmd->ref_name);
+		strvec_push(&opt.args, cmd->ref_name);
 	}
-	if (!proc.args.nr)
+	if (!opt.args.nr)
 		return;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "post-update";
+	if (use_sideband) {
+		memset(&muxer, 0, sizeof(muxer));
+		muxer.proc = copy_to_sideband;
+		muxer.in = -1;
+		if (!start_async(&muxer)) {
+			muxer_started = 1;
+			saved_stderr = dup(STDERR_FILENO);
+			if (saved_stderr >= 0)
+				dup2(muxer.in, STDERR_FILENO);
+			close(muxer.in);
+		}
+	}
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
+	run_hooks_opt(the_repository, "post-update", &opt);
+
+	if (saved_stderr >= 0) {
+		dup2(saved_stderr, STDERR_FILENO);
+		close(saved_stderr);
 	}
+	if (muxer_started)
+		finish_async(&muxer);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.52.0.732.gb351b5166d.dirty

