Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD014900E
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318181; cv=none; b=ZyjBgGF9VUf3fpEVAZRfIPTB6/zQrXybT606OV3vIkXBgPN7lgbVgqZcte7IH3B4GJkkXuHXMHwXSCCbpmT776dBv6qU0UpjgpimBOWnTAxaSm4MGRtIsbKWYas7denuyxr68tsl/Y7ajMvg1V1DIcZgJeOw8Wf8ey2XYXx+F8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318181; c=relaxed/simple;
	bh=VS9V9zlRHdbbhPu599RQE4AJ5e+ccVaxjMU6wdrVUak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V032pH9jTIF/HgpH/e+Ssn+a0gYNO+SoDsMyMcSjcTikO71ol1UzREQ1R9I/zwyL7HPtIY9m7QPENu9K3rvggSXZ+Uu+gN2kjrgvxNc4hSUktJj0N9dzRbmtYMZ7ZFuUVznr4XDavpLbpMltDHHlriQef0kkth7D2niWEJXuorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=3Ap7yrX7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="3Ap7yrX7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7931a0a4d8fso346410185a.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318178; x=1716922978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtHZas0M6YfAgIYEcoNEU6R5U2uAV2PxIiQOW5CCHKg=;
        b=3Ap7yrX7YHG7btUB4dex8ieZfeBCFkGQ2cI4yDPd9wMF/cMHRDC2IuMoRUrGn2q+VD
         Ih8RXVHV1nG960AgX6RGlw76xUGr5/sBMoh4m0FpNHvEqOCkp3C0GYmc+AG3JzWRjYrf
         cgnIV70yPce9N4LKpo4lyNxNQegr4TV3WGyBX+elBvay5qMQkoK7sANHuVDsRRBoKPRJ
         1fVwkqK/uGPAiIlRM5kpMyfr0lvo7qeDrrB8Hs9I439Le2IDHrHnzZ+2uxomqx/T8SeD
         Stu0sbxaKHEUlUtN3unlGZWsYwSYHOTi83ukGySXYCvBE8E255OL93Cd9GHT1A+sVmn5
         eEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318178; x=1716922978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtHZas0M6YfAgIYEcoNEU6R5U2uAV2PxIiQOW5CCHKg=;
        b=lpJj09z1ZpQ22PVH1Tom4jGDzr6G8r6dcNjf6PCurpPU0n+6JTe1C8WfL0ugGucMJh
         P/ocl6r6SY/CcYq/z40YBDRpey06IiZjw37ZK5RRhZCY1s6xGUx8gUaPs5RWmCEi3vIJ
         F+vB9VqOhQZRFzUrulgQ37uifkbfV0lnm5NHWa23mq/WOP2kA53li/jffe0ToQhhrDl9
         VLh86IxY9fH+ck/WAxRAIw+OCeFxgqsEEpHs4NlsqvD0A3s6i5a5EzIykAq4KziUCixo
         E7uwAeHqX4PkB6QVHFNwgnw530utXjSs3pppRTS7EFxporWhPLibV/6jPKOUlCjhEdeC
         fIyg==
X-Gm-Message-State: AOJu0YymjbNH4SVLFw6ECR9zNrXQdxdr6GNTc7/vjoHEPVH0ZaQGBY2M
	9pXi+Ee1vhSrl5KDCeLD1KMCxUn9AWnSinSMawWYiWhygr499VpsjJM3sfcL7fyVtuVs/GJJOUi
	C
X-Google-Smtp-Source: AGHT+IFtMLPtUuCScjwhiVreg78B4WFKVxl4Rz9ThvJRn13hCeHG0slNV7INtchZBiUyIMT3xmpYsw==
X-Received: by 2002:a05:620a:29c2:b0:792:d2a9:a59a with SMTP id af79cd13be357-792d2a9a840mr3893520485a.9.1716318178054;
        Tue, 21 May 2024 12:02:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27584asm1317137085a.10.2024.05.21.12.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:56 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 24/30] pack-bitmap: implement test helpers for pseudo-merge
Message-ID: <82cce72bf55a2543eb9a4045848a85d04cdb618e.1716318089.git.me@ttaylorr.com>
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
2.45.1.175.gbea44add9db

