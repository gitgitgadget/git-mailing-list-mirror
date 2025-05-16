Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A426E226D04
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425865; cv=none; b=orhpQEJOidmiazhxZIFIGIsEUpKa42QenxHYzGf4lX7MOeOe8GGPZy9Q4E04B2pXbr0Jr3Lh8g05/eDF1Y61dJuIkaKEWTGZt8GntaPZJdZUpIKRz9WPxbiXuRPLyX6KPdC6usUM/vrczdgA30TZ8FnMMfI2pRXLJy9WboAl+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425865; c=relaxed/simple;
	bh=onmbaxkFbX+nAmJltpj7X7mMqgbmw2B9to5/Xu7XqDU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ERTALzCS30bG3x6JwkYZd0w54HvURs5ZOYldqRAQdrdvSuguoVXKhtnYaVcBdXw8ylRUTbUjdUTAoofOBbVkirrXhzcBjWlUy2mhIroE0GiYAZZ4T7zhgr59m6ZolADACFJ0FOBw282jmDPuQeR1v1GTyyy/s6LtP8ySzrt02Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOWXinvp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOWXinvp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d1ed82faso18475385e9.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425861; x=1748030661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=KOWXinvp6Cs30MrHedhuOiJkS9DzATOodU19capXkEmVNA18EUVjQ8svANk/Fof9ss
         1Uu/FCojFa3UR8vQUcUqGphhpOGCKTeMy0h1wnU6M6sIPsF5oStOT4El6E8dJKpJNV6O
         4Jcapaul0wQtwc4G2NXmJ6LAFjftmFAVuvSnyH3Duy5nBwf0hpvSz8IOZDS3v/QtDUCo
         lsxMmgyg8G8ahY/pwOkCJvRqtWZ4Z9x7ofSOaaFuHEGwGfSmzspllGNnw/sIL7ua3dO8
         dj1D7yEdWoUKpIJXRod0r8nK3i64mcwugh48a0lYtstLd0pBQ2MDXYus26RvoUE5GqlJ
         6o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425861; x=1748030661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=JoTG28a0jI16ibUdgPDpSZX8cyqC2Gs8Fv6Cz31i+RTOAYe4QUTgr9Rx3oilpnWjQ8
         o/ar+Myt4cQWZaUG3lJc9LbPTc+Sruu0VEd6dQUqv7oS0YN4kdKXnB2tLsfWwqmV1GGD
         YA1jN8YbiccRP8wq9VTcwHquqU8NaMYbB6n4/NPnp+hnQQqzDGmdEoTtFbZLkZjCtQQg
         jYv23iHuzemyGPgrBSIklUxwifFjQFHLIY54VLnjV9dx6ZX9PoDdoG4wyEoYmieFWmyy
         Rfw4H46Iqqf/oxFIIvUzV7npBnSNEKhxrxtJ0v8M73B1dvLMLcPvufJMfLw1fcVt5l4B
         1v1w==
X-Gm-Message-State: AOJu0YzHmKQg4wBYdIQO5hBTjchVpl3EbOunPAveyUbZXrDrEuCVV9bx
	f19AUlWsqT7Xp4l2B5AdX0Ppk27Une2TLk/20LuVSol87+uUOqyvC6uOUCG6+g==
X-Gm-Gg: ASbGncsviykTilmSMjIzKZfcX4QIgloX8FrH9nglU9+yZA0SvFr6J/+je7FZI8WRqRd
	zFQ0RLIloupROVk95Xlx+b23nCN2+ehcjv6xFlbWmg3qZhXWadh3rLxFnzxopuiELp7kB+F6fQs
	m4baoT3Q+d927Lw2f43V09sSsgF7KEuTMeYMirURheEkop6csdXfbT8cXeQNIf07qidV8qseqN0
	dCzHHxlMbXCYFXg+5cu7G8iAzwdEycABojIscWw7EEJNT4CiKg7qlksqXJMXxvx9FnzYTkuXdEY
	4p9VGRYILQLRCb/ZgSfsFzS7SeuLWTI8eKMjz1RoNjVOiagLTXAN
X-Google-Smtp-Source: AGHT+IFA+yyDb6EercFRj8pO4b1ijuZJiwe0mhmCTVZDLWS4P0MsDMbCgc+eX/3S3mf2Kqenr/POKw==
X-Received: by 2002:a05:600c:5491:b0:440:6a1a:d8a0 with SMTP id 5b1f17b1804b1-442fefd6da8mr31753525e9.7.1747425861010;
        Fri, 16 May 2025 13:04:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6294bsm3898505f8f.51.2025.05.16.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:04:20 -0700 (PDT)
Message-Id: <4757c4810d3421b6c41723da837cab14824239e2.1747425858.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
	<pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 20:04:17 +0000
Subject: [PATCH v4 1/2] merge-ort: add a new mergeability_only option
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
    Phillip Wood <phillip.wood123@gmail.com>,
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

