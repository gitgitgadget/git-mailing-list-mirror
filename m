Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66633EB00
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077941; cv=pass; b=UBYFxDbhPOf76By6mrKhbRW8UxcqQxpjSygFNQe6CW1wPoEFFU48/c01goh/zSuq6sM8d69qSsW+1mwqsrOxdIen66cQjeAT3zURtlgFFXWhVAN478uA0xUOkMKr+F0+LDzEarW/6YmpyoytQ82HKv8v956CfnUwcuM/9mjw+aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077941; c=relaxed/simple;
	bh=/U/dbPqdN4R6jfu1AAGkTogIpB3ai6QNDXs2JYyFRCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqkgwmnuVmrXrVizJcmoqUiwbfYMBt2/6viEorJaXxDZVYIs248hqTcUyBf2vioWPAowimGWaEDfT8XuslFuUiBARjWrsGR157pl67ES4XtaJiEJVaVYz+MBY9tcFXLmbKQRMkIs8WSq9EjNF/gXZyiL5wPS+fHEdM9RZ7hHlJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=F+6C+6xP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="F+6C+6xP"
ARC-Seal: i=1; a=rsa-sha256; t=1766077923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BGUudPEXecQu5mRBp0bvuyhj13dKPfhd48917xVii+EsWK3Z7aymQT2HXby9CLh6bN+bV4vWYaiUuBrPCn4IB/qadODv4ah6Q7ofJqLHcTRTzUUmHtHmD7sD/ad7vnJOOONR1uhafKWEX+KafZkfiYsjyqgpr4aE5gtNg004ITg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766077923; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M51o4CO/qEr3PW3wf0ujHlad+K7DjV+/NjXCxZwveyQ=; 
	b=ARiiwsqPJjNXc+2N4umrBLTNFsq09aypwNspklcTjzIEQourpT9hRf2lGrr3xbFCPgEO1gVHiSMyPH2ywmxFBeC4GnC17QLDMtHqW2LRc1u0ZRbO8uptjfY0Rlqebjmhe6IgA5T1Xv4zkC8hnuqdLc4i2ymLPIrtE1/UxUCIgmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766077923;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=M51o4CO/qEr3PW3wf0ujHlad+K7DjV+/NjXCxZwveyQ=;
	b=F+6C+6xPxBfbgi5lFKppGugTgrse7dFG7VNln4eAUKSZ/GU3hCusl/EcKcyntq+2
	FpDsvSyR/4wkWwkB0TESkz/FhPeEkiEuoefUKYgHi/Ra//Kw3HsVh/v3ib4s4CxGLeX
	s9+FmQpv5DMTLuEzgFkoLytJTIJwjZgP1BRdqNDg=
Received: by mx.zohomail.com with SMTPS id 17660779209621003.5395402922272;
	Thu, 18 Dec 2025 09:12:00 -0800 (PST)
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
Subject: [PATCH v5 03/11] hook: provide stdin via callback
Date: Thu, 18 Dec 2025 19:11:17 +0200
Message-ID: <20251218171126.588066-4-adrian.ratiu@collabora.com>
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
index 11863fa734..2169d4a6bd 100644
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
+	 * Add hook callback internal state to `feed_pipe_cb_data`.
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
2.51.2

