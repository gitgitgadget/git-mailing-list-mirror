Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C71799B
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958655; cv=none; b=TNEAKkwPocD0/LLq/8hHVSuzK0Udw9ekyhrTLytoJfHN3KFqrzoMpevlgRfdI9KjC+Kc0kNXbvpbjdak4IYOCsBjrbvl5ZLuE2nmP54/SH8lxO5WIBecSYbjL0z3bcBz4tz4uPKoK5DKp89t8r9T7mqgEm1SdzVDa323UNFWu1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958655; c=relaxed/simple;
	bh=zJpiA6QKm8NFfE3SAZyRzyOdL8EcHTGjp70PTEU+1cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nF2ZQYox/4W0FcSGZBF53GZ9FmPa1PqL1WDsPgvWKD5EAiMkW7NkDsAnDQIwoEz7Y0FGFHkbYvtB0pG4NX8bDkdSRdv1p6/nR76NfvMyJdb1UUrS6ZqpyFKDOJA655hT2rPxqEK4tbQ+wBoPR3bsxkkI7SPTLuS92pZmpzISZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nm8uEm9y; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nm8uEm9y"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-66ca5e8cc51so6637277b3.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722958652; x=1723563452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BW8V281MSbQL4oLIH7m7SiTPBBV9HM8HPjg04kVYmlk=;
        b=nm8uEm9yMsmtHE2mqB0JtmUxT+teYc6GjePZGXW2+3hwi1Afk8GvKsXrn30e9sGJjx
         TUXnk68hD0PeItkwhvqDhTrRNUgzXtjwie/8oCFI0iilxo/0Ea/cFnX/LJmUaJAW2Etj
         7qKsCWDfCvG7tMBaRp7U6wYrn6Rbu2JtNCzKNBHQb1DlfV3qer5NBATOrJzPHt3VP81u
         Rggtsb4yOwBouFRzNBCPvRAkk77HI0c3Fxg5zCrkEakqDblZyQHKRmJ6UfG4+vpsuUa6
         Di4WCjpQDnUw0J1hYbgcw4J2I1blrSOKCv02yY44+wSMBvwgRL76tT4C3ccCUryMD4xq
         ceHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958652; x=1723563452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW8V281MSbQL4oLIH7m7SiTPBBV9HM8HPjg04kVYmlk=;
        b=dmb8rnzOuLzX9LoOhn/xeD2A0hlf8+YvPVyeGcCEIrsDR13TEvrcZmKrLo2TsbKKK3
         niYDOrNNAm7NJYVHeLXs6SCGecvMJqsbcKUKnjRgANt8XsJjVp2Dh5N6XD7X6nTVlDQ7
         zCMEeV6MuRsplsZXu36Bi5jRnD+iRhmIJakHHpi/H3CBFBsHvkwIjB61gkG//L3Hwz2y
         tIOO6W4sKOzBQRfg31CgFAgd1uI4t+qstxoe9aRe95ov2zQjbD4yMBdbEYeM0QqQAmYI
         EUFwdtEUcFmVwRUuQb0sHjm+2OQxIlFremz6uFTyY5pQyPGuHT+DBnIgAPdeY27Dpi5x
         bXmA==
X-Gm-Message-State: AOJu0YxQ5MjotkbZWmIN9brMzWzO4D4kIuB/RjRBe6wNx6uQNuS0S3ev
	Wl0jfrtTD2ixdLvfkt3LopxP9xg1hM6ohEllVPVTvMZE0b3ic7lhZcAYcFEM32fTDyRKEVMOCw/
	X
X-Google-Smtp-Source: AGHT+IGkCK6sueGqkQbZ12dq8XNonzc3Dk4/s5ixWpYJNPpuultzfiwYT4mR43qd4u2weh0h77Af7A==
X-Received: by 2002:a81:bb4d:0:b0:63b:d711:e722 with SMTP id 00721157ae682-6895f7faa2dmr184183767b3.1.1722958652295;
        Tue, 06 Aug 2024 08:37:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a09e92aa2sm15890027b3.0.2024.08.06.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:37:31 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:37:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/19] midx: introduce `bsearch_one_midx()`
Message-ID: <32c3fceada73e8d53f4239eafc1f440c072920c8.1722958596.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1722958595.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722958595.git.me@ttaylorr.com>

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
index 25350152f1..bd6e3f26c9 100644
--- a/midx.c
+++ b/midx.c
@@ -330,10 +330,21 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
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
index 527b853ac4..739d46f9cf 100644
--- a/object-name.c
+++ b/object-name.c
@@ -134,28 +134,32 @@ static int match_hash(unsigned len, const unsigned char *a, const unsigned char
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
+		if (!m->num_objects)
+			continue;
 
-	bsearch_midx(&ds->bin_pfx, m, &first);
+		num = m->num_objects + m->num_objects_in_base;
 
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
 
@@ -708,37 +712,40 @@ static int repo_extend_abbrev_len(struct repository *r UNUSED,
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
2.46.0.46.g406f326d27.dirty

