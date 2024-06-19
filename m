Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6215CD77
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834306; cv=none; b=gaSegG4Ugv+zbGWelUOqTsNymJoU2DcULk/axIZXCQ8/pzfsxOFX1Xq+eE8XWJMbV4vzriSPfTp7m51ZmPGUWMAVueZ2nAX7clv7pqB2QHLodHdSUYFRZfzDcJFeQ/ND0P2o4YOssUr3IZY9oWabis8XQ7TyjGHwn5e94o0WXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834306; c=relaxed/simple;
	bh=SS1VX/bHVOIg70C8ZnfbqUdEsdROiq0mxqgBLnIMsJ8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tcjfqU5oV7bg2yd7uIgjCxx0EKKVAJ3jUuS1umkE0CkA/KyEdQZGAFeSB+cl7UzIXp6c2qQhTX9VW+PgLNYWagVxeHKZVvjQk06FZ7vh9U4IoM9eq/GrLXnAhaCJGjB3NDKrtyrZzJ2QuDhs9EVvVtl3qBXaGBKvEJSmqH5YI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOe5YHgo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOe5YHgo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4217a96de38so2268045e9.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834303; x=1719439103; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQrXYa+jFKbFvvZBMObzmsBQhCfNXAtt4FxFgErbZ7w=;
        b=TOe5YHgoftAAISywNoU4wAhIthKEzhQ8vqwewGB/O/E1l7mInYCWnQBoqsfEFjtRL8
         fMR5Wo9FydcVnuyQ6UhdvQyi7SnEiAxa9YqwHr1hUwEEwdz1sDyqn2Cdiuw6K9ZkIBxk
         JoKpQG/uvjGnvS3KmPZDNkfy7/7ZNvLPm7kL6TSMzXZ5gZ1IgG8vi8FHrdpRuhk39Dfw
         An2v1LtAqHBM3lA0xT7hPN78NpoEwo61XQ/C+a1S5hLjOQ89sAcLxnVwNSTf/eMe11ho
         xfmYGF5DnCpTGG/rht0py9hpFzeyiIJ8HjyIM9qTgpTYZ/Ee6/G49Kxyn292OBOsP/uW
         q0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834303; x=1719439103;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQrXYa+jFKbFvvZBMObzmsBQhCfNXAtt4FxFgErbZ7w=;
        b=wL/ZeJTkx5M0guTReyhAloIgLJNtmI8WssOonCZ8mcaINTv0ezO5siACB6vg0niShR
         lzEVKJ0jEqeaVYPITTxYddNkfNLahKkAmDCaKRrK4ffYDFKSdAc8HKfRPvhoEgtoiNsU
         VhqnlqNFLhEXtkgtqfDP9yLzlIdnl0RUbGiQQv4ggHUhuT2DpOph5/OTFWHxRIeB4/+J
         h1P6YehFKCIxGASMUneImi+ucfAmU88XY0TiqEEv1c5jVx0/lp7zz1LOJJEt+hzNHlmD
         xCBfwWFmKCjqViIT4ySTsSNmzN8mcmOdoXGYT2c5iq7//bzisMkoEwRlhJAaSMufMFr8
         q8cw==
X-Gm-Message-State: AOJu0YyHFqxDPas2o839NJ6LM/Y2WFe4WPpy1ROr+rlpA6c89hiCO1oW
	2kEyLknkmuvOMvcq12GqQOGnFQjrPguCuFla1GvlxLKYqZHkElDdSWl1pg==
X-Google-Smtp-Source: AGHT+IFJTwDuSpUn2tuLYmNKzQDVyeaiwg5zkq6U9wRpq5RCFozxtqRVZKedMMfsDOv2qbtyy5UBeA==
X-Received: by 2002:a05:600c:4a18:b0:422:13b2:584 with SMTP id 5b1f17b1804b1-4247529bc53mr24316815e9.37.1718834303032;
        Wed, 19 Jun 2024 14:58:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b8c5fsm3848905e9.6.2024.06.19.14.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:21 -0700 (PDT)
Message-Id: <2333775ba5bd71766a6aece87e39a6d189aeaead.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:00 +0000
Subject: [PATCH v2 12/17] mktree: create tree using an in-core index
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Rather than manually write out the contents of a tree object file, construct
an in-memory sparse index from the provided tree entries and create the tree
by writing out its corresponding cache tree.

This patch does not change the behavior of the 'mktree' command. However,
constructing the tree this way will substantially simplify future extensions
to the command's functionality, including handling deeper-than-toplevel tree
entries and applying the provided entries to an existing tree.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 74 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a91d3a7b028..3ce8d3dc524 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -4,6 +4,7 @@
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
 #include "builtin.h"
+#include "cache-tree.h"
 #include "gettext.h"
 #include "hex.h"
 #include "index-info.h"
@@ -24,6 +25,11 @@ struct tree_entry {
 	char name[FLEX_ARRAY];
 };
 
+static inline size_t df_path_len(size_t pathlen, unsigned int mode)
+{
+	return S_ISDIR(mode) ? pathlen - 1 : pathlen;
+}
+
 struct tree_entry_array {
 	size_t nr, alloc;
 	struct tree_entry **entries;
@@ -60,17 +66,25 @@ static void append_to_tree(unsigned mode, struct object_id *oid, const char *pat
 	if (literally) {
 		FLEX_ALLOC_MEM(ent, name, path, len);
 	} else {
+		size_t len_to_copy = len;
+
 		/* Normalize and validate entry path */
 		if (S_ISDIR(mode)) {
-			while(len > 0 && is_dir_sep(path[len - 1]))
-				len--;
+			while(len_to_copy > 0 && is_dir_sep(path[len_to_copy - 1]))
+				len_to_copy--;
+			len = len_to_copy + 1; /* add space for trailing slash */
 		}
-		FLEX_ALLOC_MEM(ent, name, path, len);
+		ent = xcalloc(1, st_add3(sizeof(struct tree_entry), len, 1));
+		memcpy(ent->name, path, len_to_copy);
 
 		if (!verify_path(ent->name, mode))
 			die(_("invalid path '%s'"), path);
 		if (strchr(ent->name, '/'))
 			die("path %s contains slash", path);
+
+		/* Add trailing slash to dir */
+		if (S_ISDIR(mode))
+			ent->name[len - 1] = '/';
 	}
 
 	ent->mode = mode;
@@ -88,11 +102,14 @@ static int ent_compare(const void *a_, const void *b_, void *ctx)
 	struct tree_entry *b = *(struct tree_entry **)b_;
 	int ignore_mode = *((int *)ctx);
 
-	if (ignore_mode)
-		cmp = name_compare(a->name, a->len, b->name, b->len);
-	else
-		cmp = base_name_compare(a->name, a->len, a->mode,
-					b->name, b->len, b->mode);
+	size_t a_len = a->len, b_len = b->len;
+
+	if (ignore_mode) {
+		a_len = df_path_len(a_len, a->mode);
+		b_len = df_path_len(b_len, b->mode);
+	}
+
+	cmp = name_compare(a->name, a_len, b->name, b_len);
 	return cmp ? cmp : b->order - a->order;
 }
 
@@ -108,8 +125,8 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	for (size_t i = 0; i < count; i++) {
 		struct tree_entry *curr = arr->entries[i];
 		if (prev &&
-		    !name_compare(prev->name, prev->len,
-				  curr->name, curr->len)) {
+		    !name_compare(prev->name, df_path_len(prev->len, prev->mode),
+				  curr->name, df_path_len(curr->len, curr->mode))) {
 			FREE_AND_NULL(curr);
 		} else {
 			arr->entries[arr->nr++] = curr;
@@ -122,24 +139,43 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 }
 
+static int add_tree_entry_to_index(struct index_state *istate,
+				   struct tree_entry *ent)
+{
+	struct cache_entry *ce;
+	struct strbuf ce_name = STRBUF_INIT;
+	strbuf_add(&ce_name, ent->name, ent->len);
+
+	ce = make_cache_entry(istate, ent->mode, &ent->oid, ent->name, 0, 0);
+	if (!ce)
+		return error(_("make_cache_entry failed for path '%s'"), ent->name);
+
+	add_index_entry(istate, ce, ADD_CACHE_JUST_APPEND);
+	strbuf_release(&ce_name);
+	return 0;
+}
+
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
-	struct strbuf buf;
-	size_t size = 0;
+	struct index_state istate = INDEX_STATE_INIT(the_repository);
+	istate.sparse_index = 1;
 
 	sort_and_dedup_tree_entry_array(arr);
-	for (size_t i = 0; i < arr->nr; i++)
-		size += 32 + arr->entries[i]->len;
 
-	strbuf_init(&buf, size);
+	/* Construct an in-memory index from the provided entries */
 	for (size_t i = 0; i < arr->nr; i++) {
 		struct tree_entry *ent = arr->entries[i];
-		strbuf_addf(&buf, "%o %s%c", ent->mode, ent->name, '\0');
-		strbuf_add(&buf, ent->oid.hash, the_hash_algo->rawsz);
+
+		if (add_tree_entry_to_index(&istate, ent))
+			die(_("failed to add tree entry '%s'"), ent->name);
 	}
 
-	write_object_file(buf.buf, buf.len, OBJ_TREE, oid);
-	strbuf_release(&buf);
+	/* Write out new tree */
+	if (cache_tree_update(&istate, WRITE_TREE_SILENT | WRITE_TREE_MISSING_OK))
+		die(_("failed to write tree"));
+	oidcpy(oid, &istate.cache_tree->oid);
+
+	release_index(&istate);
 }
 
 static void write_tree_literally(struct tree_entry_array *arr,
-- 
gitgitgadget

