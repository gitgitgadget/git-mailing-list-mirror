Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904D41F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbeG3OBD (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:01:03 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:55587 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeG3OBD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:01:03 -0400
Received: by mail-it0-f73.google.com with SMTP id e21-v6so12402217itc.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5GqTw0P82KTORW/he5LW6UDeNbjwaKfU/u4Q+H7zbNo=;
        b=pMXDXWKoXzOXNs7jcvjBOklPgG8Eytky23h4+c8V8lwguIi3Ba8kx3RtVfb/ZWuMZG
         HoWewh8QMqjO+T0s64VryzcaGpBdcHP8OHvYzU39ahznPV5CUti/Lffmsm4325Uid4Xh
         TIOYZkV3I8Uk48WGCeY43virg8z8P8mGSKICHXOLVd994edueSr1RacVibWn0llD+Ypo
         SJCt2VQH0hudrEBKXLPNIitK9y4MIoMsxugaUlh5rRTwlo9g/w6RPjObcUmh1AglC8Ck
         dlehCnIxdE9FYOCydMKYpn0dhGM/J2xM96FF5h6Jz7fjvi02cgsCbMqbVzcL54iC/PjL
         6bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5GqTw0P82KTORW/he5LW6UDeNbjwaKfU/u4Q+H7zbNo=;
        b=TIMjkTRuFR+zyCJ4ngSVnDnZge3VQOkVqZdsNiWf/UP2V9/OCn6wQ0TpLlU2wENmhQ
         YQTGrdk+Bbb86qWFjCfjGzEgdNNxhU+S3cyQqewUgIQhneGYMfJGunhCmpBEPwu0tlV6
         2U3TkihJ60rYc8gdYd7uDaLN/P3aQctp7a3rbC9YaFmWOfp3zwvhEoQQkkxeCGogztMd
         fgEjd2fb0+6oMq4jzLY209hIQPFUI4o/yUHcG68L+vke8bT0lyR9OAzXxiCzCGtE5Vqs
         P51cO/jzS71NllYoCA9BJFLYgmxrXetkwao4jWMvPyv5SXUWEVq24bOXcCdcf+uhy0e5
         NhLQ==
X-Gm-Message-State: AOUpUlEf4v3UEAr+EiQs0e9Md9EUCDL98bAeo6fvMsn6OKa3lwGF+K+w
        PFqWJVWbjFvNBT5C3S8z3KQnXkSllhzZFd8pWCed28AnwQAZk+YNX7FXgdVDTWJN+PlEbcL1rx6
        68GBrFZARdTxsoZmshI3iXUvfJMZi9b8tBI4d0tNQ8c80zjuuqdMcPmfBDg==
X-Google-Smtp-Source: AAOMgpeuP3tlZfuMP/W7Na+gPLQc5DEYEK9y0dZcBXL3GKo1WndNSh6ZM4eXYgXWnRvq27gBBs7J7yc6bTI=
X-Received: by 2002:a24:5c8f:: with SMTP id q137-v6mr7731738itb.38.1532953578162;
 Mon, 30 Jul 2018 05:26:18 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:26:09 +0200
In-Reply-To: <20180730122609.57058-1-hanwen@google.com>
Message-Id: <20180730122609.57058-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180730122609.57058-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 2/2] Highlight keywords in remote sideband output.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The highlighting is done on the client-side. Supported keywords are
"error", "warning", "hint" and "success".

The colorization is controlled with the config setting "color.remote".

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 sideband.c                          | 79 +++++++++++++++++++++++++----
 t/t5409-colorize-remote-messages.sh | 34 +++++++++++++
 2 files changed, 104 insertions(+), 9 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

diff --git a/sideband.c b/sideband.c
index 325bf0e97..15213a7c1 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,63 @@
 #include "cache.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "color.h"
+
+static int sideband_use_color = -1;
+
+/*
+ * Optionally highlight some keywords in remote output if they appear at the
+ * start of the line.
+ */
+void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	if (sideband_use_color < 0) {
+		const char *key = "color.remote";
+		char *value = NULL;
+		if (!git_config_get_string(key, &value))
+			sideband_use_color = git_config_colorbool(key, value);
+	}
+
+	int want_color = want_color_stderr(sideband_use_color);
+	int i;
+
+	if (!want_color) {
+		strbuf_add(dest, src, n);
+		return;
+	}
+
+	struct kwtable {
+		const char *keyword;
+		const char *color;
+	} keywords[] = {
+		{"hint", GIT_COLOR_YELLOW},
+		{"warning", GIT_COLOR_BOLD_YELLOW},
+		{"success", GIT_COLOR_BOLD_GREEN},
+		{"error", GIT_COLOR_BOLD_RED},
+	};
+
+	while (isspace(*src)) {
+		strbuf_addch(dest, *src);
+		src++;
+		n--;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(keywords); i++) {
+		struct kwtable* p = keywords + i;
+		int len = strlen(p->keyword);
+		if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
+			strbuf_addstr(dest, p->color);
+			strbuf_add(dest, src, len);
+			strbuf_addstr(dest, GIT_COLOR_RESET);
+			n -= len;
+			src += len;
+			break;
+		}
+	}
+
+	strbuf_add(dest, src, n);
+}
+

 /*
  * Receive multiplexed output stream over git native protocol.
@@ -48,8 +105,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+				    DISPLAY_PREFIX);
+			maybe_colorize_sideband(&outbuf, buf + 1, len);
+
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -69,20 +128,22 @@ int recv_sideband(const char *me, int in_stream, int out)
 				if (!outbuf.len)
 					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
-					strbuf_addf(&outbuf, "%.*s%s%c",
-						    linelen, b, suffix, *brk);
-				} else {
-					strbuf_addch(&outbuf, *brk);
+					maybe_colorize_sideband(&outbuf, b, linelen);
+					strbuf_addstr(&outbuf, suffix);
 				}
+
+				strbuf_addch(&outbuf, *brk);
 				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);

 				b = brk + 1;
 			}

-			if (*b)
-				strbuf_addf(&outbuf, "%s%s", outbuf.len ?
-					    "" : DISPLAY_PREFIX, b);
+			if (*b) {
+				strbuf_addstr(&outbuf, outbuf.len ?
+					    "" : DISPLAY_PREFIX);
+				maybe_colorize_sideband(&outbuf, b, strlen(b));
+			}
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
diff --git a/t/t5409-colorize-remote-messages.sh b/t/t5409-colorize-remote-messages.sh
new file mode 100644
index 000000000..1620cffbe
--- /dev/null
+++ b/t/t5409-colorize-remote-messages.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='remote messages are colorized on the client'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir .git/hooks &&
+        cat << EOF > .git/hooks/update &&
+#!/bin/sh
+echo error: error
+echo hint: hint
+echo success: success
+echo warning: warning
+exit 0
+EOF
+	chmod +x .git/hooks/update &&
+	echo 1 >file &&
+	git add file &&
+	git commit -m 1 &&
+        git clone . child &&
+        cd child &&
+        echo 2 > file &&
+        git commit -a -m 2
+'
+
+test_expect_success 'push' 'git -c color.remote push origin HEAD:refs/heads/newbranch 2>output &&
+  test_decode_color < output > decoded &&
+  test_i18ngrep "<BOLD;RED>error<RESET>:" decoded &&
+  test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
+  test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
+  test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded'
+
+test_done
--
2.18.0.345.g5c9ce644c3-goog
