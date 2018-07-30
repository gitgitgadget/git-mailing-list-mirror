Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418301F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbeG3Nw7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 09:52:59 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:53792 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeG3Nw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 09:52:59 -0400
Received: by mail-oi0-f73.google.com with SMTP id v205-v6so10743867oie.20
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/piUim2p74jw0sV4LsKseKpof8P1UZipdUBv4srb7rg=;
        b=C6OKhf5oqZEXVhpfCscwxRSLUuoqA2V3t9HHArRlJgR/Q1ifevtat4C0MfSZepg8lI
         yH3ZJNiE4erQFetG4iAnLE1S4Ws8f8ytyIBC6UFGEb+4/2tFuHGnyGTVTilBTlaZcgE9
         fbo9utBrKMpICcsTaQ1z964N+hDhfeE15SeD+nJIAyLSzC8fFKWKVNHDOF9zchkb7CD/
         GYOnJdSag7CC1uWk1+Z0wprLSURvkD/qcsyw38y7k6WBYNeaE7FVufB11TXsZ8vsQ394
         liihnQDfC9owgNHFzwnFpDow3aQb0tE6BD1kVvEnbfkU2CojaE5k1jLBcHqO+bu2qsuD
         Lgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/piUim2p74jw0sV4LsKseKpof8P1UZipdUBv4srb7rg=;
        b=lc06RCudgTWAbVRU3TBC476QiP4J01JYvuX8MpyZ75mb7aT5gFBbgqSvGEgZ9SIq5o
         /cgFg9F9GfF3OctliovahSxWDWIUtqTmkQvLJBkRucIaJwOqV+aunp9ZOm/iw8+JwdiY
         2BoBAIB/zE6zmYOhQdMrDzs7KhD9oQqcQ1agVdoV0Yl7XrJ8x7rCaygkcTY2hsj9C4PY
         0L6MCXUJ+G2MTIyyAoEV5q+95lcwFPZ84OgspCZ1m/NWUfYvdVacakZtTa7wiHJfeRpO
         p8cFyAv/D1miqMzD7q013Pajdg3in8p3xBmDYFQYrgynO0p0cJ0dcCxBPPb1YhTO3eCE
         Z79Q==
X-Gm-Message-State: AOUpUlEJolPphCoDWuURTVtiHl0FlqVJ5yujKDtzZdcJsgjbLMn5RDuS
        08gGVcEhVh/Spr2P05qmJV3G6s05LkcFlolbmj8GJ4jhHu9X+5Jt1kbVDaGNAQpn2iaP8Ob9HR8
        Ro9SjEDc4r5sQaqwHaS3O4zm5BapZ3ycY/uc3Mt1+l5/Zl6u3cNPAzWDRpg==
X-Google-Smtp-Source: AAOMgpdDg66EyPPKWOF48N829aWDuvBEqVsXZ17Ewm3XW7XSFMTZABSYdlCZMEwNO4ifVvp17XIqq2UouD0=
X-Received: by 2002:aca:b8d5:: with SMTP id i204-v6mr11685492oif.46.1532953095849;
 Mon, 30 Jul 2018 05:18:15 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:18:01 +0200
In-Reply-To: <20180730121801.53727-1-hanwen@google.com>
Message-Id: <20180730121801.53727-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180730121801.53727-1-hanwen@google.com>
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
Change-Id: I090412a1288bc2caef0916447e28c2d0199da47d
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

