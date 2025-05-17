Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB72207E00
	for <git@vger.kernel.org>; Sat, 17 May 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747491989; cv=none; b=ML7mwYkPbxMxZBmJmX4PVkyQ/P8NiXZIusiMXGQKzLuCadguY4pwenNRvwTjm1+lCyTjcxTXQEefHJjozvnkuGj2Qo8FpKwxZGGkzbdboav7iWrVw6j+/Ag+bsi1aX0Eg3BWi5EGiWXZPQwSLMM20zuwrCLQAJFm42LojcXg8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747491989; c=relaxed/simple;
	bh=UsmS3/TA6VAWvp1WrlwNeLqFvR+gWNNdqYLFd1/bVV8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=U0JBsFTtZjYgwvhPD3W7GL8BPvq8mP/B/aw7fWAHx/qAJ2oaiYidfIZYj/61GWOXc8a3qpBlPIeiUDL5nRnNwyxGxuWRcaR9jNBvZtkQ9kutgPgSOTM7rLBTXjYNSuzudyeJdeiJBx1LoRIPqnXsXB7Kf0AZDYAPLjBm4kHueyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STkS2MGP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STkS2MGP"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b933f214so1958176f8f.0
        for <git@vger.kernel.org>; Sat, 17 May 2025 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747491985; x=1748096785; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=17c1/8qz/6tqx3OppipXOVeph1eaJnwYC4GNP1wsv1k=;
        b=STkS2MGP5OtSqrF7h3rFkQjcu4zK70z15EBZTh8HHHUoUDEeRNFAEOLBzKIGx/ZJo2
         wssHGiWbi78yGHmWySlFC9bgFa3fUyVfKo3bomPQMClI1fnoTgE6Gltr+zYJIpCQfCBu
         WdrwSvrFfiKulDfGRKppEpBCUB5TgZduM3pIm55zyhWvbx0VWulr3jQli1a5piaHorVD
         p/zF45uACmf4ij1Ly8G3pY3+GFtpYwe3z4bBy7iUPMZ7UUltKa70UOL6Tjf4b4/g99Bo
         jhaAlqQUivsttCa/vogJnfw+XWqUZ7+M0WDR83wELERt6MmJ/xM3qEwLDGqHiIizcORS
         a/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747491985; x=1748096785;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17c1/8qz/6tqx3OppipXOVeph1eaJnwYC4GNP1wsv1k=;
        b=KZFymkbOgpFvnNeInAIv3NfuVDbs8Gv+2vCqjnutL4wAB22i5MvNpUOC85y0uo7ba1
         H/s5NvpfL83ZgqN6IJKHdcbXx3+0JxPQ8/2Jvwn0MQCKD60ZLyZBHH/Y610B4GbAqi9R
         3akSGyEujtchlsazKOiF41Uwp4lqQVWPrxvu0OsoaGz6RIDIMAy09b4sVK9gXamNhWlo
         4z9ntV/68I83mKgKNF6qEKnd8MTqpHOOWLW2CHtDhn/rEKTzbnqluaRDT7Vwhkcksf/s
         dnV0xGecjISv8WqTcgg1QOxiJl4p7mbIXUfiI99OmLWJfZ8ZFx43Gazn6cNtqgqf6H83
         evmQ==
X-Gm-Message-State: AOJu0YyuxEcYp90SRkpJbyTcD0tegn6E8h7mZ2afnfhRmSBfwuWKBtXI
	6ukyCp49S2eHZ6R5sXTItaQUzoRvKl99HO9sRFhPhydoXeKg+vfYf6PjqOepvA==
X-Gm-Gg: ASbGncuU1g5/nhv51HIbXio/Pz9nJtUBcrL4pOCzlVu+0XCjngFaM21abKZ2kA/R6t3
	YXtYetTmkGgpKYWlaoxIWzyvm17uRKnm0jUVeb4+NUdqw95Iv1KOecNKrStfga121unl04p5uGb
	oMYp71YgbU7XpNdlJj8QZ07iYGtdFCK3judF7eSIHtRrzZvJzgUDiLPSUR5NptaRLcXePRq4VE6
	XpPwz+Lq/ffhU0O0G8d/B0p8/6bDU4HcW6NzoF8jNEon3IJvpSYWYub/aDtFAT6H2Bm5mgO+1MB
	+m2AvfZy5y6l/CbTWRmcC1ODkNK+49wLFSlYZZ7oDElkXknWkMcY
X-Google-Smtp-Source: AGHT+IEf/5AemM3GBrfLNShOOMincWvK5fvnppUmNNu/PDXXj3mfBS5n4jRSxzFfT0R0LprhZaHULg==
X-Received: by 2002:a05:6000:420f:b0:3a3:62af:7c39 with SMTP id ffacd0b85a97d-3a362af7e45mr5241279f8f.31.1747491984717;
        Sat, 17 May 2025 07:26:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a366e08747sm2741573f8f.95.2025.05.17.07.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 07:26:24 -0700 (PDT)
Message-Id: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 May 2025 14:26:22 +0000
Subject: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

This patch add a test function `test_bitmap_load_corrupt` in patch-bitmap.c
, a `load corrupt bitmap` test case in t5310-pack-bitmaps.sh and
a new command `load-corrupt` for `test-tool` in t/helper/test-bitmap.c.

To make sure we are loading a corrupt bitmap, we need enable bitmap table
lookup so that `prepare_bitmap()` won't call `load_bitmap_entries_v1()`.
So to test corrupt bitmap_index, we first call `prepare_bitmap()` to set
everything up but `bitmap_index->bitmaps` for us. Then we do any
corruption we want to the bitmap_index. Finally we can test loading
corrupt bitmap by calling `load_bitmap_entries_v1()`.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    pack-bitmap: add loading corrupt bitmap_index test
    
    This patch add a test function test_bitmap_load_corrupt in
    patch-bitmap.c , a load corrupt bitmap test case in
    t5310-pack-bitmaps.sh and a new command load-corrupt for test-tool in
    t/helper/test-bitmap.c.
    
    To make sure we are loading a corrupt bitmap, we need enable bitmap
    table lookup so that prepare_bitmap() won't call
    load_bitmap_entries_v1(). So to test corrupt bitmap_index, we first
    prepare_bitmap() to set everything up but bitmap_index->bitmaps for us.
    Then we do any corruption we want to the bitmap_index. Finally we call
    load_bitmap_entries_v1() to test loading corrupt bitmap.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1967%2Fbrandb97%2Fcorrupt-bitmap-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1967/brandb97/corrupt-bitmap-test-v1
Pull-Request: https://github.com/git/git/pull/1967

 pack-bitmap.c           | 65 +++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h           |  1 +
 t/helper/test-bitmap.c  |  8 +++++
 t/t5310-pack-bitmaps.sh | 15 ++++++++++
 4 files changed, 89 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d866046..9642a06b3fe 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3022,6 +3022,71 @@ cleanup:
 	return ret;
 }
 
+typedef void(corrupt_fn)(struct bitmap_index *);
+
+static int bitmap_corrupt_then_load(struct repository *r, corrupt_fn *do_corrupt)
+{
+	struct bitmap_index *bitmap_git;
+	unsigned char *map;
+
+	if (!(bitmap_git = prepare_bitmap_git(r)))
+		die(_("failed to prepare bitmap indexes"));
+	/*
+	 * If the table lookup extension is not used,
+	 * prepare_bitmap_git has already called load_bitmap_entries_v1(),
+	 * making it impossible to corrupt the bitmap.
+	 */
+	if (!bitmap_git->table_lookup)
+		return 0;
+
+	/*
+	 * bitmap_git->map is read-only;
+	 * to corrupt it, we need a writable memory block.
+	 */
+	map = bitmap_git->map;
+	bitmap_git->map = xmalloc(bitmap_git->map_size);
+	if (!bitmap_git->map)
+		return 0;
+	memcpy(bitmap_git->map, map, bitmap_git->map_size);
+
+	do_corrupt(bitmap_git);
+	if (!load_bitmap_entries_v1(bitmap_git))
+		die(_("load corrupt bitmap successfully"));
+
+	free(bitmap_git->map);
+	bitmap_git->map = map;
+	free_bitmap_index(bitmap_git);
+
+	return 0;
+}
+
+static void do_corrupt_commit_pos(struct bitmap_index *bitmap_git)
+{
+	uint32_t *commit_pos_ptr;
+
+	commit_pos_ptr = (uint32_t *)(bitmap_git->map + bitmap_git->map_pos);
+	*commit_pos_ptr = (uint32_t)-1;
+}
+
+static void do_corrupt_xor_offset(struct bitmap_index *bitmap_git)
+{
+	uint8_t *xor_offset_ptr;
+
+	xor_offset_ptr = (uint8_t *)(bitmap_git->map + bitmap_git->map_pos +
+				     sizeof(uint32_t));
+	*xor_offset_ptr = MAX_XOR_OFFSET + 1;
+}
+
+int test_bitmap_load_corrupt(struct repository *r)
+{
+	int res = 0;
+	if ((res = bitmap_corrupt_then_load(r, do_corrupt_commit_pos)))
+		return res;
+	if ((res = bitmap_corrupt_then_load(r, do_corrupt_xor_offset)))
+		return res;
+	return res;
+}
+
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 382d39499af..7770abe6bff 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -85,6 +85,7 @@ int test_bitmap_hashes(struct repository *r);
 int test_bitmap_pseudo_merges(struct repository *r);
 int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
 int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
+int test_bitmap_load_corrupt(struct repository *r);
 
 struct list_objects_filter_options;
 
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 3f23f210726..7aabcfed2f9 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -20,6 +20,11 @@ static int bitmap_dump_pseudo_merges(void)
 	return test_bitmap_pseudo_merges(the_repository);
 }
 
+static int bitmap_load_corrupt(void)
+{
+	return test_bitmap_load_corrupt(the_repository);
+}
+
 static int bitmap_dump_pseudo_merge_commits(uint32_t n)
 {
 	return test_bitmap_pseudo_merge_commits(the_repository, n);
@@ -40,6 +45,8 @@ int cmd__bitmap(int argc, const char **argv)
 		return bitmap_dump_hashes();
 	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
 		return bitmap_dump_pseudo_merges();
+	if (argc == 2 && !strcmp(argv[1], "load-corrupt"))
+		return bitmap_load_corrupt();
 	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-commits"))
 		return bitmap_dump_pseudo_merge_commits(atoi(argv[2]));
 	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-objects"))
@@ -48,6 +55,7 @@ int cmd__bitmap(int argc, const char **argv)
 	usage("\ttest-tool bitmap list-commits\n"
 	      "\ttest-tool bitmap dump-hashes\n"
 	      "\ttest-tool bitmap dump-pseudo-merges\n"
+	      "\ttest-tool bitmap load-corrupt\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
 	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>");
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a62b463eaf0..042f62f16ea 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -486,6 +486,21 @@ test_bitmap_cases () {
 			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
+
+	test_expect_success 'load corrupt bitmap' '
+		git init repo &&
+		test_when_finished "rm -fr repo" && (
+			cd repo &&
+			git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+
+			echo "Hello world" > hello_world.txt &&
+			git add hello_world.txt &&
+			git commit -am "add hello_world.txt" &&
+
+			git repack -adb &&
+			test-tool bitmap load-corrupt
+		)
+	'
 }
 
 test_bitmap_cases

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
