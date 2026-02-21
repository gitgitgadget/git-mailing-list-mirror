Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB43EBF36
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718402; cv=none; b=DQh61gu3wbVU9I0dH3sJDW7ef2Yovlw2BTT/0piNLh2XAgskcV/RJ9t86LLhhgdSFF6A4pxehqrB45Z//qVmV8FcdcVPSwGhRN04RpYxWbXpgo40AZL4KKwmrgZaNsn1ynKPr1p/EDd6m6QdXP/KXCCV57kiOBqad7QxRE/1TpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718402; c=relaxed/simple;
	bh=L9FKJaV69+zTUsN0G4KBKkRvpkr6+jFIAEpTT7uF6GQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dCBKHnQeluBT1UrdiD/X4GZYR2v8zztWWuMsoW/JJN2+mk6UJBf1TGmRNMQ/bkVeLJzbMShNeGeEvU5FRYHZC0V4OpgiZ3EZ02/Zy8kzT4pXEthl6bsTTsqv0kFz9oC11zCPj4zkyjoAqtmG7+qce6dgmiRgJFvjjDE5o68zIM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4SZMrQH; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4SZMrQH"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c7146b0854so354850285a.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718400; x=1772323200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4nMPgjNW45t9R86Cb4QKz1RdZzmMnYCh2GccP8kEX8=;
        b=A4SZMrQH77v0D0Lw/iFZ44mu2h/DtYmT/wASgb2iedsVRLXTcIdHyuHApFpdFId2tL
         J6cf/kKW/9U3IIp9H4xsPXtn8+jeTg6fmcgzEBvVAGLmrJFBuYA4rUlJa0S/4VuN18nh
         NPUSgNxsX0kuUGTaroxJG1nfG4Houm0LGJWYIN/z2EBOn9WnGTDLFAipqGjGoYrnkYia
         gtHqqXGwOAGeOGRg9W9NJa1H1PqLNCXOD80IpDOsH3zpmR3cqHq/kDkIm3ChGQm/yQ87
         wqCttt41rEpvizteLy5RUfcsJzKTz9gQcGdcJ6ecUyIzVQUj5Ub7Lt9+YNPILga1Reth
         qu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718400; x=1772323200;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4nMPgjNW45t9R86Cb4QKz1RdZzmMnYCh2GccP8kEX8=;
        b=gfwzCro3H/r0QZ7YwLfhTYvgUMulcK03iLSneNeUkupm5fjQNPbqys54S4c/pnvTEr
         4/GMfthrwnbmvQTyit8Dta+EMurkmEjhpqQr0T02C03QR6L7H6erS5Uky4Em9ylponFH
         sSfvkw5V0IwweuEivPhth7cQCv6DeyRO5Blb+1mvgYYuZ8TITWTinb/rRIjO/QbflrUy
         c/+PkEicnu5Jmyb4xHhK3XRMqwSEM3cGTrdYGdWSUNU1gVfGJM21qy8FAZfAsc2+ypul
         wgSEb4FhAD2njaYPB5sV28CjMqPzB3nyK1JhI1V2G8oicOYM8yCMkzEklv9uK2MlKvYj
         IsHQ==
X-Gm-Message-State: AOJu0YzPKqBeAs9aDUq8TjpldIVqwybXT/auwhaLdvOOeSekwdEwyrx3
	BGnRpx0SD83QnBkBh8ZuA0NqPUG7ul3cBA8otaFQgpd/4gvCJiO03ZOInc+xuQ==
X-Gm-Gg: AZuq6aK3KETyI7Eo/vK8/HFUPBJwMyN4qlj3iEK+aDKGUNiRrMkO9ZkWddtzoHcppzt
	TNMrZrndz9k+2mpdMnbVxwNdUhCCUlCESbCuD7yePGtasmwETws7scl0z0CckOP2EEGd4lTQ4AA
	szFDnIQvpO9XPS+szaJhx4JQM8c13HQefX1FqANKsHnQKPc+V3j45iwt1B7tmCWwUxLRUGyabZf
	Uae3QHoSWpk+6e7U2xfCvBYCF21HZy5w6MHHK9YAlUZZZi+GxmYTdVcJ3P4I1rQsJJCjcV5x7zB
	So9fs7yJq3779KYiNT3mKSggecGXr3jiOcMK7aH3wlWLKmcpgE+kHyHhv3YSrlEXk9UAgwCYk/Q
	82Kjd0T224saqPRL5txgYXgk26yqtMe1HK78ZqkNOYBTMhTGuI7np9OelVPlJ/zyg8EzGhSi+mb
	rq+6082TI7lT6ZXSUO/D2FL8Fs
X-Received: by 2002:a05:620a:7118:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cb8ca9294emr480520885a.78.1771718399823;
        Sat, 21 Feb 2026 15:59:59 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0460e1sm343168985a.2.2026.02.21.15.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 15:59:59 -0800 (PST)
Message-Id: <4ebfcb08a5b79c519340ea5c13d3dd44b5060639.1771718393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:50 +0000
Subject: [PATCH v3 3/6] merge-ort: replace the_repository with opt->repo
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
the_repository.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 289a61822f..9b6a4c312e 100644
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

