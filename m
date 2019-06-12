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
	by dcvr.yhbt.net (Postfix) with ESMTP id 845631F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfFMRBx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:01:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50638 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfFLXY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 19:24:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so8197012wmf.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 16:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQxy7QTZ3SJg459ql3zBsovlVdVKcSjTR6ROqdx/idk=;
        b=Idjs0MvfxlfwkFTIKyuJlwZ2sZ8CORwTJ5k8lz/DMBn0N4QWm65o7VPxh1Zq4bCiBz
         t66FFNG7VWmda20gOq1Hug5FRNk1iQVmsUyfxQ4ADGOXo+07UQjEjZt7dJVMC7brNT/5
         uo38dsGvsHuWixJgTIYb/7/MQM10vaVo+qOMC1rOGu08IdB2cHTak/8GsGAU0BoRV6Jl
         284JIbRJccJ8+5sqWB7sqmS+lwNORd0L2Uzdg0ZPJvsCqTN0eQvXYCvEkVyibQ9yNZuT
         1n+u8PQQstivaiE5zZZUjzB379FKN2jnJjxsfnRaOJu+LmOu1sMSVaJpBrYXe/4yjKoP
         8pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQxy7QTZ3SJg459ql3zBsovlVdVKcSjTR6ROqdx/idk=;
        b=gGAcb3pJCgsi0M7A8D4zeXD+L/P5Vp/ynm8KP1SZSpG0303Ff6vY5Im44Qjkv5blS3
         /HyT/xzvDlGPJzIHym4Q+ByVTyUeDwm/scAX9172XuLPr6xQpAD1g2XTkOkYn33axi/5
         cYUNFhXGXeNZ3p+ZXX9TSELJGkAIqPvIL6eiVfMSji2IvDoRYh6VYgDTJSPDchBlu/AT
         BFkIEuNOq1NEDNpT+OETfn6q0L1UYER9f8vabV6vavKGTSDc6VLHAZvpubmA+OfPVy1l
         wTNX5NgNLFf8eAjBJfqfuSAIPsGx6hV3MoqWrxnySxGLf2crbWphJwfDHEdb39e7azS9
         mAjw==
X-Gm-Message-State: APjAAAVYXH0YZd524iOoJwmwwdRwTiard8AfOVTqmsoUAnZaP5vvvb8Q
        B6zae/epB2AznoCTIg3gEVBW41Ne
X-Google-Smtp-Source: APXvYqypyHEoxRJzeWGUjYTnP9yZ9NK55/nLzipkST9RE9tHZ3qQU5+UuxSA3HXrRJSsbeV6g4I35g==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr1055681wmj.2.1560381894359;
        Wed, 12 Jun 2019 16:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1018:b2dd:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm1414803wmo.31.2019.06.12.16.24.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 16:24:53 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/3] oidmap: use sha1hash() instead of static hash() function
Date:   Thu, 13 Jun 2019 01:24:25 +0200
Message-Id: <20190612232425.12149-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190612232425.12149-1-chriscool@tuxfamily.org>
References: <20190612232425.12149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

Get rid of the static hash() function in oidmap.c which is redundant
with sha1hash(). Use sha1hash() directly instead.

Let's be more consistent and not use several hash functions doing
nearly exactly the same thing.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 oidmap.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/oidmap.c b/oidmap.c
index b0841a0f58..01c206aaef 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -12,13 +12,6 @@ static int oidmap_neq(const void *hashmap_cmp_fn_data,
 		      &((const struct oidmap_entry *) entry_or_key)->oid);
 }
 
-static int hash(const struct object_id *oid)
-{
-	int hash;
-	memcpy(&hash, oid->hash, sizeof(hash));
-	return hash;
-}
-
 void oidmap_init(struct oidmap *map, size_t initial_size)
 {
 	hashmap_init(&map->map, oidmap_neq, NULL, initial_size);
@@ -36,7 +29,7 @@ void *oidmap_get(const struct oidmap *map, const struct object_id *key)
 	if (!map->map.cmpfn)
 		return NULL;
 
-	return hashmap_get_from_hash(&map->map, hash(key), key);
+	return hashmap_get_from_hash(&map->map, sha1hash(key->hash), key);
 }
 
 void *oidmap_remove(struct oidmap *map, const struct object_id *key)
@@ -46,7 +39,7 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 	if (!map->map.cmpfn)
 		oidmap_init(map, 0);
 
-	hashmap_entry_init(&entry, hash(key));
+	hashmap_entry_init(&entry, sha1hash(key->hash));
 	return hashmap_remove(&map->map, &entry, key);
 }
 
@@ -57,6 +50,6 @@ void *oidmap_put(struct oidmap *map, void *entry)
 	if (!map->map.cmpfn)
 		oidmap_init(map, 0);
 
-	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
+	hashmap_entry_init(&to_put->internal_entry, sha1hash(to_put->oid.hash));
 	return hashmap_put(&map->map, to_put);
 }
-- 
2.22.0.6.gde8b105b43

