Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F1314B6E
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766751917; cv=pass; b=qKlzUeONXEYVh6GYqPGyAA0eJRalaGNs3gsV4YvwZmIZWMZ0MEUgltlPGI5bwHnzQvq90r4XodiDGpFxfazaV6LBIKnfwgR2aT5CKh5wp+3CCZZYS08TdUpbz6ll7a4d1W9ab9bUfKi2sx56IZjPIkwcjF1wWT56xvmJeIVkHSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766751917; c=relaxed/simple;
	bh=RPOPx5lff8E/Ju4vajfIS2WZhNv830vQIJN5T7pkIOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J00ep1XGnfGW56BcrDw8VyTtUCCZvw/NCjiGy5ME16+EgTkbl9K2pgfwLcgf6RwwiPjI5ssy5/QITZ/xMba4GsFopbM+FR4WoXH6Ezqf1TdXA8RMKH9oU+9/I+Z///Gd9tn9xGFhhxeoi8t/Q+AaWeOHwCjNG+9FB5x/10YbiBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T1m4meco; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T1m4meco"
ARC-Seal: i=1; a=rsa-sha256; t=1766751905; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jyrtyCz6LXSRx0MALUqOHQd6h0umq4z56dyFIalP565Fh+yFUjWEeko94dsGFryubyxPYPCFrjhnh2kDG/OsAgR5NAvPomXfctjQIgxp5Gw7hlCaDl0AGEFrbmhwDWMs2obdGzZvOGQ1Ik5VrUP5li3Y/4lsGLxQJjNi6vpn2pI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766751905; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uy7jT4aE2iKv7+RWeqRI2KKBXHxYmLdRDJoABD+yo+Y=; 
	b=cGoAdqxCWWjxAvlLmaBJXw0/5CvNclikZWrGAMps2XIYlhW9ZL7C69qvxKmswWGrDQwsPv2KPepOXF1LmVgxPa5JawhMNwWj99fpkR9LSeHlFDQ8MqeQsx60OEfkKKAljMaukK9b0tY5LRFxEWSZsJRFGCpDF8WhtJUngQWfGyQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766751905;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=uy7jT4aE2iKv7+RWeqRI2KKBXHxYmLdRDJoABD+yo+Y=;
	b=T1m4mecoMtM/Jegvhm738PKivxhtjZw/F33LCMahuFdNk/BSxXEvIl8G1R0/yujf
	cJJm/+y8taRGKfSlWRBUNJUHKjUbsjp4SMXHKr/lOdAlWLSbA8LSOieQDm2kcWNE8jy
	bmHZ76sfL+e7xuaGC1MTFUA4UB+51ACXoym2T6Ew=
Received: by mx.zohomail.com with SMTPS id 1766751902581844.8561909973477;
	Fri, 26 Dec 2025 04:25:02 -0800 (PST)
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
Subject: [PATCH v6 09/11] hooks: allow callers to capture output
Date: Fri, 26 Dec 2025 14:23:32 +0200
Message-ID: <20251226122334.16687-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226122334.16687-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
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

