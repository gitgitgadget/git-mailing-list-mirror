Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35181135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337157; cv=none; b=hAt4r8Mlke6tmq0T367n3PJoFfO5KRUOdEjVfxHiW+GXkhc5N84Tlr1Gdte1p8l2AnJev7LEPv19bhkpsXITIp9bgUtXfc/ihpRSOhQil1LeemUUXuDD7g6OfGHDWNUV14pmuRcfJbtzL4MJvOCSPJcOPoH65CUtPoHn0sH5urQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337157; c=relaxed/simple;
	bh=51xxuzSI6iNBiOCdKklaUwfqcZlbSz/gtBX100hO2+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCg+RF+hUs9j9u3UonEcAr3TXefI1sywXGgaTWUlXC8h11maSjx7wIcz8ahm58WMVf6si9tDOiv3iEKMzes/1YnkIqCpJTM6TOzZ1stTDT+Tnxfvrc6uHK/8HXX9xgg8h/0yOSODb+8L1d0LX9CG00CHPbnXc/WL/XMXjRx1i8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ArPDaUkd; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ArPDaUkd"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79c0c19ff02so56719785a.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1719337155; x=1719941955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDerfUd+xKFIMVjj49xx4Y05lookJawgsr/D4wJCfCw=;
        b=ArPDaUkdxl4uNFORMysqW1phFqsRVtFxODe+ZbsiUfiEj3qZt0Q/AUGCJwpgB4A4Cb
         xus5eKLiivZaBZyB0PlKH68SxXXD+Yr3k0XwMMGQjC4vN4uA4H5TL9b1IQ9Mi3Q3czqP
         jZTMSCotZu4krb5zAU4JWMYiBDgOyongkIhUuUu6BFIZ9RsE5kueeJKnubXycjqvmOQ5
         UNT0GQfPN2HRp9ja76j1z8wMstDd41f2lai2Vbapxq+biikhK9xBQS7Ygn3xKmhiR3zL
         fuag815H78Pag0/E+U8c+v+DdEaJy/SIpxzydWBVq/k6+VvnUvSJOkb+1af5Yd9SCjPb
         M33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337155; x=1719941955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDerfUd+xKFIMVjj49xx4Y05lookJawgsr/D4wJCfCw=;
        b=fmR8nXvbp1b02RgcMVRWF1wf8I4cy/AanPmopTOw/DCjhEdsjIXiitBFauPfYGIXwN
         w1yX5KL+m/tK+4A5jNAr3BL9/JlgwrdKd3IIb3saFrlipvtZ9fkybhRi5rXHcMcTi0LS
         IayC1yJxeNeeQCbtyDVQh7pGXys89DOrQNYyv2xVjEfESH0k79/t2/cZaCvyyzwN2gfC
         hlTfSjvbvoRiMVi88ReoAyVdgXkZ5oOaZOX3Q7SS7TXGDHcRidVsSIDYnzj4hjzawaBS
         1esMdd4A7Ll2Lw7BDtwXRQ7nRn88AR1HsxLNKvmS/lr05MiaA6pNxXTD369L5wNr1rNy
         +wTA==
X-Gm-Message-State: AOJu0YzYZ1pFUrPrJypQbwIRNSK/QdhcC00TAL5Nqv3mAAjDhdeUXtkK
	Qbc3yGLN6kn7MsxFE+duFycylENcuKyqeTxfj61AIpjw6bDZfFdIzKeCfAkXm6xSyCZVLN9maeu
	8pQY=
X-Google-Smtp-Source: AGHT+IHgWdO2yhnRFvlSOzpnN1nJZRPmSJeyy4XMpXzxLect8FNToBR7dVljEZvvZyn2zPSg1aP/wA==
X-Received: by 2002:a05:620a:4591:b0:795:4836:33b with SMTP id af79cd13be357-79be6e6e324mr979086085a.35.1719337154753;
        Tue, 25 Jun 2024 10:39:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c04daf1d6sm73616985a.98.2024.06.25.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 10:39:14 -0700 (PDT)
Date: Tue, 25 Jun 2024 13:39:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v7 02/16] revision.c: consult Bloom filters for root commits
Message-ID: <5d88ad6c905c040322f360884b756ece83eefa66.1719333276.git.me@ttaylorr.com>
References: <cover.1706741516.git.me@ttaylorr.com>
 <cover.1719333276.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719333276.git.me@ttaylorr.com>

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
index c68deb57ce..6931665b95 100644
--- a/revision.c
+++ b/revision.c
@@ -845,17 +845,28 @@ static int rev_compare_tree(struct rev_info *revs,
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
 
@@ -893,7 +904,7 @@ static int compact_treesame(struct rev_info *revs, struct commit *commit, unsign
 		if (nth_parent != 0)
 			die("compact_treesame %u", nth_parent);
 		old_same = !!(commit->object.flags & TREESAME);
-		if (rev_same_tree_as_empty(revs, commit))
+		if (rev_same_tree_as_empty(revs, commit, nth_parent))
 			commit->object.flags |= TREESAME;
 		else
 			commit->object.flags &= ~TREESAME;
@@ -989,7 +1000,14 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
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
@@ -1070,7 +1088,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 
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
2.45.2.664.g446e6a2b1f

