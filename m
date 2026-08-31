Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D584AE8DD
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197156; cv=none; b=MfYO/35YaBrZ0ttFs0PdjThr5i4YQbOGkqQ/9Q7ys3cgYxtifjYqMNC1DAUDrKkRQW81HUT551mBekQWOSpCov8ZS84eZLTBs8iFOb5CtvPVwSffVfJQNa9AF1Plmj2QJqfGKZBIgK4J3sN036OzgBV/cyhyVPU6mURhRV01IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197156; c=relaxed/simple;
	bh=5yPsJbDjkvBpatcpiY1WvC7DLMuSVVUsxWMiCIMPdVE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PeD2qUZ9PU/bm59T3HwisvbeKRVkDa5k2qJilOABhGl8Y9SFS9s0RMS+EqDUfrNDMcaRg3Q/M3t2PMnNGc1sK1RcwTIONeGJQRJNowrWYpPHnPPI4R0NEcWMbtNDGCXN4ZY/NEQnUJO/mUNQSB32Cbw065Jscnns7wPOC2suEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiuBytjk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiuBytjk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5218927884fso52754571cf.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197154; x=1788801954; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1QaWaS+t5AWmhxFtXlMTfrLxRmp34+pMaRnDjwUZWlQ=;
        b=RiuBytjkVTM17TwTti91u+JU1donoiXgQWCpMg7ftpoUdGrr6srSLW0dglDgnthkUA
         x4e+/+DTECk5NwmBmABnggRohtjDkbuEAzj5JYSrKLwWfg5LSdFVhW90099552r3mFPw
         WXtRQ0xJ1tZSMz7UgMzjsZqVeHloRW8AiE0isaA54BOZd1UdK2Myhl9sHP2/zDFJB7ie
         HAeSMZXFtHBk8Wbsiul8iJzYmU/CLJeDzuV47A3xRXYxa0r/cWIw0VJsxy6JzZmYWhCZ
         tb7oyC540kcWfBpcuWT6XKAuZqn98BvpoKOYFZkCVI4HCgzUwTSxfiHeuQkSctDGb1vl
         EGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197154; x=1788801954;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QaWaS+t5AWmhxFtXlMTfrLxRmp34+pMaRnDjwUZWlQ=;
        b=XyQXsSkTPjp7iEJmtWWD0t6JSNLHWuhuMMGOCSjKPvI09JJIffwzGcjr/UzJj31sro
         svbVTO8UPwhPARrjf7hAYVlJq9V+731xtllJwtvC5GYSYv7pHXLmayXnTOitmlJ2CZK0
         GGgBEUlBaXZGfN+8bglqZbs2EZOCSq264j/ROBG6VSvJ800tT/pxv9mbvq2r7CtKC93S
         4Qwv5CftMIlJvR1ib498X5BFFJKq0EW8Gz+cYn2vk5PYQeOQysoiKyc+p7uZOyPY7rAB
         KUHW2Ha8oOKdUrAeKMHt4UEr6JyP6Drewx9Y+Dwer9Qg/DtjWykpzXwleFUX9hTC+0xD
         Supw==
X-Gm-Message-State: AFuF++meSxusYFFLVqDEU9vwrUQwurP27KsmHIK5CLTIrVdaFvZVtG7z
	D0wzTQx21gcF0qOdcnD4WcrpWSC601ZJ1UjchCDtlGStsht9WuAia+s0+/1KEBbO
X-Gm-Gg: AR+sD12NYoqiog04wH5PRBnPlc8bHejOIUk9bOichv3ziLl96kg82J4KgcbX9pIVpYA
	berM3Atylmq13kcKDzEldQ395sWgm+6CkcRrQWN80gs40iqMx7I1Av0kxBuEvgwAvzysbowc8W8
	qxDlwXvXgLWZlXMLKTnm/TzlOks+MJXCaXBOB65BPLTnAW3skMQUEYKbVWl3Bb4oODvsmJfdgdz
	bm6SCy4BHeo98EGts5rNmyYUZ5CJ3CmT/ClAzqAe+LrIsytUOfbS4QhRwkWslp7WTxrxWYyHnrK
	6pAr9FYi53ZPvjuIYMl7lorwD8LZLIHbfoWmfEoYvJzuiZVgMpoDBYFGwfLLa9nezUoyExsLeiG
	bloLT/Fe7Eix/k/aNaDAZRSZfqiD2mkYauV8YH2uq3zvxVoJwvoNPKgjXJ9m+ejKY1zZzdtjQEb
	vCeaE86VV5QTpfaQUi8OkWVI0rYBIrhPh/0U4hAp6+sDjsWAvDLQnPMNVcKbPw2zGysV/47UIfC
	+k=
X-Received: by 2002:a05:622a:260f:b0:530:17b2:5109 with SMTP id d75a77b69052e-53017b251e8mr78848331cf.18.1788197153700;
        Mon, 31 Aug 2026 10:25:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce453458csm88785266d6.44.2026.08.31.10.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:52 -0700 (PDT)
Message-Id: <fa10e8d246ccd7feb11422091b5ed4be3baf2ea5.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:43 +0000
Subject: [PATCH v3 7/7] trace2: remove use of xcalloc()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Remove use of xcalloc() from the trace2 API due to its possible use of
die(), which could lead to recursive die() handlers. This is used in the
trace2 API to track an array of thread contexts when logging multi-
threaded operations.

Instead of killing the process on a failure, we attempt to proceed as
much as possible. We replace the dynamic thread context with a
statically-allocated context that uses the "unknown" thread name to
identify that we are in an error case.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h     |  3 +++
 trace2/tr2_ctr.c | 10 +++++++++-
 trace2/tr2_tls.c | 41 +++++++++++++++++++++++++++++++++++++++--
 trace2/tr2_tls.h |  6 ++++++
 trace2/tr2_tmr.c | 14 ++++++++++++--
 5 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index cff1072397..52a93c67c6 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -17,6 +17,9 @@
 #undef xstrdup
 #define xstrdup(str) BANNED(xstrdup)
 
+#undef xcalloc
+#define xcalloc(nmemb, size) BANNED(xcalloc)
+
 #undef xstrfmt
 #define xstrfmt(...) BANNED(xstrfmt)
 
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 20618a65b2..9920979030 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -55,7 +55,11 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_counter *c = &ctx->counter_block.counter[cid];
+	struct tr2_counter *c;
+
+	if (tr2tls_is_fallback(ctx))
+		return;
+	c = &ctx->counter_block.counter[cid];
 
 	c->value += value;
 
@@ -69,6 +73,8 @@ void tr2_update_final_counters(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_counter_id cid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_counter)
 		return;
 
@@ -90,6 +96,8 @@ void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_counter_id cid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_per_thread_counter)
 		return;
 
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 5e4624d0b3..ace2cd438b 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -14,6 +14,9 @@
 #define TR2_REGION_NESTING_INITIAL_SIZE (100)
 
 static struct tr2tls_thread_ctx *tr2tls_thread_main;
+static struct tr2tls_thread_ctx tr2tls_thread_fallback = {
+	.thread_name = "unknown",
+};
 static uint64_t tr2tls_us_start_process;
 
 static pthread_mutex_t tr2tls_mutex;
@@ -38,16 +41,23 @@ void tr2tls_start_process_clock(void)
 struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 					     uint64_t us_thread_start)
 {
-	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
+	struct tr2tls_thread_ctx *ctx = calloc(1, sizeof(*ctx));
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!ctx)
+		goto fallback;
+
 	/*
 	 * Implicitly "tr2tls_push_self()" to capture the thread's start
 	 * time in array_us_start[0].  For the main thread this gives us the
 	 * application run time.
 	 */
 	ctx->alloc = TR2_REGION_NESTING_INITIAL_SIZE;
-	ctx->array_us_start = (uint64_t *)xcalloc(ctx->alloc, sizeof(uint64_t));
+	ctx->array_us_start = calloc(ctx->alloc, sizeof(uint64_t));
+	if (!ctx->array_us_start) {
+		free(ctx);
+		goto fallback;
+	}
 	ctx->array_us_start[ctx->nr_open_regions++] = us_thread_start;
 
 	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
@@ -63,6 +73,10 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
 	pthread_setspecific(tr2tls_key, ctx);
 
 	return ctx;
+
+fallback:
+	pthread_setspecific(tr2tls_key, &tr2tls_thread_fallback);
+	return &tr2tls_thread_fallback;
 }
 
 struct tr2tls_thread_ctx *tr2tls_get_self(void)
@@ -85,6 +99,11 @@ struct tr2tls_thread_ctx *tr2tls_get_self(void)
 	return ctx;
 }
 
+int tr2tls_is_fallback(const struct tr2tls_thread_ctx *ctx)
+{
+	return ctx == &tr2tls_thread_fallback;
+}
+
 int tr2tls_is_main_thread(void)
 {
 	if (!HAVE_THREADS)
@@ -101,6 +120,9 @@ void tr2tls_unset_self(void)
 
 	pthread_setspecific(tr2tls_key, NULL);
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
@@ -112,6 +134,9 @@ void tr2tls_push_self(uint64_t us_now)
 	uint64_t *new_array;
 	size_t new_alloc;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	if (ctx->nr_skipped_regions) {
 		ctx->nr_skipped_regions++;
 		return;
@@ -143,6 +168,9 @@ void tr2tls_pop_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	if (ctx->nr_skipped_regions) {
 		ctx->nr_skipped_regions--;
 		return;
@@ -158,6 +186,9 @@ void tr2tls_pop_unwind_self(void)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	while (ctx->nr_open_regions > 1)
 		tr2tls_pop_self();
 }
@@ -168,6 +199,8 @@ uint64_t tr2tls_region_elasped_self(uint64_t us)
 	uint64_t us_start;
 
 	ctx = tr2tls_get_self();
+	if (tr2tls_is_fallback(ctx))
+		return 0;
 	if (ctx->nr_skipped_regions)
 		return 0;
 	if (!ctx->nr_open_regions)
@@ -189,6 +222,10 @@ uint64_t tr2tls_absolute_elapsed(uint64_t us)
 static void tr2tls_key_destructor(void *payload)
 {
 	struct tr2tls_thread_ctx *ctx = payload;
+
+	if (tr2tls_is_fallback(ctx))
+		return;
+
 	free((char *)ctx->thread_name);
 	free(ctx->array_us_start);
 	free(ctx);
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index c365017923..4a0969c014 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -54,6 +54,12 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
  */
 struct tr2tls_thread_ctx *tr2tls_get_self(void);
 
+/*
+ * Return true if the context is the non-allocating fallback used after an
+ * allocation failure. Callers must not modify a fallback context.
+ */
+int tr2tls_is_fallback(const struct tr2tls_thread_ctx *ctx);
+
 /*
  * return true if the current thread is the main thread.
  */
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 275091c693..4dfc7afb4e 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -39,8 +39,11 @@ static struct tr2_timer_metadata tr2_timer_metadata[TRACE2_NUMBER_OF_TIMERS] = {
 void tr2_start_timer(enum trace2_timer_id tid)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+	struct tr2_timer *t;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+	t = &ctx->timer_block.timer[tid];
 	t->recursion_count++;
 	if (t->recursion_count > 1)
 		return; /* ignore recursive starts */
@@ -51,10 +54,13 @@ void tr2_start_timer(enum trace2_timer_id tid)
 void tr2_stop_timer(enum trace2_timer_id tid)
 {
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
-	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+	struct tr2_timer *t;
 	uint64_t ns_now;
 	uint64_t ns_interval;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
+	t = &ctx->timer_block.timer[tid];
 	assert(t->recursion_count > 0);
 
 	t->recursion_count--;
@@ -92,6 +98,8 @@ void tr2_update_final_timers(void)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_timer_id tid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_timer)
 		return;
 
@@ -138,6 +146,8 @@ void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
 	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
 	enum trace2_timer_id tid;
 
+	if (tr2tls_is_fallback(ctx))
+		return;
 	if (!ctx->used_any_per_thread_timer)
 		return;
 
-- 
gitgitgadget
