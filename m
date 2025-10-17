Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25836CE10
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710645; cv=pass; b=qcZmgJ58n0uFiykWJOSkGFuZZ4WO//mXE2LYFcZVBpS0bs8fkW1PrNh0mLXq/mk2o79Hb0eyVOyhwa9HiQ5L6Aguot8o/1kPe9zIFSm6fAPWBgspqXkdbErMEIvbOdioCghKXupxQQrpqV8cIJ97fg6wor6xepHwltHjwBYTGMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710645; c=relaxed/simple;
	bh=4RP03z/Pp62KFBw/RjBUnTJt0rLLwHDvOl1GScgslTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=outGTQ5p7fyqxG7DPHAt03v1nByGyvpy1lH83cUZLLUlSh9MOicCFB/iCVxYitrFegQyPmM6HEYsUwEoC1cqHImTjIl9J+b/4W74CyQizlaefmCHaKdh5m5NrBhZhljfjmj2kbvcuTrjbq7Mb+4yVpTqiP43vplk6qzXbg7PUII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=koF4BKnE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="koF4BKnE"
ARC-Seal: i=1; a=rsa-sha256; t=1760710633; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SvDXixBkwA6h1QMBSABtLFGOwgs5MzbL9vHWOrwKK0eGa86sOj20/4LuPhwNBHW3R/g9rlqdFdhBeo/Cq/SQ/sNmhymQ0Iwe8hEO4Duhz9ulTv/gf5skUBoaSpBB5Y3+0KBOw/ZkDi9OpvOlFgvu2CrekMVDjaDfR1av7fCELwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710633; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0zaIIC/NFjdS4p7lA8pDSoZkHFqN4TVtF0vom9ZmYSk=; 
	b=f4oQJcyO8JHZZ/CgwqSxcGb1I4SlKauUPPfiVKCzrm6eklMJE9K633M9Y1gx5WLqPr8eGj1NvPKvZAtImfW2UBaPmK5fnVJcfc4/2/XHevri/9y3QNdEZC3gcBPSE/12bMRDLnUmIYYbhmibk8yG9eUJtUfG8wNQkbcjWp6PxXg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710633;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0zaIIC/NFjdS4p7lA8pDSoZkHFqN4TVtF0vom9ZmYSk=;
	b=koF4BKnERuRpHXB1EyPfMm4tn+oA3OZVWmA8ovUR72kR3rX5lurUzObNg2D7wWBr
	pluqw6loUyBmDNmQfh7c9kINd4TxHLyh7Hj9dkcypDc3KDeUj+ycTW/n6D8JljD5407
	t9IAiPuabZ1whLSCwxlfAJDmhZuh5VtQjaakiv0U=
Received: by mx.zohomail.com with SMTPS id 1760710630968803.910641375988;
	Fri, 17 Oct 2025 07:17:10 -0700 (PDT)
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
Subject: [PATCH v2 02/10] hook: provide stdin via callback
Date: Fri, 17 Oct 2025 17:15:36 +0300
Message-ID: <20251017141544.1538542-3-adrian.ratiu@collabora.com>
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
 hook.c | 15 +++++++++++++++
 hook.h | 23 +++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hook.c b/hook.c
index b3de1048bf..7537cf0f9e 100644
--- a/hook.c
+++ b/hook.c
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
@@ -140,6 +151,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
+		.feed_pipe = options->feed_pipe,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
@@ -148,6 +160,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate hook stdin");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 11863fa734..ebe5dc450e 100644
--- a/hook.h
+++ b/hook.h
@@ -1,6 +1,7 @@
 #ifndef HOOK_H
 #define HOOK_H
 #include "strvec.h"
+#include "run-command.h"
 
 struct repository;
 
@@ -37,6 +38,28 @@ struct run_hooks_opt
 	 * Path to file which should be piped to stdin for each hook.
 	 */
 	const char *path_to_stdin;
+
+	/**
+	 * Callback to ask for more content to pipe to each hook stdin.
+	 *
+	 * If a hook needs to consume large quantities of data (e.g. a
+	 * list of all refs received in a client push), feeding data via
+	 * in-memory strings or slurping to/from files via path_to_stdin
+	 * is inefficient, so this callback allows for piecemeal writes.
+	 *
+	 * Add initalization context to hook.feed_pipe_ctx.
+	 *
+	 * The caller owns hook.feed_pipe_ctx and has to release any
+	 * resources after hooks finish execution.
+	 */
+	feed_pipe_fn feed_pipe;
+	void *feed_pipe_ctx;
+
+	/**
+	 * Use this to keep internal state for your feed_pipe_fn callback.
+	 * Only useful when using run_hooks_opt.feed_pipe, otherwise ignore it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.49.1

