Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F26201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 01:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbdKJBKN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 20:10:13 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44235 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755342AbdKJBKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 20:10:11 -0500
Received: by mail-io0-f193.google.com with SMTP id m16so11907224iod.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 17:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v9wi/SxVctXyBrSeXKUcbKkHflCsE2EgqnjMEtU0S5c=;
        b=XWVunD2HU/2Astshtm5cGn0KV8hTRzx2crkfh4pstvvUMyz3XLiq2j8x3uVP7rr1Ca
         WsS/+0PO1vmRq14kw9C1uw0JELOg58ny2lnZgYQYxpubAHMUpeorb60tQz14QDnhf1tk
         3dhcXLbtbFoZZH+xWqo9NZbB8KSTPjYAlONIRPW6Sg9fB8viMof4rKtDPfJFTybkENZt
         BvJ0eHVSg3nvj3HTEjFafiIc+BpatdavoNb82wx5Hb/W7LisiyygjGKGeylHQUGPN2J6
         +F9bSj9McoaDEUw7Th71UiXP+y+GO1nVLXgAwPJPqz+4p2ME7Osf7LXk56Pxp2EzNw0R
         fZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v9wi/SxVctXyBrSeXKUcbKkHflCsE2EgqnjMEtU0S5c=;
        b=eCKjQCFT5fCcEBhstYGXBGQqEWiyCG5LaT5ajBOxgOTQWzLg9dme9uwqayhM87RzVd
         WSBiTxYXOwkGo21NSJt73Ul8ChboeechiZoGq30+hGejx6hhL0XdTMeXFZlanLiPzD8n
         brF7e4tdfJUmdEoIzC6cDlwRd9fj4Qu2u6VseBB8G5g8U+vOCxSUCcFyAHP8/ayqtESb
         uOGSWjPORenUHUzOxjbV3kojpDqArA3Huf/18mW7CsPuNmPIbE6oW1lc6kjiHSgmvr3T
         G/ZPcLCcwR0umshYn+m3PJj38z5CP9p3/Xq8RaKpu1G82bIqXyGWp7VY12n+nJaG0CKC
         hsdA==
X-Gm-Message-State: AJaThX6IHXYWCXBhkQvi06rdPosfdnc76EP1sEiD+CuIx0fZRnfSR6x4
        MFAXab2gxBLD+bbEWZXK0t8I6ce7kNk=
X-Google-Smtp-Source: AGs4zMbXdrA/abXpPBfp2Oid7hwAYjjIRNMxdy7OodOLQ4W36G8UBoNhjGL5ZlcyOx/u4BO9OD3KCw==
X-Received: by 10.107.143.20 with SMTP id r20mr2852111iod.205.1510276209980;
        Thu, 09 Nov 2017 17:10:09 -0800 (PST)
Received: from localhost ([2620:0:100e:422:3816:f49a:2bf0:e33c])
        by smtp.gmail.com with ESMTPSA id g26sm3880676iob.34.2017.11.09.17.10.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Nov 2017 17:10:09 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] color.h: modernize header
Date:   Thu,  9 Nov 2017 17:09:59 -0800
Message-Id: <20171110011002.10179-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.128.gcadd42da22
In-Reply-To: <20171110011002.10179-1-sbeller@google.com>
References: <20171110011002.10179-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 color.c |  2 --
 color.h | 48 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/color.c b/color.c
index 9a9261ac16..e43da3ce53 100644
--- a/color.c
+++ b/color.c
@@ -400,8 +400,6 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 	return r;
 }
 
-
-
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
diff --git a/color.h b/color.h
index fd2b688dfb..6cd632c0d8 100644
--- a/color.h
+++ b/color.h
@@ -72,26 +72,48 @@ extern int color_stdout_is_tty;
  * Use the first one if you need only color config; the second is a convenience
  * if you are just going to change to git_default_config, too.
  */
-int git_color_config(const char *var, const char *value, void *cb);
-int git_color_default_config(const char *var, const char *value, void *cb);
+extern int git_color_config(const char *var, const char *value, void *cb);
+extern int git_color_default_config(const char *var, const char *value, void *cb);
 
 /*
- * Set the color buffer (which must be COLOR_MAXLEN bytes)
- * to the raw color bytes; this is useful for initializing
+ * Set the color buffer `dst` (which must be COLOR_MAXLEN bytes)
+ * to the raw color bytes `color_bytes`; this is useful for initializing
  * default color variables.
  */
-void color_set(char *dst, const char *color_bytes);
+extern void color_set(char *dst, const char *color_bytes);
 
-int git_config_colorbool(const char *var, const char *value);
-int want_color(int var);
-int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+/*
+ * Parses a config option, which can be a boolean or one of
+ * "never", "auto", "always". Returns the constant for the given setting.
+ */
+extern int git_config_colorbool(const char *var, const char *value);
+
+/* Is the output supposed to be colored? Resolve and cache the 'auto' setting */
+extern int want_color(int var);
+
+/*
+ * Translate the human readable color string from `value` and into
+ * terminal color codes and store them in `dst`
+ */
+extern int color_parse(const char *value, char *dst);
+extern int color_parse_mem(const char *value, int len, char *dst);
+
+/*
+ * Print the format string `fmt`, encapsulated by setting and resetting the
+ * color. Omits the color encapsulation if `color` is NULL.
+ * The `color_fprintf_ln` prints a new line after resetting the color.
+ * The `color_print_strbuf` prints the given pre-formatted strbuf instead.
+ */
 __attribute__((format (printf, 3, 4)))
-int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
+extern int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
-int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
-void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
+extern int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
+extern void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
-int color_is_nil(const char *color);
+/*
+ * Check if the given color is GIT_COLOR_NIL that means "no color selected".
+ * The application needs to replace the color with the actual desired color.
+ */
+extern int color_is_nil(const char *color);
 
 #endif /* COLOR_H */
-- 
2.15.0.128.gcadd42da22

