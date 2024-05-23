Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2437128804
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499623; cv=none; b=T3UPYJxz7yNMfvozcMz50xcKdYUWHzRbNtyzH2KCg0gnwO1PNrv6hUj/295NjPkXNjFkdzJLGRz2UxfPitWRZzVBdt+hBopTu5NgkNSOzApxFNRRLrmBwKtlweim/DQSxXavsoiC+QCoNl+Xpg3YJoVUTZ8FcpG+E+Qkh1QB5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499623; c=relaxed/simple;
	bh=IXbc+CIhtJrSC5vPkh2+CUL6JxXToWYrfWRgc5mKUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRzBY/QeS/LdPjXVvC/giIy1DinYDn3TRLuWLsYEokt/yWlx3fRX6Tv+CMXJ3f5G2ag1ff4tjXH8ciUdi4BXVeQCzp/fL4+xjjVHXZ7y3YoI+tmjGpRXdiNQKpB19g1h7xpq/Oh81hEpOtR6nL5HzPWsJhqwHgmDogdDFbNZCVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=b4s84MY2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b4s84MY2"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ab975abb24so4702556d6.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499620; x=1717104420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vGV2CaoHqUtYdRFml2QjMXVFzSQHg5ZJViOnrE6+zgU=;
        b=b4s84MY2Ba6DvEpNRDyrSnfpxWiYkwu5WUbcGpCSKLERMMeaP6n5Uq+/XBq0aMJhJO
         90XDAYwZvjf77SI4pm7Ld464LbPl5LkCA3v7YuIe44/xe9/RcY+bpUAnbfPDKgQvC2Nn
         1+gFn4ccdB87fYEhBd9DpSViAe987xHqAifLO2Ma+XdKPW3SmcELrxiee5Xe6LVJOPzg
         vt0x8ue3r2gZIMzX/z+q83vYmf+vAeI+9ZSz/qQj6o4ayb9F3A9LjEVge0EgzT9YFBHC
         rgTjTIzg2ZeVsw2u1Gu/+d/XCtVPsHO16pK6CZ8cxF9DO4cOV2P0+zdCkVaTl98a4NMe
         h3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499620; x=1717104420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGV2CaoHqUtYdRFml2QjMXVFzSQHg5ZJViOnrE6+zgU=;
        b=LPibm4CwjqRBB6ehyfuGQaDiHReGVkmpOf6E9prAeRzy9edXIvA77i+3yWL2lwzHr1
         GERviLx41hf3MBQp+Ulgl5LGsUk2qfiso4e6y449z7gNIxGuheCoi1DEbHJ6eew/ilSX
         dof1sLIGA8UFVXTlitSlCcw8cg+zHs6eITNlDMuRns+qPJA6oBjFbIjSl8htdU+3udUK
         6/LUsAB/MvtyzfikLiIxZXluN/43ehR4Qr8/jHyUfE30oRpDeqoC/SjThfyO2h1O5Onn
         ztkX+vuaTjfpVXxh18SbMt8HRsXwLbHUnmzwrk7QxX4QBLmWOEG3zuIz5bcEibHwDOPr
         YQsg==
X-Gm-Message-State: AOJu0YzR+ZMljy8SRC4IPi33ENKsw+UaOmJ2xe2JVDSUun+eo1bfN99o
	Rll4YBsREcC6Umzb8Plq0oB2rfOaPeyPSYKt5/DSDz+IY/4sJZyCfbpOn8Vjrkv7Bl+YsZVg50V
	a
X-Google-Smtp-Source: AGHT+IFoaK/x/hC0ox8tf8CmrjOKuAOtnzzgXArW/MLfxwT2O1xOM2dD+rgJL4kibqHG+exd+fdSeg==
X-Received: by 2002:a05:6214:5685:b0:6a0:cf48:5196 with SMTP id 6a1803df08f44-6abcd0b1860mr3506566d6.54.1716499620335;
        Thu, 23 May 2024 14:27:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070c2f02sm636586d6.1.2024.05.23.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:59 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 16/24] pseudo-merge: implement support for reading
 pseudo-merge commits
Message-ID: <3a72e66cb6932fa73f8261043b6dcc262ebb6e31.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Implement the basic API for reading pseudo-merge bitmaps, which consists
of four basic functions:

  - pseudo_merge_bitmap()
  - use_pseudo_merge()
  - apply_pseudo_merges_for_commit()
  - cascade_pseudo_merges()

These functions are all documented in pseudo-merge.h, but their rough
descriptions are as follows:

  - pseudo_merge_bitmap() reads and inflates the objects EWAH bitmap for
    a given pseudo-merge

  - use_pseudo_merge() does the same as pseudo_merge_bitmap(), but on
    the commits EWAH bitmap, not the objects bitmap

  - apply_pseudo_merges_for_commit() applies all satisfied pseudo-merge
    commits for a given result set, and cascades any yet-unsatisfied
    pseudo-merges if any were applied in the previous step

  - cascade_pseudo_merges() applies all pseudo-merges which are
    satisfied but have not been previously applied, repeating this
    process until no more pseudo-merges can be applied

The core of the API is the latter two functions, which are responsible
for applying pseudo-merges during the object traversal implemented in
the pack-bitmap machinery.

The other two functions (pseudo_merge_bitmap(), and use_pseudo_merge())
are low-level ways to interact with the pseudo-merge machinery, which
will be useful in future commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c | 235 +++++++++++++++++++++++++++++++++++++++++++++++++
 pseudo-merge.h |  44 +++++++++
 2 files changed, 279 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index f0080d53c03..7d131011497 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -10,6 +10,7 @@
 #include "commit.h"
 #include "alloc.h"
 #include "progress.h"
+#include "hex.h"
 
 #define DEFAULT_PSEUDO_MERGE_DECAY 1.0
 #define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
@@ -464,3 +465,237 @@ void free_pseudo_merge_map(struct pseudo_merge_map *pm)
 	}
 	free(pm->v);
 }
+
+struct pseudo_merge_commit_ext {
+	uint32_t nr;
+	const unsigned char *ptr;
+};
+
+static int pseudo_merge_ext_at(const struct pseudo_merge_map *pm,
+			       struct pseudo_merge_commit_ext *ext, size_t at)
+{
+	if (at >= pm->map_size)
+		return error(_("extended pseudo-merge read out-of-bounds "
+			       "(%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)at, (uintmax_t)pm->map_size);
+	if (at + 4 >= pm->map_size)
+		return error(_("extended pseudo-merge entry is too short "
+			       "(%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)(at + 4), (uintmax_t)pm->map_size);
+
+	ext->nr = get_be32(pm->map + at);
+	ext->ptr = pm->map + at + sizeof(uint32_t);
+
+	return 0;
+}
+
+struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
+					struct pseudo_merge *merge)
+{
+	if (!merge->loaded_commits)
+		BUG("cannot use unloaded pseudo-merge bitmap");
+
+	if (!merge->loaded_bitmap) {
+		size_t at = merge->bitmap_at;
+
+		merge->bitmap = read_bitmap(pm->map, pm->map_size, &at);
+		merge->loaded_bitmap = 1;
+	}
+
+	return merge->bitmap;
+}
+
+struct pseudo_merge *use_pseudo_merge(const struct pseudo_merge_map *pm,
+				      struct pseudo_merge *merge)
+{
+	if (!merge->loaded_commits) {
+		size_t pos = merge->at;
+
+		merge->commits = read_bitmap(pm->map, pm->map_size, &pos);
+		merge->bitmap_at = pos;
+		merge->loaded_commits = 1;
+	}
+	return merge;
+}
+
+static struct pseudo_merge *pseudo_merge_at(const struct pseudo_merge_map *pm,
+					    struct object_id *oid,
+					    size_t want)
+{
+	size_t lo = 0;
+	size_t hi = pm->nr;
+
+	while (lo < hi) {
+		size_t mi = lo + (hi - lo) / 2;
+		size_t got = pm->v[mi].at;
+
+		if (got == want)
+			return use_pseudo_merge(pm, &pm->v[mi]);
+		else if (got < want)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+
+	warning(_("could not find pseudo-merge for commit %s at offset %"PRIuMAX),
+		oid_to_hex(oid), (uintmax_t)want);
+
+	return NULL;
+}
+
+struct pseudo_merge_commit {
+	uint32_t commit_pos;
+	uint64_t pseudo_merge_ofs;
+};
+
+#define PSEUDO_MERGE_COMMIT_RAWSZ (sizeof(uint32_t)+sizeof(uint64_t))
+
+static void read_pseudo_merge_commit_at(struct pseudo_merge_commit *merge,
+					const unsigned char *at)
+{
+	merge->commit_pos = get_be32(at);
+	merge->pseudo_merge_ofs = get_be64(at + sizeof(uint32_t));
+}
+
+static int nth_pseudo_merge_ext(const struct pseudo_merge_map *pm,
+				struct pseudo_merge_commit_ext *ext,
+				struct pseudo_merge_commit *merge,
+				uint32_t n)
+{
+	size_t ofs;
+
+	if (n >= ext->nr)
+		return error(_("extended pseudo-merge lookup out-of-bounds "
+			       "(%"PRIu32" >= %"PRIu32")"), n, ext->nr);
+
+	ofs = get_be64(ext->ptr + st_mult(n, sizeof(uint64_t)));
+	if (ofs >= pm->map_size)
+		return error(_("out-of-bounds read: (%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)ofs, (uintmax_t)pm->map_size);
+
+	read_pseudo_merge_commit_at(merge, pm->map + ofs);
+
+	return 0;
+}
+
+static unsigned apply_pseudo_merge(const struct pseudo_merge_map *pm,
+				   struct pseudo_merge *merge,
+				   struct bitmap *result,
+				   struct bitmap *roots)
+{
+	if (merge->satisfied)
+		return 0;
+
+	if (!ewah_bitmap_is_subset(merge->commits, roots ? roots : result))
+		return 0;
+
+	bitmap_or_ewah(result, pseudo_merge_bitmap(pm, merge));
+	if (roots)
+		bitmap_or_ewah(roots, pseudo_merge_bitmap(pm, merge));
+	merge->satisfied = 1;
+
+	return 1;
+}
+
+static int pseudo_merge_commit_cmp(const void *va, const void *vb)
+{
+	struct pseudo_merge_commit merge;
+	uint32_t key = *(uint32_t*)va;
+
+	read_pseudo_merge_commit_at(&merge, vb);
+
+	if (key < merge.commit_pos)
+		return -1;
+	if (key > merge.commit_pos)
+		return 1;
+	return 0;
+}
+
+static struct pseudo_merge_commit *find_pseudo_merge(const struct pseudo_merge_map *pm,
+						     uint32_t pos)
+{
+	if (!pm->commits_nr)
+		return NULL;
+
+	return bsearch(&pos, pm->commits, pm->commits_nr,
+		       PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
+}
+
+int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
+				   struct bitmap *result,
+				   struct commit *commit, uint32_t commit_pos)
+{
+	struct pseudo_merge *merge;
+	struct pseudo_merge_commit *merge_commit;
+	int ret = 0;
+
+	merge_commit = find_pseudo_merge(pm, commit_pos);
+	if (!merge_commit)
+		return 0;
+
+	if (merge_commit->pseudo_merge_ofs & ((uint64_t)1<<63)) {
+		struct pseudo_merge_commit_ext ext = { 0 };
+		off_t ofs = merge_commit->pseudo_merge_ofs & ~((uint64_t)1<<63);
+		uint32_t i;
+
+		if (pseudo_merge_ext_at(pm, &ext, ofs) < -1) {
+			warning(_("could not read extended pseudo-merge table "
+				  "for commit %s"),
+				oid_to_hex(&commit->object.oid));
+			return ret;
+		}
+
+		for (i = 0; i < ext.nr; i++) {
+			if (nth_pseudo_merge_ext(pm, &ext, merge_commit, i) < 0)
+				return ret;
+
+			merge = pseudo_merge_at(pm, &commit->object.oid,
+						merge_commit->pseudo_merge_ofs);
+
+			if (!merge)
+				return ret;
+
+			if (apply_pseudo_merge(pm, merge, result, NULL))
+				ret++;
+		}
+	} else {
+		merge = pseudo_merge_at(pm, &commit->object.oid,
+					merge_commit->pseudo_merge_ofs);
+
+		if (!merge)
+			return ret;
+
+		if (apply_pseudo_merge(pm, merge, result, NULL))
+			ret++;
+	}
+
+	if (ret)
+		cascade_pseudo_merges(pm, result, NULL);
+
+	return ret;
+}
+
+int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
+			  struct bitmap *result,
+			  struct bitmap *roots)
+{
+	unsigned any_satisfied;
+	int ret = 0;
+
+	do {
+		struct pseudo_merge *merge;
+		uint32_t i;
+
+		any_satisfied = 0;
+
+		for (i = 0; i < pm->nr; i++) {
+			merge = use_pseudo_merge(pm, &pm->v[i]);
+			if (apply_pseudo_merge(pm, merge, result, roots)) {
+				any_satisfied |= 1;
+				ret++;
+			}
+		}
+	} while (any_satisfied);
+
+	return ret;
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index e9216baace8..755edc054ae 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -162,4 +162,48 @@ struct pseudo_merge {
  */
 void free_pseudo_merge_map(struct pseudo_merge_map *pm);
 
+/*
+ * Loads the bitmap corresponding to the given pseudo-merge from the
+ * map, if it has not already been loaded.
+ */
+struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
+					struct pseudo_merge *merge);
+
+/*
+ * Loads the pseudo-merge and its commits bitmap from the given
+ * pseudo-merge map, if it has not already been loaded.
+ */
+struct pseudo_merge *use_pseudo_merge(const struct pseudo_merge_map *pm,
+				      struct pseudo_merge *merge);
+
+/*
+ * Applies pseudo-merge(s) containing the given commit to the bitmap
+ * "result".
+ *
+ * If any pseudo-merge(s) were satisfied, returns the number
+ * satisfied, otherwise returns 0. If any were satisfied, the
+ * remaining unsatisfied pseudo-merges are cascaded (see below).
+ */
+int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
+				   struct bitmap *result,
+				   struct commit *commit, uint32_t commit_pos);
+
+/*
+ * Applies pseudo-merge(s) which are satisfied according to the
+ * current bitmap in result (or roots, see below). If any
+ * pseudo-merges were satisfied, repeat the process over unsatisfied
+ * pseudo-merge commits until no more pseudo-merges are satisfied.
+ *
+ * Result is the bitmap to which the pseudo-merge(s) are applied.
+ * Roots (if given) is a bitmap of the traversal tip(s) for either
+ * side of a reachability traversal.
+ *
+ * Roots may given instead of a populated results bitmap at the
+ * beginning of a traversal on either side where the reachability
+ * closure over tips is not yet known.
+ */
+int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
+			  struct bitmap *result,
+			  struct bitmap *roots);
+
 #endif
-- 
2.45.1.175.gcf0316ad0e9

