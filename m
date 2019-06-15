Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3976B1F462
	for <e@80x24.org>; Sat, 15 Jun 2019 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFOKHh (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 06:07:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39005 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFOKHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 06:07:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so4971863wrt.6
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiUqHXDjxSKD/+MwLSo6BGNIeP2ud7iV2M365NojWDY=;
        b=BOSyERTVSknhCp8LNEHL0Afwq9bR0hos1ht35CgajdSBgwi/r62Xe7ne4cNmc4A6SL
         m8GkIWCG05a6rL6x4J9FZbG7mt0LUmTzI9AZ1+C2TwlhR0NDeLBpP1ZZEBca4gQwDs3x
         drjf55q8/9zlQWftnBTafROH3VxrS8rCFPOinMbZqhI30QwnkEdg1+Q/P3sdzgHAyb1c
         LXBuzMc8/gfwaaroFXN0ZWBXLx0P6X13pvH7f4FRCCTWv469U8Bz6a8oT23buKk37puV
         qOxZSabThZgzxCG9wsSSDJ+pE3XlY6Q0LYZvFecOKqLBb/khLDv0m3zUkdFYXxbpEOZv
         JfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiUqHXDjxSKD/+MwLSo6BGNIeP2ud7iV2M365NojWDY=;
        b=SS9mDDaF8Mv7lRAhbt655LwrXPboIgWdpF56qcdXY04WwSMjxjYZfga2l/QCj59pkm
         TGW0lcbEZMbP34JmnR/RO2bfBxg42eXszW4F5NtdNWoHkVXW5Daqcd9M5YxfOIRTn7/c
         s7rWWYvhKJeYDU68w51jTQEZJHZf3q6VhZHKOdEPlrfqxHRcnipm4eA+2c0E1eFwss/1
         pAlfqnKBqdEL1V948GNvo43qgvS41X1UV/DxGKvATMUuitb0DI3x4JhrOesCembqO5sV
         DRMYH4pIhY7gsqb25NY69rvTDcGg0k7hPCas4FPaO6Ul8eS/p1DL06lIVBu6E1/CCrCz
         tgIg==
X-Gm-Message-State: APjAAAXRv8dnIhLhFGqNXUh/iuyiHj0SieB0CJuuVi5D2l16SAlIIkPw
        aaDGX95PrQL0VoFZQZL23g4bMTjG9G0=
X-Google-Smtp-Source: APXvYqxnvCmTj1Kke0qT2JdwBEeoS5SdrqcupxGkb2PBV9mxQb8mI5otnYg8/o8OprAmuuGDxYAlzw==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr19567095wrw.6.1560593253630;
        Sat, 15 Jun 2019 03:07:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1017:d205:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id x11sm8091576wmg.23.2019.06.15.03.07.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:07:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/4] test-hashmap: remove 'hash' command
Date:   Sat, 15 Jun 2019 12:07:02 +0200
Message-Id: <20190615100702.20762-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.3.g82edbe9b01.dirty
In-Reply-To: <20190615100702.20762-1-chriscool@tuxfamily.org>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If hashes like strhash() are updated, for example to use a different
hash algorithm, we should not have to be updating t0011 to change out
the hashes.

As long as hashmap can store and retrieve values, and that it performs
well, we should not care what are the values of the hashes. Let's just
focus on the externally visible behavior instead.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/helper/test-hashmap.c | 9 +--------
 t/t0011-hashmap.sh      | 9 ---------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 23d2b172fe..aaf17b0ddf 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -173,14 +173,7 @@ int cmd__hashmap(int argc, const char **argv)
 			p2 = strtok(NULL, DELIM);
 		}
 
-		if (!strcmp("hash", cmd) && p1) {
-
-			/* print results of different hash functions */
-			printf("%u %u %u %u\n",
-			       strhash(p1), memhash(p1, strlen(p1)),
-			       strihash(p1), memihash(p1, strlen(p1)));
-
-		} else if (!strcmp("add", cmd) && p1 && p2) {
+		if (!strcmp("add", cmd) && p1 && p2) {
 
 			/* create entry with key = p1, value = p2 */
 			entry = alloc_test_entry(hash, p1, p2);
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 3f1f505e89..9c96b3e3b1 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -9,15 +9,6 @@ test_hashmap() {
 	test_cmp expect actual
 }
 
-test_expect_success 'hash functions' '
-
-test_hashmap "hash key1" "2215982743 2215982743 116372151 116372151" &&
-test_hashmap "hash key2" "2215982740 2215982740 116372148 116372148" &&
-test_hashmap "hash fooBarFrotz" "1383912807 1383912807 3189766727 3189766727" &&
-test_hashmap "hash foobarfrotz" "2862305959 2862305959 3189766727 3189766727"
-
-'
-
 test_expect_success 'put' '
 
 test_hashmap "put key1 value1
-- 
2.22.0.3.g82edbe9b01.dirty

