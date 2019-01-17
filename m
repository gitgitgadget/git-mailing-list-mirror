Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF1151F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfAQNG7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:06:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41205 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfAQNG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:06:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4716622plm.8
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNTOyG7IfPc9r7yVW4Pf95cjn6zLM0T+/waM9jqUUdU=;
        b=RwoSX6oP2v3BDN3mCfYXrp2V/LXDuuVFa/fCfYwUhJunvMRhxMDFR8FeUD0twWiet9
         DgiX/KtaGGFeVAX9L7ZZA7an2/vmOCH4h2i/IXhc35GP4lQ5KLdWJRAFYFPvR0orY1nE
         zOZeMse3Ae+R0pbrXrkD99Fbh/iIQ8G20W+N4eh0kmu0oLAP0eUA3Vy6QUV7/DJpq5Y2
         j4UcQvtOjyIp1E2hyRV214KTWT3DdAsG8ksYnM3rOjxqeqao4E97ylY6HCSMNPIbWSnQ
         SPM+nOjOLiiYL82Dk9F9Z3oOITR1NL+f3HE9wof+oNus79wdE+lPQPhhaXejf7PWwcVi
         7o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNTOyG7IfPc9r7yVW4Pf95cjn6zLM0T+/waM9jqUUdU=;
        b=aIIy036foZBsHfj0HjK58fKABBqSzxupx5HcsfW5uXPpopUVG8nwdKrV7OEeMOBjXw
         XIRa4onu6ZIiGVxx6UVYW1seEsHlxfCiIjAAOy6z2DzwZJDSx9rCtaAzTMS2MU+BXgB+
         j5d+vYUjUUCPRjluFiORVbWVJwJDCeRU9pa3rXt4uwMASHNrh/8EqkZHx8rNv/iZMSOS
         HcHBkVoxTxLxxyYv2hVTbMAzmM3hY8k/U8lcw5oM7ENjhyvtj+O5oRKuRKF2NUOO24Yh
         zDvo4Nm1lY4mI6WsGCEokuAWv3qLTc1hWwgt7DInhVyny7Fa5aCbT4fanMwBcW9BYHFR
         eV9g==
X-Gm-Message-State: AJcUukf6ZLZC1tPTdAlnrcqUuT8CTBlHKX1S5XGwahB4E+GqKcCG5+G3
        5/eQqtS2X014UChfs4OiENcf5WpK
X-Google-Smtp-Source: ALg8bN7xvs2zmLRc2ZiLtK7Ow4QcqjL6MduGn/1DhB7I7yhjay5c/M8YTnoAdkLmbchhpaG6Hgi2Rg==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr14997770plr.15.1547730417885;
        Thu, 17 Jan 2019 05:06:57 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t24sm3098082pfm.127.2019.01.17.05.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:06:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:06:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/76] parse-options: add OPT_BITOP()
Date:   Thu, 17 Jan 2019 20:05:04 +0700
Message-Id: <20190117130615.18732-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed for diff_opt_parse() where we do

   value = (value & ~mask) | some_more;

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 7 +++++++
 parse-options.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 9710ec9d5e..1244968855 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -109,6 +109,13 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value &= ~opt->defval;
 		return 0;
 
+	case OPTION_BITOP:
+		if (unset)
+			BUG("BITOP can't have unset form");
+		*(int *)opt->value &= ~opt->extra;
+		*(int *)opt->value |= opt->defval;
+		return 0;
+
 	case OPTION_COUNTUP:
 		if (*(int *)opt->value < 0)
 			*(int *)opt->value = 0;
diff --git a/parse-options.h b/parse-options.h
index d663b83973..c97324f576 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -10,6 +10,7 @@ enum parse_opt_type {
 	/* options with no arguments */
 	OPTION_BIT,
 	OPTION_NEGBIT,
+	OPTION_BITOP,
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
 	OPTION_CMDMODE,
@@ -118,6 +119,7 @@ struct option {
 	int flags;
 	parse_opt_cb *callback;
 	intptr_t defval;
+	intptr_t extra;
 };
 
 #define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
@@ -133,6 +135,9 @@ struct option {
 				      (h), PARSE_OPT_NOARG}
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
+#define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
+					    PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, \
+					    (set), (clear) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
-- 
2.20.0.482.g66447595a7

