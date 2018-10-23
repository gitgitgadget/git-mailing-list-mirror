Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4851F453
	for <e@80x24.org>; Tue, 23 Oct 2018 21:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeJXGQB (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 02:16:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35908 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXGQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 02:16:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so1253449plt.3
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+Qx0lGGAeHqcIrElD1L1PGLwcxPckPCNx5mHLGJLHs=;
        b=KRFNEp/3P7ENLpBCyc47alHrgt174Cx8CdWXKXTgd7MeEDTD3uVCwfbGZ1lGGXWv+t
         u9ggVuzve5DRJHCuHtVucHuL28IYEKAbpuHMXxJYE+6xM922wa0LF3lUWvhu/hknPAvY
         BVbw+QIRDocUqDqHRu3uM1F9URbAnQ0OM6JznEhv8SxAuHcoPfiW/Jb7vwbhpNQAvAWX
         +KrCGbDu9TKVlbP6nA50otmqnWNcUzWrKdKQx5btin6Nm6ZBzZvBFPj4q1z2JDBZKpmW
         uZjPBtkF4+B0lUslwN3cOQmAJTmPoJPT33sez0WD+jvmKQq2Af4t/M2sU9U98iMNI0sY
         cPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+Qx0lGGAeHqcIrElD1L1PGLwcxPckPCNx5mHLGJLHs=;
        b=BN2r0BtfxTBrc1II5hQTt0FgzDuqfciBiO8oIzZd/gxLlNCC1/7u9M91yJEEZLO6H4
         rIoedOeT/kiwoAgJB20hIa7184H+xxs59MsIHCuRwgt38vAnol1r4GNbK+g0yTzmmVIW
         qnC3MeGR0ksI5KDgryHfb9BYhwNKSfV8BMzzLMDV8v8ol7KG3p+Yd+8aDZfdmw8Wt+vl
         kTfY6bqlVF1/7w1ImHA/FPz46DMAPwIbVjqcLYSsqfukMzRVgfU3sqL5ATEIBDgQg9ZW
         QycUSMrKbIm3jk5nJmmkWqGDrqfOUbAFPRpOvzxjYkwzuAbOmq/KBzx+3fkTXIiovnJU
         fZpQ==
X-Gm-Message-State: AGRZ1gJZ5HCkuroDdXumcdOYA+kpHeaEj5aIhbKcr0/kA6A75KOLFLGl
        t9Qfylvc4GQkNor1doXNqP1cf0LCgdA=
X-Google-Smtp-Source: AJdET5cudJwLaj9lI8MYCE8cWKaVxS2dc2gS1vpwQPz+Jz7OiZBy9FN60TZipkZycrwOeZ0WTGqjeg==
X-Received: by 2002:a17:902:c01:: with SMTP id 1-v6mr2915pls.233.1540331445438;
        Tue, 23 Oct 2018 14:50:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2766810pga.64.2018.10.23.14.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Oct 2018 14:50:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peff@peff.net, chriscool@tuxfamily.org,
        l.s.r@web.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/2] khash: silence -Wunused-function for delta-islands
Date:   Tue, 23 Oct 2018 14:50:20 -0700
Message-Id: <20181023215020.18550-3-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023215020.18550-1-carenas@gmail.com>
References: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
 <20181023215020.18550-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

showing the following when compiled with latest clang (OpenBSD, Fedors
and macOS):

delta-islands.c:23:1: warning: unused function 'kh_destroy_str'
      [-Wunused-function]
delta-islands.c:23:1: warning: unused function 'kh_clear_str'
      [-Wunused-function]
delta-islands.c:23:1: warning: unused function 'kh_del_str' [-Wunused-function]

Reported-by: René Scharfe <l.s.r@web.de>
Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 khash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/khash.h b/khash.h
index c0da40daa7..fb71c92547 100644
--- a/khash.h
+++ b/khash.h
@@ -226,7 +226,7 @@ static const double __ac_HASH_UPPER = 0.77;
 	__KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
-	KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
+	KHASH_INIT2(name, MAYBE_UNUSED static inline, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal)
 
 /* Other convenient macros... */
 
-- 
2.19.1

