Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80661F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeBHUPv (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:15:51 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43126 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHUPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:15:50 -0500
Received: by mail-pl0-f65.google.com with SMTP id f4so392589plr.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AilWAtpNLwTKxuizBfOvV952xmG0Qjv8M9XerwCrNwI=;
        b=M/gj+lDolDfw6v5HufBJoZqYpP89+G3AJhu8BG3tROWDVvprXBse/Bw801fyMglArg
         D2diM5ddQPqlz8z8dW/e6aDP25JE/RMx5sgiiAmWqO7YDJSPlxK++/E7O9U1ZeTV6Ch2
         WqaymQ0XxlehUCNklt3OmgCMossijFcT/cME5+LPWuNKW2THPK+PGSn/M1XeQwvfLDXO
         FAvdkZf3X/xuZKnpvO9y1WUlCPzA0t3dTAaA0de3I0KFD3hMVMMQwg2b5hdAnNvNKlf3
         fzmj0/fp9aKd/RhkxI1P4uPuoWj9izBCuQxDdy8Cp1663l0A1/niNUba5fC1Vjtlity2
         GmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AilWAtpNLwTKxuizBfOvV952xmG0Qjv8M9XerwCrNwI=;
        b=mt9RUFipGLlWBn/W7cHDbWsUWiVYQH5tE1RDiXtq1HyQUxk9JtN8nZsssqUgFHr3Cn
         S8ikPD5bs720nWoFRHlvGC36CUoewWt0clBm5ZCNQNYixe6CK7oy8q2WY1UhUNl+WRka
         GDV/plY0nOU0DRzZnJjh5VXHKzlIVMVwIi48LTD9iJCULNta8HYMTg1787JG0XFlZriN
         ai89T/HUFNuw/pza9MaUfoEvjGdQdhXhXh/j7Z1UEPzeL121BXwDuSYSAQgGaUWSnhYQ
         uH2K0yktMi0M27eH7kBnPUWZdkqdgc3ceOVgNJRq0vuW70aveS8xjb6XNw50414Eem4y
         po5g==
X-Gm-Message-State: APf1xPARevgGWMVuujsqoFetp4gFFTy16ceI+9QTmQLyVR6Lry1HHVcU
        xTssGV3Pe/584JkfA8821gZLy/mNJM4=
X-Google-Smtp-Source: AH8x226DYqce1gWKtLQ4OxKQgIvcd4x81DgSYTxRgxW3/1hvtUs2+JIVTcXd1hWReR9xF3H4CMdSFw==
X-Received: by 2002:a17:902:7b81:: with SMTP id w1-v6mr189005pll.295.1518120949397;
        Thu, 08 Feb 2018 12:15:49 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e88sm2137168pfl.80.2018.02.08.12.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 12:15:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] color.h: document and modernize header
Date:   Thu,  8 Feb 2018 12:15:46 -0800
Message-Id: <20180208201546.194935-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation explaining the functions in color.h.
While at it, mark them extern and migrate the function `color_set`
into grep.c, where the only callers are.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This used to be part of  sb/blame-color, but I realized this is
 not strictly needed for that series, so I am sending it out alone.
 
 I would think I have addressed all concerns raised in 
 https://public-inbox.org/git/xmqqr2r088p3.fsf@gitster.mtv.corp.google.com/
 specifically the NEEDSWORK was dropped and this one function was just
 put into grep.c
 
 Thanks,
 Stefan

 color.c |  7 -------
 color.h | 52 ++++++++++++++++++++++++++++++++++++++--------------
 grep.c  |  5 +++++
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/color.c b/color.c
index d48dd947c9..f277e72e4c 100644
--- a/color.c
+++ b/color.c
@@ -161,11 +161,6 @@ int color_parse(const char *value, char *dst)
 	return color_parse_mem(value, strlen(value), dst);
 }
 
-void color_set(char *dst, const char *color_bytes)
-{
-	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
-}
-
 /*
  * Write the ANSI color codes for "c" to "out"; the string should
  * already have the ANSI escape code in it. "out" should have enough
@@ -399,8 +394,6 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
 	return r;
 }
 
-
-
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
 {
 	va_list args;
diff --git a/color.h b/color.h
index fd2b688dfb..8c7e6c41c2 100644
--- a/color.h
+++ b/color.h
@@ -72,26 +72,50 @@ extern int color_stdout_is_tty;
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
- * default color variables.
+ * Parse a config option, which can be a boolean or one of
+ * "never", "auto", "always". Return a constant of
+ * GIT_COLOR_NEVER for "never" or negative boolean,
+ * GIT_COLOR_ALWAYS for "always" or a positive boolean,
+ * and GIT_COLOR_AUTO for "auto".
  */
-void color_set(char *dst, const char *color_bytes);
+extern int git_config_colorbool(const char *var, const char *value);
 
-int git_config_colorbool(const char *var, const char *value);
-int want_color(int var);
-int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+/*
+ * Resolve the constants as returned by git_config_colorbool()
+ * (specifically "auto") to a boolean answer.
+ */
+extern int want_color(int var);
+
+/*
+ * Translate a Git color from 'value' into a string that the terminal can
+ * interpret and store it into 'dst'. The Git color values are of the form
+ * "foreground [background] [attr]" where fore- and background can be a color
+ * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
+ */
+extern int color_parse(const char *value, char *dst);
+extern int color_parse_mem(const char *value, int len, char *dst);
+
+/*
+ * Output the formatted string in the specified color (and then reset to normal
+ * color so subsequent output is uncolored). Omits the color encapsulation if
+ * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
+ * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
+ * instead, up to its first NUL character.
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
+ * The caller needs to replace the color with the actual desired color.
+ */
+extern int color_is_nil(const char *color);
 
 #endif /* COLOR_H */
diff --git a/grep.c b/grep.c
index 3d7cd0e96f..834b8eb439 100644
--- a/grep.c
+++ b/grep.c
@@ -18,6 +18,11 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static void color_set(char *dst, const char *color_bytes)
+{
+	xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);
+}
+
 /*
  * Initialize the grep_defaults template with hardcoded defaults.
  * We could let the compiler do this, but without C99 initializers
-- 
2.15.1.433.g936d1b9894.dirty

