Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64A81F597
	for <e@80x24.org>; Thu, 26 Jul 2018 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbeGZSfz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:35:55 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:48612 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbeGZSfz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:35:55 -0400
Received: by mail-yb0-f202.google.com with SMTP id v1-v6so1178182ybm.15
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=sQYx5hk70oV7ONVJBzBKSxP88XYCmg32V3z8SttEaPA=;
        b=frcEEuMp0q+YxqUcqjN6SynQnchpcyyVX+8dbETv2pzHtiCP5BfI7Emanum9XUSbHP
         b7X4p7wG4lxuOwkUEcVh+UsShuKDSxvw7/PtUQFvytKG4CnPsbmGLaICs6l4vbETrZ3g
         LSa8A3UrBY9v8wlb8GHueXsOF94/SizKI9DYs3Q4wKj25LJav+1yLp2kIy4mNfahgKLO
         XI4MpXCOmo9eRt4hFb1MHaN5iygjzP7/K+U87FY9SSMXHjUVWY8H5vCKUbdvBPpmS+9j
         17n1OEyoyfvYiyBodq3WgDni0pdVlv2QZO+nBJQg/BOhonZ2M2AXftTlHv+8iBltnDZV
         87Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=sQYx5hk70oV7ONVJBzBKSxP88XYCmg32V3z8SttEaPA=;
        b=hNeHyn8sJRF0YDmPQVag7uHAAWtzgy4x/0YMox3X+s2YVqY7SRHv1lRbJpKEi79UY4
         +WjZOi5Czfs3/LTfi4AkyYZDcNz5vZtiCQ4svCBkeehPzKtnN60uJwMW6ugRiE0ysLVx
         Uqpczm429zgw+H1r+B2z3QpTULBMKK/t3ohBeJ3Qsob9hTR1WDcKAaiU+Is4a9UxoTVJ
         LZ/1dLr0tr3MYJLhPNdfeUt8AcZr47tW2pM5WIHmoNa8g6fu41ARP7BSG1jH9LhHOqx2
         6ixKl+qa/U8Ub/NwN+ktBRodvzzVpakas4jYZL6ftIItxOWK6L+oJiekzKgd2zW8L2Wv
         8BkA==
X-Gm-Message-State: AOUpUlHi3pTgwycZpzNijbUm3DN7xK/hRfz47RhjF7iqzS/pNfnMTdIF
        LnolcfbjkUgYjAqcm+rg2ZhDUNfZiVwo6tVFxPWfTv4nvW0ZGkHwzeM7IlTprh67Tl9CSzEQS5L
        ZQnWjGW7Vv90j9CpTC6CKmi6MFhC+N7hrOZyzEhXZFrRIidvZex0/bWJywA==
X-Google-Smtp-Source: AAOMgpfuleTBCVs5RCDqg0eK+qaOpcruQ0Ttkf8g0rBxKtmiESgHe7TevvPberf9jcNcfQrK9CbRN+5Ku/o=
MIME-Version: 1.0
X-Received: by 2002:a5b:444:: with SMTP id s4-v6mr843336ybp.58.1532625489362;
 Thu, 26 Jul 2018 10:18:09 -0700 (PDT)
Date:   Thu, 26 Jul 2018 19:17:51 +0200
Message-Id: <20180726171751.178616-1-hanwen@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] RFC Highlight keywords in remote sideband output.
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Supported keywords are "error", "warning", "hint" and "success".

TODO:
 * make the coloring optional? What variable to use?
 * doc for the coloring option.
 * how to test?

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Change-Id: I090412a1288bc2caef0916447e28c2d0199da47d
---
 sideband.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/sideband.c b/sideband.c
index 325bf0e97..c8b7cb6dd 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,53 @@
 #include "cache.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "color.h"
+
+/*
+ * Optionally highlight some keywords in remote output if they appear at the
+ * start of the line.
+ */
+void emit_sideband(struct strbuf *dest, const char *src, int n) {
+        // NOSUBMIT - maybe use transport.color property?
+        int want_color = want_color_stderr(GIT_COLOR_AUTO);
+
+        if (!want_color) {
+                strbuf_add(dest, src, n);
+                return;
+        }
+
+        struct kwtable {
+                const char* keyword;
+                const char* color;
+        } keywords[] = {
+                {"hint", GIT_COLOR_YELLOW},
+                {"warning", GIT_COLOR_BOLD_YELLOW},
+                {"success", GIT_COLOR_BOLD_GREEN},
+                {"error", GIT_COLOR_BOLD_RED},
+                {},
+        };
+
+        while (isspace(*src)) {
+                strbuf_addch(dest, *src);
+                src++;
+                n--;
+        }
+
+        for (struct kwtable* p = keywords; p->keyword; p++) {
+                int len = strlen(p->keyword);
+                if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
+                        strbuf_addstr(dest, p->color);
+                        strbuf_add(dest, src, len);
+                        strbuf_addstr(dest, GIT_COLOR_RESET);
+                        n -= len;
+                        src += len;
+                        break;
+                }
+        }
+
+        strbuf_add(dest, src, n);
+}
+
 
 /*
  * Receive multiplexed output stream over git native protocol.
@@ -48,8 +95,10 @@ int recv_sideband(const char *me, int in_stream, int out)
 		len--;
 		switch (band) {
 		case 3:
-			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
-				    DISPLAY_PREFIX, buf + 1);
+			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
+				    DISPLAY_PREFIX);
+                        emit_sideband(&outbuf, buf+1, len);
+
 			retval = SIDEBAND_REMOTE_ERROR;
 			break;
 		case 2:
@@ -69,20 +118,22 @@ int recv_sideband(const char *me, int in_stream, int out)
 				if (!outbuf.len)
 					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
 				if (linelen > 0) {
-					strbuf_addf(&outbuf, "%.*s%s%c",
-						    linelen, b, suffix, *brk);
-				} else {
-					strbuf_addch(&outbuf, *brk);
+                                        emit_sideband(&outbuf, b, linelen);
+                                        strbuf_addstr(&outbuf, suffix);
 				}
+
+                                strbuf_addch(&outbuf, *brk);
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
+                                emit_sideband(&outbuf, b, strlen(b));
+                        }
 			break;
 		case 1:
 			write_or_die(out, buf + 1, len);
-- 
2.18.0.233.g985f88cf7e-goog

