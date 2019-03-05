Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1015B20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfCEMcE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:32:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfCEMcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:32:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so5601242pfa.3
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHJtCZB0nRRXmayE8ilGlRs8+6kE3NJ01L0SChTZTR8=;
        b=GAI1pYdmu1Yjvpb+dQy3SZmSs6uq+x1UKzoaX1JvphhWsHiGDiZEf9/w9eGBkCtqKq
         mxrssbiuCw081HunQUXqHdNBC/zoXebKA+/2IoXjewVQ3TGJddjYUuL0XHVDkeFmpoqH
         pe+enr5/gHJFxw9sBDhYgHpZFSPg0lkd1Dkey89NVKU+t0954YzMzeiVEolGce7xe1/n
         t9U5kMXdbtG9S6HPNRJH4V6erMFFtH7OuriMRQ6Ss4na4PIKeipwi7DTAUMkQSeRpdRG
         LQeXKKg+oBmFCo9Kp9QVejVDuSMJ0rVeEFDYbFzKTBFgSttpkXPPKD6/W9CxPtSlQHZe
         BxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHJtCZB0nRRXmayE8ilGlRs8+6kE3NJ01L0SChTZTR8=;
        b=siZMuwDQj4ttAPD3g69D8eT0tOd2bzJ4gorBzSOLKB9l2XraadTJYQLMI4CSA6TrkU
         3GZG6y0dFjIwr6MOd8n8WlOzM26zGvyM+O+WCSffvEks0C4392C2aA+EzFptH61LcMaQ
         8i3USYAKdCAn2WFUtwRkKP/GhbdafhxJQPADO1cEfm4/Eej9F57KTKguByapOPVBJhjK
         3X45RctxGEXklFDPiW2mK2aBU+31Ty+CaW7rWEu9gKt3JOaTwTYGIJg5wlmhOAe/XzTI
         sjJSXD+c1pPtz2L/lRW7FdK3VLlu9eJJqgiEJMDVpGVc/cvxEuIlsqy+gHajgT7YmCya
         kjdA==
X-Gm-Message-State: APjAAAX8lFl36W+BFFLyMCp+MsQWIJU73CfwjatHwWfWozwiDdOPKteh
        9JYpmELhEtYJnjyc+ShO0GRi0zSc
X-Google-Smtp-Source: APXvYqyXKWKYdEego/oaA+hBr3HTcMj6okRTQFJizeYUhUX1Ul+yZgIiEVcUE9R1ZG1dAevg85pBWA==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr955920plb.328.1551789122774;
        Tue, 05 Mar 2019 04:32:02 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 17sm10546452pfj.80.2019.03.05.04.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:32:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/20] diff-parseopt: convert --ext-diff
Date:   Tue,  5 Mar 2019 19:30:23 +0700
Message-Id: <20190305123026.7266-18-pclouds@gmail.com>
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
 diff.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index bd15269346..b460fa010b 100644
--- a/diff.c
+++ b/diff.c
@@ -5301,6 +5301,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("exit with 1 if there were differences, 0 otherwise")),
 		OPT_BOOL(0, "quiet", &options->flags.quick,
 			 N_("disable all output of the program")),
+		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
+			 N_("allow an external diff helper to be executed")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5350,11 +5352,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--ext-diff"))
-		options->flags.allow_external = 1;
-	else if (!strcmp(arg, "--no-ext-diff"))
-		options->flags.allow_external = 0;
-	else if (!strcmp(arg, "--textconv")) {
+	} else if (!strcmp(arg, "--textconv")) {
 		options->flags.allow_textconv = 1;
 		options->flags.textconv_set_via_cmdline = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
-- 
2.21.0.rc1.337.gdf7f8d0522

