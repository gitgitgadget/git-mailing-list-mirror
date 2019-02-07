Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7126B1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfBGKeP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36102 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBGKeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so4594362plo.3
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1IOAzBSocPEMUWr0CrNDYuDjZkcAbvhw9Vz+NH+104=;
        b=mYQYIVTD4D4WgSKFn5A5F6vPAHq/ZLi9mg7zyKmSIGQduObnzhoG0xKY4Q0S+lyglG
         h0jBGeBXt73uHjgCndHY/8ACJgBVJhXLWeQEOM7K42+ArJzIQm/pgqxgUmx1sIaPlI/q
         n4n91OEo5/gpK0GfjZLd3fNHuVgJpRmMyRZQ8XaZ4uydm3gMVeM3cubG39nBIhlZx5iO
         8gvDPVNvbDJkAEy/O41HtR5iXt3PrCKVtNUyIyzVrMDlNQRX3vIXlKteo5zqsBN4ftiA
         /Tkst4wW2zPJkVRtAm1dFw6oEuAL/zNSVlqVhzOOPbsG5K3+ewERJJtZI99PBwSzipOG
         GUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1IOAzBSocPEMUWr0CrNDYuDjZkcAbvhw9Vz+NH+104=;
        b=G1Ty/q1kxixO5Y6Xty8nBKiDYNy6WPZaBcooUnhG+vlw28HyhjKPjXseHveH3doPIV
         DgJ0pKKTQ5rTOlNwMCQVMZbB5/2SUO6NkTqBMFvgtVhcew/1/E+PIFGCuuNlOH2HHGam
         CB1MQFvb46l+3j8GjnL/MfikRJovqw0wwVtIa0cQoGknHsz/+lcEfa6DxqOWsQkXja2y
         2IVAwnQ7r4Re2j1AZymKbCVlCkOSP9/effQEOeSUP7Glf85tS/47UIP0cBDZu+bMJB0I
         stoXAQRwFTHhRdo6oHWwn+rMRhMyRmxsK/D8lDhE9mqnYL03Giz8iFJSFew6JWU6xjBg
         XJWg==
X-Gm-Message-State: AHQUAua10iZEfLyIYHiv+iqxY1biivlnAo9t+TqNKJbvDESYRxcieChx
        b0Z4Sf93S/GWyQGzRnTl4x7umcN9
X-Google-Smtp-Source: AHgI3IYR566cSL2CKB+rp5spOQygFKVk77oXSu+HdxatIn81qz4dullTz78pK8nnEdpDNC7Ys9Sy8w==
X-Received: by 2002:a17:902:aa8d:: with SMTP id d13mr14096702plr.293.1549535654471;
        Thu, 07 Feb 2019 02:34:14 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id w3sm16289098pge.8.2019.02.07.02.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/21] diff.c: convert --patch-with-stat
Date:   Thu,  7 Feb 2019 17:33:11 +0700
Message-Id: <20190207103326.10693-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0276f25200..b9811aefef 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,6 +4921,10 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "patch-with-stat", &options->output_format,
+			  N_("synonym for '-p --stat'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_BIT_F(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
 			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
@@ -4973,10 +4977,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-stat")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--name-only"))
+	if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-- 
2.20.1.682.gd5861c6d90

