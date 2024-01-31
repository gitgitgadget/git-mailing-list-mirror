Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7933A8D8
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741548; cv=none; b=jLFCd7sMeW1fbHNTxzn/QXLA8KaHiGCcj9EnM2j9VUI3bXzLpMBCul3lRP1dytMxCfRmBUxakLWy67TOTlWswR/jCcYbzIuvcj/KHNUkWVRf1e/jv7gOmCrGdwlepSMgUET1SkCVUqcnjYjuzVMdSVw9FGdphrGB/KR2RC3NFQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741548; c=relaxed/simple;
	bh=pUd/X8NFfCFpEiWOyQIbhiv2bPzxlaFqxa3ThbssICg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyobfsjZjhtlkmOSp72MVhnhXIVLT3Q11hlQHsNJIt76YYX31Bz4BX2Ckqs3gBJVD1wBDvdBZvaBxBel2wMzufg7xvVnIuXBrZAMgNk/bXeZ/2dKGTNnstMONUHMnD24skc2iAPtbEWwXpVUW6ZCpEcFjA/40zpNGJMYEYUTuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZKlgRm/t; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZKlgRm/t"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783e22a16d4so104942885a.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1706741544; x=1707346344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9BniYaMPwayL90qzNYpZNYvso3bcVW7OgFrLipKNQrk=;
        b=ZKlgRm/t7+OhIFmbTK/fxIzHnnSmQ/ntArgtrDmtHGS5Dmr3toNPbM42UQ96mMhh+i
         4o4mGiNxwjCzE650N/wmdap3COBvTwJyH6f863XhPfs5Wdic5Dzd7gqTCPbnIWpYlNBv
         7DYkgZrGAZahgGoTtEZI12wjpQWtvXV2Q/THobqkBd6mcciiAfHl1HJ9nsvhWFvPypYm
         dZ9ro+m83+FPymdX8gjUbJbwlEXfu2aGEWimMyCFwugPVUqRi9ljNuMZErD6AgrvFAom
         D4OWDtntGy0LReaIdw90m/MGU68RvmfmE7LF3+Yu4OL3bSgWEtFOO369YWZe3VcxvVwn
         qOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706741544; x=1707346344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BniYaMPwayL90qzNYpZNYvso3bcVW7OgFrLipKNQrk=;
        b=XfzDb6ymTGCakeKko0Z6uxJbmwgbQzo2ZGA7zRSPEUxTETnKY8jUOQDWeNIJWDFwNG
         AWo8wy6LVFYk8YJxw/Y+i0q2BGT0Z5zafCiUrRdkqPfCE1RLAedCT/iysclsd15/8cKD
         9P6F9QiAeIV1+xo5Al76Q0cFHWnBg8zmt2k6MFK2WAGZB8owH7WWFuNA2XETz5ajibWF
         XRFwkaY4Htgut8SOkTVSeeJpJ+kId0ajWX6zFY/0RDTjlepimlZWkfoby4Fwg2KJnqHk
         k+TMMfh5Kh6sQXUw/66c3oL6ECe6Gmns4t7dtgLyRBHEBggDoSPUBadOFvjGu2LZNlRe
         W2gA==
X-Gm-Message-State: AOJu0Yy9FOCSCzs71x7bo240w/4kq+i2FtnIa2Jw/pKQPRkF5/7nW7cf
	KXiCMt89X3EyCixKRRSWAdBD0d8jjiIOmj0zF52DtCsH1BrRnaJa2C1oqBQd7TnLshJWp74e35h
	cuYw=
X-Google-Smtp-Source: AGHT+IFMl6yY88LUuPCOhvRd1MVm/inobZtgkncSMLrV53II/ySJ6SGfwnwaXQVX4f9CWcU364MWew==
X-Received: by 2002:a0c:f10c:0:b0:68c:4475:2f2a with SMTP id i12-20020a0cf10c000000b0068c44752f2amr7047856qvl.18.1706741544646;
        Wed, 31 Jan 2024 14:52:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id eo10-20020ad4594a000000b0068179afede6sm3150343qvb.100.2024.01.31.14.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:52:24 -0800 (PST)
Date: Wed, 31 Jan 2024 17:52:23 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v6 02/16] revision.c: consult Bloom filters for root commits
Message-ID: <a6dc377f1b46d4afd442023426fc8dd5cd8ceb8e.1706741516.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1706741516.git.me@ttaylorr.com>

The commit-graph stores changed-path Bloom filters which represent the
set of paths included in a tree-level diff between a commit's root tree
and that of its parent.

When a commit has no parents, the tree-diff is computed against that
commit's root tree and the empty tree. In other words, every path in
that commit's tree is stored in the Bloom filter (since they all appear
in the diff).

Consult these filters during pathspec-limited traversals in the function
`rev_same_tree_as_empty()`. Doing so yields a performance improvement
where we can avoid enumerating the full set of paths in a parentless
commit's root tree when we know that the path(s) of interest were not
listed in that commit's changed-path Bloom filter.

Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
Original-patch-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 revision.c           | 26 ++++++++++++++++++++++----
 t/t4216-log-bloom.sh |  8 ++++++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..0e6f7d02b6 100644
--- a/revision.c
+++ b/revision.c
@@ -833,17 +833,28 @@ static int rev_compare_tree(struct rev_info *revs,
 	return tree_difference;
 }
 
-static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
+static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit,
+				  int nth_parent)
 {
 	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
+	int bloom_ret = -1;
 
 	if (!t1)
 		return 0;
 
+	if (!nth_parent && revs->bloom_keys_nr) {
+		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
+		if (!bloom_ret)
+			return 1;
+	}
+
 	tree_difference = REV_TREE_SAME;
 	revs->pruning.flags.has_changes = 0;
 	diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
+	if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+		count_bloom_filter_false_positive++;
+
 	return tree_difference == REV_TREE_SAME;
 }
 
@@ -881,7 +892,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, nth_parent))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -977,7 +988,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		return;
 
 	if (!commit->parents) {
-		if (rev_same_tree_as_empty(revs, commit))
+		/*
+		 * Pretend as if we are comparing ourselves to the
+		 * (non-existent) first parent of this commit object. Even
+		 * though no such parent exists, its changed-path Bloom filter
+		 * (if one exists) is relative to the empty tree, using Bloom
+		 * filters is allowed here.
+		 */
+		if (rev_same_tree_as_empty(revs, commit, 0))
 			commit->object.flags |= TREESAME;
 		return;
 	}
@@ -1058,7 +1076,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
 		case REV_TREE_NEW:
 			if (revs->remove_empty_trees &&
-			    rev_same_tree_as_empty(revs, p)) {
+			    rev_same_tree_as_empty(revs, p, nth_parent)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
 				 * history beyond this parent is not
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index b7baf49d62..cc6ebc8140 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -88,7 +88,11 @@ test_bloom_filters_not_used () {
 		# if the Bloom filter system is initialized, ensure that no
 		# filters were used
 		data="statistics:{"
-		data="$data\"filter_not_present\":0,"
+		# unusable filters (e.g., those computed with a
+		# different value of commitGraph.changedPathsVersion)
+		# are counted in the filter_not_present bucket, so any
+		# value is OK there.
+		data="$data\"filter_not_present\":[0-9][0-9]*,"
 		data="$data\"maybe\":0,"
 		data="$data\"definitely_not\":0,"
 		data="$data\"false_positive\":0}"
@@ -175,7 +179,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
 
 test_bloom_filters_used_when_some_filters_are_missing () {
 	log_args=$1
-	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":9"
+	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"maybe\":6,\"definitely_not\":10"
 	setup "$log_args" &&
 	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
 	test_cmp log_wo_bloom log_w_bloom
-- 
2.43.0.509.g253f65a7fc

