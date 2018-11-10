Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E69C1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeKJPZ0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:25:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37039 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeKJPZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:25:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so3375622lja.4
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YLAtDCp0DggVMXDfnq6UmjNIo6HS2SUNb0DLXoU7lRo=;
        b=fjtkDaAAOzMO0/6aEfxjf9H5Ey1+EfB+hS16CTrWYPi3AETGCKy4ibGO2w23VbKlvT
         2L5HxYgq7nv1ukVbwoJYRbVPDBVp+VWX4fQdG5ZfLSgXoQnkqspN7oPIYA3zIilPff6Q
         2/z2PrzrKYQCege2Q0if0NWDL0n//MW0VBcbjXzQ9l3MKf8YXO1P3CxbjTRjV/AjIP+I
         uV9TpuVIvpjhyIJWXtp3M8gUnBXhfeNVktLVrX9iPELjRGfZMuOCLb1zDRdxybwsIiR/
         0BlxHDD8wRC5Mdo9DA1Mt9nMh8Pi9baHgd93+8zPBm+60aLqTkhOsL9tZc8aiqynSVWe
         ueKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YLAtDCp0DggVMXDfnq6UmjNIo6HS2SUNb0DLXoU7lRo=;
        b=XST8FlI6YfrNqozOg13vhTyM0D0/OJdsJ0+JpUZ9OgtkLeC+9z0Po5OMmchg7Zh4qF
         mv8j4eGg+mX/iU/vE/8m/aYWH2BTyD5TGbv3TD42IY8MZUI60xCIOyQO17FoPqEd6NpH
         qDqpWsdK7qmQ4Nsv9Ib9BkigWlAiZu1KezdcNmy5xTVwYsbxsaJQsGchfjGtQsbJ9853
         Gp7S2GXuLjvxCyGXAWmBUJ3DbXsXkW5PRbq16e034Dqo9fkUWnZ6pnKYnbarAKm7+FHZ
         lZ2JreDdmLQuh6knZsE9XXwDd032RPmvEoMVUaskqlavyUE+UrII1F4ziv9hTSZWFHCq
         JZrg==
X-Gm-Message-State: AGRZ1gK+pSCJaBxRh1lcCRbfWnEl7C1XYDtE9WlXzUQIs2HpovLc80IH
        tqC67UYQJEqInxTlZQZUU+w=
X-Google-Smtp-Source: AJdET5fCo+PceIrh0pIcGmEeXB3vMJEYKxavdt7ksXX0UWjZWM/IqgipsNfPfutk5NP/VlV0azQ81w==
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr8110107lje.78.1541826990099;
        Fri, 09 Nov 2018 21:16:30 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm1769663lfe.42.2018.11.09.21.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:16:29 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v3 07/16] read-cache.c: add missing colon separators
Date:   Sat, 10 Nov 2018 06:16:06 +0100
Message-Id: <20181110051615.8641-8-pclouds@gmail.com>
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

typechange_fmt and added_fmt should have a colon before "needs
update". Align the statements to make it easier to read and see. Also
drop the unnecessary ().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 858befe738..8d99ae376c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1492,11 +1492,11 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 						  istate->cache_nr);
 
 	trace_performance_enter();
-	modified_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
-	deleted_fmt = (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
-	typechange_fmt = (in_porcelain ? "T\t%s\n" : "%s needs update\n");
-	added_fmt = (in_porcelain ? "A\t%s\n" : "%s needs update\n");
-	unmerged_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	modified_fmt   = in_porcelain ? "M\t%s\n" : "%s: needs update\n";
+	deleted_fmt    = in_porcelain ? "D\t%s\n" : "%s: needs update\n";
+	typechange_fmt = in_porcelain ? "T\t%s\n" : "%s: needs update\n";
+	added_fmt      = in_porcelain ? "A\t%s\n" : "%s: needs update\n";
+	unmerged_fmt   = in_porcelain ? "U\t%s\n" : "%s: needs merge\n";
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
-- 
2.19.1.1231.g84aef82467

