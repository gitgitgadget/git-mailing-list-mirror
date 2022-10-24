Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98715FA3743
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiJXUpa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiJXUoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:44:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AAA2B4179
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:51:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so10523765wme.5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgvP+EfEeBEpK52rgweCQ966i9jJvLPWYqTsCyOBurQ=;
        b=GnnsIWHGgNHS/kAWUuhCVMXENvM0SRKJwjUi8gf7U/sM9p2yISbBaz9nUkzfywAH/f
         yFz7OLBDhpsim9cbuJkDsPpbn+uvNEQg9H9NCeJgcOmHzygD4GA56dY+Nxj67/bD1rbQ
         NiuCg44Zr1a7PDJIU0F+GNWEm/dxg9kvVDQ75tIEyezmxwi6tUA3FCicUVO4OTCl3J7M
         xO8n/NYaGytfQ5oVZakSoKW9NWfsClaamGAZw+1lMv3+lqkjHeCtQfYEo0Yvsa9lny/y
         3nQc+go1nQzBUsZZZ/zzIltmS5Yb5mtLV/fDTrC6Rzx5ojbU6k3x3fDNqNneNMNj5aVd
         pjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgvP+EfEeBEpK52rgweCQ966i9jJvLPWYqTsCyOBurQ=;
        b=H9KGCkGIJ5mtGui4yAQDkWgatVDur18+TDmbTK2bS7ASbHzpen0L/ibD6LNu9SipP2
         4Js8xWmpuqtG3I2dd1RsMNS7Z93FRsqscW45d+gWo2GWgPDtM3vsT0P0DqqAu0Imxs1a
         1QujNUnpEdWYpngZ/eMcghk5RthsWcfZ4KZp4AkXG9fONx8837pgZN19uBP9Y4HVsD9r
         dnQcZPouxVD+Jx0Zetl/7KlSEOJmqudJS7hs1nrywFuGwH3rOw9tWsWGpJRVUpAzAQFx
         986pvu7wpL0XT384boHgkuIE4u/SMvBPEaQRNhkkRwjhUrdEu2ld22tfRMl+Ytbsrl/W
         TlYQ==
X-Gm-Message-State: ACrzQf0dKEixea15QXge/0i4l6nwhrtNeYHAuiMaWpiggEdwmP3zsE3B
        TdTvRBJ09dztlheU+vKUPvv/ufnzmiY=
X-Google-Smtp-Source: AMsMyM4XCxY2G/2/Z3UVSF+NcxrhplyGN1Bp32lOH0mM22zz3srtOZtTdTUTmkojL9fD4a3JBdOzBw==
X-Received: by 2002:a05:600c:310f:b0:3c6:ff0a:c41 with SMTP id g15-20020a05600c310f00b003c6ff0a0c41mr21717065wmo.91.1666618870002;
        Mon, 24 Oct 2022 06:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a7bcb02000000b003a531c7aa66sm1389wmj.1.2022.10.24.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:41:09 -0700 (PDT)
Message-Id: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 13:40:59 +0000
Subject: [PATCH v4 0/8] Trace2 timers and counters and some cleanup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is version 4 of this series to add timers and counters to Trace2.

Changes since V3:

 * Fixed typo in the new thread-name documentation.
 * Use a simpler NS_TO_SEC() macro for reporting the timer values.

Jeff Hostetler (8):
  trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
  tr2tls: clarify TLS terminology
  api-trace2.txt: elminate section describing the public trace2 API
  trace2: rename the thread_name argument to trace2_thread_start
  trace2: improve thread-name documentation in the thread-context
  trace2: convert ctx.thread_name from strbuf to pointer
  trace2: add stopwatch timers
  trace2: add global counter mechanism

 Documentation/technical/api-trace2.txt | 190 +++++++++++++++++--------
 Makefile                               |   2 +
 t/helper/test-trace2.c                 | 187 ++++++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  95 +++++++++++++
 t/t0211/scrub_perf.perl                |   6 +
 trace2.c                               | 121 +++++++++++++++-
 trace2.h                               | 101 +++++++++++--
 trace2/tr2_ctr.c                       | 101 +++++++++++++
 trace2/tr2_ctr.h                       | 104 ++++++++++++++
 trace2/tr2_tgt.h                       |  16 +++
 trace2/tr2_tgt_event.c                 |  47 +++++-
 trace2/tr2_tgt_normal.c                |  39 +++++
 trace2/tr2_tgt_perf.c                  |  43 +++++-
 trace2/tr2_tls.c                       |  34 +++--
 trace2/tr2_tls.h                       |  55 ++++---
 trace2/tr2_tmr.c                       | 182 +++++++++++++++++++++++
 trace2/tr2_tmr.h                       | 140 ++++++++++++++++++
 17 files changed, 1361 insertions(+), 102 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h


base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1373%2Fjeffhostetler%2Ftrace2-stopwatch-v4-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1373/jeffhostetler/trace2-stopwatch-v4-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1373

Range-diff vs v3:

 1:  6e7e4f3187e = 1:  6e7e4f3187e trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
 2:  9dee7a75903 = 2:  9dee7a75903 tr2tls: clarify TLS terminology
 3:  804dab9e1a7 = 3:  804dab9e1a7 api-trace2.txt: elminate section describing the public trace2 API
 4:  9adf9cee1a9 = 4:  9adf9cee1a9 trace2: rename the thread_name argument to trace2_thread_start
 5:  8cb206b7632 ! 5:  acfae17548c trace2: improve thread-name documentation in the thread-context
     @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
      + * Subsequent threads are given a non-zero thread_id and a thread_name
      + * constructed from the id and a thread base name (which is usually just
      + * the name of the thread-proc function).  For example:
     -+ *     { .thread_id=10, .thread_name="th10fsm-listen" }
     ++ *     { .thread_id=10, .thread_name="th10:fsm-listen" }
      + * This helps to identify and distinguish messages from concurrent threads.
      + * The ctx.thread_name field is truncated if necessary to help with column
      + * alignment in printf-style messages.
 6:  8a89e1aa238 = 6:  79c6406d492 trace2: convert ctx.thread_name from strbuf to pointer
 7:  8e701109976 ! 7:  a10c1bd96bb trace2: add stopwatch timers
     @@ trace2/tr2_tgt.h
      +struct tr2_timer_metadata;
      +struct tr2_timer;
      +
     -+#define NS_PER_SEC_D ((double)1000*1000*1000)
     ++#define NS_TO_SEC(ns) ((double)(ns) / 1.0e9)
       
       /*
        * Function prototypes for a TRACE2 "target" vtable.
     @@ trace2/tr2_tgt_event.c: static void fn_data_json_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct json_writer jw = JSON_WRITER_INIT;
     -+	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     -+	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     -+	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
     ++	double t_total = NS_TO_SEC(timer->total_ns);
     ++	double t_min = NS_TO_SEC(timer->min_ns);
     ++	double t_max = NS_TO_SEC(timer->max_ns);
      +
      +	jw_object_begin(&jw, 0);
      +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
     @@ trace2/tr2_tgt_normal.c: static void fn_printf_va_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct strbuf buf_payload = STRBUF_INIT;
     -+	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     -+	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     -+	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
     ++	double t_total = NS_TO_SEC(timer->total_ns);
     ++	double t_min = NS_TO_SEC(timer->min_ns);
     ++	double t_max = NS_TO_SEC(timer->max_ns);
      +
      +	strbuf_addf(&buf_payload, ("%s %s/%s"
      +				   " intervals:%"PRIu64
     @@ trace2/tr2_tgt_perf.c: static void fn_printf_va_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct strbuf buf_payload = STRBUF_INIT;
     -+	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     -+	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     -+	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
     ++	double t_total = NS_TO_SEC(timer->total_ns);
     ++	double t_min = NS_TO_SEC(timer->min_ns);
     ++	double t_max = NS_TO_SEC(timer->max_ns);
      +
      +	strbuf_addf(&buf_payload, ("name:%s"
      +				   " intervals:%"PRIu64
 8:  5cd8bdde884 ! 8:  b359a49cec9 trace2: add global counter mechanism
     @@ trace2/tr2_tgt.h: struct repository;
      +struct tr2_counter_metadata;
      +struct tr2_counter;
       
     - #define NS_PER_SEC_D ((double)1000*1000*1000)
     + #define NS_TO_SEC(ns) ((double)(ns) / 1.0e9)
       
      @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_timer_t)(const struct tr2_timer_metadata *meta,
       				  const struct tr2_timer *timer,

-- 
gitgitgadget
