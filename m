Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DC338582
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636436; cv=pass; b=IRX9CzcvDpYDF4bZLwrgdnJoJSVh7GM/5xV/IeCeYIeR/c96sTIsSYEiNYFlymBDV+NWDsdiqcDzr2IirqLJ/wm4CCT6XQpt1tQthttQnln7PkWHXXEbWAMOD/PgDBvCWHQviKtn9JRm3q2TlG8NBSylq9ayFeUCjkebDpNBAIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636436; c=relaxed/simple;
	bh=EPH/yGGW/ceDzHoF1CpYaryYNj2cRNeYls48EnUTODg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wic4rfLTGx0OVIJ0UqHL488r0j3X1mbw1gXt8oFczKi8CzpcNce8gevifNYkHd2Fc/WsyVc5DCWL2wmPrfD9iSN+sDi2aq1m9jehgLOq7VmsgnrBB4efaVb3mqTgkWL+Atmru2Dj8XHnbDVimEsFcoVodQV8ss8aX6O7bPXRW7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=RRSZvQaf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="RRSZvQaf"
ARC-Seal: i=1; a=rsa-sha256; t=1769636419; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V5zb5uJZnPW5xAwL4kUeEbADQW2EO/In+lKX2+svbS8T1nQEv895D3ayxzhI5siXhrS7NKq0q2PKvB1VKf95BLg8R+r7i6O8RTaLCYrOe1bbhUkwq5wJu6PLFiOmRSm0IMPxNC52kVMEQyG4GVXd4zy9T9tllxXeZuem3AHLjzs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636419; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oUGBDdZSwSA0RyzkMndD0QAHCaR2+Wr0uDXaB4GUAXc=; 
	b=ECWv3P54dXwEQkN6ITO8rKizcp13D8xIWVuO3a0ZSIzEhLgSO11l7G1Ha48mMdeIp6mKXoLmsF4AjS3GZcwmOjv1nFW3h4yXJ3g7ufUl1ZbKMEnZARww68z/l9LAH5vk1RxJ4pWY3wGiRNNx74fBgghAwgeU0cz2RgEikE331Is=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636419;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=oUGBDdZSwSA0RyzkMndD0QAHCaR2+Wr0uDXaB4GUAXc=;
	b=RRSZvQaf4dzf/zfbNdqinA/c/vbII8JI0vP6VlaCWOqFJ02WOqRljEstnrGwccxZ
	//V0UOMJ8pGryAwF/RoARqzm2BI8Cb4ldSSj0O6OacIGVQW04F++p2K7ZY7hK1iHLp+
	WFoc77sAFIS4D8Jb2h7Cj2Bolfoei10G2HSIjMls=
Received: by mx.zohomail.com with SMTPS id 176963641800982.76248510304288;
	Wed, 28 Jan 2026 13:40:18 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 11/12] receive-pack: convert update hooks to new API
Date: Wed, 28 Jan 2026 23:39:26 +0200
Message-ID: <20260128213927.3026875-12-adrian.ratiu@collabora.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Emily Shaffer <emilyshaffer@google.com>

The hook API avoids creating a custom struct child_process and other
internal hook plumbing (e.g. calling find_hook()) and prepares for
the specification of hooks via configs or running parallel hooks.

Execution is still sequential through the run_hooks_opt .jobs == 1,
which is the unchanged default for all hooks.

When use_sideband==1, the async thread redirects the hook outputs to
sideband 2, otherwise it is not used and the hooks write directly to
the fds inherited from the main parent process.

When .jobs == 1, run-command's poll loop is avoided entirely via the
ungroup=1 option like before (this was Jeff's suggestion), achieving
the same real-time output performance.

When running in parallel, run-command with ungroup=0 will capture
and de-interleave the output of each hook, then write to the parent
stderr which is redirected via dup2 to the sideband thread, so that
each parallel hook output is presented clearly to the client.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 103 ++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 37 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9c49174616..f554dac1ef 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -561,6 +561,48 @@ static int copy_to_sideband(int in, int out UNUSED, void *arg UNUSED)
 	return 0;
 }
 
+/*
+ * Start an async thread which redirects hook stderr over the sideband.
+ * The original stderr fd is saved to `saved_stderr` and STDERR_FILENO is
+ * redirected to the async's input pipe.
+ */
+static void prepare_sideband_async(struct async *sideband_async, int *saved_stderr, int *started)
+{
+	*started = 0;
+
+	if (!use_sideband)
+		return;
+
+	memset(sideband_async, 0, sizeof(*sideband_async));
+	sideband_async->proc = copy_to_sideband;
+	sideband_async->in = -1;
+
+	if (!start_async(sideband_async)) {
+		*started = 1;
+		*saved_stderr = dup(STDERR_FILENO);
+		if (*saved_stderr >= 0)
+			dup2(sideband_async->in, STDERR_FILENO);
+		close(sideband_async->in);
+	}
+}
+
+/*
+ * Restore the original stderr and wait for the async sideband thread to finish.
+ */
+static void finish_sideband_async(struct async *sideband_async, int saved_stderr, int started)
+{
+	if (!use_sideband)
+		return;
+
+	if (saved_stderr >= 0) {
+		dup2(saved_stderr, STDERR_FILENO);
+		close(saved_stderr);
+	}
+
+	if (started)
+		finish_async(sideband_async);
+}
+
 static void hmac_hash(unsigned char *out,
 		      const char *key_in, size_t key_len,
 		      const char *text, size_t text_len)
@@ -941,29 +983,25 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct async sideband_async;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
 	int code;
-	const char *hook_path = find_hook(the_repository, "update");
 
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
+	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
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
+	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
+
+	return code;
 }
 
 static struct command *find_command_by_refname(struct command *list,
@@ -1639,34 +1677,25 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 
 static void run_update_post_hook(struct command *commands)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+	struct async sideband_async;
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook(the_repository, "post-update");
-	if (!hook)
-		return;
+	int sideband_async_started = 0;
+	int saved_stderr = -1;
 
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
+	prepare_sideband_async(&sideband_async, &saved_stderr, &sideband_async_started);
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks_opt(the_repository, "post-update", &opt);
+
+	finish_sideband_async(&sideband_async, saved_stderr, sideband_async_started);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.52.0.732.gb351b5166d.dirty

