Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF831F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfA0AhS (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:37:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40712 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AhS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:37:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so6362602pfo.7
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sh2SzhnBPZvr+Fjr05yLP6SyI9u1WEtTh3FN2UE1lzE=;
        b=qekmv1Je6PhD8+rPjL3pYNw62kIRSGKrSc3D/tX67xhj/f5Hf6MIt8dmj6hNq8+S4y
         WBw60u50/LGR/r9Hg0E8+k76G1VTz/9EhiYBj5kKFePKoTV9a3DNWG4r08PL6GB4NEVV
         UGbByN6cD2IcN7A3RJffXAFEtu35kV0hCVIMcaLVBhyALbulkkGvMwUy8qUvId3IDg9C
         Yf5BCFCOHk+KJpr9BsmcyVj+VIdyPUrQtpGHbwq0b5tFldplna0MyUZ8/eQXyuicScrz
         wLjBXWqHe+GuoRhS1+AVEK1aaLVZjYcYT5o/el/2hBF3HiVOAkUsRNqYHjQdFsxwwVHL
         2KTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sh2SzhnBPZvr+Fjr05yLP6SyI9u1WEtTh3FN2UE1lzE=;
        b=kEX9pz68MeyxRkPrgXWROeKQJ+1Crufjwc93sX8z1t2DH6ESMdxz8uquSy/XheGJWg
         OYpjrI8/95b0C5PS4Jv00STf2dxCEyjgWNzK2xuSRhEkdszHOwZdUqNwfztrlOz5Z19k
         AdlyNxR5PYodBw/2tGcLC+LzCYb6vIgYCT06PRG09fxGc4jyOg9zvIv2kW4YxMSVeM+6
         lZD4Us70m6gW+fuNm50Tr8e65o8IERRhHffG7TjQgeOA/f0JlDDE6iB5xhACbwceHMIC
         G86VtlU0WfHykNiBhZ12IBGs9WMb2EqrTpIGBZQjjDRV0XLrlIPG7TJUymx3aWJaBArA
         Arww==
X-Gm-Message-State: AJcUukfK9sA+1vRQXf865ibpkKJrwdPCwr/EH379tr7+1rZQt7bxktoq
        Bv+spw1DY2xSgVmpQ4CIGfycYrV8
X-Google-Smtp-Source: ALg8bN4fkXqKzCzI2zecAA4ecryyDi62lkE7sccF818se+Ho2U6PyQTH0NEZpE9nt/MYKu0JuQL2sg==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr16743114pfc.113.1548549437419;
        Sat, 26 Jan 2019 16:37:17 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b7sm38727273pfa.52.2019.01.26.16.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:37:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:37:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/14] diff.c: convert --raw
Date:   Sun, 27 Jan 2019 07:35:35 +0700
Message-Id: <20190127003535.28341-15-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 8f70101362..4bc9df7362 100644
--- a/diff.c
+++ b/diff.c
@@ -4898,6 +4898,9 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_NONEG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
+		OPT_BIT_F(0, "raw", &options->output_format,
+			  N_("generate the diff in raw format"),
+			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4926,9 +4929,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--raw"))
-		options->output_format |= DIFF_FORMAT_RAW;
-	else if (!strcmp(arg, "--patch-with-raw")) {
+	if (!strcmp(arg, "--patch-with-raw")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_RAW;
 	} else if (!strcmp(arg, "--numstat"))
-- 
2.20.1.560.g70ca8b83ee

