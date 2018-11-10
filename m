Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B011F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbeKJPYo (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:24:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44261 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeKJPYo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:24:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2808591lfe.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHBFgH9ML/AasrGcZbij/HIUVPSxIbs0Ds5VfXDIWrw=;
        b=QxhX1qFOlqQm38nNRzIcvYRLbQVz47TqvcSgobdS9PK3cdkN97NVB/3DBIfkOwmiKv
         p4A1Xu0sRp/XH9jOb0QMSFJQMICzbd22ZtJnAHNxKQ37IRdBBisgfg/zD805ohViCZAc
         FNTJ9jse280Iz4pEBiLp9BRqa2GBsTQ6oA5QB70R8RTLONWGoDv0ejn/LsoN/AajWVFy
         prDhxeNycBMfoH1GeO0B/W+Wtnv8qiML/EFH6brquAsjDTf0HtW95Aefk20/PoCEuoOr
         bQu4awLn7Jg76nGGAGzwJofNzvTda2A0LjnJlqU4FaAOWwXP0JWbgmjmaZyJvqoBYSUP
         F68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHBFgH9ML/AasrGcZbij/HIUVPSxIbs0Ds5VfXDIWrw=;
        b=nnhmfvEpHQlliaIJme1eZbmBpLmufELKfOvWr7V9mIvD9Elf5oHGsTkZk1DEIJ2j5E
         90MiH4pz8q8tNfDAhiQX56AJTTSjnWSl3saX5JeWdj/AbyLrUCcQ+lmjohtZRRnR6uU3
         57x72dmv60CzHwIeaYHnWVUo9m/+t7zFd9ZY9XS+iWm7ocai5mh+ALM0yNpusKiGZi0o
         m77uDDK4nz8iFAV6dLbnMYrJaWZr53odq61bfZAx98DJ3uerORbmPxFQIwFG5lmWUGu+
         dcie4ENomhUZSDG94tfwRXAdDSkrVpIwxmR35yswX9rQ1b5RcNrQEuc81uOFozUZe/n+
         i+Nw==
X-Gm-Message-State: AGRZ1gK4COC1ujndRl5nvpquCa8PeTXfTwAoVdE2+X7EaybHPw/3wvWG
        jx5Gr1rvCwr/OqIe46OtdGo=
X-Google-Smtp-Source: AJdET5fxsuRxrAdMn88k/WNLFXvkA40L1+LT+N1Ox0m5VKLQQpoFHvlroyW3DXYU4KkOzWeNj/RYKQ==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr7272248lff.123.1541826987051;
        Fri, 09 Nov 2018 21:16:27 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:26 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 04/16] attr.c: mark more string for translation
Date:   Sat, 10 Nov 2018 06:16:03 +0100
Message-Id: <20181110051615.8641-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110051615.8641-1-pclouds@gmail.com>
References: <20181105192059.20303-1-pclouds@gmail.com>
 <20181110051615.8641-1-pclouds@gmail.com>
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
2.19.1.1231.g84aef82467

