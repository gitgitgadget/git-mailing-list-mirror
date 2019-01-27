Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E1D1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfA0AgY (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43038 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so6351425pfk.10
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pCkKFNZ2m4aH+e/KBCXznOvoJnfrn+1I0EYfjc2f6lw=;
        b=pzWBU2jqZ5WtCx08FhtPKzimqU15O1pM6PcznW7pNVWedZWhQjXUahn+PvjwfeQgzO
         D0T5lvuLnqLrPAcdeiYBvWSI1/Xew9+AnYUWo9B7n5brP96OKGPE6LAzdRDXfumdQfig
         Egnn2aucY1TZ086jyfSR5x0Yr0Rofdy5mhueSkrtkpN6MBnhGnjVJZ9aoHBFqGAYsmuu
         aAZFVh4TXgWaMA7pmbdWa2s4K1Elzf87TfX61dNOTQ3AsWbFNOGPLrt48ltioQJ53jiE
         qOO/o7qLRJAc0V0a1BlgE18ljmdkRfOSC/E6oiHxoYO0g3qGcQp1ikIY9zluzF1xgYXM
         AmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pCkKFNZ2m4aH+e/KBCXznOvoJnfrn+1I0EYfjc2f6lw=;
        b=jkUZeUl3i3V8rT9Ho0Zxf4Qv7QVikCoEzpZhIr/dNr+4XRyGpZClbMpBaDtboVdh/J
         NneI3hEyP18L4To17BieR6JCduBfMI9fM2hA22Bv0HKdb4DBQ4F07BXolI+iLWWOrqHa
         zd4u/99tfqmSQur13FmU/v/HzhdMRLnl3NA/MxAtC5FdCIbRrU3l5zoffZmekD1W5DFr
         XTZVfhLgqxiBJc67OTV/b3iaCrGGJ0N8BFMl5rHhhzgxcpcfnp/zxC+Y2yU3Qbz6e5Z5
         IemVcSFRaZRAtbWfIRj0m0X8J9FFhWq5FRWxIR6V4DgcoPz6qKU8hxIHcqiy1mAky1wR
         //4A==
X-Gm-Message-State: AJcUukelMvi0ynr78kQxLkIzzEminvOWYdKy5odcNzOdn5JOIv9wl/7y
        +vNOykk6v1N2OnHPt8PNQCopzW8r
X-Google-Smtp-Source: ALg8bN7SKXPJeqW7KEX6lToLZYV/YXL3vXVxqI/gmSJ+SwifeW1VqDeGbYq27pkLNv7iv4snsgPLzA==
X-Received: by 2002:a62:37c3:: with SMTP id e186mr17017630pfa.251.1548549383184;
        Sat, 26 Jan 2019 16:36:23 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b13sm3906455pfj.66.2019.01.26.16.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:22 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:36:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/14] parse-options: add OPT_BITOP()
Date:   Sun, 27 Jan 2019 07:35:25 +0700
Message-Id: <20190127003535.28341-5-pclouds@gmail.com>
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

This is needed for diff_opt_parse() where we do

   value = (value & ~mask) | some_more;

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 7 +++++++
 parse-options.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 779034e1fd..62d94ca2e0 100644
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
2.20.1.560.g70ca8b83ee

