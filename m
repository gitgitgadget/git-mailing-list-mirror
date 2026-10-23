Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740395;
	b=GlbYQuMb7q1KigoYAfdDRLToFg+hGJJd1km+cdEVpcBIfsMRDWm4hCsxW+Hq+nGvOS3v
	 8qsWJuC7hndMDS81fb3gBQYJAb60xoAK8ZwYTmmJfqBSyzbVYvqk95kJT1wDrhaYV1MWd
	 vpNd2zcMCwvdH1go0vQlLXaqC1USvmqCliMBPKqJtMXsTJ+kUB/48MNSYVX62JSf6wUyS
	 6FH/Oz6yNiiWBXfgpeL4AdUHkBTijy8TqXrbVvItnchu+FEX/5fU/dFC6yic0Wk8Gl8K0
	 G/cd2DyzgnzsREFnytHtH7tR9mFXuFamsPa6hIw9bnZKjYf/3scST8FFmzRcOYQhlhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
	b=WI5exqtGvQ0w+xfkE6WgdG+SHu1uv9isaYFAsQZodulFZcvTY/p+SGTMmJYs6HBiErrI
	 rY9PGO6RxYDnljMBMbF+YioClGFUKnZZYURoEVv+c2/y9dfg8p07FECcpyTXqPWHLunWh
	 9nAwxYCWg4ek43sHBEYH45x+A2uEyqmpf2ATLTDrm9JvuJefdftdWjaQ9hGOBGJRfvKws
	 484EzxNKl6H+pDsEsYfsSlWPAYja171ZTZjLzq/POyEFLGw5Fg6kaBG+XeHz8T3dBOAnl
	 REkhl69z6haKD6EZkltGELaQBI9TqA3y1TXctubeuXPVzbifwS7cDhZNB9GM7NfmpYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WOWzx2l5;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3F6606A335
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B3F6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WOWzx2l5
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e0d1da913so368937f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740394; x=1793345194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
        b=WOWzx2l57VC8LHoRZIdESO7i9ldhcYylqn2j1kGxw0NTaX8E73K0Etx820EvKtJgcy
         54/n+Mgh+Ydt2YCFbATOqQ1Fv4IM5FITzTyMadCkLaF6xXe0a+tzZQFqZIKJVI7V/kU+
         SW+W6IAtnm+Ojd8r8nhERWfZ26IuEruyitA0f9QtmjF6Iyq5aScfsQwla0ztISaO+MxJ
         MUtzy83r/YmVDgcelJBLIWknvg7s5SKdBWetORRAOFUBx8Nez4tOWAc06TVPSYZZa+NM
         vM4N+FPtVQKhczEiFnVMu3RkszlZZKEHANpM5QZEv/8biQ/1rmKY85ju8eWND1//Nyd2
         ff3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740394; x=1793345194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TTfSrTJiay6nATm3Ar848tgTtkXAk8lVaf34rPkcYL0=;
        b=T5opvXvhAfFVavGu5VuD0hfCnHSqSWPTXDXJH8kki0xmdfIGkZr9U/R4Znl0I7itLd
         hFgyyvJYo1HcWPM22H7AIr76BUjVPsqUw64DydV5y50it7S6ih4EkpjxjbJOYgjGk1iV
         FfUAgtNGu3itjjjClS1i/Plr9nGOPJMKsEhHZ/u9F6dpMapz81plE3T+sWGlczaRPvet
         zp8qq92k71A77Ztj8tjcnkxwYGT9rfJFGDbr9um2t4iKHte/8Vyb5BPG/eC8UesCuzQh
         dGOZ0APPHJmucS5BjLIEkzlw8wJktFHXe3CCNVv1y9BTkqfZKJWNLDqk7G9KBlNlt6vi
         ySAA==
X-Gm-Message-State: AFq9FYIi8o59dwZuyPy0xyTk7EBblQTg3p/i9QldKxURdkE99j3/WjYc
	+j+raaGXBlfhTYpDY0ZZKWDLngMHid5ltAWBxYiKUQy9r+ifmBlpT3IiNfB9Ew==
X-Gm-Gg: AYBFou0SDhCWQkshMOLH34P1wi86r1ne2G9sU4d7scO1ast30WA1RIrPLjwro5GbJut
	0mU5XfbVGdbL7Vlphpr1J5vmf2lzxnMWF/AvlYrMOIcECIeU82SH+S0+7IGMaQTAufFJ7OI0s6o
	zz+kKvqbNtu+haF7Yw4m8qXSNA+IjY0Zm6R4oVb1caLIhkm5B7WVkBNMaOo+RXbZfyrs65IALuk
	EZ9WoC9vEovWu7VWDguNJh0qNrUvHJVpVwfZRd+9EhXqnmcnvMZeOmnY2vw2PSGMafqZrF8zUyr
	T2R+7so1ShYiIJSG7OLMrMCQGbW6Ud0BCfIRFKThwc8y92MMBflTXvk6m+tyllzTmDA/ykdLtOe
	jT8gQ0bJtByS103vVvUQzE5cVdiFyWCMRvL4bwoskvjcdTnZeY8gIuSZGFCwT7q0v7e1WMzzDfM
	WZrsC6YBpqV3e3sUsRQLnFPcgjlnzI9bflxXzAuyYxiYiGYem158xep6bKN8d7hUEtG9UgZiaCg
	bEoJ/MoDSJBch92qtN0ul89jfbBOZ9Et++iAflvTycHVXlGNzaEEnXw1Mqa05+92RZzEvbvrykb
	0DE52WmvJ6RhtwqZ8x6sqrRCj4Yqg60Wttwt6MVVJywpUSeTk822q1vzDTYRkEsVJP0PLY+Mokv
	cyukhaKSC3kYh3uKix8JlBzE2dg+FfuQQzTiUXCMkPf7VLly9LnS6J6MDI4DKUJsNpg==
X-Received: by 2002:a05:6000:41c8:b0:48d:f9dd:e3e0 with SMTP id ffacd0b85a97d-48e38588df7mr1852108f8f.4.1792740393560;
        Fri, 23 Oct 2026 00:26:33 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:32 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 11/13] loose: map object IDs using pack index v3
Date: Fri, 23 Oct 2026 09:25:56 +0200
Message-ID: <20261023072559.3204273-12-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
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

