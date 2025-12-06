Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD42C08CA
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053090; cv=none; b=YlLKnR3uzZu+6MSl05GKZFGIBZSs9aANFOAizq9eHmOu3HA7o4Yry9Anecd66L2ZTwOr7F/PbJQITwjOLRxuR4wuXC1jUD2PnbJ1ZlBWNFmrxto1aPoe+s0AT4Sxk2HJzIquDnAzlJnJsR7i1ArP8zB6LlPcLPHh57u9GCiSHJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053090; c=relaxed/simple;
	bh=bmoewWdD3bZJG232j21TWUf1xV5lHeDu1jeuF3vtkEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrU+qapDn6go5vf+699x21D/IBnD4yY9p58EblZgPUn8wbpnKqo+jMtezjLKy8s0ApVxR7zVICou1ZAYcYn3JIaZ98D9Kdz4qblA3PqSN8MhmbXqAjjBsbLhud6VVF4bUFRkp+yqwhK0si2oiuPZpcSZd9NOSRFhEeIOOayRYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=REYYFLJC; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="REYYFLJC"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fc72db706so2926028d50.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053087; x=1765657887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6kCQFKqS1rCkUoxv6b7Io9P3040qM43yRn7gbTYBfQ=;
        b=REYYFLJCmxmPaMeOCPFoGHQTuRd5IvUj1jcxfE11A0EGcbbsTdNDGgtG40QgFbxLcz
         h8DjMomTQr0rl4PG5kHHpwhUU0R670jQkZlvui6msL3P2ujWnHeD2x2U/q1BwPZGz8xp
         H6YHPIEibvju4kc5Jy4yTM6v1GHhUVdFHqZlGnsthOjmb+NjHyNZPZVv0HbKg/hGe9xi
         2zeP8V6221VZ0WBMqxG//6qPWblfFkI2F/hGYoi7INmNYfSc/eEIidmxc9IsbAMZMKd5
         b3seT4yyrbyC4i3uHiUq6NXVLhHg2Wey4Sxw2196JapdUJaxaQFkieJQHNaLlmU32K58
         28NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053087; x=1765657887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6kCQFKqS1rCkUoxv6b7Io9P3040qM43yRn7gbTYBfQ=;
        b=rQEvTwPt8HnVREJiyDUg8eX+eUctPsNO5hh49/lx8pzLzcrFlnG92+XQg0MAe4Armp
         Ss57ff0uHTPV3km4pily/obMNytax/P9t5bO/q+0Z05btnHzQoDhMQGie4YhvJdB69y3
         SVA1Vsrahq6ag+3EjITMEjy/zUewEwJnt4VTC+N6wlW4OaMaM2qeECYeyU/3G3oSsgpi
         cxaqNsjRML1cG/hL5bQZqgLMxySHXrvukjGIdkK9Om5bJrd8Ai0mbBG30nEApX6lIa9A
         IU4tfXQDS6QJVlmCTjhL3ZZbNn8FwDdJ6WbHQaPdXW/DD3VB0BtDt1SQO6cEVRmkyxm5
         KUSw==
X-Gm-Message-State: AOJu0YwAyQZsrlFWv0Uu4/BNoIrPuUWBO8JxEyAhAg01IpMVrtFIBprO
	h+geoPM8DAG0Ww+EK9tRf36o5DVdcd5Olm3RPxXfE6diTKrS6y+UGikxiK87SVvxWyOCgws44rC
	FLsstmkY=
X-Gm-Gg: ASbGncuYa2sAmzs5YXInaqOX37Ohfi791McQeT12I3dy6A6tl3AoAmKdrxUhsfBoy+5
	FxbRJjIVb+DmzVgT3OKOB8hpQtIBs+fIYXcwtahwR2nbzE29isS6ENJXmrAyWUORK3QWAwIuigw
	xIwNXgEGjEDwzW+hL+wUVkB8cbj618rKtVRMrYvjLlQLnw2B1DA0/XO3I0rvepAkwR1oywyzL6y
	Q1LODcGqq12Iz0JipY/pC5dunnnrVCl0bSu1Hab54u1d/OicvXKY59OjqRioeI1bCRMvqimpBIn
	P6rNh83H+D4SSAu4PlNzwIEnp1R8cFiiSNmEN0h7FTNfOXdbtxG1EJI6uJkNtUrWpkOqDktNnvH
	h+Va5LYBXzaHI1wfiOh6ARJ9bDYPUlYBMlsR5cvwBh3Idf/iaKGrrFQ7eZVeDQU0V0BZczzEZ7H
	QOHShdOFCwQpJ1QNy+L+ri31lnguK69oJqxh0SiqgnUi0iaAz1wZmYY6zJJxA3skKWsSfZUbiom
	syLze1t4t0F2uKyJFid3AwJ/rd+
X-Google-Smtp-Source: AGHT+IHS6RyEIqPjQjNM5eRvPHid1IgT6YkWpm+pUTMohE+ZbqtbyPbC5TC+VuyUOzKmB6tIkjuzdA==
X-Received: by 2002:a05:690e:2442:b0:644:472d:db04 with SMTP id 956f58d0204a3-6444e7cd89cmr2023714d50.55.1765053086983;
        Sat, 06 Dec 2025 12:31:26 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f5aeac5sm3381470d50.17.2025.12.06.12.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:26 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:25 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 09/17] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <d5389a93b16a4933b0c54f78f2d5ce84b9ecac53.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

The MIDX file format currently requires that pack files be identified by
the lexicographic ordering of their names (that is, a pack having a
checksum beginning with "abc" would have a numeric pack_int_id which is
smaller than the same value for a pack beginning with "bcd").

As a result, it is impossible to combine adjacent MIDX layers together
without permuting bits from bitmaps that are in more recent layer(s).

To see why, consider the following example:

          | packs       | preferred pack
  --------+-------------+---------------
  MIDX #0 | { X, Y, Z } | Y
  MIDX #1 | { A, B, C } | B
  MIDX #2 | { D, E, F } | D

, where MIDX #2's base MIDX is MIDX #1, and so on. Suppose that we want
to combine MIDX layers #0 and #1, to create a new layer #0' containing
the packs from both layers. With the original three MIDX layers, objects
are laid out in the bitmap in the order they appear in their source
pack, and the packs themselves are arranged according to the pseudo-pack
order. In this case, that ordering is Y, X, Z, B, A, C.

But recall that the pseudo-pack ordering is defined by the order that
packs appear in the MIDX, with the exception of the preferred pack,
which sorts ahead of all other packs regardless of its position within
the MIDX. In the above example, that means that pack 'Y' could be placed
anywhere (so long as it is designated as preferred), however, all other
packs must be placed in the location listed above.

Because that ordering isn't sorted lexicographically, it is impossible
to compact MIDX layers in the above configuration without permuting the
object-to-bit-position mapping. Changing this mapping would affect all
bitmaps belonging to newer layers, rendering the bitmaps associated with
MIDX #2 unreadable.

One of the goals of MIDX compaction is that we are able to shrink the
length of the MIDX chain *without* invalidating bitmaps that belong to
newer layers, and the lexicographic ordering constraint is at odds with
this goal.

However, packs do not *need* to be lexicographically ordered within the
MIDX. As far as I can gather, the only reason they are sorted lexically
is to make it possible to perform a binary search over the pack names in
a MIDX, necessary to make `midx_contains_pack()`'s performance
logarithmic in the number of packs rather than linear.

Relax this constraint by allowing MIDX writes to proceed with packs that
are not arranged in lexicographic order. `midx_contains_pack()` will
lazily instantiate a `pack_names_sorted` array on the MIDX, which will
be used to implement the binary search over pack names.

Note that this produces MIDXs which may be incompatible with earlier
versions of Git that have stricter requirements on the layout of packs
within a MIDX. This patch does *not* modify the version number of the
MIDX format, since existing versions of Git already know to gracefully
ignore a MIDX with packs that appear out-of-order.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                |  5 -----
 midx.c                      | 28 ++++++++++++++++++++++------
 midx.h                      |  1 +
 t/t5319-multi-pack-index.sh |  5 -----
 4 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index b262631ae45..55342fcb6dd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -410,11 +410,6 @@ static int write_midx_pack_names(struct hashfile *f, void *data)
 		if (ctx->info[i].expired)
 			continue;
 
-		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
-			BUG("incorrect pack-file order: %s before %s",
-			    ctx->info[i - 1].pack_name,
-			    ctx->info[i].pack_name);
-
 		writelen = strlen(ctx->info[i].pack_name) + 1;
 		hashwrite(f, ctx->info[i].pack_name, writelen);
 		written += writelen;
diff --git a/midx.c b/midx.c
index f9b11de9ca9..4d5fe880649 100644
--- a/midx.c
+++ b/midx.c
@@ -209,11 +209,6 @@ static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
 		if (!end)
 			die(_("multi-pack-index pack-name chunk is too short"));
 		cur_pack_name = end + 1;
-
-		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
-			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
-			      m->pack_names[i - 1],
-			      m->pack_names[i]);
 	}
 
 	trace2_data_intmax("midx", r, "load/num_packs", m->num_packs);
@@ -411,6 +406,7 @@ void close_midx(struct multi_pack_index *m)
 	}
 	FREE_AND_NULL(m->packs);
 	FREE_AND_NULL(m->pack_names);
+	FREE_AND_NULL(m->pack_names_sorted);
 	free(m);
 }
 
@@ -656,17 +652,37 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 	return strcmp(idx_or_pack_name, idx_name);
 }
 
+
+static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
+{
+	struct multi_pack_index *m = m_;
+	return strcmp(m->pack_names[*(const size_t *)a],
+		      m->pack_names[*(const size_t *)b]);
+}
+
 static int midx_contains_pack_1(struct multi_pack_index *m,
 				const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
+	if (!m->pack_names_sorted) {
+		uint32_t i;
+
+		ALLOC_ARRAY(m->pack_names_sorted, m->num_packs);
+
+		for (i = 0; i < m->num_packs; i++)
+			m->pack_names_sorted[i] = i;
+
+		QSORT_S(m->pack_names_sorted, m->num_packs, midx_pack_names_cmp,
+			m);
+	}
+
 	while (first < last) {
 		uint32_t mid = first + (last - first) / 2;
 		const char *current;
 		int cmp;
 
-		current = m->pack_names[mid];
+		current = m->pack_names[m->pack_names_sorted[mid]];
 		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
 		if (!cmp)
 			return 1;
diff --git a/midx.h b/midx.h
index e188ffeb578..39bf04b18e5 100644
--- a/midx.h
+++ b/midx.h
@@ -71,6 +71,7 @@ struct multi_pack_index {
 	uint32_t num_packs_in_base;
 
 	const char **pack_names;
+	size_t *pack_names_sorted;
 	struct packed_git **packs;
 };
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ca020091dda..03676d37b98 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -450,11 +450,6 @@ test_expect_success 'verify invalid chunk offset' '
 		"improper chunk offset(s)"
 '
 
-test_expect_success 'verify packnames out of order' '
-	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
-		"pack names out of order"
-'
-
 test_expect_success 'verify missing pack' '
 	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
 		"failed to load pack"
-- 
2.52.0.171.gd6a4e6b6955

