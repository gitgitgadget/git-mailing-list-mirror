Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558A1A9B29
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571472; cv=none; b=AVu02oRkTqkuKYAB7NVyhekEPEeqTj99TRNs/SHK3XLGcg7XQTdsmYwyzufOmyX2pngG7C2aDdJodJ7qcycn/0oZDyHDahI1sE5CoDq08jbUa7rlDn2tdKHN4x3TZeuUu3NbYHCZ8ExEPm5jqCwlkax3WqF/Mfg6sa4BXy0ebyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571472; c=relaxed/simple;
	bh=2KiRz8PnBOBKJ6h6tI9UMqdpm8fWJ3Yl+f7EPECWwzw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rZvznYyM7o7b5wn8yqxSunXKASLLjrGovR9GpXa/+cDQ3CPHqK+6EZL6a2MrfXl0ybMF3Khvg/2naTcML/rb+aJ11TVWPV9Oun9ku8EmEXNsIfrn0PX11hbH29W+6os2CX5jCPCNueMchdasytTn7Y1/s8TKu0H0tquW4P3GXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb9zdDrS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb9zdDrS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25520a289so423151266b.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571464; x=1742176264; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNPSb1VIulS3Hy35Fbd8LQ5mGhKLnk92XgHQch5UgP0=;
        b=Fb9zdDrSZEZH/P3yVKv78rGUa0OEATorQxZoey8M+H0Xeg4fSR/AZx3tndLJGc+VZN
         o3rNfk6eBgJhfzijeQlcTE9yFZ1JeSkVTPhIPJ1+4vbLtxRlR05kF3BV+grYQHV7GhgG
         XSYN0FvCOVvZzqQma7hy9WTDrgQ0OFhiPZKQ4cb6Yr+cGbNn3LYYfhQKaofsF/YVYtNn
         Iqw9YA8OJ/oLJt4zltrMuNmip25nqPE7QuQJm7oyWVR9s0Ep4ftSayouDJydJZGJQD2E
         dG4kyqkkSV6jV45YvVlf3v3o+vuBXGL+qvLLp5ul3cz5/h8wopcS45NwIu/ukXzfk+6U
         1QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571464; x=1742176264;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNPSb1VIulS3Hy35Fbd8LQ5mGhKLnk92XgHQch5UgP0=;
        b=Kn3oPxrDvpEy4urFbHc3GlK5Hxf9VyYdk536CugqlvWf/PFQBLF8OTGm090O6HUmiQ
         wVhxfnva5AWMp4RuFTTydCwIUCUOG+/x5gSIMQUZnOk4AFiAVOTLwsQg2RcfyGg8EaJK
         CU200bex7TJejF0F7eKaK3n2RWC1mAYEnf7xaHCpVh4a4MX9kSoKIVJaK/2/7ZDqWn4M
         YzQFcWkvT6roAEuu4s86LTAjxiJr6baNAF4j+/I8M9OHs/0ooM+NbLYBcvPdUcnozp4F
         JLT78paNgqopuZ2wBGuMXHydA93QWb7mlo7beqMZHQzH88b3yjb12WCH6+GSHNc/OVw3
         U+/g==
X-Gm-Message-State: AOJu0Yy9a8csmZ/34sCYfVSjeEHvzUi4H1JhnCaru6TFz97yvlHa1d1X
	S5USL9MIde7kMd2UdYfqU4whl7uMShm3Y/bTUw3cogbjvW/6MeS7vRy65Q==
X-Gm-Gg: ASbGncsD37y0VAJB2juT9zSY4T8FI7HwKX4cDjW9AqTc71EfBnrhclxaVgQBYhlIs2B
	1gWp9P6u/QpY1//vOeIn8fkm87jGEU3gf/GKHmlNr6Q2tDO8mmDobyXc/2BfgvcF3Ux13+6uxr/
	Vqd2y4MrCM2BgdxYwc+p+QXNtx6XU1KISAIcTjFv7d7UHCWlcvr1Ho+Y0r0xa+fzyh+vCXzD5I/
	I143O32ggpY6rkfYtapLyPXnWAdH7lnhGR7kgoLHm9+Wjh0QQgAMwiu7iOHtSLug73W31ZGEY8M
	+8ttXCqAKarGCmwsbxPcVBOGkXWflMcHA8K5CSqb77pzgDQyvETsa1ti
X-Google-Smtp-Source: AGHT+IHkZV5idnr0t7nT+qcjnKizL6cIHdpDM3Yy3bupk0uiDPWKBnTwOLJIX4zYfUkJ1OvIwHJFrQ==
X-Received: by 2002:a17:907:94cb:b0:abf:40a2:40c8 with SMTP id a640c23a62f3a-ac252ae1b6emr1184648066b.28.1741571464364;
        Sun, 09 Mar 2025 18:51:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac296fac99bsm158934466b.146.2025.03.09.18.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:04 -0700 (PDT)
Message-Id: <c047fbd7f275ef79695b5e1356075705e6fd7bc8.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:52 +0000
Subject: [PATCH 10/13] pack-objects: refactor path-walk delta phase
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
index c756ce50dd7..c5a3129c88e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3233,6 +3233,51 @@ static int should_attempt_deltas(struct object_entry *entry)
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
@@ -3257,6 +3302,10 @@ static void prepare_pack(int window, int depth)
 	if (!to_pack.nr_objects || !window || !depth)
 		return;
 
+	if (path_walk)
+		find_deltas_by_region(to_pack.objects, to_pack.regions,
+				      0, to_pack.nr_regions);
+
 	ALLOC_ARRAY(delta_list, to_pack.nr_objects);
 	nr_deltas = n = 0;
 
@@ -4210,10 +4259,8 @@ static int add_objects_by_path(const char *path,
 			       enum object_type type,
 			       void *data)
 {
-	struct object_entry **delta_list;
 	size_t oe_start = to_pack.nr_objects;
 	size_t oe_end;
-	unsigned int sub_list_size;
 	unsigned int *processed = data;
 
 	/*
@@ -4246,32 +4293,17 @@ static int add_objects_by_path(const char *path,
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
index d73e3843c92..1b01304f9c4 100644
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
+	uint32_t nr_regions, nr_regions_alloc;
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

