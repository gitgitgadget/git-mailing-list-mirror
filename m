Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435DC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJDQUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJDQUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B910402E3
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5so9255220wms.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=o2ispt3iRKRIfJEw6xvAmp2DiIRviuvQfEr6Qu/yjNE=;
        b=U2ccTE6GyFkgXKbtp7CL1LpzT80/2BkEmulvU2abuRWhR5Y38d9JnBSz2eiCrFM3v+
         iS1dQJAqefgN5MgzXlPnoPLkZ/g1guhtvmsSDYu1NkCj3ZZ4L5i349CUEpkdOZoMNL89
         AUq4WDAklxUZuvE1aCXjho86S92ffQ4Et2xFSj+zfvvM7tfhSsSZZAr1oJgE0zSbCC+w
         e9aVJtbthWYekqXEfX9+WsG1jgWi6yq4xTIv2SILIBBGx5SWmvip3QT0lLglKQqMHIwH
         LZw1R5BRygkt4vg1s8OwR8qEunDNn4wInyIuRgqrawPQ4qhHXH7xbeobnw/EGQMy6IQO
         cAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o2ispt3iRKRIfJEw6xvAmp2DiIRviuvQfEr6Qu/yjNE=;
        b=wyJFwM+7asYQjnSpuyLEl7SErgJkgIo+4vL9IEUh6yvwM2WU7TE7lkXMDCgpNCRqa7
         n+QIUdbcskjQTAGRMuzBm1tkasKu6T76aDW6fkhzBuMLktLfo3KJQYL9QoxFvO7ree9a
         RPI5C6GZ4JGhn0Fka9uh1yXDnqx0AHshtdspTGrTVKubrIfy+ahM8CSjk2SRCVONlVI2
         VT1vFEAssKRAsbt6ZGyDae/MRlB3wsGWbl0u+kwg60ZSlvTIJhExetpOcqbgnoAHaWgQ
         m+3BrpBxqrJAS7KCUoP3Uk8nhN/KL4KAiEheaNrfwV6eY7IAzAzql0qhtucPAhgErYwN
         ez6A==
X-Gm-Message-State: ACrzQf3/NRJzZ7Z/DNs/J+5JDhuxUst2RttRlBtwvk7l96pe4U1YzomI
        Z3OMxWzoXhXzpACH96pyptlT8yftAdU=
X-Google-Smtp-Source: AMsMyM7VKH6kidoJR2/WmXD2c3f+VNVdQ7CUH08XVAdUYwC9Sp3XzVhf8eZ4Ol1rqiba7V+rPVjuHA==
X-Received: by 2002:a05:600c:3d8e:b0:3b4:a61c:52cc with SMTP id bi14-20020a05600c3d8e00b003b4a61c52ccmr403946wmb.7.1664900413678;
        Tue, 04 Oct 2022 09:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600011c700b0021e51c039c5sm7791346wrx.80.2022.10.04.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:13 -0700 (PDT)
Message-Id: <6492b6d2b989e08bb539fff3ffe5bdf50fa0a195.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:04 +0000
Subject: [PATCH 6/9] trace2: convert ctx.thread_name to flex array
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
to a "flex array" at the end of the context structure.

The `thread_name` field is a constant string that is constructed when
the context is created.  Using a (non-const) `strbuf` structure for it
caused some confusion in the past because it implied that someone
could rename a thread after it was created.  That usage was not
intended.  Changing it to a "flex array" will hopefully make the
intent more clear.

Also, move the maximum thread_name truncation to tr2_tgt_perf.c
because it is the only target that needs to worry about output column
alignment.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  |  8 ++++++--
 trace2/tr2_tls.c       | 25 +++++++++++++------------
 trace2/tr2_tls.h       |  9 +--------
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 37a3163be12..52f9356c695 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -90,7 +90,7 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 
 	jw_object_string(jw, "event", event_name);
 	jw_object_string(jw, "sid", tr2_sid_get());
-	jw_object_string(jw, "thread", ctx->thread_name.buf);
+	jw_object_string(jw, "thread", ctx->thread_name);
 
 	/*
 	 * In brief mode, only emit <time> on these 2 event types.
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 8cb792488c8..fdeb3292d3a 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -25,6 +25,7 @@ static int tr2env_perf_be_brief;
 
 #define TR2FMT_PERF_FL_WIDTH (28)
 #define TR2FMT_PERF_MAX_EVENT_NAME (12)
+#define TR2FMT_PERF_MAX_THREAD_NAME (24)
 #define TR2FMT_PERF_REPO_WIDTH (3)
 #define TR2FMT_PERF_CATEGORY_WIDTH (12)
 
@@ -107,8 +108,11 @@ static void perf_fmt_prepare(const char *event_name,
 	}
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
-	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
+	strbuf_addf(buf, "%-*.*s | %-*s | ",
+		    TR2FMT_PERF_MAX_THREAD_NAME,
+		    TR2FMT_PERF_MAX_THREAD_NAME,
+		    ctx->thread_name,
+		    TR2FMT_PERF_MAX_EVENT_NAME,
 		    event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 39b41fd2487..89437e773f6 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -34,7 +34,18 @@ void tr2tls_start_process_clock(void)
 struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
 					     uint64_t us_thread_start)
 {
-	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct tr2tls_thread_ctx *ctx;
+	struct strbuf buf_name = STRBUF_INIT;
+	int thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
+
+	if (thread_id)
+		strbuf_addf(&buf_name, "th%02d:", thread_id);
+	strbuf_addstr(&buf_name, name_hint);
+
+	FLEX_ALLOC_MEM(ctx, thread_name, buf_name.buf, buf_name.len);
+	strbuf_release(&buf_name);
+
+	ctx->thread_id = thread_id;
 
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
@@ -45,15 +56,6 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *name_hint,
 	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
-	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
-
-	strbuf_init(&ctx->thread_name, 0);
-	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, name_hint);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
-
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
@@ -95,7 +97,6 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +114,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index f1ee58305d6..be0bc73d08f 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -9,17 +9,12 @@
  * There is NO relation to "transport layer security".
  */
 
-/*
- * Arbitry limit for thread names for column alignment.
- */
-#define TR2_MAX_THREAD_NAME (24)
-
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
+	char thread_name[FLEX_ARRAY];
 };
 
 /*
@@ -32,8 +27,6 @@ struct tr2tls_thread_ctx {
  * upon the name of the thread-proc function).  For example:
  *     { .thread_id=10, .thread_name="th10fsm-listen" }
  * This helps to identify and distinguish messages from concurrent threads.
- * The ctx.thread_name field is truncated if necessary to help with column
- * alignment in printf-style messages.
  *
  * In this and all following functions the term "self" refers to the
  * current thread.
-- 
gitgitgadget

