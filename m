Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17B471F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbeBILCt (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:02:49 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46849 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeBILCs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:02:48 -0500
Received: by mail-pg0-f66.google.com with SMTP id a11so3390053pgu.13
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuZ14cFRKa89U30YkHQwykDmt5zFfHl9RC7HlDTnrbo=;
        b=t4njroZgEF9CVzflLxKwb35pPeK2R6UduwyW2xjwvfR7+K00pYsG1k3AVPmbnAWskL
         akopPpSL33J9uIVGDYbDwkNm8Z6SD3/IT0qC/vkdkWA0oV5Wb+L2vzPveW43RAO1CY8O
         Tcc2WAxpv1Ho+NwRsKPm2+4pru6hrOa988vR4aRlKFJ/zJcqDL4oGSCcCFxSPhll50xD
         X0lQ5dD+yAs4E8YNxjFFmhblsbqS2dPRlT5GTTWbZczsrFmeAal1LVqu0vo4hFEDhDNG
         ew0TEgCaBiqCZ4hTA3YZiN1soiU0zgRNmN3Q2e02uRwNWD+hOSGiYw7Kewez0Yld2/p8
         FHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuZ14cFRKa89U30YkHQwykDmt5zFfHl9RC7HlDTnrbo=;
        b=sBUWaXtAfUdrARloN1y2f/vKiYX8g51oMouoOG6CFKirnlovCxPqVP8jc78jS5Odcc
         rPOjwUpQ2HXpIdbPsYNUmo2OeTMh87uKZoymDigUhj/+ssc7zzYVVE1t+5/lGHsGVJtz
         5BzEtdWhscyeEluYKDDTNH5HSzH5/X1LunvlOCpN8lqnbC4VQzgLDlso7wvgQEw9hq0R
         CrfZuIyyqJetY68VWzliELgnzeAOSWX3k8x7fp9IqEkCBLinVarp/uxDwy3LtltULzQS
         aAptiPh3KeaJupk0KIBcO+nIb8C+n86/0OAiDFUvVdMj2Ssz61zfik7DHlYDSnbqpLrQ
         wOTg==
X-Gm-Message-State: APf1xPAv9FF8OJ36t5QD307rhi6uBl5GkgaWPXyPw/wYV9xtv3BrB18k
        0CcYT1y9J5zEnSZERcS30Kzaaw==
X-Google-Smtp-Source: AH8x227kkx8oNwUk3XIU3xt1FTdyELoCl9rdSP8wGpCwAvBk+DU7lcDqSXNdUCQ1PgxZt2KJmjEFqQ==
X-Received: by 10.99.191.78 with SMTP id i14mr2121941pgo.9.1518174167556;
        Fri, 09 Feb 2018 03:02:47 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id s89sm5484487pfk.35.2018.02.09.03.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:02:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 02/42] parse-options: add OPT_xxx_F() variants
Date:   Fri,  9 Feb 2018 18:01:41 +0700
Message-Id: <20180209110221.27224-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These macros allow us to add extra parse-options flag, the main one in
my mind is PARSE_OPT_NOCOMPLETE to hide certain options from
--git-completion-helper.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index a5caa0bb1d..05a6839019 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -115,19 +115,24 @@ struct option {
 	intptr_t defval;
 };
 
+#define OPT_BIT_F(s, l, v, h, b, f) { OPTION_BIT, (s), (l), (v), NULL, (h), \
+				      PARSE_OPT_NOARG|(f), NULL, (b) }
+#define OPT_COUNTUP_F(s, l, v, h, f) { OPTION_COUNTUP, (s), (l), (v), NULL, \
+				       (h), PARSE_OPT_NOARG|(f) }
+#define OPT_SET_INT_F(s, l, v, h, i, f) { OPTION_SET_INT, (s), (l), (v), NULL, \
+					  (h), PARSE_OPT_NOARG | (f), NULL, (i) }
+#define OPT_BOOL_F(s, l, v, h, f)   OPT_SET_INT_F(s, l, v, h, 1, f)
+
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
 				      (h), PARSE_OPT_NOARG}
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
-#define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
-				      PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
-#define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG }
-#define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
-				      (h), PARSE_OPT_NOARG, NULL, (i) }
-#define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+#define OPT_COUNTUP(s, l, v, h)     OPT_COUNTUP_F(s, l, v, h, 0)
+#define OPT_SET_INT(s, l, v, h, i)  OPT_SET_INT_F(s, l, v, h, i, 0)
+#define OPT_BOOL(s, l, v, h)        OPT_BOOL_F(s, l, v, h, 0)
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
-- 
2.16.1.207.gedba492059

