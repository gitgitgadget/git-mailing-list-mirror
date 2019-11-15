Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13E01F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKOOQG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:06 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50608 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOQG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:06 -0500
Received: by mail-wm1-f52.google.com with SMTP id l17so9805416wmh.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SS7bRlq7DG8hvTPjGjIa+Gy8rxR6kTmDlHR4pTD7k/I=;
        b=MZE6FJ0fW7PHuD/EyZZwzYAvYwkqxbBR47LzwgMw7VG3qNoGfSJW3Ts8228Oop0Q9t
         U85bSz1QL2mCV3TSzkIPaEp3Zl9ygBaWm21IsSZs94UZUBa+NPLFP8WGzscBRR1xZ3vE
         nSXnGNupIs7z07cM6oFcELlu3hidApJbQBf+IR0fkhs5zlHMLOC8yRk5eFAeHIVL8T9s
         gkOJkBB0DgppYS7Gzj6sw7aTNVPWyBwNnsrf6/kbplwRA7I1N6tW3ehCq5p2GkXfXJhe
         SxhLmY4IbAR++rrkCX66/RtAg8fsWGitryFdfKO7J+AklMTi8zZOiRiJPQ6pI77yTK2m
         p6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SS7bRlq7DG8hvTPjGjIa+Gy8rxR6kTmDlHR4pTD7k/I=;
        b=mZwzzjbrsmW+15SymP0lOaMOWKx2HzwL5KhHDTIgwcWvf+jp5zUdO6L9gqeRialCOU
         HMGd7ABHTjrdgqQiQZN9VNwlHMPrWMES2G7H+Ft8A3ty+mrLKfxZeKPASa2lcvwwNMVQ
         zsHjEP8+OCBgr8cttOgS4Hct6yJ6hN8z37CA9dyMjAX+jApGyV8Wm6g7hjf4Hw3+6CFv
         3eP83/tWPtb4EIgsnRNtERz9IsghRbZdk0EUuZMbnHji8peZ2qVMU7zTWaVuebTRjPAK
         VsCUpaEsrWHPKNsdLHgE1zpDZrCyaL0aZVmYW2LAjds6L/VugsOvYVxnSTlamw6HxH+l
         FTdw==
X-Gm-Message-State: APjAAAXDM1GdnlSvFrxi0eCAdSGNnM+GSLxf8vPoZtEf8fbC7qU0ig+m
        H0BkJ1dhv6y08kyrdUQwbwgzTtCJ
X-Google-Smtp-Source: APXvYqwrYTo+s7wj14I9vGjVx57tfJf2Rxvos1Tr9BXv4MbBHTwcQdI+Y9QnW0lYVLJKqidN/wVYDA==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr15485161wmc.164.1573827362169;
        Fri, 15 Nov 2019 06:16:02 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:16:01 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v3 3/9] ewah/bitmap: introduce bitmap_word_alloc()
Date:   Fri, 15 Nov 2019 15:15:35 +0100
Message-Id: <20191115141541.11149-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

In a following commit we will need to allocate a variable
number of bitmap words, instead of always 32, so let's add
bitmap_word_alloc() for this purpose.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 ewah/bitmap.c | 13 +++++++++----
 ewah/ewok.h   |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 52f1178db4..b5fed9621f 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -22,21 +22,26 @@
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
 #define EWAH_BLOCK(x) (x / BITS_IN_EWORD)
 
-struct bitmap *bitmap_new(void)
+struct bitmap *bitmap_word_alloc(size_t word_alloc)
 {
 	struct bitmap *bitmap = xmalloc(sizeof(struct bitmap));
-	bitmap->words = xcalloc(32, sizeof(eword_t));
-	bitmap->word_alloc = 32;
+	bitmap->words = xcalloc(word_alloc, sizeof(eword_t));
+	bitmap->word_alloc = word_alloc;
 	return bitmap;
 }
 
+struct bitmap *bitmap_new(void)
+{
+	return bitmap_word_alloc(32);
+}
+
 void bitmap_set(struct bitmap *self, size_t pos)
 {
 	size_t block = EWAH_BLOCK(pos);
 
 	if (block >= self->word_alloc) {
 		size_t old_size = self->word_alloc;
-		self->word_alloc = block * 2;
+		self->word_alloc = block ? block * 2 : 1;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		memset(self->words + old_size, 0x0,
 			(self->word_alloc - old_size) * sizeof(eword_t));
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 84b2a29faa..1b98b57c8b 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -172,6 +172,7 @@ struct bitmap {
 };
 
 struct bitmap *bitmap_new(void);
+struct bitmap *bitmap_word_alloc(size_t word_alloc);
 void bitmap_set(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_reset(struct bitmap *self);
-- 
2.24.0-rc1

