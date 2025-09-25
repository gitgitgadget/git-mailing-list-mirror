Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFB2AE68
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804874; cv=pass; b=kaN2/jwZEcNGvBU6EMS8H/OIHaSbRm4au2zHHhjX6ifTjBXBbQeoqL5rePyiJn9sMZIR7wUJalUk9/Q5wHuS5gzbid006ME5+KPkEubzjOOmQDWbRoE6ympO2gaVwwj1rrr+uZ79bRnSIJtpcNXG1/qNd7RqC7JhCy1Kbb9qKKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804874; c=relaxed/simple;
	bh=cTnX/Hbi2cK+G6h/gIuxrpP7h/zsYyEmWmC3hmjSc6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AI5idp4YYCY1bq+M3eSK6KUABMbizONKiRZXTizp74Igg+PSF8CX62TPHaPwk1DScvcK4AgHEPY4PQPVTyI+DoO4suOvkuwL58tRiE5imq9Yh4zRkyuyv8u4Bh2Q8Cxnt9Af4PTC1uuoS3HS/gGa/ytZxqyU4sB1TyHrAQ171sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=fhV4d+wi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="fhV4d+wi"
ARC-Seal: i=1; a=rsa-sha256; t=1758804862; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ot33bobSlpFWInA4NUn/8hfsGcQE0aAqTW3ArO4UuQGhEfOpOrO1OZaGQ3HKJuOrCWzeJ+p5pfButkR5czcx25ZJzFsOkfr2Ps0qZXj3xki533jvbxjAfsGTNj0Up4zUS0EEw8ysLxSJwehQrjenuX9Z4k7kuuf3p7EnVwxpNjM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758804862; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4f9WExWVXIHAYZD/bcLuIKbcktSapSgu8mG313Ep/cQ=; 
	b=TodThkaBesFq7JgFs5IUULrnUCLEZ9JV2Xj9sxw51TQiJmRGQ8UobyhPod7IzEk98sK8Hujy+NAdSz5CmbponZIchRXjyXKpGzCowHWNwsDPwnWCnmcO/m7pT0jd1VYxfGKJLZe3vSV55Ub42nllyfsAVpVriRNYvARcrBLydKw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758804862;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4f9WExWVXIHAYZD/bcLuIKbcktSapSgu8mG313Ep/cQ=;
	b=fhV4d+wiALEDtUfLZ51bo3LqOSPIkMXtCdUNhBdZRYCkkXK/Uhrwu3oIDG0Odnof
	3IapOGSJ0pGCJRa0ckLAMhceYeuDr7SIITRFocGPVc4TlhKTTAME5VYc57N51lSwmCn
	V+jm0Esp767/Caw35YhW36Z0ZjpaX4DBQXrn3w8c=
Received: by mx.zohomail.com with SMTPS id 1758804859365855.2871773839695;
	Thu, 25 Sep 2025 05:54:19 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 02/10] hook: provide stdin via callback
Date: Thu, 25 Sep 2025 15:53:45 +0300
Message-ID: <20250925125352.1728840-3-adrian.ratiu@collabora.com>
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
 hook.c |  8 ++++++++
 hook.h | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/hook.c b/hook.c
index b3de1048bf..54568d5bc0 100644
--- a/hook.c
+++ b/hook.c
@@ -69,6 +69,10 @@ static int pick_next_hook(struct child_process *cp,
 	if (hook_cb->options->path_to_stdin) {
 		cp->no_stdin = 0;
 		cp->in = xopen(hook_cb->options->path_to_stdin, O_RDONLY);
+	} else if (hook_cb->options->feed_pipe) {
+		cp->no_stdin = 0;
+		/* start_command() will allocate a pipe / stdin fd for us */
+		cp->in = -1;
 	}
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
@@ -140,6 +144,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
+		.feed_pipe = options->feed_pipe,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
@@ -148,6 +153,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
+	if (options->path_to_stdin && options->feed_pipe)
+		BUG("choose only one method to populate hook stdin");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 11863fa734..8fdbc8c673 100644
--- a/hook.h
+++ b/hook.h
@@ -1,6 +1,7 @@
 #ifndef HOOK_H
 #define HOOK_H
 #include "strvec.h"
+#include "run-command.h"
 
 struct repository;
 
@@ -37,6 +38,24 @@ struct run_hooks_opt
 	 * Path to file which should be piped to stdin for each hook.
 	 */
 	const char *path_to_stdin;
+
+	/**
+	 * Callback to ask for more content to pipe to each hook stdin.
+	 *
+	 * If a hook needs to consume large quantities of data (e.g. a list of all refs received in a
+	 * client push), feeding data via in-memory strings or slurping to/from files via path_to_stdin
+	 * will not be efficient, so this callback allows for piecemeal reading and writing.
+	 *
+	 * Add initalization context to hook.feed_pipe_ctx.
+	 */
+	feed_pipe_fn feed_pipe;
+	void *feed_pipe_ctx;
+
+	/**
+	 * Use this to keep internal state for your feed_pipe_fn callback.
+	 * Only useful if you are using run_hooks_opt.feed_pipe. Otherwise, ignore it.
+	 */
+	void *feed_pipe_cb_data;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -44,6 +63,9 @@ struct run_hooks_opt
 	.args = STRVEC_INIT, \
 }
 
+/**
+ * Callback data provided to feed_pipe_fn.
+ */
 struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
-- 
2.49.1

