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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E3D11F462
	for <e@80x24.org>; Sat, 15 Jun 2019 10:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFOKHe (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 06:07:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40558 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOKHd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 06:07:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so4972535wre.7
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkKcsL9j/PSirfGj1G9mnA8V/6BZHp6lnji/hAv0xIo=;
        b=dvjDs7w1qDOKHFxKqhGkkgOe0K3Nau53rnBR9X/yvHkjMwg/rUHLvTapbjg8Q8shu8
         IzQyWvMlO/mxEo3W0fshxcgoPRXlYXO/XBrisJaPitidfh4kJzBKg6bI+r6oBSs8Umxy
         o7QlsO3gztsU+x7n4aOZdSmw+59TmD8xXGRs5wfk9DMybwVtwskO/sizlF0DycWRS5/G
         wHs54Q885LDEtAqmCvNGmZy/SnbIM8IBQbAYfIR/WqBbwGEl1kRGasDKKLRVyk0d6yNF
         VMr30Iz7FvHYQLrSzNjjWUP8dAfCkLO8E1yXTmb9d2whd1NmlOtG6WJ9wAh0q5kzVOgb
         IdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkKcsL9j/PSirfGj1G9mnA8V/6BZHp6lnji/hAv0xIo=;
        b=h7Mv9ew08gDvB/fuX4naGKnIzsaprJbzgDtJe2yBLkIal1Sg+aQiwdq8EjQmAgDwXh
         62t6pAJ5BDTvZDMWsUd25q1P1ZiWZVKyuhYU5bl8AAh+VQZU7CEFik7OeZU3vlkTa/OG
         qLiLZtpL1DQWzgZfOUfA43ZIFVXt4nYXNcjPO1iYBWAMgQF2IS0K+UxcGAKt1eGJaFPL
         iev4ttP3nYvpg0ii4x7wsqz3gYIdsuODYijFdWFZTn2DeS25gNCbzSfMhrOwSx6bhdJZ
         N18GeNKa+CURxLZAFAx5FL4Jaqhuej/kcywSYVUgTtJMidg2xu5n4ebWg91rL2S0eMwo
         3elQ==
X-Gm-Message-State: APjAAAWDeUyp+PHZUQdQGAGuOs5N6v25RpvjmqiCPoFJE8EBGolMRwST
        THcVuJWstqki85PVVtojbsupL2d/Pe0=
X-Google-Smtp-Source: APXvYqz4VH9MXVvKxysU0iEU47S1sIQHBD4I601GkIFKIb/Pl4zVLVk7c9Ovt9o4AAKTpRzOnuwZdw==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr55097836wrn.31.1560593252348;
        Sat, 15 Jun 2019 03:07:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:1017:d205:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id x11sm8091576wmg.23.2019.06.15.03.07.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:07:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/4] oidmap: use sha1hash() instead of static hash() function
Date:   Sat, 15 Jun 2019 12:07:01 +0200
Message-Id: <20190615100702.20762-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.3.g82edbe9b01.dirty
In-Reply-To: <20190615100702.20762-1-chriscool@tuxfamily.org>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
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
2.22.0.3.g82edbe9b01.dirty

