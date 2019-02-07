Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4FF41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfBGKeZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:25 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:47086 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:25 -0500
Received: by mail-pg1-f174.google.com with SMTP id w7so4294492pgp.13
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lbFRpzbS+pg681IDlCenWU8C+ZMZAefCl1d9DcVUJg=;
        b=nbJQuFYvJQBx0ZtciSc7YtH25IyDLZ89PmjWVyO/cKkPG6SQ6Kzuw4KdOvjvYLGLGW
         0jnq2q/Jv/YaPSk0hnao2pxG5ke1A87rlVpjNFsnxXEODEJsqucTLXcUr5Rgpdh0ikL7
         AXVcw6u1no5LWZ+oEqvwNuP8CBTv7bwYTuXK8Yuf9JANNmvQSoaTm9LVqkAr9UUcmBRy
         fj8QoJlIZGrB5WULlrLHepzlSL1xeCTbhH3aBYw7ABfO01S2W+sxt5gSVrZvpwmRxUD7
         zp9rOh9avYv2EHCzLvuo5EwWqtvOrzthuKo+e8ZqfpCU3VAf8FS3IKIE9y61C4E2LFtM
         K0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lbFRpzbS+pg681IDlCenWU8C+ZMZAefCl1d9DcVUJg=;
        b=XVysR3b6NKASfqr+uDf0LmgvYtYfiVHE9LRwijLYDPGT38/37Z6h5s3UzhGce2m2MI
         fRKSTZ6bkrr6eVZ4XnmVkvKQ4n9IrzY/iDONAPxwA6jlEP03X0wSg2Y0Gt64Ym9Bz8zr
         u68DdDAHV3eoFspkIS7QLqYutmjTwMcy4rIpubLp6cUnI/ytsfeHtQP8Ckxf9Y+g21SD
         JsIJT7o1TjFnK1gTzDuVmnbmxwO6+bT3CqdXAGF0nCeyt2fP3DxygU9lNDAmWOzCWnc5
         1unVDj9wjPypAjl8PlbdbZ4JfDBa3XZXyc1AIM4Li1dNUcPp0Og7fbuMyAIXKe591SHp
         c69A==
X-Gm-Message-State: AHQUAuZGnRRJvLAkfBmtQzCu9MLxrIv4675dWDwovcbgHJgdaYJIZoVu
        dolHW9pEct5cdoZcQLE/c0dP0gYI
X-Google-Smtp-Source: AHgI3IY1dqYWCTLvp1JdGA5BYndTUKeTnngiF5n2kJPUZzAxUgXXyX8dOfWRbJUIoz77SACNr2cWEQ==
X-Received: by 2002:a63:1a5f:: with SMTP id a31mr10058152pgm.335.1549535664332;
        Thu, 07 Feb 2019 02:34:24 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s21sm14706888pfk.133.2019.02.07.02.34.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/21] diff.c: convert --name-status
Date:   Thu,  7 Feb 2019 17:33:13 +0700
Message-Id: <20190207103326.10693-9-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 7ea308814f..99047fb5fe 100644
--- a/diff.c
+++ b/diff.c
@@ -4952,6 +4952,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
 			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-status", &options->output_format,
+			  N_("show only names and status of changed files"),
+			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4980,9 +4983,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-status"))
-		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
+	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-- 
2.20.1.682.gd5861c6d90

