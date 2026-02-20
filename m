Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911323BD02
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552797; cv=none; b=LRVt2D2ctNffX9CMmkXqA7DKw2KD3LLxoOa1hE6pQPFkUzfZmwSNWB0/AaVOd0gJJYKb7ZzB01shbjjfiV2PJfK86Nc5i8znJDA/QGzIzLn4XttvJM1n/icxCpS9VG83zyeK+QXFLazlv5t0gSj278b2GB1xhZnV+Wehwv2mcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552797; c=relaxed/simple;
	bh=1WAn7A08HTgyyKZPMf16hOcd1KE5La6wyPADL4lC3gU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EVay/bf61YgXZgGTczTik4Iox6657Bex3OtLB21dypRlAroi2j79HqVdpcGjHzEQH9Tm4r56UVS+mX6O+jRRqj/QqY9qj/GxYgiWtAu26/k6PApp6khHCs0+dc+7OW2e//KstVjWKDFmBFyjqzQULBKrVUxk40i8n+sz3Iigtts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMgEhhSo; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMgEhhSo"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so1326109c88.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552795; x=1772157595; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U616UkX3lMH0Prd5EFHfJMUuXwO3IYEwx3WFkpgWspQ=;
        b=UMgEhhSogbAWayxd8RalVmQWDWGCzBr0zc1sp0NaTibMPl92MYjDYCmKbhJgDtdGQY
         UjNfzNMQjtB9JJ4FEuqkRm3jXS2pjzTWjNlZWCEDaKnYZWomRv4TRSrGXYHmLuEWrFfn
         pRj8t1WMw2bNSzbIeLuyfsCb9bPDaW743BFXx3IDDJCpCcZhJaxwYaS6hvv+6pM0+AuZ
         bxxmO8QTIR8DYu8r86XgiW+2+fxR2RtBXSHzdLOpWsihv/ezR+7LPQUGtbd5BT8gYAyq
         wydMTaojFL7LAzxdRS0o6FbXsHAzQY8emYuel+77+IlEjMWNv3Q4Xr+hRqDvoVQWNvqe
         GZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552795; x=1772157595;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U616UkX3lMH0Prd5EFHfJMUuXwO3IYEwx3WFkpgWspQ=;
        b=drcCS8nSKr7F2JYhzrAJlAlBxPEyFdUMRAVCnOyAygbMD4hkxAmldvLoGgsUWg+nn7
         qLQdFkPUZL5p6856sX9JPJETqC/bapOp277ANsDswzpye3bMx5u5Vls66I0u4sWRUJqN
         PCZ89UBYpGnOu4wVW2pLqog006rSZeHotln+4zEAs5Eba/yzPivOp64OCUY/PfAaiBza
         jv0of5NV4BFOq0q4qBzvYGSwrKhzjqnYxNmLYdDTCGo2yxSDXqia/WSA4Tg0hrIdNnac
         +6TV5nOzCoUFhOxBct8RZQXgRTCzIHQwDXZ9O+dOa+0Hu7kPgtGKqNCR+cUzALFzKo2M
         mCFQ==
X-Gm-Message-State: AOJu0YwpSHO5yZadal9eOZQjSBoPGVi3msT2ixgCICPz322JxAaj6Zjs
	oiLjIS3w7MyqxF59B9nd9xlms9i0uSdJdAWsPN04T5RoznKZ4665YzM08JgvVBhI
X-Gm-Gg: AZuq6aJ2nTPLVrFT6qCaSfbMSxQ33/4g+/k81d/u+vncDxOJ+jwAI1P5hlnp26JkMTK
	W7KYs9LVaYm2VvECbKoDdXMONu5+UBin7TCSyOX6GHOc+K6VipfPCiQ8h7luYJFUGJVg7F45FEa
	d2QdUWw75rcArqhHw1Cc5RoIuF5rNG4Q0ueuZRegZR+yhX6rx6mPBroQ2Jpw97H/MlNNWAOza2+
	sN7a76IRBQdeDtPW4vOhGGkJ6GUnQhEbraU6MjxaW4Eqlremm+1yN1XsO3ZmrIq9O8gH1W9m4TH
	ge1Q7jG/kvRqrt0czG7f9/QWM2o4bHrypHHTr6qwxjXtXSYUMqdV5dUVVHRmF9W27mfzEk3iXyZ
	MIe/9kI6/m/GTg/TWNVItoTGxg43291PeZkAYKcBhUhj4rM//ovG0VZTGv8MB4OzQ1TFsLJBJ1L
	kQFl2IYDrf5ADFY+eq/h0BiDgW6Tic91lVR0Is
X-Received: by 2002:a05:7022:6285:b0:127:369f:60c4 with SMTP id a92af1059eb24-1276609cb3cmr32819c88.49.1771552795075;
        Thu, 19 Feb 2026 17:59:55 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742b62274sm30285865c88.3.2026.02.19.17.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:54 -0800 (PST)
Message-Id: <bfa68716af2c931817761a812d8ad825a56cec5a.1771552788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:46 +0000
Subject: [PATCH v2 4/6] merge-ort: replace the_hash_algo with
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

We have a perfectly valid repository available and do not need to use
the_hash_algo (a shorthand for the_repository->hash_algo), so use the
known repository instead.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9b6a4c312e..60b4675f39 100644
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

