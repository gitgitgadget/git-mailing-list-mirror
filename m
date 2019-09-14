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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0331F463
	for <e@80x24.org>; Sat, 14 Sep 2019 00:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbfINA0K (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 20:26:10 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39907 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389329AbfINA0K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 20:26:10 -0400
Received: by mail-pl1-f202.google.com with SMTP id d11so17361584plo.6
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 17:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c/bJLwwvqxyjaO0SVJCh6eW1+SYv8Mf4syUbYpEhCbo=;
        b=RWY4vqP5YSd/+ksTbhM7ttun/yppXEzWkGlcPjVsDa12A2jUzsFCnF+J+0QzzMD5Bq
         LzXjwE/toUaPwztZsSnL7eJ4tWOaoctaAfvvhWDr4U5QM0p2QkRLKYORjcYZkUY5pdzB
         H9ACT3fSTsyw202RQERobRZ/Cz0Kg2DiQZy9XUVEPy1kyn0BENRHFaTH43S4Hm4T5UOq
         IyB3MLDnAjOX8v1kJjoI85p4o/X4NPOidIxVotfQzTWiP9AMhB5Rz1PwKesxia58vi94
         hsjkuc2iKU5K0GJXYUMYum34WtI6K3ADRMrlpoE2GlcyRu05R/eKCGJ8S9JO8/OzhSsp
         pOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c/bJLwwvqxyjaO0SVJCh6eW1+SYv8Mf4syUbYpEhCbo=;
        b=Lbk3Iup1zwQX0EGAoIH5lqBr5eqcAjwaTb0aUhkwrpsTuGT624ZVNRNpdm/viFueHT
         +QRviPFKGQssUP6Z4ZBwQVjZmsO6+xxjrZY6PuNveTzfl7HtNUbZVl7X8EJ/g6Np/Zsl
         fG37SrbgcJQr/AAoTxdA/Z7+zImkIX57JGISTYLx/vwMSAxM7Bk2tY9e/yK/0vJY6Dsj
         qFkvggW0Hd1ctp9s1mZJhap2c8KbCYZwfxfU0PPvNAIm6vHA37rMbxUY+bKxEoSzzx5G
         nJCFV4OCR8fnK0HZA2lrzcZeC0tC+WFgbceb84rq0lljhQgeIkZHGRVcMbB+iLETfe9M
         AcTw==
X-Gm-Message-State: APjAAAUyoI9EnogoVK0ZTKFYzOy257hnj4syLHls6ARk+/A2ipWO3iYd
        ZZkAGn8sD+osT9toWaHtyiDNUwV5rIr/zefOJTu2EqGtGTdNf/quUWGU/IgnxMnK31NaAShtej3
        2FRyUeSobArViyWUC65vt2NkcIJJD6CKf7FFbpB4a8ouhd/rcXC+Se8FjEdChoGA=
X-Google-Smtp-Source: APXvYqxhO9fgk89zT4sGUPBK7qoFeY00FPigRuwrVu6CcLiLu2JlFbGflKaVl38C50jpLnC0tXhcqNh7dZKUfg==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr46506155pgi.70.1568420768961;
 Fri, 13 Sep 2019 17:26:08 -0700 (PDT)
Date:   Fri, 13 Sep 2019 17:25:59 -0700
In-Reply-To: <cover.1568419818.git.steadmon@google.com>
Message-Id: <bf20ec8ea25ae80ee32d2867fa168c94fbe07d29.1568419818.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1568419818.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [RFC PATCH v3 2/3] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

trace2 can write files into a target directory. With heavy usage, this
directory can fill up with files, causing difficulty for
trace-processing systems.

This patch adds a config option (trace2.maxFiles) to set a maximum
number of files that trace2 will write to a target directory. The
following behavior is enabled when the maxFiles is set to a positive
integer:
  When trace2 would write a file to a target directory, first check
  whether or not the directory is overloaded. A directory is overloaded
  if there is a sentinel file declaring an overload, or if the number of
  files exceeds trace2.maxFiles. If the latter, create a sentinel file
  to speed up later overload checks.

The assumption is that a separate trace-processing system is dealing
with the generated traces; once it processes and removes the sentinel
file, it should be safe to generate new trace files again.

The default value for trace2.maxFiles is zero, which disables the
overload check.

The config can also be overridden with a new environment variable:
GIT_TRACE2_MAX_FILES.

Potential future work:
* Write a message into the sentinel file (should match the requested
  trace2 output format).
* Add a performance test to make sure that contention between multiple
  processes all writing to the same target directory does not become an
  issue.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/config/trace2.txt |  6 +++
 t/t0212-trace2-event.sh         | 17 +++++++
 trace2/tr2_dst.c                | 86 +++++++++++++++++++++++++++++++++
 trace2/tr2_sysenv.c             |  3 ++
 trace2/tr2_sysenv.h             |  2 +
 5 files changed, 114 insertions(+)

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 2edbfb02fe..4ce0b9a6d1 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -54,3 +54,9 @@ trace2.destinationDebug::
 	By default, these errors are suppressed and tracing is
 	silently disabled.  May be overridden by the
 	`GIT_TRACE2_DST_DEBUG` environment variable.
+
+trace2.maxFiles::
+	Integer.  When writing trace files to a target directory, do not
+	write additional traces if we would exceed this many files. Instead,
+	write a sentinel file that will block further tracing to this
+	directory. Defaults to 0, which disables this check.
diff --git a/t/t0212-trace2-event.sh b/t/t0212-trace2-event.sh
index ff5b9cc729..2ff97e72da 100755
--- a/t/t0212-trace2-event.sh
+++ b/t/t0212-trace2-event.sh
@@ -265,4 +265,21 @@ test_expect_success JSON_PP 'using global config, event stream, error event' '
 	test_cmp expect actual
 '
 
+test_expect_success "don't overload target directory" '
+	mkdir trace_target_dir &&
+	test_when_finished "rm -r trace_target_dir" &&
+	(
+		GIT_TRACE2_MAX_FILES=5 &&
+		export GIT_TRACE2_MAX_FILES &&
+		cd trace_target_dir &&
+		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
+		xargs touch <../expected_filenames.txt &&
+		cd .. &&
+		GIT_TRACE2_EVENT="$(pwd)/trace_target_dir" test-tool trace2 001return 0
+	) &&
+	echo git-trace2-overload >>expected_filenames.txt &&
+	ls trace_target_dir >ls_output.txt &&
+	test_cmp expected_filenames.txt ls_output.txt
+'
+
 test_done
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5dda0ca1cd..414053d550 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,3 +1,5 @@
+#include <dirent.h>
+
 #include "cache.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
@@ -8,6 +10,19 @@
  */
 #define MAX_AUTO_ATTEMPTS 10
 
+/*
+ * Sentinel file used to detect when we're overloading a directory with too many
+ * trace files.
+ */
+#define OVERLOAD_SENTINEL_NAME "git-trace2-overload"
+
+/*
+ * When set to zero, disables directory overload checking. Otherwise, controls
+ * how many files we can write to a directory before entering overload mode.
+ * This can be overridden via the TR2_SYSENV_MAX_FILES setting.
+ */
+static int tr2env_max_files = 0;
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -32,6 +47,67 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+/*
+ * Check to make sure we're not overloading the target directory with too many
+ * files. First get the threshold (if present) from the config or envvar. If
+ * it's zero or unset, disable this check.  Next check for the presence of a
+ * sentinel file, then check file count. If we are overloaded, create the
+ * sentinel file if it doesn't already exist.
+ *
+ * We expect that some trace processing system is gradually collecting files
+ * from the target directory; after it removes the sentinel file we'll start
+ * writing traces again.
+ */
+static int tr2_dst_overloaded(const char *tgt_prefix)
+{
+	int file_count = 0, max_files = 0, ret = 0;
+	const char *max_files_var;
+	DIR *dirp;
+	struct strbuf path = STRBUF_INIT, sentinel_path = STRBUF_INIT;
+	struct stat statbuf;
+
+	strbuf_addstr(&path, tgt_prefix);
+	if (!is_dir_sep(path.buf[path.len - 1])) {
+		strbuf_addch(&path, '/');
+	}
+
+	/* Get the config or envvar and decide if we should continue this check */
+	max_files_var = tr2_sysenv_get(TR2_SYSENV_MAX_FILES);
+	if (max_files_var && *max_files_var && ((max_files = atoi(max_files_var)) >= 0))
+		tr2env_max_files = max_files;
+
+	if (!tr2env_max_files) {
+		ret = 0;
+		goto cleanup;
+	}
+
+	/* check sentinel */
+	strbuf_addbuf(&sentinel_path, &path);
+	strbuf_addstr(&sentinel_path, OVERLOAD_SENTINEL_NAME);
+	if (!stat(sentinel_path.buf, &statbuf)) {
+		ret = 1;
+		goto cleanup;
+	}
+
+	/* check file count */
+	dirp = opendir(path.buf);
+	while (file_count < tr2env_max_files && dirp && readdir(dirp))
+		file_count++;
+	if (dirp)
+		closedir(dirp);
+
+	if (file_count >= tr2env_max_files) {
+		creat(sentinel_path.buf, 0666);
+		ret = 1;
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&path);
+	strbuf_release(&sentinel_path);
+	return ret;
+}
+
 static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 {
 	int fd;
@@ -50,6 +126,16 @@ static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
 	strbuf_addstr(&path, sid);
 	base_path_len = path.len;
 
+	if (tr2_dst_overloaded(tgt_prefix)) {
+		strbuf_release(&path);
+		if (tr2_dst_want_warning())
+			warning("trace2: not opening %s trace file due to too "
+				"many files in target directory %s",
+				tr2_sysenv_display_name(dst->sysenv_var),
+				tgt_prefix);
+		return 0;
+	}
+
 	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
 		if (attempt_count > 0) {
 			strbuf_setlen(&path, base_path_len);
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index 5958cfc424..3c3792eca2 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -49,6 +49,9 @@ static struct tr2_sysenv_entry tr2_sysenv_settings[] = {
 				       "trace2.perftarget" },
 	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TRACE2_PERF_BRIEF",
 				       "trace2.perfbrief" },
+
+	[TR2_SYSENV_MAX_FILES]     = { "GIT_TRACE2_MAX_FILES",
+				       "trace2.maxfiles" },
 };
 /* clang-format on */
 
diff --git a/trace2/tr2_sysenv.h b/trace2/tr2_sysenv.h
index 8dd82a7a56..d4364a7b85 100644
--- a/trace2/tr2_sysenv.h
+++ b/trace2/tr2_sysenv.h
@@ -24,6 +24,8 @@ enum tr2_sysenv_variable {
 	TR2_SYSENV_PERF,
 	TR2_SYSENV_PERF_BRIEF,
 
+	TR2_SYSENV_MAX_FILES,
+
 	TR2_SYSENV_MUST_BE_LAST
 };
 
-- 
2.23.0.237.gc6a4ce50a0-goog

