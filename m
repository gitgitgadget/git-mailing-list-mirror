Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4025320248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfCEMb1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:27 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39837 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so5591695pfo.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qPzDw1tId6zHZ/C5HYE4D3qBEIqkAOTAm9iLUqUeLU=;
        b=If7xb9gNZAjrUSkyJKkjXqJDK1jZp/H24KAV5l4LlmLeHlU8F17ZdFzS/Zl0xfW5RC
         qgTfaqADkcATrEQrLtkL83AWdPpho0qTndSFlRNWq+fRm923IvkaHIJWxaI0V/petbNg
         bX9R0QFjmJqRcjgaB/WLd6fJ95XodOV3b7Y1s1q5icBi7WIvcihsIAeDxzfgb94l68eb
         7P/r7iQ4SoL4YSYEB2qL93qCNGtfoKIvzJKRASkmtDWU+KTgBqEd7hJ6TOsYPCJ4uPTl
         MnBdh9p5rcsh1ntQhsiGFqv77WxuE3wCvxUJn1VcERJGSERVVaQIldoMYx93m66QhI+9
         HPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qPzDw1tId6zHZ/C5HYE4D3qBEIqkAOTAm9iLUqUeLU=;
        b=YWJBW143m7Y4q3W3jmoCKkdAjNgw42YdteBqTUyuPSW3tzY6WHThhDULSfr2JiqxTI
         QhQA3nL5Z/GL2DsoZIS4TQY5xtzePuyYQ/BtUFaZ/D3lEMV3MwsyvRXBseplHhGwKEla
         Fz+eVcGd5RQDZMrUp2EUWyqw4jjWP5y7dixNOCHshT7gbgA9Ghz8U70gydZZgi5XWDjb
         3j629l8IrzEAHP4PNBYP/oF7swP1OuYAQJ7cxYgf7N70IEdA8vdjVKKf4a0U29n9RSCz
         dZiyzd9Kt+2VndaZ1QbBYkHlLbdj31iijOovfFUYpKbiV6gm64XJ0mvOo4FJA/0+wZVB
         RArA==
X-Gm-Message-State: APjAAAVgnanvDtYPr/GsAnCcv2xu0F3MPbpOkdU8/QoEdiSgQNfYIPQB
        HYmG+4wGPoW+OekW8/KYYWeNSgnL
X-Google-Smtp-Source: APXvYqzAbzLyvM4CDZPHwA4sQeiLFnbM0iMF95h5ehdBn6lEK2nnssfdp+NVGRvnCh1/KXiMOarQfw==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr1183193pgc.22.1551789086224;
        Tue, 05 Mar 2019 04:31:26 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id o6sm24603063pgo.27.2019.03.05.04.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:21 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/20] diff-parseopt: convert -R
Date:   Tue,  5 Mar 2019 19:30:15 +0700
Message-Id: <20190305123026.7266-10-pclouds@gmail.com>
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
index 51d22f63fa..689dc11684 100644
--- a/diff.c
+++ b/diff.c
@@ -5216,6 +5216,8 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_relative),
 		OPT_BOOL('a', "text", &options->flags.text,
 			 N_("treat all files as text")),
+		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
+			 N_("swap two inputs, reverse the diff")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5248,9 +5250,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "-R"))
-		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--follow"))
+	if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
 		options->flags.follow_renames = 0;
-- 
2.21.0.rc1.337.gdf7f8d0522

