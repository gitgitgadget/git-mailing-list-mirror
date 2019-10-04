Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F811F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 22:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfJDWIg (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 18:08:36 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56228 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJDWIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 18:08:35 -0400
Received: by mail-pl1-f202.google.com with SMTP id g11so4746291plm.22
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qSQE4sW/WsNuLde3haIK8sQROaeX0cuhSpI19WoQDcU=;
        b=VCRfCU+Ydh0Vmb9NzcfRrZQiDM1TIveiv3atHUOE4fLZJ5I3Q0KM13Z4k/uhFKLa10
         098gyH/KpNjfibtPzYNYuDjwfnpbOzGY4krL44WcK0LEVtNojvvzmYpaqkRK2CC/ZZw2
         3YtSsdsqIb6DyGEWPGWmdweaiTVFjItqVBcijuHCHYALjHGSvWzhc/j9x9OPEJwMU5Fe
         WtOlPup29hjpzyQY0y8s33w220h8MsauydYtf5Da/feUgNnVZVrWL4+86l8tTPJXTT4P
         d9Pm3Mqzs8Glg5qhwFNziNBTMRBaJFgswDfYOxK/LUkhe4DS5YyKizlAPB/p4r5vyao+
         R0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qSQE4sW/WsNuLde3haIK8sQROaeX0cuhSpI19WoQDcU=;
        b=BIkHl0cJ7MaTOkDfytJzmhhW2L72gD9kf0QhNW2AYVaGIDO/lwYy44yDLxXknrapAM
         TudHcAfxV65UssC38gK79MmfWgMJHSQPgTBOlDqxwD4BSvsFMeOVdAiZgROX/zrzo2v2
         lUuK1eQrJsM2mEdOjCT13DFZUacRPegLAn0p68KRjRaWvhlVfPhgY2zeQJuro92jCOEt
         +RkIA6j+CS1d5HKxbDjxDxOI7AhvQYJFVG2xzAjOlS3HgLpWyzFDot8mwFeAJbuF8H7Y
         yPD7aDpRS6rBDve5+Ms+4CtVdqMiXadi5SqBFzkPTdzcitIfM9bvXx9Si2ZktkJXFqhb
         nw3g==
X-Gm-Message-State: APjAAAXRVvh4kJG3cOjKhUqnL6nFXBTr8fGrP3UPfZkRVi184Px5l1rF
        jqHdTZNL1LCkBabxQ+uOY7qfULHyyZ8/0uQ7XLG1KvMcNEmVcWlJ45xVXKB3N0vZ/LbrPIG5eF7
        qPldsGHrM7x5s67AQyOoj42gr54VXJ7welC2m8yjxf4+x2C9iRh0vBFdxeadWSBw=
X-Google-Smtp-Source: APXvYqy4Ciz7/9Sk87Fn6UewxgNLQwGAMJOozyITdAQT70l1ZRBkIS/55XFLdm+5PznW8Qn7y6OTf5OgeRWwQA==
X-Received: by 2002:a65:5883:: with SMTP id d3mr17879208pgu.332.1570226914509;
 Fri, 04 Oct 2019 15:08:34 -0700 (PDT)
Date:   Fri,  4 Oct 2019 15:08:21 -0700
In-Reply-To: <cover.1570225500.git.steadmon@google.com>
Message-Id: <1c3c7f01c6ce87728190913da238400220bf68d4.1570225500.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1570225500.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH v5 4/4] trace2: write discard message to sentinel files
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, stolee@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "discard" event type for trace2 event destinations. When the
trace2 file count check creates a sentinel file, it will include the
normal trace2 output in the sentinel, along with this new discard
event.

Writing this message into the sentinel file is useful for tracking how
often the file count check triggers in practice.

Bump up the event format version since we've added a new event type.

Change-Id: I0953c1a891ad93585ddcd8e22575ec34c0ebe73c
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 16 +++++++--
 t/t0212-trace2-event.sh                |  4 ++-
 trace2/tr2_dst.c                       | 47 ++++++++++++++------------
 trace2/tr2_dst.h                       |  1 +
 trace2/tr2_tgt_event.c                 | 31 +++++++++++++----
 trace2/tr2_tgt_normal.c                |  2 +-
 trace2/tr2_tgt_perf.c                  |  2 +-
 7 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 18b79128fd..a045dbe422 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -128,7 +128,7 @@ yields
 
 ------------
 $ cat ~/log.event
-{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"1","exe":"2.20.1.155.g426c96fcdb"}
+{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"2","exe":"2.20.1.155.g426c96fcdb"}
 {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
 {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
 {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
@@ -616,11 +616,23 @@ only present on the "start" and "atexit" events.
 {
 	"event":"version",
 	...
-	"evt":"1",		       # EVENT format version
+	"evt":"2",		       # EVENT format version
 	"exe":"2.20.1.155.g426c96fcdb" # git version
 }
 ------------
 
+`"discard"`::
+	This event is written to the git-trace2-discard sentinel file if there
+	are too many files in the target trace directory (see the
+	trace2.maxFiles config option).
++
+------------
+{
+	"event":"discard",
+	...
+}
+------------
+
 `"start"`::
 	This event contains the complete argv received by main().
 +
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index bf75e06e30..7065a1b937 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -279,7 +279,9 @@ test_expect_success 'discard traces when there are too many files' '
 	) &&
 	echo git-trace2-discard >>expected_filenames.txt &&
 	ls trace_target_dir >ls_output.txt &&
-	test_cmp expected_filenames.txt ls_output.txt
+	test_cmp expected_filenames.txt ls_output.txt &&
+	head -n1 trace_target_dir/git-trace2-discard | grep \"event\":\"version\" &&
+	head -n2 trace_target_dir/git-trace2-discard | tail -n1 | grep \"event\":\"too_many_files\"
 '
 
 test_done
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index f4646bf98d..741ec872a7 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -48,15 +48,19 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 /*
  * Check to make sure we're not overloading the target directory with too many
  * files. First get the threshold (if present) from the config or envvar. If
- * it's zero or unset, disable this check.  Next check for the presence of a
- * sentinel file, then check file count. If we are overloaded, create the
- * sentinel file if it doesn't already exist.
+ * it's zero or unset, disable this check. Next check for the presence of a
+ * sentinel file, then check file count.
+ *
+ * Returns 0 if tracing should proceed as normal. Returns 1 if the sentinel file
+ * already exists, which means tracing should be disabled. Returns -1 if there
+ * are too many files but there was no sentinel file, which means we have
+ * created and should write traces to the sentinel file.
  *
  * We expect that some trace processing system is gradually collecting files
  * from the target directory; after it removes the sentinel file we'll start
  * writing traces again.
  */
-static int tr2_dst_too_many_files(const char *tgt_prefix)
+static int tr2_dst_too_many_files(struct tr2_dst *dst, const char *tgt_prefix)
 {
 	int file_count = 0, max_files = 0, ret = 0;
 	const char *max_files_var;
@@ -95,8 +99,9 @@ static int tr2_dst_too_many_files(const char *tgt_prefix)
 		closedir(dirp);
 
 	if (file_count >= tr2env_max_files) {
-		creat(sentinel_path.buf, 0666);
-		ret = 1;
+		dst->too_many_files = 1;
+		dst->fd = open(sentinel_path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		ret = -1;
 		goto cleanup;
 	}
 
@@ -108,7 +113,7 @@ static int tr2_dst_too_many_files(const char *tgt_prefix)
 
 static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 {
-	int fd;
+	int too_many_files;
 	const char *last_slash, *sid = tr2_sid_get();
 	struct strbuf path = STRBUF_INIT;
 	size_t base_path_len;
@@ -124,7 +129,19 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 	strbuf_addstr(&path, sid);
 	base_path_len = path.len;
 
-	if (tr2_dst_too_many_files(tgt_prefix)) {
+	too_many_files = tr2_dst_too_many_files(dst, tgt_prefix);
+	if (!too_many_files) {
+		for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
+			if (attempt_count > 0) {
+				strbuf_setlen(&path, base_path_len);
+				strbuf_addf(&path, ".%d", attempt_count);
+			}
+
+			dst->fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
+			if (dst->fd != -1)
+				break;
+		}
+	} else if (too_many_files == 1) {
 		strbuf_release(&path);
 		if (tr2_dst_want_warning())
 			warning("trace2: not opening %s trace file due to too "
@@ -134,18 +151,7 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 		return 0;
 	}
 
-	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
-		if (attempt_count > 0) {
-			strbuf_setlen(&path, base_path_len);
-			strbuf_addf(&path, ".%d", attempt_count);
-		}
-
-		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
-		if (fd != -1)
-			break;
-	}
-
-	if (fd == -1) {
+	if (dst->fd == -1) {
 		if (tr2_dst_want_warning())
 			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
 				(int) base_path_len, path.buf,
@@ -159,7 +165,6 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 
 	strbuf_release(&path);
 
-	dst->fd = fd;
 	dst->need_close = 1;
 	dst->initialized = 1;
 
diff --git a/trace2/tr2_dst.h b/trace2/tr2_dst.h
index 3adf3bac13..b1a8c144e0 100644
--- a/trace2/tr2_dst.h
+++ b/trace2/tr2_dst.h
@@ -9,6 +9,7 @@ struct tr2_dst {
 	int fd;
 	unsigned int initialized : 1;
 	unsigned int need_close : 1;
+	unsigned int too_many_files : 1;
 };
 
 /*
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c2852d1bd2..424e6def3e 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -10,16 +10,17 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0 };
+static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
 
 /*
- * The version number of the JSON data generated by the EVENT target
- * in this source file.  Update this if you make a significant change
- * to the JSON fields or message structure.  You probably do not need
- * to update this if you just add another call to one of the existing
- * TRACE2 API methods.
+ * The version number of the JSON data generated by the EVENT target in this
+ * source file. The version should be incremented if new event types are added,
+ * if existing fields are removed, or if there are significant changes in
+ * interpretation of existing events or fields. Smaller changes, such as adding
+ * a new field to an existing event, do not require an increment to the EVENT
+ * format version.
  */
-#define TR2_EVENT_VERSION "1"
+#define TR2_EVENT_VERSION "2"
 
 /*
  * Region nesting limit for messages written to the event target.
@@ -107,6 +108,19 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 		jw_object_intmax(jw, "repo", repo->trace2_repo_id);
 }
 
+static void fn_too_many_files_fl(const char *file, int line)
+{
+	const char *event_name = "too_many_files";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 static void fn_version_fl(const char *file, int line)
 {
 	const char *event_name = "version";
@@ -120,6 +134,9 @@ static void fn_version_fl(const char *file, int line)
 
 	tr2_dst_write_line(&tr2dst_event, &jw.json);
 	jw_release(&jw);
+
+	if (tr2dst_event.too_many_files)
+		fn_too_many_files_fl(file, line);
 }
 
 static void fn_start_fl(const char *file, int line,
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 00b116d797..e91633468d 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -9,7 +9,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0 };
+static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0, 0 };
 
 /*
  * Use the TR2_SYSENV_NORMAL_BRIEF setting to omit the "<time> <file>:<line>"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index ea0cbbe13e..bebac4782d 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -11,7 +11,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0 };
+static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0, 0 };
 
 /*
  * Use TR2_SYSENV_PERF_BRIEF to omit the "<time> <file>:<line>"
-- 
2.23.0.581.g78d2f28ef7-goog

