Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E45E320248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfCEMcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:32:09 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34278 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfCEMcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:32:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id u9so5600335pfn.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfbRFUzEiozOAYC3PuRSi6wck7Ugu7l6ZXnRc1FkOrg=;
        b=cBLM7Ap04tt5cxVioc7pUPz/poGUlzxLtmYW/Bs5pfJJ/FFYujnnD1c9q7ZHXgqxpD
         hBcMSbm7TTpuGRJ2x4nrZQN7K9cR/ae9FF6VF8bdALp38PUAUos8Ya4uoQdJ5U0eyWqW
         SOd1AUBT03NxBYd/PqAxP189uuJZc8tTwEuK0nrx6jQ69VQ3xKVMNUjQq5NI3ZkmBQvf
         gSviqMsACF1DM6DME96X+05RsMhh7QRsi6nltiI0lE2Arjg9AiIOMMcWo+FkWjs3mYB/
         ftsJzmXScXfqIllqViHuCEF97kCHQb/L1JuDZuFdV4RyQsVXTRIjEZkLepBeL9HUb18j
         +vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfbRFUzEiozOAYC3PuRSi6wck7Ugu7l6ZXnRc1FkOrg=;
        b=HNF6/xDSfcx0Y4A9e2CbdJNb0pqjNVPuIzWmhhWf0YXZUiDP+YmZxBhvPNSqZAgm+s
         sj5FZOdyqqEf+cyKeQzWdzW3y7jYzey1CUPFT0V991wSWwduZu9+qvbfmRHxHysgPQfD
         Q0GFZxhnmtDliSeD0UgKLvXKTEacvQ+RJvkneFJjsNxknRpopD9AA8P2GyQeSu175Ai3
         +UIYsyZKmFG0Ca3UH6e9gSnYmqeq/Tae/ebInawLQg3c1mzRjMs1XuD3H5Mxl7cndHH6
         869FBalH2hC2Uq4XFFGdvRkbMShCA2gRRvmeLii1MxTSblAqsZvT5krkdWZjfr/RTVP1
         +8yA==
X-Gm-Message-State: APjAAAWqUIWdPi8IH3Voto9h30Rtu2xxw4j0ZKloULPa9iM/JqLNnrvV
        D9PXsAlHiCbqy90MYv/VR68s+PqC
X-Google-Smtp-Source: APXvYqyIWKeGLKrxyuU9XUO4bc3uLPmo8kSB9lxyFasQuHOANaaDHklT36N6lEIZBPXkHE2jTQA3Pg==
X-Received: by 2002:a63:5362:: with SMTP id t34mr1188909pgl.81.1551789127453;
        Tue, 05 Mar 2019 04:32:07 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id w17sm13193191pfn.63.2019.03.05.04.32.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:32:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:32:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/20] diff-parseopt: convert --textconv
Date:   Tue,  5 Mar 2019 19:30:24 +0700
Message-Id: <20190305123026.7266-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index b460fa010b..a27bca527d 100644
--- a/diff.c
+++ b/diff.c
@@ -5062,6 +5062,21 @@ static int diff_opt_relative(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_textconv(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.allow_textconv = 0;
+	} else {
+		options->flags.allow_textconv = 1;
+		options->flags.textconv_set_via_cmdline = 1;
+	}
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5303,6 +5318,9 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("disable all output of the program")),
 		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
 			 N_("allow an external diff helper to be executed")),
+		OPT_CALLBACK_F(0, "textconv", options, NULL,
+			       N_("run external text conversion filters when comparing binary files"),
+			       PARSE_OPT_NOARG, diff_opt_textconv),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5352,12 +5370,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--textconv")) {
-		options->flags.allow_textconv = 1;
-		options->flags.textconv_set_via_cmdline = 1;
-	} else if (!strcmp(arg, "--no-textconv"))
-		options->flags.allow_textconv = 0;
-	else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
+	} else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
 		options->flags.override_submodule_config = 1;
 		handle_ignore_submodules_arg(options, arg);
 	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
-- 
2.21.0.rc1.337.gdf7f8d0522

