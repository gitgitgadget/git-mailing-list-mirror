Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504E346A1E
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857771; cv=pass; b=OzhoXpHxKE8JiXsv9WDtBe2eld/Gz0xjrYnLwfzifoXS3myUunWqm0FPbtI7wGPsbSIbjRWCnpILqP/wDeylHeHvkVkQj84+Wj2BddPhSudtqsSfXb4h1p7GPEQeTCVIUtwyxuF/hTgfoyJdGEWrxQhL2STqsB6pgxxAGXS2u9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857771; c=relaxed/simple;
	bh=rfxdOUHV/3y9FPmsYp2MpsPDssrpcDVM99gpWn6ptBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doqdKFN0GjLVa+yB3TD4NwlvjmBlCVXlrvRk/HmUVZhYDgT7zTuZjZnA8XQCnztCu4Hq3+5bLKwLipek/4Vu3+YVoiNALX2r33Id0kQmRSimzclh4R0rpnPXFW1DoV8U0i8/kVYOAubm+dZSBJP+aCwTTVXRr0XI4e/P1CmEfKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FDO/5F6a; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FDO/5F6a"
ARC-Seal: i=1; a=rsa-sha256; t=1764857756; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Em+VHXAPa67Euu0OuqcLAeUHB0u65yX1D5gWtf+13P+HDaqgVJWEq7lBY5tdngJmXmxdVvI/bGNbI+m7Vejh2xe8n2/+D1K5pIdCMxpFOP+4RaVj8xPdlRN4Ck+buzTmduKWZCiNSNRfTsT6zlf1HWMLSnDMqFZYUuL5tF0NXF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857756; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ojD8uzxfeXLTZpmAGbQu/seEKecA8/86fCKVEEm8Zgk=; 
	b=dpLSTcnPJBB9MOOciXoRVGCki3MwDrVIKg5wdXMJgiaK7YdsUJnLSy4/91fGvcZaULdGdoTL8vj8B07RGmZlI9hSGd/E9UJ8d0GMtU02lZLMJKOg5SP6YsgnL9HQuSiXklGRWhrEU/oLIRhYgwJN81sJaZCPOM3C1e48dfyjuk0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857756;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ojD8uzxfeXLTZpmAGbQu/seEKecA8/86fCKVEEm8Zgk=;
	b=FDO/5F6ahXwDL0bFxbSPC4mjbpaXV0FYHpEIYe7K1Ei+ZXDEh1WofsVI6H5jVdDS
	SkeZUBkEzjSxYI+WUmlEPKvnSrjCdIq7bYRwjox2nny3DBizSzWFUSE9dBwWamOvPqb
	jyvBI2o9PkVhn4TCocpOvNlPRLW67ZyLSKNfP+MM=
Received: by mx.zohomail.com with SMTPS id 1764857754970511.10272434779733;
	Thu, 4 Dec 2025 06:15:54 -0800 (PST)
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
Subject: [PATCH v4 03/11] hook: provide stdin via callback
Date: Thu,  4 Dec 2025 16:15:27 +0200
Message-ID: <20251204141535.1986263-4-adrian.ratiu@collabora.com>
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

This adds a callback mechanism for feeding stdin to hooks alongside
the existing path_to_stdin (which slurps a file's content to stdin).

The advantage of this new callback is that it can feed stdin without
going through the FS layer. This helps when feeding large amount of
data and uses the run-command parallel stdin callback introduced in
the preceding commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 23 ++++++++++++++++++++++-
 hook.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index b3de1048bf..5ddd7678d1 100644
--- a/hook.c
+++ b/hook.c
@@ -55,7 +55,7 @@ int hook_exists(struct repository *r, const char *name)
 static int pick_next_hook(struct child_process *cp,
 			  struct strbuf *out UNUSED,
 			  void *pp_cb,
-			  void **pp_task_cb UNUSED)
+			  void **pp_task_cb)
 {
 	struct hook_cb_data *hook_cb = pp_cb;
 	const char *hook_path = hook_cb->hook_path;
@@ -65,11 +65,22 @@ static int pick_next_hook(struct child_process *cp,
 
 	cp->no_stdin = 1;
 	strvec_pushv(&cp->env, hook_cb->options->env.v);
+
+	if (hook_cb->options->path_to_stdin && hook_cb->options->feed_pipe)
+		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
+
 	/* reopen the file for stdin; run_command closes it. */
 	if (hook_cb->options->path_to_stdin) {
 		cp->no_stdin = 0;
 		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
 	}
+
+	if (hook_cb->options->feed_pipe) {
+		cp->no_stdin = 0;
+		/* start_command() will allocate a pipe / stdin fd for us */
+		cp->in = -1;
+	}
+
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
@@ -77,6 +88,12 @@ static int pick_next_hook(struct child_process *cp,
 	strvec_push(&cp->args, hook_path);
 	strvec_pushv(&cp->args, hook_cb->options->args.v);
 
+	/*
+	 * Provide per-hook internal state via task_cb for easy access, so
+	 * hook callbacks don't have to go through hook_cb->options.
+	 */
+	*pp_task_cb = hook_cb->options->feed_pipe_cb_data;
+
 	/*
 	 * This pick_next_hook() will be called again, we're only
 	 * running one hook, so indicate that no more work will be
@@ -140,6 +157,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
+		.feed_pipe = options->feed_pipe,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
@@ -148,6 +166,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 11863fa734..51cab785ea 100644
--- a/hook.h
+++ b/hook.h
@@ -1,6 +1,7 @@
 #ifndef HOOK_H
 #define HOOK_H
 #include "strvec.h"
+#include "run-command.h"
 
 struct repository;
 
@@ -37,6 +38,43 @@ struct run_hooks_opt
 	 * Path to file which should be piped to stdin for each hook.
 	 */
 	const char *path_to_stdin;
+
+	/**
+	 * Callback used to incrementally feed a child hook stdin pipe.
+	 *
+	 * Useful especially if a hook consumes large quantities of data
+	 * (e.g. a list of all refs in a client push), so feeding it via
+	 * in-memory strings or slurping to/from files is inefficient.
+	 * While the callback allows piecemeal writing, it can also be
+	 * used for smaller inputs, where it gets called only once.
+	 *
+	 * Add hook callback initalization context to `feed_pipe_ctx`.
+	 * Add Hook callback internal state to `feed_pipe_cb_data`.
+	 *
+	 */
+	feed_pipe_fn feed_pipe;
+
+	/**
+	 * Opaque data pointer used to pass context to `feed_pipe_fn`.
+	 *
+	 * It can be accessed via the second callback arg 'pp_cb':
+	 * ((struct hook_cb_data *) pp_cb)->hook_cb->options->feed_pipe_ctx;
+	 *
+	 * The caller is responsible for managing the memory for this data.
+	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
+	 */
+	void *feed_pipe_ctx;
+
+	/**
+	 * Opaque data pointer used to keep internal state across callback calls.
+	 *
+	 * It can be accessed directly via the third callback arg 'pp_task_cb':
+	 * struct ... *state = pp_task_cb;
+	 *
+	 * The caller is responsible for managing the memory for this data.
+	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.51.0

