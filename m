Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF71FDA61
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804891; cv=pass; b=JV//Kr+XaURjuioWhY7cgJqOD7Cnv77Fs4qQjI9JWS7clYRNTjhyL05zJZ7btphWbh4VrNN1BJV0n++qMSQTdceSgwfW6Rfktg4jJd6H5IqCRbK9AbXxgYBPPnZpxw3JjQsVRkBt59bbke4CbSyVjktGUNUize1Sw5+qUzcKCkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804891; c=relaxed/simple;
	bh=i3KNlGxDqFQRGLfElEa9YssJ65ZP9OMluhwJvQphCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu7ZqXSeIuTNgukfIpvmRuxPCesVmlerzWCo6JcSMW5CBLZpfjtarHL1/uqSYKYAmt0FbB5R1vVuzu6V4EJoL6BPHJ1fEdd7YteySTM0k5XL9FLCeM1y1pxUdfx+qmxCetMUPi+uAQPw9kxtc0Jw0uB9u08YGXz2UlNgbsyuQew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KfgJg4vj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KfgJg4vj"
ARC-Seal: i=1; a=rsa-sha256; t=1758804879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qp0ec+F0OUBK/mmj2TS7NOFCC/vbgU8hF67I7L1KCNQEIYISy+ALHdfFyhag/El2rMs8TfW6WpGH3+DKRmR6MGR69MSseUWcwfM43drtUVbOElUGMCMy2e2qxFLoiEOjL/PLwWek6z0QA1BtzDwgFHoeWYU1awhh5i18PprEAUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yTnb0TQdsH1PiFOtw87p8uJ3Fc+wIS5qlHCo/CgtisE=; 
	b=eG/kJ/QKMAAbmq4njfzSgOedK1D2h3U/PJVV0vNWu05IQe0wKprjQZi4Z1duPuXsrXL6Vm7vKmRV07NMQmxhSlV5in88Q1kTDpMsKhJjcV4Zw6qGEMIjVxG6Un0CzWTjNtgrDnTWDWqYJmXg/3uR0XiL0fNMOYq3gA+Orzm4u4o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804879;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=yTnb0TQdsH1PiFOtw87p8uJ3Fc+wIS5qlHCo/CgtisE=;
	b=KfgJg4vjl2W10gh4FxPH2QcnPpFR/TrhTdLLKvktuQ8p+kBA6fImSrydgfYUkQ9p
	6BVFiobEZwAFiEeHYyS1NV/siVfFm9q6ea+vuPDyH/d8KY9zicQUoKV+OoXJY68yWdx
	o5KEKq8o/BeBZNkmy4FjU1AYNmiY4Sh88LInKeMI=
Received: by mx.zohomail.com with SMTPS id 1758804877362716.0610999757615;
	Thu, 25 Sep 2025 05:54:37 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 09/10] post-update: use hook.h library
Date: Thu, 25 Sep 2025 15:53:52 +0300
Message-ID: <20250925125352.1728840-10-adrian.ratiu@collabora.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d5192ce132..78d4df349e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1662,33 +1662,20 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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

