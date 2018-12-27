Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145AF211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeL0QZu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:25:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41656 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbeL0QZu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:25:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so12991754lfj.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2CuQGYHq9PKV2gr+Pn85/ehQnGk4QjWSetIpRhDp8Ig=;
        b=qKU10GhiDFrOsUwmt9gnBmLuNJGj7WY+rGl0wh5CwRbaqajyOVldRIWRSbWnw7Rhfl
         ztrlmY22JptQ+SYRa2R+hvqBcrAJ5ouvrlzxAzw7rsMbskSJpfyZlZOs+92bXqwZBr/C
         mRpQJ6uLc+XS6W7waZGOy6m2ylkQG5/dC5WFWW4vDywjOBeu/Yz4RdQLDm3dM0E+4nml
         +KA1hvIAQMcYt1Z74WrRlcP2oHUeT6IEaGLAn67gOCRwk3PkfBw4Yf7gTyVe/RSjWkMW
         eNAo1FbDkLHuFkJIMAJDB1zN4Jg5EGw1mByZwhLzufbnp0cMTbMukQALD5LivXkoIRW6
         q12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CuQGYHq9PKV2gr+Pn85/ehQnGk4QjWSetIpRhDp8Ig=;
        b=ageax7G2QyRsWWvyfEZbjsrkecCR2s2gtqCMiRl7KlrRtzJlebzymqweXA3lw586aq
         2PZCq/jzVlucO7f4RerNp/gOGp+PpSy0jhi3kYA5vV+gschLNVFapBSYZS598BGR7JkI
         le3xyepkFuW1xC6jRn6xmlsnOLo0V9iVu9gu8zFPSK9vEeu/+OAhJ8msMqyfpvM5kJMm
         Hvvpbk4H94nDj1eTFl5uXEl5MtxLiUl5+ktMdCyxeuaLNFBOtZwhkkGXxO602n1AMMF6
         8Nzj2llrKGuAPW/Nu/ShbzxZ+obKxBE7wwly0CC+Q1wxNaF16FMI7jCNB1LVVfIj2UMh
         30gg==
X-Gm-Message-State: AA+aEWYRAujx7KoDrNoevz/48H0lxsA9ptkUvi4XV63oHwPD9UGOwEJr
        eoYfvIC+tp2WquWNQ+HkPuYDD330
X-Google-Smtp-Source: AFSGD/VYMUN6qiCuVTAN4vNpArdloDqvqK2yTC7ecSUQQy+rWNnewfJ1bKh7aT897vgzUB1rbtorVg==
X-Received: by 2002:a19:9904:: with SMTP id b4mr11823353lfe.95.1545927946072;
        Thu, 27 Dec 2018 08:25:46 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:44 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/75] parse-options.h: remove extern on function prototypes
Date:   Thu, 27 Dec 2018 17:25:22 +0100
Message-Id: <20181227162536.15895-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.h | 60 ++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index a650a7d220..1947cb27cf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -174,19 +174,19 @@ struct option {
  * for translation with N_().
  * Returns the number of arguments left in argv[].
  */
-extern int parse_options(int argc, const char **argv, const char *prefix,
-                         const struct option *options,
-                         const char * const usagestr[], int flags);
+int parse_options(int argc, const char **argv, const char *prefix,
+		  const struct option *options,
+		  const char * const usagestr[], int flags);
 
-extern NORETURN void usage_with_options(const char * const *usagestr,
-                                        const struct option *options);
+NORETURN void usage_with_options(const char * const *usagestr,
+				 const struct option *options);
 
-extern NORETURN void usage_msg_opt(const char *msg,
-				   const char * const *usagestr,
-				   const struct option *options);
+NORETURN void usage_msg_opt(const char *msg,
+			    const char * const *usagestr,
+			    const struct option *options);
 
-extern int optbug(const struct option *opt, const char *reason);
-extern int opterror(const struct option *opt, const char *reason, int flags);
+int optbug(const struct option *opt, const char *reason);
+int opterror(const struct option *opt, const char *reason, int flags);
 #if defined(__GNUC__)
 #define opterror(o,r,f) (opterror((o),(r),(f)), const_error())
 #endif
@@ -230,31 +230,31 @@ struct parse_opt_ctx_t {
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

