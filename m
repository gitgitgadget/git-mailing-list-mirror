Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A17343D86
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 00:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718405; cv=none; b=fzhoFo2G3ekm+FW9TxQjO4FfRC0RebDmxpP7NZ+LQjge/5o+pV7n61WSP7+ntgNepT7NRo2M07QVKeV6cDyLCfzukuYH3JM4D9zVc8rRF3zhweDZzDpSRRGfh67H91w6/NQlK4pUbdtzHRiivaCCWffaGFlcRy5gKfzZHyDKe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718405; c=relaxed/simple;
	bh=1WAn7A08HTgyyKZPMf16hOcd1KE5La6wyPADL4lC3gU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mbd/cmUGtLlpvzLswWOhJrBhONTvfTSCZsKqxauM0godXnFOIRroFptj9t9ht3CJwC2Y/AVrf0HGviB4txzmmfZzhrCBQWe1AeGbG/WgXBLTixs9aB4xQdR+VZVNj9ZqNYSTJmQOTX3T+XhyDuAquwt9wZG6EmALW0DMpNk/u8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ehq0/Z2C; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehq0/Z2C"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8954ae375efso36235606d6.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718401; x=1772323201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U616UkX3lMH0Prd5EFHfJMUuXwO3IYEwx3WFkpgWspQ=;
        b=Ehq0/Z2CkX4zoC0Xv2btlBspygRGPEGwOOV7EMzD1pUVDJ8EgVilhVUZCsX4s8rXeR
         LXOrPT0t7AOqZ7///4AGV75iRx1GRES52zrhJCT3nl+Zq44YW5n/wKfXZh/6MXsPpDUh
         7b2+Ym1TvlnIyNs/CGQo4AAnYUMBPGtD0UH+eU9eIxolBWXcozd8yF4n5ucFoMvzmwnH
         z/EcSt8sZzQEWPVL2TTaF/AE1Pz7Nk1C4gcLcTMUnLmwo9ga1l2U073gO9oK0qDXsHU9
         A1pfdEIsLVhIWtkGhLQq0rKKtCnPUTMH96jngCBzlwtAR6k8rfkrW7BQpFxSH+edDAFC
         Y+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718401; x=1772323201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U616UkX3lMH0Prd5EFHfJMUuXwO3IYEwx3WFkpgWspQ=;
        b=QLxcPVaysVdTR5016bvqufWuX4kYO2x0sUJPXYbsgjOCLtxe4T/olFh/pRcYeJIM0x
         1PV8vz4A+oVuhTDIaPAh5YBGgjsahlkNYqsShHBwHvffUiCRpxdc2AUcKMEfDbfCOElt
         VeQEQziCw78w4sIKx6z//hCpsQCgPC2xZ49cMs4KPgQriGWgrKWOFSgkL+k5vu0ER8DY
         AejJj4f5iQn2qFurC0M/Xev5VX8DdOHKAUAVPFbbY+YYEVxGwtS8z7NZhmqZixaKAOMW
         dG1BRZYyK0bpdveIECbGFx+uZUwlVQtG6JLeOJ3DgOyLGXKYiMfIffMZF6jOmv6PXooX
         dB8g==
X-Gm-Message-State: AOJu0Yx8WOl/CS+JDgZO398HI8QMVDRY6gt/TBK6KdWEy7vTnyfASjMP
	9xkZZOexwJurHHbyUg0uJOyzlYvAU0uSSfJPUDdyj3Srb79S4zBWOFYZ1E8Xaw==
X-Gm-Gg: AZuq6aLJgK5+v8Gbhw7iahQ5K+0nuRsj5r+YjsLGenhilNe1d6bYf1JEpzal1eb1mPH
	gd0lEgR9cSTRCH8Tuk+FNUzGVaoO6RnOg+7orlhmVVz8+uae/mAGM4sfD9UWwSzjQ7F0F0OOSof
	ugs1NxE3QYdrQVtyecftsdjheaSxkrwK/yYEy8Jwfpz+4Avh/MciZr8Yzj5mLakq/DjePaY4KPc
	TCInLjz2byIP0SBmZNQCw8jN3RI+TvMzcD40JFlV3z0yVrZLJ0JSTPGCbwYd7f6vxiABKEk19ZC
	mP5owp4dpYRF8ZqDHcCFHmtRlvP9MocsSYKprJ9A3RGx6DZK1SLxkC4xnm9pzD9YblDXUwO8kMS
	nXzYY1Gmn4Me1WsQhbBGwqFf0kVGZDLR/BW1Ry9kzxL9AwfNcjRirr0b1b0q3nqeSYhL+KPQLbb
	q4BYSwYbDTTebuHMhtYl+KY9XE
X-Received: by 2002:ad4:5beb:0:b0:880:5249:be3e with SMTP id 6a1803df08f44-8997a87d39dmr67571136d6.13.1771718400893;
        Sat, 21 Feb 2026 16:00:00 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62fd3dsm28555476d6.39.2026.02.21.16.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:00:00 -0800 (PST)
Message-Id: <09076d81b671c4c5a7582ff23163c4edba912cb6.1771718393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:51 +0000
Subject: [PATCH v3 4/6] merge-ort: replace the_hash_algo with
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

