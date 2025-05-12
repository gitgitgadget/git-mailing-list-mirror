Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD72580FD
	for <git@vger.kernel.org>; Mon, 12 May 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093329; cv=none; b=UZ5bIq5wcrV08GIpc4xv7REFRmcm4BlIomJfCxQbk681l88jFsyVLw2BBSUGuBPg6lBdsxVhNDOeqOHyiwIO1Gy0YxBp30xNKOoeDABtc5xSKznywqcQiuS7zEhEBwswYfAfCwHVgLGwTPOkKdDuSi2emyJI4C5ZM+TnF34Dt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093329; c=relaxed/simple;
	bh=onmbaxkFbX+nAmJltpj7X7mMqgbmw2B9to5/Xu7XqDU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bcFuuErjgzt6I358gynPtYMIcVTDKlpy4CKwVUBR0XC9gM0dAFwkuBbne3UEIzfccJcSUYXmoXvwZcVCXkoE17QD5Aw8PBP8V+39q+fM8fZKg7vuMuixr5/x+Xfcic1dtq75JjNYbt5jkHddb8hIOmT/TlRxWZP6m1DuNDp1Dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjUbGk4Q; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjUbGk4Q"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso33826545e9.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093325; x=1747698125; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=hjUbGk4QvUC5aE/UmfK+SCbM9ccUjFXtY8q7pNKJC/c+e8qdBVfJ51mdMtCTVJvURd
         V9z+nsA5KaFBLdAaqjKhyHdFtcJGw3/aItj2QHIE3tYaqXDBQcXltXwzclNKXF4GdX9W
         rjygcCpWt/lvtqMCsfdZuNsRyeEYb4rA5LI1bkPn0e90ukYdEZ6/Bac5c2kFUPBg1Te2
         d3TWAjSVqZ5KolRB8JhbwUyx1tD6aSmE8YGd+eGzOQUDU8fHk1TOjE4PL6ygef5MPqzz
         G1vvKUAlXfwueaG7zoqafNpVEbQg3EvgDSyzsPWmuKpj6rh5WTX4EdbjxmbJmBYHKLC4
         tQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093325; x=1747698125;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3ASt+jibcenxweI72mlx+ZNnjYdsnB+xsFhClktLR4=;
        b=MMnsigqr3r3cJ2XnkDeVIInXRLODG7liGiHfG7wlP1QZuSXo+kITbcaIZRpmt0VgpJ
         6uZzJevi934DCZ1gJY2Rl01zBBx5B0B3iTuWp3Hr2z4ngDAI4MEmBsjOBSJ9HRLNGAz+
         dsF79NJJ0mcFaWoyGymBDCdsuTLKBgSvqKLjUwY7o44xOkDWAqPdLHldU7Vzw4fQJSx+
         Yc6PldXJD2cqswqNleTCZ7WjSmyNxjCMS34idiwtWe76eCGIjZEq4lnd8lRkhQ/ga6Nv
         hIbchDicY1BIIqvknupflcW5Gs0eeK/BnAHFqXKyqyC3eA6MpKngb7+eXba3shpn6pkV
         +Vvg==
X-Gm-Message-State: AOJu0YySKXC6NyNA+Dyi9lvwffTmHO87YjcHFWFE8FobM9IVLMTT+vDC
	Qca2iV+OXwgD1cDe0zRVAWno5HLJuUJDc/vYMBXL4M2usvlQfAFC4vQknQ==
X-Gm-Gg: ASbGncs5weqyuQLe+JiKP5oeM7r8eriSd3B4iEZGZdIfCcmAqXdnKxT6wP9677Kvlsu
	INupC6B2ZaVB7YHvuBYA/Pw1u3FvOKGIfRjy6cMZBrkX2mkhcl7AXEzWOPzmMKhgTKUlpt+2rS0
	rxSjeiAg1A3Y8MWINIu5sVVAWoHbZm9IMjKcTcKDc3aj9U4FIZNvDQuoGaEFJcIlH6Tr+yK2KnS
	ZwyPiL+CT10Hoqfaf1OYh1gLwbaaeLPWcO7WYGhmYSGGZmrhu9nuiBetyVsg4oSowflhaESqfRa
	L1JZ8SM4xAQjAB8/i0I+h7H4oeduLkKG5egtX+uXguPUqmkqUItW
X-Google-Smtp-Source: AGHT+IHwPefOnypEhRUd7QdrtdXs/WzxLgMkBbLNLaG0LI+VuB27gL+IR1Q5Z4Fh//osTd/BmpnsJQ==
X-Received: by 2002:a05:600c:35c2:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-442eaca3444mr9802875e9.5.1747093324777;
        Mon, 12 May 2025 16:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687ac8csm140318135e9.33.2025.05.12.16.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:42:04 -0700 (PDT)
Message-Id: <4757c4810d3421b6c41723da837cab14824239e2.1747093322.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
	<pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 23:42:01 +0000
Subject: [PATCH v2 1/2] merge-ort: add a new mergeability_only option
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

