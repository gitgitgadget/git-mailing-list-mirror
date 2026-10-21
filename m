Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564402;
	b=19J/Gox5J6ydhuoTImKIii3mMaMxZzsXI1UyqQ/0ZvGvrADwi0yzC1SN2G6Z8G++uVgV
	 WoZv5GzRAUR5WzkwLlhTv8A3CTTX3ROy/6V/1OqpnWOJ2m30wAj0wTHms13hupKgQFFRl
	 U/2RothB9r831eDlnUGLGd3rsFLx3mL8zyY65UX6xEclARN58jBN2+be5ICFTpw99sEU9
	 Cf88+MHfoayVR0oQp7blJ+KkETiK8rDWQQaCpKwT6RTWPTHRPAw/k9T0QuX4sCh8J2iZ7
	 J0qnrnZoQdMcX2UqEoTuVMLKxvCWsH1bWTiBsc4OEHF/Yhnwt8R6aHTz92ndEvJxOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
	b=iO3QPa6d70iSQ5Q0xMxLPymQ1ijq1wRtlmYaIYPlW+0w/ixnX2wy0V9fmh0d+GvEUZhB
	 JOVLglkAj3f61gwaXpDEKBKxL+lmbScjtcTaL91uldHTOKJ/SQ+soGQVX6HmFzvUh3uJw
	 tiVS/Xtt8y1JeUOOqrDjGPnoRzbKZiILvaMkfCo5IEhMB+RPKT4rGWH0UzXMG/+jO5XQN
	 3VfdU9+vYSYEpY1TpJVkfy9pH0otyExWnwm8ef4Q1neSpexYJwdVU1bk7LGZIFiXfDg6Z
	 cFTSf7l3QBgInZN8m+a9m0n3UUWMYO07c1EjmGT+gaj4oaiaq0CxmED/j8d9UJgusAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fT/VdblO";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DFA60A2625
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DFA60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fT/VdblO
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48bbb06e746so133552f8f.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564400; x=1793169200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
        b=fT/VdblOY+vRYUL0yEDRiyiog74uXxsppQ1lFj+YW8GNNPWi5BrSyNuhTrIE12p5I4
         iZDn1zSPvTEfmcwLYJ/XUKPOpMOnA0HKfHf2pfeUWk5DZtEGPU1jIL7VBjayCqn7e5E0
         ETncuXByqB4/Y1gGWyL+v1V4FKjGvsezDUmx88f5I/2V3ntl5Aescatnl4Bsr1JaZtrN
         4nh7IPP2Y+rGbmcrs9kNrEeysNyTZTR49eBxIjL+Om96TP45L2cLMN8kUspuLRD7wsVe
         c0fKjHrvJc48iH6/qTOMPlossheDT8jvMm5Qb/CWcxjMUTUeNAFZLvRjPytfVpeWXdH+
         4VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564400; x=1793169200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
        b=ofhF3ccmyBtTSbdmzoJNzYK1KsOlPOjhX3tjALkjS4pnnAL27V1PB0S219G8a2tDTN
         4OaITqjzlNR1kGwTauualNV3n1viiMNMJ7vT7aNd2kWQ4l7lPCmm4Bc2mLrP1ilPIRNc
         6kAI9PLVHVVPimEiZLaVrtAOWLoAmEf6Pj1xiu7WzuyEP8hGUJR9H7I/gvXYCEUZ3oy6
         1jSehQE30+68gl8FApU/xRI8HQtKfFjLuqp0BVeXZVat0GBfOCtVeC4PPku/6PALSt3/
         qhbrh7nEymPQI8S2m5ogrHyvl9pm8b5ncchWC2uPOsb7ahhATn2NXcD+ic2GXD/rpoPp
         Jb1w==
X-Gm-Message-State: AFq9FYKBWBJpS5ti0lxQk98CVcYetY2Pggm7MuM37BDAWbNw1X+hqR5j
	63+D6Ghy1qrA6OMJr6KtkHRBmaU8HjgoVzpzx1R2giblteiLxWqDEbo2qb/F1g==
X-Gm-Gg: AYBFou0Gka+jPxAsmuKufuxjBV5qFfWU/Ph6+L6B2idXe9fHK2Y07UmXswos98VxQ9m
	E+gpE02ESDUXWU+mcQkGR33pMIYPMIyc0c4eKQKTqjbWsZ2cudoBb1a0rWOIy/eDOCOGpAA4UFK
	xZ2Bw9HYkFYGwSzLlYEIOBEy6GkWNijDE0vdBYE1QWGbO9xfvRVSdncqoXaJn0O5YuySuAzBU6i
	D2B9gN4+sdy2oyTZhvN7dx7HCAeoTpt7cbsvxcimnQ1i1nR9Lc4RbApztwqRbl0xYANKVeMyNFL
	q+yGGhx5GXQW/uR9aNvr3fIpqVAIUyFBTWsSSu7gGpmE0lVtw/IRcQblPQDfCfq8JglyppwiqYE
	tsHll832PEZe28x5pf0g0id0uBCpXdinV4FHWnQ2HunXi8fY/AfimV4XBOM51Z2LDvI3pUONh1N
	sO4+trO0H4XQKsZ33nuicbl9QDj9PnBriaJZYzjM+ifYlR2Iis16yrDCBr1PntKbNZznVRhXKwb
	YrgcZfBf1N1E5DzEffzyYU7r0g1rMv4GXdJYDLFGjcOrmBc5EFme84qKhin2VG9k7tFGYTSHfSa
	8kdqL1WJZb9AIkiaNj14zmcA8Bb1x8uFmjaF2r5gdDpC/JD34IJD3c4STvnF2N5xbec/g1pz4r5
	sokVAyFz4HKQSR+m3qMGHQCIac6jeEXKzSA5bZX54TbciVwDWcBZ4Ade9Ahtxj4r3Pg==
X-Received: by 2002:adf:ecc3:0:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-48e264e0fafmr1375022f8f.25.1792564400168;
        Tue, 20 Oct 2026 23:33:20 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:18 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 11/13] loose: map object IDs using pack index v3
Date: Wed, 21 Oct 2026 08:32:43 +0200
Message-ID: <20261021063245.2917625-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com>
References: <20261021063245.2917625-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Right now, we can only map an object if it exists in the loose object
map.  However, we have a perfectly good way to look up packed objects,
which is the pack index.  Let's use that to look up any packed objects
if they're not in the loose object map.

In order to do so, let's add a variant of nth_packed_object_id that
handles an arbitrary hash algorithm.

Only pack index v3 stores object IDs in more than one algorithm, so
skip packs with an older index when mapping.

Also make the new variant fail when the index cannot provide the
requested object ID, for example because it has no data for one of the
algorithms.

Add a test in t1016 to check that packed objects are mapped using a v3
index, but not using a v2 index, when the loose object map has no entry
for them.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 odb/source-packed.c           | 30 ++++++++++++++++++++++++++----
 packfile.c                    | 28 +++++++++++++++++++++++-----
 packfile.h                    |  8 ++++++++
 t/t1016-compatObjectFormat.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index ee1edfdb2b..4ecc2de818 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -863,12 +863,34 @@ static void odb_source_packed_close(struct odb_source *source)
 	packed->midx = NULL;
 }
 
-static int odb_source_packed_map_oid(struct odb_source *source UNUSED,
-				     const struct object_id *src UNUSED,
-				     const struct git_hash_algo *to UNUSED,
-				     struct object_id *dest UNUSED,
+static int odb_source_packed_map_oid(struct odb_source *source,
+				     const struct object_id *src,
+				     const struct git_hash_algo *to,
+				     struct object_id *dest,
 				     enum odb_map_oid_flags flags UNUSED)
 {
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct repository *repo = packed->base.odb->repo;
+	struct packfile_list_entry *e;
+
+	for (e = packfile_store_get_packs(packed); e; e = e->next) {
+		struct packed_git *p = e->pack;
+		uint32_t off;
+		const struct git_hash_algo *src_algo = src->algo ?
+						       &hash_algos[src->algo] :
+						       repo->hash_algo;
+
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+		/* Only v3 indices store object IDs in both algorithms. */
+		if (p->index_version < 3)
+			continue;
+		if (!bsearch_pack(src, p, &off))
+			continue;
+		if (nth_packed_object_id_algop(dest, p, off, src_algo, to))
+			continue;
+		return 0;
+	}
 	return -1;
 }
 
diff --git a/packfile.c b/packfile.c
index f6e2db45d5..3bfd427c6c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1861,9 +1861,19 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
 int nth_packed_object_id(struct object_id *oid,
 			 struct packed_git *p,
 			 uint32_t n)
+{
+	return nth_packed_object_id_algop(oid, p, n, p->repo->hash_algo,
+					  p->repo->hash_algo);
+}
+
+int nth_packed_object_id_algop(struct object_id *oid,
+			       struct packed_git *p,
+			       uint32_t n,
+			       const struct git_hash_algo *src,
+			       const struct git_hash_algo *dest)
 {
 	const unsigned char *index = p->index_data;
-	const unsigned int hashsz = p->repo->hash_algo->rawsz;
+	const unsigned int hashsz = dest->rawsz;
 	if (!index) {
 		if (open_pack_index(p))
 			return -1;
@@ -1871,17 +1881,25 @@ int nth_packed_object_id(struct object_id *oid,
 	}
 	if (n >= p->num_objects)
 		return -1;
+	if (p->index_version < 3 && (src != dest || dest != p->repo->hash_algo))
+		return -1; /* older indices only store main object IDs */
 	if (p->index_version == 1) {
 		index += 4 * 256;
 		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
-			p->repo->hash_algo);
+			dest);
 	} else if (p->index_version == 2) {
 		index += 4 * 256 + 8;
-		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
+		oidread(oid, index + st_mult(hashsz, n), dest);
 	} else {
-		int algo = hash_algo_by_ptr(p->repo->hash_algo);
+		int algo = hash_algo_by_ptr(dest);
 		const struct packed_git_format *pfp = &p->formats[algo-1];
-		oidread(oid, index + pfp->full_oid_offset + (hashsz * n), p->repo->hash_algo);
+		uint32_t pack_order_idx;
+
+		if (!pfp->data_offset ||
+		    !p->formats[hash_algo_by_ptr(src) - 1].data_offset)
+			return -1; /* no data for one of the algorithms */
+		pack_order_idx = nth_packed_object_pack_order_algop(p, n, src);
+		oidread(oid, index + st_add(pfp->full_oid_offset, st_mult(hashsz, pack_order_idx)), dest);
 	}
 	return 0;
 }
diff --git a/packfile.h b/packfile.h
index 22278cc6c6..73452b2a43 100644
--- a/packfile.h
+++ b/packfile.h
@@ -289,6 +289,14 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  */
 int nth_packed_object_id(struct object_id *, struct packed_git *, uint32_t n);
 
+/*
+ * The same as nth_packed_object_id, but the nth object is counted in src
+ * and the object ID looked up is in dest.
+ */
+int nth_packed_object_id_algop(struct object_id *, struct packed_git *,
+			       uint32_t n, const struct git_hash_algo *src,
+			       const struct git_hash_algo *dest);
+
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index af9532aa1f..030d6000b5 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -242,6 +242,33 @@ do
 		git -C large-repo cat-file blob :large >actual &&
 		test_cmp large-repo/large actual
 	'
+
+	test_expect_success 'packed objects are only mapped using pack index v3' '
+		test_when_finished "rm -rf map-repo v3.idx loose-object-idx" &&
+		create_compat_repo $hash map-repo &&
+		echo content >map-repo/file &&
+		git -C map-repo add file &&
+		git -C map-repo commit --message A &&
+		oid=$(git -C map-repo rev-parse HEAD) &&
+		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >expect &&
+		git -C map-repo repack -a -d &&
+		pack=$(echo map-repo/.git/objects/pack/pack-*.pack) &&
+		git -C map-repo index-pack --index-version=3 \
+			-o "$(pwd)/v3.idx" "$(pwd)/$pack" &&
+		mv map-repo/.git/objects/loose-object-idx loose-object-idx &&
+
+		# A v2 index only has object IDs in the main algorithm, so it
+		# must not provide a mapping.
+		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
+		! test_cmp expect actual &&
+		test $(wc -c <actual) -ne $(($(test_oid --hash=$(compat_hash $hash) hexsz) + 1)) &&
+
+		# A v3 index provides it.
+		rm -f "${pack%.pack}.idx" "${pack%.pack}.rev" &&
+		mv v3.idx "${pack%.pack}.idx" &&
+		git -C map-repo rev-parse --output-object-format=$(compat_hash $hash) "$oid" >actual &&
+		test_cmp expect actual
+	'
 done
 cd "$base"
 
-- 
2.56.0.215.g47fdf2208c

