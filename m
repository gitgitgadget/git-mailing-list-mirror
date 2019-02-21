Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8F51F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfBULQi (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43490 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULQi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so13595153pfh.10
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6Rd8cdfbn/liIv8brLBqkSFYPlE/LyzcDZp6mECtbc=;
        b=ISURRD/7/0SZl/Ilj8J9HCq8Ss+nF2/xMAaUMiMR6TQNgCEo9wNaIgctoF+Dp2xVq1
         1ouxfJzYDmplOAxwfX5+rB0pzzoBaEH4J22NdV0JE8s1G5D7euT2jzHoNf/8Od0SrjAN
         3YFxEsA8i/pa1pI11m2+Sza6lm+VYQL/cmHrCO4OXY6WAAj1h0NbJIlccBOAQo134M+u
         8Zl5A96QTlXdw1bQF/a8+PZ/cFa0ofjlcqO36CUc8fj9UBqSviAir4+kIiM+boOMjuEr
         EuY1dxqOjDfiJdwfpUXwbnd+CvRogjvmnSwb8JVOuYnsUmcQnsOfRFYeCDZANXOASO0f
         uw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6Rd8cdfbn/liIv8brLBqkSFYPlE/LyzcDZp6mECtbc=;
        b=GPphmF3dSFGtNNzGIbbUawN5ktU9SYP1VI6JEWEcWGTPyirx7fALrIi4ayT3lw3Wnj
         mvtGgNlHapj0E8sgffo0ZD4z5URtcKTrmG4+DnbWWc7XqxtXcXQkviqyAr1gvaIfd79a
         NoAphwafk3J/WoiMz0pyduzmihNY9fX3SV8CUA4kNiikePiksEt/Z4esDXdGaBC6GcjG
         jngaVKFIEjcqtcPdK9M30gIjzK2EDCdBXgDqWLZqYD4LjKNY6ZbmMG7OT7daKcfOsX+R
         +rTZRNkK1JyXfXXM9D6CWgC1crBW8hbXB7rPBzZ6FJEbZc2FHm94O/Z11CB5aeHZC+ky
         XxZQ==
X-Gm-Message-State: AHQUAuZPiAgGHlzR97AdknzAkPCb/2/sR/1NTErWGMPSYefOhnsaBnxv
        tZA9VU83Pwj87ha/cxzsaJKITtdL
X-Google-Smtp-Source: AHgI3IZ+gOaXx85KBtQWzd9F12ISCOUmxQAnyrOd/kNNulobHMakAc6LOhhkk5hrvdYefzNpBIdc7w==
X-Received: by 2002:a63:61c9:: with SMTP id v192mr34629974pgb.120.1550747797285;
        Thu, 21 Feb 2019 03:16:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e63sm41182434pfc.47.2019.02.21.03.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 01/21] diff-parseopt: convert --patch-with-raw
Date:   Thu, 21 Feb 2019 18:16:01 +0700
Message-Id: <20190221111621.27180-2-pclouds@gmail.com>
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
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4bc9df7362..12e333c67f 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,6 +4901,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
 			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "patch-with-raw", &options->output_format,
+			  N_("synonym for '-p --raw'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4929,10 +4933,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-raw")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_RAW;
-	} else if (!strcmp(arg, "--numstat"))
+	if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-- 
2.21.0.rc1.337.gdf7f8d0522

