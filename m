Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15AD21F462
	for <e@80x24.org>; Sun,  9 Jun 2019 04:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfFIEth (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 00:49:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43677 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfFIEth (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 00:49:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r18so5853857wrm.10
        for <git@vger.kernel.org>; Sat, 08 Jun 2019 21:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2WAeH9XKfpktBnDzZsrryQ7Qm3OzWGPMO2fj+263LQ=;
        b=cvFn4gxPobAF0irPGvXMT2w6/QCAcmgwjlOw/xd484f0C47iuDd2KdisnRxhf/oMxt
         hHKCC1TWiLzYqL8BiDuNmOssSxvaoDA6jEr/34HSIovGZOL/a73mB69vixLkq9RqR9rf
         tG5pYvt9gHceXx/17aZWhGsGQoeoc/nLg5fgOxe1SNiHdOizlFTDuiUUt+bd7zNRMLrG
         DMsJbwgexCtwSOFt37iV4ztLYuJXAHoVgAUG/ZY8v6AWHG30tOdZLG1nbLFD6vOpFu4N
         0TiEilrtaqNjb0ly6bUVBn+wdvvL9/8r6ojcVdbtPmLkHOjhoVes3E9LjI0tgmk9nqbR
         aVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2WAeH9XKfpktBnDzZsrryQ7Qm3OzWGPMO2fj+263LQ=;
        b=QOWI0RZ/0pO01LHc6qzrxQ710OQbHEJ3VsE8ajZdwi0EIJMqkbpqTJ1BCk8lnXF1Ez
         kJ61wQbEOo/GiUQipaO15CYzzvvtUKGMZWAciALaeACQWteoeB492t6SJy/civE5/vb3
         9FrpxYlH/hn46v0/wezVjiNNVLjVhS2cupoxkP8eS4PYfjbpt4xxiGEy8gnQfry2ST3M
         4U9A35K8pnd05w+lAFsjhsIsPRkeILNouQwp8SH5kZtt7fe4Gy6P03ZXEPGJzoHl6Ow4
         iJTz2UKM/RqkWP2YzFFoPFFg4x/WVJ72NwxynLikpvbZk4RSHjRFlanPsf0wt9uAZP7z
         DFoQ==
X-Gm-Message-State: APjAAAVRHNKiaTDl4HIuLSdqfaycEfP2Fn5CzI0W71c/DN15pzk6rb3B
        ibiqLqyKTSM45Wr+EZR12ckzREywsIo=
X-Google-Smtp-Source: APXvYqxIwV1clKwPIc6ureQi83lxw+u+GBn0TcER70eIDyXlLhQdSpEDDWtLKR6E7q8qvBgNN2HKlQ==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr5139931wrq.290.1560055775486;
        Sat, 08 Jun 2019 21:49:35 -0700 (PDT)
Received: from localhost.localdomain (160.10.112.78.rev.sfr.net. [78.112.10.160])
        by smtp.gmail.com with ESMTPSA id y2sm6461116wra.58.2019.06.08.21.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 21:49:34 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/3] oidmap: use sha1hash() instead of static hash() function
Date:   Sun,  9 Jun 2019 06:49:07 +0200
Message-Id: <20190609044907.32477-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.14.g9023ccb50a
In-Reply-To: <20190609044907.32477-1-chriscool@tuxfamily.org>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
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
2.22.0.14.g9023ccb50a

