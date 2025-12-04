Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73C34888A
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857787; cv=pass; b=cPmU16KAlwQyDI3BiV8tOB67VyUAXigJGCoVxo55HME4EGSAjAXR8aGs/oC57pCOlt9jYDN6Hx6E15sHJXYlLpx3TtCZgX4qehfy8YOD66umL8dhWJ3mTDQn7PiB/0Nld4vsAUvz3Pn9DnOr0rbTKUAWdRccBs/WxnMbfGYFUQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857787; c=relaxed/simple;
	bh=0NLyBcdRmwS6GGrP5cb0q3Xfc3FWIL0v6Pr2Z71ImpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=se7965ydRvq/BWtqtsJ/WJ820lSd3NSbqKOJc2W/cdtEWeP8/NyAaABALjlaHw2JyRQU9XukccXlgk4udZVDdM4cY2P8w4xkGfLGLtJvNZ1jApr5s8QBE0YHY/Dhg8qeHBAHo0sjveas5mMTbs7s7rYFdKQyQ4PjeeRXbyYnpdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=b9Sno0eU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="b9Sno0eU"
ARC-Seal: i=1; a=rsa-sha256; t=1764857774; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jxG9FIpLR5pCSm5QG4B59OokdH/SPhVv8omjBfoHLduqdiLwm0LR22Gt+rs8QWp5QNpxJ5C78YshOsZGBSrhiKDvfMxYfr4adMLnNFTgHMhfR7ZLMGquFyDm2ayVRMSxzVP4TIk4GL2XcROCSmiAKl6nGiQRSlOflNJ1z7XL0E8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857774; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OyusOpy2NXY+fJc0Ipjwr1VRukutLNXDiopDCGwEOV0=; 
	b=Ew0JC/uxwivKyn0+Pv/zEge88OZVO+TJOtJPbYDSWwD2/rih3MijgEXsQL7scBdDGRvgwOAETqt1noZtjGfD5aVewJmRwPGmuzRih9v8QHFdzOFRey+TTivaTGrCSZ0CmktWc2HpK3R/Jyg+PXhB+wi/omvrElNMoA0BY2ISvuY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857774;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OyusOpy2NXY+fJc0Ipjwr1VRukutLNXDiopDCGwEOV0=;
	b=b9Sno0eUtc+VHmDf9tjoMCeu0LVaxjqOBm92sX8lK3cbPWZS5CIJqBVP2tNv2ta9
	KjFku7PZ+5MRPHEgXTfSAuR05vVAdAElj8ZclN9ZKg7AoygcCuRZ0055x7hOHKpvpW8
	FZVuPKsHjzLFT4PW8FfVXEiXahKuyPZ7ZvXeX/jw=
Received: by mx.zohomail.com with SMTPS id 1764857773948533.0306406903387;
	Thu, 4 Dec 2025 06:16:13 -0800 (PST)
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
Subject: [PATCH v4 10/11] receive-pack: convert update hooks to new API
Date: Thu,  4 Dec 2025 16:15:34 +0200
Message-ID: <20251204141535.1986263-11-adrian.ratiu@collabora.com>
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

Use the new hook sideband API introduced in the previous commit.

The hook API avoids creating a custom struct child_process and other
internal hook plumbing (e.g. calling find_hook()) and prepares for
the specification of hooks via configs or running parallel hooks.

Execution is still sequential through the current hook.[ch] via the
run_process_parallel_opts.processes=1 arg.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 60 +++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e8ee0e7321..d95df748cd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -938,31 +938,26 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
-static int run_update_hook(struct command *cmd)
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	int code;
-	const char *hook_path = find_hook(the_repository, "update");
-
-	if (!hook_path)
-		return 0;
+	if (output && output->len)
+		send_sideband(1, 2, output->buf, output->len, use_sideband);
+}
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, cmd->ref_name);
-	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
-	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
+static int run_update_hook(struct command *cmd)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "update";
+	strvec_pushl(&opt.args,
+		     cmd->ref_name,
+		     oid_to_hex(&cmd->old_oid),
+		     oid_to_hex(&cmd->new_oid),
+		     NULL);
 
-	code = start_command(&proc);
-	if (code)
-		return code;
 	if (use_sideband)
-		copy_to_sideband(proc.err, -1, NULL);
-	return finish_command(&proc);
+		opt.consume_output = hook_output_to_sideband;
+
+	return run_hooks_opt(the_repository, "update", &opt);
 }
 
 static struct command *find_command_by_refname(struct command *list,
@@ -1639,33 +1634,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 static void run_update_post_hook(struct command *commands)
 {
 	struct command *cmd;
-	struct child_process proc = CHILD_PROCESS_INIT;
-	const char *hook;
-
-	hook = find_hook(the_repository, "post-update");
-	if (!hook)
-		return;
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
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
+	if (use_sideband)
+		opt.consume_output = hook_output_to_sideband;
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks_opt(the_repository, "post-update", &opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.51.0

