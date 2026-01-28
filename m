Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633732FA37
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636429; cv=pass; b=Dm45lIbV9ZNChtfZWu9Uss4utYn+v7PisQvyks9w9sU7gTDJ+HK+SJ3fUnRGsxz4IP0Qt9YJkACR1s2PeXK7Myo/5iksRuXfILGMwnA5TXXmVUZvjBHXKtQ+lm7QNQ/5TqicFG8yqGq/+ehfwyVqjtj6/UxgLj8sHDc5xxQsbnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636429; c=relaxed/simple;
	bh=fJ+ObV6POrHDhD45fmsTjWU7NVQmX+Zsf4cxFOnfKzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHZAjQs+IqCGTnYTyUiuzDPSpvvjp7bErIFd/F8PxYPl/A29lWzbpyRGehuwnQHOftWr8xxRc40tJsmc0PkBjueasTcVQ5h4JdsQwgipjus6aGfv9x3BwsIbEcmBYorXtbyamW48JNILKAXu56X2dhZRZfMA+DV8mDKbz4y4Z50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HXQybuRA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HXQybuRA"
ARC-Seal: i=1; a=rsa-sha256; t=1769636415; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WlfqQrModNjoWfYIfkUAxQb7NUv6iblD9VhpPwi+L6D97B36OwohtGTpI6AShuYlYFe1QjsbtYnrn6cDp4Op1K91D/pA06zaGmpXGZQoA94GaLkY+vVKFnIbvQpkaC2GHJl2zat+sRsD035XsUVeM7oLmDHds6kWwmSYx1ZGiQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636415; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4WtefoJEj/WpA3/l/0trI2QZPeK9MxitiNhV478MmH0=; 
	b=YfnmQ7JkAAoUYnUjuvZNEpv3Xner/EYm7358LIV5DVFX0CtmdDUECAJW8yx2KKQTVJb1fBN/397GO3q/z7ViJ/xCrW/dBiL8kOQDfCOLT/K4h6pKBq2GRg7aPxa/EwW/9Jll7pcTOGMsNsBIFDcGXDjpOwJYcQJZWrr5+DWCiHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636415;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4WtefoJEj/WpA3/l/0trI2QZPeK9MxitiNhV478MmH0=;
	b=HXQybuRAXjFbbl9R6C56uJ+qgDJjUXipFnUswtLk3olp2MwQc6M+2DayLQN1i+Vq
	n6G40+0fSKw3aGYTL71dm/FzY8xxet34cxDC/xhPtsmBDAMBrnhMX3nsQngNC82ZOYj
	d/jn3PBWbaTwyLKrBNfkuDfkGgl70Nc9/od7boOw=
Received: by mx.zohomail.com with SMTPS id 1769636413364546.3080282934445;
	Wed, 28 Jan 2026 13:40:13 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 09/12] hook: add jobs option
Date: Wed, 28 Jan 2026 23:39:24 +0200
Message-ID: <20260128213927.3026875-10-adrian.ratiu@collabora.com>
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
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Allow the API callers to specify the number of jobs across which
hook execution can be parallelized. It defaults to 1 and no hook
currently changes it, so all hooks run sequentially as before.

This allows us to both pave the way for parallel hook execution
(that will be a follow-up patch series building upon this) and to
finish the API conversion of builtin/receive-pack.c, keeping the
output async sideband thread ("muxer") design as Peff suggested.

When .jobs==1 nothing changes, the "copy_to_sideband" async thread
still outputs directly via sideband channel 2, keeping the current
(mostly) real-time output characteristics, avoids unnecessary poll
delays or deadlock risks.

When .jobs > 1, a more complex muxer is needed to buffer the hook
output and avoid interleaving. After working on this mux I quickly
realized I was re-implementing run-command with ungroup=0 so that
idea was dropped in favor of run-command which outputs to stderr.

In other words, run-command itself already can buffer/deinterleave
pp child outputs (ungroup=0), so we can just connect its stderr to
the sideband async task when jobs > 1.

Maybe it helps to illustrate how it works with ascii graphics:

 [ Sequential (jobs = 1) ]             [ Parallel (jobs > 1) ]

 +--------------+                      +--------+   +--------+
 | Hook Process |                      | Hook 1 |   | Hook 2 |
 +--------------+                      +--------+   +--------+
        |                                  |             |
        | stderr (inherited)               | stderr pipe |
        |                                  | (captured)  |
        v                                  v             v
 +-------------------------------------------------------------+
 |                      Parent Process                         |
 |                                                             |
 |      (direct write)              [run-command (buffered)]   |
 |             |                                 |             |
 |             |                                 | writes      |
 |             v                                 v             |
 |      +-------------------------------------------+          |
 |      |             stderr (FD 2)                 |          |
 |      +-------------------------------------------+          |
 |                           |                                 |
 |                           | (dup2'd to pipe)                |
 |                           v                                 |
 |               +-----------------------+                     |
 |               | sideband async thread |                     |
 |               +-----------------------+                     |
 +-------------------------------------------------------------+

When use_sideband == 0, the sideband async thread is missing, so
this same architecture just outputs via the parent stderr stream.

See the following commits for the hook API conversions doing this,
using pre-existing sideband thread logic from `copy_to_sideband`.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 7 +++++--
 hook.h | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hook.c b/hook.c
index fde1f88ce8..cde7198412 100644
--- a/hook.c
+++ b/hook.c
@@ -152,8 +152,8 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
-		.processes = 1,
-		.ungroup = 1,
+		.processes = options->jobs,
+		.ungroup = options->jobs == 1,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -169,6 +169,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
+	if (!options->jobs)
+		BUG("run_hooks_opt must be called with options.jobs >= 1");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 2c8a23a569..20eb56fd63 100644
--- a/hook.h
+++ b/hook.h
@@ -16,6 +16,14 @@ struct run_hooks_opt
 	/* Emit an error if the hook is missing */
 	unsigned int error_if_missing:1;
 
+	/**
+	 *  Number of processes to parallelize across.
+	 *
+	 * If > 1, output will be buffered and de-interleaved (ungroup=0).
+	 * If == 1, output will be real-time (ungroup=1).
+	 */
+	unsigned int jobs;
+
 	/**
 	 * An optional initial working directory for the hook,
 	 * translates to "struct child_process"'s "dir" member.
@@ -90,6 +98,7 @@ struct run_hooks_opt
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 	.stdout_to_stderr = 1, \
+	.jobs = 1, \
 }
 
 struct hook_cb_data {
-- 
2.52.0.732.gb351b5166d.dirty

