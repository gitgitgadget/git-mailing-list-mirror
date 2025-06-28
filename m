Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100521C9E4
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084511; cv=none; b=eSKWlerDD7J081k1nlHVmrcEVIO55VSaciXPbPwRIA7W/fBLJ+kFDE8q/1dH4qiuagj1UzMGVn9UudO8Ib8Te2i5xdqcnp1QuS9YoZBwwVe3gGgYV8FGIW1aFZlfRBzXidZHmCQmMbh6Upq8MAkwIP7KhURkaCl1z/y6kCZ8Zjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084511; c=relaxed/simple;
	bh=qNjMSP+r6FcQi4PdolZE17VN0cVuL0XgdOBgueJp++w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fk1GimukOs5fQ8pVdt5iiuE9xOPp7s/SmtYgBx4Bbnknwn2RO6OR/XtUKR3NUUhKttQMs84mHpCPHRMQZ+gI4xyBIUnog0NwkSP4Su2s4inCI1wHVETFvPEisZfClP/EPL0mdufh64m0nIRv34GU18MNw7SP6jvgMR4TnfWg2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ont2WvQn; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ont2WvQn"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b34c068faf8so3336158a12.2
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751084509; x=1751689309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd0VUWLZ11kTxuiIGjeVdf8MqzMJ9Xkl1TVFLTDrCb0=;
        b=Ont2WvQnaIccZqtgu5KenuuCkhhZgEuPosur9YscJp01f7BCj6/s7qYd1T2zfDIPd4
         BearVMOVt6iaL6jnRXtK/ABTxqdn/BaVbET+eUbCx9/tRlq+sFdIJ+UEIto9ae/5o7tK
         U3QFUipnfYYpnshm3n6ySh74z7oqk4/cVcWgVurMDv1DNvlC79jYkq3ZoJrBEUfnCZLt
         W9acMX377xzxAsph7a69Ymnxc+xfGOVKFMTFWubtxy2cCTjRZV079eLR6/eGHTK9CVwk
         TQQKiabc3pH+cXAdUJ7XLnHNB3KdnXUI7po1qifgrQSVfXh+5nTK7ss0Eq+3nR3ED55F
         CFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751084509; x=1751689309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd0VUWLZ11kTxuiIGjeVdf8MqzMJ9Xkl1TVFLTDrCb0=;
        b=PYP+KvQ2gy6e0HsNLeGBpl7+fSSyuqJL1yDU7k5SgWUGlNmtLV5Vu/xzpUVQalAn9y
         uik9SxvKWErgHLpNKaqS4MAzoWBAGVP6UCKs5qbLCM/bqVyB4bCqwON/CAPPhg1fZ35y
         QjBUqSpbBxHF89gI9Jv7SPzbaxqQ02j2QGUnIOhoKCUlgRpDgtzqZt/2kvPUa5yoVYbC
         kEXXQDJppDwERkdop6yMFLXgCVN+53gh4/aCAm1pQru2aiisMWVea+BkTr//s8Qdw+6K
         YazUjhMGf/x/mU69e9+XRmkTAyCR6f5sY6EyU/202iAO1hLhNWohVjs60WOzmuG9n05b
         rZeg==
X-Gm-Message-State: AOJu0Yw/7n3FAvO4M1OaC3ltrMePvyMm0jeMEnU1u16S9R5Kz6FqnVil
	sAooByqpgO+r3/XF0gHlHm40p53+LZnFCP9k0L0QMjF54RuNQZ+bk0ywL7Q/cAZnWIWrQg==
X-Gm-Gg: ASbGncuJike/MTlU7ImFjWA4TISox/OF9EvR6WgAJCcSiqO7W+Vm+zwR9KkcTczMmU5
	xAxnXrGKYAwotUOXUQwv+teCAqaNGZfxfsyXHjlnECnNutin1Mk9NaY3miVgAkpCzloU/tUnmGs
	LB2GqUiplLIjDrdBgAxJkp56NvMm7fVSGp0NHF2DZ3iZiyVz+No/UPYge2dIwbMZmopAAQaHFGX
	1tx5BztYYJ2k7LDvUDPcLaDgoGSLphTyZCupg/B2eDM3/pC+TLOoa1PEA8IMx5mzEC8tSVBABbH
	q4Out9rA57Iq9mOlis9sBHf2foKW8KOYYHmlym/l3MLj0tLdDme1mkvIOyQGrhP5juNA
X-Google-Smtp-Source: AGHT+IGCO31jE8bN8uYPLq2CRNwD02paXT/Nf53xjgto/1BHYfepaNGeKiUow/p1vs6NmfgHNeNwLA==
X-Received: by 2002:a05:6a21:32a5:b0:220:25c4:1881 with SMTP id adf61e73a8af0-220a1a6316cmr9426922637.39.1751084508734;
        Fri, 27 Jun 2025 21:21:48 -0700 (PDT)
Received: from r760 ([188.253.126.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5580faasm3402914b3a.76.2025.06.27.21.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:21:48 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v3 1/2] bloom: replace struct bloom_key * with struct bloom_keyvec
Date: Sat, 28 Jun 2025 12:21:39 +0800
Message-ID: <20250628042140.1097910-2-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The revision traversal limited by pathspec has optimization when
the pathspec has only one element. To support optimization for
multiple pathspec items, we need to modify the data structures
in struct rev_info.

struct rev_info uses bloom_keys and bloom_nr to store the bloom keys
corresponding to a single pathspec item. To allow struct rev_info
to store bloom keys for multiple pathspec items, a new data structure
`struct bloom_keyvec` is introduced. Each `struct bloom_keyvec`
corresponds to a single pathspec item.

In `struct rev_info`, replace bloom_keys and bloom_nr with bloom_keyvecs
and bloom_keyvec_nr. This commit still optimize one pathspec item, thus
bloom_keyvec_nr can only be 0 or 1.

New *_bloom_keyvec functions are added to create and destroy a keyvec.
bloom_filter_contains_vec() is added to check if all key in keyvec is
contained in a bloom filter. fill_bloom_keyvec_key() is added to
initialize a key in keyvec.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 bloom.c    | 31 +++++++++++++++++++++++++++++++
 bloom.h    | 20 ++++++++++++++++++++
 revision.c | 36 ++++++++++++++++++------------------
 revision.h |  6 +++---
 4 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/bloom.c b/bloom.c
index 0c8d2cebf9..8259cfce51 100644
--- a/bloom.c
+++ b/bloom.c
@@ -280,6 +280,25 @@ void deinit_bloom_filters(void)
 	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
 }
 
+struct bloom_keyvec *create_bloom_keyvec(size_t count)
+{
+	struct bloom_keyvec *vec;
+	size_t sz = sizeof(struct bloom_keyvec);
+	sz += count * sizeof(struct bloom_key);
+	vec = (struct bloom_keyvec *)xcalloc(1, sz);
+	vec->count = count;
+	return vec;
+}
+
+void destroy_bloom_keyvec(struct bloom_keyvec *vec)
+{
+	if (!vec)
+		return;
+	for (size_t nr = 0; nr < vec->count; nr++)
+		clear_bloom_key(&vec->key[nr]);
+	free(vec);
+}
+
 static int pathmap_cmp(const void *hashmap_cmp_fn_data UNUSED,
 		       const struct hashmap_entry *eptr,
 		       const struct hashmap_entry *entry_or_key,
@@ -540,3 +559,15 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 
 	return 1;
 }
+
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *vec,
+			      const struct bloom_filter_settings *settings)
+{
+	int ret = 1;
+
+	for (size_t nr = 0; ret > 0 && nr < vec->count; nr++)
+		ret = bloom_filter_contains(filter, &vec->key[nr], settings);
+
+	return ret;
+}
diff --git a/bloom.h b/bloom.h
index 6e46489a20..9e4e832c8c 100644
--- a/bloom.h
+++ b/bloom.h
@@ -74,6 +74,11 @@ struct bloom_key {
 	uint32_t *hashes;
 };
 
+struct bloom_keyvec {
+	size_t count;
+	struct bloom_key key[FLEX_ARRAY];
+};
+
 int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
@@ -100,6 +105,17 @@ void add_key_to_filter(const struct bloom_key *key,
 void init_bloom_filters(void);
 void deinit_bloom_filters(void);
 
+struct bloom_keyvec *create_bloom_keyvec(size_t count);
+void destroy_bloom_keyvec(struct bloom_keyvec *vec);
+
+static inline void fill_bloom_keyvec_key(const char *data, size_t len,
+					 struct bloom_keyvec *vec, size_t nr,
+					 const struct bloom_filter_settings *settings)
+{
+	assert(nr < vec->count);
+	fill_bloom_key(data, len, &vec->key[nr], settings);
+}
+
 enum bloom_filter_computed {
 	BLOOM_NOT_COMPUTED = (1 << 0),
 	BLOOM_COMPUTED     = (1 << 1),
@@ -137,4 +153,8 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
+int bloom_filter_contains_vec(const struct bloom_filter *filter,
+			      const struct bloom_keyvec *v,
+			      const struct bloom_filter_settings *settings);
+
 #endif
diff --git a/revision.c b/revision.c
index afee111196..3aa544c137 100644
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
@@ -736,19 +737,21 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		p++;
 	}
 
-	revs->bloom_keys_nr = path_component_nr;
-	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
+	revs->bloom_keyvecs_nr = 1;
+	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
+	bloom_keyvec = create_bloom_keyvec(path_component_nr);
+	revs->bloom_keyvecs[0] = bloom_keyvec;
 
-	fill_bloom_key(path, len, &revs->bloom_keys[0],
-		       revs->bloom_filter_settings);
+	fill_bloom_keyvec_key(path, len, bloom_keyvec, 0,
+			      revs->bloom_filter_settings);
 	path_component_nr = 1;
 
 	p = path + len - 1;
 	while (p > path) {
 		if (*p == '/')
-			fill_bloom_key(path, p - path,
-				       &revs->bloom_keys[path_component_nr++],
-				       revs->bloom_filter_settings);
+			fill_bloom_keyvec_key(path, p - path, bloom_keyvec,
+					      path_component_nr++,
+					      revs->bloom_filter_settings);
 		p--;
 	}
 
@@ -779,11 +782,8 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
-		result = bloom_filter_contains(filter,
-					       &revs->bloom_keys[j],
-					       revs->bloom_filter_settings);
-	}
+	result = bloom_filter_contains_vec(filter, revs->bloom_keyvecs[0],
+					   revs->bloom_filter_settings);
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -823,7 +823,7 @@ static int rev_compare_tree(struct rev_info *revs,
 			return REV_TREE_SAME;
 	}
 
-	if (revs->bloom_keys_nr && !nth_parent) {
+	if (revs->bloom_keyvecs_nr && !nth_parent) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 
 		if (bloom_ret == 0)
@@ -850,7 +850,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
 	if (!t1)
 		return 0;
 
-	if (!nth_parent && revs->bloom_keys_nr) {
+	if (!nth_parent && revs->bloom_keyvecs_nr) {
 		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
 		if (!bloom_ret)
 			return 1;
@@ -3230,10 +3230,10 @@ void release_revisions(struct rev_info *revs)
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
 
-	for (int i = 0; i < revs->bloom_keys_nr; i++)
-		clear_bloom_key(&revs->bloom_keys[i]);
-	FREE_AND_NULL(revs->bloom_keys);
-	revs->bloom_keys_nr = 0;
+	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)
+		destroy_bloom_keyvec(revs->bloom_keyvecs[i]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index 6d369cdad6..ac843f58d0 100644
--- a/revision.h
+++ b/revision.h
@@ -62,7 +62,7 @@ struct repository;
 struct rev_info;
 struct string_list;
 struct saved_parents;
-struct bloom_key;
+struct bloom_keyvec;
 struct bloom_filter_settings;
 struct option;
 struct parse_opt_ctx_t;
@@ -360,8 +360,8 @@ struct rev_info {
 
 	/* Commit graph bloom filter fields */
 	/* The bloom filter key(s) for the pathspec */
-	struct bloom_key *bloom_keys;
-	int bloom_keys_nr;
+	struct bloom_keyvec **bloom_keyvecs;
+	int bloom_keyvecs_nr;
 
 	/*
 	 * The bloom filter settings used to generate the key.
-- 
2.50.0.108.g6ae0c543ae

