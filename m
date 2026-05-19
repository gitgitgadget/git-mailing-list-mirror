Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AEA400DF4
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207180; cv=none; b=mER5p66iZT3KUbmMxnlKQz0TBQI5kNw6b9O5VHfucDOaXBRENCddYEzWVA0XN/itnn7GKtLUIotckdz3RzfzHjlmT+Z50FtyPvOw7SUZqbULgfXZYMRKNBDflzFPFsczoOqAMyQ45AVzHhU8rQE3InKPO0ryXyWsfemJAX2Ybgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207180; c=relaxed/simple;
	bh=egfGbhRDUs5s93PKNmw0wmYAaUMJfRw8aGqK+QVBxeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk7B4zseiceMiQlOP7C/SV0VzxPbIR9HLmeC3xNwA6J6GauGmfRL7kWxWwzIBxLp0beOLp5kaxsOhKLq64kLP1k7r9TrfSwUaZGa6xShnn/MDPkSE7N1Q6TPW9gNoUJKf1+hrjZonwXryWGH8cAFaKJmqEIHN2P4aF3p4UiX4I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UzcrOJ9I; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UzcrOJ9I"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651d6347a69so5229891d50.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779207177; x=1779811977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LtNyt0HMlfbBOKEZMIZHJmUI8Q6kHCDBGytrODTbr1c=;
        b=UzcrOJ9IjZsyqG1pnKpFQYOVseZ7ulEeK+Y56yg0Nap9fPyQxCROoCTPbaiWi6Qvfu
         NDk+UZotjJQsmebPRrl/iT3NCIAhiqmLlh8y3Eh6Yiy7Z5UJXamYkR5spTaCXwRrRKE4
         hsYScOvpIoAKY4YnJ8pMmdkuxCwK+eCMfpu/4nP2fFWZsLPghn10hHBp41Bzr6VQIiZp
         B1cTcPYigom9DPM9EEPL49D4C2W9DENKpq1PtOJHn50I4KmfIaKXN4ONLzqsMt+YzS9X
         GdXJCiSfaMbdAEI/xgT9uVZDAWwysRww3894wCofDq8xPM2xWV3M0YRXAk592uOZmCl3
         PkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207177; x=1779811977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtNyt0HMlfbBOKEZMIZHJmUI8Q6kHCDBGytrODTbr1c=;
        b=g+8pU/S8MK72c9PFBr7OWeYcvhXxmPeHKR1bibu/nl/SYxUpRuSOH4cr8l593XvyOJ
         5XeuQFJkR90v18qbN+kEpc9GivUu2+DN61CwxKcom6iLoryUX5lN8JG2Ka9vDVWQhCLz
         G/Bm5c1LDzNPcCgjNVYFgt/hXdNuqnAJe3t4ypJXNOyxHirBZl6zk/R8Zm1DUosD53mE
         Xj44Hr+/+aR5pjY/wYhB/yyC/F0MReoVnocvqQtopuTx7+fZqaEIj3BSx77Y4qWAkkWm
         m1c9GArH2v+9qMYi/W8bXtXMzLJT4E9QB5tG86ZMbDFUju9qE4idL//hH5PU8PTxAPOC
         rWtQ==
X-Gm-Message-State: AOJu0YxTW24aVL38KLuOExEqTFcoL6eP7zf8o0ayjxme3J7xcacG+Gz+
	46uhp5AoCeRhN6HXxczOTAMhYtuDi7mCuceFJG03VkSSFmm1OumH+ZnqSmsGPscXpZMkqff2JdN
	xqfjA7dNG1w==
X-Gm-Gg: Acq92OF7dCaN350/GzPQ9YDIWb32611V+Xs2Wa3WnDV/j71Jx5l5wxvrY8z2zT2bYNJ
	maF1tdU3UbioOsfKAap/NSThNahLqzBcJNkw2dPDzcelxhl9+AeYQ4QoGVkPseURDY3xj20Fnqj
	+WTgd1m1lVc8JBon7B9TqdyeJIqPZgFJ3U3IGxx8iBff6fIUtRjdbx5RKh06M+/pojQ5W8uYQP/
	T8csC6a3YOmN/xLg8H2wAoi8grNIH2WTQDuJngqt3vWbpDbbW+ZSg/oKLXHlx7S2BHPxySutOS1
	UzIBCAtnp5zT5geX6GXraraynjVvuB9dfFqoiXTZcOT3MczTHF3PqsEvcm5j/OL161iun/QWDye
	35rRfLB5PugmDsWr7j5MIxJhDzOMxR78XJ/0Rw5YTf3z3/u8CZfxVPV7MRMp51UthqhNTudK9Ju
	pqt9QKnJpoSY/2mHrpdxmSmhRGs/lMIG5BDFJSM8M3Ogk0k5qxHe1PxQSlhoNtiSAc5HMYWgVNd
	c3ktWgbXnmuIrlTB6dHB+XOF0G5HWCzjD5IctCnNW7vcamUVI7GFdbNyCqWG0pXiXtiUZiLtEHv
	pOBHvv5tHhU79ADrZswsCnQq+FQ=
X-Received: by 2002:a05:690e:4415:20b0:65d:f682:a59b with SMTP id 956f58d0204a3-65e216647fcmr12826478d50.26.1779207177204;
        Tue, 19 May 2026 09:12:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm8190905d50.2.2026.05.19.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:12:56 -0700 (PDT)
Date: Tue, 19 May 2026 12:12:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 8/8] pack-bitmap: build pseudo-merge bitmaps after regular
 bitmaps
Message-ID: <30ce254312cfee2a2a82f08246c3a2546ae32578.1779207127.git.me@ttaylorr.com>
References: <cover.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1779207127.git.me@ttaylorr.com>

When generating bitmaps, `bitmap_builder_init()` starts with an initial
selection of commits to receive bitmap coverage, and then determines a
set of "maximal" commits based on its input.

Commit 089f751360f (pack-bitmap-write: build fewer intermediate bitmaps,
2020-12-08) has extensive details, but the gist is as follows:

Each selected commit starts with one commit_mask bit in its "commit
mask" bitmap. Then, we walk the first-parent history in topological
order and OR each commit's mask into its (first) parent. Whenever that
OR results in the parent having more bits set, the child is deemed to be
non-maximal, and the frontier is pushed further back along the first
parent history.

That approach works extremely well for ordinary selected commits, whose
first-parent histories often describe real sharing between the bitmaps
we are going to write.

It struggles, however, to efficiently generate pseudo-merge bitmaps.
Unlike ordinary commits for which the above algorithm is designed,
pseudo-merges don't represent any "real" commit in history, just a
grouping of non-bitmapped reference tips. In that sense, their first
parent is just a part of a larger set, and treating them like ordinary
selected commits imposes a significant slow-down when generating bitmaps
with pseudo-merges enabled.

Consider partitioning all non-bitmapped reference tips into eight
individual pseudo-merges via the following configuration:

    [bitmapPseudoMerge "all"]
        pattern=refs/
        threshold=now
        stableSize=10000000
        maxMerges=8

, the cost of generating a bitmap from scratch rises significantly:

    +------------------+-----------------+---------------+---------------------+
    |                  | no pseudo-merge | pseudo-merges | Delta               |
    |                  |                 | (HEAD^)       |                     |
    +------------------+-----------------+---------------+---------------------+
    | elapsed          |   294.1 s       |   575.0 s     |   +280.9 s (+95.5%) |
    | cycles           | 1,365.5 B       | 2,686.9 B     | +1,321.4 B (+96.8%) |
    | instructions     | 1,389.8 B       | 2,546.6 B     | +1,156.8 B (+83.2%) |
    | CPI              |     0.983       |     1.055     |   +0.073    (+7.4%) |
    +------------------+-----------------+---------------+---------------------+

This is a particularly poor trade-off, because the time saved by these
pseudo-merges during, e.g.,

    $ git rev-list --count --all --objects --use-bitmap-index

is only:

    $ hyperfine -L v true,false -n 'pseudo-merges: {v}' '
        GIT_TEST_USE_PSEUDO_MERGES={v} git.compile rev-list --count \
          --objects --all --use-bitmap-index
      '

    Benchmark 1: pseudo-merges: true
      Time (mean ± σ):      2.613 s ±  0.012 s    [User: 2.308 s, System: 0.305 s]
      Range (min … max):    2.594 s …  2.633 s    10 runs

    Benchmark 2: pseudo-merges: false
      Time (mean ± σ):     52.205 s ±  0.170 s    [User: 51.500 s, System: 0.697 s]
      Range (min … max):   51.956 s … 52.458 s    10 runs

    Summary
      pseudo-merges: true ran
       19.98 ± 0.11 times faster than pseudo-merges: false

In other words, we pay a nearly ~5 minute penalty to generate
pseudo-merge bitmaps, but only save ~50 seconds during traversal.

The problem stems from injecting pseudo-merges into the bitmap builder
as if they were normal commits. The maximal commit selection algorithm
was simply not designed for that case, and performs predictably poorly.

The only reason we reused the maximal commit selection routine for
pseudo-merges alongside regular non-pseudo-merge commits is because we
represent them both as commit objects (where the pseudo-merge commits
just represent a made-up commit as opposed to one that actually exists
in a repository's object store).

Instead, build the regular selected commit bitmaps first, considering
only non-pseudo-merge commits in `bitmap_builder_init()`. Once those
bitmaps have been stored, build each pseudo-merge bitmap separately and
attach its parent and object bitmaps to the corresponding pseudo-merge
entry before writing the extension.

This keeps the regular bitmap build shaped like the no-pseudo-merge
case. The later pseudo-merge fill can still stop at stored selected
ancestor bitmaps, so it does not have to rewalk each pseudo-merge
closure from scratch.

When an existing bitmap has the same pseudo-merge parent set, reuse and
remap that whole pseudo-merge bitmap before falling back to
fill_bitmap_commit(). This preserves the benefit of stable pseudo-merges
while keeping the on-disk format and reader behavior unchanged.

As a result, the overhead cost for generating pseudo-merges in the above
configuration is much smaller:

    +------------------+-----------------+---------------+-------------------+
    |                  | no pseudo-merge | pseudo-merges | Delta             |
    |                  |                 | (HEAD)        |                   |
    +------------------+-----------------+---------------+-------------------+
    | elapsed          |   294.1 s       |   328.4 s     |  +34.3 s (+11.7%) |
    | cycles           | 1,365.5 B       | 1,529.3 B     | +163.7 B (+12.0%) |
    | instructions     | 1,389.8 B       | 1,552.8 B     | +163.0 B (+11.7%) |
    | CPI              |     0.983       |     0.985     |  +0.002   (+0.2%) |
    +------------------+-----------------+---------------+-------------------+

Recall that at the start of this series, generating reachability bitmaps
took 612.5 seconds *without* pseudo-merges. With this commit, it is
still ~46.38% *faster* to generate reachability bitmaps *with*
pseudo-merges than it was to generate bitmaps wihtout them at the
beginning of this series.

The changes to implement this are mostly straightforward. We exclude
pseudo-merge commits from the existing bitmap generation, and walk over
them in a separate pass, by either reusing an existing on-disk
pseudo-merge, or passing the pseudo-merge commit itself back to the
existing routine in `fill_bitmap_commit()`.

(Note that the routine to build pseudo-merge bitmaps is the same both
before and after this change, the difference is only that we do not let
psuedo-merges participate in determining the set of maximal commits.)

The only wrinkle is that `fill_bitmap_commit()` must be taught to not
expect that all tree objects have been parsed, which is the case for any
portion of history reachable by one or more pseudo-merge(s), but not by
any non-pseudo-merge commit selected for bitmapping.

Now that we have decoupled how we generate pseudo-merges from their
representation, the following commits will improve the API around
specifying pseudo-merge groupings during bitmap generation.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 210 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 174 insertions(+), 36 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 8200aed6101..1bcb3f98a42 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -446,13 +446,17 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	revs.topo_order = 1;
 	revs.first_parent_only = 1;
 
-	for (i = 0; i < writer->selected_nr; i++) {
+	for (i = 0; i < bitmap_writer_nr_selected_commits(writer); i++) {
 		struct bitmapped_commit *bc = &writer->selected[i];
 		struct bb_commit *ent = bb_data_at(&bb->data, bc->commit);
 
+		if (bc->pseudo_merge)
+			BUG("unexpected pseudo-merge at %"PRIuMAX,
+			    (uintmax_t)i);
+
 		ent->selected = 1;
 		ent->maximal = 1;
-		ent->pseudo_merge = bc->pseudo_merge;
+		ent->pseudo_merge = 0;
 		ent->idx = i;
 
 		ent->commit_mask = bitmap_new();
@@ -618,6 +622,8 @@ static int fill_bitmap_tree(struct bitmap_writer *writer,
 
 static int reused_bitmaps_nr;
 static int reused_pseudo_merge_bitmaps_nr;
+static int pseudo_merge_bitmap_nr;
+static int pseudo_merge_bitmap_parents;
 
 static int fill_bitmap_commit_calls_nr;
 static int fill_bitmap_commit_found_ancestor_nr;
@@ -631,8 +637,12 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      const uint32_t *mapping)
 {
 	int found;
+	int from_pseudo_merge = commit->object.flags & BITMAP_PSEUDO_MERGE;
 	uint32_t pos;
 
+	if (ent->pseudo_merge)
+		BUG("unexpected pseudo-merge commit in fill_bitmap_commit()");
+
 	fill_bitmap_commit_calls_nr++;
 
 	if (!ent->bitmap)
@@ -648,10 +658,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			struct ewah_bitmap *old;
 			struct bitmap *remapped = bitmap_new();
 
-			if (commit->object.flags & BITMAP_PSEUDO_MERGE)
-				old = pseudo_merge_bitmap_for_commit(old_bitmap, c);
-			else
-				old = bitmap_for_commit(old_bitmap, c);
+			old = bitmap_for_commit(old_bitmap, c);
 			/*
 			 * If this commit has an old bitmap, then translate that
 			 * bitmap and add its bits to this one. No need to walk
@@ -660,10 +667,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			if (old && !rebuild_bitmap(mapping, old, remapped)) {
 				bitmap_or(ent->bitmap, remapped);
 				bitmap_free(remapped);
-				if (commit->object.flags & BITMAP_PSEUDO_MERGE)
-					reused_pseudo_merge_bitmaps_nr++;
-				else
-					reused_bitmaps_nr++;
+				reused_bitmaps_nr++;
 				continue;
 			}
 			bitmap_free(remapped);
@@ -696,12 +700,32 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 		 * walk ensures we cover all parents.
 		 */
 		if (!(c->object.flags & BITMAP_PSEUDO_MERGE)) {
+			struct tree *tree;
+
+			if (from_pseudo_merge && !c->object.parsed) {
+				/*
+				 * Commits reachable from selected
+				 * non-pseudo-merges are already parsed
+				 * by the regular bitmap build.
+				 *
+				 * However, pseudo-merge fills can also
+				 * reach commits that were not covered
+				 * there, so parse any such leftovers
+				 * before reading their tree or parents.
+				 */
+				if (repo_parse_commit(writer->repo, c))
+					return -1;
+			}
+
 			pos = find_object_pos(writer, &c->object.oid, &found);
 			if (!found)
 				return -1;
 			bitmap_set(ent->bitmap, pos);
-			prio_queue_put(tree_queue,
-				       repo_get_commit_tree(writer->repo, c));
+
+			tree = repo_get_commit_tree(writer->repo, c);
+			if (!tree)
+				return -1;
+			prio_queue_put(tree_queue, tree);
 		}
 
 		for (p = c->parents; p; p = p->next) {
@@ -738,6 +762,137 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 	return 0;
 }
 
+static int reuse_pseudo_merge_bitmap(struct bitmap_index *old_bitmap,
+				     const uint32_t *mapping,
+				     struct commit *merge,
+				     struct ewah_bitmap **out)
+{
+	struct ewah_bitmap *old;
+	struct bitmap *remapped;
+
+	if (!old_bitmap || !mapping)
+		return 0;
+
+	old = pseudo_merge_bitmap_for_commit(old_bitmap, merge);
+	if (!old)
+		return 0;
+
+	remapped = bitmap_new();
+	if (rebuild_bitmap(mapping, old, remapped) < 0) {
+		bitmap_free(remapped);
+		return 0;
+	}
+
+	*out = bitmap_to_ewah(remapped);
+	bitmap_free(remapped);
+	reused_pseudo_merge_bitmaps_nr++;
+	return 1;
+}
+
+static int build_pseudo_merge_bitmap(struct bitmap_writer *writer,
+				     struct bitmap_index *old_bitmap,
+				     const uint32_t *mapping,
+				     struct commit *merge,
+				     struct ewah_bitmap **out)
+{
+	struct bb_commit ent = { 0 };
+	struct prio_queue queue = { NULL };
+	struct prio_queue tree_queue = { NULL };
+	unsigned parents = commit_list_count(merge->parents);
+	int ret;
+
+	ent.bitmap = bitmap_new();
+
+	pseudo_merge_bitmap_nr++;
+	pseudo_merge_bitmap_parents += parents;
+
+	if (reuse_pseudo_merge_bitmap(old_bitmap, mapping, merge, out)) {
+		ret = 0;
+		goto done;
+	}
+
+	ret = fill_bitmap_commit(writer, &ent, merge, &queue, &tree_queue,
+				 old_bitmap, mapping);
+
+	if (!ret)
+		*out = bitmap_to_ewah(ent.bitmap);
+
+done:
+	bitmap_free(ent.bitmap);
+	clear_prio_queue(&queue);
+	clear_prio_queue(&tree_queue);
+
+	return ret;
+}
+
+static int build_pseudo_merge_bitmaps(struct bitmap_writer *writer,
+				      struct bitmap_index *old_bitmap,
+				      const uint32_t *mapping,
+				      int *nr_stored)
+{
+	size_t i = bitmap_writer_nr_selected_commits(writer);
+	int ret = 0;
+
+	if (!writer->pseudo_merges_nr)
+		return 0;
+
+	trace2_region_enter("pack-bitmap-write", "building_pseudo_merge_bitmaps",
+			    writer->repo);
+
+	for (; i < writer->selected_nr; i++) {
+		struct bitmapped_commit *merge = &writer->selected[i];
+		struct commit_list *p;
+		struct bitmap *parents = bitmap_new();
+		struct ewah_bitmap *objects = NULL;
+
+		if (!merge->pseudo_merge)
+			BUG("found non-pseudo merge commit at %"PRIuMAX,
+			    (uintmax_t)i);
+
+		for (p = merge->commit->parents; p; p = p->next) {
+			int found;
+			uint32_t pos = find_object_pos(writer,
+						       &p->item->object.oid,
+						       &found);
+			if (!found) {
+				bitmap_free(parents);
+				ret = -1;
+				goto done;
+			}
+			bitmap_set(parents, pos);
+		}
+
+		merge->pseudo_merge_parents = bitmap_to_ewah(parents);
+		bitmap_free(parents);
+
+		if (build_pseudo_merge_bitmap(writer, old_bitmap, mapping,
+					      merge->commit, &objects) < 0) {
+			ret = -1;
+			goto done;
+		}
+		merge->bitmap = objects;
+
+		(*nr_stored)++;
+		display_progress(writer->progress, *nr_stored);
+	}
+
+done:
+	trace2_region_leave("pack-bitmap-write", "building_pseudo_merge_bitmaps",
+			    writer->repo);
+
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "pseudo_merge_bitmap_nr",
+			   pseudo_merge_bitmap_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "building_bitmaps_pseudo_merge_reused",
+			   reused_pseudo_merge_bitmaps_nr);
+	trace2_data_intmax("pack-bitmap-write", writer->repo,
+			   "pseudo_merge_bitmap_parents",
+			   pseudo_merge_bitmap_parents);
+
+	return ret;
+}
+
 static void store_selected(struct bitmap_writer *writer,
 			   struct bb_commit *ent, struct commit *commit)
 {
@@ -821,6 +976,10 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 			bitmap_free(ent->bitmap);
 		ent->bitmap = NULL;
 	}
+	if (closed &&
+	    build_pseudo_merge_bitmaps(writer, old_bitmap, mapping,
+				       &nr_stored) < 0)
+		closed = 0;
 	clear_prio_queue(&queue);
 	clear_prio_queue(&tree_queue);
 	bitmap_builder_clear(&bb);
@@ -831,9 +990,6 @@ int bitmap_writer_build(struct bitmap_writer *writer)
 			    writer->repo);
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "building_bitmaps_reused", reused_bitmaps_nr);
-	trace2_data_intmax("pack-bitmap-write", writer->repo,
-			   "building_bitmaps_pseudo_merge_reused",
-			   reused_pseudo_merge_bitmaps_nr);
 	trace2_data_intmax("pack-bitmap-write", writer->repo,
 			   "fill_bitmap_commit_calls_nr",
 			   fill_bitmap_commit_calls_nr);
@@ -1015,23 +1171,6 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 
 	CALLOC_ARRAY(pseudo_merge_ofs, writer->pseudo_merges_nr);
 
-	for (i = 0; i < writer->pseudo_merges_nr; i++) {
-		struct bitmapped_commit *merge = &writer->selected[base + i];
-		struct commit_list *p;
-		struct bitmap *parents = bitmap_new();
-
-		if (!merge->pseudo_merge)
-			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
-
-		for (p = merge->commit->parents; p; p = p->next)
-			bitmap_set(parents,
-				   find_object_pos(writer, &p->item->object.oid,
-						   NULL));
-
-		merge->pseudo_merge_parents = bitmap_to_ewah(parents);
-		bitmap_free(parents);
-	}
-
 	start = hashfile_total(f);
 
 	for (i = 0; i < writer->pseudo_merges_nr; i++) {
@@ -1040,14 +1179,13 @@ static void write_pseudo_merges(struct bitmap_writer *writer,
 		if (!merge->pseudo_merge)
 			BUG("found non-pseudo merge commit at %"PRIuMAX, (uintmax_t)i);
 
-		if (!merge->pseudo_merge_parents)
-			BUG("missing pseudo-merge parents bitmap for commit %s",
+		if (!merge->pseudo_merge_parents || !merge->bitmap)
+			BUG("missing pseudo-merge bitmap for commit %s",
 			    oid_to_hex(&merge->commit->object.oid));
 
 		pseudo_merge_ofs[i] = hashfile_total(f);
-
 		dump_bitmap(f, merge->pseudo_merge_parents);
-		dump_bitmap(f, writer->selected[base+i].write_as);
+		dump_bitmap(f, merge->bitmap);
 	}
 
 	next_ext = st_add(hashfile_total(f),
-- 
2.54.0.rc1.84.g30ce254312c
