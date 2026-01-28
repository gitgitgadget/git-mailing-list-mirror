Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD83358B8
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636420; cv=pass; b=OeBJnMAr1lZZ5tSk5qO4oZJKwrcbZ47Xnen0dT/JPd7bva/SGCAdnqBk9nYoX1ZOZD5tTtKLiUSOPy+hBCD4Z6J/ubzZ5t/c/N07PmAsb+iFW/4QM4mJMsjkMUZ92okHPgA9vVRfs/DmEdi+R3ugKdAdNhjYOxbUARZu/kSUPIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636420; c=relaxed/simple;
	bh=BTc/70VSyx4znX5Kj1wznvQzUCrA+vvxjpuKip4QnTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAvW3OILV1Jw8RaZiuQsE4ZzMi0IES0xvjdduJPkiHfquHLE0z0M2h6xm1WemnRIo75zWiaJ+yinWJRRWKGomyP3Cd2/+ITKBATvrPGZlFYWhpFsPEVf5z4h8JY2QeVcCWcFN1o1Rscjv/VR2YHfFZpX7roanVwK3B2L/8JVlBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ftnvuaDz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ftnvuaDz"
ARC-Seal: i=1; a=rsa-sha256; t=1769636405; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZzDssvBFuF2hN15VNHmktn0HxF5LTBoPOB5htzXR1TDJyudgrWYdNNFKlxswU11KR/PIwwqS4CsmFMfOwuRLaK/gvRZ6+r1co3j8p82jEmkMRko9gen99f/lP5RSV68avWOp6Vvkv0xNQx2xMhieDrUewH2zkm6ws6Z+VirQRc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636405; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+CvT/hORnfjxezHw3GqdhL1bQ02gpSli3wUVAF9ZUPg=; 
	b=URQ2dcKX9OMVOx40sWbWX4hAIBpIUVfgDp093cxhU9hpLMGsYGQueQIKBEnq9AM5y51N8pzboUt2aFqjFbHpeeFqEFhKMWY07V9pyEf9sJpKrK0hGhvMWZHRH1RK/5md+NnCjsxPMupm1ZklMt2WlB/K/7V/WvFJ8kWmmZrd9Q4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636405;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+CvT/hORnfjxezHw3GqdhL1bQ02gpSli3wUVAF9ZUPg=;
	b=ftnvuaDzKXPKKNwKQlmHKbq7tMEaBWZMMoIOT7XOOQ4QrlknlZDbGOx4FUu1dUmU
	IqY83e77C7a/sveEGKwdflko3LG/LamggQusudn2QZyXsHFZu1BLieVSzAWLk7pdEcv
	FBcHIdkVGIYh9fLFEGHriHMkD1lBxccNIt7GIPHw=
Received: by mx.zohomail.com with SMTPS id 1769636403438160.42818880122525;
	Wed, 28 Jan 2026 13:40:03 -0800 (PST)
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
Subject: [PATCH v8 05/12] hook: convert 'post-rewrite' hook in sequencer.c to hook API
Date: Wed, 28 Jan 2026 23:39:20 +0200
Message-ID: <20260128213927.3026875-6-adrian.ratiu@collabora.com>
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
index 1f492f8460..cccde58bee 100644
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
2.52.0.732.gb351b5166d.dirty

