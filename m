Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879A2F6937
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710665; cv=pass; b=q+37HT+XMSMENv5+uelOcDCh9PlxuHG3YEbz+njY3osvjqrSUYUMGKZmEkL2s0FjEatE3WuvXIIINcqOJpOHh1RA4S7VbFViTRwSRytL97E6pwoyCkev3l3qVIQbslwUL3J2XWseVf5zy7oYG2sUr7Dt8BbhkBtKUo6Cmx9s2zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710665; c=relaxed/simple;
	bh=Ln7VHHGc39AddsEox9dUOx1T+a+URibyutLTA8qgaIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3wUciOwkCBXLD1SdpYd9wdOPLg+QvxTgY0bk53b0uIErT9B6VtTbawlXa5U3fYdecFxTUDGhk9wJpT3PWRp+CK9Avq7yyCpZX3PnybqbB2eDVIEuL7bwAfZ8J/sq/WrfdxhzBnjRBOQMuAR7VjxRelydkZdNexKW4qDTGTw8+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Sm0ogFAS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Sm0ogFAS"
ARC-Seal: i=1; a=rsa-sha256; t=1760710655; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VuNr7ANHIIgWTu8c12jotZMKGJSuMN8MeaO2S7SfmTYrsYNFs15wsvH7YBVmktPZQhttHGfMbAEU6uK/ynCusEPNUIAYcMFNdtkJkVHHX03fHAVQrWD+6rJcXgB8r8yoe7QxuktKqayL512uDmfGmh4L5Ren4EGTnTGZ++zGRBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710655; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Av9IR4qIxu2f6DQnCFp/RGVsM6crvD9deV01Dn/nx3c=; 
	b=SLqo1Sb7xMTkXKI1ZT7IMgFHQ5fUWknTOD920xksy4L1nCQ60WZeIaCWWPLc1t845YI8Pge/78+iNc5LTUQY/Cro9mrA123L43xKm1pGy+8z3OE749hWx1y5aAL5wUhbVG0oYiCgnBbmAk1gQwmv/MiBgEpXrkGRm2YOHAjqD0A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710655;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Av9IR4qIxu2f6DQnCFp/RGVsM6crvD9deV01Dn/nx3c=;
	b=Sm0ogFAS2Gmt2le6emh4ZgA440aFbdKC4bjOJvIG8Cr8Gb3CQemwdLQB4PZku/Ks
	XfRUmsLL3A20ok8tT3VSj/NYher+Tzt57hVIlxEnviSvKeCTGZRudruMGQ7vArjh7/j
	00ZYlYkd9F+gIefxpSW7zDUGhQh8w74AN4gmXvFk=
Received: by mx.zohomail.com with SMTPS id 1760710652674308.4191006270895;
	Fri, 17 Oct 2025 07:17:32 -0700 (PDT)
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
Subject: [PATCH v2 09/10] receive-pack: convert update hooks to new API
Date: Fri, 17 Oct 2025 17:15:43 +0300
Message-ID: <20251017141544.1538542-10-adrian.ratiu@collabora.com>
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

Use the new hook sideband API introduced in the previous commit.

The hook API avoids creating a custom struct child_process and other
internal hook plumbing (e.g. calling find_hook()) and prepares for
the specification of hooks via configs or running parallel hooks.

Execution is still sequential through the current hook.[ch] via the
run_proces_parallel_opts.processes=1 arg.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/receive-pack.c | 60 +++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 39 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9288a9c7e..93b6f28662 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -939,31 +939,26 @@ static int run_receive_hook(struct command *commands,
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
+		opt.consume_sideband = hook_output_to_sideband;
+
+	return run_hooks_opt(the_repository, "update", &opt);
 }
 
 static struct command *find_command_by_refname(struct command *list,
@@ -1640,33 +1635,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
+		opt.consume_sideband = hook_output_to_sideband;
 
-	if (!start_command(&proc)) {
-		if (use_sideband)
-			copy_to_sideband(proc.err, -1, NULL);
-		finish_command(&proc);
-	}
+	run_hooks_opt(the_repository, "post-update", &opt);
 }
 
 static void check_aliased_update_internal(struct command *cmd,
-- 
2.49.1

