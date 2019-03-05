Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752C720248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfCEMcO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:32:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38979 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfCEMcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:32:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so5593454pfo.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwuq6qk4b0k/48vdaomvIlz//D+7pgH2mcmtcn+hMRw=;
        b=sKirZeiGv6ovH1wYSZ5NOhQjkX6/lrjZ9xLD7N8QW+Th/EbMmovq/mG8k7wmdCXZXt
         Q4tDYjiUec9DPoBVzj5BUafHQFFBeifgeJnKGqIMP2LhDBvTPXp+SIa3ezbiPD4xOlzJ
         siFKi+ykYDIVhB/qbWaGQOQHfhrPB64+bLddjiswBx4BgXjWNnb3h4t3Q626/xltqxFA
         RvACXrS08wG4XFDLMH9TngZtY5LltPPYzMdxWaHFxe8bDzVt6pz62NyDIZd/AmCp1dYK
         GL754azWGygl7paE4BcdyymZiJnOKCdO06Ysca+rjNSuxGsK1uR0zoVkWGHRxB48DqZ4
         sVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwuq6qk4b0k/48vdaomvIlz//D+7pgH2mcmtcn+hMRw=;
        b=Vlg5Ug+W/T5HLpxHvL065ft0+KIRoO7RIt9mWkgvA6gvKsET9Z8d9qGMXsCdL9LMfC
         QvbAXle6BLt3SI4JhCgFhmNM2LbBTSMbLtShxPlWZjO9zBVXqDgXztZlvLkZf2c0FcmK
         Q3WvGwXrsplWQFo/jkL7jfD6fPy0nDrUzlEcx0x6pNq95s5grAl9GlOLL/1oYED4QVoB
         kP4u3YJuQ/2a8/JkKM+aMoAeoycoLTKvDAOyXwljQOwI/LJ9eAQ2XEnCbVnsyBI8SLtO
         zxm7rv9okys6Oe9YBXc1qSUXp3J9dwmPIjcGCLjvyT7JidENKDQkIgv6ycIeNs+OrZZJ
         umGw==
X-Gm-Message-State: APjAAAWIbASyDwOrzIeaksI1xiuHU6egTp6TbeDIFkMoi9TbokH0xDoT
        GdbQ4Kth7CgIyMe55nMO9NyxkSmb
X-Google-Smtp-Source: APXvYqzgiVqM7gJmbEFg7raQr0k+ZOYsPE50GjY6cVEFOeXVJhvA/Q7fm/mUkoqAAXJOPG240Hpn3A==
X-Received: by 2002:a62:14c6:: with SMTP id 189mr1665125pfu.23.1551789131875;
        Tue, 05 Mar 2019 04:32:11 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f193sm13669696pgc.3.2019.03.05.04.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:32:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:32:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/20] diff-parseopt: convert --ignore-submodules
Date:   Tue,  5 Mar 2019 19:30:25 +0700
Message-Id: <20190305123026.7266-20-pclouds@gmail.com>
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
 diff.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index a27bca527d..6fd6106963 100644
--- a/diff.c
+++ b/diff.c
@@ -5013,6 +5013,19 @@ static int diff_opt_follow(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ignore_submodules(const struct option *opt,
+				      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "all";
+	options->flags.override_submodule_config = 1;
+	handle_ignore_submodules_arg(options, arg);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5321,6 +5334,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
+		OPT_CALLBACK_F(0, "ignore-submodules", options, N_("<when>"),
+			       N_("ignore changes to submodules in the diff generation"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_ignore_submodules),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5370,9 +5387,6 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
-		options->flags.override_submodule_config = 1;
-		handle_ignore_submodules_arg(options, arg);
 	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-- 
2.21.0.rc1.337.gdf7f8d0522

