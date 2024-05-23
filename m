Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF412A15B
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499637; cv=none; b=I4dkESr3WOcFlroYCIZT516fVtqJsdpUXewT+S8y+1I46gxjk6x7xH/z2rQXI0ZHjNvjhKLm7wJ4iJVCNCvdHoIuGpI0x5sSmv1ZzVg6Tekah3zC0fTmHfCe/FlV7iItsEKyF/Xv3fZ+m5Ye1GWqjMvK6l/XCYMmqjLvGDSZGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499637; c=relaxed/simple;
	bh=qRP+oiA27z+DEjRqdN+Sv9GPKU9FrIuYHQepEt2c+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOqvhMclw9QA2fkBcm2V3fbbjfyWHeg3kEkfjE9uWPb+BTf0DidmOCfiZqyPAPnkMVcjc35DBEA9P1Rt9XfVyQ2kMZOvD5coRmRYtgZBBniMoihh/nGg6melYZ6P+jXF7ok8g0ARPORjD3rilvOL3lQx1D9oJcwcWO6Jyp9gI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TB2TQK8T; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TB2TQK8T"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b277993a48so4628025eaf.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499634; x=1717104434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/eS8Z7Pn1NGmbGfaP8tH/BzgdAXCsaOVdg/lPmxIcsE=;
        b=TB2TQK8TwxRRjC2azlOZFFrumAwPujI1C6sjQ3ODojtaSiZwAmmX/ypAtq+rvIaO2Y
         /DitmY8JunvrtnJIrJAf/z2A8k/E96Nmk1w6r/j6mk24VUerws2LpTGVs/M8I6FPijKW
         rkh3gSP0s509FMVSN2VYuec+UQ+P32CSha4h0uOCMmqSoDrPMlMxsPO5uS4nfNU3QjFN
         rW5zhgqHNsB6Gz7MbOdHNEaTl8U+EYpgevmU67N5EeDoGo3jBcE8+RW/32yvYOrKFuEj
         6a+9mPg0MMLkl9uERdbpynVvIdswAxjPvv9HCk3aZlh3IYGdhgwJn1CHfMU8u7Um9Dn2
         eadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499634; x=1717104434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eS8Z7Pn1NGmbGfaP8tH/BzgdAXCsaOVdg/lPmxIcsE=;
        b=le0EVh4Hu2tD8yDZzPnMqAksJkqaxUBtA9DiecTmdp9zLjURlIG+1kvh7g0xhm/4SQ
         2N9WOVYJu9BHGPKjNJyoJ+WUroAPPqQiO3XeFAQWZDxBRzmfwRpCsmQfBAL8V+UqLSeZ
         vVtDZvgLcDTJ1bYixpfocm12QjTJhH02CDfGhMQWnh4nLe/7gPN+V2aCUAbvSDqGH34I
         Qh5JCVzt7JnYXE9RKhU4xVWMc5Ib3DbRFwgdzCvcMHEPKUMXacWsGAXZEEJROkeJWZrJ
         m4auOtmEvEoh/M+oAZYzW7KkuwhaRllKalP5tbRcraNtC/0wLziaQ9/Q+rVJn8+YjoIN
         8GFg==
X-Gm-Message-State: AOJu0YzyKQvQrjZOmQwfLLDRejCKsbZSy3JRG0XCYuqFXMT2IA7kT9uk
	SCNuutiMhoFA+HC3El8uvU0B0nMq4rbMjyB1WaCxoDoWTSdcgz7No2r+g+7UQgVpP+oUx/FR5tm
	A
X-Google-Smtp-Source: AGHT+IGqpoGCp0YSvD+EZTwD4bnXEWAts2oeCyxqBzTwXf9OK+T+um9IvuUU7OLniqZmx9URXT7kzA==
X-Received: by 2002:a05:6358:2825:b0:197:3d6f:cce3 with SMTP id e5c5f4694b2df-197e5101b84mr79757855d.13.1716499633487;
        Thu, 23 May 2024 14:27:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18c2af7sm525701cf.92.2024.05.23.14.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:13 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 20/24] pack-bitmap.c: use pseudo-merges during traversal
Message-ID: <cad38608aaec65e962d74c5398e46d7c47359f01.1716499565.git.me@ttaylorr.com>
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

Now that all of the groundwork has been laid to support reading and
using pseudo-merges, make use of that work in this commit by teaching
the pack-bitmap machinery to use pseudo-merge(s) when available during
traversal.

The basic operation is as follows:

  - When enumerating objects on either side of a reachability query,
    first see if any subset of the roots satisfies some pseudo-merge
    bitmap. If it does, apply that pseudo-merge bitmap.

  - If any pseudo-merge bitmap(s) were applied in the previous step, OR
    them into the result[^1]. Then repeat the process over all
    pseudo-merge bitmaps (we'll refer to this as "cascading"
    pseudo-merges). Once this is done, OR in the resulting bitmap.

  - If there is no fill-in traversal to be done, return the bitmap for
    that side of the reachability query. If there is fill-in traversal,
    then for each commit we encounter via show_commit(), check to see if
    any unsatisfied pseudo-merges containing that commit as one of its
    parents has been made satisfied by the presence of that commit.

    If so, OR in the object set from that pseudo-merge bitmap, and then
    cascade. If not, continue traversal.

A similar implementation is present in the boundary-based bitmap
traversal routines.

[^1]: Importantly, we cannot OR in the entire set of roots along with
  the objects reachable from whatever pseudo-merge bitmaps were
  satisfied.  This may leave some dangling bits corresponding to any
  unsatisfied root(s) getting OR'd into the resulting bitmap, tricking
  other parts of the traversal into thinking we already have a
  reachability closure over those commit(s) when we do not.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c                   | 112 ++++++++++-
 t/t5333-pseudo-merge-bitmaps.sh | 328 ++++++++++++++++++++++++++++++++
 2 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100755 t/t5333-pseudo-merge-bitmaps.sh

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c13074673af..e61058dada6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -114,6 +114,9 @@ struct bitmap_index {
 	unsigned int version;
 };
 
+static int pseudo_merges_satisfied_nr;
+static int pseudo_merges_cascades_nr;
+
 static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap *st)
 {
 	struct ewah_bitmap *parent;
@@ -1006,6 +1009,22 @@ static void show_commit(struct commit *commit UNUSED,
 {
 }
 
+static unsigned apply_pseudo_merges_for_commit_1(struct bitmap_index *bitmap_git,
+						 struct bitmap *result,
+						 struct commit *commit,
+						 uint32_t commit_pos)
+{
+	int ret;
+
+	ret = apply_pseudo_merges_for_commit(&bitmap_git->pseudo_merges,
+					     result, commit, commit_pos);
+
+	if (ret)
+		pseudo_merges_satisfied_nr += ret;
+
+	return ret;
+}
+
 static int add_to_include_set(struct bitmap_index *bitmap_git,
 			      struct include_data *data,
 			      struct commit *commit,
@@ -1026,6 +1045,10 @@ static int add_to_include_set(struct bitmap_index *bitmap_git,
 	}
 
 	bitmap_set(data->base, bitmap_pos);
+	if (apply_pseudo_merges_for_commit_1(bitmap_git, data->base, commit,
+					     bitmap_pos))
+		return 0;
+
 	return 1;
 }
 
@@ -1151,6 +1174,20 @@ static void show_boundary_object(struct object *object UNUSED,
 	BUG("should not be called");
 }
 
+static unsigned cascade_pseudo_merges_1(struct bitmap_index *bitmap_git,
+					struct bitmap *result,
+					struct bitmap *roots)
+{
+	int ret = cascade_pseudo_merges(&bitmap_git->pseudo_merges,
+					result, roots);
+	if (ret) {
+		pseudo_merges_cascades_nr++;
+		pseudo_merges_satisfied_nr += ret;
+	}
+
+	return ret;
+}
+
 static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 					    struct rev_info *revs,
 					    struct object_list *roots)
@@ -1160,6 +1197,7 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	unsigned int i;
 	unsigned int tmp_blobs, tmp_trees, tmp_tags;
 	int any_missing = 0;
+	int existing_bitmaps = 0;
 
 	cb.bitmap_git = bitmap_git;
 	cb.base = bitmap_new();
@@ -1167,6 +1205,25 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 
 	revs->ignore_missing_links = 1;
 
+	if (bitmap_git->pseudo_merges.nr) {
+		struct bitmap *roots_bitmap = bitmap_new();
+		struct object_list *objects = NULL;
+
+		for (objects = roots; objects; objects = objects->next) {
+			struct object *object = objects->item;
+			int pos;
+
+			pos = bitmap_position(bitmap_git, &object->oid);
+			if (pos < 0)
+				continue;
+
+			bitmap_set(roots_bitmap, pos);
+		}
+
+		if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
+			bitmap_free(roots_bitmap);
+	}
+
 	/*
 	 * OR in any existing reachability bitmaps among `roots` into
 	 * `cb.base`.
@@ -1178,8 +1235,10 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 			continue;
 
 		if (add_commit_to_bitmap(bitmap_git, &cb.base,
-					 (struct commit *)object))
+					 (struct commit *)object)) {
+			existing_bitmaps = 1;
 			continue;
+		}
 
 		any_missing = 1;
 	}
@@ -1187,6 +1246,9 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	if (!any_missing)
 		goto cleanup;
 
+	if (existing_bitmaps)
+		cascade_pseudo_merges_1(bitmap_git, cb.base, NULL);
+
 	tmp_blobs = revs->blob_objects;
 	tmp_trees = revs->tree_objects;
 	tmp_tags = revs->blob_objects;
@@ -1242,6 +1304,13 @@ static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
 	return cb.base;
 }
 
+static void unsatisfy_all_pseudo_merges(struct bitmap_index *bitmap_git)
+{
+	uint32_t i;
+	for (i = 0; i < bitmap_git->pseudo_merges.nr; i++)
+		bitmap_git->pseudo_merges.v[i].satisfied = 0;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -1249,9 +1318,32 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 {
 	struct bitmap *base = NULL;
 	int needs_walk = 0;
+	unsigned existing_bitmaps = 0;
 
 	struct object_list *not_mapped = NULL;
 
+	unsatisfy_all_pseudo_merges(bitmap_git);
+
+	if (bitmap_git->pseudo_merges.nr) {
+		struct bitmap *roots_bitmap = bitmap_new();
+		struct object_list *objects = NULL;
+
+		for (objects = roots; objects; objects = objects->next) {
+			struct object *object = objects->item;
+			int pos;
+
+			pos = bitmap_position(bitmap_git, &object->oid);
+			if (pos < 0)
+				continue;
+
+			bitmap_set(roots_bitmap, pos);
+		}
+
+		base = bitmap_new();
+		if (!cascade_pseudo_merges_1(bitmap_git, base, roots_bitmap))
+			bitmap_free(roots_bitmap);
+	}
+
 	/*
 	 * Go through all the roots for the walk. The ones that have bitmaps
 	 * on the bitmap index will be `or`ed together to form an initial
@@ -1262,11 +1354,21 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 	 */
 	while (roots) {
 		struct object *object = roots->item;
+
 		roots = roots->next;
 
+		if (base) {
+			int pos = bitmap_position(bitmap_git, &object->oid);
+			if (pos > 0 && bitmap_get(base, pos)) {
+				object->flags |= SEEN;
+				continue;
+			}
+		}
+
 		if (object->type == OBJ_COMMIT &&
 		    add_commit_to_bitmap(bitmap_git, &base, (struct commit *)object)) {
 			object->flags |= SEEN;
+			existing_bitmaps = 1;
 			continue;
 		}
 
@@ -1282,6 +1384,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 
 	roots = not_mapped;
 
+	if (existing_bitmaps)
+		cascade_pseudo_merges_1(bitmap_git, base, NULL);
+
 	/*
 	 * Let's iterate through all the roots that don't have bitmaps to
 	 * check if we can determine them to be reachable from the existing
@@ -1866,6 +1971,11 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
 	object_list_free(&wants);
 	object_list_free(&haves);
 
+	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_satisfied",
+			   pseudo_merges_satisfied_nr);
+	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_cascades",
+			   pseudo_merges_cascades_nr);
+
 	return bitmap_git;
 
 cleanup:
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
new file mode 100755
index 00000000000..4c9aebcffdc
--- /dev/null
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -0,0 +1,328 @@
+#!/bin/sh
+
+test_description='pseudo-merge bitmaps'
+
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
+. ./test-lib.sh
+
+test_pseudo_merges () {
+	test-tool bitmap dump-pseudo-merges
+}
+
+test_pseudo_merge_commits () {
+	test-tool bitmap dump-pseudo-merge-commits "$1"
+}
+
+test_pseudo_merges_satisfied () {
+	test_trace2_data bitmap pseudo_merges_satisfied "$1"
+}
+
+test_pseudo_merges_cascades () {
+	test_trace2_data bitmap pseudo_merges_cascades "$1"
+}
+
+tag_everything () {
+	git rev-list --all --no-object-names >in &&
+	perl -lne '
+		print "create refs/tags/" . $. . " " . $1 if /([0-9a-f]+)/
+	' <in | git update-ref --stdin
+}
+
+test_expect_success 'setup' '
+	test_commit_bulk 512 &&
+	tag_everything
+'
+
+test_expect_success 'bitmap traversal without pseudo-merges' '
+	git repack -adb &&
+
+	git rev-list --count --all --objects >expect &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT=$PWD/trace2.txt \
+		git rev-list --count --all --objects --use-bitmap-index >actual &&
+
+	test_pseudo_merges_satisfied 0 <trace2.txt &&
+	test_pseudo_merges_cascades 0 <trace2.txt &&
+	test_pseudo_merges >merges &&
+	test_must_be_empty merges &&
+	test_cmp expect actual
+'
+
+test_expect_success 'pseudo-merges accurately represent their objects' '
+	test_config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+	test_config bitmapPseudoMerge.test.maxMerges 8 &&
+	test_config bitmapPseudoMerge.test.stableThreshold never &&
+
+	git repack -adb &&
+
+	test_pseudo_merges >merges &&
+	test_line_count = 8 merges &&
+
+	for i in $(test_seq 0 $(($(wc -l <merges)-1)))
+	do
+		test-tool bitmap dump-pseudo-merge-commits $i >commits &&
+
+		git rev-list --objects --no-object-names --stdin <commits >expect.raw &&
+		test-tool bitmap dump-pseudo-merge-objects $i >actual.raw &&
+
+		sort -u <expect.raw >expect &&
+		sort -u <actual.raw >actual &&
+
+		test_cmp expect actual || return 1
+	done
+'
+
+test_expect_success 'bitmap traversal with pseudo-merges' '
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT=$PWD/trace2.txt \
+		git rev-list --count --all --objects --use-bitmap-index >actual &&
+	git rev-list --count --all --objects >expect &&
+
+	test_pseudo_merges_satisfied 8 <trace2.txt &&
+	test_pseudo_merges_cascades 1 <trace2.txt &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stale bitmap traversal with pseudo-merges' '
+	test_commit other &&
+
+	: >trace2.txt &&
+	GIT_TRACE2_EVENT=$PWD/trace2.txt \
+		git rev-list --count --all --objects --use-bitmap-index >actual &&
+	git rev-list --count --all --objects >expect &&
+
+	test_pseudo_merges_satisfied 8 <trace2.txt &&
+	test_pseudo_merges_cascades 1 <trace2.txt &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
+	test_config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+	test_config bitmapPseudoMerge.test.maxMerges 1 &&
+	test_config bitmapPseudoMerge.test.stableThreshold never &&
+
+	commits_nr=$(git rev-list --all --count) &&
+
+	for rate in 1.0 0.5 0.25
+	do
+		git -c bitmapPseudoMerge.test.sampleRate=$rate repack -adb &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges &&
+		test_pseudo_merge_commits 0 >commits &&
+
+		test-tool bitmap list-commits >bitmaps &&
+		bitmaps_nr="$(wc -l <bitmaps)" &&
+
+		perl -MPOSIX -e "print ceil(\$ARGV[0]*(\$ARGV[1]-\$ARGV[2]))" \
+			"$rate" "$commits_nr" "$bitmaps_nr" >expect &&
+
+		test $(cat expect) -eq $(wc -l <commits) || return 1
+	done
+'
+
+test_expect_success 'bitmapPseudoMerge.threshold excludes newer commits' '
+	git init pseudo-merge-threshold &&
+	(
+		cd pseudo-merge-threshold &&
+
+		new="1672549200" && # 2023-01-01
+		old="1641013200" && # 2022-01-01
+
+		GIT_COMMITTER_DATE="$new +0000" &&
+		export GIT_COMMITTER_DATE &&
+		test_commit_bulk --message="new" --notick 128 &&
+
+		GIT_COMMITTER_DATE="$old +0000" &&
+		export GIT_COMMITTER_DATE &&
+		test_commit_bulk --message="old" --notick 128 &&
+
+		tag_everything &&
+
+		git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=1 \
+			-c bitmapPseudoMerge.test.threshold=$(($new - 1)) \
+			-c bitmapPseudoMerge.test.stableThreshold=never \
+			repack -adb &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges &&
+
+		test_pseudo_merge_commits 0 >oids &&
+		git cat-file --batch <oids >commits &&
+
+		test $(wc -l <oids) = $(grep -c "^committer.*$old +0000$" commits)
+	)
+'
+
+test_expect_success 'bitmapPseudoMerge.stableThreshold creates stable groups' '
+	(
+		cd pseudo-merge-threshold &&
+
+		new="1672549200" && # 2023-01-01
+		mid="1654059600" && # 2022-06-01
+		old="1641013200" && # 2022-01-01
+
+		GIT_COMMITTER_DATE="$mid +0000" &&
+		export GIT_COMMITTER_DATE &&
+		test_commit_bulk --message="mid" --notick 128 &&
+
+		git for-each-ref --format="delete %(refname)" refs/tags >in &&
+		git update-ref --stdin <in &&
+
+		tag_everything &&
+
+		git \
+			-c bitmapPseudoMerge.test.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.test.maxMerges=1 \
+			-c bitmapPseudoMerge.test.threshold=$(($new - 1)) \
+			-c bitmapPseudoMerge.test.stableThreshold=$(($mid - 1)) \
+			-c bitmapPseudoMerge.test.stableSize=10 \
+			repack -adb &&
+
+		test_pseudo_merges >merges &&
+		merges_nr="$(wc -l <merges)" &&
+
+		for i in $(test_seq $(($merges_nr - 1)))
+		do
+			test_pseudo_merge_commits 0 >oids &&
+			git cat-file --batch <oids >commits &&
+
+			expect="$(grep -c "^committer.*$old +0000$" commits)" &&
+			actual="$(wc -l <oids)" &&
+
+			test $expect = $actual || return 1
+		done &&
+
+		test_pseudo_merge_commits $(($merges_nr - 1)) >oids &&
+		git cat-file --batch <oids >commits &&
+		test $(wc -l <oids) = $(grep -c "^committer.*$mid +0000$" commits)
+	)
+'
+
+test_expect_success 'out of order thresholds are rejected' '
+	test_must_fail git \
+		-c bitmapPseudoMerge.test.pattern="refs/*" \
+		-c bitmapPseudoMerge.test.threshold=1.month.ago \
+		-c bitmapPseudoMerge.test.stableThreshold=1.week.ago \
+		repack -adb 2>err &&
+
+	cat >expect <<-EOF &&
+	fatal: pseudo-merge group ${SQ}test${SQ} has unstable threshold before stable one
+	EOF
+
+	test_cmp expect err
+'
+
+test_expect_success 'pseudo-merge pattern with capture groups' '
+	git init pseudo-merge-captures &&
+	(
+		cd pseudo-merge-captures &&
+
+		test_commit_bulk 128 &&
+		tag_everything &&
+
+		for r in $(test_seq 8)
+		do
+			test_commit_bulk 16 &&
+
+			git rev-list HEAD~16.. >in &&
+
+			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
+			git update-ref --stdin || return 1
+		done &&
+
+		git \
+			-c bitmapPseudoMerge.tags.pattern="refs/remotes/([0-9]+)/tags/" \
+			-c bitmapPseudoMerge.tags.maxMerges=1 \
+			repack -adb &&
+
+		git for-each-ref --format="%(objectname) %(refname)" >refs &&
+
+		test_pseudo_merges >merges &&
+		for m in $(test_seq 0 $(($(wc -l <merges) - 1)))
+		do
+			test_pseudo_merge_commits $m >oids &&
+			grep -f oids refs |
+			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
+			sort -u || return 1
+		done >remotes &&
+
+		test $(wc -l <remotes) -eq $(sort -u <remotes | wc -l)
+	)
+'
+
+test_expect_success 'pseudo-merge overlap setup' '
+	git init pseudo-merge-overlap &&
+	(
+		cd pseudo-merge-overlap &&
+
+		test_commit_bulk 256 &&
+		tag_everything &&
+
+		git \
+			-c bitmapPseudoMerge.all.pattern="refs/" \
+			-c bitmapPseudoMerge.all.maxMerges=1 \
+			-c bitmapPseudoMerge.all.stableThreshold=never \
+			-c bitmapPseudoMerge.tags.pattern="refs/tags/" \
+			-c bitmapPseudoMerge.tags.maxMerges=1 \
+			-c bitmapPseudoMerge.tags.stableThreshold=never \
+			repack -adb
+	)
+'
+
+test_expect_success 'pseudo-merge overlap generates overlapping groups' '
+	(
+		cd pseudo-merge-overlap &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_pseudo_merge_commits 0 >commits-0.raw &&
+		test_pseudo_merge_commits 1 >commits-1.raw &&
+
+		sort commits-0.raw >commits-0 &&
+		sort commits-1.raw >commits-1 &&
+
+		comm -12 commits-0 commits-1 >overlap &&
+
+		test_line_count -gt 0 overlap
+	)
+'
+
+test_expect_success 'pseudo-merge overlap traversal' '
+	(
+		cd pseudo-merge-overlap &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --all --objects --use-bitmap-index >actual &&
+		git rev-list --count --all --objects >expect &&
+
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+		test_pseudo_merges_cascades 1 <trace2.txt &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'pseudo-merge overlap stale traversal' '
+	(
+		cd pseudo-merge-overlap &&
+
+		test_commit other &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --all --objects --use-bitmap-index >actual &&
+		git rev-list --count --all --objects >expect &&
+
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+		test_pseudo_merges_cascades 1 <trace2.txt &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.45.1.175.gcf0316ad0e9

