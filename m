Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE8188596
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004899; cv=pass; b=OXXvN7rTDKDZBlKnS+8eJmq1nmlLv7o8ZEuvtWvnzEFCJrvyOPmBVjA5PkPh4bqy3FvzK7czeqHIvAAsykYQycg3//DL1sc5al2Lg8Juox0D6iab6A+9Iu8CwXChTiJ9S76BVfehnaCoT5vEyZSvwL3sA+3kyFLbJNEF66qpnhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004899; c=relaxed/simple;
	bh=0NLyBcdRmwS6GGrP5cb0q3Xfc3FWIL0v6Pr2Z71ImpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akbpUQfIfywowy+osq6Vz6OeqXcQrsec2TQ8nH63r0A5mnJJYjL6XXOUhN3B7k+15loWyvZ0ye5OUmnpNbLCsuVGl9tL4AzM/3ZUMJMIkSnsBhHagxKIe12eKfIPIeoW1ML06jPlitXDzzKrp5nMhcR4kT/OHV/CdBhBaEJrgeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jIWA85Nb; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jIWA85Nb"
ARC-Seal: i=1; a=rsa-sha256; t=1764004886; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kXp52ZiQZOMQQuBo/x04tIs2rFgsv3YCic2v5dKyG4Dv6XbcpnZyfO6uR6+7EAuMMSWPsUtujaNtFtB8q0c0qqicYu3sSQ0VVJU3/2gIBOIrHY5VixfA/ssb7bhx83uHrmoTvOU7ckHmDcOXekp1e/nU2b6uW1hwS+zxOUr+O0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004886; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OyusOpy2NXY+fJc0Ipjwr1VRukutLNXDiopDCGwEOV0=; 
	b=BC4HnI56f3VzGKd1/bpaBeLvpQ170XKrIYKZli1U2t9T88pcdWzEGpzT+pVYJpegx5C3xO+ZfIHr6RKkLo+SqNNcP/924xZsxID1VgX66YISRkGETLCNhWVToGNwllQi2ATCfOSQK7WrgpzMvSR06COrM0dDAa/L3Mh4qyQITwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004885;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OyusOpy2NXY+fJc0Ipjwr1VRukutLNXDiopDCGwEOV0=;
	b=jIWA85Nbvc9il/B6SetgDPk0E9s0ZVIeZdLQeoqx2ul7FUEBw29QZ2NQOFv+aPZx
	vCP8chZZ+dth9AnVozV6XUiX2foOHXmpoWTvPVRsQGYNcWPZHYQlGx/ttjBTZiXIWWr
	uuw5Rs6NYw+3rDTj99TvsCD4id1uItlyrtbLM+S0=
Received: by mx.zohomail.com with SMTPS id 1764004883353754.0315380802399;
	Mon, 24 Nov 2025 09:21:23 -0800 (PST)
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
Subject: [PATCH v3 09/10] receive-pack: convert update hooks to new API
Date: Mon, 24 Nov 2025 19:20:42 +0200
Message-ID: <20251124172043.1650014-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124172043.1650014-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
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

