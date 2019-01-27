Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023281F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfA0Ag6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:58 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43559 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0Ag5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so5679247pgk.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isWG9ZriEGn5qe342uz4xnWoSDM51oIhOnodE4SUTZk=;
        b=T6d1LUvHBW5I3KvnqcgqamEz2Q4Kb4+TwSLX4nLm35YCpajnV5C+k/XjRSW58bmchz
         WzwZOK65OiNO8aTaNhAGGsX97kFihfraryQfF7g3ImOzTArbrwXhpPRCvwvTm3591FR4
         BgP0xBe4swMIMeoTJOY8PaTqiVA1eoEpETpcZaqkG473uRMwlFSeVo/UIFplb7S4/mth
         uKEcQIw0f6S3fqSzBeLRZtmCaF1bCpSSxzEeGx9rEk1jn/jOPYWIGKfJjRRT4e0SIUoq
         tdXuZpaWTlFt2iT9pzI2Z4qlRFqqW+tcetg7hfo6vIEWSamvmXIC8gz0Ujur8I1vq+mP
         5eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isWG9ZriEGn5qe342uz4xnWoSDM51oIhOnodE4SUTZk=;
        b=FvsRfHb9q/t9kgQdjBbmCCspCruG91jeYrEHPJioAxf097Q7SNOk6aPeIbpp1L9Hf+
         FqjxoD/ZWR75zXB25AsJ/ee0YR1VbwSGDJBWnhaFBG6fOG1pYHZmNnmElDPXAqwTOjZ6
         v0ZQl0e7sSwr4YjLvdgNYQcluUfe+pzEurH6jZ9ao7L8QUdCLkCNO425us0HlXmN4VfT
         GAsa8UTLwYpOLEKWfuov/xPl47yFGLzUdsHzQTo6SNWeXNVYvvQLPOshCsU5/O6UiTBi
         StNT0OpA6ZIBP/4nA7e3DSTJYTBjuuT2FunCFmCFeYeWd+r2/fe5GOCsWcz3/udFhfpT
         MmnA==
X-Gm-Message-State: AJcUukcv7jxTaYmekazO7Xi4sFqu31RlDMzydhfqIq1DmJs7gUZxCkd0
        xpcL7h3LCmH/ye6MeGrNGtd6PWSx
X-Google-Smtp-Source: ALg8bN7jI8kmx+HQr9ICudY1FUU7Rzn1FGInYDocg43/O8jknWfQtDsqrwMbp6vA2O295IT6jPGdcg==
X-Received: by 2002:a62:5b44:: with SMTP id p65mr16444900pfb.47.1548549416577;
        Sat, 26 Jan 2019 16:36:56 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l3sm41997904pga.92.2019.01.26.16.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/14] diff.c: prepare to use parse_options() for parsing
Date:   Sun, 27 Jan 2019 07:35:31 +0700
Message-Id: <20190127003535.28341-11-pclouds@gmail.com>
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

This is a preparation step to start using parse_options() to parse
diff/revision options instead of what we have now. There are a couple
of good things from using parse_options():

- better help usage
- easier to add new options
- better completion support
- help usage generation
- better integration with main command option parser. We can just
  concat the main command's option array and diffopt's together and
  parse all in one go.
- detect colidding options (e.g. --reverse is used by revision code,
  so diff code can't use it as long name for -R)
- consistent syntax, e.g. option that takes mandatory argument will
  now accept both "--option=value" and "--option value".

The plan is migrate all diff/rev options to parse_options(). Then we
could get rid of diff_opt_parse() and expose parseopts[] directly to
the caller.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 27 +++++++++++++++++++++++++++
 diff.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/diff.c b/diff.c
index 1b5f276360..80b4af23d7 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "parse-options.h"
 #include "help.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
@@ -4425,6 +4426,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+static void prep_parse_options(struct diff_options *options);
+
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4466,6 +4469,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
+
+	prep_parse_options(options);
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4569,6 +4574,8 @@ void diff_setup_done(struct diff_options *options)
 
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
+
+	FREE_AND_NULL(options->parseopts);
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4860,6 +4867,16 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static void prep_parse_options(struct diff_options *options)
+{
+	struct option parseopts[] = {
+		OPT_END()
+	};
+
+	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
+	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4870,6 +4887,16 @@ int diff_opt_parse(struct diff_options *options,
 	if (!prefix)
 		prefix = "";
 
+	ac = parse_options(ac, av, prefix, options->parseopts, NULL,
+			   PARSE_OPT_KEEP_DASHDASH |
+			   PARSE_OPT_KEEP_UNKNOWN |
+			   PARSE_OPT_NO_INTERNAL_HELP |
+			   PARSE_OPT_ONE_SHOT |
+			   PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (ac)
+		return ac;
+
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
 	    || opt_arg(arg, 'U', "unified", &options->context))
diff --git a/diff.h b/diff.h
index 8abe1649d0..d9ad73f0e1 100644
--- a/diff.h
+++ b/diff.h
@@ -15,6 +15,7 @@ struct diff_filespec;
 struct diff_options;
 struct diff_queue_struct;
 struct oid_array;
+struct option;
 struct repository;
 struct rev_info;
 struct strbuf;
@@ -229,6 +230,7 @@ struct diff_options {
 	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
+	struct option *parseopts;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.20.1.560.g70ca8b83ee

