Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377AA187355
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250740; cv=none; b=MyNapQFo8AQpmESoxpFLTLjHWt6KyNZ/VFdl6CSnwe6BONGfIuH3ct/pN6KL8FJULEy5IM2YkZTmsvWv9IpspSjYBU23mbPIVRXt5ujS7EVn5UIjviFzKGO/gx1phiUwvJ0cxPzY6JYd3E/mx/vNC71N1HCsApmjft2vmm2ehzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250740; c=relaxed/simple;
	bh=gkvbmHez6Q+UVDblTIOqKfWNM1AUTI+4TH9Zog1dqso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jy8C3yRMn26uI1XVanBtOtakrF/B32OZM9K+BYV5rR202AS+OldBSgn/JPWk1NCZY5d0B1/2ENObXoOrsUmYN9iaEp5CRG4nHbFG8mP7Mi9qBqbVoj2MYfTgxd/hpufMpAOBQZDUnp9JfaKl0wKj+iKVnX8orpgkDQRomgtt4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jypg1woO; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jypg1woO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-65f9708c50dso644697b3.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250738; x=1721855538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2dfvSv62RBvTUQCe99MddFqLKtY7TcgwCI+/me6fO0=;
        b=jypg1woOYcckZI8/xE+tlqExsN2IYlgaIAfuR1LX/5lVHHeexZdH1QTm2l5W7KHl3c
         vNbMPLFBM3HBBXr/J54KRLDoQH1H3UdQASUzNGAYoBRDRFjlIrr7HP9RhVU72mV4Ew1y
         30xj3GZjCHpPNAa2C7VvXSJEU0iyj9OVi5EjNAkbxTbvmbDp9EaKdWsJlEfYrXbjXzSq
         u8/Gyj1NTzwkuB5HPuzjvd5h9Ugka212A3G7LluhUs6PiVrqeaJAkrVQ0+z7/xcvOkC2
         y39+pUpSjatf2dJDoeYt8OBdlvGVuHTfuHRv2d71CE81T1SwAKUGSLalu4x6Td9Lp7Ls
         Xj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250738; x=1721855538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2dfvSv62RBvTUQCe99MddFqLKtY7TcgwCI+/me6fO0=;
        b=jhQlLmnV9UMo7fACAuR4fdblJoK4QqPYS9+w5zV5vnIVUzFMcigtjPLiMDms+5q2MG
         ultPqSP/flxdgM8/BfPXPBdUzYXhOaNAo/cG606V6/tv3caF/xP8EpZQXzs9Y1VK4nTa
         wR1IkQDMy3SGLC0pWL3V5ChsVR1JCFTqzyDflMUTURIygsVW2V09bV4Wd1QFeLKTZxJt
         Y7Z+JfPICKJt1ns4lu8/4Ts5RIDEQ4IFBavz1WL25JsbXRWj/mFQcgjwhKh2dQOabRug
         F1y73xAfi4R7cqPfL/kvJPEMnbzsbzWcWeKWK1ndLdiEHqok0WTHSNuDzPyh2aGXmiHw
         2yHQ==
X-Gm-Message-State: AOJu0YzUIbF5yUnV/ObXKN/DgwIqBCNARt+x2aWaqXMXbsnnJoCBUYRV
	vAdjir7jhFkXfUMuSXC8IgUizethkqNZ/SqOjw688hsupb2OmgAZIraXNtdjHchR3IMOET2xYjd
	l
X-Google-Smtp-Source: AGHT+IHaDbYIW1XjOxMO74kn6QxFuZ6uSj53wRiFFAuZfM4G4nNqTCbaI9HoBB1P2lD/wV1ukJMsIw==
X-Received: by 2002:a0d:d182:0:b0:643:4879:3399 with SMTP id 00721157ae682-664fe35ca88mr36499957b3.6.1721250738004;
        Wed, 17 Jul 2024 14:12:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66603ce7189sm741987b3.104.2024.07.17.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:12:17 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:12:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/19] midx: introduce `bsearch_one_midx()`
Message-ID: <bfd1dadbf15cf735392ca15b52834f104cbd6538.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1721250704.git.me@ttaylorr.com>

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
index b6c3cd3e59..bb3fa43492 100644
--- a/midx.c
+++ b/midx.c
@@ -329,10 +329,21 @@ int nth_bitmapped_pack(struct repository *r, struct multi_pack_index *m,
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
index 527b853ac4..e23b3e695a 100644
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
2.46.0.rc0.94.g9b2aff57b3

