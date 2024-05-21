Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B4149E1B
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318173; cv=none; b=e0polBI/ypM2zNI5DCQgi/+jRtQdgtV56Y892cEuMuNhPUbREmxz7U7dMJyhXCCKvY0lVlDeo9qm6VYWQcS3ZqGKF9GtGzwIbuTbIlwVScD/1ZgDUkStT24eT3OUkjR+IGv0TW5+eRvmgIzrYcP3DXWq75ODMRsrnRrAkeL3wWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318173; c=relaxed/simple;
	bh=GS7ETYlZZ3CaQiQxjdUEfAOozKTCPoH/xp1LHtPAaH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H21XNoNnC02FWSHxfP8Gnmfh1cmSIlAHHEetkMPZvNm2YU2cs02hsk84fKKh4cMzaqkTJFuulaCb0LYLWYmi1oRHIGceloUHh9P6bIroul12V4ZYOZscsoCZEaXg4MkD47s10ZXKFYRntmz0MoCySyRyxNKqfchstyKwF9zLMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lD9bTtOW; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lD9bTtOW"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-23ee34c33ceso1954164fac.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318170; x=1716922970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwNBCtxGkzIA0ESquA+d83YILY/XN3+X4GtvrWe7Zzk=;
        b=lD9bTtOWfxZVHj2X6gmu0urAIqUP7fv7fa68aWmjVWNFpmNQB0H4WMEgAWTfgr4XeG
         8kXXf/3z0j+vu9p0DxbtDb2ZlW4BL3dcPxxlILNg6xhAkqZzM1B7pUymgOYeYdK6jHxk
         /XuuuaOSdwVlSHivXrBnZH3f8jxk7TdaRipeUqlCMKo/LPeZqJom8Kx2PM3zDOKaqAW/
         qBZQRCln0TWgnaQQDvaW+DkanwrFIEHMvOoXZsUVBGlLUDEQpfH+q1ooUUHsLz/2x36g
         UqOIVquULnPPSLLzJK2NbuGWjLFj+8iW25vGXbeB1GXSt/fj5etkATWezPYSgmhyTnqg
         y+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318170; x=1716922970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwNBCtxGkzIA0ESquA+d83YILY/XN3+X4GtvrWe7Zzk=;
        b=E9KocRj0PzVwVqvpyMTfBRNQ/11rItMVldjYro2cdHdYefcWso8ApHouGaaphxOy6y
         +xPdQlNDaAPYkU7ZnohTlNa9XHThb4DVx+lQdleQTiL1qB76KvxXn1uyJqzxuNWJLV+M
         x68p4xmtTZj2AcMlP+a6XGyk8RzglKOM4rGH1StQf6E1QTpeIp1NnWNK6LFTVtwT0cli
         9h8QbSPrBZYGS/R3wnCk6dMYvkatft8NMqzKHnhj2P0mCaUj1GIpsGOXk4CZLLa/cLab
         tpabNYYE2nzvEmc+M/t/FaEPUc8cXmXX9Ots7tQ/HQrsa5xog3Hynep+tjYSbzbivBgK
         TbgQ==
X-Gm-Message-State: AOJu0YxkN/gLn4tYUToZLIimaGkZDO7CopEHfs5qxDMzCgpEC5cauFuc
	MA5ilWuhywpUyWi0MItTRA7yiSuiBQhzyEN4Mhz5hEbWoqQj+f/WzxpEDWAMI3laxydXeKPur4R
	B
X-Google-Smtp-Source: AGHT+IGz0hSnUodJAUoLeAH0VmxwlsP2qMjSzExztR6W8L7ohQcEJCUTRmXhP8ACL1+4pPoZNEmazA==
X-Received: by 2002:a05:6870:b41d:b0:24c:58e4:976e with SMTP id 586e51a60fabf-24c68b3dddcmr11724fac.29.1716318170374;
        Tue, 21 May 2024 12:02:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1872f8sm126092546d6.55.2024.05.21.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:49 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 22/30] pseudo-merge: implement support for reading
 pseudo-merge commits
Message-ID: <8ba0a9c5402fb154bc316768a8fbb016e302a686.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Implement the basic API for reading pseudo-merge bitmaps, which consists
of four basic functions:

  - pseudo_merge_bitmap()
  - use_pseudo_merge()
  - apply_pseudo_merges_for_commit()
  - cascade_pseudo_merges()

These functions are all documented in pseudo-merge.h, but their rough
descriptions are as follows:

  - pseudo_merge_bitmap() reads and inflates the objects EWAH bitmap for
    a given pseudo-merge

  - use_pseudo_merge() does the same as pseudo_merge_bitmap(), but on
    the commits EWAH bitmap, not the objects bitmap

  - apply_pseudo_merges_for_commit() applies all satisfied pseudo-merge
    commits for a given result set, and cascades any yet-unsatisfied
    pseudo-merges if any were applied in the previous step

  - cascade_pseudo_merges() applies all pseudo-merges which are
    satisfied but have not been previously applied, repeating this
    process until no more pseudo-merges can be applied

The core of the API is the latter two functions, which are responsible
for applying pseudo-merges during the object traversal implemented in
the pack-bitmap machinery.

The other two functions (pseudo_merge_bitmap(), and use_pseudo_merge())
are low-level ways to interact with the pseudo-merge machinery, which
will be useful in future commits.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c | 231 +++++++++++++++++++++++++++++++++++++++++++++++++
 pseudo-merge.h |  44 ++++++++++
 2 files changed, 275 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 1aca70ecdfb..0f50ac6183e 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -10,6 +10,7 @@
 #include "commit.h"
 #include "alloc.h"
 #include "progress.h"
+#include "hex.h"
 
 #define DEFAULT_PSEUDO_MERGE_DECAY 1.0f
 #define DEFAULT_PSEUDO_MERGE_MAX_MERGES 64
@@ -464,3 +465,233 @@ void free_pseudo_merge_map(struct pseudo_merge_map *pm)
 	}
 	free(pm->v);
 }
+
+struct pseudo_merge_commit_ext {
+	uint32_t nr;
+	const unsigned char *ptr;
+};
+
+static int pseudo_merge_ext_at(const struct pseudo_merge_map *pm,
+			       struct pseudo_merge_commit_ext *ext, size_t at)
+{
+	if (at >= pm->map_size)
+		return error(_("extended pseudo-merge read out-of-bounds "
+			       "(%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)at, (uintmax_t)pm->map_size);
+
+	ext->nr = get_be32(pm->map + at);
+	ext->ptr = pm->map + at + sizeof(uint32_t);
+
+	return 0;
+}
+
+struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
+					struct pseudo_merge *merge)
+{
+	if (!merge->loaded_commits)
+		BUG("cannot use unloaded pseudo-merge bitmap");
+
+	if (!merge->loaded_bitmap) {
+		size_t at = merge->bitmap_at;
+
+		merge->bitmap = read_bitmap(pm->map, pm->map_size, &at);
+		merge->loaded_bitmap = 1;
+	}
+
+	return merge->bitmap;
+}
+
+struct pseudo_merge *use_pseudo_merge(const struct pseudo_merge_map *pm,
+				      struct pseudo_merge *merge)
+{
+	if (!merge->loaded_commits) {
+		size_t pos = merge->at;
+
+		merge->commits = read_bitmap(pm->map, pm->map_size, &pos);
+		merge->bitmap_at = pos;
+		merge->loaded_commits = 1;
+	}
+	return merge;
+}
+
+static struct pseudo_merge *pseudo_merge_at(const struct pseudo_merge_map *pm,
+					    struct object_id *oid,
+					    size_t want)
+{
+	size_t lo = 0;
+	size_t hi = pm->nr;
+
+	while (lo < hi) {
+		size_t mi = lo + (hi - lo) / 2;
+		size_t got = pm->v[mi].at;
+
+		if (got == want)
+			return use_pseudo_merge(pm, &pm->v[mi]);
+		else if (got < want)
+			hi = mi;
+		else
+			lo = mi + 1;
+	}
+
+	warning(_("could not find pseudo-merge for commit %s at offset %"PRIuMAX),
+		oid_to_hex(oid), (uintmax_t)want);
+
+	return NULL;
+}
+
+struct pseudo_merge_commit {
+	uint32_t commit_pos;
+	uint64_t pseudo_merge_ofs;
+};
+
+#define PSEUDO_MERGE_COMMIT_RAWSZ (sizeof(uint32_t)+sizeof(uint64_t))
+
+static void read_pseudo_merge_commit_at(struct pseudo_merge_commit *merge,
+					const unsigned char *at)
+{
+	merge->commit_pos = get_be32(at);
+	merge->pseudo_merge_ofs = get_be64(at + sizeof(uint32_t));
+}
+
+static int nth_pseudo_merge_ext(const struct pseudo_merge_map *pm,
+				struct pseudo_merge_commit_ext *ext,
+				struct pseudo_merge_commit *merge,
+				uint32_t n)
+{
+	size_t ofs;
+
+	if (n >= ext->nr)
+		return error(_("extended pseudo-merge lookup out-of-bounds "
+			       "(%"PRIu32" >= %"PRIu32")"), n, ext->nr);
+
+	ofs = get_be64(ext->ptr + st_mult(n, sizeof(uint64_t)));
+	if (ofs >= pm->map_size)
+		return error(_("out-of-bounds read: (%"PRIuMAX" >= %"PRIuMAX")"),
+			     (uintmax_t)ofs, (uintmax_t)pm->map_size);
+
+	read_pseudo_merge_commit_at(merge, pm->map + ofs);
+
+	return 0;
+}
+
+static unsigned apply_pseudo_merge(const struct pseudo_merge_map *pm,
+				   struct pseudo_merge *merge,
+				   struct bitmap *result,
+				   struct bitmap *roots)
+{
+	if (merge->satisfied)
+		return 0;
+
+	if (!ewah_bitmap_is_subset(merge->commits, roots ? roots : result))
+		return 0;
+
+	bitmap_or_ewah(result, pseudo_merge_bitmap(pm, merge));
+	if (roots)
+		bitmap_or_ewah(roots, pseudo_merge_bitmap(pm, merge));
+	merge->satisfied = 1;
+
+	return 1;
+}
+
+static int pseudo_merge_commit_cmp(const void *va, const void *vb)
+{
+	struct pseudo_merge_commit merge;
+	uint32_t key = *(uint32_t*)va;
+
+	read_pseudo_merge_commit_at(&merge, vb);
+
+	if (key < merge.commit_pos)
+		return -1;
+	if (key > merge.commit_pos)
+		return 1;
+	return 0;
+}
+
+static struct pseudo_merge_commit *find_pseudo_merge(const struct pseudo_merge_map *pm,
+						     uint32_t pos)
+{
+	if (!pm->commits_nr)
+		return NULL;
+
+	return bsearch(&pos, pm->commits, pm->commits_nr,
+		       PSEUDO_MERGE_COMMIT_RAWSZ, pseudo_merge_commit_cmp);
+}
+
+int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
+				   struct bitmap *result,
+				   struct commit *commit, uint32_t commit_pos)
+{
+	struct pseudo_merge *merge;
+	struct pseudo_merge_commit *merge_commit;
+	int ret = 0;
+
+	merge_commit = find_pseudo_merge(pm, commit_pos);
+	if (!merge_commit)
+		return 0;
+
+	if (merge_commit->pseudo_merge_ofs & ((uint64_t)1<<63)) {
+		struct pseudo_merge_commit_ext ext = { 0 };
+		off_t ofs = merge_commit->pseudo_merge_ofs & ~((uint64_t)1<<63);
+		uint32_t i;
+
+		if (pseudo_merge_ext_at(pm, &ext, ofs) < -1) {
+			warning(_("could not read extended pseudo-merge table "
+				  "for commit %s"),
+				oid_to_hex(&commit->object.oid));
+			return ret;
+		}
+
+		for (i = 0; i < ext.nr; i++) {
+			if (nth_pseudo_merge_ext(pm, &ext, merge_commit, i) < 0)
+				return ret;
+
+			merge = pseudo_merge_at(pm, &commit->object.oid,
+						merge_commit->pseudo_merge_ofs);
+
+			if (!merge)
+				return ret;
+
+			if (apply_pseudo_merge(pm, merge, result, NULL))
+				ret++;
+		}
+	} else {
+		merge = pseudo_merge_at(pm, &commit->object.oid,
+					merge_commit->pseudo_merge_ofs);
+
+		if (!merge)
+			return ret;
+
+		if (apply_pseudo_merge(pm, merge, result, NULL))
+			ret++;
+	}
+
+	if (ret)
+		cascade_pseudo_merges(pm, result, NULL);
+
+	return ret;
+}
+
+int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
+			  struct bitmap *result,
+			  struct bitmap *roots)
+{
+	unsigned any_satisfied;
+	int ret = 0;
+
+	do {
+		struct pseudo_merge *merge;
+		uint32_t i;
+
+		any_satisfied = 0;
+
+		for (i = 0; i < pm->nr; i++) {
+			merge = use_pseudo_merge(pm, &pm->v[i]);
+			if (apply_pseudo_merge(pm, merge, result, roots)) {
+				any_satisfied |= 1;
+				ret++;
+			}
+		}
+	} while (any_satisfied);
+
+	return ret;
+}
diff --git a/pseudo-merge.h b/pseudo-merge.h
index a3f0243062c..c00b622be4b 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -162,4 +162,48 @@ struct pseudo_merge {
  */
 void free_pseudo_merge_map(struct pseudo_merge_map *pm);
 
+/*
+ * Loads the bitmap corresponding to the given pseudo-merge from the
+ * map, if it has not already been loaded.
+ */
+struct ewah_bitmap *pseudo_merge_bitmap(const struct pseudo_merge_map *pm,
+					struct pseudo_merge *merge);
+
+/*
+ * Loads the pseudo-merge and its commits bitmap from the given
+ * pseudo-merge map, if it has not already been loaded.
+ */
+struct pseudo_merge *use_pseudo_merge(const struct pseudo_merge_map *pm,
+				      struct pseudo_merge *merge);
+
+/*
+ * Applies pseudo-merge(s) containing the given commit to the bitmap
+ * "result".
+ *
+ * If any pseudo-merge(s) were satisfied, returns the number
+ * satisfied, otherwise returns 0. If any were satisfied, the
+ * remaining unsatisfied pseudo-merges are cascaded (see below).
+ */
+int apply_pseudo_merges_for_commit(const struct pseudo_merge_map *pm,
+				   struct bitmap *result,
+				   struct commit *commit, uint32_t commit_pos);
+
+/*
+ * Applies pseudo-merge(s) which are satisfied according to the
+ * current bitmap in result (or roots, see below). If any
+ * pseudo-merges were satisfied, repeat the process over unsatisfied
+ * pseudo-merge commits until no more pseudo-merges are satisfied.
+ *
+ * Result is the bitmap to which the pseudo-merge(s) are applied.
+ * Roots (if given) is a bitmap of the traversal tip(s) for either
+ * side of a reachability traversal.
+ *
+ * Roots may given instead of a populated results bitmap at the
+ * beginning of a traversal on either side where the reachability
+ * closure over tips is not yet known.
+ */
+int cascade_pseudo_merges(const struct pseudo_merge_map *pm,
+			  struct bitmap *result,
+			  struct bitmap *roots);
+
 #endif
-- 
2.45.1.175.gbea44add9db

