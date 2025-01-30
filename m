Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46861B4F21
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228434; cv=none; b=qyzBcAfOzmUEAfkwfMCZJ0T9zz0yyRGweE9oNqxUTb/bst8OIzekI/sICpZ1dZFQNrfvLuIyLQK9PuBnCn9ZxJGxMOpaJokcFeWgl2bgBP0nE63PPS6nmxe86OtmGfpucVrjewuaR0TcU0wXV9lGxwqTdshLzZ2wJgyzAJStWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228434; c=relaxed/simple;
	bh=UgNTkQj40msqh+R/SNKGNOqbZ6wmSpJune27bgM+/s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLladfLnF7E66KXRv6YMX0LDE/38cg4vOJMeFjeIZDE3N+2nbdgbSSZ7ilbus627xqbU7+MMOOpxiUhX7xnlOZaOQKd6yLguMCNfA3OJahog6QT51GXGkx7WSW/y8rSf4ddo16xlJO/j0hlhg6VX9jGrqefCyPUToPr8ESoFmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIIG8O94; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIIG8O94"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dc75f98188so315764a12.2
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738228431; x=1738833231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHt6Aan/+mIR1lo66eP2Rr0CLNK8OTEJCD2RdeBRRKQ=;
        b=GIIG8O944Hi9lpwU/RsY1dsmjjZaWHWy+QUMIpJXWj4LRK/lW4ODN5m1Yu+1txFc/1
         wfARRV0PraEA3Ovz7bfd77ZD+GzAEdfG49AdqO1VvfU0JEI/aAbu08go7as2In61qKkY
         BcurBEgX/Hhvm85YKaptxuWvEP/58O9XAoTG8cWciYI8Cxo2NBrLxHlGHGibU+NCEvjO
         4AM53zsY6nFGBbf28qFUZGsu6JnnIT8IAJCgESjFflDCkmG/ffTsheKLix0blYsGGY8d
         yP/5tLFyUvGYOzMxNtPkYamqYkj8DSDWOrNtgTq98OkQ23bKnvyOFHIN+drJmZik0DXG
         hrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738228431; x=1738833231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHt6Aan/+mIR1lo66eP2Rr0CLNK8OTEJCD2RdeBRRKQ=;
        b=bYx22yL8ILXaLApzRBOMPu2R6kkD/XQEc0xmKQSNzqXpCqApHvAT60LDnfnBtT56l6
         w937lmKGO9dCsmypwlSdLvEO5ja1npqc0Qq7RPaeq0wUx7g9EgMDshu9YZpVucLFl7Q7
         V4gMaEjF5sr6arOI3fL22XBsHOwe3QGzzzlp8jnFmYiEmiUL53KMjmj0FEogio/kICfA
         rergacQf8ntJqb3RFAnyhuFM7KsULQZM14t1ebitdiLHMxbWdN/PCE0uAUHf9usU19DO
         eYRK8E/SRYWDhkf3ORvgTn9WMcrOHKTEGzQOSD6EWen0foneHEZAq5Pei8HlKOkfPj5X
         n1PQ==
X-Gm-Message-State: AOJu0YzCwDvRsLJA84lKidwAlezmEaxtL/rguyuHJ8OoJ0q2uoFDcNru
	d0qcQuaubYSNDsUOswIg9ATfIW7JuTuE72nRvWruF3lV0kFxOWkfpzZOK1WZIZIPBg==
X-Gm-Gg: ASbGncuzzMg/CD3E8ycgNWRzc6D4TMvb0a+IFpnJDlsFgAfWUgXxLlbr1Sa18FFLe8R
	ErysoQ3tuuEwsijJvsig5MeUHeyrmGc+HvQJBgYjKt8UnfXpZJ2CEmfFYqFFQZmxwRAFGOZlXsV
	wrUwPhj8s8tkcCZNNeR+kaHVGhWSlj0hVyVKN4F2L9vqret4+i8of1mCKvUP57v96aODfWL9980
	UMRSuQZcNx01UNNfyV/OHF/5kp8q8cfMprQQIsoHqjnIRnXymfSkyWBrkpwBFR3OXt3fgGhvzae
	ojZoAuuZSNitK01ri+0s6AUfLfy2Tw==
X-Google-Smtp-Source: AGHT+IG+UmZ48475shKcbxoByRQ3bCgORr/kqs1gDuvBJf4igG55cgTUftRX+xYmdMMiwvSK71iNZA==
X-Received: by 2002:a05:6402:3589:b0:5dc:5c18:6cc with SMTP id 4fb4d7f45d1cf-5dc5efa8af0mr5795536a12.3.1738228430424;
        Thu, 30 Jan 2025 01:13:50 -0800 (PST)
Received: from localhost.localdomain ([154.120.90.178])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9ee4sm742249a12.25.2025.01.30.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:13:49 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 1/4] t/unit-tests: convert hashmap test to clar framework
Date: Thu, 30 Jan 2025 10:13:31 +0100
Message-ID: <20250130091334.39922-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250130091334.39922-1-kuforiji98@gmail.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adapts hashmap test script to clar framework by using clar assertions
where necessary. Test functions are created as both standalone and
inline to test different test cases.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                                  |   2 +-
 t/meson.build                             |   2 +-
 t/unit-tests/{t-hashmap.c => u-hashmap.c} | 226 +++++++++++-----------
 3 files changed, 114 insertions(+), 116 deletions(-)
 rename t/unit-tests/{t-hashmap.c => u-hashmap.c} (60%)

diff --git a/Makefile b/Makefile
index b0cdc1fd4a..2d9dad119a 100644
--- a/Makefile
+++ b/Makefile
@@ -1339,6 +1339,7 @@ THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
 CLAR_TEST_SUITES += u-ctype
 CLAR_TEST_SUITES += u-hash
+CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-prio-queue
 CLAR_TEST_SUITES += u-reftable-tree
@@ -1349,7 +1350,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_PROGRAMS += t-example-decorate
-UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-oid-array
 UNIT_TEST_PROGRAMS += t-oidmap
 UNIT_TEST_PROGRAMS += t-oidtree
diff --git a/t/meson.build b/t/meson.build
index 14fea8dddf..af597f9804 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1,6 +1,7 @@
 clar_test_suites = [
   'unit-tests/u-ctype.c',
   'unit-tests/u-hash.c',
+  'unit-tests/u-hashmap.c',
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-prio-queue.c',
   'unit-tests/u-reftable-tree.c',
@@ -45,7 +46,6 @@ test('unit-tests', clar_unit_tests)
 
 unit_test_programs = [
   'unit-tests/t-example-decorate.c',
-  'unit-tests/t-hashmap.c',
   'unit-tests/t-oid-array.c',
   'unit-tests/t-oidmap.c',
   'unit-tests/t-oidtree.c',
diff --git a/t/unit-tests/t-hashmap.c b/t/unit-tests/u-hashmap.c
similarity index 60%
rename from t/unit-tests/t-hashmap.c
rename to t/unit-tests/u-hashmap.c
index 83b79dff39..6b6d22005a 100644
--- a/t/unit-tests/t-hashmap.c
+++ b/t/unit-tests/u-hashmap.c
@@ -1,4 +1,4 @@
-#include "test-lib.h"
+#include "unit-test.h"
 #include "hashmap.h"
 #include "strbuf.h"
 
@@ -83,23 +83,23 @@ static void t_replace(struct hashmap *map, unsigned int ignore_case)
 	struct test_entry *entry;
 
 	entry = alloc_test_entry("key1", "value1", ignore_case);
-	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 
 	entry = alloc_test_entry(ignore_case ? "Key1" : "key1", "value2",
 				 ignore_case);
 	entry = hashmap_put_entry(map, entry, ent);
-	if (check(entry != NULL))
-		check_str(get_value(entry), "value1");
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(get_value(entry), "value1");
 	free(entry);
 
 	entry = alloc_test_entry("fooBarFrotz", "value3", ignore_case);
-	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+	cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 
 	entry = alloc_test_entry(ignore_case ? "FOObarFrotz" : "fooBarFrotz",
 				 "value4", ignore_case);
 	entry = hashmap_put_entry(map, entry, ent);
-	if (check(entry != NULL))
-		check_str(get_value(entry), "value3");
+	cl_assert(entry != NULL);
+	cl_assert_equal_s(get_value(entry), "value3");
 	free(entry);
 }
 
@@ -122,20 +122,18 @@ static void t_get(struct hashmap *map, unsigned int ignore_case)
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		entry = alloc_test_entry(key_val[i][0], key_val[i][1],
 					 ignore_case);
-		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
 		entry = get_test_entry(map, query[i][0], ignore_case);
-		if (check(entry != NULL))
-			check_str(get_value(entry), query[i][1]);
-		else
-			test_msg("query key: %s", query[i][0]);
+		cl_assert(entry != NULL);
+		cl_assert_equal_s(get_value(entry), query[i][1]);
 	}
 
-	check_pointer_eq(get_test_entry(map, "notInMap", ignore_case), NULL);
-	check_int(map->tablesize, ==, 64);
-	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
+	cl_assert_equal_p(get_test_entry(map, "notInMap", ignore_case), NULL);
+	cl_assert_equal_i(map->tablesize, 64);
+	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
 }
 
 static void t_add(struct hashmap *map, unsigned int ignore_case)
@@ -165,39 +163,19 @@ static void t_add(struct hashmap *map, unsigned int ignore_case)
 
 		hashmap_for_each_entry_from(map, entry, ent)
 		{
-			int ret;
-			if (!check_int((ret = key_val_contains(
-						key_val, seen,
-						ARRAY_SIZE(key_val), entry)),
-				       ==, 0)) {
-				switch (ret) {
-				case 1:
-					test_msg("found entry was not given in the input\n"
-						 "    key: %s\n  value: %s",
-						 entry->key, get_value(entry));
-					break;
-				case 2:
-					test_msg("duplicate entry detected\n"
-						 "    key: %s\n  value: %s",
-						 entry->key, get_value(entry));
-					break;
-				}
-			} else {
-				count++;
-			}
+			int ret = key_val_contains(key_val, seen,
+						   ARRAY_SIZE(key_val), entry);
+			cl_assert(ret == 0);
+			count++;
 		}
-		check_int(count, ==, 2);
+		cl_assert_equal_i(count, 2);
 	}
 
-	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
-		if (!check_int(seen[i], ==, 1))
-			test_msg("following key-val pair was not iterated over:\n"
-				 "    key: %s\n  value: %s",
-				 key_val[i][0], key_val[i][1]);
-	}
+	for (size_t i = 0; i < ARRAY_SIZE(seen); i++)
+		cl_assert_equal_i(seen[i], 1);
 
-	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
-	check_pointer_eq(get_test_entry(map, "notInMap", ignore_case), NULL);
+	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
+	cl_assert_equal_p(get_test_entry(map, "notInMap", ignore_case), NULL);
 }
 
 static void t_remove(struct hashmap *map, unsigned int ignore_case)
@@ -211,24 +189,25 @@ static void t_remove(struct hashmap *map, unsigned int ignore_case)
 
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		entry = alloc_test_entry(key_val[i][0], key_val[i][1], ignore_case);
-		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 	}
 
 	for (size_t i = 0; i < ARRAY_SIZE(remove); i++) {
 		entry = alloc_test_entry(remove[i][0], "", ignore_case);
 		removed = hashmap_remove_entry(map, entry, ent, remove[i][0]);
-		if (check(removed != NULL))
-			check_str(get_value(removed), remove[i][1]);
+		cl_assert(removed != NULL);
+		cl_assert_equal_s(get_value(removed), remove[i][1]);
 		free(entry);
 		free(removed);
 	}
 
 	entry = alloc_test_entry("notInMap", "", ignore_case);
-	check_pointer_eq(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
+	cl_assert_equal_p(hashmap_remove_entry(map, entry, ent, "notInMap"), NULL);
 	free(entry);
 
-	check_int(map->tablesize, ==, 64);
-	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
+	cl_assert_equal_i(map->tablesize, 64);
+	cl_assert_equal_i(hashmap_get_size(map),
+			  ARRAY_SIZE(key_val) - ARRAY_SIZE(remove));
 }
 
 static void t_iterate(struct hashmap *map, unsigned int ignore_case)
@@ -242,38 +221,21 @@ static void t_iterate(struct hashmap *map, unsigned int ignore_case)
 
 	for (size_t i = 0; i < ARRAY_SIZE(key_val); i++) {
 		entry = alloc_test_entry(key_val[i][0], key_val[i][1], ignore_case);
-		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 	}
 
 	hashmap_for_each_entry(map, &iter, entry, ent /* member name */)
 	{
-		int ret;
-		if (!check_int((ret = key_val_contains(key_val, seen,
-						       ARRAY_SIZE(key_val),
-						       entry)), ==, 0)) {
-			switch (ret) {
-			case 1:
-				test_msg("found entry was not given in the input\n"
-					 "    key: %s\n  value: %s",
-					 entry->key, get_value(entry));
-				break;
-			case 2:
-				test_msg("duplicate entry detected\n"
-					 "    key: %s\n  value: %s",
-					 entry->key, get_value(entry));
-				break;
-			}
-		}
+		int ret = key_val_contains(key_val, seen,
+						ARRAY_SIZE(key_val),
+						entry);
+		cl_assert(ret == 0);
 	}
 
-	for (size_t i = 0; i < ARRAY_SIZE(seen); i++) {
-		if (!check_int(seen[i], ==, 1))
-			test_msg("following key-val pair was not iterated over:\n"
-				 "    key: %s\n  value: %s",
-				 key_val[i][0], key_val[i][1]);
-	}
+	for (size_t i = 0; i < ARRAY_SIZE(seen); i++)
+		cl_assert_equal_i(seen[i], 1);
 
-	check_int(hashmap_get_size(map), ==, ARRAY_SIZE(key_val));
+	cl_assert_equal_i(hashmap_get_size(map), ARRAY_SIZE(key_val));
 }
 
 static void t_alloc(struct hashmap *map, unsigned int ignore_case)
@@ -284,17 +246,17 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
 		char *key = xstrfmt("key%d", i);
 		char *value = xstrfmt("value%d", i);
 		entry = alloc_test_entry(key, value, ignore_case);
-		check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
+		cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
 		free(key);
 		free(value);
 	}
-	check_int(map->tablesize, ==, 64);
-	check_int(hashmap_get_size(map), ==, 51);
+	cl_assert_equal_i(map->tablesize, 64);
+	cl_assert_equal_i(hashmap_get_size(map), 51);
 
 	entry = alloc_test_entry("key52", "value52", ignore_case);
-	check_pointer_eq(hashmap_put_entry(map, entry, ent), NULL);
-	check_int(map->tablesize, ==, 256);
-	check_int(hashmap_get_size(map), ==, 52);
+	cl_assert_equal_p(hashmap_put_entry(map, entry, ent), NULL);
+	cl_assert_equal_i(map->tablesize, 256);
+	cl_assert_equal_i(hashmap_get_size(map), 52);
 
 	for (int i = 1; i <= 12; i++) {
 		char *key = xstrfmt("key%d", i);
@@ -302,27 +264,27 @@ static void t_alloc(struct hashmap *map, unsigned int ignore_case)
 
 		entry = alloc_test_entry(key, "", ignore_case);
 		removed = hashmap_remove_entry(map, entry, ent, key);
-		if (check(removed != NULL))
-			check_str(value, get_value(removed));
+		cl_assert(removed != NULL);
+		cl_assert_equal_s(value, get_value(removed));
 		free(key);
 		free(value);
 		free(entry);
 		free(removed);
 	}
-	check_int(map->tablesize, ==, 256);
-	check_int(hashmap_get_size(map), ==, 40);
+	cl_assert_equal_i(map->tablesize, 256);
+	cl_assert_equal_i(hashmap_get_size(map), 40);
 
 	entry = alloc_test_entry("key40", "", ignore_case);
 	removed = hashmap_remove_entry(map, entry, ent, "key40");
-	if (check(removed != NULL))
-		check_str("value40", get_value(removed));
-	check_int(map->tablesize, ==, 64);
-	check_int(hashmap_get_size(map), ==, 39);
+	cl_assert(removed != NULL);
+	cl_assert_equal_s("value40", get_value(removed));
+	cl_assert_equal_i(map->tablesize, 64);
+	cl_assert_equal_i(hashmap_get_size(map), 39);
 	free(entry);
 	free(removed);
 }
 
-static void t_intern(void)
+void test_hashmap__intern(void)
 {
 	const char *values[] = { "value1", "Value1", "value2", "value2" };
 
@@ -330,32 +292,68 @@ static void t_intern(void)
 		const char *i1 = strintern(values[i]);
 		const char *i2 = strintern(values[i]);
 
-		if (!check(!strcmp(i1, values[i])))
-			test_msg("strintern(%s) returns %s\n", values[i], i1);
-		else if (!check(i1 != values[i]))
-			test_msg("strintern(%s) returns input pointer\n",
-				 values[i]);
-		else if (!check_pointer_eq(i1, i2))
-			test_msg("address('%s') != address('%s'), so strintern('%s') != strintern('%s')",
-				 i1, i2, values[i], values[i]);
-		else
-			check_str(i1, values[i]);
+		cl_assert_equal_s(i1, values[i]);
+		cl_assert(i1 != values[i]);
+		cl_assert_equal_p(i1, i2);
 	}
 }
 
-int cmd_main(int argc UNUSED, const char **argv UNUSED)
+void test_hashmap__replace_case_sensitive(void)
+{
+	setup(t_replace, 0);
+}
+
+void test_hashmap__replace_case_insensitive(void)
+{
+	setup(t_replace, 1);
+}
+
+void test_hashmap__get_case_sensitive(void)
+{
+	setup(t_get, 0);
+}
+
+void test_hashmap__get_case_insensitive(void)
+{
+	setup(t_get, 1);
+}
+
+void test_hashmap__add_case_sensitive(void)
+{
+	setup(t_add, 0);
+}
+
+void test_hashmap__add_case_insensitive(void)
+{
+	setup(t_add, 1);
+}
+
+void test_hashmap__remove_case_sensitive(void)
+{
+	setup(t_remove, 0);
+}
+
+void test_hashmap__remove_case_insensitive(void)
+{
+	setup(t_remove, 1);
+}
+
+void test_hashmap__iterate_case_sensitive(void)
+{
+	setup(t_iterate, 0);
+}
+
+void test_hashmap__iterate_case_insensitive(void)
+{
+	setup(t_iterate, 1);
+}
+
+void test_hashmap__alloc_case_sensitive(void)
+{
+	setup(t_alloc, 0);
+}
+
+void test_hashmap__alloc_case_insensitive(void)
 {
-	TEST(setup(t_replace, 0), "replace works");
-	TEST(setup(t_replace, 1), "replace (case insensitive) works");
-	TEST(setup(t_get, 0), "get works");
-	TEST(setup(t_get, 1), "get (case insensitive) works");
-	TEST(setup(t_add, 0), "add works");
-	TEST(setup(t_add, 1), "add (case insensitive) works");
-	TEST(setup(t_remove, 0), "remove works");
-	TEST(setup(t_remove, 1), "remove (case insensitive) works");
-	TEST(setup(t_iterate, 0), "iterate works");
-	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
-	TEST(setup(t_alloc, 0), "grow / shrink works");
-	TEST(t_intern(), "string interning works");
-	return test_done();
+	setup(t_alloc, 1);
 }
-- 
2.47.0.86.g15030f9556

