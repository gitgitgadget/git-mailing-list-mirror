Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501625B30D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856178; cv=none; b=idsU009TcWpSKDnD+FIdNNbGW0/33SaS799xsibcz2TlMZbfKRtoVTmqvL9jL5Fc9LDABueOQxR0XVdRDed9trlle1LhTYJ6Fri6hjt9jVia6tcofBGBeN6h7HLKIWMLNc+zc3tby890gZiNJ5TV9ct3G1953fhUS7dFldxvOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856178; c=relaxed/simple;
	bh=r9D3PPnm9ialKxM/++crUcvEUX4Zoa0uGTkCLU/osq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeFMb3HRxL0KbpfR6UovplCG48ysBnvf2GPoTXZ/V8W3Yw2P1DUTZ1NieScV+8xrMQllFcnIkCjsV6snJsmHsAeeoJUZvboGChDFpIdy9rGg25b/rjLzPlsg+o/jYIgvWAy0nSuNRvC7msEvIN6owEbPQoH1iLj67W4ws7TLR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPq+6H+U; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPq+6H+U"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-23633a6ac50so24566405ad.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 05:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750856176; x=1751460976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rZs7iMWGTxSeIpAu3W9QRcc30eJCNNJlsUKg8axCRw=;
        b=lPq+6H+UBPZL7+qx2e3yBeqWNOXbbLtDJ4a+Vkx4IWfNLqaSTa82J78LQRAL0TmhIN
         rhpK/JiiDuP9LReHfYBP2+UkTDndFsjMvTyCnAUICZIDedmXm/KjtSYEoWa4XHfceTXv
         mYiiACI+8/0rlfwKZS6jYuWSnrQ76uztqOQ5VWNQ7oF0yN16Te0cUHmIWw9CefpRDGUQ
         b5Qc7aXBCFUtbezviTUiTIQJDJk317BV6gx5WgwSA0C6OZM/6SKuuz/5OT4wuv3kqRsA
         YLWvKAOxPAhWzKxVrHJUClG3rduUIiaUdQpRFUHbjmRrWlAzMWG8bLCKPsmt2GIwZ4+U
         4Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856176; x=1751460976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rZs7iMWGTxSeIpAu3W9QRcc30eJCNNJlsUKg8axCRw=;
        b=WCmjz/as3UQDn75k3gLH9TsMrzkJ3kpfLfeeAOYvlsXW78IqWjDUiNTAIldAY9NVc5
         SY5nkPdra0yV/xZf6dZUTOruG4elUmqXfSr8zIAPBHQ4LuwI/m3ZvARBHCgGn6+aojpe
         uTA94taUe7F0jtRKINaGQmcOcyQXOBxlT9Nb7J2RcnY4aXxmcjKOpWv1yjVtyHpoNYtH
         lvgJRf0Std5SU5M3FfpU2ZeYF32grkvGJzjDOM58vSUX/OjD3x/vNmu6IJmFMyvKDv1Z
         UJZE2DEWYsICrpJK3RnrFatE0HQE3CUX3HJCijmWkJUd9O9dAlp5GttRxrB2MS9yQ0To
         t4XQ==
X-Gm-Message-State: AOJu0YyJxGtmbBF9qipinwh8XaG5zOeaFsS30T6bNskXgdaBFyLn3Dzl
	vWxZdCO7ESYn6SGMZx+iCpnLFUFki3I4MdZe0nvnPfOsxsSF0UsiLRJwfxZ1BwmmYn8=
X-Gm-Gg: ASbGnctC6+/x7HjK10/wpQfjhNRt1mJal5ndpS3rx7YbkGfveAOPTHQlCUDR3AJtv6e
	csm6m9Op1Xse/piDZii2Fm/zwEW1n0vUw50nhehGidYv1XmoXncG61WGRTx/6D8KmVEWCPx00sJ
	HGvzw+Ek7HgdMV0xQSN/5WLBVGL2PHXfkbikRdrR6yvP4rWGzJ6HhcenYGzwu4xoEBXfDv+ZI1K
	0jxF3t+9ojCpYnB1HIotKxWlJqAdNSSdh5jjK8TOmInJ4QdvdY26K6wb8zqvs/wuTvk8Oe/O1hk
	AloRqukpGayxpLmT5IGPpXnIv8QDlWVV56B0kGK/voBLnVf8amildw0gXn9ivB8IETML
X-Google-Smtp-Source: AGHT+IFaxpLhmf+Jwqz+HdyXbeKqvOIuw/2Gb/j8Bmb2VMsOVJBFyf6Wo8tlqNIv8oRzRHVTWJiwzw==
X-Received: by 2002:a17:902:ea0e:b0:234:a139:1217 with SMTP id d9443c01a7336-23823fcf9c4mr43549575ad.18.1750856175531;
        Wed, 25 Jun 2025 05:56:15 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8391494sm136312145ad.1.2025.06.25.05.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:56:15 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
Date: Wed, 25 Jun 2025 20:55:41 +0800
Message-ID: <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `if (spec->nr > 1)` to enable bloom filter given multiple
pathspec. Wrapped for loop around code in prepare_to_use_bloom_filter()
to initialize each pathspec's struct bloom_keyvec. Add for loop
in check_maybe_different_in_bloom_filter() to find if at least one
pathspec's bloom_keyvec is contained in bloom filter.

Add new function release_revisions_bloom_keyvecs() to free all bloom
keyvec owned by rev_info.

Modify t/t4216 to test if bloom filter is still used given multiple
pathspec.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 revision.c           | 122 ++++++++++++++++++++++++-------------------
 t/t4216-log-bloom.sh |  10 ++--
 2 files changed, 73 insertions(+), 59 deletions(-)

diff --git a/revision.c b/revision.c
index cf7dc3b3fa..8818f017f3 100644
--- a/revision.c
+++ b/revision.c
@@ -675,8 +675,6 @@ static int forbid_bloom_filters(struct pathspec *spec)
 {
 	if (spec->has_wildcard)
 		return 1;
-	if (spec->nr > 1)
-		return 1;
 	if (spec->magic & ~PATHSPEC_LITERAL)
 		return 1;
 	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
@@ -685,6 +683,8 @@ static int forbid_bloom_filters(struct pathspec *spec)
 	return 0;
 }
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -692,7 +692,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	char *path_alloc = NULL;
 	const char *path, *p;
 	size_t len;
-	int path_component_nr = 1;
+	int path_component_nr;
 
 	if (!revs->commits)
 		return;
@@ -709,51 +709,53 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	if (!revs->pruning.pathspec.nr)
 		return;
 
-	pi = &revs->pruning.pathspec.items[0];
-
-	/* remove single trailing slash from path, if needed */
-	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
-		path_alloc = xmemdupz(pi->match, pi->len - 1);
-		path = path_alloc;
-	} else
-		path = pi->match;
-
-	len = strlen(path);
-	if (!len) {
-		revs->bloom_filter_settings = NULL;
-		free(path_alloc);
-		return;
-	}
-
-	p = path;
-	while (*p) {
-		/*
-		 * At this point, the path is normalized to use Unix-style
-		 * path separators. This is required due to how the
-		 * changed-path Bloom filters store the paths.
-		 */
-		if (*p == '/')
-			path_component_nr++;
-		p++;
-	}
-
-	revs->bloom_keyvecs_nr = 1;
-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
-	bloom_keyvec = &revs->bloom_keyvecs[0];
-	bloom_keyvec_init(bloom_keyvec, path_component_nr);
+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
+		pi = &revs->pruning.pathspec.items[i];
+		path_component_nr = 1;
+
+		/* remove single trailing slash from path, if needed */
+		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
+			path_alloc = xmemdupz(pi->match, pi->len - 1);
+			path = path_alloc;
+		} else
+			path = pi->match;
+
+		len = strlen(path);
+		if (!len)
+			goto fail;
+
+		p = path;
+		while (*p) {
+			/*
+			 * At this point, the path is normalized to use
+			 * Unix-style path separators. This is required due to
+			 * how the changed-path Bloom filters store the paths.
+			 */
+			if (*p == '/')
+				path_component_nr++;
+			p++;
+		}
 
-	fill_bloom_key(path, len, bloom_keyvec_at(bloom_keyvec, 0),
-		       revs->bloom_filter_settings);
-	path_component_nr = 1;
+		bloom_keyvec = &revs->bloom_keyvecs[i];
+		bloom_keyvec_init(bloom_keyvec, path_component_nr);
+
+		fill_bloom_key(path, len, bloom_keyvec_at(bloom_keyvec, 0),
+			       revs->bloom_filter_settings);
+		path_component_nr = 1;
+
+		p = path + len - 1;
+		while (p > path) {
+			if (*p == '/')
+				fill_bloom_key(path, p - path,
+					       bloom_keyvec_at(bloom_keyvec,
+							       path_component_nr++),
+					       revs->bloom_filter_settings);
+			p--;
+		}
 
-	p = path + len - 1;
-	while (p > path) {
-		if (*p == '/')
-			fill_bloom_key(path, p - path,
-				       bloom_keyvec_at(bloom_keyvec,
-						       path_component_nr++),
-				       revs->bloom_filter_settings);
-		p--;
+		FREE_AND_NULL(path_alloc);
 	}
 
 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
@@ -761,14 +763,19 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 		bloom_filter_atexit_registered = 1;
 	}
 
+	return;
+
+fail:
+	revs->bloom_filter_settings = NULL;
 	free(path_alloc);
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 						 struct commit *commit)
 {
 	struct bloom_filter *filter;
-	int result = 1, j;
+	int result = 0;
 
 	if (!revs->repo->objects->commit_graph)
 		return -1;
@@ -783,8 +790,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 		return -1;
 	}
 
-	result = bloom_filter_contains_vec(filter, &revs->bloom_keyvecs[0],
-					   revs->bloom_filter_settings);
+	for (int i = 0; !result && i < revs->bloom_keyvecs_nr; i++) {
+		result = bloom_filter_contains_vec(filter,
+						   &revs->bloom_keyvecs[i],
+						   revs->bloom_filter_settings);
+	}
 
 	if (result)
 		count_bloom_filter_maybe++;
@@ -3202,6 +3212,14 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 
 static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 
+static void release_revisions_bloom_keyvecs(struct rev_info *revs)
+{
+	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)
+		bloom_keyvec_clear(&revs->bloom_keyvecs[i]);
+	FREE_AND_NULL(revs->bloom_keyvecs);
+	revs->bloom_keyvecs_nr = 0;
+}
+
 static void free_void_commit_list(void *list)
 {
 	free_commit_list(list);
@@ -3230,11 +3248,7 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
-
-	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)
-		bloom_keyvec_clear(&revs->bloom_keyvecs[i]);
-	FREE_AND_NULL(revs->bloom_keyvecs);
-	revs->bloom_keyvecs_nr = 0;
+	release_revisions_bloom_keyvecs(revs);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 8910d53cac..46d1900a21 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -138,8 +138,8 @@ test_expect_success 'git log with --walk-reflogs does not use Bloom filters' '
 	test_bloom_filters_not_used "--walk-reflogs -- A"
 '
 
-test_expect_success 'git log -- multiple path specs does not use Bloom filters' '
-	test_bloom_filters_not_used "-- file4 A/file1"
+test_expect_success 'git log -- multiple path specs use Bloom filters' '
+	test_bloom_filters_used "-- file4 A/file1"
 '
 
 test_expect_success 'git log -- "." pathspec at root does not use Bloom filters' '
@@ -151,9 +151,9 @@ test_expect_success 'git log with wildcard that resolves to a single path uses B
 	test_bloom_filters_used "-- *renamed"
 '
 
-test_expect_success 'git log with wildcard that resolves to a multiple paths does not uses Bloom filters' '
-	test_bloom_filters_not_used "-- *" &&
-	test_bloom_filters_not_used "-- file*"
+test_expect_success 'git log with wildcard that resolves to a multiple paths uses Bloom filters' '
+	test_bloom_filters_used "-- *" &&
+	test_bloom_filters_used "-- file*"
 '
 
 test_expect_success 'setup - add commit-graph to the chain without Bloom filters' '
-- 
2.50.0.108.g6ae0c543ae

