Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB932620C4
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856174; cv=none; b=foqfZunZf4p8xqN6fGJtGUjf33v5nfDvigsi7hPEz49kDVrfTrIOJG8+S2LtHYNBuEG6SO+uPCmx25gpHWfRSjk8trWDJg0O16i1sKycmsn7bt6bQKJHHs3u0dTepOrKjUil+pheP7ARimYd1Jj0dQP+CVimm0DQYsXFy0n0Hmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856174; c=relaxed/simple;
	bh=zc/si9Lnp/dDdiovOF9yA96QYixV8hHPO+uNC1p0q4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWPtAvoqJIYGVHpdDeDKe+PeI+8PaeGYS6cbcc7wGSf3DrWdVAnTxzIyz4Q/LhdbB4SH4rsLfZoLOLg88Yg2BhRxscUJ/1oSn2kZ7DkN1Qf/IYxsKFXeUxsix2yRfp3sqvs9Kd7+SbWFhOdToGOxF1/O//AJ+2EErLrQtECXIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWLaWHjQ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWLaWHjQ"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-23649faf69fso66827145ad.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750856172; x=1751460972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaSIae4rrv+Gjiwqy7KbWJVqafjMsSUDdY9Lts//0ic=;
        b=AWLaWHjQF1miXR0ye6wrJo9UGqzAg9I1g6m55GjEe1UkhrQBEoMpWhigSs5fgz1ihQ
         Dw0FBbIDnXyUATt/XgAauOw3wVqEaFqJg0fcVYcCe4MC412kLzPXeNG6ugG3KZIzD0yh
         bDgJLmnABmRBvCoxGG95tyx2vcEnmE/Y5GQnIf5Y5HzkJ/Pk3amsbVnbc6Y+BtLu5sFa
         XHIbI6rnPzmQZg8BxESVobkS7guO0hk8T0pONZ7bfRgtYvNqKQg47L/ZA1Ia3d48/SsY
         Wqot18+J4/K2/FABE4hQ2xqvVcOs6IwJhkTxFkYnReaZ5KKK2TQ1aBbqNJwNTD2+I5bX
         XHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856172; x=1751460972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaSIae4rrv+Gjiwqy7KbWJVqafjMsSUDdY9Lts//0ic=;
        b=sRfN4XsSkcRd9xovOjOzQSYWWntGV4jkmz2RPBlaPxDICymNYKjVWH3pTpPWetNDhY
         M22sP8y0H+cowKzhVo1aihqhHdk4Xyek7/WE82c1yNp7IJAA36uk6WpFQ2Wox+2zkZbN
         smu/xAWQXsVtkFcoP12+gg88ykh7LC5R1EWVPtChC4iqkgOvHEaVjcKldbhPotoK4H9m
         HeXjZHWrMdhtqgyNHVpTFZ8nGqPsXTkFadiHwDzS41IDyGVAWWwmuIKFP+poftPKII44
         pjU+6FBpRl/moNDJJI9UT/oWklnhFI6/b/TMraH7bfHCjERZcDm5KgaICX27b6QJHdfO
         c/6g==
X-Gm-Message-State: AOJu0YyGSSoLiHja5QdxL2YovJK4XXhUqUr9z7cZgjKZfjHBDEk4H7k3
	xYwQkHsV/Tfl7MOSE7xD9R31xTT5zYIj8MUnxPr7NcWGnUM3W1mnQpgJH3VrXKBNfhE=
X-Gm-Gg: ASbGncsv4xEZ2crRTHkr94i3x6eTHFcegiZDvk2Zlf4fSbJbRpaFeN3jTd0L3/ZgUJR
	CAZicNPhKee0j4KGGUobv46YSb3RbEgGqy19WVvwPzzfPpW8RgY7fBHW7dwqfdNTHpMAlE42E/q
	UyZvWeWWZmBi5LNnZcMwDk2wqyrCCvbAIeYy0a6sfcm5ynR8pfD2mTM9yK3Kb8AV4RzHJKnkaCm
	iHXR1CSksWcPUro8pEwN7yGGrb3ONIC3omEBIBqQro4QDQ2V7HGUdNd9xkhpL561ZQkOorIEGNu
	Bjs6ubsGamEjOOAiDWSO3yCnr6XGlIwaVDA1GJLvrHLrHeIOoMQlll62ucOuidPcjK1Q
X-Google-Smtp-Source: AGHT+IGZ5p/sh8MeOSP0u5j1n3gjscPA/WUYfFYHfVfHCZpFHC6AHOBHIy60Myt5Nt9odAEwut6Dhw==
X-Received: by 2002:a17:902:cf0a:b0:235:ef87:bd50 with SMTP id d9443c01a7336-2382408079cmr57327235ad.45.1750856171879;
        Wed, 25 Jun 2025 05:56:11 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8391494sm136312145ad.1.2025.06.25.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:56:11 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH 1/2] bloom: replace struct bloom_key * with struct bloom_keyvec
Date: Wed, 25 Jun 2025 20:55:40 +0800
Message-ID: <20250625125541.3048632-2-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct rev_info uses bloom_keys and bloom_nr to store the bloom keys
corresponding to a single pathspec. To allow struct rev_info to store
the bloom keys for multiple pathspecs, a new data structure bloom_keyvec
is introduced. Each struct bloom_keyvec corresponds to a single pathspec.
In rev_info, an array bloom_keyvecs is used to store multiple bloom_keyvec
instances, along with its length bloom_keyvec_nr.

New bloom_keyvec_* functions are added to initialize, free, and access
elements in a keyvec. bloom_filter_contains_vec() is added to check
if all key in struct bloom_keyvec is contained in a bloom filter.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 bloom.c    | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 bloom.h    | 14 ++++++++++++++
 revision.c | 31 ++++++++++++++++---------------
 revision.h |  5 +++--
 4 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/bloom.c b/bloom.c
index 0c8d2cebf9..497bb44567 100644
--- a/bloom.c
+++ b/bloom.c
@@ -280,6 +280,36 @@ void deinit_bloom_filters(void)
 	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
 }
 
+void bloom_keyvec_init(struct bloom_keyvec *v, size_t initial_size)
+{
+	ALLOC_ARRAY(v->keys, initial_size);
+	v->nr = initial_size;
+}
+
+void bloom_keyvec_clear(struct bloom_keyvec *v)
+{
+	size_t i;
+	if (!v->keys)
+		return;
+
+	for (i = 0; i < v->nr; i++)
+		clear_bloom_key(&v->keys[i]);
+
+	FREE_AND_NULL(v->keys);
+	v->nr = 0;
+}
+
+struct bloom_key *bloom_keyvec_at(const struct bloom_keyvec *v, size_t i)
+{
+	assert(i < v->nr);
+	return &v->keys[i];
+}
+
+bool bloom_keyvec_empty(const struct bloom_keyvec *v)
+{
+	return v->nr == 0 || !v->keys;
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -540,3 +570,20 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 
 	return 1;
 }
+
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *keys,
+			      const struct bloom_filter_settings *settings)
+{
+	const struct bloom_key *key;
+	int i, ret;
+
+	for (i = 0; i < keys->nr; i++) {
+		key = &keys->keys[i];
+		ret = bloom_filter_contains(filter, key, settings);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return 1;
+}
\ No newline at end of file
diff --git a/bloom.h b/bloom.h
index 6e46489a20..d556af7310 100644
--- a/bloom.h
+++ b/bloom.h
@@ -74,6 +74,11 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+struct bloom_keyvec {
+	struct bloom_key *keys;
+	size_t nr;
+};
+
 int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
@@ -100,6 +105,11 @@ void add_key_to_filter(const struct bloom_key *key,
 void init_bloom_filters(void);
 void deinit_bloom_filters(void);
 
+void bloom_keyvec_init(struct bloom_keyvec *v, size_t initial_size);
+void bloom_keyvec_clear(struct bloom_keyvec *v);
+struct bloom_key *bloom_keyvec_at(const struct bloom_keyvec *v, size_t i);
+bool bloom_keyvec_empty(const struct bloom_keyvec *v);
+
 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
 	BLOOM_COMPUTED     = (1 << 1),
@@ -137,4 +147,8 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *keys,
+			      const struct bloom_filter_settings *settings);
+
 #endif
diff --git a/revision.c b/revision.c
index afee111196..cf7dc3b3fa 100644
--- a/revision.c
+++ b/revision.c
@@ -688,6 +688,7 @@ static int forbid_bloom_filters(struct pathspec *spec)
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
+	struct bloom_keyvec *bloom_keyvec;
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
@@ -736,10 +737,12 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		p++;
 	}
 
-	revs->bloom_keys_nr = path_component_nr;
-	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+	revs->bloom_keyvecs_nr = 1;
+	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
+	bloom_keyvec = &revs->bloom_keyvecs[0];
+	bloom_keyvec_init(bloom_keyvec, path_component_nr);
 
-	fill_bloom_key(path, len, &revs->bloom_keys[0],
+	fill_bloom_key(path, len, bloom_keyvec_at(bloom_keyvec, 0),
 		       revs->bloom_filter_settings);
 	path_component_nr = 1;
 
@@ -747,7 +750,8 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	while (p > path) {
 		if (*p == '/')
 			fill_bloom_key(path, p - path,
-				       &revs->bloom_keys[path_component_nr++],
+				       bloom_keyvec_at(bloom_keyvec,
+						       path_component_nr++),
 				       revs->bloom_filter_settings);
 		p--;
 	}
@@ -779,11 +783,8 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
-		result = bloom_filter_contains(filter,
-					       &revs->bloom_keys[j],
-					       revs->bloom_filter_settings);
-	}
+	result = bloom_filter_contains_vec(filter, &revs->bloom_keyvecs[0],
+					   revs->bloom_filter_settings);
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -823,7 +824,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keys_nr && !nth_parent) {
+	if (revs->bloom_keyvecs_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -850,7 +851,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keys_nr) {
+	if (!nth_parent && revs->bloom_keyvecs_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -3230,10 +3231,10 @@ void release_revisions(struct rev_info *revs)
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
 
-	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		clear_bloom_key(&revs->bloom_keys[i]);
-	FREE_AND_NULL(revs->bloom_keys);
-	revs->bloom_keys_nr = 0;
+	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)
+		bloom_keyvec_clear(&revs->bloom_keyvecs[i]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index 6d369cdad6..88167b710c 100644
--- a/revision.h
+++ b/revision.h
@@ -63,6 +63,7 @@ struct rev_info;
 struct string_list;
 struct saved_parents;
 struct bloom_key;
+struct bloom_keyvec;
 struct bloom_filter_settings;
 struct option;
 struct parse_opt_ctx_t;
@@ -360,8 +361,8 @@ struct rev_info {
 
 	/* Commit graph bloom filter fields */
 	/* The bloom filter key(s) for the pathspec */
-	struct bloom_key *bloom_keys;
-	int bloom_keys_nr;
+	struct bloom_keyvec *bloom_keyvecs;
+	int bloom_keyvecs_nr;
 
 	/*
 	 * The bloom filter settings used to generate the key.
-- 
2.50.0.108.g6ae0c543ae

