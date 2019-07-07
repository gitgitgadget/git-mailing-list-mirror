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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7441F461
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGGIaf (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55979 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGGIae (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so12873491wmj.5
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTlXERrzqpLHSY1faQeiwbQoiCrRbG52FZPiZbO8hMg=;
        b=Y8y5Sp6WamJ8nbsOxAe/VleYJ2FQRGPCk7G8+n18MTwsSvsi0peefNnjL2++BpnJUO
         do4a7cxV7Cl1Jg+J50DLHxL9uSE1PAGubdQ4CPIs6+Y4aDkAF1YFoeF0l/L/H9+ZHMqp
         DGUQTFtuyBuiQCHvrC1LLWwXx0FJPucDhJmmqN71O50NvEWyrH3DtrsngkuPi6BUeOZa
         gYfK1UHZlXyAxWZ5GGJdHZDMvHyPZK1nfrfcUMwKbpZdjyPbAoHuYN4WdjnilhHL2GKr
         aiIs8MPOzRse9JfK0o5EQqZiRJyh7T5ymDQze1xY2cLVV3CE5+VBiO8EfT0IgwIECMZz
         KQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTlXERrzqpLHSY1faQeiwbQoiCrRbG52FZPiZbO8hMg=;
        b=gB4+uDfyT0sfMGatFMqHLCKEZbXmPlRL+RHzy4ufaMjHPgq4vLfpPTWinT4IiGMuKb
         HTSu1HOu3Z2jh2jE+lB4Dr1FWQWBgEoK7xhVrT90wyo/4AwwoIXbJL5AiD2fQEJhSxXa
         P6IF10wj/Z8R2aTt3ZtGjMz3J134uthKqLkHcXjpJGt+Y90axdB0aVSHyH8bzx7EeLnz
         6mYRbZR7C3KqReEPQbyCFRBpq4gIOCqUG8/mUwneyrBI3FPgu2SvH67JHZuRiSczmMGa
         fGJvSZ7uYph3xRZbGu8ah8nZwQkkacN6mJTJoJpmxB7eJegMrc92ZDa6YB8GXXt12l42
         l9sQ==
X-Gm-Message-State: APjAAAWvnOoni0ihwLqAD3BNAiXT6ZHSKB9ypAuCWNJHu0t19x1xpYGZ
        aaWTrHcpOt8mk3jw3D926PeJfTmG2Y4=
X-Google-Smtp-Source: APXvYqwMH8lxWFSGwBAnNTW5ZK/KAZjqtnFDXcRf6Qb8lrG7+hwrcyYE3oYUXnzk1afJK8143yRQ+A==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr10528644wmi.148.1562488231885;
        Sun, 07 Jul 2019 01:30:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 2/5] oidmap: add oidmap_get_next()
Date:   Sun,  7 Jul 2019 10:29:59 +0200
Message-Id: <20190707083002.7037-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For now "oidmap.h" gives us no way to get all the entries that have the
same oid key from an oidmap, as oidmap_get() will always return the first
entry. So let's add oidmap_get_next() for this purpose.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 oidmap.c | 8 ++++++++
 oidmap.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/oidmap.c b/oidmap.c
index bfb290ee01..9cf9dfd533 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -32,6 +32,14 @@ void *oidmap_get(const struct oidmap *map, const struct object_id *key)
 	return hashmap_get_from_hash(&map->map, oidhash(key), key);
 }
 
+void *oidmap_get_next(const struct oidmap *map, const void *entry)
+{
+	if (!map->map.cmpfn)
+		return NULL;
+
+	return hashmap_get_next(&map->map, entry);
+}
+
 void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 {
 	struct hashmap_entry entry;
diff --git a/oidmap.h b/oidmap.h
index 21d929ad79..5aad22784a 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -49,6 +49,12 @@ void oidmap_free(struct oidmap *map, int free_entries);
 void *oidmap_get(const struct oidmap *map,
 		 const struct object_id *key);
 
+/*
+ * Returns the next equal oidmap entry, or NULL if not found. This can be
+ * used to iterate over duplicate entries (see `oidmap_add`).
+ */
+void *oidmap_get_next(const struct oidmap *map, const void *entry);
+
 /*
  * Adds an oidmap entry. This allows to add duplicate entries (i.e.
  * separate values with the same oid key).
-- 
2.22.0.514.g3228928bce.dirty

