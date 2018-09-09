Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9BB1F428
	for <e@80x24.org>; Sun,  9 Sep 2018 17:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeIIW1I (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 18:27:08 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41688 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIIW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 18:27:07 -0400
Received: by mail-lj1-f171.google.com with SMTP id y17-v6so15933426ljy.8
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 10:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PEV4pbrWgCf2ZtGm2bOMvtucp86Gd1EEZG2F1VO7OQ0=;
        b=aw4QyQoxfnVVsQmtJCeNooAX+pqjedRcb/uxxCzejXXHs56jn/60js5fPyyE6vjV2D
         b6ly/tXUZv+G/JbuFEsgUYFQFXWQMvF7i+r47whvnHFMu+QNVMXUQJ04aEhLfWcUr761
         sJHVZt/aRPYxU+FoEnNC+tyPyprMhnEFhMcHBvorDg/a2T3NOdcelNjiss7B41Ly3QBS
         HBMK94+6COR3VYS4GTeKBwdTKVfiCZ2f5LGjfPQjsIFgSbq4HLLkPJucjr+xw7vtqazC
         7D14nNwqay9cQwInaUq4RpXn/JdoxDizAFCsufiW5baK0PrNc6I+V/UzHXiWp6riLl0q
         EL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEV4pbrWgCf2ZtGm2bOMvtucp86Gd1EEZG2F1VO7OQ0=;
        b=ni/RjI37dULVfrtbKoE9aVKyILrMsPFWXrGeVIut9ETL9zEp0azlRZ0/IWt1LyQJ3i
         G0RUCp/8SO5t0G2b4c6GqC8Zcv63DorQOWPoxmfOcH47RHxMikpmwfeMKwbF5pys24Xh
         whFoGh7gGT5+2pF5rJ++cqPBH2Y5wviD4K315TTYfJkcrlGtkikev4+7t/I6vOcKqG2q
         3fxjY8dvQ4oj+nko4p1cZiYlvXJlojxO2pnHIJzdfuXmfCzJaZfLlMjf3Sh7V7sq2Ybq
         6i8W+s7IvXe3S5dsfr3FcnbrITij1VrwooqN7Kdoes3M1Rrczdntq/hFtPez+BpnIQMS
         hFsg==
X-Gm-Message-State: APzg51Caf5OwFPZUAhKN/FHMiRuJn9OBsBJj65MKlDBgF5tO6sXxE4ZA
        Mrm0Uz2Bwi5OurXPtY8Zibr8Ik+q
X-Google-Smtp-Source: ANB0VdZS5IlB5Vp0vGfPdy/IW1ekv4oE1PwpOCbq75fnHtBzyoCNLA4yQFuJpMB9tbxyFHmFb7qwpQ==
X-Received: by 2002:a2e:2e02:: with SMTP id u2-v6mr10546878lju.77.1536514603509;
        Sun, 09 Sep 2018 10:36:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u19-v6sm2317793lje.51.2018.09.09.10.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 10:36:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/6] Makefile: add a hint about TEST_BUILTINS_OBJS
Date:   Sun,  9 Sep 2018 19:36:31 +0200
Message-Id: <20180909173631.1446-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909173631.1446-1-pclouds@gmail.com>
References: <20180909173631.1446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index ea7454632d..39d39257e0 100644
--- a/Makefile
+++ b/Makefile
@@ -744,6 +744,8 @@ TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-write-cache.o
 
+# Do not add more tests here unless they have extra dependencies. Add
+# them in TEST_BUILTINS_OBJS above.
 TEST_PROGRAMS_NEED_X += test-fake-ssh
 TEST_PROGRAMS_NEED_X += test-line-buffer
 TEST_PROGRAMS_NEED_X += test-svn-fe
-- 
2.19.0.rc0.337.ge906d732e7

