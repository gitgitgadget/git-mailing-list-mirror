Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA3F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAQNGj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40380 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfAQNGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so4728839plq.7
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdhuXFpZBdQ2H7CTiqa2xws/PohM44r3qNouPBwkP+4=;
        b=plPC6+LMaOaawzL+vGKJO0ZXduG5OIudPLp5zA2uVb7Wz2nYf+B6Sat+GdZohNB+Pe
         lGlFXuBaM2zEeC87QIFH/r9W5sHAMW1jpjcljdA4DcQeCWkorQ6Swp446gSoZiyVkD+y
         n0tm/1QiLyf6zq2xCLoh+FppjE7hLUgvoJbZG3qpNg+7MSOh4/IKWcguiKbKm2Edkg4t
         9eIxBlrpqRWPCQjuF6v2ct14Zn8lG4cQveOJ/J51LIjmH43WAUecUZ7R2a3O+/Rkj6Qx
         0P7AEDszzhxks07n+imf2PnKjinwEWn6H7F2VWh+y21OpTeTdzaO30i52ZjwJN70v0Ks
         jbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdhuXFpZBdQ2H7CTiqa2xws/PohM44r3qNouPBwkP+4=;
        b=UA/eA76Yvxlcn5xx2FRiO+S534q9IbzQ9Jyuo1AxSTYGw7T5fVt7wtlvijtxlqpOCf
         oLBhL2zQPNu1J3My8x12z8rNS002MA8uAudVZDpM0cmkMcrksW2DZcok53vR7YwZNL+2
         6hvEwqGdG+Jrk/bAYkHIxshqy9i4R/SjBYy4mwAiNimECG/pA+jrW6LufiNNLiDJ1hPz
         SNY5QDGAo5PDTdtYF3r1suX9aWOQ9LVuvRNRUd9SBTwRQBkc2wNsHoMD+ZJ0E3bVL3n0
         pAu1mUtXBHFznNUjDncm/jy5BU/r6uMRVsB6oEe0yjtqa33an5HUp4Ary7jyhbq8nPze
         LSNA==
X-Gm-Message-State: AJcUuke1nNBLqTgwKwGCwMqScq5S1eQWkhPS7gD0yLU4OnzTYdbDxWgh
        TqUDSgYlSl9gexYumIy94w8VG1L4
X-Google-Smtp-Source: ALg8bN7ihF1l/t3EakzV/eu9IejBiQqQJD/XBn+HSzJxeeeA5TY0WPLGd3o2XovS5xDmSs+0yv62kw==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr15231803pla.228.1547730397874;
        Thu, 17 Jan 2019 05:06:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a17sm2067852pgm.26.2019.01.17.05.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/76] parse-options.h: remove extern on function prototypes
Date:   Thu, 17 Jan 2019 20:05:00 +0700
Message-Id: <20190117130615.18732-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.h | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index 14fe32428e..f5e7ec7d23 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -174,18 +174,18 @@ struct option {
  * for translation with N_().
  * Returns the number of arguments left in argv[].
  */
-extern int parse_options(int argc, const char **argv, const char *prefix,
-			 const struct option *options,
-			 const char * const usagestr[], int flags);
+int parse_options(int argc, const char **argv, const char *prefix,
+		  const struct option *options,
+		  const char * const usagestr[], int flags);
 
-extern NORETURN void usage_with_options(const char * const *usagestr,
-					const struct option *options);
+NORETURN void usage_with_options(const char * const *usagestr,
+				 const struct option *options);
 
-extern NORETURN void usage_msg_opt(const char *msg,
-				   const char * const *usagestr,
-				   const struct option *options);
+NORETURN void usage_msg_opt(const char *msg,
+			    const char * const *usagestr,
+			    const struct option *options);
 
-extern int optbug(const struct option *opt, const char *reason);
+int optbug(const struct option *opt, const char *reason);
 const char *optname(const struct option *opt, int flags);
 
 /*
@@ -227,31 +227,31 @@ struct parse_opt_ctx_t {
 	const char *prefix;
 };
 
-extern void parse_options_start(struct parse_opt_ctx_t *ctx,
-				int argc, const char **argv, const char *prefix,
-				const struct option *options, int flags);
+void parse_options_start(struct parse_opt_ctx_t *ctx,
+			 int argc, const char **argv, const char *prefix,
+			 const struct option *options, int flags);
 
-extern int parse_options_step(struct parse_opt_ctx_t *ctx,
-			      const struct option *options,
-			      const char * const usagestr[]);
+int parse_options_step(struct parse_opt_ctx_t *ctx,
+		       const struct option *options,
+		       const char * const usagestr[]);
 
-extern int parse_options_end(struct parse_opt_ctx_t *ctx);
+int parse_options_end(struct parse_opt_ctx_t *ctx);
 
-extern struct option *parse_options_concat(struct option *a, struct option *b);
+struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
-extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
-extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
-extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
-extern int parse_opt_object_name(const struct option *, const char *, int);
-extern int parse_opt_commits(const struct option *, const char *, int);
-extern int parse_opt_tertiary(const struct option *, const char *, int);
-extern int parse_opt_string_list(const struct option *, const char *, int);
-extern int parse_opt_noop_cb(const struct option *, const char *, int);
-extern int parse_opt_unknown_cb(const struct option *, const char *, int);
-extern int parse_opt_passthru(const struct option *, const char *, int);
-extern int parse_opt_passthru_argv(const struct option *, const char *, int);
+int parse_opt_abbrev_cb(const struct option *, const char *, int);
+int parse_opt_expiry_date_cb(const struct option *, const char *, int);
+int parse_opt_color_flag_cb(const struct option *, const char *, int);
+int parse_opt_verbosity_cb(const struct option *, const char *, int);
+int parse_opt_object_name(const struct option *, const char *, int);
+int parse_opt_commits(const struct option *, const char *, int);
+int parse_opt_tertiary(const struct option *, const char *, int);
+int parse_opt_string_list(const struct option *, const char *, int);
+int parse_opt_noop_cb(const struct option *, const char *, int);
+int parse_opt_unknown_cb(const struct option *, const char *, int);
+int parse_opt_passthru(const struct option *, const char *, int);
+int parse_opt_passthru_argv(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-- 
2.20.0.482.g66447595a7

