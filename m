Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8624A1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933227AbeBMBli (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:41:38 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932886AbeBMBlf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:41:35 -0500
Received: by mail-pl0-f65.google.com with SMTP id t4so5895103plo.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6MAqtfNI8j4M+4xcseeVIxFzwbcMs/2N4Qsb25AxX0M=;
        b=Z1crsyfP5Nkuxl8YYj1zQ203DL3iAV+G2e2THjP3QMAWVy7rowLg49KuP7nwL3Ahuf
         hYR6CF9edTC5gyB06Oizs+n/nq9xdJh1f2zjX49sJI7cfIUQirRDaVGQFnw4NvWJfrU7
         1n151saqv7ASY1XvEMZWYJ6iaXW2Vr4MV+RnT8R5e/ADUqgRrrqYkNT0lXlMltr0K+6s
         P2HSR5IwuGY7dVim252bo3tNqoXHZdNqBm4JLw/W746SFgtlJYB/xgQ2PO6d2kPZDi01
         3S+JKMgXgVUmCDKHHYO2Fp/uKMXfodMUMp7LoFKTw1c8HFlwwYZ+sCjdURnLQNimKFD5
         LADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6MAqtfNI8j4M+4xcseeVIxFzwbcMs/2N4Qsb25AxX0M=;
        b=XusGkIIQCRT3dRmXQnMJYJGZSEb72Ci0DrfWvVGNLzwt+leu3QNQ9v/tDXxlLkwKVJ
         MoHKHzdaYdyZf+CG0MILvW0FVrIrt5AyMNHfiZr2UXqFMfqcP6CjhcPFoZ67N/QlyNKH
         Ou9l6H/cpFmXemW3Jj6PV9w1uOSME3k/4QUF3sEVamS388IiQ53DIplk5Zm9+b0QDr+N
         FKudJd2OLbvATZsFtuqPpThVQURMrOjx912X4xW44IMD0YaSsRRToEHfXgHNDLFDgFW7
         HaDflTBnYcWO5cihaI0kbo4MxNbQ9GcL+w90X9DfXTiAXQhxTnDBS5HeMdSTiUGHpOLu
         cIDQ==
X-Gm-Message-State: APf1xPBpc/TpI47m8CoC2v53fLPHItusDDu4A2wksopnDRSf/I9OBWip
        ZnwkRKVHQgKiJOzozKrazUuVqw==
X-Google-Smtp-Source: AH8x22635B+SrMRzYZ5ENnCTj86RUUYf5HlEbI+1G1t0BCq3bOJc4Vo5Opjba9LPFRckfGgRj44ztA==
X-Received: by 2002:a17:902:42c3:: with SMTP id h61-v6mr12301811pld.269.1518486094785;
        Mon, 12 Feb 2018 17:41:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id s187sm4151323pgb.84.2018.02.12.17.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:41:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com
Subject: [PATCH] color.h: document and modernize header
Date:   Mon, 12 Feb 2018 17:41:30 -0800
Message-Id: <20180213014130.190374-1-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
References: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation explaining the functions in color.h.
While at it, migrate the function `color_set` into grep.c,
where the only callers are.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 * fixed commit message
 * followed Jeffs/Erics advice  and rewrote want_color()s doc once again.

 color.c |  7 -------
 color.h | 34 +++++++++++++++++++++++++++++-----
 grep.c  |  5 +++++
 3 files changed, 34 insertions(+), 12 deletions(-)

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
index fd2b688dfb..763bef857d 100644
--- a/color.h
+++ b/color.h
@@ -76,22 +76,46 @@ int git_color_config(const char *var, const char *value, void *cb);
 int git_color_default_config(const char *var, const char *value, void *cb);
 
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
-
 int git_config_colorbool(const char *var, const char *value);
+
+/*
+ * Return a boolean whether to use color, where the argument 'var' is
+ * one of GIT_COLOR_UNKNOWN, GIT_COLOR_NEVER, GIT_COLOR_ALWAYS, GIT_COLOR_AUTO.
+ */
 int want_color(int var);
+
+/*
+ * Translate a Git color from 'value' into a string that the terminal can
+ * interpret and store it into 'dst'. The Git color values are of the form
+ * "foreground [background] [attr]" where fore- and background can be a color
+ * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
+ */
 int color_parse(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
+
+/*
+ * Output the formatted string in the specified color (and then reset to normal
+ * color so subsequent output is uncolored). Omits the color encapsulation if
+ * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
+ * the color.  BUG: The `color_print_strbuf` prints the given pre-formatted
+ * strbuf instead, up to its first NUL character.
+ */
 __attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
+/*
+ * Check if the given color is GIT_COLOR_NIL that means "no color selected".
+ * The caller needs to replace the color with the actual desired color.
+ */
 int color_is_nil(const char *color);
 
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
2.16.1.73.ga2c3e9663f.dirty

