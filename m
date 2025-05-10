Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA11194137
	for <git@vger.kernel.org>; Sat, 10 May 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746914567; cv=none; b=J/Iim2ehPyU0Ih3++gqTb/hZ6LJBscl3iK45670PBQt1cMPTbxfWvq9az2JvZZDe62AVe23Ps3reMmUsyJwAELyVtSBod7vRwH2LoeYOBzx5xT+HuvQnqjmOfdDq9imhuw9za0aV2E/D8j+Nx7Bey1bX6n8N9VKp+oomGrRF5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746914567; c=relaxed/simple;
	bh=rNLQxc3UwLA63h/66fm93Lq+bcmTs3chXk8uhejlJKc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=saYT1222+ckfVopVlAXglgh7tqjShhvRggAlODeeFrU+SxR/vJKjoArJmLY5KCeleR/W/UR9oRNTUP0gehXamuzwde/AzzKFOYp4O4UyBcCkYCXQS+wek4MrRJEtOc9Rr0QM4zGGFODIHFYxI752VE0dQKFc5u7iA9s0JdEr38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQJzra9J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQJzra9J"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0ac853894so2768110f8f.3
        for <git@vger.kernel.org>; Sat, 10 May 2025 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746914563; x=1747519363; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQfjF/s2gFH2fbTZzIn5/8PpbqPg+trnUX/BhuLb/fU=;
        b=SQJzra9J6Tv3v+vpVmcAF22j5GNGDiSN5Kc6AlYMjugc1HG8eamAkU7qXb6npBnj+4
         khDhwlV/0juJg7kDiPwP65A1OGu9NXfa6ilDU34+8hMdeN6wXmw8m9QwjSfsplV63Xw2
         OJURM/iCywNzZZbjE54II1I54zFvJP3n2/29DU0D9y/CIc6ktLCi6ba9vRr2N2BY1djW
         VabV6rXuxFveTst88gfqbejuI3NBTiO0YkgCz0FPVEEmTagzAu3orSFLFG7tqnJXDNo5
         dbiF14M6FPAibdUsam8NxgHmDsfzMn53Vm1E++8Aqxb75/GrYaYKMpYbUYe1f2l0gF6H
         FydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746914563; x=1747519363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQfjF/s2gFH2fbTZzIn5/8PpbqPg+trnUX/BhuLb/fU=;
        b=gZWF6HAvfNaYc5oha1+K+mhuo6phg9ucUnlK0IyxEmuO8yx+SbiCzk5lk1qC48Sn5i
         5kBjoInB2dTjmE2o03lIFXejjXIjJAnPicXyDH+L4P1s6hpXFsg0zJaGGJdrQ9cGv2Ul
         B3Qyr+J81tBRceFhRXg8K2S4I1LWUwv9rAk3IeTw+D/wwgRb7EFRKRDeKIVKehg5xD2T
         cQUpMtzvXmu3k5tL59fSSzVRz+vbMiFhDXVeY2w45BvHgXOWJBil1FXTIkk/b97FszQ4
         AsBLh/Hrsn4/0QWFpCWxknGQv6UEO8h8NqW28T1OpuEYatyElxSWms84RKJiGsKs7mnL
         VA5Q==
X-Gm-Message-State: AOJu0YzKIGVMaEaKCxeASyCEmTfxV/hlgIURKAVquofkdEYLar1XE21R
	pAb7v03WA1FmIgfDlZSperq6jhC1+Zgl6xTukPFBSmrqw7F35MThr54dZQ==
X-Gm-Gg: ASbGncvhkSF4GFi0ayOaL8XSnV+wCyVgd1tZOg+hJA1ZzELPLyJVNAU4WLSwiMrVVNV
	5fc8y53wqTpfBj9CQutUb9x542HYU+4yravAT/qCmyzEvYiVtef4oIesHBPniuTW+nZj5yIUIw1
	zq3JxjE7P5nugHQaZJxGzCpeKkLy4oGj2/6psqgYwOykr7naR40nhby/DoJPzbMYuCitYPlNXxR
	b5SuhQQdHSPFPJT3Zw/Mtp1WNya4kTpKLXHhF8LWjmZlD3/tHQKW/Q/MxgdUlA3ske66PzNdizq
	quEvfDdgM9Ys0Eygn6zw2kH+QfYvEG9Ua05KraD3MlDdzpzo6Ip/
X-Google-Smtp-Source: AGHT+IFZsjO0yaXWefLqAQF6fDSL3VIf2/MiV7uxVq8IJpl/6QuqMr6ut/wfBmJ5UdZZWnoyz/mMyA==
X-Received: by 2002:a05:6000:3113:b0:39c:1f0e:95af with SMTP id ffacd0b85a97d-3a1f64279d3mr6819007f8f.3.1746914563339;
        Sat, 10 May 2025 15:02:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde27sm7670106f8f.17.2025.05.10.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:02:43 -0700 (PDT)
Message-Id: <09292804cffc41d15f1156e0b4bba4cba7ec7ca4.1746914561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 May 2025 22:02:40 +0000
Subject: [PATCH 1/2] merge-ort: add a new mergeability_only option
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

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new mergeability_only option.  This
option allows the merge machinery to, in the outer layer of the merge:
  * exit upon first conflict
  * avoid writing merged blobs/trees to the object store

Note that since the recursive merge of merge bases (corresponding to
call_depth > 0) can conflict without the outer final merge (corresponding
to call_depth == 0) conflicting, we can't short-circuit nor avoid
writing merges blobs/trees to the object store during those inner
merges.

There is a further potential micro-optimization here.  rename/rename
conflicts have the potential for nested conflicts even without recursive
merges; because of that, handle_content_merge() can be called multiple
times and is done via different paths.  Currently, we only exit early in
process_entries(), which is where the final handle_content_merge() is
invoked.  Since rename/rename conflicts have an additional earlier
handle_content_merge() call that can be invoked from
detect_and_process_renames() (via process_renames()), we could
potentially exit earlier at that call point.  However, rename/rename
conflicts are exceptionally rare, and feeding the extra logic through
didn't seem worth it.  (And, if we don't exit early at that point, then
any resulting blobs need to be written to the store so that subsequent
handle_content_merge() calls trying to use the blob don't throw
exceptions.)

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

