Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9701F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfA0AgI (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34199 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so6385861pfg.1
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxtmO7dXFX80Z9kEjqEhdw4Sy5rHHoxOw+1Cqw0ZSXo=;
        b=hm2QNv8Wx4WLMzJg93cefDRYiOD4s7yDuCrf4bG2fstHi8j1HCozpO9tO8taJ/VyuS
         25ihsngfein5D0wZaFDwC7miUGoZMvBuX40YxNWFtS/sHp3pvW135g6Q/9ewBnCxbzWw
         6sjQ0I3tb0YcitVk5J+MSfkf6tLRQTuZafUXFdPikuP613Blx2sqPxbwHbg/Y63t19zf
         VhDAnxcuP8F4iDTbGybr4n1ewJlTIzJ6KcrCj+C+FuG6a2GJO/SYJGY14MxGVWuFKka5
         bZzdkvjPAwgJtB+VuX1gL3Pm/6Qp5UuTmdh+9P6gveys7kA8N1FR9K2kk2pITHBomjGG
         URPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxtmO7dXFX80Z9kEjqEhdw4Sy5rHHoxOw+1Cqw0ZSXo=;
        b=YwO+n30d+xgSEh2OFXvhysHzFcpSZ3Inmx8D+XhswgTdwvbnahsJWi9DX1OQj9nbYH
         jcgrKSBY3oIYqypI/eHsQF85TIGVO8fSNdhQb5N9IDy7Qvy5yT63y89MSnlWAmuAu0Xs
         hZnhTI/5hWJ7WuzHubLr66NezdVac0f3ORxpf0pGrhns/wCE67iDtjavotFTlx9b7FbX
         5rJEwDjM+7sKznfxr4tsWxoNgMSoygo2XpE3FxEKmOgqar/K1lbhHBD8MY8URvjReZuA
         FJT5cYU46hzb3ck3gX9pw6qQMvQi6eVxHrySkSIs87/7zwLl2Tgdyho/jiT5A7H0+p4S
         8Bhg==
X-Gm-Message-State: AJcUukcGnN/C9dnS+laUdmEGZ526ewTUw/LIMlVNAel/LGdODOUCVbkX
        o67xPs+mlcT0ZCtyccynw3M7nwEM
X-Google-Smtp-Source: ALg8bN6Z53ZOjReM2j7MwKLIiW2e1TjE5+z/v+czuwD3FsrTPipTta1/Zha5jN01TmEcndn+LlB4Lw==
X-Received: by 2002:a63:4948:: with SMTP id y8mr14964008pgk.32.1548549367488;
        Sat, 26 Jan 2019 16:36:07 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h79sm45389674pfj.186.2019.01.26.16.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/14] parse-options.h: remove extern on function prototypes
Date:   Sun, 27 Jan 2019 07:35:22 +0700
Message-Id: <20190127003535.28341-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.20.1.560.g70ca8b83ee

