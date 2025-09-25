Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53D14A0B5
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804888; cv=pass; b=fFulfJxHhNmOEMkBmAqTeBkyi8KdLRKSIq8ecMEcyI1A24OGiVT2KirlpGhBKQ9fBzAmzoJDHlMPCw0qb0kGM1ynVSlxDF+MUmu1j+FSGxFG3a7gJx0JtTHQ6RgLoLKarCzHpfcISfSRVJ+lz3fkAt2z7V857n8Znloaj1NLHlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804888; c=relaxed/simple;
	bh=h9q1e+pCL0VycXgnkLGl1c8hYao29nohzwEjMW2LLf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHRxQ9xthZO3v/MtMxOU3mBwv8Dh8Jm568ucXkDMKaFC4ozsiZrmWxiVyZVwckGjjb5DSsP+X+vCH9XJgcxpn5PRc2Fgilp2gkGQFOaK1Xg6Q4xhqR1WmZURuZXrXtuxRs/kMtFz4fruuIlOSJRsGbCwPCaUEuUBkRaTf5+lD8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IcT1rlNw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IcT1rlNw"
ARC-Seal: i=1; a=rsa-sha256; t=1758804877; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EB4kxkYd9qxgdv+1SUAI8+s4uZ4sFdr+lEhMa+Zgeiyh77BS3dbe02hJ+z/3HYNji8UdEmHFSaNBSthFegIT1v+/WoRAYqr/LcrfYSHUi4vDgV60u1d632HOswpNh/mgOQ8+NltXpu6buEpsB3PGVP5rPFeddqWf3meXkHNk7wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804877; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+CgZxQQ/a4WuU6FKNNdgkCiqpqIASB6/AO6PMJ8hRzs=; 
	b=b/ulfTULPtomVSa5A/gSguWE7O3s8n/nw2J+pRtlH9r/mrqkZW83pZ373BShKG08RxU+pi7bZl+luaQ5z/BfZPtrFFPGY+IaVvDaVjXZKsyVjs+HXEoZe506GdH9ClZzI2iX5Xh5AYdWqt5V4YYJFkW9HKQTIDSRYLtourEu51U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804877;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+CgZxQQ/a4WuU6FKNNdgkCiqpqIASB6/AO6PMJ8hRzs=;
	b=IcT1rlNwo1f6S/WE994zInB1CidZ+4xTtaztU43K03uwI1wDSqm3yEuPD6iHQZKw
	xjNYPOf1TsMpAO6WdmdTnDO06FXAvaZ0b/Zpkao41VdXElwKraRFn+fjiSupaods7UG
	qjNSoCj7BQMgMnQxFTKO9T8Hs17uj19LyiNz9XrY=
Received: by mx.zohomail.com with SMTPS id 1758804874904313.91270761031865;
	Thu, 25 Sep 2025 05:54:34 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 08/10] receive-pack: convert 'update' hook to hook.h
Date: Thu, 25 Sep 2025 15:53:51 +0300
Message-ID: <20250925125352.1728840-9-adrian.ratiu@collabora.com>
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

This makes use of the new sideband API in hook.h added in the
preceding commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 60 +++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1113137a6f..d5192ce132 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -939,31 +939,53 @@ static int run_receive_hook(struct command *commands,
 	return status;
 }
 
-static int run_update_hook(struct command *cmd)
+static void hook_output_to_sideband(struct strbuf *output, void *cb_data UNUSED)
 {
-	struct child_process proc = CHILD_PROCESS_INIT;
-	int code;
-	const char *hook_path = find_hook(the_repository, "update");
+	int keepalive_active = 0;
 
-	if (!hook_path)
-		return 0;
+	if (keepalive_in_sec <= 0)
+		use_keepalive = KEEPALIVE_NEVER;
+	if (use_keepalive == KEEPALIVE_ALWAYS)
+		keepalive_active = 1;
 
-	strvec_push(&proc.args, hook_path);
-	strvec_push(&proc.args, cmd->ref_name);
-	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
-	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
+	/* send a keepalive if there is no data to write */
+	if (keepalive_active && !output->len) {
+		static const char buf[] = "0005\1";
+		write_or_die(1, buf, sizeof(buf) - 1);
+		return;
+	}
 
-	proc.no_stdin = 1;
-	proc.stdout_to_stderr = 1;
-	proc.err = use_sideband ? -1 : 0;
-	proc.trace2_hook_name = "update";
+	if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
+		const char *first_null = memchr(output->buf, '\0', output->len);
+		if (first_null) {
+			/* The null bit is excluded. */
+			size_t before_null = first_null - output->buf;
+			size_t after_null = output->len - (before_null + 1);
+			keepalive_active = 1;
+			send_sideband(1, 2, output->buf, before_null, use_sideband);
+			send_sideband(1, 2, first_null + 1, after_null, use_sideband);
+
+			return;
+		}
+	}
+
+	send_sideband(1, 2, output->buf, output->len, use_sideband);
+}
+
+static int run_update_hook(struct command *cmd)
+{
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
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
-- 
2.49.1

