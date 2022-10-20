Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262E8C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJTS2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJTS2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:20 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784351F5263
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so478987wrr.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49A0L1wMbmU0RvsqsmDPtIsptTiM40AWpEgBd9ZjT4Y=;
        b=lI5jqdCSD0SZ0skzA3+nC/K9c1iq49so+jfUKK//ECEjne4+Yc2xrxZp27hZVjDiET
         a8eKpgAwUkL1dsTTRtUFWHxdqIfsNMXFW9ReSKJwoNVh8OFBuX2E1Eo8Sm9revjJB4ml
         T+ludZqp5uk1Ybvplm3Zo6beaCFpDD6Cd3JZ/IBIreB9ASRMCCWJv/6QlVFz+8MgLnZV
         uDXBAAfN/hzamM+Ts1trVYYPHQCw1dwIEqRAk8tv68wcFrVrQe7e5G51en/HTEJv8eC6
         bz/HUgokF+rvfupgPQP0Brz09FGgBsgN7Rnd1OBBuNAlNcGjlaXbLhvXFi0S17RQsrzo
         YUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49A0L1wMbmU0RvsqsmDPtIsptTiM40AWpEgBd9ZjT4Y=;
        b=t1ICD02ZCjrIJNOMfcqC52HayB4brdePUTEENZTqf0K2BR2dEvTh3uNdlE4wT8BW0i
         TPQRG47tVg332/RVpFYf9gSItalAiXng3cLDG1z3RmPR6Tr7Kq3h2hN0F/ud98P5kQgE
         55xvVwatF4XO4aQnH8bPKcWIcGrAuUPynliS9f7uF3MG3/85ifDQ6kp+2e+IaRP6Mzr3
         Mi0iaMm8TXIULMUDhd6xWzRERcprvz90oqgF8qO6BHY4Tu5+w/Ny4rBD8h/IGpVEhMwM
         OGksdGwvkbd4Fy0U9tqpmi/AmcRiBdG2vYm4s0QouzUjaahQ/uLkH3AbClpV3PZLQFuR
         7Bag==
X-Gm-Message-State: ACrzQf0oDr90gBBXHEQMp3k/mtIK8UR+8hQUIYVePMxQPF9wlL4zyKKh
        BcFXSv9KPpsn6yx8SOyIfl7E0UWN4k4=
X-Google-Smtp-Source: AMsMyM5oMDLEiqWshullOADthCszy4CUufJA3AxAyIwJSiZVir/ywMWggNOu3BPtdc2vJJY/rlDiBA==
X-Received: by 2002:adf:d228:0:b0:22e:488d:758f with SMTP id k8-20020adfd228000000b0022e488d758fmr9236394wrh.445.1666290496592;
        Thu, 20 Oct 2022 11:28:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020adfedc1000000b00228daaa84aesm17220295wro.25.2022.10.20.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:16 -0700 (PDT)
Message-Id: <8a89e1aa238bff874f3fa9a414781e4abc03c526.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:07 +0000
Subject: [PATCH v3 6/8] trace2: convert ctx.thread_name from strbuf to pointer
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Convert the `tr2tls_thread_ctx.thread_name` field from a `strbuf`
to a "const char*" pointer.

The `thread_name` field is a constant string that is constructed when
the context is created.  Using a (non-const) `strbuf` structure for it
caused some confusion in the past because it implied that someone
could rename a thread after it was created.  That usage was not
intended.  Change it to a const pointer to make the intent more clear.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_event.c |  2 +-
 trace2/tr2_tgt_perf.c  |  2 +-
 trace2/tr2_tls.c       | 16 +++++++++-------
 trace2/tr2_tls.h       |  2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

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
index 8cb792488c8..59ca58f862d 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -108,7 +108,7 @@ static void perf_fmt_prepare(const char *event_name,
 
 	strbuf_addf(buf, "d%d | ", tr2_sid_depth());
 	strbuf_addf(buf, "%-*s | %-*s | ", TR2_MAX_THREAD_NAME,
-		    ctx->thread_name.buf, TR2FMT_PERF_MAX_EVENT_NAME,
+		    ctx->thread_name, TR2FMT_PERF_MAX_EVENT_NAME,
 		    event_name);
 
 	len = buf->len + TR2FMT_PERF_REPO_WIDTH;
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 4f7c516ecb6..3a67532aae4 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start)
 {
 	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct strbuf buf = STRBUF_INIT;
 
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
@@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
 
-	strbuf_init(&ctx->thread_name, 0);
+	strbuf_init(&buf, 0);
 	if (ctx->thread_id)
-		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
-	strbuf_addstr(&ctx->thread_name, thread_base_name);
-	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
-		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
+		strbuf_addf(&buf, "th%02d:", ctx->thread_id);
+	strbuf_addstr(&buf, thread_base_name);
+	if (buf.len > TR2_MAX_THREAD_NAME)
+		strbuf_setlen(&buf, TR2_MAX_THREAD_NAME);
+	ctx->thread_name = strbuf_detach(&buf, NULL);
 
 	pthread_setspecific(tr2tls_key, ctx);
 
@@ -95,7 +97,7 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
-	strbuf_release(&ctx->thread_name);
+	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
 }
@@ -113,7 +115,7 @@ void tr2tls_pop_self(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
 	if (!ctx->nr_open_regions)
-		BUG("no open regions in thread '%s'", ctx->thread_name.buf);
+		BUG("no open regions in thread '%s'", ctx->thread_name);
 
 	ctx->nr_open_regions--;
 }
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 7d1f03a2ea6..e17cc462f87 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -15,7 +15,7 @@
 #define TR2_MAX_THREAD_NAME (24)
 
 struct tr2tls_thread_ctx {
-	struct strbuf thread_name;
+	const char *thread_name;
 	uint64_t *array_us_start;
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
-- 
gitgitgadget

