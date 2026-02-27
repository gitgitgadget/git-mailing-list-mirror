Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277873A7F63
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772235772; cv=none; b=g1wPonb4cZ1dXkQJ1aS5SbvBEiex1Rv1hLNxUiRBsDNQrwROOkBFffQS1TGPm6CupwVl8+MXdE6qrGBht4ZnwhPcEciGmm+1BBfdcWcDEewwfcgPaCBJ8epdpLBtvvIDr45h/tMZl758hDyPmTFHYFilhxH6O4D2YuRM3MY3TcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772235772; c=relaxed/simple;
	bh=7lY6i39gtJ+3cFcmUkUxRAYFASoPVnRe0uWlIbgVEEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRpynBYZllDjGdOKBMw7rqGNk7v9fHx99oqbICtstmcvzW8nqwp25EAKmkL7EGVyuj3lZPib8fPZABo48Yp35ANiIB6GWcNXUlZyjYzIzylvYui8SKS6IfFPoCzs5oH45wyJGRseOX7cmTY64lhIcmMZKv3S97yw0MWav43kN2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCM1L758; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCM1L758"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4807068eacbso21102125e9.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 15:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772235769; x=1772840569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=fCM1L758Bpft8FvnM5uQyHvFweNLdtYQeQYfgmyIIW2y1iNSUpphS8xWOPJzYY380w
         KJKHnRuybB+43WZOq5XmbcB1H6KSM9oafahz0+K7yCtRb2/4LHa4sCO/Kcb/+M7r8owL
         9ZGVEa3PBIhFm3gG3luYKnJB+/M79Gpsnke67hdTjInLdwFKUlxoIOLdebj5jzv5LYjj
         3yXHfaF45R22yRkDofude/LVz7pZXLJHLbWH+VpP+/Zrtg/+tAF/93URueW5ERlFFNRC
         olMfmjVNBv5dhjt3OMRGHopyrsDnR7q1YfC19Rk4PDUe0yEXxD5zekAFr7b8ipBGPmM3
         QvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772235769; x=1772840569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhjVihwXwXH+H1aMZRfNz6NYRrWCy6fjycqEgdsuQko=;
        b=hMfwkaP5IsFfRBw2wX5Cvany4oOilfeZZxS+fku+fOk4FtMeeU+6FI8wjKr6TkpkIV
         GuWOH7o1pVQ2N8fpH881FiQ02n8H9Xj3LPOufBNdyUe72yvysm2HVpBIsGWI3eTQG3iW
         kpkOwhgyZuG++F83pztd4dU4VU4IFrg0q7XI1owMZh7Wd3XTyY6ZJJU1ua8RDwef2erd
         fO9A1+2LvyLx34ey/KxW08P8JG7jYUoHULLYi5/KbbTOTp1kDx/83MMju0G/J7EdJLID
         4r5BKYs6JkmzMeLH4D5DDLS02wWO5hJXwkBENNIThU2Y5VjDpn4xbICcS7MaZsy5UF9K
         mJbA==
X-Gm-Message-State: AOJu0YzSOGtFIfOWRP3x9oWNRrsy7IAyADZHcfaxbcCjVHgMNbHznnBz
	Qey/NBR0X2CWhCU/Ea0h3IxvKgZ26Nhvjr2gO5WLliXMVhSJ+uNrxk2/DgVEAxum
X-Gm-Gg: ATEYQzwzBkly00nmaAP1wrgWvT82O0eWv2ZK2LwJ2ujaTjW4tBsgSGMkGjcpwFhGb02
	dTjGOdXe0FoxB0EsiHt8QpVYZ/QChb9Rk6EYVTnYZAuv6xgoIAFWoe14i+YLWA78qdZK0iKfvnw
	zvR0YDQYaofI963D3DNpivprWMtvBsfn2jwbtn8Np55MZeySD6SqDhjlf0zbYUED318PJ+CqIum
	eo+ASHGZwU2q6/NrYsdIe05EQbq4vH6WAmkSKG2jrHI7U188D9QwXpj6QxzLAXFBP/dG8n9RJUN
	ThNIlctDHW8w56oEKKAIQLLXG6cFKktQ40VKU8E1TCPUVb0kThdlOT29w4rfr3sq8QPKSe7fOMZ
	tyclgAc6fhY+ZMRj8U4xjXlJr6uqKjIPprB2mLAwnFte65+iJ17IATWenUqFUp7jJ6HaTeDxLu6
	SxU6E9ea5cdcR20cTs96FcC0KX0Z8TxHHrTWFwlB+G6VZPUzIEiYIM
X-Received: by 2002:a05:600c:c16e:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-483c9bf448bmr73561075e9.24.1772235769131;
        Fri, 27 Feb 2026 15:42:49 -0800 (PST)
Received: from localhost.localdomain ([105.113.107.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm9710899f8f.36.2026.02.27.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:42:48 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Seyi Kufoiji <kuforiji98@gmail.com>
Subject: [PATCH 1/5] oidmap: make entry cleanup explicit in oidmap_clear
Date: Sat, 28 Feb 2026 00:42:09 +0100
Message-ID: <20260227234213.17633-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227234213.17633-1-kuforiji98@gmail.com>
References: <20260227234213.17633-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kufoiji <kuforiji98@gmail.com>

Replace oidmap's use of hashmap_clear_() and layout-dependent freeing
with an explicit iteration and optional free callback. This removes
reliance on struct layout assumptions while keeping the existing API
intact.

Add tests for oidmap_clear_with_free behavior.
test_oidmap__clear_with_free_callback verifies that entries are freed
when a callback is provided, while
test_oidmap__clear_without_free_callback verifies that entries are not
freed when no callback is given. These tests ensure the new clear
implementation behaves correctly and preserves ownership semantics.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 oidmap.c                | 23 ++++++++++++++++++++---
 oidmap.h                | 15 +++++++++++++++
 t/unit-tests/u-oidmap.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/oidmap.c b/oidmap.c
index 508d6c7dec..a1ef53577f 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -24,11 +24,28 @@ void oidmap_init(struct oidmap *map, size_t initial_size)
 
 void oidmap_clear(struct oidmap *map, int free_entries)
 {
-	if (!map)
+	oidmap_clear_with_free(map,
+		free_entries ? free : NULL);
+}
+
+void oidmap_clear_with_free(struct oidmap *map,
+			    oidmap_free_fn free_fn)
+{
+	struct hashmap_iter iter;
+	struct hashmap_entry *e;
+
+	if (!map || !map->map.cmpfn)
 		return;
 
-	/* TODO: make oidmap itself not depend on struct layouts */
-	hashmap_clear_(&map->map, free_entries ? 0 : -1);
+	hashmap_iter_init(&map->map, &iter);
+	while ((e = hashmap_iter_next(&iter))) {
+		struct oidmap_entry *entry =
+			container_of(e, struct oidmap_entry, internal_entry);
+		if (free_fn)
+			free_fn(entry);
+	}
+
+	hashmap_clear(&map->map);
 }
 
 void *oidmap_get(const struct oidmap *map, const struct object_id *key)
diff --git a/oidmap.h b/oidmap.h
index 67fb32290f..acddcaecdd 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -35,6 +35,21 @@ struct oidmap {
  */
 void oidmap_init(struct oidmap *map, size_t initial_size);
 
+/*
+ * Function type for functions that free oidmap entries.
+ */
+typedef void (*oidmap_free_fn)(void *);
+
+/*
+ * Clear an oidmap, freeing any allocated memory. The map is empty and
+ * can be reused without another explicit init.
+ *
+ * The `free_fn`, if not NULL, is called for each oidmap entry in the map
+ * to free any user data associated with the entry.
+ */
+void oidmap_clear_with_free(struct oidmap *map,
+			    oidmap_free_fn free_fn);
+
 /*
  * Clear an oidmap, freeing any allocated memory. The map is empty and
  * can be reused without another explicit init.
diff --git a/t/unit-tests/u-oidmap.c b/t/unit-tests/u-oidmap.c
index b23af449f6..00481df63f 100644
--- a/t/unit-tests/u-oidmap.c
+++ b/t/unit-tests/u-oidmap.c
@@ -14,6 +14,13 @@ struct test_entry {
 	char name[FLEX_ARRAY];
 };
 
+static int freed;
+
+static void test_free_fn(void *p) {
+	freed++;
+	free(p);
+}
+
 static const char *const key_val[][2] = { { "11", "one" },
 					  { "22", "two" },
 					  { "33", "three" } };
@@ -134,3 +141,37 @@ void test_oidmap__iterate(void)
 	cl_assert_equal_i(count, ARRAY_SIZE(key_val));
 	cl_assert_equal_i(hashmap_get_size(&map.map), ARRAY_SIZE(key_val));
 }
+
+void test_oidmap__clear_without_free_callback(void)
+{
+	struct oidmap local_map = OIDMAP_INIT;
+	struct test_entry *entry;
+
+	freed = 0;
+
+	FLEX_ALLOC_STR(entry, name, "one");
+	cl_parse_any_oid("11", &entry->entry.oid);
+	cl_assert(oidmap_put(&local_map, entry) == NULL);
+
+	oidmap_clear_with_free(&local_map, NULL);
+
+	cl_assert_equal_i(freed, 0);
+
+	free(entry);
+}
+
+void test_oidmap__clear_with_free_callback(void)
+{
+	struct oidmap local_map = OIDMAP_INIT;
+	struct test_entry *entry;
+
+	freed = 0;
+
+	FLEX_ALLOC_STR(entry, name, "one");
+	cl_parse_any_oid("11", &entry->entry.oid);
+	cl_assert(oidmap_put(&local_map, entry) == NULL);
+
+	oidmap_clear_with_free(&local_map, test_free_fn);
+
+	cl_assert_equal_i(freed, 1);
+}
-- 
2.43.0

