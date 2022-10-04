Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA2C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJDQUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJDQU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7364686E
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j16so10187672wrh.5
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=GLmyH8id1WFlky1uyi0qWN6Mb88lavXxjAVrxE7tsdw=;
        b=fpvl24c2M0cUZgPO4RqOMa0XzTbLotIQXcSp4UVrHER50VxwblH81c/+rKSHQa0x9L
         ckajtk2UV4+80YvUmSo5SAb6U2NRcLCKqbgDBN0bejTBV0L0UX0EzPfUue8pRK7s/CQY
         2AOKTtpf7vLl8V8YxpeRdAf1NpQcf13qG7dxTfSNxpwfHZIeTBPO+YwV8oJ6Mu7pVm8i
         HQi0cR3r8keQUWkKasDAQlz0mMgQeGipknMUdc4LnrpDj92Ofenp62qHrwSLFPYWZq/q
         NAD+TYzTUlnsJy4RdbeT8NoSRtP642w0TSSp1k4wApyvp17Dg2CYiOZFqK2xbjlXEB84
         m5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GLmyH8id1WFlky1uyi0qWN6Mb88lavXxjAVrxE7tsdw=;
        b=cO1NVZQRpC2ZAYCofnDFSUcMy9nq6rgMcZ3Us3gpWck7p4NckcTOHO/OYkr3kjaxw/
         cQpXS8Pl1H6k+qK2ge57y0q0iGdHhMZyHmjm6gZgH3HAf53XtaV6WUGaV+ot5q/AEJ/w
         3kpLWvIeY9y+iVvxpurcM2wy39tMN23/8gDV5z0ycToeGo8h4UHK7DoLBpZ18cYmJMPW
         LMypC2ATqORem9bGlnrIAljdtC8EZS7qV96sFwYViqZ4AoV9ELxyS/dhZJmIlVUI+Quv
         wsuAL/3aIrrCtZqM49tzRilc3C4z2lAAw4VAjmJAqLEg0Gm3XfuMrSmKPIILKqGig1zC
         iegQ==
X-Gm-Message-State: ACrzQf2SGaGcndIMTE37Pq6N0H0u2TElMHAYOtqfyWkS7LoYA0nVguS4
        d9o3kTt8Cpo5Lm6amUvEMC9tN8zrMsA=
X-Google-Smtp-Source: AMsMyM7HSWAIbWSZCgn8Uq4ThtPKAaPd0ZDYeXOWU2SO9busDZwFhn88s9N9oLRt+4DliFeLn/RKdw==
X-Received: by 2002:a5d:4b11:0:b0:22e:3af9:c754 with SMTP id v17-20020a5d4b11000000b0022e3af9c754mr7003493wrq.206.1664900415920;
        Tue, 04 Oct 2022 09:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c63-20020a1c3542000000b003a6a3595edasm15246924wma.27.2022.10.04.09.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:15 -0700 (PDT)
Message-Id: <2bf7cb1f8d01ed3fad43cd62d341a0c9b33b92bd.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:07 +0000
Subject: [PATCH 9/9] trace2: add global counter mechanism
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

Add global counters mechanism to Trace2.

The Trace2 counters mechanism adds the ability to create a set of
global counter variables and an API to increment them efficiently.
Counters can optionally report per-thread usage in addition to the sum
across all threads.

Counter events are emitted to the Trace2 logs when a thread exits and
at process exit.

Counters are an alternative to `data` and `data_json` events.

Counters are useful when you want to measure something across the life
of the process, when you don't want per-measurement events for
performance reasons, when the data does not fit conveniently within a
region, or when your control flow does not easily let you write the
final total.  For example, you might use this to report the number of
calls to unzip() or the number of de-delta steps during a checkout.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  31 ++++++++
 Makefile                               |   1 +
 t/helper/test-trace2.c                 |  89 +++++++++++++++++++++
 t/t0211-trace2-perf.sh                 |  46 +++++++++++
 trace2.c                               |  52 +++++++++++--
 trace2.h                               |  37 +++++++++
 trace2/tr2_ctr.c                       | 101 ++++++++++++++++++++++++
 trace2/tr2_ctr.h                       | 104 +++++++++++++++++++++++++
 trace2/tr2_tgt.h                       |   7 ++
 trace2/tr2_tgt_event.c                 |  19 +++++
 trace2/tr2_tgt_normal.c                |  16 ++++
 trace2/tr2_tgt_perf.c                  |  17 ++++
 trace2/tr2_tls.h                       |   4 +
 13 files changed, 517 insertions(+), 7 deletions(-)
 create mode 100644 trace2/tr2_ctr.c
 create mode 100644 trace2/tr2_ctr.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 75ce6f45603..de5fc250595 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -805,6 +805,37 @@ The "value" field may be an integer or a string.
 }
 ------------
 
+`"th_counter"`::
+	This event logs the value of a counter variable in a thread.
+	This event is generated when a thread exits for counters that
+	requested per-thread events.
++
+------------
+{
+	"event":"th_counter",
+	...
+	"category":"my_category",
+	"name":"my_counter",
+	"count":23
+}
+------------
+
+`"counter"`::
+	This event logs the value of a counter variable across all threads.
+	This event is generated when the process exits.  The total value
+	reported here is the sum across all threads.
++
+------------
+{
+	"event":"counter",
+	...
+	"category":"my_category",
+	"name":"my_counter",
+	"count":23
+}
+------------
+
+
 == Example Trace2 API Usage
 
 Here is a hypothetical usage of the Trace2 API showing the intended
diff --git a/Makefile b/Makefile
index 820649bf62a..29ab417ca3a 100644
--- a/Makefile
+++ b/Makefile
@@ -1094,6 +1094,7 @@ LIB_OBJS += trace.o
 LIB_OBJS += trace2.o
 LIB_OBJS += trace2/tr2_cfg.o
 LIB_OBJS += trace2/tr2_cmd_name.o
+LIB_OBJS += trace2/tr2_ctr.o
 LIB_OBJS += trace2/tr2_dst.o
 LIB_OBJS += trace2/tr2_sid.o
 LIB_OBJS += trace2/tr2_sysenv.o
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f951b9e97d7..1b092c60714 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -323,6 +323,92 @@ static int ut_101timer(int argc, const char **argv)
 	return 0;
 }
 
+/*
+ * Single-threaded counter test.  Add several values to the TEST1 counter.
+ * The test script can verify that the final sum is reported in the "counter"
+ * event.
+ */
+static int ut_200counter(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <v1> [<v2> [...]]";
+	int value;
+	int k;
+
+	if (argc < 1)
+		die("%s", usage_error);
+
+	for (k = 0; k < argc; k++) {
+		if (get_i(&value, argv[k]))
+			die("invalid value[%s] -- %s",
+			    argv[k], usage_error);
+		trace2_counter_add(TRACE2_COUNTER_ID_TEST1, value);
+	}
+
+	return 0;
+}
+
+/*
+ * Multi-threaded counter test.  Create seveal threads that each increment
+ * the TEST2 global counter.  The test script can verify that an individual
+ * "th_counter" event is generated with a partial sum for each thread and
+ * that a final aggregate "counter" event is generated.
+ */
+
+struct ut_201_data {
+	int v1;
+	int v2;
+};
+
+static void *ut_201counter_thread_proc(void *_ut_201_data)
+{
+	struct ut_201_data *data = _ut_201_data;
+
+	trace2_thread_start("ut_201");
+
+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, data->v1);
+	trace2_counter_add(TRACE2_COUNTER_ID_TEST2, data->v2);
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+static int ut_201counter(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <v1> <v2> <threads>";
+
+	struct ut_201_data data = { 0, 0 };
+	int nr_threads = 0;
+	int k;
+	pthread_t *pids = NULL;
+
+	if (argc != 3)
+		die("%s", usage_error);
+	if (get_i(&data.v1, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&data.v2, argv[1]))
+		die("%s", usage_error);
+	if (get_i(&nr_threads, argv[2]))
+		die("%s", usage_error);
+
+	CALLOC_ARRAY(pids, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_create(&pids[k], NULL, ut_201counter_thread_proc, &data))
+			die("failed to create thread[%d]", k);
+	}
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_join(pids[k], NULL))
+			die("failed to join thread[%d]", k);
+	}
+
+	free(pids);
+
+	return 0;
+}
+
 /*
  * Usage:
  *     test-tool trace2 <ut_name_1> <ut_usage_1>
@@ -346,6 +432,9 @@ static struct unit_test ut_table[] = {
 
 	{ ut_100timer,    "100timer",  "<count> <ms_delay>" },
 	{ ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
+
+	{ ut_200counter,  "200counter", "<v1> [<v2> [<v3> [...]]]" },
+	{ ut_201counter,  "201counter", "<v1> <v2> <threads>" },
 };
 /* clang-format on */
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 5c28424e657..0b3436e8cac 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -222,4 +222,50 @@ test_expect_success 'stopwatch timer test/test2' '
 	have_timer_event "main" "timer" "test" "test2" 15 actual
 '
 
+# Exercise the global counters and confirm that we get the expected values.
+#
+# The counter "test/test1" should only emit a global summary "counter" event.
+# The counter "test/test2" could emit per-thread "th_counter" events and a
+# global summary "counter" event.
+
+have_counter_event () {
+	thread=$1 event=$2 category=$3 name=$4 value=$5 file=$6 &&
+
+	pattern="d0|${thread}|${event}||||${category}|name:${name} value:${value}" &&
+
+	grep "${patern}" ${file}
+}
+
+test_expect_success 'global counter test/test1' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+
+	# Use the counter "test1" and add n integers.
+	test-tool trace2 200counter 1 2 3 4 5 &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	have_counter_event "main" "counter" "test" "test1" 15 actual
+'
+
+test_expect_success 'global counter test/test2' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+
+	# Add 2 integers to the counter "test2" in each of 3 threads.
+	test-tool trace2 201counter 7 13 3 &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	# So we should have 3 per-thread events of 5 each.
+	have_counter_event "th01:ut_201" "th_counter" "test" "test2" 20 actual &&
+	have_counter_event "th02:ut_201" "th_counter" "test" "test2" 20 actual &&
+	have_counter_event "th03:ut_201" "th_counter" "test" "test2" 20 actual &&
+
+	# And we should have a single event with the total across all threads.
+	have_counter_event "main" "counter" "test" "test2" 60 actual
+'
+
 test_done
diff --git a/trace2.c b/trace2.c
index c564ff49bb9..2376500ea05 100644
--- a/trace2.c
+++ b/trace2.c
@@ -8,6 +8,7 @@
 #include "version.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_cmd_name.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
@@ -101,6 +102,22 @@ static void tr2_tgt_emit_a_timer(const struct tr2_timer_metadata *meta,
 			tgt_j->pfn_timer(meta, timer, is_final_data);
 }
 
+/*
+ * The signature of this function must match the pfn_counter
+ * method in the targets.
+ */
+static void tr2_tgt_emit_a_counter(const struct tr2_counter_metadata *meta,
+				   const struct tr2_counter *counter,
+				   int is_final_data)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_counter)
+			tgt_j->pfn_counter(meta, counter, is_final_data);
+}
+
 static int tr2main_exit_code;
 
 /*
@@ -132,20 +149,26 @@ static void tr2main_atexit_handler(void)
 	 * Some timers want per-thread details.  If the main thread
 	 * used one of those timers, emit the details now (before
 	 * we emit the aggregate timer values).
+	 *
+	 * Likewise for counters.
 	 */
 	tr2_emit_per_thread_timers(tr2_tgt_emit_a_timer);
+	tr2_emit_per_thread_counters(tr2_tgt_emit_a_counter);
 
 	/*
-	 * Add stopwatch timer data for the main thread to the final
-	 * totals.  And then emit the final timer values.
+	 * Add stopwatch timer and counter data for the main thread to
+	 * the final totals.  And then emit the final values.
 	 *
 	 * Technically, we shouldn't need to hold the lock to update
-	 * and output the final_timer_block (since all other threads
-	 * should be dead by now), but it doesn't hurt anything.
+	 * and output the final_timer_block and final_counter_block
+	 * (since all other threads should be dead by now), but it
+	 * doesn't hurt anything.
 	 */
 	tr2tls_lock();
 	tr2_update_final_timers();
+	tr2_update_final_counters();
 	tr2_emit_final_timers(tr2_tgt_emit_a_timer);
+	tr2_emit_final_counters(tr2_tgt_emit_a_counter);
 	tr2tls_unlock();
 
 	for_each_wanted_builtin (j, tgt_j)
@@ -582,16 +605,20 @@ void trace2_thread_exit_fl(const char *file, int line)
 	/*
 	 * Some timers want per-thread details.  If this thread used
 	 * one of those timers, emit the details now.
+	 *
+	 * Likewise for counters.
 	 */
 	tr2_emit_per_thread_timers(tr2_tgt_emit_a_timer);
+	tr2_emit_per_thread_counters(tr2_tgt_emit_a_counter);
 
 	/*
-	 * Add stopwatch timer data from the current (non-main) thread
-	 * to the final totals.  (We'll accumulate data for the main
-	 * thread later during "atexit".)
+	 * Add stopwatch timer and counter data from the current
+	 * (non-main) thread to the final totals.  (We'll accumulate
+	 * data for the main thread later during "atexit".)
 	 */
 	tr2tls_lock();
 	tr2_update_final_timers();
+	tr2_update_final_counters();
 	tr2tls_unlock();
 
 	for_each_wanted_builtin (j, tgt_j)
@@ -870,6 +897,17 @@ void trace2_timer_stop(enum trace2_timer_id tid)
 	tr2_stop_timer(tid);
 }
 
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (cid < 0 || cid >= TRACE2_NUMBER_OF_COUNTERS)
+		BUG("trace2_counter_add: invalid counter id: %d", cid);
+
+	tr2_counter_increment(cid, value);
+}
+
 const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
diff --git a/trace2.h b/trace2.h
index 2d146fb32fc..da670ffd26c 100644
--- a/trace2.h
+++ b/trace2.h
@@ -52,6 +52,7 @@ struct json_writer;
  * [] trace2_data*      -- emit region/thread/repo data messages.
  * [] trace2_printf*    -- legacy trace[1] messages.
  * [] trace2_timer*     -- stopwatch timers (messages are deferred).
+ * [] trace2_counter*   -- global counters (messages are deferred).
  */
 
 /*
@@ -528,6 +529,42 @@ enum trace2_timer_id {
 void trace2_timer_start(enum trace2_timer_id tid);
 void trace2_timer_stop(enum trace2_timer_id tid);
 
+/*
+ * Define the set of global counters.
+ *
+ * We can add more at any time, but they must be defined at compile
+ * time (to avoid the need to dynamically allocate and synchronize
+ * them between different threads).
+ *
+ * These must start at 0 and be contiguous (because we use them
+ * elsewhere as array indexes).
+ *
+ * Any values added to this enum be also be added to the
+ * `tr2_counter_metadata[]` in `trace2/tr2_tr2_ctr.c`.
+ */
+enum trace2_counter_id {
+	/*
+	 * Define two counters for testing.  See `t/helper/test-trace2.c`.
+	 * These can be used for ad hoc testing, but should not be used
+	 * for permanent analysis code.
+	 */
+	TRACE2_COUNTER_ID_TEST1 = 0, /* emits summary event only */
+	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
+
+	/* Add additional counter definitions before here. */
+	TRACE2_NUMBER_OF_COUNTERS
+};
+
+/*
+ * Increase the named global counter by value.
+ *
+ * Note that this adds `value` to the current thread's partial sum for
+ * this counter (without locking) and that the complete sum is not
+ * available until all threads have exited, so it does not return the
+ * new value of the counter.
+ */
+void trace2_counter_add(enum trace2_counter_id cid, uint64_t value);
+
 /*
  * Optional platform-specific code to dump information about the
  * current and any parent process(es).  This is intended to allow
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
new file mode 100644
index 00000000000..483ca7c308f
--- /dev/null
+++ b/trace2/tr2_ctr.c
@@ -0,0 +1,101 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_ctr.h"
+
+/*
+ * A global counter block to aggregrate values from the partial sums
+ * from each thread.
+ */
+static struct tr2_counter_block final_counter_block; /* access under tr2tls_mutex */
+
+/*
+ * Define metadata for each global counter.
+ *
+ * This array must match the "enum trace2_counter_id" and the values
+ * in "struct tr2_counter_block.counter[*]".
+ */
+static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTERS] = {
+	[TRACE2_COUNTER_ID_TEST1] = {
+		.category = "test",
+		.name = "test1",
+		.want_per_thread_events = 0,
+	},
+	[TRACE2_COUNTER_ID_TEST2] = {
+		.category = "test",
+		.name = "test2",
+		.want_per_thread_events = 1,
+	},
+
+	/* Add additional metadata before here. */
+};
+
+void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2_counter *c = &ctx->counter_block.counter[cid];
+
+	c->value += value;
+
+	ctx->used_any_counter = 1;
+	if (tr2_counter_metadata[cid].want_per_thread_events)
+		ctx->used_any_per_thread_counter = 1;
+}
+
+void tr2_update_final_counters(void)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	enum trace2_counter_id cid;
+
+	if (!ctx->used_any_counter)
+		return;
+
+	/*
+	 * Access `final_counter_block` requires holding `tr2tls_mutex`.
+	 * We assume that our caller is holding the lock.
+	 */
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++) {
+		struct tr2_counter *c_final = &final_counter_block.counter[cid];
+		const struct tr2_counter *c = &ctx->counter_block.counter[cid];
+
+		c_final->value += c->value;
+	}
+}
+
+void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	enum trace2_counter_id cid;
+
+	if (!ctx->used_any_per_thread_counter)
+		return;
+
+	/*
+	 * For each counter, if the counter wants per-thread events
+	 * and this thread used it (the value is non-zero), emit it.
+	 */
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
+		if (tr2_counter_metadata[cid].want_per_thread_events &&
+		    ctx->counter_block.counter[cid].value)
+			fn_apply(&tr2_counter_metadata[cid],
+				 &ctx->counter_block.counter[cid],
+				 0);
+}
+
+void tr2_emit_final_counters(tr2_tgt_evt_counter_t *fn_apply)
+{
+	enum trace2_counter_id cid;
+
+	/*
+	 * Access `final_counter_block` requires holding `tr2tls_mutex`.
+	 * We assume that our caller is holding the lock.
+	 */
+
+	for (cid = 0; cid < TRACE2_NUMBER_OF_COUNTERS; cid++)
+		if (final_counter_block.counter[cid].value)
+			fn_apply(&tr2_counter_metadata[cid],
+				 &final_counter_block.counter[cid],
+				 1);
+}
diff --git a/trace2/tr2_ctr.h b/trace2/tr2_ctr.h
new file mode 100644
index 00000000000..a2267ee9901
--- /dev/null
+++ b/trace2/tr2_ctr.h
@@ -0,0 +1,104 @@
+#ifndef TR2_CTR_H
+#define TR2_CTR_H
+
+#include "trace2.h"
+#include "trace2/tr2_tgt.h"
+
+/*
+ * Define a mechanism to allow global "counters".
+ *
+ * Counters can be used count interesting activity that does not fit
+ * the "region and data" model, such as code called from many
+ * different regions and/or where you want to count a number of items,
+ * but don't have control of when the last item will be processed,
+ * such as counter the number of calls to `lstat()`.
+ *
+ * Counters differ from Trace2 "data" events.  Data events are emitted
+ * immediately and are appropriate for documenting loop counters at
+ * the end of a region, for example.  Counter values are accumulated
+ * during the program and final counter values are emitted at program
+ * exit.
+ *
+ * To make this model efficient, we define a compile-time fixed set of
+ * counters and counter ids using a fixed size "counter block" array
+ * in thread-local storage.  This gives us constant time, lock-free
+ * access to each counter within each thread.  This lets us avoid the
+ * complexities of dynamically allocating a counter and sharing that
+ * definition with other threads.
+ *
+ * Each thread uses the counter block in its thread-local storage to
+ * increment partial sums for each counter (without locking).  When a
+ * thread exits, those partial sums are (under lock) added to the
+ * global final sum.
+ *
+ * Partial sums for each counter are optionally emitted when a thread
+ * exits.
+ *
+ * Final sums for each counter are emitted between the "exit" and
+ * "atexit" events.
+ *
+ * A parallel "counter metadata" table contains the "category" and
+ * "name" fields for each counter.  This eliminates the need to
+ * include those args in the various counter APIs.
+ */
+
+/*
+ * The definition of an individual counter as used by an individual
+ * thread (and later in aggregation).
+ */
+struct tr2_counter {
+	uint64_t value;
+};
+
+/*
+ * Metadata for a counter.
+ */
+struct tr2_counter_metadata {
+	const char *category;
+	const char *name;
+
+	/*
+	 * True if we should emit per-thread events for this counter
+	 * when individual threads exit.
+	 */
+	unsigned int want_per_thread_events:1;
+};
+
+/*
+ * A compile-time fixed block of counters to insert into thread-local
+ * storage.  This wrapper is used to avoid quirks of C and the usual
+ * need to pass an array size argument.
+ */
+struct tr2_counter_block {
+	struct tr2_counter counter[TRACE2_NUMBER_OF_COUNTERS];
+};
+
+/*
+ * Private routines used by trace2.c to increment a counter for the
+ * current thread.
+ */
+void tr2_counter_increment(enum trace2_counter_id cid, uint64_t value);
+
+/*
+ * Add the current thread's counter data to the global totals.
+ * This is called during thread-exit.
+ *
+ * Caller must be holding the tr2tls_mutex.
+ */
+void tr2_update_final_counters(void);
+
+/*
+ * Emit per-thread counter data for the current thread.
+ * This is called during thread-exit.
+ */
+void tr2_emit_per_thread_counters(tr2_tgt_evt_counter_t *fn_apply);
+
+/*
+ * Emit global counter values.
+ * This is called during atexit handling.
+ *
+ * Caller must be holding the tr2tls_mutex.
+ */
+void tr2_emit_final_counters(tr2_tgt_evt_counter_t *fn_apply);
+
+#endif /* TR2_CTR_H */
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 2a80bef0df5..94a334d980a 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -6,6 +6,8 @@ struct repository;
 struct json_writer;
 struct tr2_timer_metadata;
 struct tr2_timer;
+struct tr2_counter_metadata;
+struct tr2_counter;
 
 /*
  * Function prototypes for a TRACE2 "target" vtable.
@@ -102,6 +104,10 @@ typedef void(tr2_tgt_evt_timer_t)(const struct tr2_timer_metadata *meta,
 				  const struct tr2_timer *timer,
 				  int is_final_data);
 
+typedef void(tr2_tgt_evt_counter_t)(const struct tr2_counter_metadata *meta,
+				    const struct tr2_counter *counter,
+				    int is_final_data);
+
 /*
  * "vtable" for a TRACE2 target.  Use NULL if a target does not want
  * to emit that message.
@@ -139,6 +145,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
 	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
 	tr2_tgt_evt_timer_t                     *pfn_timer;
+	tr2_tgt_evt_counter_t                   *pfn_counter;
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 1196da89ba4..bb0653e0e6f 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -642,6 +642,24 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 	jw_release(&jw);
 }
 
+static void fn_counter(const struct tr2_counter_metadata *meta,
+		       const struct tr2_counter *counter,
+		       int is_final_data)
+{
+	const char *event_name = is_final_data ? "counter" : "th_counter";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	jw_object_string(&jw, "category", meta->category);
+	jw_object_string(&jw, "name", meta->name);
+	jw_object_intmax(&jw, "count", counter->value);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 struct tr2_tgt tr2_tgt_event = {
 	.pdst = &tr2dst_event,
 
@@ -674,4 +692,5 @@ struct tr2_tgt tr2_tgt_event = {
 	.pfn_data_json_fl = fn_data_json_fl,
 	.pfn_printf_va_fl = NULL,
 	.pfn_timer = fn_timer,
+	.pfn_counter = fn_counter,
 };
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 3888c10ef50..b21508e06f7 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -351,6 +351,21 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_counter(const struct tr2_counter_metadata *meta,
+		       const struct tr2_counter *counter,
+		       int is_final_data)
+{
+	const char *event_name = is_final_data ? "counter" : "th_counter";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "%s %s/%s value:%"PRIu64,
+		    event_name, meta->category, meta->name,
+		    counter->value);
+
+	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_normal = {
 	.pdst = &tr2dst_normal,
 
@@ -383,4 +398,5 @@ struct tr2_tgt tr2_tgt_normal = {
 	.pfn_data_json_fl = NULL,
 	.pfn_printf_va_fl = fn_printf_va_fl,
 	.pfn_timer = fn_timer,
+	.pfn_counter = fn_counter,
 };
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 064aefbbebb..cbf8aefd56c 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -582,6 +582,22 @@ static void fn_timer(const struct tr2_timer_metadata *meta,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_counter(const struct tr2_counter_metadata *meta,
+		       const struct tr2_counter *counter,
+		       int is_final_data)
+{
+	const char *event_name = is_final_data ? "counter" : "th_counter";
+	struct strbuf buf_payload = STRBUF_INIT;
+
+	strbuf_addf(&buf_payload, "name:%s value:%"PRIu64,
+		    meta->name,
+		    counter->value);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL, NULL, NULL,
+			 meta->category, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	.pdst = &tr2dst_perf,
 
@@ -614,4 +630,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	.pfn_data_json_fl = fn_data_json_fl,
 	.pfn_printf_va_fl = fn_printf_va_fl,
 	.pfn_timer = fn_timer,
+	.pfn_counter = fn_counter,
 };
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 4f8e24f1749..e306c9bf3ec 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -2,6 +2,7 @@
 #define TR2_TLS_H
 
 #include "strbuf.h"
+#include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tmr.h"
 
 /*
@@ -16,8 +17,11 @@ struct tr2tls_thread_ctx {
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 	struct tr2_timer_block timer_block;
+	struct tr2_counter_block counter_block;
 	unsigned int used_any_timer:1;
 	unsigned int used_any_per_thread_timer:1;
+	unsigned int used_any_counter:1;
+	unsigned int used_any_per_thread_counter:1;
 	char thread_name[FLEX_ARRAY];
 };
 
-- 
gitgitgadget
