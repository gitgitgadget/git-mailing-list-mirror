Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BA31F597
	for <e@80x24.org>; Mon, 30 Jul 2018 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeG3OI3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 10:08:29 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:54995 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbeG3OI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 10:08:29 -0400
Received: by mail-qt0-f201.google.com with SMTP id d1-v6so10249876qth.21
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Efggud+4d3Xpu5EpzieFsSNa1wh1aWpxgNKkDidtyVA=;
        b=dLRViHn+yvdwkhtqOtmDDUNaWaa7R9c6eWSggTIesxxkO/w1ipW1h0vUkYtbrV8I+M
         MCiOUR2aPkkks2d5B63DcOKVB2GXV3N4nq0q+KJwAM6eJLESN//6bYAskaLFVMFaLrjd
         XVqNCEAeGCB62I8MWDWKlXnqAKBgMMICn+Vnm0tuvQqk9uN0mwZRI6LiYif7595dXBWS
         jjsWaxQGdviFlwH5E+7hnXs1JCvnSyiTl+uizJWFTNr4pFN0e3mdyNW9ayOmwkGKBWwN
         vXVCopoRh+p1VNyLoR1E1XyDKFxil3SO0p0qPgyiQPCjlo4EMm9XP6uHDO6qlWh3rUyw
         9F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Efggud+4d3Xpu5EpzieFsSNa1wh1aWpxgNKkDidtyVA=;
        b=bSa5QzBe399bguKH3vBWbtZC6ry3fcMb9+755ndDZkaolfF52yds1bQRhDOz7R4FZH
         VQDOFLL9Zlk/i0fePt5ly+6kwdrnUCXBRckT51jofBTTVJDbzr3M5QVC6GcJ9C2BftEk
         ghgqNDuGuxB/0atxYBi88XwYbGxNOjB6BwmuCeosQJpJ49qbbuNGbp46j8OArmVaKACL
         AHuVn0hqyZcD/YQYT/tpaetidpm9Nks8lyMX8PZJmw/tMfW5CbgyP9/FrCc82XQbj6Ea
         P1VPsCw1AW4owc58bQMMfZpX3R4hlASEbDtOykTva7OHrJ891uYDyMnUTTI1TyYJWzhK
         VXlA==
X-Gm-Message-State: AOUpUlEelLj3PWezSgmsIHrVq0wyFTzT90tL/u3/ibkYdQxSQMgdJ3LF
        LmVXSvPIxyzvSAXafXAZWqw4+J/Mun6PCMOykExOYBfUrYf5bwdTPTBg0E7NMkyqV20tu33RuhW
        +PWsyX8npxZRkivMOUUmxJXmoEWseECS9kAerS8HMvMz/txffUfBzj0AmPQ==
X-Google-Smtp-Source: AAOMgpfVJkCy3eYLO6ic9Yu/AqBpIGSqTyr6DJhyMLzOqggzMlZUSsm8AJos29nUsduwXCbQpkQG7Z7bI9I=
X-Received: by 2002:a0c:e801:: with SMTP id y1-v6mr9360168qvn.55.1532954022312;
 Mon, 30 Jul 2018 05:33:42 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:33:34 +0200
In-Reply-To: <20180730123334.65186-1-hanwen@google.com>
Message-Id: <20180730123334.65186-2-hanwen@google.com>
Mime-Version: 1.0
References: <20180730123334.65186-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 1/1] Highlight keywords in remote sideband output.
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
 sideband.c                          | 78 +++++++++++++++++++++++++----
 t/t5409-colorize-remote-messages.sh | 34 +++++++++++++
 2 files changed, 103 insertions(+), 9 deletions(-)
 create mode 100644 t/t5409-colorize-remote-messages.sh

diff --git a/sideband.c b/sideband.c
index 325bf0e97..e939cd436 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,7 +1,63 @@
 #include "cache.h"
+#include "color.h"
+#include "config.h"
 #include "pkt-line.h"
 #include "sideband.h"

+
+/*
+ * Optionally highlight some keywords in remote output if they appear at the
+ * start of the line.
+ */
+void maybe_colorize_sideband(struct strbuf *dest, const char *src, int n)
+{
+	static int sideband_use_color = -1;
+	int i;
+	if (sideband_use_color < 0) {
+		const char *key = "color.remote";
+		char *value = NULL;
+		if (!git_config_get_string(key, &value))
+			sideband_use_color = git_config_colorbool(key, value);
+	}
+
+	if (!want_color_stderr(sideband_use_color)) {
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
+
 /*
  * Receive multiplexed output stream over git native protocol.
  * in_stream is the input stream from the remote, which carries data
@@ -48,8 +104,10 @@ int recv_sideband(const char *me, int in_stream, int out)
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
@@ -69,20 +127,22 @@ int recv_sideband(const char *me, int in_stream, int out)
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
index 000000000..fd165cda0
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
+test_expect_success 'push' 'git -c color.remote=always push origin HEAD:refs/heads/newbranch 2>output &&
+  test_decode_color < output > decoded &&
+  test_i18ngrep "<BOLD;RED>error<RESET>:" decoded &&
+  test_i18ngrep "<YELLOW>hint<RESET>:" decoded &&
+  test_i18ngrep "<BOLD;GREEN>success<RESET>:" decoded &&
+  test_i18ngrep "<BOLD;YELLOW>warning<RESET>:" decoded'
+
+test_done
--
2.18.0.345.g5c9ce644c3-goog
