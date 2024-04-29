Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3C178CF1
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423472; cv=none; b=T+PTVOnuCBaTou/vZk0OtM8X57JfWWQC+Jhby74EOn8/NWU/9TQzWjmzg3Ri8gsqcOpQkOAYIv2COX+pNLGfnwZOz+XuoPxnToygMt2ZUCtrnNxX2LalPXdJ/liB7jXJORexqYY08Zg917OuyMCSAem7xmYyHJYEawXXpRYbeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423472; c=relaxed/simple;
	bh=fvxOkp2eWu9r6zgvz8Dpotl1KXKd9QgO0MMlUEB0+fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjBGKMAOR995nFu5yCqoQydnYz5hCgq9D5Q8sWvn4jx3Gtl1HW5TO/YLqTZpL4TXICDEzDjF/HF6gxlaCXTnMu69TdXhGWshGman1lMawKbMbUHSDELBec8HU8Um0VM7ldvVJMH5OcLcGoZVsiTNHv7zef4B+S21M7BGQ3rc3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JuVmP3SY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JuVmP3SY"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61be4b986aaso7895967b3.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423468; x=1715028268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTGZQKsd3E7eGfKoI7Y/lfPCuaKuqfdQIrqOutTbSSY=;
        b=JuVmP3SYdRZyKCNCX6F6cFKkAOi8vcFawEKKohLYaZrguI8jx8eC5z9LwRww/4ztWl
         jNz8pqkYeZLB6hzOJ8rjK0quO/MakMiQq7KZVebwTQpA43uBecKNON8eKrY26ImRI1qb
         h4miw6r09nHslEUhMiGCGhaolhTrc7J4oqfsRWAFchIls3L1BFon2B90GlK074I5kOmT
         ygsxLatom0RTm56Ru8zgPmwIc+v2MpdSRFLIgJqzX2jln5W2l/SDH4TBvhb4CcqtFXV8
         ui/LM+hDC+EZRsL6C3kiSMgTbJp/HA9vKTGb+WSfQdIsiAegw189bUH7V4X6AHcaWKs3
         7CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423468; x=1715028268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTGZQKsd3E7eGfKoI7Y/lfPCuaKuqfdQIrqOutTbSSY=;
        b=IQioHL8Gx4GECnQ7pCcipHkXDS2O9Q6PyBVfk8VFV6fl7/tQCcUGS1twlzXw5r1ZJ8
         VxJK3BNxULurPHAtXUlJoGJKVPLl/awGOYyFuSeyucjSI2zkdi+xiVaRk4Ks9VX72yh0
         Neq7QAKtGXQbApRO68i0kEQ3Y/ZdTdNO00rNVMhlYLv+myuwNK8TLVMVgdZayTULxbn9
         sTun5dw9pIe/RFlo65ASV1FrLc3me54Ec0pOyOO0Zi4mQAHNDcAJhFM90dHFcpRQBbrq
         8XPYbeezMZ3I5XULf01CcC9Ip4nrMkQCmrrq+qsZ4iuyxyu3dR26YdH/h1rL7UiDfaJJ
         8lSQ==
X-Gm-Message-State: AOJu0YxH7OsUzsRXD/z0lR7wTmGtkfrVF+IN1YHHlsJ79PBOyxnVFVZK
	hdqKJFYI/OUm9mXd+8W6MLFPr+9pue7nBUIa9fTJ1cqvUkjYDIsuV1pWwtAwKCT93iTv8P4WEyb
	Ar7k=
X-Google-Smtp-Source: AGHT+IF4aV4X053EDwy2/aBD3lp0TZ+eDqSxLTeZngeAb/zEynMaOt+oOR9FUDhd0LTysKuRfp+AmA==
X-Received: by 2002:a05:690c:f11:b0:61a:cc3c:ae69 with SMTP id dc17-20020a05690c0f1100b0061acc3cae69mr13317793ywb.18.1714423468137;
        Mon, 29 Apr 2024 13:44:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id he28-20020a05622a601c00b00437543e5307sm10792252qtb.40.2024.04.29.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:27 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 22/23] pseudo-merge: implement support for finding
 existing merges
Message-ID: <61ddb5742850868d0fd192f37048527c3b06e853.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

This patch implements support for reusing existing pseudo-merge commits
when writing bitmaps when there is an existing pseudo-merge bitmap which
has exactly the same set of parents as one that we are about to write.

Note that unstable pseudo-merges are likely to change between
consecutive repacks, and so are generally poor candidates for reuse.
However, stable pseudo-merges (see the configuration option
'bitmapPseudoMerge.<name>.stableThreshold') are by definition unlikely
to change between runs (as they represent long-running branches).

Because there is no index from a *set* of pseudo-merge parents to a
matching pseudo-merge bitmap, we have to construct the bitmap
corresponding to the set of parents for each pending pseudo-merge commit
and see if a matching bitmap exists.

This is technically quadratic in the number of pseudo-merges, but is OK
in practice for a couple of reasons:

  - non-matching pseudo-merge bitmaps are rejected quickly as soon as
    they differ in a single bit

  - already-matched pseudo-merge bitmaps are discarded from subsequent
    rounds of search

  - the number of pseudo-merges is generally small, even for large
    repositories

In order to do this, implement (a) a function that finds a matching
pseudo-merge given some uncompressed bitset describing its parents, (b)
a function that computes the bitset of parents for a given pseudo-merge
commit, and (c) call that function before computing the set of reachable
objects for some pending pseudo-merge.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c             | 15 ++++++--
 pack-bitmap.c                   | 32 +++++++++++++++++
 pack-bitmap.h                   |  2 ++
 pseudo-merge.c                  | 55 ++++++++++++++++++++++++++++
 pseudo-merge.h                  |  7 ++++
 t/t5333-pseudo-merge-bitmaps.sh | 64 +++++++++++++++++++++++++++++++++
 6 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index d4894ace9ee..f7245d7d6fa 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -19,6 +19,10 @@
 #include "tree-walk.h"
 #include "pseudo-merge.h"
 #include "oid-array.h"
+#include "config.h"
+#include "alloc.h"
+#include "refs.h"
+#include "strmap.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
@@ -443,6 +447,7 @@ static int fill_bitmap_tree(struct bitmap *bitmap,
 }
 
 static int reused_bitmaps_nr;
+static int reused_pseudo_merge_bitmaps_nr;
 
 static int fill_bitmap_commit(struct bb_commit *ent,
 			      struct commit *commit,
@@ -467,7 +472,7 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 			struct bitmap *remapped = bitmap_new();
 
 			if (commit->object.flags & BITMAP_PSEUDO_MERGE)
-				old = NULL;
+				old = pseudo_merge_bitmap_for_commit(old_bitmap, c);
 			else
 				old = bitmap_for_commit(old_bitmap, c);
 			/*
@@ -478,7 +483,10 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 			if (old && !rebuild_bitmap(mapping, old, remapped)) {
 				bitmap_or(ent->bitmap, remapped);
 				bitmap_free(remapped);
-				reused_bitmaps_nr++;
+				if (commit->object.flags & BITMAP_PSEUDO_MERGE)
+					reused_pseudo_merge_bitmaps_nr++;
+				else
+					reused_bitmaps_nr++;
 				continue;
 			}
 			bitmap_free(remapped);
@@ -604,6 +612,9 @@ int bitmap_writer_build(struct packing_data *to_pack)
 			    the_repository);
 	trace2_data_intmax("pack-bitmap-write", the_repository,
 			   "building_bitmaps_reused", reused_bitmaps_nr);
+	trace2_data_intmax("pack-bitmap-write", the_repository,
+			   "building_bitmaps_pseudo_merge_reused",
+			   reused_pseudo_merge_bitmaps_nr);
 
 	stop_progress(&writer.progress);
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1966b3b95f1..70230e26479 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1316,6 +1316,37 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	return cb.base;
 }
 
+struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						   struct commit *commit)
+{
+	struct commit_list *p;
+	struct bitmap *parents;
+	struct pseudo_merge *match = NULL;
+
+	if (!bitmap_git->pseudo_merges.nr)
+		return NULL;
+
+	parents = bitmap_new();
+
+	for (p = commit->parents; p; p = p->next) {
+		int pos = bitmap_position(bitmap_git, &p->item->object.oid);
+		if (pos < 0 || pos >= bitmap_num_objects(bitmap_git))
+			goto done;
+
+		bitmap_set(parents, pos);
+	}
+
+	match = pseudo_merge_for_parents(&bitmap_git->pseudo_merges,
+						parents);
+
+done:
+	bitmap_free(parents);
+	if (match)
+		return pseudo_merge_bitmap(&bitmap_git->pseudo_merges, match);
+
+	return NULL;
+}
+
 static void unsatisfy_all_pseudo_merges(struct bitmap_index *bitmap_git)
 {
 	uint32_t i;
@@ -2809,6 +2840,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		 */
 		close_midx_revindex(b->midx);
 	}
+	free_pseudo_merge_map(&b->pseudo_merges);
 	free(b);
 }
 
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 25d3b8e604a..0fefef39bec 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -119,6 +119,8 @@ int rebuild_bitmap(const uint32_t *reposition,
 		   struct bitmap *dest);
 struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
 				      struct commit *commit);
+struct ewah_bitmap *pseudo_merge_bitmap_for_commit(struct bitmap_index *bitmap_git,
+						   struct commit *commit);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 				  unsigned int indexed_commits_nr);
 int bitmap_writer_build(struct packing_data *to_pack);
diff --git a/pseudo-merge.c b/pseudo-merge.c
index e111c9cd1a6..9e21fbb5062 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -682,3 +682,58 @@ int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
 
 	return ret;
 }
+
+struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_map *pm,
+					      struct bitmap *parents)
+{
+	struct pseudo_merge *match = NULL;
+	size_t i;
+
+	if (!pm->nr)
+		return NULL;
+
+	/*
+	 * NOTE: this loop is quadratic in the worst-case (where no
+	 * matching pseudo-merge bitmaps are found), but in practice
+	 * this is OK for a few reasons:
+	 *
+	 *   - Rejecting pseudo-merge bitmaps that do not match the
+	 *     given commit is done quickly (i.e. `bitmap_equals_ewah()`
+	 *     returns early when we know the two bitmaps aren't equal.
+	 *
+	 *   - Already matched pseudo-merge bitmaps (which we track with
+	 *     the `->satisfied` bit here) are skipped as potential
+	 *     candidates.
+	 *
+	 *   - The number of pseudo-merges should be small (in the
+	 *     hundreds for most repositories).
+	 *
+	 * If in the future this semi-quadratic behavior does become a
+	 * problem, another approach would be to keep track of which
+	 * pseudo-merges are still "viable" after enumerating the
+	 * pseudo-merge commit's parents:
+	 *
+	 *   - A pseudo-merge bitmap becomes non-viable when the bit(s)
+	 *     corresponding to one or more parent(s) of the given
+	 *     commit are not set in a candidate pseudo-merge's commits
+	 *     bitmap.
+	 *
+	 *   - After processing all bits, enumerate the remaining set of
+	 *     viable pseudo-merge bitmaps, and check that their
+	 *     popcount() matches the number of parents in the given
+	 *     commit.
+	 */
+	for (i = 0; i < pm->nr; i++) {
+		struct pseudo_merge *candidate = use_pseudo_merge(pm, &pm->v[i]);
+		if (!candidate || candidate->satisfied)
+			continue;
+		if (!bitmap_equals_ewah(parents, candidate->commits))
+			continue;
+
+		match = candidate;
+		match->satisfied = 1;
+		break;
+	}
+
+	return match;
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index cc14e947e86..33acd00a3e5 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -208,4 +208,11 @@ int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
 			  struct bitmap *result,
 			  struct bitmap *roots);
 
+/*
+ * Returns a pseudo-merge which contains the exact set of commits
+ * listed in the "parents" bitamp, or NULL if none could be found.
+ */
+struct pseudo_merge *pseudo_merge_for_parents(const struct pseudo_merge_map *pm,
+					      struct bitmap *parents);
+
 #endif
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 909c17e301e..531f1924af4 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -22,6 +22,10 @@ test_pseudo_merges_cascades () {
 	test_trace2_data bitmap pseudo_merges_cascades "$1"
 }
 
+test_pseudo_merges_reused () {
+	test_trace2_data pack-bitmap-write building_bitmaps_pseudo_merge_reused "$1"
+}
+
 tag_everything () {
 	git rev-list --all --no-object-names >in &&
 	perl -lne '
@@ -322,4 +326,64 @@ test_expect_success 'pseudo-merge overlap stale traversal' '
 	)
 '
 
+test_expect_success 'pseudo-merge reuse' '
+	git init pseudo-merge-reuse &&
+	(
+		cd pseudo-merge-reuse &&
+
+		stable="1641013200" && # 2022-01-01
+		unstable="1672549200" && # 2023-01-01
+
+		for date in $stable $unstable
+		do
+			test_commit_bulk --date "$date +0000" 128 &&
+			test_tick || return 1
+		done &&
+
+		tag_everything &&
+
+		git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=1 \
+			-c bitmapPseudoMerge.test.threshold=now \
+			-c bitmapPseudoMerge.test.stableThreshold=$(($unstable - 1)) \
+			-c bitmapPseudoMerge.test.stableSize=512 \
+			repack -adb &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_pseudo_merge_commits 0 >stable-oids.before &&
+		test_pseudo_merge_commits 1 >unstable-oids.before &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=2 \
+			-c bitmapPseudoMerge.test.threshold=now \
+			-c bitmapPseudoMerge.test.stableThreshold=$(($unstable - 1)) \
+			-c bitmapPseudoMerge.test.stableSize=512 \
+			repack -adb &&
+
+		test_pseudo_merges_reused 1 <trace2.txt &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 3 merges &&
+
+		test_pseudo_merge_commits 0 >stable-oids.after &&
+		for i in 1 2
+		do
+			test_pseudo_merge_commits $i || return 1
+		done >unstable-oids.after &&
+
+		sort -u <stable-oids.before >expect &&
+		sort -u <stable-oids.after >actual &&
+		test_cmp expect actual &&
+
+		sort -u <unstable-oids.before >expect &&
+		sort -u <unstable-oids.after >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.45.0.23.gc6f94b99219

