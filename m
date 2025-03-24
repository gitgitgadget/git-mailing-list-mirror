Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660832620F7
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829786; cv=none; b=eLXpytiVRvmLyyVcA1hg/n6Sb2y5QqqS0coflAoBp9IjlBAKpbwvbBhA4vmdEp5weUSyiKDRvBvMS+KBNwaBPLwuSz8xjg0kbdebFKcfb2wh8mlTmYTr7aUsWazXvl7OysrOvSUJ1c4MFbnHmNQzfY5Vil75iSWwa8l1IiHIcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829786; c=relaxed/simple;
	bh=ahcylMYowVYPBWZHZ0/RHMkqySPm69fMMaQy+zfbuUc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RjA9uuNIggFIl9Uo2TYKQcsXXuQW1m1a7zcPHN6v2S70yvisxVnXMOpaZhFV8r63y0ny0mt6ZPVOq6nruPpUNDn7dwp7ie+3MuZjNXexzREW/Z55VCvRR9O0WwN1V5fm+aDYWQGHg3sB5pPOzsKXT9jc6ljKda8CUm1Owz0rehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDJ83aVt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDJ83aVt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so3859119f8f.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829782; x=1743434582; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8ZH7PS/LIkK+yAzFT6L7ZCr5T9tknYCMIzh5JJj308=;
        b=XDJ83aVtdVg6PJ6Qr6GNVDeespzgmf91eNu0WHQX3IPKaTymkgRgEgvkbsH86mJT3z
         0lJU0GVB1uBJwuoSJ6O+DWUVfqsroghiudMHgcNjGgavbGHftR9bYTegE79KQlRcxJ5N
         lKPfpCuRchfPzYBl1l/BoVWwdzK3EgTerAq+oBTJ9qV0+fo/+UOFNNTVKAFqjPKGmcBo
         EnQ+nCICVlPM8zUcNvNdpR3H0YPZdDNGsp1fMYpRA1AKCdC00IYKmzfqp1np5hdmRAhe
         rZV6xhzYdutLMM4omTz1zmoU9Ah9kTzc09S0BYpTpZ6NlUM8ugABhQbPQiBbViCb99fn
         5EIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829782; x=1743434582;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8ZH7PS/LIkK+yAzFT6L7ZCr5T9tknYCMIzh5JJj308=;
        b=seRCJIFHqWarmVW19Y6t8B/z21AvimgprrhkDqXPQ2tzIJyIXpmBii+70smgunYhcW
         8GdTGHePhbIF84aU+E0JU6SGm5KvmgNL0hmEcWdJP5jvcXLBpYcGYtGjqEgzDPeeNssJ
         +ZjD6uybNd43alhcPcHElDEG9L2vQqcbYX25ZJGPYztjawRzn7IJohsCrCP/cm9hsyR2
         aNjBvY9XuIQcKdViZXm7wYzPSMZAp6zHquIUobektxm9PSmPPSQcrKQw/HT8d8FbTN9y
         xZFG6a1vFsRcAEmimSY0Phiz2CnhUtipStyoKXWR4XSvoBwtPQN6k7KRDm3YgU3mtHWy
         IODQ==
X-Gm-Message-State: AOJu0YzowQzL/DhfXtQ/4kAFNLiJnPX3RVtTmQyHx9ihY2NHKKVdaImS
	QqRC70ESSPm5kKt1CkcKOHYxNZQ0HvYbgXdCtdsWGAeKDDy8YIKKILvVOQ==
X-Gm-Gg: ASbGncugqj6Wv4cbY72yZ/axp1vkwHrzORLgaL7XT4GhkG2imoD6qod4jKKmPRWSmHd
	8PJsfDbIf2H9uUQqt1M3rKXutOvYJ7kSNSsfv7oAA8oqIzkeD+7SlnCXIU3ePuEM4YqFUOrlare
	3E9OpA9NLFH2T8TLjXiiar3nR2fS4w4fdHV72RPkPp8H4zQnG770p+wRQEggPgMm+0ZbHdCoYW2
	YlR7i2vF7VHfuyTBDUN+rDtaR/6B9iDE1SiVWcryBN3WPK9ykZDNYFiXg7l57E2ryBBpbHylQx5
	ZyE+YSgor9GKa0ZU+s3Ew6cPObVEPdxsbmz+sBH24ynoxm7JrC0EX3hU
X-Google-Smtp-Source: AGHT+IEvnCyfvuSEATXBBYain7sFurv9jPz5cu7UyLSuPEsjOhTNQtPc1DWp6KIyTsWBpBlFVDaG7A==
X-Received: by 2002:a05:6000:1543:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-3997f911531mr12827789f8f.29.1742829782094;
        Mon, 24 Mar 2025 08:23:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6539sm11305274f8f.77.2025.03.24.08.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:01 -0700 (PDT)
Message-Id: <622439d78557d94da899d21444920c27768d3c67.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:46 +0000
Subject: [PATCH v2 10/13] pack-objects: refactor path-walk delta phase
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, the --path-walk option to 'git pack-objects' would compute
deltas inline with the path-walk logic. This would make the progress
indicator look like it is taking a long time to enumerate objects, and
then very quickly computed deltas.

Instead of computing deltas on each region of objects organized by tree,
store a list of regions corresponding to these groups. These can later
be pulled from the list for delta compression before doing the "global"
delta search.

This presents a new progress indicator that can be used in tests to
verify that this stage is happening.

The current implementation is not integrated with threads, but could be
done in a future update.

Since we do not attempt to sort objects by size until after exploring
all trees, we can remove the previous change to t5530 due to a different
error message appearing first.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c       | 82 +++++++++++++++++++++++++-----------
 pack-objects.h               | 12 ++++++
 t/t5300-pack-object.sh       |  8 +++-
 t/t5530-upload-pack-error.sh |  6 ---
 4 files changed, 75 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0ea85754c52..d4e05ca4434 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3236,6 +3236,51 @@ static int should_attempt_deltas(struct object_entry *entry)
 	return 1;
 }
 
+static void find_deltas_for_region(struct object_entry *list,
+				   struct packing_region *region,
+				   unsigned int *processed)
+{
+	struct object_entry **delta_list;
+	uint32_t delta_list_nr = 0;
+
+	ALLOC_ARRAY(delta_list, region->nr);
+	for (uint32_t i = 0; i < region->nr; i++) {
+		struct object_entry *entry = list + region->start + i;
+		if (should_attempt_deltas(entry))
+			delta_list[delta_list_nr++] = entry;
+	}
+
+	QSORT(delta_list, delta_list_nr, type_size_sort);
+	find_deltas(delta_list, &delta_list_nr, window, depth, processed);
+	free(delta_list);
+}
+
+static void find_deltas_by_region(struct object_entry *list,
+				  struct packing_region *regions,
+				  uint32_t start, uint32_t nr)
+{
+	unsigned int processed = 0;
+	uint32_t progress_nr;
+
+	if (!nr)
+		return;
+
+	progress_nr = regions[nr - 1].start + regions[nr - 1].nr;
+
+	if (progress)
+		progress_state = start_progress(the_repository,
+						_("Compressing objects by path"),
+						progress_nr);
+
+	while (nr--)
+		find_deltas_for_region(list,
+				       &regions[start++],
+				       &processed);
+
+	display_progress(progress_state, progress_nr);
+	stop_progress(&progress_state);
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
@@ -3260,6 +3305,10 @@ static void prepare_pack(int window, int depth)
 	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
+	if (path_walk)
+		find_deltas_by_region(to_pack.objects, to_pack.regions,
+				      0, to_pack.nr_regions);
+
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
@@ -4213,10 +4262,8 @@ static int add_objects_by_path(const char *path,
 			       enum object_type type,
 			       void *data)
 {
-	struct object_entry **delta_list;
 	size_t oe_start = to_pack.nr_objects;
 	size_t oe_end;
-	unsigned int sub_list_size;
 	unsigned int *processed = data;
 
 	/*
@@ -4249,32 +4296,17 @@ static int add_objects_by_path(const char *path,
 	if (oe_end == oe_start || !window)
 		return 0;
 
-	sub_list_size = 0;
-	ALLOC_ARRAY(delta_list, oe_end - oe_start);
-
-	for (size_t i = 0; i < oe_end - oe_start; i++) {
-		struct object_entry *entry = to_pack.objects + oe_start + i;
+	ALLOC_GROW(to_pack.regions,
+		   to_pack.nr_regions + 1,
+		   to_pack.nr_regions_alloc);
 
-		if (!should_attempt_deltas(entry))
-			continue;
-
-		delta_list[sub_list_size++] = entry;
-	}
+	to_pack.regions[to_pack.nr_regions].start = oe_start;
+	to_pack.regions[to_pack.nr_regions].nr = oe_end - oe_start;
+	to_pack.nr_regions++;
 
-	/*
-	 * Find delta bases among this list of objects that all match the same
-	 * path. This causes the delta compression to be interleaved in the
-	 * object walk, which can lead to confusing progress indicators. This is
-	 * also incompatible with threaded delta calculations. In the future,
-	 * consider creating a list of regions in the full to_pack.objects array
-	 * that could be picked up by the threaded delta computation.
-	 */
-	if (sub_list_size && window) {
-		QSORT(delta_list, sub_list_size, type_size_sort);
-		find_deltas(delta_list, &sub_list_size, window, depth, processed);
-	}
+	*processed += oids->nr;
+	display_progress(progress_state, *processed);
 
-	free(delta_list);
 	return 0;
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index d73e3843c92..7ba9f3448fe 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -119,11 +119,23 @@ struct object_entry {
 	unsigned ext_base:1; /* delta_idx points outside packlist */
 };
 
+/**
+ * A packing region is a section of the packing_data.objects array
+ * as given by a starting index and a number of elements.
+ */
+struct packing_region {
+	uint32_t start;
+	uint32_t nr;
+};
+
 struct packing_data {
 	struct repository *repo;
 	struct object_entry *objects;
 	uint32_t nr_objects, nr_alloc;
 
+	struct packing_region *regions;
+	uint64_t nr_regions, nr_regions_alloc;
+
 	int32_t *index;
 	uint32_t index_size;
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 16420d12863..c8df6afd784 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -725,7 +725,9 @@ test_expect_success '--name-hash-version=2 and --write-bitmap-index are incompat
 
 test_expect_success '--path-walk pack everything' '
 	git -C server rev-parse HEAD >in &&
-	git -C server pack-objects --stdout --revs --path-walk <in >out.pack &&
+	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
+		--stdout --revs --path-walk --progress <in >out.pack 2>err &&
+	grep "Compressing objects by path" err &&
 	git -C server index-pack --stdin <out.pack
 '
 
@@ -734,7 +736,9 @@ test_expect_success '--path-walk thin pack' '
 	$(git -C server rev-parse HEAD)
 	^$(git -C server rev-parse HEAD~2)
 	EOF
-	git -C server pack-objects --thin --stdout --revs --path-walk <in >out.pack &&
+	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
+		--thin --stdout --revs --path-walk --progress <in >out.pack 2>err &&
+	grep "Compressing objects by path" err &&
 	git -C server index-pack --fix-thin --stdin <out.pack
 '
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 8eb6fea839a..558eedf25a4 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -34,12 +34,6 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
 	hexsz=$(test_oid hexsz) &&
 	printf "%04xwant %s\n00000009done\n0000" \
 		$(($hexsz + 10)) $head >input &&
-
-	# The current implementation of path-walk causes a different
-	# error message. This will be changed by a future refactoring.
-	GIT_TEST_PACK_PATH_WALK=0 &&
-	export GIT_TEST_PACK_PATH_WALK &&
-
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	test_grep "unable to read" output.err &&
 	test_grep "pack-objects died" output.err
-- 
gitgitgadget

