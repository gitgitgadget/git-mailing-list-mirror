Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EF1946AA
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431834; cv=none; b=ex3DZoYF9K5rpul6rvYu8Ayn3uiHz+Z4zaVWQFf/HxCJF692kK6rLY0B8LoTPLmYmzDL35z6L/4oZDHi8nkhRFkf1UnRh1bCxGmL3AMHYmaEoqBGOrZeug//j/DwyQYC7tPGEMY5VBrdPGQL3YXEwF/ENLcdIjqKWhvHPONAniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431834; c=relaxed/simple;
	bh=nHr3lAPUy3tOoVWoI3q8tIHRIs+K3x+c2o9FuYt++P8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fACWzOLFv60WcBAEqgNzpDViDwYsPULjc+49dj2r2HY4bX3sFt8QSWPOAwl6q0MpxC7YsIA2Z1kTaR8TNvpw91RARoo5D6tuFkA05Rji5WE/6GQHr7Bj5BZfHvWL6Ng3n1U8wQLQ2m7uUD06AJV0dx8gg8VjJpwN19L4oqrSWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbxeVZAM; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbxeVZAM"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a998a5ca499so456137666b.0
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431830; x=1730036630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1Dk8CxF9S/s65XsXVAoxKRDpwmgMnTH343/56iclQo=;
        b=hbxeVZAMJTH+WkdDCtdr5W3sj/OfWTHoY0ady6sTOPxz6dGN/opshJgouoYdpEugF6
         NNuoBfed4Ia7blFZE46BQ03qPP7dB0M+eZbXDpssXnTjewk12Rou6VEPTRqba5t1iRo6
         PsfvtTiTuExLLlQY97eDdxfuXpHXG02Ui2YYiqdCFeo1bHeM8nbkhn9ErEMG1nMeHFpj
         9uLfZQClEKEjdSEs/FlvJTce2YujFmxWUaqyMOmwI6dDzKIbE0HL777wuP+lNt13Qqfa
         EJwJ69VBkcZj5qJdQ9dsrtNxe+SEL7Oms8/dd5E2aOs+WXw212dzs8BYOQVxdY/vuzZD
         SJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431830; x=1730036630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1Dk8CxF9S/s65XsXVAoxKRDpwmgMnTH343/56iclQo=;
        b=OHdenH3QoWMj4IjwTPFHGalsa4A6Iegb01WZ7+EXitwF7K6nSO4zMPY91c/vhzPDRn
         E6AX5151KUJIeU1MT8V4YPajVl98oKeQkeTM+gAYuEtWBV72TuHU++5XQXVwNOv8ZdRd
         Id4cQ5MPSGdMhGZatVLsB/DYblYBk6lzOOQlwBusBjjl88AD+B+r/WA+P3LObsH16A3Y
         tjZ/Ecy4rF8pgXvy2mbJ8vHg5HyME+tK/X+3dyfhTgNLGOv+tpB+mEqNxNtFo16qIohW
         vaRDaHW9w6GqNxcHyzSiIB2lARRFVf5WnwskF9WVdeDpb6azMsB/k3u2p4S0jXam2SzB
         iYJA==
X-Gm-Message-State: AOJu0YxYajvp8Ql/YgUAWTJn9QGmrObNdkJMB56jpuV41xOCL/J36D+w
	3wgyaiHaup4R0jLkTs6417TflJZtl88lemV4lqepMBpaIVuUmajh4SDFQA==
X-Google-Smtp-Source: AGHT+IE5l/XG3xsPemlg3MOsm5mTvomakWiOLtZ0DB2eqq/8p8swHyXCnjFdCiyqr3kQT671n002RA==
X-Received: by 2002:a17:907:94c2:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a9a69a65fd0mr878544566b.20.1729431829789;
        Sun, 20 Oct 2024 06:43:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a915993c6sm91233066b.202.2024.10.20.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:48 -0700 (PDT)
Message-Id: <030d8ec238e7692e029ae063e475f58e4c172542.1729431811.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:29 +0000
Subject: [PATCH v2 16/17] pack-objects: refactor path-walk delta phase
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
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
 builtin/pack-objects.c       | 81 +++++++++++++++++++++++++-----------
 pack-objects.h               | 12 ++++++
 t/t5300-pack-object.sh       |  8 +++-
 t/t5530-upload-pack-error.sh |  6 ---
 4 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6805a55c60d..5c413ac07e6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3204,6 +3204,50 @@ static int should_attempt_deltas(struct object_entry *entry)
 	return 1;
 }
 
+static void find_deltas_for_region(struct object_entry *list UNUSED,
+				   struct packing_region *region,
+				   unsigned int *processed)
+{
+	struct object_entry **delta_list;
+	uint32_t delta_list_nr = 0;
+
+	ALLOC_ARRAY(delta_list, region->nr);
+	for (uint32_t i = 0; i < region->nr; i++) {
+		struct object_entry *entry = to_pack.objects + region->start + i;
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
+		progress_state = start_progress(_("Compressing objects by path"),
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
@@ -3228,6 +3272,10 @@ static void prepare_pack(int window, int depth)
 	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
+	if (path_walk)
+		find_deltas_by_region(to_pack.objects, to_pack.regions,
+				      0, to_pack.nr_regions);
+
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
@@ -4165,10 +4213,8 @@ static int add_objects_by_path(const char *path,
 			       enum object_type type,
 			       void *data)
 {
-	struct object_entry **delta_list;
 	size_t oe_start = to_pack.nr_objects;
 	size_t oe_end;
-	unsigned int sub_list_size;
 	unsigned int *processed = data;
 
 	/*
@@ -4201,32 +4247,17 @@ static int add_objects_by_path(const char *path,
 	if (oe_end == oe_start || !window)
 		return 0;
 
-	sub_list_size = 0;
-	ALLOC_ARRAY(delta_list, oe_end - oe_start);
+	ALLOC_GROW(to_pack.regions,
+		   to_pack.nr_regions + 1,
+		   to_pack.nr_regions_alloc);
 
-	for (size_t i = 0; i < oe_end - oe_start; i++) {
-		struct object_entry *entry = to_pack.objects + oe_start + i;
+	to_pack.regions[to_pack.nr_regions].start = oe_start;
+	to_pack.regions[to_pack.nr_regions].nr = oe_end - oe_start;
+	to_pack.nr_regions++;
 
-		if (!should_attempt_deltas(entry))
-			continue;
+	*processed += oids->nr;
+	display_progress(progress_state, *processed);
 
-		delta_list[sub_list_size++] = entry;
-	}
-
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
-
-	free(delta_list);
 	return 0;
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64b..bde4ba19755 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -118,11 +118,23 @@ struct object_entry {
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
+	uint32_t nr_regions, nr_regions_alloc;
+
 	int32_t *index;
 	uint32_t index_size;
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 5f6914acae7..4f81613eab1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -677,7 +677,9 @@ done
 # Basic "repack everything" test
 test_expect_success '--path-walk pack everything' '
 	git -C server rev-parse HEAD >in &&
-	git -C server pack-objects --stdout --revs --path-walk <in >out.pack &&
+	GIT_PROGRESS_DELAY=0 git -C server pack-objects \
+		--stdout --revs --path-walk --progress <in >out.pack 2>err &&
+	grep "Compressing objects by path" err &&
 	git -C server index-pack --stdin <out.pack
 '
 
@@ -687,7 +689,9 @@ test_expect_success '--path-walk thin pack' '
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
index 356b96cb741..7172780d550 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -35,12 +35,6 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
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

