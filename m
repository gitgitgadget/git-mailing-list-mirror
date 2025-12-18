Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C734DCCF
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077956; cv=pass; b=EU1sceWCcVhXwLxY4IUm7q0kW3s21gLupx3taLr9+wcUxeFQIEUQO+j2teB6QwVf2Q6OkroXzkHuRGK6DSZOUXM1yhZ6THPBT74zu0lNBz/ITtFN1TYbKRE5IOa15XW/0CCdRXfFkbH/R60vN3yNOo02bYHpcnFirl2iJj0DbSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077956; c=relaxed/simple;
	bh=RPOPx5lff8E/Ju4vajfIS2WZhNv830vQIJN5T7pkIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMxftXmcWFnhHgHW1tnxgWek/xSyWw/zn8skwf8ddGHZ9i5jjRKkUv6b6b4DYmYBmjHkA0wgUP9I1uZcbxWTZiclBsgYF0nF4RVA0aWZAEwcc8TLdhO+j1vIroNaACX7U4ZmRPXT1diF/n3k0rKlfbdH6d4/CIPzvFTwaeBTVvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NuBjGoh1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NuBjGoh1"
ARC-Seal: i=1; a=rsa-sha256; t=1766077942; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cNTGOlDQXXzJWQBvgBospEx3Hdy4xtUqSw5V09PkLwwxkE9+WVe2wsR31wCTqDfHa+vKanUCuCS7M3ZK5C+4QiXsn+SE6hPsdWc/BeZzQThd0Uapmkb2p9kpNVz93BxT9Cb4xpmVKm2D1C4MTi11yjxTBxI+HPGA9mTx4AfbJ+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766077942; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uy7jT4aE2iKv7+RWeqRI2KKBXHxYmLdRDJoABD+yo+Y=; 
	b=Cr2hC/OJKBBHeAGw3VGJyoddEb9oMDbQkN35xZZazWFRNOf41/0xplq0CUSCVg6klMAQs4pY+We2u/Y38CiSPma3c+HWLZfVOFMVSDNZrTfWPrVBcHX6hTlNzySDxou8c7equjuKKXbawJA+n01DL51BLmfsCKYxz3FFj/YJRSw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766077942;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uy7jT4aE2iKv7+RWeqRI2KKBXHxYmLdRDJoABD+yo+Y=;
	b=NuBjGoh17Etv/Q6dh3ZlRgTHxxXPDh4Y5dwMJwcwXoubnr/CctQmNDYijWEyBFLl
	8JmRrfjgwYnX6yYyLp9KvIihPT9BxCPvUKRkFSNF5rhyVPS3BQ8gZbaAI0DsObA2m4L
	NgDta3rCGZf2l1nO0FONNSufjMiobmHgCZplhPc0=
Received: by mx.zohomail.com with SMTPS id 1766077939674886.0929061106328;
	Thu, 18 Dec 2025 09:12:19 -0800 (PST)
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
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v5 09/11] hooks: allow callers to capture output
Date: Thu, 18 Dec 2025 19:11:23 +0200
Message-ID: <20251218171126.588066-10-adrian.ratiu@collabora.com>
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

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 hook.c | 1 +
 hook.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hook.c b/hook.c
index 00a1e2ad22..35211e5ed7 100644
--- a/hook.c
+++ b/hook.c
@@ -158,6 +158,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
 		.feed_pipe = options->feed_pipe,
+		.consume_output = options->consume_output,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
diff --git a/hook.h b/hook.h
index 78a1a44690..ae502178b9 100644
--- a/hook.h
+++ b/hook.h
@@ -80,6 +80,14 @@ struct run_hooks_opt
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
+
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_output_fn consume_output;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
-- 
2.51.2

