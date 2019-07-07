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
	by dcvr.yhbt.net (Postfix) with ESMTP id 877101F461
	for <e@80x24.org>; Sun,  7 Jul 2019 08:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfGGIae (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jul 2019 04:30:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39070 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfGGIad (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jul 2019 04:30:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so13459429wma.4
        for <git@vger.kernel.org>; Sun, 07 Jul 2019 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQLDDbjf2S01h1lXslFYqfSqVr9rCqh2hmTcM+9Pzho=;
        b=AdKly+5ykkATqL5fnwf1A8Yu9ebbRGlsNEy/YOmKfHYwPuVZrDXiLrAlxcJsOVeRay
         H3nWFRUjgcAUwmXScubVtzOkyQKW4jB6vSlr7XleXccZPs/5iYuNhX5qCLXnJ+vuPB6a
         m7+pNom3FxdmbdEjm5Gd7pR88IQ9tEHUMJyeJwN3UBo8ExODXDWwF9CbjHGZROESv+BY
         vdUArw8AIEfJzRaZ8Kz28ftMXJAscp4cJ7rqXw1cX6IHmTHJLdIxYF+LMRFVw7shKr9w
         T7JqgevmzziPuqOESRHHO1F77i/bNsfaar4roz0Pi69tUqGm4nmJp5p/noE+RIMD9upl
         mkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQLDDbjf2S01h1lXslFYqfSqVr9rCqh2hmTcM+9Pzho=;
        b=UBY3IYeRwAf+TpuEx3yKTQ0gNJhe5pA4WJjcDdld8SjkmFFSm1iAOlywvkF7lmGmDX
         raU+wdpnIlZ9uhKiqaOjiBNH5FBbEFloZyuIx71yKR9F1g/tQh02qBnjW8P6ZAzzcTcQ
         jP8qelCK5eHtbugos/PKLNliFCk/K60qkeW4WJRlyDzt7REx8yKiIrKgUX5vJHmxXO5c
         9YfRRRO/ILryBFRWl1OQgzMGvrMDFz5/8GQGIKNnrpEXmugNaPDMnk2vVJK31vZ2/NEB
         t67EOzbn4rE7exhwKi4eHroeh6Y22mkBxLct6HWpqUOThsfFZbyx7YTTq1934y3Ao7Nh
         DH5w==
X-Gm-Message-State: APjAAAWxnlWZm2GyKGnJOf9ZDPl5X1OrwTzjZxHPujFcRLWINi4skAut
        2mvjQxVDNBwqWbRIzbKFKrWU+CfI+Pg=
X-Google-Smtp-Source: APXvYqxYoyZ9ruXwQFZ+huQNj+ectY6fCxi1yjrqhk3KBDiKLeiJ1feeY+1r/HPmcfTibIgasdJDhQ==
X-Received: by 2002:a1c:a019:: with SMTP id j25mr11710145wme.95.1562488230648;
        Sun, 07 Jul 2019 01:30:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10c1:a195:f489:5ba4:f140:8c9a])
        by smtp.gmail.com with ESMTPSA id u186sm9606319wmu.26.2019.07.07.01.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:30:30 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 1/5] oidmap: add oidmap_add()
Date:   Sun,  7 Jul 2019 10:29:58 +0200
Message-Id: <20190707083002.7037-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.514.g3228928bce.dirty
In-Reply-To: <20190707083002.7037-1-chriscool@tuxfamily.org>
References: <20190707083002.7037-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We will need to have more than one entry with the same oid key
in an oidmap, which is not supported yet, as oipmap_put()
replaces an existing entry with the same oid key. So let's add
oidmap_add().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 oidmap.c | 12 ++++++++++++
 oidmap.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/oidmap.c b/oidmap.c
index 6d6e840d03..bfb290ee01 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -43,6 +43,17 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
 	return hashmap_remove(&map->map, &entry, key);
 }
 
+void oidmap_add(struct oidmap *map, void *entry)
+{
+	struct oidmap_entry *to_put = entry;
+
+	if (!map->map.cmpfn)
+		oidmap_init(map, 0);
+
+	hashmap_entry_init(&to_put->internal_entry, oidhash(&to_put->oid));
+	hashmap_add(&map->map, to_put);
+}
+
 void *oidmap_put(struct oidmap *map, void *entry)
 {
 	struct oidmap_entry *to_put = entry;
@@ -53,3 +64,4 @@ void *oidmap_put(struct oidmap *map, void *entry)
 	hashmap_entry_init(&to_put->internal_entry, oidhash(&to_put->oid));
 	return hashmap_put(&map->map, to_put);
 }
+
diff --git a/oidmap.h b/oidmap.h
index 7a939461ff..21d929ad79 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -49,6 +49,12 @@ void oidmap_free(struct oidmap *map, int free_entries);
 void *oidmap_get(const struct oidmap *map,
 		 const struct object_id *key);
 
+/*
+ * Adds an oidmap entry. This allows to add duplicate entries (i.e.
+ * separate values with the same oid key).
+ */
+void oidmap_add(struct oidmap *map, void *entry);
+
 /*
  * Adds or replaces an oidmap entry.
  *
-- 
2.22.0.514.g3228928bce.dirty

