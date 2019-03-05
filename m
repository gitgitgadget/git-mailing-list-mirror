Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F83A20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfCEMb7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46176 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfCEMb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so5544834pgf.13
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZO/SapRkxoHh9jFbm6g/cmLzETkMPwQCVij31eIMm4Y=;
        b=tVdq0CbkIRpFTh+kBn62JNri9/KHmD+DpYF7wywUwykuomtqpg/yQkAUpNlO44oucS
         ns4ZxXTfFy2aVM/wXuS2aABD2iRTsc5dboqVX1+V/vhC4KjH8IHPF0ZHFoOHpX6+J6dO
         ZaG231ZRL7C+R+wyy72pVbkxXPPhhcZqrxq7u71u/m9Xg0U1JATFgWDYn8PJL+M1kxaU
         +OHYgXhfXNDHyGZVaeBrw+TRb9ZK1E5TrO23r5n1/tkTVcA/Ktzh2JjTtGy0hrBJ8dI9
         7qgl5zN0sBBZnIHiFyUdnXHlwa+xcC0btCuSGWffXLzPGlFX6NU4sDTpDzcFIVzMPeyv
         t9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZO/SapRkxoHh9jFbm6g/cmLzETkMPwQCVij31eIMm4Y=;
        b=ZJjOUj4ZnMCy9klWzvfkT31cyOlWWItYdu5UKxWglHeng29Y9YRPrWtZ59qbiEwobH
         sdFre4ZMqbgmk3jhaBd/ppwjdRDKF700yD02S5vl0up/LtCUpnUDO8ijUwRGXZ0ehmw6
         +jiRpsojQ47MXpuj9b2HOvqyHkmjbCqhfNIxlirc0xMresWefX8nSoqjdTIlQ3RTJatM
         acTxrn+nSEK5FbXZ2hN5WEwnC1DWgODnfusAB3QAxPIMXnuTmQDCxKX/LIxfMeuGh+nE
         ENhpn6J37VNQxzt48dmjOIeW7uwi4iLDd2I4b0ruK6WM3xsUmSAydTuFPk/fSuK1M0sH
         38YA==
X-Gm-Message-State: APjAAAUaYlq/SX23s3ebkWGMeHns4AaDL9oWe7fcZHCqPV2yoQFuCeXB
        sjimeLZwrAD8Ebf0XiXYhBEQ+ubk
X-Google-Smtp-Source: APXvYqx92hC9lVeX/HzhJTJL5Xx7QJYltNnupUTMbazWIqTSvyW+KaY1sWOR60eYKV9HEiRmc2SHlg==
X-Received: by 2002:a62:39c5:: with SMTP id u66mr1582934pfj.245.1551789118337;
        Tue, 05 Mar 2019 04:31:58 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p14sm21195544pgn.34.2019.03.05.04.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/20] diff-parseopt: convert --quiet
Date:   Tue,  5 Mar 2019 19:30:22 +0700
Message-Id: <20190305123026.7266-17-pclouds@gmail.com>
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
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 3f80e06de5..bd15269346 100644
--- a/diff.c
+++ b/diff.c
@@ -5299,6 +5299,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("swap two inputs, reverse the diff")),
 		OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
 			 N_("exit with 1 if there were differences, 0 otherwise")),
+		OPT_BOOL(0, "quiet", &options->flags.quick,
+			 N_("disable all output of the program")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5348,9 +5350,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--quiet"))
-		options->flags.quick = 1;
-	else if (!strcmp(arg, "--ext-diff"))
+	} else if (!strcmp(arg, "--ext-diff"))
 		options->flags.allow_external = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
 		options->flags.allow_external = 0;
-- 
2.21.0.rc1.337.gdf7f8d0522

