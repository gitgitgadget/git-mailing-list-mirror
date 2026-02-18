Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C24E33A9DC
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406126; cv=none; b=N8PYaJ5Pb3d6tYHRwXgs5YwZpS18puHR2XsILO52Tnw2WtVQsp+ETXsA2E38+jk3b/tSibG8OXYD8HLbgS7aKWUGjTXacRfgngWYcKOZNBf3VxWmvZPGXbxqgSGrtR6JMoPBJNuibD32LkCArWjeB8Tdx7VyCRqUZadvqGRzAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406126; c=relaxed/simple;
	bh=22B/Ma4WM0ND2p3Cq82QkYq/aK6aJxMQL379sUWdSxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q918c8UTFyv9JHXo1MDrcRP/BagyWm0l/p0lhJcN22xiHr0kZoccYEIZKLegmKjSyCZrkA5tr/S+OHD3eaVcP8nF/VRu2t7aeW3b8jPgmh2BwHsr6hPs+jmsaRxtywvLo06n1ewPBMALxBm5CZnhnvXWekcC/8fEmRjgeQx+NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDt9Mefo; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDt9Mefo"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5951926eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406121; x=1772010921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBV1KNm6HSYEjVGbBxyYRS1RyXgb0tfxpCuMYhEp/9A=;
        b=CDt9Mefo9QhrnVtreEgbTG6khQeYjAadmVAnJ7duNLYOlTBL0vyFfAkVeHLs1x0Rib
         90sRM5XDT6MjNMIN05s3nLLZ4VLBtdQLCw47Tcl26YXXa5nY1LVRsGWECND/yVzSbGGO
         viWayBPunyy2/+6cO5tF1eiuJq9pSBZ4WmHvzd1BpK2zG8AM0XOmL8hiTvihXGEw2Fxk
         E4EVGj+S2P5FtCrr9HIW/kznyXbEA7f1j9wRA41Qu7OAsu25PHF8Hm336W2nEekqF9Xk
         LG9D3UW4kh0+2FtqHY0+B2Q38Wqv3GDFOk/e4HLuuVVSvuKn4N4e1BSvWVocqSPfM7F+
         RSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406121; x=1772010921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vBV1KNm6HSYEjVGbBxyYRS1RyXgb0tfxpCuMYhEp/9A=;
        b=GkANXMSONl+94ekcPp6bpfKDikL2aYfHeZvsK8o0P1sg+/oT9F0pVZrJv8kspJJqvB
         b7V4olc5ATQjI2t0YppSQ6Q3bi93/Ut2NAD/qCt2geUROQwWm+uD2597+GCQIU9ha6XC
         kvhdmgTE1Q8O3zbtXpcMQ+yIplSYLNcxVtuV+fvN6/Yf0ehuzMPBjTK99ISSWTVabrNI
         STGj52eb1ZG0iAcpQd0WIDtvJdtpT4+2EwOU/R8VzKH3OUvGlIi2nohZ6SdeVdSkInsK
         T8FTlvL2Gw2Se8FNc5BqVEjPZHkUOO4UXxkzlWo6nwXZKSe/6NUT6FTD+6P7gh+hipFW
         a7Aw==
X-Gm-Message-State: AOJu0YzhaNoOodpoRDFbekE6f0HLAFIenlMdeOGCOfirmfH56ANYsnH/
	qOZ8/7V0OFFPylJk+rCAh8HyY2lgr3ugwSSegs+T3HgAu7zENQv9fyA1syaxvA==
X-Gm-Gg: AZuq6aIGRU68hhMQQdfLuGKScUeFcb3Te97bLQx+LjQfe8ZtndnG8jnSwRi3q5XOQCx
	ZyzpWOeM1VWzpHsLBptcXiZaRSzqeQGQ0+pIQ09LRRx8zyrw3PrgQK2LyReanxQvYQXD6BO5VL2
	S2j2ZX4CLPdSdthOkQXjJpV6uBjcNUPvT+WyAy0wP8Ikxsm5O/rQtpPcEMg4ShuaiayhDh+VegL
	O34wXPe28HViNLs2eCL2BhbmI9RoGjrEGVLypGsRvqtdh1BhldVjNvapl3Jhk8/8OBVOrWHcRdh
	8aDdK+UtmpaqIAyq52R2RsyrYttIauE1cua6vCPyEXWa/RILLHmvm3839miD8dOpYdjfJdAPNkS
	DqcWcTeaVmlumKJ9vwD9GGE06lipxsYfiN9uedAfi2xRQgt5YdLbXay4hkUM9ijfHKghJx+JPm+
	NEqTbJBenz9qRsGpNrWIRNhZDCEQ==
X-Received: by 2002:a05:7022:62a0:b0:11f:2c69:31 with SMTP id a92af1059eb24-12739850ed5mr8583180c88.46.1771406121357;
        Wed, 18 Feb 2026 01:15:21 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb67b638sm18060303eec.31.2026.02.18.01.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:20 -0800 (PST)
Message-Id: <36c2713ceb305f17295c4e8b38dbf252dc641128.1771406115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:13 +0000
Subject: [PATCH 3/5] merge-ort: replace the_hash_algo with
 opt->repo->hash_algo
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2106c5f632..40a11dca73 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1857,7 +1857,7 @@ static int merge_submodule(struct merge_options *opt,
 		BUG("submodule deleted on one side; this should be handled outside of merge_submodule()");
 
 	if ((sub_not_initialized = repo_submodule_init(&subrepo,
-		opt->repo, path, null_oid(the_hash_algo)))) {
+		opt->repo, path, null_oid(opt->repo->hash_algo)))) {
 		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (not checked out)"),
@@ -2240,7 +2240,7 @@ static int handle_content_merge(struct merge_options *opt,
 		two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 
 		merge_status = merge_3way(opt, path,
-					  two_way ? null_oid(the_hash_algo) : &o->oid,
+					  two_way ? null_oid(opt->repo->hash_algo) : &o->oid,
 					  &a->oid, &b->oid,
 					  pathnames, extra_marker_size,
 					  &result_buf);
@@ -2272,7 +2272,7 @@ static int handle_content_merge(struct merge_options *opt,
 	} else if (S_ISGITLINK(a->mode)) {
 		int two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 		clean = merge_submodule(opt, pathnames[0],
-					two_way ? null_oid(the_hash_algo) : &o->oid,
+					two_way ? null_oid(opt->repo->hash_algo) : &o->oid,
 					&a->oid, &b->oid, &result->oid);
 		if (clean < 0)
 			return -1;
@@ -2786,7 +2786,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		assert(!new_ci->match_mask);
 		new_ci->dirmask = 0;
 		new_ci->stages[1].mode = 0;
-		oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_algo));
+		oidcpy(&new_ci->stages[1].oid, null_oid(opt->repo->hash_algo));
 
 		/*
 		 * Now that we have the file information in new_ci, make sure
@@ -2799,7 +2799,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				continue;
 			/* zero out any entries related to files */
 			ci->stages[i].mode = 0;
-			oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo));
+			oidcpy(&ci->stages[i].oid, null_oid(opt->repo->hash_algo));
 		}
 
 		/* Now we want to focus on new_ci, so reassign ci to it. */
@@ -3214,7 +3214,7 @@ static int process_renames(struct merge_options *opt,
 			if (type_changed) {
 				/* rename vs. typechange */
 				/* Mark the original as resolved by removal */
-				memcpy(&oldinfo->stages[0].oid, null_oid(the_hash_algo),
+				memcpy(&oldinfo->stages[0].oid, null_oid(opt->repo->hash_algo),
 				       sizeof(oldinfo->stages[0].oid));
 				oldinfo->stages[0].mode = 0;
 				oldinfo->filemask &= 0x06;
@@ -4102,7 +4102,7 @@ static int process_entry(struct merge_options *opt,
 			if (ci->filemask & (1 << i))
 				continue;
 			ci->stages[i].mode = 0;
-			oidcpy(&ci->stages[i].oid, null_oid(the_hash_algo));
+			oidcpy(&ci->stages[i].oid, null_oid(opt->repo->hash_algo));
 		}
 	} else if (ci->df_conflict && ci->merged.result.mode != 0) {
 		/*
@@ -4149,7 +4149,7 @@ static int process_entry(struct merge_options *opt,
 				continue;
 			/* zero out any entries related to directories */
 			new_ci->stages[i].mode = 0;
-			oidcpy(&new_ci->stages[i].oid, null_oid(the_hash_algo));
+			oidcpy(&new_ci->stages[i].oid, null_oid(opt->repo->hash_algo));
 		}
 
 		/*
@@ -4271,11 +4271,11 @@ static int process_entry(struct merge_options *opt,
 			new_ci->merged.result.mode = ci->stages[2].mode;
 			oidcpy(&new_ci->merged.result.oid, &ci->stages[2].oid);
 			new_ci->stages[1].mode = 0;
-			oidcpy(&new_ci->stages[1].oid, null_oid(the_hash_algo));
+			oidcpy(&new_ci->stages[1].oid, null_oid(opt->repo->hash_algo));
 			new_ci->filemask = 5;
 			if ((S_IFMT & b_mode) != (S_IFMT & o_mode)) {
 				new_ci->stages[0].mode = 0;
-				oidcpy(&new_ci->stages[0].oid, null_oid(the_hash_algo));
+				oidcpy(&new_ci->stages[0].oid, null_oid(opt->repo->hash_algo));
 				new_ci->filemask = 4;
 			}
 
@@ -4283,11 +4283,11 @@ static int process_entry(struct merge_options *opt,
 			ci->merged.result.mode = ci->stages[1].mode;
 			oidcpy(&ci->merged.result.oid, &ci->stages[1].oid);
 			ci->stages[2].mode = 0;
-			oidcpy(&ci->stages[2].oid, null_oid(the_hash_algo));
+			oidcpy(&ci->stages[2].oid, null_oid(opt->repo->hash_algo));
 			ci->filemask = 3;
 			if ((S_IFMT & a_mode) != (S_IFMT & o_mode)) {
 				ci->stages[0].mode = 0;
-				oidcpy(&ci->stages[0].oid, null_oid(the_hash_algo));
+				oidcpy(&ci->stages[0].oid, null_oid(opt->repo->hash_algo));
 				ci->filemask = 2;
 			}
 
@@ -4415,7 +4415,7 @@ static int process_entry(struct merge_options *opt,
 		/* Deleted on both sides */
 		ci->merged.is_null = 1;
 		ci->merged.result.mode = 0;
-		oidcpy(&ci->merged.result.oid, null_oid(the_hash_algo));
+		oidcpy(&ci->merged.result.oid, null_oid(opt->repo->hash_algo));
 		assert(!ci->df_conflict);
 		ci->merged.clean = !ci->path_conflict;
 	}
-- 
gitgitgadget

