Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE233A70F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406124; cv=none; b=TNK7t+rnTkYaaj23N4YKcxdEtGj54hU5daa2JXfEVrpaCMNj6RyDMough+bzKRxhtcYDjnm4QN+C2pKD1jRhx2oRDO9eoB4u8ssmKuuqDvc84ZKL3Ikkuby/TnuJ3Q6ReHOG4wARCen4rboaroIm3AnzZOaLGJv9JqONyVJa7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406124; c=relaxed/simple;
	bh=yCOUC3D6vThvBcL69R1mXsH+CYHASdMtrUelY9oTiAU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EGuxHoOrOtYfJZJFp1P43m+DzGl325ilAcvDMLCqgPepmJeTh2EOLrjfmAZ4aOtJOa6LwfQCVAcm8Vb3156bNCbpKHYx2xB+NNLKK6aDU6XJ34R/hNeRQOw/jcTN8Oi+Hma/dsduv7HzCkGpeeNiF4o54cKSjW4gMB3anwJVDdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsZdebgq; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsZdebgq"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4620722eec.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406120; x=1772010920; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6klz7fQJUVqMMuD96uKf/m62B9+eh7pbxBisZ+T390o=;
        b=OsZdebgqfjs7sLvFOGky2BJ2U9G4Ll1HxLUixEno97zTFkMmCk4qO7r87dIe9hlinR
         OdVB7TrvYOi3Q1uaX9iY9e/Xt/YK/FJL70Os01kS853kDpEz+DO0rmevdeGgF4RiQ9Ns
         T68rBqBAfJyvcWZOLhvGLbXMGQXCwVVU50iVicEIvZgEcJT/jd3QPyPIWkorHDvE2dEB
         a7xXA4ALedjJboEqceAz5yTipDdHpjrLkxm6VHRvHupwlF3vuNrX2Eq2TN5jGeMnyU+r
         f/a8p+UV906Jai2ZJvPI3WP3h0gSS0leH2CiH2gNQDntjU8OvGHWatm/g5ahfEumUsWW
         xDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406120; x=1772010920;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6klz7fQJUVqMMuD96uKf/m62B9+eh7pbxBisZ+T390o=;
        b=HUnQ/YDPnjFiTmYrJuP0yYW4zHSh0CQMN+0lC/9p4NllpxFnLoF9LBSs5Nopj66Uka
         ncN7d9wqHV2PlNdH9yP3VDeIIfdnJ1WpvEvuvOHI7yeBCzWbnnHsky8z4vqQjSI4GiNK
         yeMZqmUSbYW1DqdC5r+hoiqt3bkSyIYUMREXgcMKlf9A9dBZhrX8cf9ri1MhJxADf7Am
         UU6zNVdafALgj1+dsRYqYdPhk5P2Xzqy6NQrZJqls0IbcfrxI6lvDVcNUhJJMmL2yP4C
         lXGnvkezPGMWdT+SNRLpFZ8SP1MeRNrn1AhdAilvRANiAchz2SfpDJKSKXlO29pU2uWI
         ejwQ==
X-Gm-Message-State: AOJu0YxlUdoyZ5AMFcb371W0qJTK5vXoAtRgEUH5+53L394ZOrpAeN30
	WJbwS35BDK4A0v0mzyPd/A6WjCiuatcvCRK15iGgJXq0pvYeqh/ZZYN314RNrA==
X-Gm-Gg: AZuq6aJWWd5HMmGKfYjNPtNP8sR0iAswIr1CX045zFhe8EplYzvcsyVKMjGBHk+kNnh
	YAerKsmOMHV0Rv0EUpo8PbfYslvDAkU/DflgRH1CcF4OoVYrhdQjg+H2G/xaNciv274MLDy2z0p
	nFm/YYIN7w4cGjrXoV2+eC6df61iSAsfjpsCE4p8+uRFOpIvsAZZXh/Bj/46xUf0Aro6hDZGSHy
	Zw5XPl5h12Uo0LEnRJPWwiVrFzEQSjgI/DDjKp9zMlCXEzUuRwlqRMWCzAByl3L8cFiMXI/uurd
	3gonq7MyYPkYoSi0ckR7myC79akXyVnpup5SEfxKF8a9v6lVGPEhbATp/IzAVTfBUNoIlGhwDOX
	JWbTNF1ORFhhq/S3KbSPnM7/QAtG+tx6N03dDgtgMKTPKNJxXC/3OlgDf7h0xeCYXzv9ZvYeuHD
	ZY61uW4p6SBqX8xgAnr7GKhFKvsQ==
X-Received: by 2002:a05:7300:d70c:b0:2b7:ee0e:e9ca with SMTP id 5a478bee46e88-2bd5008f728mr543453eec.13.1771406119991;
        Wed, 18 Feb 2026 01:15:19 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb5622f2sm20695424eec.10.2026.02.18.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:19 -0800 (PST)
Message-Id: <abba4bd76233d7efb5d876bc14753359944b2d76.1771406115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:12 +0000
Subject: [PATCH 2/5] merge-ort: replace the_repository with opt->repo
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
Cc: Elijah Newren <newren@gmail.com>,
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
index 42499f7b43..2106c5f632 100644
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
 
-	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
+	if (opt->repo != the_repository || !repo_has_promisor_remote(opt->repo))
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

