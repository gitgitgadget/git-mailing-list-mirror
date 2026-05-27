Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AB2F3C26
	for <git@vger.kernel.org>; Wed, 27 May 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911754; cv=none; b=X9ZgFMe9/EGmXxBbOrDJxE/dbkp+rkdqPvVGaeHHxzOh9iZtjYL5nIrVjKRUf0vst88ZOlnU/Gtafu7RVCewYMPQ/bngh/jrhPiQ20X503qbOP6xkC6DX2CoDWOQHPmDuO8D9CykDj79+jUTM3pXVIH/Su2QIJasfS2E+2W4EPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911754; c=relaxed/simple;
	bh=a8Qs3yvr7vZoK5gP26rUy1fId7oaFeTBx9pqUHn99ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6mCZXdt+KdA7ioci23ZJyLmLiu2n7AdYJR30MJ7q0j9Qotne9VsEivKhgwxT03b9tTjFYRnumNBDKb8dBndNnsok0dAeaYzaMcOcEe+HzrT97QwHBDRCAWgPVJYg4C64mTXMugJs8INWXwtQQ4EStgrlLaT656z9mlQbmzdEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Ou5aqt5g; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Ou5aqt5g"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c5361142fso11484903d50.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 12:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779911752; x=1780516552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+eYLsu++pcY97q8r5dhfcFrADUdqP68AWf3D+bmRLB0=;
        b=Ou5aqt5gxnULBcIyo8H25ApV0Z3xu7EeEL5KRsUeGt72aDL+a2PejXuxBvNt3dWeyl
         DSNYUMY34liH7pvMxA5iia41uyshJcRFCmExUwu5mhO/+LHZKbIwXotUuT1JpBx+p7gJ
         BSJemL1qTlNsjHHZ3Vpj3WOvOGdZF1rICWUE6Bad0Ks2HJyYSrYMFVy5+xNXSfR7G9Ko
         A7VVWqeKMQHl5ICOnwy/+AkmUAWI7z3PTqRg17zUQTUzs0zJGhJPkt2wpilAG4VwypJb
         VgV1K5rMNNQGLg3diBQ7VL4ytASWDvI1AKoVKDYL5M2mMSxLyAmLt9GoXeJDjGWn+lQS
         LsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911752; x=1780516552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eYLsu++pcY97q8r5dhfcFrADUdqP68AWf3D+bmRLB0=;
        b=Zl4h269Uu4YL8yo2PHGttX+vEK1+03aCglQC1kh4h4VxcFUlgtenz+Jf3f/aU18xhy
         iPXVlh6QykQ134BLysVTqQt2Bd0YQyGyWzkb6LN5x/d6vKwv9CSlzY3w2RVH6lsZSJCH
         7PPstlcApNwlBsXuW4K46N2KtJHBB/qg4JavCSWYKshe/0ysKaCneo+vNWilGK4trjFv
         /5ZRYGcAwemdVu81AlEdhrFekR7eKNU4Od7jw7pjhpTsYVqIHfc8VsEk07R/3p0eri9a
         4RGRclETCE7JUZD5GXaCawuF+yfs/DNFRJHE2YExN5i+8Uv9wcrEqtk60QVkN6EVj9cl
         IVIQ==
X-Gm-Message-State: AOJu0YzSKpiHG9Y3OWWWylQoaPLlWdL41UdYv9KBA5tKW/vbK81n6Jfk
	hwXGQR7HvNJI/UQtFANHqxXCIoQiFHudvKxrphx+iTfZTSykUW+BdGrxkaAyQSQtSqKyjWgp57l
	UG4DH8y4=
X-Gm-Gg: Acq92OEKDrTUnIUtF1R/zEuCPfs/1Wpft0V621bzVjX0khZcrXxSVl75gEpDC3VLcFs
	RLgGrE64ZeZe8ch0F7G0DkV9kRou5FliY7g+nEeiM3/KNsqiiniB2yoNanTfMBpMpYDr/1O+aW1
	flwQJyJH3VTVN+YHwRJXRgABheqAl480byaL0OyrsbitOEvLEikxkhiBMkmZHYGSLWdLqx3Xo5t
	TuK/hIHMOzaYqIzlYdCYlF8qBkxh8ayYqlpzUn2px/dkIubauQwmp53N0Fo/jqZBvO/aWr799jT
	pRpzRmbWBukAO+QN6ou+VSwS7VkGwCdHsTSgguAWkCSTwQRSDTe427gH2r31B9e37h3iT4AAm3U
	r88wgcbZh8WHFb2lnGnuzuHRYUh5ehvBKzWLPCI2/okIu7tMXjj9xvOgqrBYAOKNFrKEFvo4zyo
	PkYSLfJHoeLA5Tn8KRkfngZ19u/W3prNY2UB+Cc/qM+E/cBaOChDfXAUoeYo0v9TO2l2dYVqx5v
	0MzBP4hgNrbIbBMj7VUB9CVYzDt2AR4nge/k0yTiCCmYlOFZCxXjQgqVQDNQ5tBDHI+8tQc/xdp
	CqkHbbY3qpoo/soWBKjVoBaLnlk=
X-Received: by 2002:a05:690c:9a08:b0:7bf:4a8:3ebb with SMTP id 00721157ae682-7d3362b1af4mr247131447b3.39.1779911751685;
        Wed, 27 May 2026 12:55:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c435b54sm79075677b3.40.2026.05.27.12.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:55:51 -0700 (PDT)
Date: Wed, 27 May 2026 15:55:50 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 1/8] pack-bitmap: pass object position to
 `fill_bitmap_tree()`
Message-ID: <ad025810ab3c14152998755f6ea74cffc2438f92.1779911733.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
 <cover.1779911733.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779911733.git.me@ttaylorr.com>

In the following commit, callers of `fill_bitmap_tree()` will be
required to check the bit corresponding to their tree before calling
that function. That change will reduce the overhead of setting up and
tearing down stack frames for trees whose bits are already set.

To prepare for that change, have callers pass in the tree's bit position
in `fill_bitmap_tree()`, which will make the next commit easier to read.

In the meantime, this change has a surprising and measurable benefit
during bitmap generation, particularly on very large repositories.

When processing sub-trees within `fill_bitmap_tree()`, the preimage of
this patch did the following:

    while (tree_entry(&desc, entry)) {
        switch (object_type(entry.mode)) {
        case OBJ_TREE:
            if (fill_bitmap_tree(writer, bitmap,
                                 lookup_tree(writer->repo,
                                             &entry.oid)) < 0) {
                /* ... */
            }
            /* ... */
        }
    }

, first performing the object lookup via `lookup_tree()`, and then
locating its bit position within the recursive call. This patch
effectively reorders those two calls so that we first discover the
sub-tree's bit position, *then* load its tree.

By reordering these two operations, we spend fewer CPU cycles per
instruction, likely due to improved CPU dependency/cache/pipeline
behavior. Comparing the results of: running `perf stat` before and after
this commit, we have:

    +--------------+-------------+-------------+-------------------+
    |              | HEAD^       | HEAD        | Delta             |
    +--------------+-------------+-------------+-------------------+
    | elapsed      |   612.5 s   |   582.4 s   |  -30.1 s  (-4.9%) |
    | cycles       | 2,857.3 B   | 2,713.3 B   | -144.0 B  (-5.0%) |
    | instructions | 2,413.2 B   | 2,415.5 B   |   +2.3 B  (+0.1%) |
    | CPI          |     1.184   |     1.123   |  -0.061   (-5.1%) |
    +--------------+-------------+-------------+-------------------+

In a large repository with ~4.8M commit, and ~37.1M tree objects this
change improves timing from ~612.5 seconds down to ~582.4 seconds, or a
~4.9% improvement. More importantly, the number of CPU cycles spent
dropped off significantly as a result of this commit, lowering our
cycles-per-instruction ratio by about ~5.1%.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1c8070f99c0..2d5ff8fd406 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -456,10 +456,10 @@ static void bitmap_builder_clear(struct bitmap_builder *bb)
 
 static int fill_bitmap_tree(struct bitmap_writer *writer,
 			    struct bitmap *bitmap,
-			    struct tree *tree)
+			    struct tree *tree,
+			    uint32_t pos)
 {
 	int found;
-	uint32_t pos;
 	struct tree_desc desc;
 	struct name_entry entry;
 
@@ -467,9 +467,6 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	 * If our bit is already set, then there is nothing to do. Both this
 	 * tree and all of its children will be set.
 	 */
-	pos = find_object_pos(writer, &tree->object.oid, &found);
-	if (!found)
-		return -1;
 	if (bitmap_get(bitmap, pos))
 		return 0;
 	bitmap_set(bitmap, pos);
@@ -482,8 +479,12 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 	while (tree_entry(&desc, &entry)) {
 		switch (object_type(entry.mode)) {
 		case OBJ_TREE:
+			pos = find_object_pos(writer, &entry.oid, &found);
+			if (!found)
+				return -1;
 			if (fill_bitmap_tree(writer, bitmap,
-					     lookup_tree(writer->repo, &entry.oid)) < 0)
+					     lookup_tree(writer->repo,
+							 &entry.oid), pos) < 0)
 				return -1;
 			break;
 		case OBJ_BLOB:
@@ -575,8 +576,14 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 	}
 
 	while (tree_queue->nr) {
-		if (fill_bitmap_tree(writer, ent->bitmap,
-				     prio_queue_get(tree_queue)) < 0)
+		struct tree *t = prio_queue_get(tree_queue);
+		int found;
+
+		pos = find_object_pos(writer, &t->object.oid, &found);
+		if (!found)
+			return -1;
+
+		if (fill_bitmap_tree(writer, ent->bitmap, t, pos) < 0)
 			return -1;
 	}
 	return 0;
-- 
2.54.0.rc1.84.g1cf18622df7

