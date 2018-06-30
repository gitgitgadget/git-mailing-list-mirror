Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51261F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934939AbeF3JVF (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:21:05 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:41042 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934336AbeF3JUt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:20:49 -0400
Received: by mail-lf0-f46.google.com with SMTP id y127-v6so8462052lfc.8
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=838JaquIiNGKzQrMgNqKuI+KHquefvtiVtVnIRXL2eo=;
        b=vcjnIE92nD6OpYm8Cs6GR1yft+73eIt5vaeuyNAALyFDqBrv3Yy7+d2kKn6J0/ENmY
         W9llJ+CGQ+jskigOdWFhWvHN8P+GgeBGgEisGY3MwRlZk3AZlqYc+jcz2DtdVy8CTSOT
         1NqXsWafoB/ZplbBIeamHf8/irvjtY0OM7E+C+xw5TOMFVmrmVFbLhJdwHbA7VNzRAza
         MWCUrhwdp7m33pgTQuRUz5S5pyFCmySPO1No3dQ7hchDnanj/J5HfDDpVrmV9HsrJMxs
         IG4RHAZbR1uEOzW8bnJpv4tGslemdD58kgZxWL6J+Mf+fiz2PdGjghT8EGGLp9pQyUNm
         uCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=838JaquIiNGKzQrMgNqKuI+KHquefvtiVtVnIRXL2eo=;
        b=uPQVKYBr6q8wG1UMGORe3Ozo75p2krY1uUGgpGv8fW7ZgxZt8KAjlIeWoxGp/rvXIy
         NkfCKJDX1k/GjucgZio6IawtONxHdQyEszAiE+3JnfpMMrM1IRKWm7EV3aTOg6XcaC1m
         N+yxprJQWuSf+fczchSU/1R/0fKspuIl1pk+Wg/YuDe5ch6109BkhtY1qn3nUq7798mN
         00tfdXbHMCSmbB9NgVJGdmfCV4d1rXp3xCRIs+YcVgH90frAbJ5DMXrEbGUrWuX64DOF
         DfbLXeH/RxmJ2CBtEibHOdKsukgnoHLLTgGMML3V865jJdbe/rCwUTq9b9TRvbfo9M/C
         CrYw==
X-Gm-Message-State: APt69E0WxwoXKZHjYFgTLxmVnINzFJB70Cs+m6YRApa65GO88wK9Asx1
        zDPGFl610tqiyvCZKXl8fogdMQ==
X-Google-Smtp-Source: AAOMgpddXgtDa/uuaz0pNE6e3T6bokbDtlpJPIdWouKSx/ATWx9oh156zrf9YczqDt8fZRyLmZXXlQ==
X-Received: by 2002:a19:385a:: with SMTP id d26-v6mr12607305lfj.47.1530350447459;
        Sat, 30 Jun 2018 02:20:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c20-v6sm1854650lji.82.2018.06.30.02.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:20:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/12] line-range.h: drop extern from function declaration
Date:   Sat, 30 Jun 2018 11:20:27 +0200
Message-Id: <20180630092031.29910-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630092031.29910-1-pclouds@gmail.com>
References: <20180630092031.29910-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 line-range.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/line-range.h b/line-range.h
index 83ba3c25e8..d3c54e45aa 100644
--- a/line-range.h
+++ b/line-range.h
@@ -19,11 +19,11 @@
 
 typedef const char *(*nth_line_fn_t)(void *data, long lno);
 
-extern int parse_range_arg(const char *arg,
-			   nth_line_fn_t nth_line_cb,
-			   void *cb_data, long lines, long anchor,
-			   long *begin, long *end,
-			   const char *path);
+int parse_range_arg(const char *arg,
+		    nth_line_fn_t nth_line_cb,
+		    void *cb_data, long lines, long anchor,
+		    long *begin, long *end,
+		    const char *path);
 
 /*
  * Scan past a range argument that could be parsed by
@@ -34,6 +34,6 @@ extern int parse_range_arg(const char *arg,
  * NULL in case the argument is obviously malformed.
  */
 
-extern const char *skip_range_arg(const char *arg);
+const char *skip_range_arg(const char *arg);
 
 #endif /* LINE_RANGE_H */
-- 
2.18.0.rc2.476.g39500d3211

