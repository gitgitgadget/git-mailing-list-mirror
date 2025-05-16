Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85027C857
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419157; cv=none; b=sb17uPZEljeKzTumHf1uLK/z5mpuFfijdNS1ABFAg5kOgfez2qTuvrvFar7D6Ca704JHGHtBDdw7MoMeu3cB53qMeApTUzTvBFNdwInhXtQiOcPnnGnxDsPNyEs5PyL13v7HlzB+LJD6CnthuPkteFED/cYxkNk80SD/qP/Zdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419157; c=relaxed/simple;
	bh=fm5SaTJ8Lo+EONmG0h4BLqlV6jmw3p7QoDqrXwWah24=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kuX4RxQIqj5PZlNf5DDd3+QrltW8D+NbjB9ddNIQF+kCvSSK9TpJum2UOreKCDGVUwAetOKhNwr1ucFkSn6ka3bi87qKc5XtQV/gd1JUEwrChr/aKTuyY3ejv8oZRw9GLFiEzj2TLmHrXeKPD7NMScgOrrX5XLzHLo9zRI490Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG1lzpsV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG1lzpsV"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9e2d640so2074770f8f.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419153; x=1748023953; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctgoHMgFOBfvA/O4ZWt6TZTIgwRyK3QDb/RFmrD5klQ=;
        b=mG1lzpsVTWmA/t+IoGiGJIBzYeT8TGNs/NGJi8iTeQ4mKbsC2p33lail1WFk4wp6eJ
         0tq4xQin/t4dM5f9l74GR4ec2sMRqxh+mMa2qJqOfGV+G7wv1Cs7Y+98Chjp8CyTetPq
         A4+ROVytPgCHrk/8I4yh4Z4/kjGP15v8+azLAqvxheyghw6/3eBdx6VIjcRbQ1sLtDOO
         QnZSbbxST2vy88cssNsEMy/UnmOVmKxMkUl61csXyAiIRrnMMMog7JgSbDc3YKESQ/ka
         a6m9vM4C31gPM0lmsf/39TWxSFIAPWSWUFLO8FG0M/XwUufXDqyZ+Oma3nXzcBPqVKbs
         25rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419153; x=1748023953;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctgoHMgFOBfvA/O4ZWt6TZTIgwRyK3QDb/RFmrD5klQ=;
        b=m9r+j5GNWtmZTnPoL5KR0ikSTMB9h1DvODJhcW5sVLdMx4+heVaFnHynB9VCp+bT79
         9PMFia/dfDWrZkpbmUPYv2cY2FyhdQTN9xbNf0Ns/OOgnOBugc76CvBitIXBsSVTEeR1
         qqbxmAZnbzoOdWK2bojigWGwZgLNRCDG3KFQH0zlugYpTfUdK5ehFMzn4Gk8M6SGIitA
         BCsXCnOJD/ehwt1SDdXMdKEyXDgMekTXPcch1+blYcmilYPYYEvncfigO8soH3c6fJuo
         fO45PAjXs48S9pPR3N7Snl8nOqwXNSB9h3TCdiTULPlIXwO9ADcDNrtK6YUL4u+oPSZ/
         7e7A==
X-Gm-Message-State: AOJu0YyXFZp9QPc12L8Y+YwvpbepvGtfjaKUWpdeI5tIqHGhYs7tS0Ag
	yjGVCdI7MHkrkm83DbRSW9kXNDj4VixxfwGJGRUiHyHqHZTWRgn+hAEZ2a/nmw==
X-Gm-Gg: ASbGnctEbvInO5mN3Ns6626nyivg2DvUEVybCzDIyNJyTAz39G09+j/htqdjqoyDZvk
	xE4Mxktmq1ebAkQS5jsbRMFiw2WN6ZIXzxm/uF1+y7JzZTyZvysLqUBoKHAnkGX8Fwr8LLInmDb
	+8UroG4CzpyyOsz0H+1paDIY9Ggtb7k0ifRiRN2sr7VBDCqieFE5uxHqa81tFYQuuKr4HwaMijO
	k6LMgC7oSuLpphuoYnZQzkiAE4sZT8haZPYXt1TP0tOzFTOoaXiI2nzTLEKBBLI4B7l3sj+6LV2
	N9mdHju+W6iy6u+ptaXXYZ4Oebuv35G/bgymoQmrWYjMyk+G8h6R
X-Google-Smtp-Source: AGHT+IEKC7ARmfIIJ11EAmfjvQRB94/pyB1zp+9ICf7pvmRQH1b1l8jO+8fBXR+uvpxZ3iiNAdZy9g==
X-Received: by 2002:adf:e385:0:b0:3a3:6282:693a with SMTP id ffacd0b85a97d-3a362826998mr2386486f8f.44.1747419153143;
        Fri, 16 May 2025 11:12:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3632a2bffsm1929332f8f.32.2025.05.16.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:31 -0700 (PDT)
Message-Id: <2c1d847987285ab98abb6a21d7dcd0bbed750d75.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:12:00 +0000
Subject: [PATCH v3 10/13] pack-objects: refactor path-walk delta phase
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

The current implementation is not integrated with threads, but we are
setting it up to arrive in the next change.

Since we do not attempt to sort objects by size until after exploring
all trees, we can remove the previous change to t5530 due to a different
error message appearing first.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c       | 83 +++++++++++++++++++++++++-----------
 pack-objects.h               | 12 ++++++
 t/t5300-pack-object.sh       |  8 +++-
 t/t5530-upload-pack-error.sh |  6 ---
 4 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index bdd20c074a9b..c7bf3fbc0267 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3237,6 +3237,51 @@ static int should_attempt_deltas(struct object_entry *entry)
 	return 1;
 }
 
+static void find_deltas_for_region(struct object_entry *list,
+				   struct packing_region *region,
+				   unsigned int *processed)
+{
+	struct object_entry **delta_list;
+	unsigned int delta_list_nr = 0;
+
+	ALLOC_ARRAY(delta_list, region->nr);
+	for (size_t i = 0; i < region->nr; i++) {
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
+				  size_t start, size_t nr)
+{
+	unsigned int processed = 0;
+	size_t progress_nr;
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
@@ -3261,6 +3306,10 @@ static void prepare_pack(int window, int depth)
 	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
+	if (path_walk)
+		find_deltas_by_region(to_pack.objects, to_pack.regions,
+				      0, to_pack.nr_regions);
+
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
@@ -4214,10 +4263,8 @@ static int add_objects_by_path(const char *path,
 			       enum object_type type,
 			       void *data)
 {
-	struct object_entry **delta_list = NULL;
 	size_t oe_start = to_pack.nr_objects;
 	size_t oe_end;
-	unsigned int sub_list_nr;
 	unsigned int *processed = data;
 
 	/*
@@ -4250,33 +4297,17 @@ static int add_objects_by_path(const char *path,
 	if (oe_end == oe_start || !window)
 		return 0;
 
-	sub_list_nr = 0;
-	if (oe_end > oe_start)
-		ALLOC_ARRAY(delta_list, oe_end - oe_start);
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
 
-		delta_list[sub_list_nr++] = entry;
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
-	if (sub_list_nr && window) {
-		QSORT(delta_list, sub_list_nr, type_size_sort);
-		find_deltas(delta_list, &sub_list_nr, window, depth, processed);
-	}
-
-	free(delta_list);
 	return 0;
 }
 
diff --git a/pack-objects.h b/pack-objects.h
index d73e3843c92e..51e1ff6b95bf 100644
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
+	size_t start;
+	size_t nr;
+};
+
 struct packing_data {
 	struct repository *repo;
 	struct object_entry *objects;
 	uint32_t nr_objects, nr_alloc;
 
+	struct packing_region *regions;
+	size_t nr_regions, nr_regions_alloc;
+
 	int32_t *index;
 	uint32_t index_size;
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 16420d128639..c8df6afd7844 100755
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
index 8eb6fea839a6..558eedf25a4c 100755
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

