Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227213E041
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715089; cv=none; b=XCI0h38Slr8SA32kxfWHHpU+8WeufS7GdNT7SyODUQsZmAsakI21jBjzbu7oUA4eKGHlGaO1uSi9QTeRzN9UDj3E7/oufILisYc8ckqMKz3/O/ka1ij6mkcA6weij55I21A/aqE6DwDoLTcA/wPAxPPbdCYgPKuX2a6+v6E5CNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715089; c=relaxed/simple;
	bh=cBuOVa88A8CCMvbgDAO0BgUgfCMF001EHIaUML/0qXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKADOoq9aoeQbopJYJWgrYl6oDAXnDIRx7ygFxDakgrUEY7Qlt/GaaufU5uftwOVE7vNuIW7dpvnLFQWGjE0YJJ+dtokGHF4rvLEeNFplIAct+dtVBkb64nA7brRowhxOEVhUYM+ul3FO4kt+FWwqBSZYnxZ2JanPRd9QZrAnwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AgjiS1Tf; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AgjiS1Tf"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ae102523a4so8235956d6.1
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717715087; x=1718319887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uScawNpktYDzaAJVwIILX+gkfJ+wR/0v+41pAtl6WaM=;
        b=AgjiS1Tfj4uzcsFu6W2xI94h+iNcbnYZ8qn2gkOYsA6DpWcGpCqSjW7gO7nYrsts5V
         gawavf0Z27YCVOPJ85MBrBrcDCB2LZqRWaSgCCRiRkWFwDkCh5Z3fZKCKvb5ZJBl/9FO
         xJ1wwulINQ950N+8YebBvw87egv4Y4uJ/ONrQVYoPDXV+W444A86QNpncuxPlPc4bBwf
         +JdQla0Brxg5a4LhqXbIvkE3Ug/j9WRRgjz+2cDz7vpeSBkHBuc76Ysn9pumIsV/2GNF
         uiWznQ1xRyAxE2Nsmx2jb6rhSGa7P8p5pYIVkeVVfSJst3VtLG6xtKKxuFEMeGASqcve
         wzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717715087; x=1718319887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uScawNpktYDzaAJVwIILX+gkfJ+wR/0v+41pAtl6WaM=;
        b=LsQOyAKhgF8vgU2KmL9LtXRkOwppN6jVdoqKeDjxehWPLpuHyZlp+jDBgOaSJ7jAxJ
         o4s2G2P4TqxJnfseSBcX+a1OWZjkM3+YagcQ+cjDdf/GlGlCij3E3zIGXvzuO4+2NJTJ
         BO743wDxR2qmn3SB6OhSYOCRbxr+RQBPd0PhXOusl6cuvAl2g9mkMv8Ua7H7sLGKYoMf
         fgkgkCmCjGe/0Md+HpPJYxIa0QZ6xJ5R/NhVm0mMni/P0ztb4DiwdjzlGnbbwRm+KnuK
         v57UqSnvg5W2Wc2KJeSSYeDcvu2Ei+8f5/JQoaPqmz1EyzAsQgChoaooZUc2VexcmIor
         iIRw==
X-Gm-Message-State: AOJu0YyhOcnoX9p4pSK23zaI1jQodBeznfeBhAkq/yMVROLNBOEEYJbH
	+Nwtm5k4vY58Q9T5vv36ayOYLfNC6LWbs8QJfxYA1Zxc2b35na/LDlqaVWrbp+ZYt+8QVaw+LoT
	b+Y8=
X-Google-Smtp-Source: AGHT+IF567UOflgF7sBoCAoe2Ea6Pdj7NKRlk8O3p6tGGFeL7Lr+P467FPJny0WeuDCMmxHSoNE0fg==
X-Received: by 2002:a05:6214:4485:b0:6af:bc71:828b with SMTP id 6a1803df08f44-6b059f0e9d2mr10381956d6.58.1717715086500;
        Thu, 06 Jun 2024 16:04:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f9f6a94sm10490346d6.113.2024.06.06.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 16:04:46 -0700 (PDT)
Date: Thu, 6 Jun 2024 19:04:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/19] midx: introduce `bsearch_one_midx()`
Message-ID: <ac10770602e0fc386aa597cd314a718b83d78c52.1717715060.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

The `bsearch_midx()` function will be extended in a following commit to
search for the location of a given object ID across all MIDXs in a chain
(or the single non-chain MIDX if no chain is available).

While most callers will naturally want to use the updated
`bsearch_midx()` function, there are a handful of special cases that
will want finer control and will only want to search through a single
MIDX.

For instance, the object abbreviation code, which cares about object IDs
near to where we'd expect to find a match in a MIDX. In that case, we
want to look at the nearby matches in each layer of the MIDX chain, not
just a single one).

Split the more fine-grained control out into a separate function called
`bsearch_one_midx()` which searches only a single MIDX.

At present both `bsearch_midx()` and `bsearch_one_midx()` have identical
behavior, but the following commit will rewrite the former to be aware
of incremental MIDXs for the remaining non-special case callers.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c        | 17 +++++++--
 midx.h        |  5 ++-
 object-name.c | 99 +++++++++++++++++++++++++++------------------------
 3 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/midx.c b/midx.c
index cdc754af97..1b4a9d5d00 100644
--- a/midx.c
+++ b/midx.c
@@ -327,10 +327,21 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 	return 0;
 }
 
-int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result)
+int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
+		     uint32_t *result)
 {
-	return bsearch_hash(oid->hash, m->chunk_oid_fanout, m->chunk_oid_lookup,
-			    the_hash_algo->rawsz, result);
+	int ret = bsearch_hash(oid->hash, m->chunk_oid_fanout,
+			       m->chunk_oid_lookup, the_hash_algo->rawsz,
+			       result);
+	if (result)
+		*result += m->num_objects_in_base;
+	return ret;
+}
+
+int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
+		 uint32_t *result)
+{
+		return bsearch_one_midx(oid, m, result);
 }
 
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
diff --git a/midx.h b/midx.h
index 020e49f77c..46c53d69ff 100644
--- a/midx.h
+++ b/midx.h
@@ -90,7 +90,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
 		       struct bitmapped_pack *bp, uint32_t pack_int_id);
-int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
+int bsearch_one_midx(const struct object_id *oid, struct multi_pack_index *m,
+		     uint32_t *result);
+int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m,
+		 uint32_t *result);
 off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos);
 uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos);
 struct object_id *nth_midxed_object_oid(struct object_id *oid,
diff --git a/object-name.c b/object-name.c
index 523af6f64f..3307d5200c 100644
--- a/object-name.c
+++ b/object-name.c
@@ -132,28 +132,32 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
 static void unique_in_midx(struct multi_pack_index *m,
 			   struct disambiguate_state *ds)
 {
-	uint32_t num, i, first = 0;
-	const struct object_id *current = NULL;
-	int len = ds->len > ds->repo->hash_algo->hexsz ?
-		ds->repo->hash_algo->hexsz : ds->len;
-	num = m->num_objects;
+	for (; m; m = m->base_midx) {
+		uint32_t num, i, first = 0;
+		const struct object_id *current = NULL;
+		int len = ds->len > ds->repo->hash_algo->hexsz ?
+			ds->repo->hash_algo->hexsz : ds->len;
 
-	if (!num)
-		return;
+		num = m->num_objects + m->num_objects_in_base;
 
-	bsearch_midx(&ds->bin_pfx, m, &first);
+		if (!num)
+			continue;
 
-	/*
-	 * At this point, "first" is the location of the lowest object
-	 * with an object name that could match "bin_pfx".  See if we have
-	 * 0, 1 or more objects that actually match(es).
-	 */
-	for (i = first; i < num && !ds->ambiguous; i++) {
-		struct object_id oid;
-		current = nth_midxed_object_oid(&oid, m, i);
-		if (!match_hash(len, ds->bin_pfx.hash, current->hash))
-			break;
-		update_candidates(ds, current);
+		bsearch_one_midx(&ds->bin_pfx, m, &first);
+
+		/*
+		 * At this point, "first" is the location of the lowest
+		 * object with an object name that could match
+		 * "bin_pfx".  See if we have 0, 1 or more objects that
+		 * actually match(es).
+		 */
+		for (i = first; i < num && !ds->ambiguous; i++) {
+			struct object_id oid;
+			current = nth_midxed_object_oid(&oid, m, i);
+			if (!match_hash(len, ds->bin_pfx.hash, current->hash))
+				break;
+			update_candidates(ds, current);
+		}
 	}
 }
 
@@ -706,37 +710,40 @@ static int repo_extend_abbrev_len(struct repository *r UNUSED,
 static void find_abbrev_len_for_midx(struct multi_pack_index *m,
 				     struct min_abbrev_data *mad)
 {
-	int match = 0;
-	uint32_t num, first = 0;
-	struct object_id oid;
-	const struct object_id *mad_oid;
+	for (; m; m = m->base_midx) {
+		int match = 0;
+		uint32_t num, first = 0;
+		struct object_id oid;
+		const struct object_id *mad_oid;
 
-	if (!m->num_objects)
-		return;
+		if (!m->num_objects)
+			continue;
 
-	num = m->num_objects;
-	mad_oid = mad->oid;
-	match = bsearch_midx(mad_oid, m, &first);
+		num = m->num_objects + m->num_objects_in_base;
+		mad_oid = mad->oid;
+		match = bsearch_one_midx(mad_oid, m, &first);
 
-	/*
-	 * first is now the position in the packfile where we would insert
-	 * mad->hash if it does not exist (or the position of mad->hash if
-	 * it does exist). Hence, we consider a maximum of two objects
-	 * nearby for the abbreviation length.
-	 */
-	mad->init_len = 0;
-	if (!match) {
-		if (nth_midxed_object_oid(&oid, m, first))
-			extend_abbrev_len(&oid, mad);
-	} else if (first < num - 1) {
-		if (nth_midxed_object_oid(&oid, m, first + 1))
-			extend_abbrev_len(&oid, mad);
+		/*
+		 * first is now the position in the packfile where we
+		 * would insert mad->hash if it does not exist (or the
+		 * position of mad->hash if it does exist). Hence, we
+		 * consider a maximum of two objects nearby for the
+		 * abbreviation length.
+		 */
+		mad->init_len = 0;
+		if (!match) {
+			if (nth_midxed_object_oid(&oid, m, first))
+				extend_abbrev_len(&oid, mad);
+		} else if (first < num - 1) {
+			if (nth_midxed_object_oid(&oid, m, first + 1))
+				extend_abbrev_len(&oid, mad);
+		}
+		if (first > 0) {
+			if (nth_midxed_object_oid(&oid, m, first - 1))
+				extend_abbrev_len(&oid, mad);
+		}
+		mad->init_len = mad->cur_len;
 	}
-	if (first > 0) {
-		if (nth_midxed_object_oid(&oid, m, first - 1))
-			extend_abbrev_len(&oid, mad);
-	}
-	mad->init_len = mad->cur_len;
 }
 
 static void find_abbrev_len_for_pack(struct packed_git *p,
-- 
2.45.2.437.gecb9450a0e

