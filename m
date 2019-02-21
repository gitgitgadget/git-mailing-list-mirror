Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB6A41F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfBULR2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:17:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35098 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBULR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id p19so2806185plo.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyd7LIgbA7LF7r84I4VnYjXpCkPhMnAtEwWVikbczkI=;
        b=EUpJxBPrIgQGWDar8/AiJaRwf/4nz7EZ2M4MvsRRfq8vytxrZYx2rpHlRCt0IYynDK
         ryFD6DstCdqaXMgwauUEVFQsEcxBBuQbcyQAS9Me0GbZ6GYexpfzlDYaufYTYDwhX0lE
         kX7mdCSNuxQpPSgQ1EfOaNNR1s2FcSVgnkU19Mr+AMignHykH7bYKljq7QHTXFhmNmyo
         Bp65dVoOvqjjenQY+qjWDXBXpG5V+f3Sfs+6KUSmUetXIG5EDH/nOOW5bOplWrOOCrND
         XEKhZQK9bIgRm/p17eOTO8jVQdg/cn89KIZW1k0R21+M3rmSHtLtpa0kTE2pqbxUNXcM
         BRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyd7LIgbA7LF7r84I4VnYjXpCkPhMnAtEwWVikbczkI=;
        b=pialzFRc0nXdtpBM/xsA1NU5kVCW8TtN2troz0qlokOMDZHs+/WZdVoNsdQnn9D0sD
         atc2FdyEBWwFT2P9sHFO9gZm0NyGN7wn5xRv3JkfiVbPAG7q9m4ScgKfcpDcF/8UlIbk
         D+GqRY+Z7vH0M6sHd/LynR2+ez5PawxrhtgDHGO8gHghr7P9QudG6kMCNObFssZUEsnI
         OT91p50AtGarRpEUHkQy/y7kAxK5BNXXkHDM+hFl28XvD96CQ5/RUwVk5+y4inFzDUJl
         av8OFLRoVh9i87Jlb01xnHFRIln6g1Z5CYWcq+CLwvUlILk/WdeAVWLKaILL6pTYqTR3
         kAiQ==
X-Gm-Message-State: AHQUAuYQutnVy1OXaUo8Mbw735xu2Z2qbwSbLuyKYWjT79MzArayQmqP
        7BHMT1XDFkbNKzYSaSGEIb/nMzHO
X-Google-Smtp-Source: AHgI3IabyE1nlb1dsPExNiULUadGM8uH+CWBiyQXkcv8EHasDKL3y6etmLySIOgbQR6+btVrog5O1Q==
X-Received: by 2002:a17:902:8485:: with SMTP id c5mr11817449plo.67.1550747847832;
        Thu, 21 Feb 2019 03:17:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k3sm24466801pfi.129.2019.02.21.03.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 11/21] diff-parseopt: convert --[no-]compact-summary
Date:   Thu, 21 Feb 2019 18:16:11 +0700
Message-Id: <20190221111621.27180-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190221111621.27180-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
 <20190221111621.27180-1-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1feb13deb3..b24f6825a1 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,21 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_compact_summary(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.stat_with_summary = 0;
+	} else {
+		options->flags.stat_with_summary = 1;
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	return 0;
+}
+
 static int diff_opt_dirstat(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4947,6 +4962,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
 			       N_("generate diffstat with limited lines"),
 			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
+			       N_("generate compact summary in diffstat"),
+			       PARSE_OPT_NOARG, diff_opt_compact_summary),
 		OPT_END()
 	};
 
@@ -4975,12 +4993,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--compact-summary")) {
-		 options->flags.stat_with_summary = 1;
-		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--no-compact-summary"))
-		 options->flags.stat_with_summary = 0;
-	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+	if (skip_prefix(arg, "--output-indicator-new=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
 	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-- 
2.21.0.rc1.337.gdf7f8d0522

