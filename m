Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66918C43217
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJDQUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJDQU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:20:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0B4456A
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:20:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so16764246wrr.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=pvP0QmMA5SmQDdTHVTyvT9opvuzNYMRmnEtM4AoZ9K4=;
        b=T5yulZwnp8a3RjQzp8riuUZk7piWPzqQV4SnBBR7dBm7sSBB6E+QxJgG+FLEIAsfVr
         wMmxbHWuciw36vBzOUb6uiOINnQzuT+ejJb2dKC8rWulsXlItcNBvHbbFAJAIweUxTJm
         lTnw9BI3R9WP3ugx48Gh8FwLdvwVdS5RRLY1ddNguIVlSSB3EfEiXgtqdzL2J3u61DGl
         fyNlMUE9GdBm0T7bpxKntK05EqlNHcnyPLbBx9Egy5M8bxZeyE0C59MOLd5+bCGe6+xl
         EmkxPeS5Xhw94vkLgC47fMak7iljezrHjBvOmACjxOyaryfI23IVpcszdKJZFs9Qnu4j
         qBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pvP0QmMA5SmQDdTHVTyvT9opvuzNYMRmnEtM4AoZ9K4=;
        b=SGrM6ykkwFXqcrkzt6WwurOnCH5tXWgLV/9xgScUZunERkqu6VsLzuuqVljSvSRr88
         /2UTv3wbIqCZlZkbwyQZOh6HOfqP1IoKT2ysA3k8SuwrUxhNbqaZ6xi92/WoCLhjH7r9
         5YqSjYqTitf5DTzVSMlVyXJiXKQOZxiMgDy0nlFj7JLp6IuCe7/ZC7UazgOJMKzzBQOw
         8HUwSUa7UdVdZWcyI0KrGpLiWD4ieDODLoXQ8qCYRlpRXguoM+vVOjJkf0hRD/DMc3p9
         jchy2LGccc7AYb5VR+XhCAno2zBXZr/XpcvW2XkBYImd1DV+oAK/R8QYNfkj6q1+7tdj
         PAyA==
X-Gm-Message-State: ACrzQf0SQEcMdBnIoqDYD+DAtkTFvgYW+2aBtyd++7656rIZanbOYysP
        T7XN1iKZLNNWFomVcI8vdOjL7+7n/tk=
X-Google-Smtp-Source: AMsMyM6ClR8UTkaJbPa2txAlvmVWjvlA7723lh7u2FSOOzTOfWvB5rdzeMVd2SRl4+2L1MjGpEddBw==
X-Received: by 2002:a5d:5a05:0:b0:22e:5b81:c295 with SMTP id bq5-20020a5d5a05000000b0022e5b81c295mr579594wrb.588.1664900415271;
        Tue, 04 Oct 2022 09:20:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m67-20020a1c2646000000b003a342933727sm19499657wmm.3.2022.10.04.09.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:20:14 -0700 (PDT)
Message-Id: <19c7bba91ba87a795f53e8b4ce4f285fe184688b.1664900407.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Oct 2022 16:20:06 +0000
Subject: [PATCH 8/9] trace2: add stopwatch timers
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

Add stopwatch timer mechanism to Trace2.

Timers are an alternative to Trace2 Regions.  Regions are useful for
measuring the time spent in various computation phases, such as the
time to read the index, time to scan for unstaged files, time to scan
for untracked files, and etc.

However, regions are not appropriate in all places.  For example,
during a checkout, it would be very inefficient to use regions to
measure the total time spent inflating objects from the ODB from
across the entire lifetime of the process; a per-unzip() region would
flood the output and significantly slow the command; and some form of
post-processing would be requried to compute the time spent in unzip().

Timers can be used to measure a series of timer intervals and emit
a single summary event (at thread and/or process exit).

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/technical/api-trace2.txt |  90 ++++++++++++
 Makefile                               |   1 +
 t/helper/test-trace2.c                 |  98 +++++++++++++
 t/t0211-trace2-perf.sh                 |  49 +++++++
 t/t0211/scrub_perf.perl                |   6 +
 trace2.c                               |  75 ++++++++++
 trace2.h                               |  43 ++++++
 trace2/tr2_tgt.h                       |   7 +
 trace2/tr2_tgt_event.c                 |  26 ++++
 trace2/tr2_tgt_normal.c                |  23 ++++
 trace2/tr2_tgt_perf.c                  |  24 ++++
 trace2/tr2_tls.c                       |  10 ++
 trace2/tr2_tls.h                       |  10 ++
 trace2/tr2_tmr.c                       | 182 +++++++++++++++++++++++++
 trace2/tr2_tmr.h                       | 140 +++++++++++++++++++
 15 files changed, 784 insertions(+)
 create mode 100644 trace2/tr2_tmr.c
 create mode 100644 trace2/tr2_tmr.h

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 9d43909d068..75ce6f45603 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -769,6 +769,42 @@ The "value" field may be an integer or a string.
 }
 ------------
 
+`"th_timer"`::
+	This event logs the amount of time that a stopwatch timer was
+	running in the thread.  This event is generated when a thread
+	exits for timers that requested per-thread events.
++
+------------
+{
+	"event":"th_timer",
+	...
+	"category":"my_category",
+	"name":"my_timer",
+	"intervals":5,         # number of time it was started/stopped
+	"t_total":0.052741,    # total time in seconds it was running
+	"t_min":0.010061,      # shortest interval
+	"t_max":0.011648       # longest interval
+}
+------------
+
+`"timer"`::
+	This event logs the amount of time that a stopwatch timer was
+	running aggregated across all threads.  This event is generated
+	when the process exits.
++
+------------
+{
+	"event":"timer",
+	...
+	"category":"my_category",
+	"name":"my_timer",
+	"intervals":5,         # number of time it was started/stopped
+	"t_total":0.052741,    # total time in seconds it was running
+	"t_min":0.010061,      # shortest interval
+	"t_max":0.011648       # longest interval
+}
+------------
+
 == Example Trace2 API Usage
 
 Here is a hypothetical usage of the Trace2 API showing the intended
@@ -1200,6 +1236,60 @@ d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsy
 d0 | main                     | exit         |     |  0.000470 |           |              | code:0
 d0 | main                     | atexit       |     |  0.000477 |           |              | code:0
 ----------------
+
+Stopwatch Timer Events::
+
+	Measure the time spent in a function call or span of code
+	that might be called from many places within the code
+	throughout the life of the process.
++
+----------------
+static void expensive_function(void)
+{
+	trace2_timer_start(TRACE2_TIMER_ID_TEST1);
+	...
+	sleep_millisec(1000); // Do something expensive
+	...
+	trace2_timer_stop(TRACE2_TIMER_ID_TEST1);
+}
+
+static int ut_100timer(int argc, const char **argv)
+{
+	...
+
+	expensive_function();
+
+	// Do something else 1...
+
+	expensive_function();
+
+	// Do something else 2...
+
+	expensive_function();
+
+	return 0;
+}
+----------------
++
+In this example, we measure the total time spent in
+`expensive_function()` regardless of when it is called
+in the overall flow of the program.
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ t/helper/test-tool trace2 100timer 3 1000
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.001453 |           |              | t/helper/test-tool trace2 100timer 3 1000
+d0 | main                     | cmd_name     |     |           |           |              | trace2 (trace2)
+d0 | main                     | exit         |     |  3.003667 |           |              | code:0
+d0 | main                     | timer        |     |           |           | test         | name:test1 intervals:3 total:3.001686 min:1.000254 max:1.000929
+d0 | main                     | atexit       |     |  3.003796 |           |              | code:0
+----------------
+
+
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
diff --git a/Makefile b/Makefile
index cac3452edb9..820649bf62a 100644
--- a/Makefile
+++ b/Makefile
@@ -1102,6 +1102,7 @@ LIB_OBJS += trace2/tr2_tgt_event.o
 LIB_OBJS += trace2/tr2_tgt_normal.o
 LIB_OBJS += trace2/tr2_tgt_perf.o
 LIB_OBJS += trace2/tr2_tls.o
+LIB_OBJS += trace2/tr2_tmr.o
 LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index a714130ece7..f951b9e97d7 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -228,6 +228,101 @@ static int ut_010bug_BUG(int argc, const char **argv)
 	BUG("a %s message", "BUG");
 }
 
+/*
+ * Single-threaded timer test.  Create several intervals using the
+ * TEST1 timer.  The test script can verify that an aggregate Trace2
+ * "timer" event is emitted indicating that we started+stopped the
+ * timer the requested number of times.
+ */
+static int ut_100timer(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <count> <ms_delay>";
+
+	int count = 0;
+	int delay = 0;
+	int k;
+
+	if (argc != 2)
+		die("%s", usage_error);
+	if (get_i(&count, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&delay, argv[1]))
+		die("%s", usage_error);
+
+	for (k = 0; k < count; k++) {
+		trace2_timer_start(TRACE2_TIMER_ID_TEST1);
+		sleep_millisec(delay);
+		trace2_timer_stop(TRACE2_TIMER_ID_TEST1);
+	}
+
+	return 0;
+}
+
+struct ut_101_data {
+	int count;
+	int delay;
+};
+
+static void *ut_101timer_thread_proc(void *_ut_101_data)
+{
+	struct ut_101_data *data = _ut_101_data;
+	int k;
+
+	trace2_thread_start("ut_101");
+
+	for (k = 0; k < data->count; k++) {
+		trace2_timer_start(TRACE2_TIMER_ID_TEST2);
+		sleep_millisec(data->delay);
+		trace2_timer_stop(TRACE2_TIMER_ID_TEST2);
+	}
+
+	trace2_thread_exit();
+	return NULL;
+}
+
+/*
+ * Multi-threaded timer test.  Create several threads that each create
+ * several intervals using the TEST2 timer.  The test script can verify
+ * that an individual Trace2 "th_timer" events for each thread and an
+ * aggregate "timer" event are generated.
+ */
+static int ut_101timer(int argc, const char **argv)
+{
+	const char *usage_error =
+		"expect <count> <ms_delay> <threads>";
+
+	struct ut_101_data data = { 0, 0 };
+	int nr_threads = 0;
+	int k;
+	pthread_t *pids = NULL;
+
+	if (argc != 3)
+		die("%s", usage_error);
+	if (get_i(&data.count, argv[0]))
+		die("%s", usage_error);
+	if (get_i(&data.delay, argv[1]))
+		die("%s", usage_error);
+	if (get_i(&nr_threads, argv[2]))
+		die("%s", usage_error);
+
+	CALLOC_ARRAY(pids, nr_threads);
+
+	for (k = 0; k < nr_threads; k++) {
+		if (pthread_create(&pids[k], NULL, ut_101timer_thread_proc, &data))
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
@@ -248,6 +343,9 @@ static struct unit_test ut_table[] = {
 	{ ut_008bug,      "008bug",    "" },
 	{ ut_009bug_BUG,  "009bug_BUG","" },
 	{ ut_010bug_BUG,  "010bug_BUG","" },
+
+	{ ut_100timer,    "100timer",  "<count> <ms_delay>" },
+	{ ut_101timer,    "101timer",  "<count> <ms_delay> <threads>" },
 };
 /* clang-format on */
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 22d0845544e..5c28424e657 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -173,4 +173,53 @@ test_expect_success 'using global config, perf stream, return code 0' '
 	test_cmp expect actual
 '
 
+# Exercise the stopwatch timers in a loop and confirm that we have
+# as many start/stop intervals as expected.  We cannot really test the
+# actual (total, min, max) timer values, so we have to assume that they
+# are good, but we can verify the interval count.
+#
+# The timer "test/test1" should only emit a global summary "timer" event.
+# The timer "test/test2" should emit per-thread "th_timer" events and a
+# global summary "timer" event.
+
+have_timer_event () {
+	thread=$1 event=$2 category=$3 name=$4 intervals=$5 file=$6 &&
+
+	pattern="d0|${thread}|${event}||||${category}|name:${name} intervals:${intervals}" &&
+
+	grep "${pattern}" ${file}
+}
+
+test_expect_success 'stopwatch timer test/test1' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+
+	# Use the timer "test1" 5 times from "main".
+	test-tool trace2 100timer 5 10 &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	have_timer_event "main" "timer" "test" "test1" 5 actual
+'
+
+test_expect_success 'stopwatch timer test/test2' '
+	test_when_finished "rm trace.perf actual" &&
+	test_config_global trace2.perfBrief 1 &&
+	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
+
+	# Use the timer "test2" 5 times each in 3 threads.
+	test-tool trace2 101timer 5 10 3 &&
+
+	perl "$TEST_DIRECTORY/t0211/scrub_perf.perl" <trace.perf >actual &&
+
+	# So we should have 3 per-thread events of 5 each.
+	have_timer_event "th01:ut_101" "th_timer" "test" "test2" 5 actual &&
+	have_timer_event "th02:ut_101" "th_timer" "test" "test2" 5 actual &&
+	have_timer_event "th03:ut_101" "th_timer" "test" "test2" 5 actual &&
+
+	# And we should have 15 total uses.
+	have_timer_event "main" "timer" "test" "test2" 15 actual
+'
+
 test_done
diff --git a/t/t0211/scrub_perf.perl b/t/t0211/scrub_perf.perl
index 299999f0f89..7a50bae6463 100644
--- a/t/t0211/scrub_perf.perl
+++ b/t/t0211/scrub_perf.perl
@@ -64,6 +64,12 @@ while (<>) {
 	    goto SKIP_LINE;
 	}
     }
+    elsif ($tokens[$col_event] =~ m/timer/) {
+	# This also captures "th_timer" events
+	$tokens[$col_rest] =~ s/ total:\d+\.\d*/ total:_T_TOTAL_/;
+	$tokens[$col_rest] =~ s/ min:\d+\.\d*/ min:_T_MIN_/;
+	$tokens[$col_rest] =~ s/ max:\d+\.\d*/ max:_T_MAX_/;
+    }
 
     # t_abs and t_rel are either blank or a float.  Replace the float
     # with a constant for matching the HEREDOC in the test script.
diff --git a/trace2.c b/trace2.c
index c8e5acced2a..c564ff49bb9 100644
--- a/trace2.c
+++ b/trace2.c
@@ -13,6 +13,7 @@
 #include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 static int trace2_enabled;
 
@@ -83,6 +84,23 @@ static void tr2_tgt_disable_builtins(void)
 		tgt_j->pfn_term();
 }
 
+/*
+ * The signature of this function must match the pfn_timer
+ * method in the targets.  (Think of this is an apply operation
+ * across the set of active targets.)
+ */
+static void tr2_tgt_emit_a_timer(const struct tr2_timer_metadata *meta,
+				 const struct tr2_timer *timer,
+				 int is_final_data)
+{
+	struct tr2_tgt *tgt_j;
+	int j;
+
+	for_each_wanted_builtin (j, tgt_j)
+		if (tgt_j->pfn_timer)
+			tgt_j->pfn_timer(meta, timer, is_final_data);
+}
+
 static int tr2main_exit_code;
 
 /*
@@ -110,6 +128,26 @@ static void tr2main_atexit_handler(void)
 	 */
 	tr2tls_pop_unwind_self();
 
+	/*
+	 * Some timers want per-thread details.  If the main thread
+	 * used one of those timers, emit the details now (before
+	 * we emit the aggregate timer values).
+	 */
+	tr2_emit_per_thread_timers(tr2_tgt_emit_a_timer);
+
+	/*
+	 * Add stopwatch timer data for the main thread to the final
+	 * totals.  And then emit the final timer values.
+	 *
+	 * Technically, we shouldn't need to hold the lock to update
+	 * and output the final_timer_block (since all other threads
+	 * should be dead by now), but it doesn't hurt anything.
+	 */
+	tr2tls_lock();
+	tr2_update_final_timers();
+	tr2_emit_final_timers(tr2_tgt_emit_a_timer);
+	tr2tls_unlock();
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_atexit)
 			tgt_j->pfn_atexit(us_elapsed_absolute,
@@ -541,6 +579,21 @@ void trace2_thread_exit_fl(const char *file, int line)
 	tr2tls_pop_unwind_self();
 	us_elapsed_thread = tr2tls_region_elasped_self(us_now);
 
+	/*
+	 * Some timers want per-thread details.  If this thread used
+	 * one of those timers, emit the details now.
+	 */
+	tr2_emit_per_thread_timers(tr2_tgt_emit_a_timer);
+
+	/*
+	 * Add stopwatch timer data from the current (non-main) thread
+	 * to the final totals.  (We'll accumulate data for the main
+	 * thread later during "atexit".)
+	 */
+	tr2tls_lock();
+	tr2_update_final_timers();
+	tr2tls_unlock();
+
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_thread_exit_fl)
 			tgt_j->pfn_thread_exit_fl(file, line,
@@ -795,6 +848,28 @@ void trace2_printf_fl(const char *file, int line, const char *fmt, ...)
 	va_end(ap);
 }
 
+void trace2_timer_start(enum trace2_timer_id tid)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
+		BUG("trace2_timer_start: invalid timer id: %d", tid);
+
+	tr2_start_timer(tid);
+}
+
+void trace2_timer_stop(enum trace2_timer_id tid)
+{
+	if (!trace2_enabled)
+		return;
+
+	if (tid < 0 || tid >= TRACE2_NUMBER_OF_TIMERS)
+		BUG("trace2_timer_stop: invalid timer id: %d", tid);
+
+	tr2_stop_timer(tid);
+}
+
 const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
diff --git a/trace2.h b/trace2.h
index fe39dcb5849..2d146fb32fc 100644
--- a/trace2.h
+++ b/trace2.h
@@ -51,6 +51,7 @@ struct json_writer;
  * [] trace2_region*    -- emit region nesting messages.
  * [] trace2_data*      -- emit region/thread/repo data messages.
  * [] trace2_printf*    -- legacy trace[1] messages.
+ * [] trace2_timer*     -- stopwatch timers (messages are deferred).
  */
 
 /*
@@ -485,6 +486,48 @@ void trace2_printf_fl(const char *file, int line, const char *fmt, ...);
 
 #define trace2_printf(...) trace2_printf_fl(__FILE__, __LINE__, __VA_ARGS__)
 
+/*
+ * Define the set of stopwatch timers.
+ *
+ * We can add more at any time, but they must be defined at compile
+ * time (to avoid the need to dynamically allocate and synchronize
+ * them between different threads).
+ *
+ * These must start at 0 and be contiguous (because we use them
+ * elsewhere as array indexes).
+ *
+ * Any values added to this enum must also be added to the
+ * `tr2_timer_metadata[]` in `trace2/tr2_tmr.c`.
+ */
+enum trace2_timer_id {
+	/*
+	 * Define two timers for testing.  See `t/helper/test-trace2.c`.
+	 * These can be used for ad hoc testing, but should not be used
+	 * for permanent analysis code.
+	 */
+	TRACE2_TIMER_ID_TEST1 = 0, /* emits summary event only */
+	TRACE2_TIMER_ID_TEST2,     /* emits summary and thread events */
+
+	/* Add additional timer definitions before here. */
+	TRACE2_NUMBER_OF_TIMERS
+};
+
+/*
+ * Start/Stop the indicated stopwatch timer in the current thread.
+ *
+ * The time spent by the current thread between the _start and _stop
+ * calls will be added to the thread's partial sum for this timer.
+ *
+ * Timer events are emitted at thread and program exit.
+ *
+ * Note: Since the stopwatch API routines do not generate individual
+ * events, they do not take (file, line) arguments.  Similarly, the
+ * category and timer name values are defined at compile-time in the
+ * timer definitions array, so they are not needed here in the API.
+ */
+void trace2_timer_start(enum trace2_timer_id tid);
+void trace2_timer_stop(enum trace2_timer_id tid);
+
 /*
  * Optional platform-specific code to dump information about the
  * current and any parent process(es).  This is intended to allow
diff --git a/trace2/tr2_tgt.h b/trace2/tr2_tgt.h
index 65f94e15748..2a80bef0df5 100644
--- a/trace2/tr2_tgt.h
+++ b/trace2/tr2_tgt.h
@@ -4,6 +4,8 @@
 struct child_process;
 struct repository;
 struct json_writer;
+struct tr2_timer_metadata;
+struct tr2_timer;
 
 /*
  * Function prototypes for a TRACE2 "target" vtable.
@@ -96,6 +98,10 @@ typedef void(tr2_tgt_evt_printf_va_fl_t)(const char *file, int line,
 					 uint64_t us_elapsed_absolute,
 					 const char *fmt, va_list ap);
 
+typedef void(tr2_tgt_evt_timer_t)(const struct tr2_timer_metadata *meta,
+				  const struct tr2_timer *timer,
+				  int is_final_data);
+
 /*
  * "vtable" for a TRACE2 target.  Use NULL if a target does not want
  * to emit that message.
@@ -132,6 +138,7 @@ struct tr2_tgt {
 	tr2_tgt_evt_data_fl_t                   *pfn_data_fl;
 	tr2_tgt_evt_data_json_fl_t              *pfn_data_json_fl;
 	tr2_tgt_evt_printf_va_fl_t              *pfn_printf_va_fl;
+	tr2_tgt_evt_timer_t                     *pfn_timer;
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 52f9356c695..1196da89ba4 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -9,6 +9,7 @@
 #include "trace2/tr2_sysenv.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 static struct tr2_dst tr2dst_event = {
 	.sysenv_var = TR2_SYSENV_EVENT,
@@ -617,6 +618,30 @@ static void fn_data_json_fl(const char *file, int line,
 	}
 }
 
+static void fn_timer(const struct tr2_timer_metadata *meta,
+		     const struct tr2_timer *timer,
+		     int is_final_data)
+{
+	const char *event_name = is_final_data ? "timer" : "th_timer";
+	struct json_writer jw = JSON_WRITER_INIT;
+	double t_total = ((double)timer->total_ns) / 1000000000.0;
+	double t_min = ((double)timer->min_ns) / 1000000000.0;
+	double t_max = ((double)timer->max_ns) / 1000000000.0;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, __FILE__, __LINE__, NULL, &jw);
+	jw_object_string(&jw, "category", meta->category);
+	jw_object_string(&jw, "name", meta->name);
+	jw_object_intmax(&jw, "intervals", timer->interval_count);
+	jw_object_double(&jw, "t_total", 6, t_total);
+	jw_object_double(&jw, "t_min", 6, t_min);
+	jw_object_double(&jw, "t_max", 6, t_max);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 struct tr2_tgt tr2_tgt_event = {
 	.pdst = &tr2dst_event,
 
@@ -648,4 +673,5 @@ struct tr2_tgt tr2_tgt_event = {
 	.pfn_data_fl = fn_data_fl,
 	.pfn_data_json_fl = fn_data_json_fl,
 	.pfn_printf_va_fl = NULL,
+	.pfn_timer = fn_timer,
 };
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 69f80330778..3888c10ef50 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -8,6 +8,7 @@
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 static struct tr2_dst tr2dst_normal = {
 	.sysenv_var = TR2_SYSENV_NORMAL,
@@ -329,6 +330,27 @@ static void fn_printf_va_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_timer(const struct tr2_timer_metadata *meta,
+		     const struct tr2_timer *timer,
+		     int is_final_data)
+{
+	const char *event_name = is_final_data ? "timer" : "th_timer";
+	struct strbuf buf_payload = STRBUF_INIT;
+	double t_total = ((double)timer->total_ns) / 1000000000.0;
+	double t_min = ((double)timer->min_ns) / 1000000000.0;
+	double t_max = ((double)timer->max_ns) / 1000000000.0;
+
+	strbuf_addf(&buf_payload, ("%s %s/%s"
+				   " intervals:%"PRIu64
+				   " total:%8.6f min:%8.6f max:%8.6f"),
+		    event_name, meta->category, meta->name,
+		    timer->interval_count,
+		    t_total, t_min, t_max);
+
+	normal_io_write_fl(__FILE__, __LINE__, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_normal = {
 	.pdst = &tr2dst_normal,
 
@@ -360,4 +382,5 @@ struct tr2_tgt tr2_tgt_normal = {
 	.pfn_data_fl = NULL,
 	.pfn_data_json_fl = NULL,
 	.pfn_printf_va_fl = fn_printf_va_fl,
+	.pfn_timer = fn_timer,
 };
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index fdeb3292d3a..064aefbbebb 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -10,6 +10,7 @@
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
 
 static struct tr2_dst tr2dst_perf = {
 	.sysenv_var = TR2_SYSENV_PERF,
@@ -559,6 +560,28 @@ static void fn_printf_va_fl(const char *file, int line,
 	strbuf_release(&buf_payload);
 }
 
+static void fn_timer(const struct tr2_timer_metadata *meta,
+		     const struct tr2_timer *timer,
+		     int is_final_data)
+{
+	const char *event_name = is_final_data ? "timer" : "th_timer";
+	struct strbuf buf_payload = STRBUF_INIT;
+	double t_total = ((double)timer->total_ns) / 1000000000.0;
+	double t_min = ((double)timer->min_ns) / 1000000000.0;
+	double t_max = ((double)timer->max_ns) / 1000000000.0;
+
+	strbuf_addf(&buf_payload, ("name:%s"
+				   " intervals:%"PRIu64
+				   " total:%8.6f min:%8.6f max:%8.6f"),
+		    meta->name,
+		    timer->interval_count,
+		    t_total, t_min, t_max);
+
+	perf_io_write_fl(__FILE__, __LINE__, event_name, NULL, NULL, NULL,
+			 meta->category, &buf_payload);
+	strbuf_release(&buf_payload);
+}
+
 struct tr2_tgt tr2_tgt_perf = {
 	.pdst = &tr2dst_perf,
 
@@ -590,4 +613,5 @@ struct tr2_tgt tr2_tgt_perf = {
 	.pfn_data_fl = fn_data_fl,
 	.pfn_data_json_fl = fn_data_json_fl,
 	.pfn_printf_va_fl = fn_printf_va_fl,
+	.pfn_timer = fn_timer,
 };
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 89437e773f6..1aceb36b010 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -180,3 +180,13 @@ int tr2tls_locked_increment(int *p)
 
 	return current_value;
 }
+
+void tr2tls_lock(void)
+{
+	pthread_mutex_lock(&tr2tls_mutex);
+}
+
+void tr2tls_unlock(void)
+{
+	pthread_mutex_unlock(&tr2tls_mutex);
+}
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index be0bc73d08f..4f8e24f1749 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -2,6 +2,7 @@
 #define TR2_TLS_H
 
 #include "strbuf.h"
+#include "trace2/tr2_tmr.h"
 
 /*
  * Notice: the term "TLS" refers to "thread-local storage" in the
@@ -14,6 +15,9 @@ struct tr2tls_thread_ctx {
 	size_t alloc;
 	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
+	struct tr2_timer_block timer_block;
+	unsigned int used_any_timer:1;
+	unsigned int used_any_per_thread_timer:1;
 	char thread_name[FLEX_ARRAY];
 };
 
@@ -100,4 +104,10 @@ int tr2tls_locked_increment(int *p);
  */
 void tr2tls_start_process_clock(void);
 
+/*
+ * Explicitly lock/unlock our mutex.
+ */
+void tr2tls_lock(void);
+void tr2tls_unlock(void);
+
 #endif /* TR2_TLS_H */
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
new file mode 100644
index 00000000000..786762dfd26
--- /dev/null
+++ b/trace2/tr2_tmr.c
@@ -0,0 +1,182 @@
+#include "cache.h"
+#include "thread-utils.h"
+#include "trace2/tr2_tgt.h"
+#include "trace2/tr2_tls.h"
+#include "trace2/tr2_tmr.h"
+
+#define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
+#define MY_MIN(a, b) ((a) < (b) ? (a) : (b))
+
+/*
+ * A global timer block to aggregate values from the partial sums from
+ * each thread.
+ */
+static struct tr2_timer_block final_timer_block; /* access under tr2tls_mutex */
+
+/*
+ * Define metadata for each stopwatch timer.
+ *
+ * This array must match "enum trace2_timer_id" and the values
+ * in "struct tr2_timer_block.timer[*]".
+ */
+static struct tr2_timer_metadata tr2_timer_metadata[TRACE2_NUMBER_OF_TIMERS] = {
+	[TRACE2_TIMER_ID_TEST1] = {
+		.category = "test",
+		.name = "test1",
+		.want_per_thread_events = 0,
+	},
+	[TRACE2_TIMER_ID_TEST2] = {
+		.category = "test",
+		.name = "test2",
+		.want_per_thread_events = 1,
+	},
+
+	/* Add additional metadata before here. */
+};
+
+void tr2_start_timer(enum trace2_timer_id tid)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+
+	t->recursion_count++;
+	if (t->recursion_count > 1)
+		return; /* ignore recursive starts */
+
+	t->start_ns = getnanotime();
+}
+
+void tr2_stop_timer(enum trace2_timer_id tid)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	struct tr2_timer *t = &ctx->timer_block.timer[tid];
+	uint64_t ns_now;
+	uint64_t ns_interval;
+
+	assert(t->recursion_count > 0);
+
+	t->recursion_count--;
+	if (t->recursion_count)
+		return; /* still in recursive call(s) */
+
+	ns_now = getnanotime();
+	ns_interval = ns_now - t->start_ns;
+
+	t->total_ns += ns_interval;
+
+	/*
+	 * min_ns was initialized to zero (in the xcalloc()) rather
+	 * than UINT_MAX when the block of timers was allocated,
+	 * so we should always set both the min_ns and max_ns values
+	 * the first time that the timer is used.
+	 */
+	if (!t->interval_count) {
+		t->min_ns = ns_interval;
+		t->max_ns = ns_interval;
+	} else {
+		t->min_ns = MY_MIN(ns_interval, t->min_ns);
+		t->max_ns = MY_MAX(ns_interval, t->max_ns);
+	}
+
+	t->interval_count++;
+
+	ctx->used_any_timer = 1;
+	if (tr2_timer_metadata[tid].want_per_thread_events)
+		ctx->used_any_per_thread_timer = 1;
+}
+
+void tr2_update_final_timers(void)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	enum trace2_timer_id tid;
+
+	if (!ctx->used_any_timer)
+		return;
+
+	/*
+	 * Accessing `final_timer_block` requires holding `tr2tls_mutex`.
+	 * We assume that our caller is holding the lock.
+	 */
+
+	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++) {
+		struct tr2_timer *t_final = &final_timer_block.timer[tid];
+		struct tr2_timer *t = &ctx->timer_block.timer[tid];
+
+		if (t->recursion_count) {
+			/*
+			 * The current thread is exiting with
+			 * timer[tid] still running.
+			 *
+			 * Technically, this is a bug, but I'm going
+			 * to ignore it.
+			 *
+			 * I don't think it is worth calling die()
+			 * for.  I don't think it is worth killing the
+			 * process for this bookkeeping error.  We
+			 * might want to call warning(), but I'm going
+			 * to wait on that.
+			 *
+			 * The downside here is that total_ns won't
+			 * include the current open interval (now -
+			 * start_ns).  I can live with that.
+			 */
+		}
+
+		if (!t->interval_count)
+			continue; /* this timer was not used by this thread */
+
+		t_final->total_ns += t->total_ns;
+
+		/*
+		 * final_timer_block.timer[tid].min_ns was initialized to
+		 * was initialized to zero rather than UINT_MAX, so we should
+		 * always set both the min_ns and max_ns values the first time
+		 * that we add a partial sum into it.
+		 */
+		if (!t_final->interval_count) {
+			t_final->min_ns = t->min_ns;
+			t_final->max_ns = t->max_ns;
+		} else {
+			t_final->min_ns = MY_MIN(t_final->min_ns, t->min_ns);
+			t_final->max_ns = MY_MAX(t_final->max_ns, t->max_ns);
+		}
+
+		t_final->interval_count += t->interval_count;
+	}
+}
+
+void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply)
+{
+	struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
+	enum trace2_timer_id tid;
+
+	if (!ctx->used_any_per_thread_timer)
+		return;
+
+	/*
+	 * For each timer, if the timer wants per-thread events and
+	 * this thread used it, emit it.
+	 */
+	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
+		if (tr2_timer_metadata[tid].want_per_thread_events &&
+		    ctx->timer_block.timer[tid].interval_count)
+			fn_apply(&tr2_timer_metadata[tid],
+				 &ctx->timer_block.timer[tid],
+				 0);
+}
+
+void tr2_emit_final_timers(tr2_tgt_evt_timer_t *fn_apply)
+{
+	enum trace2_timer_id tid;
+
+	/*
+	 * Accessing `final_timer_block` requires holding `tr2tls_mutex`.
+	 * We assume that our caller is holding the lock.
+	 */
+
+	for (tid = 0; tid < TRACE2_NUMBER_OF_TIMERS; tid++)
+		if (final_timer_block.timer[tid].interval_count)
+			fn_apply(&tr2_timer_metadata[tid],
+				 &final_timer_block.timer[tid],
+				 1);
+}
diff --git a/trace2/tr2_tmr.h b/trace2/tr2_tmr.h
new file mode 100644
index 00000000000..d5753576134
--- /dev/null
+++ b/trace2/tr2_tmr.h
@@ -0,0 +1,140 @@
+#ifndef TR2_TMR_H
+#define TR2_TMR_H
+
+#include "trace2.h"
+#include "trace2/tr2_tgt.h"
+
+/*
+ * Define a mechanism to allow "stopwatch" timers.
+ *
+ * Timers can be used to measure "interesting" activity that does not
+ * fit the "region" model, such as code called from many different
+ * regions (like zlib) and/or where data for individual calls are not
+ * interesting or are too numerous to be efficiently logged.
+ *
+ * Timer values are accumulated during program execution and emitted
+ * to the Trace2 logs at program exit.
+ *
+ * To make this model efficient, we define a compile-time fixed set of
+ * timers and timer ids using a "timer block" array in thread-local
+ * storage.  This gives us constant time access to each timer within
+ * each thread, since we want start/stop operations to be as fast as
+ * possible.  This lets us avoid the complexities of dynamically
+ * allocating a timer on the first use by a thread and/or possibly
+ * sharing that timer definition with other concurrent threads.
+ * However, this does require that we define time the set of timers at
+ * compile time.
+ *
+ * Each thread uses the timer block in its thread-local storage to
+ * compute partial sums for each timer (without locking).  When a
+ * thread exits, those partial sums are (under lock) added to the
+ * global final sum.
+ *
+ * Using this "timer block" model costs ~48 bytes per timer per thread
+ * (we have about six uint64 fields per timer).  This does increase
+ * the size of the thread-local storage block, but it is allocated (at
+ * thread create time) and not on the thread stack, so I'm not worried
+ * about the size.
+ *
+ * Partial sums for each timer are optionally emitted when a thread
+ * exits.
+ *
+ * Final sums for each timer are emitted between the "exit" and
+ * "atexit" events.
+ *
+ * A parallel "timer metadata" table contains the "category" and "name"
+ * fields for each timer.  This eliminates the need to include those
+ * args in the various timer APIs.
+ */
+
+/*
+ * The definition of an individual timer and used by an individual
+ * thread.
+ */
+struct tr2_timer {
+	/*
+	 * Total elapsed time for this timer in this thread in nanoseconds.
+	 */
+	uint64_t total_ns;
+
+	/*
+	 * The maximum and minimum interval values observed for this
+	 * timer in this thread.
+	 */
+	uint64_t min_ns;
+	uint64_t max_ns;
+
+	/*
+	 * The value of the clock when this timer was started in this
+	 * thread.  (Undefined when the timer is not active in this
+	 * thread.)
+	 */
+	uint64_t start_ns;
+
+	/*
+	 * Number of times that this timer has been started and stopped
+	 * in this thread.  (Recursive starts are ignored.)
+	 */
+	uint64_t interval_count;
+
+	/*
+	 * Number of nested starts on the stack in this thread.  (We
+	 * ignore recursive starts and use this to track the recursive
+	 * calls.)
+	 */
+	unsigned int recursion_count;
+};
+
+/*
+ * Metadata for a timer.
+ */
+struct tr2_timer_metadata {
+	const char *category;
+	const char *name;
+
+	/*
+	 * True if we should emit per-thread events for this timer
+	 * when individual threads exit.
+	 */
+	unsigned int want_per_thread_events:1;
+};
+
+/*
+ * A compile-time fixed-size block of timers to insert into
+ * thread-local storage.  This wrapper is used to avoid quirks
+ * of C and the usual need to pass an array size argument.
+ */
+struct tr2_timer_block {
+	struct tr2_timer timer[TRACE2_NUMBER_OF_TIMERS];
+};
+
+/*
+ * Private routines used by trace2.c to actually start/stop an
+ * individual timer in the current thread.
+ */
+void tr2_start_timer(enum trace2_timer_id tid);
+void tr2_stop_timer(enum trace2_timer_id tid);
+
+/*
+ * Add the current thread's timer data to the global totals.
+ * This is called during thread-exit.
+ *
+ * Caller must be holding the tr2tls_mutex.
+ */
+void tr2_update_final_timers(void);
+
+/*
+ * Emit per-thread timer data for the current thread.
+ * This is called during thread-exit.
+ */
+void tr2_emit_per_thread_timers(tr2_tgt_evt_timer_t *fn_apply);
+
+/*
+ * Emit global total timer values.
+ * This is called during atexit handling.
+ *
+ * Caller must be holding the tr2tls_mutex.
+ */
+void tr2_emit_final_timers(tr2_tgt_evt_timer_t *fn_apply);
+
+#endif /* TR2_TMR_H */
-- 
gitgitgadget

