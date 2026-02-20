Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCB25CC74
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552796; cv=none; b=EdxEechq8K7p/ivpd8/INBLkrQls91jsN73iMSjU6eOR651Bq/Sz3IVP69nhuSV8t3AG5CdcQdmE1qLpkfz17E8nzeR2/7xdc8wwAF7C8cug7OnnpQzE+NsIEVfJQ7E8ZWpaZq+VfpEZkdcsLdjawuiUqC8NW1h/hfSkNCT5ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552796; c=relaxed/simple;
	bh=mMXgWosoAoqX1L9+UbykPMNvNUiLcm8VCMrfbwpLbD8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GijfE0H8W/RLTuMQu9koiU1mm5nvGGvK6Uk0ROFgruYRLrqleu/palWc7HhDcVbVecR4GLdqSVDovV9dVYoOMcsMAdzdRR9cZrrk3zSjJgEv8qotM7JyPDRkGNB89fmhr8+S6CWT5WvkaVAHg+DQDBqOI/c7CglqIR3RYVRBpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8aVfA9q; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8aVfA9q"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12721cd256bso1751883c88.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552794; x=1772157594; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RajM8h5/Db6MykEiBSIcBf1chkNP6BzlpqpSTTB8Wbw=;
        b=K8aVfA9qOUbxN8NhGCQe3EwstGob0h4F+RSnuZ7D1o4WeTqyhQzsLW5GGezcb6R6AA
         y7B2n13/es9unld0h0DKC46wDPBSBu04xbNpdl9SPstCpsuo5L2vdKZg6B2sy5XIbLp9
         ZdXU7vF0g4cyRfVCjJPmYio2M9RhtrcRDPi1/sK6n+V/FwIb80rXO2TvJDMu7LxsFVF/
         iISrWpi8/S/5hbt7GIqmvf97RfuQeceIxR5KwyYyyktcCk0w/ZxUBB8VOiTqFciBlxmZ
         wZm1Fyaf+gh+BqQQyW1d0wsdvHihBmqB8Mm0uDWAL6adOBZqMpbSV/Fi3XaILNFLm+H0
         UcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552794; x=1772157594;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RajM8h5/Db6MykEiBSIcBf1chkNP6BzlpqpSTTB8Wbw=;
        b=Iff3YfWRoSv6rWw1YIX9zUrGN4sws4DZzU2w5UnsNsWW1pXKUA128m5qp4IrCoVcBM
         GtjxtHYYfruVqHmm5tDJ/gJ5HHaE9yLjPMg2gBPBk06B6h6HmWpq/LeBq2Jt0wYrP4qX
         ++OfI8lIVRtwInaDN5kbfOcrBf04753CbSDi2Gocic2uHPmzEwOktE3vH3gTk+lxhkdP
         zopEmv+tJUjaMqq5VzRE4ltI/ekUlBQGNKh7m9aRjC3KvQqn/A158uSlQeQt9ZPR0/fK
         0zXFJUkcjXNqb0mjfIzn3nbrUhtQgC5reT1cDruVyKC+bxF1xyumX+T1n4Nwd0m6BEcr
         pafA==
X-Gm-Message-State: AOJu0YzDcXtdWLuwS87k0BF0FJbLpSpdBwkKzbvuw5zwSLMVk8j1Aa4b
	YLimabL69eIKKNSi6TszIb+qfTMJ25s4cdlDDVWbmqT2o1uvhvb189X5/HnD/a/k
X-Gm-Gg: AZuq6aL7C/UbmoHFWsmTUpC6wJqxzFv4u9OSQ83DXgKGt4LBsKMTXeWdWVc8E9avn9h
	wGzRZvpfl0ZZAHKMSuN5Sb4yBQcOguTSkatLBqVyvZrs82U+3lWQ5Fs2x4AH3NWAjGgfAUucp7w
	bP7Kotw4UFIyoaTDLUtJXBYsDdfdY4eh2ediIfLAymBN7FvOKqgH3zeWk+TvttD3e5E2KyXyE+f
	l1Ddh9ty6a6hE1ZHU6ANKhp/7DDbYeP0S3eJQ3rK0B192IrgxkGUN7DEXMc9aeQ5l+IQXAF0nFW
	QC8+l/3pN92UKougbXlHxHle3RhORaxGIF69FnfoU1VGPtPT/tp/ifyUZYn94CVuyRRpuWjLDp1
	AmP9II5I61EnYd6he2ec6HUnkfXt5L804f8tW7InY7f0C/Kew3hyFSvfOF+5kt/l/qIUMma2JKO
	TTmvu9zwy3eH6nQ4OGARjTGtIoGAcgFRH9rLEw
X-Received: by 2002:a05:7022:45a8:b0:119:e569:f626 with SMTP id a92af1059eb24-12741bc8629mr8315062c88.31.1771552793686;
        Thu, 19 Feb 2026 17:59:53 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc9376sm27134237c88.16.2026.02.19.17.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:53 -0800 (PST)
Message-Id: <68af47ed187ea1bdd1b83ad8aae8d7be60a469c8.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:45 +0000
Subject: [PATCH v2 3/6] merge-ort: replace the_repository with opt->repo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

We have a perfectly valid repository available and do not need to use
the_repository, except for one location in
prefetch_for_content_merges().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3535fc676f..9b6a4c312e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1732,9 +1732,9 @@ static int collect_merge_info(struct merge_options *opt,
 	info.data = opt;
 	info.show_all_errors = 1;
 
-	if (repo_parse_tree(the_repository, merge_base) < 0 ||
-	    repo_parse_tree(the_repository, side1) < 0 ||
-	    repo_parse_tree(the_repository, side2) < 0)
+	if (repo_parse_tree(opt->repo, merge_base) < 0 ||
+	    repo_parse_tree(opt->repo, side1) < 0 ||
+	    repo_parse_tree(opt->repo, side2) < 0)
 		return -1;
 	init_tree_desc(t + 0, &merge_base->object.oid,
 		       merge_base->buffer, merge_base->size);
@@ -2136,9 +2136,9 @@ static int merge_3way(struct merge_options *opt,
 		name2 = mkpathdup("%s:%s", opt->branch2,  pathnames[2]);
 	}
 
-	read_mmblob(&orig, the_repository->objects, o);
-	read_mmblob(&src1, the_repository->objects, a);
-	read_mmblob(&src2, the_repository->objects, b);
+	read_mmblob(&orig, opt->repo->objects, o);
+	read_mmblob(&src1, opt->repo->objects, a);
+	read_mmblob(&src2, opt->repo->objects, b);
 
 	merge_status = ll_merge(result_buf, path, &orig, base,
 				&src1, name1, &src2, name2,
@@ -2254,7 +2254,7 @@ static int handle_content_merge(struct merge_options *opt,
 		}
 
 		if (!ret && record_object &&
-		    odb_write_object(the_repository->objects, result_buf.ptr, result_buf.size,
+		    odb_write_object(opt->repo->objects, result_buf.ptr, result_buf.size,
 				     OBJ_BLOB, &result->oid)) {
 			path_msg(opt, ERROR_OBJECT_WRITE_FAILED, 0,
 				 pathnames[0], pathnames[1], pathnames[2], NULL,
@@ -3713,7 +3713,7 @@ static int read_oid_strbuf(struct merge_options *opt,
 	void *buf;
 	enum object_type type;
 	unsigned long size;
-	buf = odb_read_object(the_repository->objects, oid, &type, &size);
+	buf = odb_read_object(opt->repo->objects, oid, &type, &size);
 	if (!buf) {
 		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
 			 path, NULL, NULL, NULL,
@@ -4439,7 +4439,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	if (!repo_has_promisor_remote(the_repository))
+	if (!repo_has_promisor_remote(opt->repo))
 		return;
 
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
@@ -4619,10 +4619,10 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
-	if (repo_parse_tree(the_repository, prev) < 0)
+	if (repo_parse_tree(opt->repo, prev) < 0)
 		return -1;
 	init_tree_desc(&trees[0], &prev->object.oid, prev->buffer, prev->size);
-	if (repo_parse_tree(the_repository, next) < 0)
+	if (repo_parse_tree(opt->repo, next) < 0)
 		return -1;
 	init_tree_desc(&trees[1], &next->object.oid, next->buffer, next->size);
 
@@ -5280,7 +5280,7 @@ redo:
 
 	if (result->clean >= 0) {
 		if (!opt->mergeability_only) {
-			result->tree = repo_parse_tree_indirect(the_repository,
+			result->tree = repo_parse_tree_indirect(opt->repo,
 								&working_tree_oid);
 			if (!result->tree)
 				die(_("unable to read tree (%s)"),
@@ -5309,7 +5309,7 @@ static void merge_ort_internal(struct merge_options *opt,
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (!merge_bases) {
-		if (repo_get_merge_bases(the_repository, h1, h2,
+		if (repo_get_merge_bases(opt->repo, h1, h2,
 					 &merge_bases) < 0) {
 			result->clean = -1;
 			goto out;
@@ -5440,20 +5440,20 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 {
 	char *value = NULL;
 	int renormalize = 0;
-	repo_config_get_int(the_repository, "merge.verbosity", &opt->verbosity);
-	repo_config_get_int(the_repository, "diff.renamelimit", &opt->rename_limit);
-	repo_config_get_int(the_repository, "merge.renamelimit", &opt->rename_limit);
-	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
+	repo_config_get_int(opt->repo, "merge.verbosity", &opt->verbosity);
+	repo_config_get_int(opt->repo, "diff.renamelimit", &opt->rename_limit);
+	repo_config_get_int(opt->repo, "merge.renamelimit", &opt->rename_limit);
+	repo_config_get_bool(opt->repo, "merge.renormalize", &renormalize);
 	opt->renormalize = renormalize;
-	if (!repo_config_get_string(the_repository, "diff.renames", &value)) {
+	if (!repo_config_get_string(opt->repo, "diff.renames", &value)) {
 		opt->detect_renames = git_config_rename("diff.renames", value);
 		free(value);
 	}
-	if (!repo_config_get_string(the_repository, "merge.renames", &value)) {
+	if (!repo_config_get_string(opt->repo, "merge.renames", &value)) {
 		opt->detect_renames = git_config_rename("merge.renames", value);
 		free(value);
 	}
-	if (!repo_config_get_string(the_repository, "merge.directoryrenames", &value)) {
+	if (!repo_config_get_string(opt->repo, "merge.directoryrenames", &value)) {
 		int boolval = git_parse_maybe_bool(value);
 		if (0 <= boolval) {
 			opt->detect_directory_renames = boolval ?
@@ -5466,7 +5466,7 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 		free(value);
 	}
 	if (ui) {
-		if (!repo_config_get_string(the_repository, "diff.algorithm", &value)) {
+		if (!repo_config_get_string(opt->repo, "diff.algorithm", &value)) {
 			long diff_algorithm = parse_algorithm_value(value);
 			if (diff_algorithm < 0)
 				die(_("unknown value for config '%s': %s"), "diff.algorithm", value);
@@ -5474,7 +5474,7 @@ static void merge_recursive_config(struct merge_options *opt, int ui)
 			free(value);
 		}
 	}
-	repo_config(the_repository, git_xmerge_config, NULL);
+	repo_config(opt->repo, git_xmerge_config, NULL);
 }
 
 static void init_merge_options(struct merge_options *opt,
-- 
gitgitgadget

