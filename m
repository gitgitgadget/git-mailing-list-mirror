Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F6120248
	for <e@80x24.org>; Thu, 21 Mar 2019 21:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfCUVJ7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 17:09:59 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:37853 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCUVJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 17:09:59 -0400
Received: by mail-vk1-f202.google.com with SMTP id u9so124153vke.4
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=M1ioYCGKaNZ2WJdD6vkP694Njemi4tZjghRZmG0/8qA=;
        b=p/EPktqtEqJ8wAvPlOLiB4iNwyXDQlpm81uwj5b0mARSdmAYPZEpte13X6QBEOoe/c
         RZq9MKeoeMVlBTgXysgH5Fv/Rfd2+cvyvOMzcoKEv6+zaVeIk60AIdgTYrAnBol8GXLd
         xDyMGigrVqXNNfnsaNdX6KEzKcxzAsBEtbpQdmNyU1mQ3qHr8mRvC3YnAVG09YsKZtK9
         f41/8dp+8EeEQa87OEEOulheJWpd/6lIaWwiuXlDvvQEZnV84Yu/0fVuruN+XhfST+MN
         H/SriReprTjkc1G9xoXmnrxPDK3Hu1HTh8e9/ktfKo/SeFM2mtpoRgpdJg+N3bPA3zMo
         dFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=M1ioYCGKaNZ2WJdD6vkP694Njemi4tZjghRZmG0/8qA=;
        b=dbctI1T54le9BIXtfUTgCMH2Dn/nqUg+PF72AAq7W4078dLBrvv+8OXIsezU0PRvbP
         PvvOJRH/jPoSI/YOE/4noxAl2dCyv6C4/kHPo4mqkAQ3MTbtIQxfadJYCkiuCdkQ/nei
         TvvyyGExDpZBCbPVtHIXNAeDh+sAbZPiFYuK9w1hAMEZ2bGKJhv3y0HeY7oia76a1yom
         SGNvnXyiihxTsxlkncGi3DzDOhMqkpl4sMMyRlvlRnDFQCH0XzAte9Ch4UteBD6mBcBE
         j+5rIC8LitCydf3lAWtkuTWgbAZstm08bLFxcxTSny2QA1YsVsKMmT1qwcvmXuhl8eRL
         4Pzw==
X-Gm-Message-State: APjAAAVwOF2yuLfiOcq84ngMqqJkTAq1/ec0VUGxNAoyufu6WTtIwZV2
        DfgdIbGqt9i4Pq7Rl8hEkqQLQ4v0O25VtRSgHQNeiEBgPCF8NiwzX0tyQCUo4emKS3KI+AHhYWA
        SVhar20FIWV40GnV7k+YVRGMCY+xAG0d8lnprXAeApFnL0i3Z6qmKSM3TyvNA/dc=
X-Google-Smtp-Source: APXvYqwEeoKsi3LMIKi+P1opgvd6sHNryHDPxxYvfrnun3oAEMtVsp6IZMkXsRBeugSPRCRH8y4CzJQx5q4uVA==
X-Received: by 2002:a67:1646:: with SMTP id 67mr3458486vsw.19.1553202597367;
 Thu, 21 Mar 2019 14:09:57 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:09:51 -0700
In-Reply-To: <cover.1553202340.git.steadmon@google.com>
Message-Id: <ce5258610ffbc2e498ff33336c5c89b69468d4fd.1553202340.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1552519463.git.steadmon@google.com> <cover.1553202340.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH v3 1/1] trace2: write to directory targets
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the value of a trace2 environment variable is an absolute path
referring to an existing directory, write output to files (one per
process) underneath the given directory. Files will be named according
to the final component of the trace2 SID, followed by a counter to avoid
potential collisions.

This makes it more convenient to collect traces for every git invocation
by unconditionally setting the relevant trace2 envvar to a constant
directory name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/technical/api-trace2.txt |  5 ++
 t/t0210-trace2-normal.sh               | 15 ++++++
 trace2/tr2_dst.c                       | 63 +++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 2de565fa3d..d0948ba250 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -109,6 +109,11 @@ values are recognized.
 
 	Enables the target, opens and writes to the file in append mode.
 
+	If the target already exists and is a directory, the traces will be
+	written to files (one per process) underneath the given directory. They
+	will be named according to the last component of the SID (optionally
+	followed by a counter to avoid filename collisions).
+
 `af_unix:[<socket_type>:]<absolute-pathname>`::
 
 	Enables the target, opens and writes to a Unix Domain Socket
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 03a0aedb1d..819430658b 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -80,6 +80,21 @@ test_expect_success 'normal stream, return code 1' '
 	test_cmp expect actual
 '
 
+test_expect_success 'automatic filename' '
+	test_when_finished "rm -r traces actual expect" &&
+	mkdir traces &&
+	GIT_TR2="$(pwd)/traces" test-tool trace2 001return 0 &&
+	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
+	cat >expect <<-EOF &&
+		version $V
+		start _EXE_ trace2 001return 0
+		cmd_name trace2 (trace2)
+		exit elapsed:_TIME_ code:0
+		atexit elapsed:_TIME_ code:0
+	EOF
+	test_cmp expect actual
+'
+
 # Verb 002exit
 #
 # Explicit exit(code) from within cmd_<verb> propagates <code>.
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index fd490a43ad..c3d82ca6a4 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "trace2/tr2_dst.h"
+#include "trace2/tr2_sid.h"
 
 /*
  * If a Trace2 target cannot be opened for writing, we should issue a
@@ -12,6 +13,11 @@
  */
 #define TR2_ENVVAR_DST_DEBUG "GIT_TR2_DST_DEBUG"
 
+/*
+ * How many attempts we will make at creating an automatically-named trace file.
+ */
+#define MAX_AUTO_ATTEMPTS 10
+
 static int tr2_dst_want_warning(void)
 {
 	static int tr2env_dst_debug = -1;
@@ -36,6 +42,55 @@ void tr2_dst_trace_disable(struct tr2_dst *dst)
 	dst->need_close = 0;
 }
 
+static int tr2_dst_try_auto_path(struct tr2_dst *dst, const char *tgt_prefix)
+{
+	int fd;
+	const char *last_slash, *sid = tr2_sid_get();
+	struct strbuf path = STRBUF_INIT;
+	size_t base_path_len;
+	unsigned attempt_count;
+
+	last_slash = strrchr(sid, '/');
+	if (last_slash)
+		sid = last_slash + 1;
+
+	strbuf_addstr(&path, tgt_prefix);
+	if (!is_dir_sep(path.buf[path.len - 1]))
+		strbuf_addch(&path, '/');
+	strbuf_addstr(&path, sid);
+	base_path_len = path.len;
+
+	for (attempt_count = 0; attempt_count < MAX_AUTO_ATTEMPTS; attempt_count++) {
+		if (attempt_count > 0) {
+			strbuf_setlen(&path, base_path_len);
+			strbuf_addf(&path, ".%d", attempt_count);
+		}
+
+		fd = open(path.buf, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		if (fd != -1)
+			break;
+	}
+
+	if (fd == -1) {
+		if (tr2_dst_want_warning())
+			warning("trace2: could not open '%.*s' for '%s' tracing: %s",
+				(int) base_path_len, path.buf,
+				dst->env_var_name, strerror(errno));
+
+		tr2_dst_trace_disable(dst);
+		strbuf_release(&path);
+		return 0;
+	}
+
+	strbuf_release(&path);
+
+	dst->fd = fd;
+	dst->need_close = 1;
+	dst->initialized = 1;
+
+	return dst->fd;
+}
+
 static int tr2_dst_try_path(struct tr2_dst *dst, const char *tgt_value)
 {
 	int fd = open(tgt_value, O_WRONLY | O_APPEND | O_CREAT, 0666);
@@ -202,8 +257,12 @@ int tr2_dst_get_trace_fd(struct tr2_dst *dst)
 		return dst->fd;
 	}
 
-	if (is_absolute_path(tgt_value))
-		return tr2_dst_try_path(dst, tgt_value);
+	if (is_absolute_path(tgt_value)) {
+		if (is_directory(tgt_value))
+			return tr2_dst_try_auto_path(dst, tgt_value);
+		else
+			return tr2_dst_try_path(dst, tgt_value);
+	}
 
 #ifndef NO_UNIX_SOCKETS
 	if (starts_with(tgt_value, PREFIX_AF_UNIX))
-- 
2.21.0.225.g810b269d1ac-goog

