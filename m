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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EC8D1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404585AbfFKIYB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 04:24:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41050 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404565AbfFKIYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 04:24:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so11920242wrm.8
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQxy7QTZ3SJg459ql3zBsovlVdVKcSjTR6ROqdx/idk=;
        b=D463JW2Hc36ZfwiQxhuBkW7+DFmOZylYpU4wuAMoSfUKSl9Et0P3TBMvRi0CxIh3Z8
         1bphDfTZS4cw69s6s8l9HPWU4QHLZYcRYlQGtRIsuOs3PVeWoWX/0VyTwYS1kesmXPa6
         8qYb4u+wxrhF4S2WLF6EH4GKXV44YcHTgrI23Wf4v5SEc7D/ZtG3HLceJseUgigEK9cO
         E/oyhLBm8XubB1IsljuxgXiFqFQ6kz8DojnEWZRjXONaOIHPKUMO4jtIyRFntN0AHhPn
         kToHQ6jnzwKjZbyBwNPgOktdsnbXNQE99YKte8rrPMJ7qq4FtIXAIDNQLt+pJAzrgp4G
         I35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQxy7QTZ3SJg459ql3zBsovlVdVKcSjTR6ROqdx/idk=;
        b=sgxD513sVatkazVHQ6nPYYC200ea5rjxgzMX9Op9FC+hJsEXjOcXsoI8AFbR0TJ/mq
         B51HhR8m2B9XmJzrKgLu/Df3vTnkVk20t+ox3lrIs+PHPO+a/e4Kq2TsE02FjVOAVfns
         xQZtlB+wyuHMRpJ9Ma5A4t0TjDFxgM+gl4Y9kvJ/W0A0XvVDdy5lvMBWltu/LAaOR3LY
         aYf6mb0viRViURTczq/9Cq8VuNePmSgEw0KKzWPwSYaDHUMfUTh7aoaAtpOg5oDmwpZR
         M7Cm3n9vCiVyaRLEGORo68X7X2vSqD4gk2nYuD8jVIWZAeUVsixKjzBJCRNw/KGsybz/
         UgLg==
X-Gm-Message-State: APjAAAWbr06KYR/MRgDjLZojaWjmtWQsc8YK1Ssd0Q/wQdcGyqrHuwDS
        DrbUMOD1aY5uilRz4ua2PTtEHw/H
X-Google-Smtp-Source: APXvYqxYEYUbDNQtq6omwRfI7eEBgxTZAz7cSi0WyGp+e8moipgeqRwbvjFkYxhX+GuAAOf6ANQYmQ==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr35340479wrp.277.1560241439428;
        Tue, 11 Jun 2019 01:23:59 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10dc:b342:2143:78cf:c452:5744])
        by smtp.gmail.com with ESMTPSA id o126sm2837350wmo.31.2019.06.11.01.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 01:23:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/3] oidmap: use sha1hash() instead of static hash() function
Date:   Tue, 11 Jun 2019 10:23:25 +0200
Message-Id: <20190611082325.28878-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.6.gde8b105b43
In-Reply-To: <20190611082325.28878-1-chriscool@tuxfamily.org>
References: <20190611082325.28878-1-chriscool@tuxfamily.org>
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

