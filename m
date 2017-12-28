Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47671F406
	for <e@80x24.org>; Thu, 28 Dec 2017 21:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754763AbdL1VEB (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 16:04:01 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:35728 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754737AbdL1VEA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 16:04:00 -0500
Received: by mail-it0-f68.google.com with SMTP id f143so29909467itb.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 13:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJcZ2NwZkWnU8kmEYWbVPGDC4PZ9zWFZMN/iimE3BSQ=;
        b=tjYEr9a8ph6RNa/NvaErpCI2OOemkCRpI8jB1n6r/IergljyTwYTFD+skv5/ZYXgVz
         6Gj2e2N/0gwgkuSgfdLjgL7NWZ/GLBaG1Dyh7No7ldvT/I15/I2FdHRa0jsuB/GRocG3
         kmfJnWgPvDKxFUvaOdOqj6vARIZnhz7hF3EzuOI0XJYHW4QXlhHsa4jAj8Iz/Ud9F+/u
         KHWQA9bLtfgKwcfDt60keYT/r4vFyTdsk3WPoCHEhNLweX3rrKvLIOvTl9+DO/eqhB8d
         ot3TfvyAL2oad9s26vFGYhuUb7h4Aq1CBObgXM7FeQGbj0ZIpbGMs+DkKHJ240Xm8KUo
         YBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJcZ2NwZkWnU8kmEYWbVPGDC4PZ9zWFZMN/iimE3BSQ=;
        b=qYTw2wm9D5xtFbjFWxEdVcumS1l3jKEZfTISHt6SDghF8ShPA19KnQtT6Y5isnVgY0
         Y6zyiEl4TqIDk4Ab3/9x3KgVOLZbpYsYs9ej7ihBW+q04T/i+tvht9hEuq95nSbda1SM
         TZOSWi/706QfhuwomZ/0GgpdbuhEQcPo7WrA5sku23TSHUQoCPJQKZQyZeYAATrk37da
         wq1dtpRK7gKZ/iMx8m5aLWJb45e8VshwItxqz74LQkMy5qVago507wYeDtyyOlbOX4x/
         yuLCOlrOcUgW55VLMdT3RXb74lu/TMczPCnayJMFhQbw3QyTI1M687nWyoMIpAGSxWUG
         3/Yw==
X-Gm-Message-State: AKGB3mIP+wdDGJgQZ8N1Jfctk9Uk8JOzV9u7JE/dsdwNpcWZ+7kxrRzU
        84KJnEr6lLBi0kM5XVan2S5VN5rKg4w=
X-Google-Smtp-Source: ACJfBosTquXjXiK4qIfD4BpNDOmbfWNK153UKGt7RLS/RrUiKUjupiVvOyKx6AezHyiPdlKszC6RxQ==
X-Received: by 10.36.253.137 with SMTP id m131mr41786455ith.16.1514495039013;
        Thu, 28 Dec 2017 13:03:59 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w6sm12047008itc.5.2017.12.28.13.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Dec 2017 13:03:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] color.h: document and modernize header
Date:   Thu, 28 Dec 2017 13:03:42 -0800
Message-Id: <20171228210345.205300-2-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
In-Reply-To: <20171228210345.205300-1-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation explaining the functions in color.h.
While at it, mark them extern.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 color.c |  2 --
 color.h | 48 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/color.c b/color.c
index d48dd947c9..c4dc1cb989 100644
--- a/color.c
+++ b/color.c
@@ -399,8 +399,6 @@ static int color_vfprintf(FILE *fp, const char *color, const char *fmt,
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
2.15.1.620.gb9897f4670-goog

