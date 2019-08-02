Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD231F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391127AbfHBWCp (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:02:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:46691 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfHBWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:02:44 -0400
Received: by mail-pg1-f202.google.com with SMTP id u1so48281763pgr.13
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2nvzli2+AG8nV+i2/VSeU8WLCss/Hv1HK0yt91njdow=;
        b=ckI2oSwloyvrBeRbLZ7Xd2CBQtlTCSjsGwuLUDIswbPbJlQhBVohTbtbrziuDGG9q6
         iwesImQXdJghXDslO+cYaIAbvh23GFT3rGdBzxfmWXai7LE0/tSHGCg6LO5v1/PmULyf
         Nzl1Gp+8nQLJTKwp/zgBDHxW16QVEV1LOM71f6TWmBnh2kx9kNy/5st6/aEROj0B7Fok
         6T772WjRtE/jCJ2VSmt22kVMVVikk1+wNNQa+xXhugSun5uNUOeXWSk4BDeGY7FoS2cY
         vzDzyzRrQmEdcOEEDIBtmaDeFuXLESLDfgT5FghjmvoppEsBpPF8i/Zl5E87oRBZFc9R
         Myxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2nvzli2+AG8nV+i2/VSeU8WLCss/Hv1HK0yt91njdow=;
        b=H7ytVAaB0RSWn1hfBez5DIOM86thYtKEBCU1onHoQZV7vyO3urJQNsvsnf4bssM39q
         d0fGgeBoyOBE6vvOOneOxaQKl3v+FvgHZGwghe1Saj69xvMaXDQDvfkIM3P1gHMYuhA2
         /V+Gt7EpR1wK6nQpMK4hPZVan5lKT0lA0nG0S58lajlXdM6wQcxYUE6fgVRgZdUUvWv6
         APi+RJnoo6tQxgV0wCXQQ9oadtl16sEaznXbTGDIGrOB34MRzipThU7HKxvi2R0fQjlu
         P275gE55ZcGu9O4+D3KcAON2ABT9iC62Unxn2deLz3EMjDuIlQCjiJ89Cr1Xo8w5opiV
         eOWA==
X-Gm-Message-State: APjAAAUCW7586I8b1U6RGCqgpJydgXgvNQ9/NUiRoQPjI/m3Iu1tzYwK
        yb513U9qDY4H2EJzcdZUZRoTJ0S2NS3OZlOtYsiP9bCKPAEKxVHC9T9m/8YPMEgwZHFhJp/4mGJ
        yvSnwdXKRTimEfo58xd5peb+BQUNgNVL8AgnVdfy3Zd4g3Sib/e2ILCQybaa531g=
X-Google-Smtp-Source: APXvYqxmLYD71m2rDr8E60wTLpER5vQ6wKhAWFthpynDDySUHEqs03iR7I4Hk2qEKDIPZuO8J3mOFRBeFM+Ycg==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr118481393pgc.248.1564783363139;
 Fri, 02 Aug 2019 15:02:43 -0700 (PDT)
Date:   Fri,  2 Aug 2019 15:02:35 -0700
In-Reply-To: <cover.1564771000.git.steadmon@google.com>
Message-Id: <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
Mime-Version: 1.0
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [RFC PATCH v2 2/2] trace2: don't overload target directories
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, git@jeffhostetler.com
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
 t/t0210-trace2-normal.sh        | 19 ++++++++
 trace2/tr2_dst.c                | 86 +++++++++++++++++++++++++++++++++
 trace2/tr2_sysenv.c             |  3 ++
 trace2/tr2_sysenv.h             |  2 +
 5 files changed, 116 insertions(+)

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
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ce7574edb1..59b9560109 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -186,4 +186,23 @@ test_expect_success 'using global config with include' '
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
+		ls trace_target_dir >first_ls_output.txt &&
+		test_cmp expected_filenames.txt first_ls_output.txt &&
+		GIT_TRACE2="$(pwd)/trace_target_dir" test-tool trace2 001return 0
+	) &&
+	echo git-trace2-overload >>expected_filenames.txt &&
+	ls trace_target_dir >second_ls_output.txt &&
+	test_cmp expected_filenames.txt second_ls_output.txt
+'
+
 test_done
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 5dda0ca1cd..40ec03c2d7 100644
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
+	strbuf_addstr(&sentinel_path, path.buf);
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
+		creat(sentinel_path.buf, S_IRUSR | S_IWUSR);
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
2.22.0.770.g0f2c4a37fd-goog

