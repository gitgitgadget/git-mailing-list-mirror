Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6391A1F463
	for <e@80x24.org>; Sat, 14 Sep 2019 00:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbfINA0P (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 20:26:15 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36615 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbfINA0O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 20:26:14 -0400
Received: by mail-pg1-f201.google.com with SMTP id d19so18010956pgh.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 17:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bxEOdKAPl+S24xHe/pK5xLJ8rDBATODqiTx/u86y1K8=;
        b=jwXGxnmWQJIF2W8bgvvq54UQajsUG2aH1mR/2bUNvvFMTVB4wyttvMasGbc3OWFAxc
         d36pSEDvhemGeyr4lQNrkii8peKR08oQALNE7oSqN6QlpxYGi2n1oxE3eIAjn8yuGLMw
         nKKwnlU7lvdqoBTpCLlkIwFVJukKXK59bp3BJWH/ValTIPkjnkTbwbIRQ80fYTNz9b68
         9aaDXTfAu9+cZ/yjYfCZVXgyQS5vAl2FMzVpDIj0BdbLf1R1PjRrld3ndmjFNHaYpv1O
         jq40anoGutQs4wnZPPa//2YNHZa3ZuvUwPJUypBjR2xQDac/6VX9XD5Emxd2onQ/UQqr
         Zalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bxEOdKAPl+S24xHe/pK5xLJ8rDBATODqiTx/u86y1K8=;
        b=TPOjM4u73D+Oj6HxAwV4fdp6pDHFDKztxOKNV3DtBKL2vjxutQ1lG/GF4RGU9JBpZw
         KVRvI/9PKlVfVYN4SgLOPHRQrlbRHj3znQcdblo7CNko9BmDjqmrNTC15KILrzko/yZw
         wodQLl+Z1sySKfiFyJGJ1MYoFFBlxlhgiyJLIDiQOmGJ27nf7k5A4DwrYShqqJQ2EvRL
         acT2yyPDNriTrMfvdBVpO4Xug8qimgI61u0J8h9rV4awSRb2S+RMMFKvFWQ5Ny17zUqc
         L3tP4DGN/rdO20lHkMWDKz2r6znquGI5RBS12AXJvcY0FZA1JSlTTrzaAaYyJ2jCyHfr
         8hqQ==
X-Gm-Message-State: APjAAAUnr+LHHFqUIkhd350Ss0z8IGxNijN+5mgOWF3TbItq2fd488kk
        ZFJmDTvisiuaigVADHMlFj0dmHO6QON498g603K29U4bhqNkcS5CCaVIz+YQBq+WV6Wl8nyRc0H
        TEQAe+h7IP0IK5LCR9ozL2Eg0iVKl4IaGC1UIJlTsfmkpCZK6c5L5SIIoizKuq1c=
X-Google-Smtp-Source: APXvYqwR1eEFWZchXQVTc8o4LeZC2jhI2tgUtB+ThP7PO54x10kZgopLZkbiUyG8eg6bsJXXFB9OsGHym6YO8A==
X-Received: by 2002:a65:4505:: with SMTP id n5mr41274713pgq.301.1568420771538;
 Fri, 13 Sep 2019 17:26:11 -0700 (PDT)
Date:   Fri, 13 Sep 2019 17:26:00 -0700
In-Reply-To: <cover.1568419818.git.steadmon@google.com>
Message-Id: <bab45cb735ad658e6c838a9b2bdb9a8c74b9d179.1568419818.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [RFC PATCH v3 3/3] trace2: write overload message to sentinel files
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new "overload" event type for trace2 event destinations. Write
this event into the sentinel file created by the trace2.maxFiles
feature. Bump up the event format version since we've added a new event
type.

Writing this message into the sentinel file is useful for tracking how
often the overload protection feature is triggered in practice.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt | 17 ++++++++++--
 trace2/tr2_dst.c                       | 38 ++++++++++++++++++++++++--
 trace2/tr2_dst.h                       |  3 ++
 trace2/tr2_tgt_event.c                 | 21 ++++++++++++--
 trace2/tr2_tgt_normal.c                |  2 +-
 trace2/tr2_tgt_perf.c                  |  2 +-
 6 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 80ffceada0..ef26e47805 100644
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
@@ -610,11 +610,24 @@ only present on the "start" and "atexit" events.
 {
 	"event":"version",
 	...
-	"evt":"1",		       # EVENT format version
+	"evt":"2",		       # EVENT format version
 	"exe":"2.20.1.155.g426c96fcdb" # git version
 }
 ------------
 
+`"overload"`::
+	This event is created in a sentinel file if we are overloading a target
+	trace directory (see the trace2.maxFiles config option).
++
+------------
+{
+	"event":"overload",
+	...
+	"dir":"/trace/target/dir/", # The configured trace2 target directory
+	"evt":"2",		    # EVENT format version
+}
+------------
+
 `"start"`::
 	This event contains the complete argv received by main().
 +
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 414053d550..b72be57635 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -47,6 +47,38 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+/*
+ * Create a sentinel file to note that we don't want to create new trace files
+ * in this location. The form of the sentinel file may vary based on the
+ * destination type; the default is to create an empty file, but destination
+ * types can override this by providing an overload_writer function that accepts
+ * the filename, line number, and target path.
+ */
+static void tr2_create_sentinel(struct tr2_dst *dst, const char *dir,
+				const char *sentinel_path)
+{
+	int fd;
+
+	if (dst->overload_writer) {
+		fd = open(sentinel_path, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		if (fd != -1) {
+			dst->fd = fd;
+			/*
+			 * I don't think it's particularly useful to include the
+			 * file and line here, but we expect all trace messages
+			 * (at least for "event" destinations) to include them.
+			 * So I'm adding these for consistency's sake.
+			 */
+			dst->overload_writer(__FILE__, __LINE__, dir);
+			tr2_dst_trace_disable(dst);
+		}
+	} else
+		fd = creat(sentinel_path, 0666);
+
+	if (fd != -1)
+		close(fd);
+}
+
 /*
  * Check to make sure we're not overloading the target directory with too many
  * files. First get the threshold (if present) from the config or envvar. If
@@ -58,7 +90,7 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
  * from the target directory; after it removes the sentinel file we'll start
  * writing traces again.
  */
-static int tr2_dst_overloaded(const char *tgt_prefix)
+static int tr2_dst_overloaded(struct tr2_dst *dst, const char *tgt_prefix)
 {
 	int file_count = 0, max_files = 0, ret = 0;
 	const char *max_files_var;
@@ -97,7 +129,7 @@ static int tr2_dst_overloaded(const char *tgt_prefix)
 		closedir(dirp);
 
 	if (file_count >= tr2env_max_files) {
-		creat(sentinel_path.buf, 0666);
+		tr2_create_sentinel(dst, path.buf, sentinel_path.buf);
 		ret = 1;
 		goto cleanup;
 	}
@@ -126,7 +158,7 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 	strbuf_addstr(&path, sid);
 	base_path_len = path.len;
 
-	if (tr2_dst_overloaded(tgt_prefix)) {
+	if (tr2_dst_overloaded(dst, tgt_prefix)) {
 		strbuf_release(&path);
 		if (tr2_dst_want_warning())
 			warning("trace2: not opening %s trace file due to too "
diff --git a/trace2/tr2_dst.h b/trace2/tr2_dst.h
index 3adf3bac13..dd09a9541c 100644
--- a/trace2/tr2_dst.h
+++ b/trace2/tr2_dst.h
@@ -4,11 +4,14 @@
 struct strbuf;
 #include "trace2/tr2_sysenv.h"
 
+typedef void(tr2_dst_overload_writer_t)(const char *file, int line, const char *dir);
+
 struct tr2_dst {
 	enum tr2_sysenv_variable sysenv_var;
 	int fd;
 	unsigned int initialized : 1;
 	unsigned int need_close : 1;
+	tr2_dst_overload_writer_t *overload_writer;
 };
 
 /*
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index c2852d1bd2..68cb26fc67 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -10,7 +10,9 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0 };
+static void fn_overload_fl(const char *file, int line, const char *dir);
+
+static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, fn_overload_fl };
 
 /*
  * The version number of the JSON data generated by the EVENT target
@@ -19,7 +21,7 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0 };
  * to update this if you just add another call to one of the existing
  * TRACE2 API methods.
  */
-#define TR2_EVENT_VERSION "1"
+#define TR2_EVENT_VERSION "2"
 
 /*
  * Region nesting limit for messages written to the event target.
@@ -107,6 +109,21 @@ static void event_fmt_prepare(const char *event_name, const char *file,
 		jw_object_intmax(jw, "repo", repo->trace2_repo_id);
 }
 
+static void fn_overload_fl(const char *file, int line, const char *dir)
+{
+	const char *event_name = "overload";
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	event_fmt_prepare(event_name, file, line, NULL, &jw);
+	jw_object_string(&jw, "dir", dir);
+	jw_object_string(&jw, "evt", TR2_EVENT_VERSION);
+	jw_end(&jw);
+
+	tr2_dst_write_line(&tr2dst_event, &jw.json);
+	jw_release(&jw);
+}
+
 static void fn_version_fl(const char *file, int line)
 {
 	const char *event_name = "version";
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 00b116d797..ffca0d3811 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -9,7 +9,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0 };
+static struct tr2_dst tr2dst_normal = { TR2_SYSENV_NORMAL, 0, 0, 0, NULL };
 
 /*
  * Use the TR2_SYSENV_NORMAL_BRIEF setting to omit the "<time> <file>:<line>"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index ea0cbbe13e..0a91e8a1f6 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -11,7 +11,7 @@
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 
-static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0 };
+static struct tr2_dst tr2dst_perf = { TR2_SYSENV_PERF, 0, 0, 0, NULL };
 
 /*
  * Use TR2_SYSENV_PERF_BRIEF to omit the "<time> <file>:<line>"
-- 
2.23.0.237.gc6a4ce50a0-goog

