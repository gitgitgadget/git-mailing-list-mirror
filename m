Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7B81F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfBULSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:18:00 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38063 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfBULR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:17:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so14020701plb.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PzgSoRaC1NRAN1R0WQUg0Fzdn1CVlCoPCtBlKtDGCkg=;
        b=Llj3oCnIDeCQ+yWwBpw4uDDDitte4hF12CvXNHLW8SrmYjuanm6WTryUFAtrz48H/i
         8qr6sLGvCRaKDkrIwLmjoPvGhaQTPoC7VU8q8pjBQVJM9AYbpLIzDGwWJqSLmAZp4Sqy
         KSZmWoIOsBpIlj+84dLN8Z0YY/dkVGzqlNxe7AsOz81fDY4DT9VFYTys2VxW1y3pMDuX
         hVSTzL3NgKac4LdDRrghODCDuCRYKdFWb6Q21cmTPrYuooPbOtdhkcR7EiEvCWJg96ik
         FSHQ405GHrfdA6Okk7t7KH6vZJMH1irx0QlMEzFvquQhaJjgcD0AJFD9eoeMPTXutM5K
         F3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PzgSoRaC1NRAN1R0WQUg0Fzdn1CVlCoPCtBlKtDGCkg=;
        b=TTyZtGUJXPYcXopS1Td4JLsp+BHV5SL2dK/ndZFeEO50gEm1XfvZ6kJp5A0T/QVXj1
         yV8fzh+qIaBhOEP1L8axmbkI53snPaDtWPtbAlltprbA+oGRWfbUdgqu6TW5vj4YqOse
         /7K/EqCTG4JPd9QXBXcbKfFuYIJco/MlDIYktbwitdSJ9ZUQNgqVuSgR0RYJtAGWrg1n
         /UuP8GAqlWoQkF4OBcqxCfNd8WuTB65ZM9RkGEA/h2sPIhIr6XZv0/wyrvRoEggjGLWd
         FFpSFp77Tk8dZZrjm2/9/a/kUHFtx44oc45opZVckfwwQGe1X5kvhGfMbqTvjQ7SAVU9
         u5Yg==
X-Gm-Message-State: AHQUAuZuwenyd0PO07PRPPVUflkL0vYy5zLqUzMleQ34zDQG7IKKRX3v
        EWUHGbq5Y0esPq/XrjVK+VWLNm3V
X-Google-Smtp-Source: AHgI3IZND1qwloeh8aN72q4LYl7MWRHcb2ufRN4TiEH5XvtfG2vgRnd+bW9Wg2yIONoNnsbF6aMlfA==
X-Received: by 2002:a17:902:7d92:: with SMTP id a18mr25333032plm.215.1550747878930;
        Thu, 21 Feb 2019 03:17:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y66sm39918537pfy.66.2019.02.21.03.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:17:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:17:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 17/21] diff-parseopt: convert --find-copies-harder
Date:   Thu, 21 Feb 2019 18:16:17 +0700
Message-Id: <20190221111621.27180-18-pclouds@gmail.com>
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

--no-find-copies-harder is also added on purpose (because I don't see
why we should not have the --no- version for this)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 35bac115cc..abb1566f95 100644
--- a/diff.c
+++ b/diff.c
@@ -5085,6 +5085,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect copies"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_copies),
+		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
+			 N_("use unmodified files as source to find copies")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5191,8 +5193,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--find-copies-harder"))
-		options->flags.find_copies_harder = 1;
 	else if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-- 
2.21.0.rc1.337.gdf7f8d0522

