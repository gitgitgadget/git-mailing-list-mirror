Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF351F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBULQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45137 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBULQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id v21so10599159pfm.12
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpT0u+8iKoG3m0VOYYQxgNYeB/azPfiKzplGnayoX1w=;
        b=bpOH2jtAHy+HY5HtZkvf0GEg/I0Ar6kx6jpe8qPRGzjrJR1QAMpGPaiOGlAchR7F1I
         F55N3+Qzrj5TcyAvkTNmJceZueo4Li/qjPGJD0gsq5tIkjAlCiQ6Qwz2WEZv7iQ0sq+A
         hQ2SVYgMKGLukGoIgiwUl51jVRyT32QcuPYy2ZSdbIOE3Bvjp5fdl3mKgbzc1pUXaL4F
         r/A9Zz0639+VOohLHXwMJvgoEBnEib7WVE35mc8wJUlIgw4YQ6VhPQXI9YzM8zvcMSsn
         bKHU794I6kb7SURo/nBabZRdRAG8rg8QyLGl6OP9TCYGv3l17MZI5masMO97hzyTte1e
         u5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpT0u+8iKoG3m0VOYYQxgNYeB/azPfiKzplGnayoX1w=;
        b=V4eCljgD64wB4kgIpPCsmiSWf3StJsd3+mpAgXNHjGkoQyA6DjR524Z5ocWAmqoaIJ
         H6QS/mi8ehWS2q6libvjhj+F8pGkSx4eWz5N6kC1CDtc6soUKaSmN/HFh8uNrH/PtWfT
         xNB5bWluTHaVWELNseDlrHtvbiOdzTS43Sgz4P3QAtHcFo/bQ5AyOnJLybxSXrvrJcTe
         SPr/tRh4sjxTaxb947hUeyZeLIIq0kOzK+NyERAZgXvLcUXx7q+Pl/IQIjib1LVrCqEm
         5HveU6K01abk1SWnT2ue/0jFZ7G/a7DzjxCg5RxrOCh9DN3ygpmHFcS1VqqHAM7ANH8E
         a6uw==
X-Gm-Message-State: AHQUAuao+5jBfN3LUQKMBeSLRJeEmovbPRP7qQTIOcpvFS37aw5vxSWu
        zQ8LbhuZ95WzWCo/MhunbCHb7AV/
X-Google-Smtp-Source: AHgI3IbBfr+NOwsrTheW4YXn2WyjOjA62cCsIlHvah4Qjq8Uu7fvZl3d1uOoX7CpOlj4GDOznb7TSA==
X-Received: by 2002:a65:614a:: with SMTP id o10mr34429510pgv.387.1550747812706;
        Thu, 21 Feb 2019 03:16:52 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m67sm2405622pfj.70.2019.02.21.03.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 04/21] diff-parseopt: convert --check
Date:   Thu, 21 Feb 2019 18:16:04 +0700
Message-Id: <20190221111621.27180-5-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 1cdbe8e688..5e16082091 100644
--- a/diff.c
+++ b/diff.c
@@ -4939,6 +4939,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("synonym for --dirstat=files,param1,param2..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
+		OPT_BIT_F(0, "check", &options->output_format,
+			  N_("warn if changes introduce conflict markers or whitespace errors"),
+			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4967,9 +4970,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--check"))
-		options->output_format |= DIFF_FORMAT_CHECKDIFF;
-	else if (!strcmp(arg, "--summary"))
+	if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
-- 
2.21.0.rc1.337.gdf7f8d0522

