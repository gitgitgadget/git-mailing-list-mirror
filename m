Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 874CA1F453
	for <e@80x24.org>; Sun, 28 Oct 2018 06:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeJ1Pfv (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 11:35:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45107 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeJ1Pfv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Oct 2018 11:35:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id j4-v6so4780387ljc.12
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djLcnc/ogJNL4Z13pc77uU3n+GglYQ7EVoZPsqvs5Q4=;
        b=DZDgyfAd6h+PwSiBo4JpcLSvE4VjM9IUn1qOt715nPrgPMGa0UHozW453N5er6nxML
         TBKAEAdRHqqoozM3k45Xd9FoTNZa5yAgF2NVre8vGJ1fnYvYXrFHypUs7WLjnNZVug4L
         u6ztxU0x7xONNDwHlrJgvu6ygTOIQUTfBEhUsa64ePkbnADzibcmhEChSJEGca9SBO6H
         w0dX8ju/4cW0vdOu8JJxdwlg1HNWU79VCi5XhEmKwfdBI7Ps5jGNdhrqefQq4OlVkJQ3
         H9aoyG4BZq4O/Q3FpQj2U2+2vEZAYoyXMAEu9oRzPJvXjC+VwkHKqJCHRe+B05vEeHLx
         m92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djLcnc/ogJNL4Z13pc77uU3n+GglYQ7EVoZPsqvs5Q4=;
        b=WKRDupROVEfESxzRvRL1jYwE6eirI3virAlpstwpDudRhEDDBrs4PeTkwGmGGlTETo
         +BBjjJgeMQ0qvW2BEVJ/VHabYKXB3z+iRB/1b3L2ssjPhU53x2S14pRXk7CxWUDWHwN8
         O53CSbMBaSaZF+crSIDBXVQsglJhP73DTTzLqFZRo5ZTIXwY4mrVOTnZknatTK6eDtW8
         tbvgDlWd8NQjWgBd/GwK5H6mEuH2lzuwmPOydcSEYYohqJrtvtCV+jdfoK/3sAxG+H16
         JzAVq+1JZTtu+cAryoJMPMNTKX9Fhq8conuLx2s9fkYPZNtdY2f1tSRR3qfAtZAgudPL
         vUHA==
X-Gm-Message-State: AGRZ1gIEnAR1cLYER7HuntQQSGpcpUfkqBQ9eMExPmBYse8LbqT+D9BB
        TDI+tsruLo1dOCzZJk2FPwwKKpC+
X-Google-Smtp-Source: AJdET5cp2X1dZ5ltLvCs/hP4AOhqYmhKMSp9OehBX7gTRpiH97ikT+Sf8trziPipQjPw4GslNXrbwQ==
X-Received: by 2002:a2e:21d2:: with SMTP id h79-v6mr6265078lji.46.1540709526589;
        Sat, 27 Oct 2018 23:52:06 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v23-v6sm148847ljd.70.2018.10.27.23.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 23:52:05 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/12] attr.c: mark more string for translation
Date:   Sun, 28 Oct 2018 07:51:49 +0100
Message-Id: <20181028065157.26727-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181028065157.26727-1-pclouds@gmail.com>
References: <20181028065157.26727-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 60d284796d..4ebc169abe 100644
--- a/attr.c
+++ b/attr.c
@@ -372,7 +372,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
-			fprintf(stderr, "%s not allowed: %s:%d\n",
+			fprintf(stderr, _("%s not allowed: %s:%d\n"),
 				name, src, lineno);
 			goto fail_return;
 		}
-- 
2.19.1.647.g708186aaf9

