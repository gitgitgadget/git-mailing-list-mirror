Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B9C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJTS2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTS2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239171F524D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bp11so367377wrb.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlDBK4pwWSVqQNnopPLOKHrioN8Ea6fx+W8b+xkuAtI=;
        b=NNF0JkNySyzVzFS3GvhzwZ7K5cgCgOqsOzXot6IE+pWW3xrQFwD2YZyaeW+S5Hs3vW
         QeSRRWGF2rZ/HypqdlYCWC/A9HHj64LAu2XxKdud1qr2LyXCvfM7remQEIW/VQR+28xA
         zV4bV0B25zxuk/3ZL8ekCUmZ8W4zIYcpIQzJVruqScKQ1G7XruzrqPub973rpA9p+6M1
         htpaYDDnMyqex5TVPPlX4BKzGXF1gaMhw8JIVM7amghfIQs9CdcMngbeoKqzGlPpJne6
         kVz+lY+jN7jnw6LXdF/Yqmtj+eHGrt4cYLwhMIg8M1uR9ted4RCMnP1ihZLCQF35n1gX
         /h/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlDBK4pwWSVqQNnopPLOKHrioN8Ea6fx+W8b+xkuAtI=;
        b=j74k9pgUD/eGB5vWWuoabdFm7jBZ+TasKyB8yOLVoozx/a9IqezAMvriqfhA8jwrNI
         sYQrKXjspgA0TsqxTI5kD12zQZxIb6y41eOqSXTCzeE8PsplNi7/9RXMdpVQzkywQPYW
         9XPAzoGLMlldObguvLbBpUYghNhhljyg5+xNEzLNhFB9+OXRSoTqwarXwkv8ClJvheFL
         C4qdEx3DSzNHRGaIHGFCJ7nzzW+ooLl+K5BWzapbKvl3MW79qu2Tn52jrf/OfaiolbLj
         IqZNCVi3/a7iJlGZYRf5ntyo2qjuq2I87OmsUn5kF1U0+z23xt1/MAMM8aoPjHD5PxY8
         lq3g==
X-Gm-Message-State: ACrzQf1+vj+Tpzw7nHee1Bf7Ev785hziABwhhL5SgLsBz2zXhIu4Xi8c
        eLIo0B8cCYoNJv0qHgUUd0A1+aflPx8=
X-Google-Smtp-Source: AMsMyM4BQ96PLuKhO5dCiJ7lpGqW0ERgmoY6dRVuTIShF/pCkhktJW56L3oTYImxvrMLYNwXPTjmLg==
X-Received: by 2002:a05:6000:1d94:b0:22c:c4d1:3622 with SMTP id bk20-20020a0560001d9400b0022cc4d13622mr9450436wrb.63.1666290491265;
        Thu, 20 Oct 2022 11:28:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c468900b003c452678025sm653331wmo.4.2022.10.20.11.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:10 -0700 (PDT)
Message-Id: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:01 +0000
Subject: [PATCH v3 0/8] Trace2 timers and counters and some cleanup
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

Here is version 2 of this series to add timers and counters to Trace2.

Changes since V1:

 * I dropped the commits concerning compiler errors in Clang 11.0.0 on
   MacOS. I've sent them to the mailing list in a separate series, since
   they had nothing to do with the main topic of this series.

 * I moved the documentation changes earlier in the series to get it out of
   the way (and eliminate the need to update it later commits).

 * After a long conversation on the mailing list, I redid the two
   thread-name commits to simplify and hopefully eliminate the remaining
   misunderstandings and/or short-comings of my previous attempt and
   explanations. We now use a "const char *" for the field in the thread-ctx
   that we format and detach from a strbuf during thread-start. The goal
   here is to move away from a modifyable strbuf in the thread-ctx itself
   (to avoid giving the appearance that a caller could modify the
   thread-name at some point, when that was not intended).

The last 2 commits add the stopwatch timers and the global counters and are
unchanged from the previous version.

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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1373%2Fjeffhostetler%2Ftrace2-stopwatch-v4-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1373/jeffhostetler/trace2-stopwatch-v4-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1373

Range-diff vs v2:

 1:  6e7e4f3187e = 1:  6e7e4f3187e trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
 2:  9dee7a75903 = 2:  9dee7a75903 tr2tls: clarify TLS terminology
 3:  804dab9e1a7 = 3:  804dab9e1a7 api-trace2.txt: elminate section describing the public trace2 API
 4:  637b422b860 ! 4:  9adf9cee1a9 trace2: rename the thread_name argument to trace2_thread_start
     @@ trace2/tr2_tls.c: struct tr2tls_thread_ctx *tr2tls_create_self(const char *threa
      
       ## trace2/tr2_tls.h ##
      @@ trace2/tr2_tls.h: struct tr2tls_thread_ctx {
     - /*
     -  * Create thread-local storage for the current thread.
     -  *
     -- * We assume the first thread is "main".  Other threads are given
     -- * non-zero thread-ids to help distinguish messages from concurrent
     -- * threads.
     -- *
     -- * Truncate the thread name if necessary to help with column alignment
     -- * in printf-style messages.
     -+ * The first thread in the process will have:
     -+ *     { .thread_id=0, .thread_name="main" }
     -+ * Subsequent threads are given a non-zero thread_id and a thread_name
     -+ * constructed from the id and a thread base name (which is usually just
     -+ * the name of the thread-proc function).  For example:
     -+ *     { .thread_id=10, .thread_name="th10fsm-listen" }
     -+ * This helps to identify and distinguish messages from concurrent threads.
     -+ * The ctx.thread_name field is truncated if necessary to help with column
     -+ * alignment in printf-style messages.
     -  *
        * In this and all following functions the term "self" refers to the
        * current thread.
        */
 -:  ----------- > 5:  8cb206b7632 trace2: improve thread-name documentation in the thread-context
 5:  4bf78e356e2 = 6:  8a89e1aa238 trace2: convert ctx.thread_name from strbuf to pointer
 6:  dd6d8e2841b ! 7:  8e701109976 trace2: add stopwatch timers
     @@ trace2/tr2_tgt.h
       struct json_writer;
      +struct tr2_timer_metadata;
      +struct tr2_timer;
     ++
     ++#define NS_PER_SEC_D ((double)1000*1000*1000)
       
       /*
        * Function prototypes for a TRACE2 "target" vtable.
     @@ trace2/tr2_tgt_event.c: static void fn_data_json_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct json_writer jw = JSON_WRITER_INIT;
     -+	double t_total = ((double)timer->total_ns) / 1000000000.0;
     -+	double t_min = ((double)timer->min_ns) / 1000000000.0;
     -+	double t_max = ((double)timer->max_ns) / 1000000000.0;
     ++	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     ++	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     ++	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
      +
      +	jw_object_begin(&jw, 0);
      +	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
     @@ trace2/tr2_tgt_normal.c: static void fn_printf_va_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct strbuf buf_payload = STRBUF_INIT;
     -+	double t_total = ((double)timer->total_ns) / 1000000000.0;
     -+	double t_min = ((double)timer->min_ns) / 1000000000.0;
     -+	double t_max = ((double)timer->max_ns) / 1000000000.0;
     ++	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     ++	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     ++	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
      +
      +	strbuf_addf(&buf_payload, ("%s %s/%s"
      +				   " intervals:%"PRIu64
     @@ trace2/tr2_tgt_perf.c: static void fn_printf_va_fl(const char *file, int line,
      +{
      +	const char *event_name = is_final_data ? "timer" : "th_timer";
      +	struct strbuf buf_payload = STRBUF_INIT;
     -+	double t_total = ((double)timer->total_ns) / 1000000000.0;
     -+	double t_min = ((double)timer->min_ns) / 1000000000.0;
     -+	double t_max = ((double)timer->max_ns) / 1000000000.0;
     ++	double t_total = ((double)timer->total_ns) / NS_PER_SEC_D;
     ++	double t_min = ((double)timer->min_ns) / NS_PER_SEC_D;
     ++	double t_max = ((double)timer->max_ns) / NS_PER_SEC_D;
      +
      +	strbuf_addf(&buf_payload, ("name:%s"
      +				   " intervals:%"PRIu64
 7:  cf012fcde37 ! 8:  5cd8bdde884 trace2: add global counter mechanism
     @@ trace2/tr2_tgt.h: struct repository;
      +struct tr2_counter_metadata;
      +struct tr2_counter;
       
     - /*
     -  * Function prototypes for a TRACE2 "target" vtable.
     + #define NS_PER_SEC_D ((double)1000*1000*1000)
     + 
      @@ trace2/tr2_tgt.h: typedef void(tr2_tgt_evt_timer_t)(const struct tr2_timer_metadata *meta,
       				  const struct tr2_timer *timer,
       				  int is_final_data);

-- 
gitgitgadget
