Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB48665A
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972357; cv=none; b=EY5ntjLi0X/LT/fpXkjMzWo9/u7igsY/sjoCUm7PmWDAUKzjZqFeoDhlW1+xYJumkOEuoYRvFRx80O0gHRi9CQ3TctaVWtTkq3sYWjXnjRsGkVeiRVRqEP3MYfTdyEHD90eaTPq3ttY7GjVDMfnr44gJl8zzHOKncxMrLz1ETyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972357; c=relaxed/simple;
	bh=STc801ngdsw4grWj/2fCuhZ5g2oSOIiTqFMWy9yv+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zrxz9NYHS0jOfU+kqvFW6+g0sa6w1Gv3AqbDEkECYl77lbQKPfwz0fjW2eC6Jx4/GxYbetKnp1hBkSpl/sVebW4ZhnieyVVzyHSTqxEVYVmU9f2Tuzg80imHQGiB4Q+kKMkXQhadHRurMmYLPzcr2UbpvJ+sABBtbCo/J+nwTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Pcr359d0; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Pcr359d0"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6963c0c507eso4457206d6.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972354; x=1711577154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m3PcbGEDqgL/0XLppcmfbabNLxqQPslp9rWFGst9FQY=;
        b=Pcr359d0OEpEQzDH6s3rjJUDWPap7y5qrtUILBJbtqeU4xpANiMJwAmf/Xy5pSGj5O
         //ncNJcuZACiMT/VnwtlqFalrG8IzKEazHR3dwNU8nN1g8wUzeWp+tCCMpP7cIKKoEU1
         1DdrbWBIxi4Ma3ZQPRjDuScU0/HekcISEJaQ0qMae+GgpaU9ssMxWQcDpquxXjPfzBAQ
         Th/0nN8WkHQ6K612TbQgNDFRz+qGJc4h0HxV1a5ichQcpIUhEQA359q5T8gQl/p9quHY
         BdNFd2pGL2NROZgFlhq62Kx86Cn2ZVLgt6xckZ4L8r0bIX7CZ9SgtDxaJs/lEL2+Ejko
         m4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972354; x=1711577154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3PcbGEDqgL/0XLppcmfbabNLxqQPslp9rWFGst9FQY=;
        b=tQ2dn7EYgt1EYSeb3BlWt6dNJav1YwcRZflQqHh1AQ9RUc13J0voh7OXs8IGzEbqhi
         uMl3ZG1M33sly0yUrrCddkLWr3L965KnFx5HOvppDR0rT5T2gq4MRMH4aCeOOr6QK6GZ
         Qt2bbnt1XvitPg80wFAjRdfimJZnHFvjehi48TeaNKh0eXp9KgYzQsgfA+fPMg6zfyct
         8aSQHGdlvqmZ4zMt9kEENK3O+ZzCrxBYe0H/BwX0uaDok5CXu5kVlqcfg0vH+mqyyf9D
         MIefVLglf7UzTHA4g5hamKBjcp3ldw2CEFMwpmyHCijUYNgAiNVqnJaGdHx1lTFDmcRK
         Y7xA==
X-Gm-Message-State: AOJu0Yw6p2skgnDJhazvJCRefdFxr60irBYUqRJ7RmljFVddZUtsg8EC
	uQ37dCiiSJudheo2xhPgH8kNwrgLqe2RflYd+D0c06UrOameBydESvtmIOpwpWeQJyHcOiZhjkg
	2f00=
X-Google-Smtp-Source: AGHT+IEiY2t0WiVhFXi/vjPPwMoD8GO5ET9g/xq/FolakoT/c25DJm4FsMVIgBMyOFdWdLTyYYQ6cA==
X-Received: by 2002:a05:6214:5294:b0:696:4771:9b57 with SMTP id kj20-20020a056214529400b0069647719b57mr1572984qvb.23.1710972354217;
        Wed, 20 Mar 2024 15:05:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m10-20020a0562141bca00b00690b21ff926sm8224811qvc.137.2024.03.20.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:53 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/24] pack-bitmap: implement test helpers for pseudo-merge
Message-ID: <c839e1fed15a4a4cb827bbd177c120c8c3f74556.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

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
index e0f191b7581..7188dd75eaf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2442,6 +2442,132 @@ int test_bitmap_hashes(struct repository *r)
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
index a5fe4f305ef..25d3b8e604a 100644
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
2.44.0.303.g1dc5e5b124c

