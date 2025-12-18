Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32734DB60
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077960; cv=pass; b=VPsoRMZvyJStLqjAGEUiL2QFQpbCos213b1a6M3t/FVgUWLypdEK+Y2cBGMDgmn5WYcca28R/QKWTlVXOdtZvIPToW0oFs1qzf+wSF4k7CjmKgs13TYH3FkP6HDUs9DUuqyF1Be1IT46nrLJQH51IgH4xCZAukVwsC3MOK70SLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077960; c=relaxed/simple;
	bh=rmENuhB8SlKBTh9e2IwWw37sC4hH/lr6GtzVeu/DgzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKqAPb25WkbkU8F8hnKL4fYiKQsQO8e7+2QcXeCRqVcrd7toMAlEJdX7fGIzNkdtk9vZM4xWqovtmqv3RnpcW3v5WsTU2sp+V5G+ZIRIUt5aF8vSSGtyWNO0wBDhnM9HZ+2hnx6rtcYSQGg3Z1n3zgdVKyiDnL4YwZZAifcDpIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=YQQJg9TT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="YQQJg9TT"
ARC-Seal: i=1; a=rsa-sha256; t=1766077944; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PlnSYw3RzO5G0sShv6ttWDpiyBEJg7X+vhw+WSwmIT8wkbKf6OiiDc+RDnuWH77pemqPEaPzINnJcrDClKkHDl921dKipa4zXxGUxwPi2xO+T/niLk5D+c+XVYn+6hl4Ol6t7NBn1WM+2XTfzlZHc95TFH+PIBq+Fu0NMFGnEgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766077944; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QdfmOHEfr+++YCCzoaJJO8vzqcor9sFlSA7vEu13dQ8=; 
	b=nfPkA8WeoYezskzOqogGRL6vj5K/LirhjYzfg5SggbWNMrzOpRQqhSmbnMI8/5fWj9w4p1B3YQFCbOX7Nkd4lD5CEBlfURY5ISkPksRpXfMYisx/CF26apuH3aoDW+Z0HI+cVyw/mbYYOjrq4fOs0xa7cAHcek4HXPichskpP7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766077944;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QdfmOHEfr+++YCCzoaJJO8vzqcor9sFlSA7vEu13dQ8=;
	b=YQQJg9TTaSsaFr5X/4Vke+fI0iU5fYzn8Y3PSdLSDVOuQ9A/NDLPyiaK66MChcNO
	dCchD57YJ4MlKGju17nywhuEhgzlVLBgkW2O2K3FLYWuynU+/quWradjsTYQJE3WfkW
	UF0A6bTc0XoHKtVHNFUvaMLbnv2o998t4pkfG+2Y=
Received: by mx.zohomail.com with SMTPS id 1766077942876425.46262464703295;
	Thu, 18 Dec 2025 09:12:22 -0800 (PST)
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
Subject: [PATCH v5 10/11] receive-pack: convert update hooks to new API
Date: Thu, 18 Dec 2025 19:11:24 +0200
Message-ID: <20251218171126.588066-11-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218171126.588066-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-1-adrian.ratiu@collabora.com>
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
 builtin/receive-pack.c | 64 +++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 39 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9c49174616..d1c40a768d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -918,6 +918,16 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 	return 0;
 }
 
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
+{
+	if (!output)
+		BUG("output must be non-NULL");
+
+	/* buffer might be empty for keepalives */
+	if (output->len)
+		send_sideband(1, 2, output->buf, output->len, use_sideband);
+}
+
 static int run_receive_hook(struct command *commands,
 			    const char *hook_name,
 			    int skip_broken,
@@ -941,29 +951,18 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	int code;
-	const char *hook_path = find_hook(the_repository, "update");
-
-	if (!hook_path)
-		return 0;
-
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, cmd->ref_name);
-	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
-	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
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
@@ -1640,33 +1639,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
2.51.2

