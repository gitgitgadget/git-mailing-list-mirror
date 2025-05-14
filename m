Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17D17736
	for <git@vger.kernel.org>; Wed, 14 May 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182295; cv=none; b=dM3dwXiRAP8zS//2UqxG0MuQuck1Vd9VTeq0lhwqOH87DW/fkSwmUOdF1mxzoOepgY9OEkK4MT1emwaX0RB7qtHWlul14J+7jjzQ0+qkQm+vaKhGLYZXVDSfYO31EYF5Ea/DNc1Cmn6+cnms15BQDCFFFDUjc34drCfUEJBVnSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182295; c=relaxed/simple;
	bh=onmbaxkFbX+nAmJltpj7X7mMqgbmw2B9to5/Xu7XqDU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TvushGMS5dMr4CXWSJlrwEPTM9Q54jBR6YPm253JrQH8l1DEBrIhcQihlgdC+JuN3fhUF8h96QhvtSBiBycggPSZQIHI2RyZ76TJaF00b4eT6YfGrJcBLyWA/QjW80F+cdfqBnPOF9qKW1ov13jGX3SzdyUlW7I+Z8aBb6Yeo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLK/a8Lb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLK/a8Lb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso61791395e9.2
        for <git@vger.kernel.org>; Tue, 13 May 2025 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747182291; x=1747787091; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=LLK/a8Lb47UfYYCSyMvtK1kKNbMFlxvLzt0v5AzuP+OISpTiDY8ff5LVmVca0GCt55
         lYfpG/Waf+qAKw24aw37+IbeRzzhTefwwMGlASWJu/3rTtPJrOrVzlZrhOZ9/xmOm2hb
         yxSNKqFGWv95NqcrkvQXSEJ1RaF0w/kVJJ0waoHa/rNdCUx9ivV+QG3pUhVZHQ6UZgbY
         arUFCCAc3pzrCnkdYN5whU75x2JrUMK9czPy8Xv7XQsPSvUsz3+i0LW7KPJeEt1TrEX3
         5jX+XQdxIpdtrxmBVcdQ03eFKWQ5HXyOxRcISLLHplPqfLTHUWbDpwqPWK4av9iEgFP5
         6iRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747182291; x=1747787091;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=JNY+jFe69YFfJxoEhRtueshAx4nyzCzbCYvRFI4bAxAbSxtJ/4/ztz8UFTntLKQuRB
         GSx5kvLs4zL70nMvdvtiQ/2sc7Q8Ad3GioVe+LJ/HvqsVROXI1URfjjvNTC/zWujSE7K
         j5te2YmI9DeCGTUT4RjZREGatBcadABkEgmjQGAnp0lPkKszv4od7KSxpcz4AOYkVxio
         Fz7lRoXb6DrRcaYH9Y8pg6vea9yIIbss0z25yWkebTIMkVZLcF43Q1mIGJ1XuQ9pxp/y
         8ayOVSSi2dpxz5QHdeD1RCoxFtRg7GCFXh/LEA8PqGueimV/JHsXPCfWq4uDIuu62eS8
         ISiw==
X-Gm-Message-State: AOJu0YzBXhQ7Wh/ehim7abAzipRulmLWDmynIymZAf6FPRSSM9oyVshS
	LTcA2cUlPQrkOVGzcIAkBhqiKZ5igAGIgDxTGWmvuw6+hpv1ID9sRsn33w==
X-Gm-Gg: ASbGncvzJ4Y16odvOO12LZ/J/YCirInn3iklWB2LzK3Tc2ahrFBd4tPc6Uu0WUFrcdf
	SrwxnZq9zVT7+AqMU/zcTNm5LXJaeeemmShVOMTU2OsJzqdBzsGNeVDEfyKb6zJqMA5mZKa6EZw
	mEkgQkgCJ/0zDMxqLezeDh3Fr4ORb3UEJU3/etK3cEKmfD88CBBb45YHJZsynAzwihK4eSk6uS4
	koSy4Kz5t55BdM6f1biiFW3U/vjaARtUaCYEBX7XTeJsKdLo/YrpF/5rW8OYdEmpUFA8ew/Hyoa
	4PfHbmea0I1K2FrVGBwrdTqbjmPxY5qgQHO1OZZSCUnXIzPBwqIr
X-Google-Smtp-Source: AGHT+IFV3+r4P6tqg9ht+r8XkqHMf0lt9RIZibT/R7LOrxjsOeqf9JSmSlPl5fi67FbT/7dbN6EVGg==
X-Received: by 2002:a05:600c:3f15:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-442f2177c18mr9417285e9.29.1747182291114;
        Tue, 13 May 2025 17:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395060esm6252705e9.17.2025.05.13.17.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 17:24:50 -0700 (PDT)
Message-Id: <4757c4810d3421b6c41723da837cab14824239e2.1747182288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
	<pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 00:24:46 +0000
Subject: [PATCH v3 1/2] merge-ort: add a new mergeability_only option
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new mergeability_only option.  This
option allows the merge machinery to, in the "outer layer" of the merge:
  * exit upon first[-ish] conflict
  * avoid (not prevent) writing merged blobs/trees to the object store

I have a number of qualifiers there, so let me explain each:

"outer layer":

Note that since the recursive merge of merge bases (corresponding to
call_depth > 0) can conflict without the outer final merge
(corresponding to call_depth == 0) conflicting, we can't short-circuit
nor avoid writing merged blobs/trees to the object store during those
inner merges.

"first-ish conflict":

The current patch only exits early from process_entries() on the first
conflict it detects, but conflicts could have been detected in a
previous function call, namely detect_and_process_renames().  However:
  * conflicts detected by detect_and_process_renames() are quite rare
    conflict types
  * the detection would still come after regular rename detection
    (which is the expensive part of detect_and_process_renames()), so
    it is not saving us much in computation time given that
    process_entries() directly follows detect_and_process_renames()
  * [this overlaps with the next bullet point] process_entries() is the
    place where virtually all object writing occurs (object writing is
    sometimes more of a concern for Forges than computation time), so
    exiting early here isn't saving us much in object writes either
  * the code changes needed to handle an earlier exit are slightly
    more invasive in detect_and_process_renames() than for
    process_entries().
Given the rareness of the even earlier conflicts, the limited savings
we'd get from exiting even earlier, and in an attempt to keep this
patch simpler, we don't guarantee that we actually exit on the first
conflict detected.  We can always revisit this decision later if we
decide that a further micro-optimization to exit slightly earlier in
rare cases is worthwhile.

"avoid (not prevent) writing objects":

The detect_and_process_renames() call can also write objects to the
object store, when rename/rename conflicts involve one (or more) files
that have also been modified on both sides.  Because of this alternate
call path leading to handle_content_merges(), our "early exit" does not
prevent writing objects entirely, even within the "outer layer"
(i.e. even within call_depth == 0).  I figure that's fine though, since
we're already writing objects for the inner merges (i.e. for call_depth
> 0), which are likely going to represent vastly more objects than files
involved in rename/rename+modify/modify cases in the outer merge, on
average.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 38 +++++++++++++++++++++++++++++++-------
 merge-ort.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 77310a4a52c9..47b3d1730ece 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2127,6 +2127,7 @@ static int handle_content_merge(struct merge_options *opt,
 				const struct version_info *b,
 				const char *pathnames[3],
 				const int extra_marker_size,
+				const int record_object,
 				struct version_info *result)
 {
 	/*
@@ -2214,7 +2215,7 @@ static int handle_content_merge(struct merge_options *opt,
 			ret = -1;
 		}
 
-		if (!ret &&
+		if (!ret && record_object &&
 		    write_object_file(result_buf.ptr, result_buf.size,
 				      OBJ_BLOB, &result->oid)) {
 			path_msg(opt, ERROR_OBJECT_WRITE_FAILED, 0,
@@ -2897,6 +2898,7 @@ static int process_renames(struct merge_options *opt,
 			struct version_info merged;
 			struct conflict_info *base, *side1, *side2;
 			unsigned was_binary_blob = 0;
+			const int record_object = true;
 
 			pathnames[0] = oldpath;
 			pathnames[1] = newpath;
@@ -2947,6 +2949,7 @@ static int process_renames(struct merge_options *opt,
 							   &side2->stages[2],
 							   pathnames,
 							   1 + 2 * opt->priv->call_depth,
+							   record_object,
 							   &merged);
 			if (clean_merge < 0)
 				return -1;
@@ -3061,6 +3064,7 @@ static int process_renames(struct merge_options *opt,
 
 			struct conflict_info *base, *side1, *side2;
 			int clean;
+			const int record_object = true;
 
 			pathnames[0] = oldpath;
 			pathnames[other_source_index] = oldpath;
@@ -3080,6 +3084,7 @@ static int process_renames(struct merge_options *opt,
 						     &side2->stages[2],
 						     pathnames,
 						     1 + 2 * opt->priv->call_depth,
+						     record_object,
 						     &merged);
 			if (clean < 0)
 				return -1;
@@ -3931,9 +3936,12 @@ static int write_completed_directory(struct merge_options *opt,
 		 * Write out the tree to the git object directory, and also
 		 * record the mode and oid in dir_info->result.
 		 */
+		int record_tree = (!opt->mergeability_only ||
+				   opt->priv->call_depth);
 		dir_info->is_null = 0;
 		dir_info->result.mode = S_IFDIR;
-		if (write_tree(&dir_info->result.oid, &info->versions, offset,
+		if (record_tree &&
+		    write_tree(&dir_info->result.oid, &info->versions, offset,
 			       opt->repo->hash_algo->rawsz) < 0)
 			ret = -1;
 	}
@@ -4231,10 +4239,13 @@ static int process_entry(struct merge_options *opt,
 		struct version_info *o = &ci->stages[0];
 		struct version_info *a = &ci->stages[1];
 		struct version_info *b = &ci->stages[2];
+		int record_object = (!opt->mergeability_only ||
+				     opt->priv->call_depth);
 
 		clean_merge = handle_content_merge(opt, path, o, a, b,
 						   ci->pathnames,
 						   opt->priv->call_depth * 2,
+						   record_object,
 						   &merged_file);
 		if (clean_merge < 0)
 			return -1;
@@ -4395,6 +4406,8 @@ static int process_entries(struct merge_options *opt,
 						   STRING_LIST_INIT_NODUP,
 						   NULL, 0 };
 	int ret = 0;
+	const int record_tree = (!opt->mergeability_only ||
+				 opt->priv->call_depth);
 
 	trace2_region_enter("merge", "process_entries setup", opt->repo);
 	if (strmap_empty(&opt->priv->paths)) {
@@ -4454,6 +4467,12 @@ static int process_entries(struct merge_options *opt,
 				ret = -1;
 				goto cleanup;
 			};
+			if (!ci->merged.clean && opt->mergeability_only &&
+			    !opt->priv->call_depth) {
+				ret = 0;
+				goto cleanup;
+			}
+
 		}
 	}
 	trace2_region_leave("merge", "processing", opt->repo);
@@ -4468,7 +4487,8 @@ static int process_entries(struct merge_options *opt,
 		fflush(stdout);
 		BUG("dir_metadata accounting completely off; shouldn't happen");
 	}
-	if (write_tree(result_oid, &dir_metadata.versions, 0,
+	if (record_tree &&
+	    write_tree(result_oid, &dir_metadata.versions, 0,
 		       opt->repo->hash_algo->rawsz) < 0)
 		ret = -1;
 cleanup:
@@ -4715,6 +4735,8 @@ void merge_display_update_messages(struct merge_options *opt,
 
 	if (opt->record_conflict_msgs_as_headers)
 		BUG("Either display conflict messages or record them as headers, not both");
+	if (opt->mergeability_only)
+		BUG("Displaying conflict messages incompatible with mergeability-only checks");
 
 	trace2_region_enter("merge", "display messages", opt->repo);
 
@@ -5171,10 +5193,12 @@ redo:
 	result->path_messages = &opt->priv->conflicts;
 
 	if (result->clean >= 0) {
-		result->tree = parse_tree_indirect(&working_tree_oid);
-		if (!result->tree)
-			die(_("unable to read tree (%s)"),
-			    oid_to_hex(&working_tree_oid));
+		if (!opt->mergeability_only) {
+			result->tree = parse_tree_indirect(&working_tree_oid);
+			if (!result->tree)
+				die(_("unable to read tree (%s)"),
+				    oid_to_hex(&working_tree_oid));
+		}
 		/* existence of conflicted entries implies unclean */
 		result->clean &= strmap_empty(&opt->priv->conflicted);
 	}
diff --git a/merge-ort.h b/merge-ort.h
index 30750c03962f..6045579825da 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -83,6 +83,7 @@ struct merge_options {
 	/* miscellaneous control options */
 	const char *subtree_shift;
 	unsigned renormalize : 1;
+	unsigned mergeability_only : 1; /* exit early, write fewer objects */
 	unsigned record_conflict_msgs_as_headers : 1;
 	const char *msg_header_prefix;
 
-- 
gitgitgadget

