Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B7129E9F
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499629; cv=none; b=f3asc3W+14D+ps4pSH8tj4uyYURsSWeZvO5mJoif/VpS0gqNMH5VRa5nTAWFWAmnyuVwieYJu3/UTEjjXVaEv5p4j2ZvV1CpoypnMvSWah4Rj7H1qalfIPIebC3vm048TXP3oKYsJ5+6JsUIFzUaKkdKCzlny0FCDvLaF9K0q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499629; c=relaxed/simple;
	bh=MgMY54PKCLJ/2ma4eddn+9ywHyoqew1NvlnKhaPTnjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ickRQnDAm+IV1V4ioC1JbsVIi7pasFS4UrmPxctUxr+oewht2vlivuRFTtVTC8xJPSLWGf9ynkPHIzRSekcr7rWDDdHSUwvz7Nk9xorTU+St+zvJqai5sXLuTU/nPhwdPdxsePtgUN7vJbZL0WD4rOGsTbo/cM/OwBhmUJ0rFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0o2h7hrv; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0o2h7hrv"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ab8ab4ca0bso10599156d6.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499626; x=1717104426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SWMMbr1Vy/P9Z5zpil6N5cVf+cv/qQ2YuUWCY55/mLE=;
        b=0o2h7hrvcuVhWc2PwewwbN9Qox4V60UHJqkXvSok0TXGm9mfDPEDEDE83P/yJ9+tRh
         r5tYX7X1LKtwHxEamZzxXQ9UkJ3I9bgCectYe8uHIbDt/ZJBlD0RpebQygNtW0nODHIS
         qAVzKvUvZLiXqGgBhaFeW7mYJ9W+DOkzsyy25DvAmOv+uVtBGLf4fxV8WI2xpreaLx+o
         LVG6QCfNDLo7ZiAkOC3Es2CjQfRiMy7nYwxbx5ZlRIXUdCEJ2/AjTnx+D7wAAbwKp/lA
         yS5nHk5EkY6AOksNnApPaAbraKgYAguUBSEhnYnv9P4t+yxBfF3emdiRywS4cvl4f0zc
         Ec3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499626; x=1717104426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWMMbr1Vy/P9Z5zpil6N5cVf+cv/qQ2YuUWCY55/mLE=;
        b=wb3ZvCtpkWVhHn76vxKUey+oURZJdRVSaZgkXOiTlqcH28P/XmZZZd9GAJLA1Vf5iJ
         ERkEB3MLvTSsPgYWeE1QJICUqgDZH2/S/xtfrskp481B/RHL+bYQ3AEoMnuf0QataNkY
         tlLwwDhz4NutzAM66CCPeUb6ZrVelZjci2eTAfA64NxINLrnNFZVbwbGgbMABNg6bCQo
         QmOV71vIc4SH6XrDRRRyE77WRUCsbOBgDy386W31wHxNLNjLgVAn4BFqKDpvRBnvvGLh
         TU5It8oFM6fD1Cuw+4tOCxPX2Ln2jvPU11e2pHr7sZkmtY+remwYiL1LRMdhsisXo8lO
         RMxA==
X-Gm-Message-State: AOJu0Yx0UmyvY9jkrMY8HYt/eThmb0TaRVPQAtKdbGJZakJA4vGIbQeZ
	fwzj3f0uDWhxMsMxmrC3KLObC7R7RUVEP7r95oWoA+Dj0gylam19N7lp8So41Uc+NQ3OGoPn9q0
	O
X-Google-Smtp-Source: AGHT+IGnnDQjZgImRpu2qOHQPzDCtGWiA5szJES97Xeg+ft01jZmr9ZizzvxSi2mrWNSrT5YVIsQxg==
X-Received: by 2002:a05:6214:4342:b0:6ab:9884:1a82 with SMTP id 6a1803df08f44-6abcd0d4bbfmr2590406d6.51.1716499626680;
        Thu, 23 May 2024 14:27:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070c7c3dsm604826d6.22.2024.05.23.14.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:27:06 -0700 (PDT)
Date: Thu, 23 May 2024 17:27:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 18/24] pack-bitmap: implement test helpers for pseudo-merge
Message-ID: <06ba1a5bbfd206cd47c9d8d474371042dc226031.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

Implement three new sub-commands for the "bitmap" test-helper:

  - t/helper test-tool bitmap dump-pseudo-merges
  - t/helper test-tool bitmap dump-pseudo-merge-commits <n>
  - t/helper test-tool bitmap dump-pseudo-merge-objects <n>

These three helpers dump the list of pseudo merges, the "parents" of the
nth pseudo-merges, and the set of objects reachable from those parents,
respectively.

These helpers will be useful in subsequent patches when we add test
coverage for pseudo-merge bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c          | 126 +++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h          |   3 +
 t/helper/test-bitmap.c |  34 ++++++++---
 3 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fc9c3e2fc43..c13074673af 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2443,6 +2443,132 @@ int test_bitmap_hashes(struct repository *r)
 	return 0;
 }
 
+static void bit_pos_to_object_id(struct bitmap_index *bitmap_git,
+				 uint32_t bit_pos,
+				 struct object_id *oid)
+{
+	uint32_t index_pos;
+
+	if (bitmap_is_midx(bitmap_git))
+		index_pos = pack_pos_to_midx(bitmap_git->midx, bit_pos);
+	else
+		index_pos = pack_pos_to_index(bitmap_git->pack, bit_pos);
+
+	nth_bitmap_object_oid(bitmap_git, oid, index_pos);
+}
+
+int test_bitmap_pseudo_merges(struct repository *r)
+{
+	struct bitmap_index *bitmap_git;
+	uint32_t i;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	for (i = 0; i < bitmap_git->pseudo_merges.nr; i++) {
+		struct pseudo_merge *merge;
+		struct ewah_bitmap *commits_bitmap, *merge_bitmap;
+
+		merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+					 &bitmap_git->pseudo_merges.v[i]);
+		commits_bitmap = merge->commits;
+		merge_bitmap = pseudo_merge_bitmap(&bitmap_git->pseudo_merges,
+						   merge);
+
+		printf("at=%"PRIuMAX", commits=%"PRIuMAX", objects=%"PRIuMAX"\n",
+		       (uintmax_t)merge->at,
+		       (uintmax_t)ewah_bitmap_popcount(commits_bitmap),
+		       (uintmax_t)ewah_bitmap_popcount(merge_bitmap));
+	}
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return 0;
+}
+
+static void dump_ewah_object_ids(struct bitmap_index *bitmap_git,
+				 struct ewah_bitmap *bitmap)
+
+{
+	struct ewah_iterator it;
+	eword_t word;
+	uint32_t pos = 0;
+
+	ewah_iterator_init(&it, bitmap);
+
+	while (ewah_iterator_next(&word, &it)) {
+		struct object_id oid;
+		uint32_t offset;
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			if (!(word >> offset))
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+
+			bit_pos_to_object_id(bitmap_git, pos + offset, &oid);
+			printf("%s\n", oid_to_hex(&oid));
+		}
+		pos += BITS_IN_EWORD;
+	}
+}
+
+int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n)
+{
+	struct bitmap_index *bitmap_git;
+	struct pseudo_merge *merge;
+	int ret = 0;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	if (n >= bitmap_git->pseudo_merges.nr) {
+		ret = error(_("pseudo-merge index out of range "
+			      "(%"PRIu32" >= %"PRIuMAX")"),
+			    n, (uintmax_t)bitmap_git->pseudo_merges.nr);
+		goto cleanup;
+	}
+
+	merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+				 &bitmap_git->pseudo_merges.v[n]);
+	dump_ewah_object_ids(bitmap_git, merge->commits);
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return ret;
+}
+
+int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n)
+{
+	struct bitmap_index *bitmap_git;
+	struct pseudo_merge *merge;
+	int ret = 0;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	if (n >= bitmap_git->pseudo_merges.nr) {
+		ret = error(_("pseudo-merge index out of range "
+			      "(%"PRIu32" >= %"PRIuMAX")"),
+			    n, (uintmax_t)bitmap_git->pseudo_merges.nr);
+		goto cleanup;
+	}
+
+	merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+				 &bitmap_git->pseudo_merges.v[n]);
+
+	dump_ewah_object_ids(bitmap_git,
+			     pseudo_merge_bitmap(&bitmap_git->pseudo_merges,
+						 merge));
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return ret;
+}
+
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 21aabf805ea..4466b5ad0fb 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -73,6 +73,9 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
+int test_bitmap_pseudo_merges(struct repository *r);
+int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
+int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
 
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index af43ee1cb5e..6af2b42678f 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -13,21 +13,41 @@ static int bitmap_dump_hashes(void)
 	return test_bitmap_hashes(the_repository);
 }
 
+static int bitmap_dump_pseudo_merges(void)
+{
+	return test_bitmap_pseudo_merges(the_repository);
+}
+
+static int bitmap_dump_pseudo_merge_commits(uint32_t n)
+{
+	return test_bitmap_pseudo_merge_commits(the_repository, n);
+}
+
+static int bitmap_dump_pseudo_merge_objects(uint32_t n)
+{
+	return test_bitmap_pseudo_merge_objects(the_repository, n);
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
 
-	if (argc != 2)
-		goto usage;
-
-	if (!strcmp(argv[1], "list-commits"))
+	if (argc == 2 && !strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
-	if (!strcmp(argv[1], "dump-hashes"))
+	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
 		return bitmap_dump_hashes();
+	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
+		return bitmap_dump_pseudo_merges();
+	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-commits"))
+		return bitmap_dump_pseudo_merge_commits(atoi(argv[2]));
+	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-objects"))
+		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
 
-usage:
 	usage("\ttest-tool bitmap list-commits\n"
-	      "\ttest-tool bitmap dump-hashes");
+	      "\ttest-tool bitmap dump-hashes\n"
+	      "\ttest-tool bitmap dump-pseudo-merges\n"
+	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
+	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>");
 
 	return -1;
 }
-- 
2.45.1.175.gcf0316ad0e9

