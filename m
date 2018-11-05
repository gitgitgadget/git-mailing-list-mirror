Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1908B1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 19:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbeKFEmV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:42:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35164 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKFEmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:42:21 -0500
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so7033211lfi.2
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 11:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9f93GFvnJNaMUSCqBeJf25Zr08F9PQE2gHBLTTBeU8=;
        b=QnOiorUaeaQT/zT1Z35qXxRHfJNO2K2tt7Ktc5yCQFmPgHsWH2UDaD/Ydza9Ywr2VF
         N/yuCL0oFrvebTvU7IvbdHg1fpemPly7nU2ImcMn5qnflWZhvLRF020TY+oujsq6lZ54
         KptoP+kGytVj6WkKRSJ8DN05i/u6qXcQ9y4fnTgBKWYMlDTHzBqbOpdHh0WC0mZRvhwc
         5xzxCW39IKqwvq25nxAyo18yI2glQg8fFkmwGwS6Mz87dttlkFqFhz8aIQqi9z/unF9w
         P7Dpc8l0c9D6wsHlDKdxBmIE6xd8FcMMjjHSqi23JhaymeVo6hsJGH4iaeqLvVhAjjxt
         95bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9f93GFvnJNaMUSCqBeJf25Zr08F9PQE2gHBLTTBeU8=;
        b=Lp3s5mvN2riCGgxxjcQZJJAXGTnhWsppTPLRc3fr3pKTdwOasX8AnXRLTi2jRP3WVr
         L4jfNBvgTprxzufomjN5kOLCw7/t4rnTXD7ssl+2VkOpkTap7wj4H6O8TDTQXO7n1onx
         QUP5Y87gsSRl5wZGrbOBdiezGBYvc8Zl7I17QU3dN3Hm1SK8w0SpjLJfI03fbxR6nQwv
         cu4guSq+J7E2E9cfqmg3vKI3RJEoTWJwMK+W0o0o7YddlQfgqZWFGgantRQpS5CYT2JO
         KsLw0s4UFizAWGRHAMVbKsR7PmqPtVcEDVMbnWnFcFD0X9t7L6arIXTq4LYvPNO1b0IU
         WXSw==
X-Gm-Message-State: AGRZ1gITZ5bD7dS3VjBGAP+w48w8EG4xcQ+KBd8ly/00qmFGGz4u9FiW
        HkhkGLeZEYs6ZnTw0ngGz68=
X-Google-Smtp-Source: AJdET5dWGBEI8uJFAzPNw5ymvVcr9w3bKrRmKsG8ju8CEfQ8wwfAdGJQ8O06gUuALuhR+KFPro4Q6g==
X-Received: by 2002:a19:c801:: with SMTP id y1mr12950073lff.53.1541445671020;
        Mon, 05 Nov 2018 11:21:11 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x5-v6sm3591056lfe.58.2018.11.05.11.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 11:21:09 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/16] attr.c: mark more string for translation
Date:   Mon,  5 Nov 2018 20:20:47 +0100
Message-Id: <20181105192059.20303-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181105192059.20303-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
 <20181105192059.20303-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 60d284796d..3770bc1a11 100644
--- a/attr.c
+++ b/attr.c
@@ -372,8 +372,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
-			fprintf(stderr, "%s not allowed: %s:%d\n",
-				name, src, lineno);
+			fprintf_ln(stderr, _("%s not allowed: %s:%d"),
+				   name, src, lineno);
 			goto fail_return;
 		}
 		is_macro = 1;
-- 
2.19.1.1005.gac84295441

