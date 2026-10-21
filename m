Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792564394;
	b=mLWHuU3iLBJS6a0shJpgnR9+7QUfcbj/33xxP+dQjDrnFqZSspvln8p3Bhx/tLA/tMyp
	 pINSAkal+Mz3w5+CL0QLodbGniJM0FVVeYVOtISmnKy8eGP2LEn4XE4loWusuEaYkm9pZ
	 WvR3vM3zByyS0w8+j2N3T/N8SiVoExzEcD+4hJgLvu3aTFH8YhVPLPTwEsw+wZpvlKNI6
	 yI93FhsNnjsTcxI5gDK9J2Nuze90r7uCzkSG0VyoQCDEW+GtqNp+fWkchmBqPDA4sLncK
	 hL8yH813Z0S0tJdjQ6b1MzRcQitd7eFE7X59f2V7RB7pJk3d0bYuhKL/TqKSHw3hxSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792564394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qoRAQZPc/h4KGwnPHcofENj+2KHNOCX4qQasKT+lYpA=;
	b=KpfEUUiuF5LJiMZ3yXubBfoRQ6ly8kr6KeStTwTiTHkfNA9uFYb0b5AgKG6fQzXhOMlw
	 eQNEeziNT0Do5Nxj0En5YHY1hvgVvWCd8xubl7dqiqYCRjhyB5Xv9wp9bx+DaRf+faz4L
	 2jczWe2shmy4cBrWjsexrPmB/s+msM/0U5uVnXssPswmy8jO36PdjDVHmlLt13/OiH4Dv
	 vlmicikm1KY3a58P8/WUyatdf0dt4fgb4urpzt7VPwKQSPAHrMAOAxf7u9lq1E9YjhHxM
	 jiv/oAdXFGxAvn64CzffTYfSEsOJ5dSNxlOWwpV7tQG/shcObmu7l9qrGKS0kccXsXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6buQZXW;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E66606A33E
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 06:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E66606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r6buQZXW
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-487049569b6so176415f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792564392; x=1793169192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qoRAQZPc/h4KGwnPHcofENj+2KHNOCX4qQasKT+lYpA=;
        b=r6buQZXW3ZkIrAosxhrhmfgqLnSnlpCnApCxjzO1SrQ2sSEEbWxdpHHYzwTKG//kv4
         t6E5a7pYLi+xLjF56yCw8lKbm0vTHwq5e2UA1eBifreb+RvDk4GiquxYE5+Y4H70Mzx3
         A8zorrA2QJVpobzJHAMqZpMbL1ni8TrUepBaZUJc6dAm/fckyHKvOYxFzkfoKHVhmf1T
         jI/8B1wvNVAcHf4Q3AHf2EMCH9UsptlapEFIhyG3rS0fvwC2wTZvuv1/dz2gwe1ec6pI
         O0TwzqkoXhngJBr/ffYZzQinyv2t0oNT9FrEPhjwjPWA37D8FD7+9BxlBDuHfv8O/xfw
         dQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792564392; x=1793169192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qoRAQZPc/h4KGwnPHcofENj+2KHNOCX4qQasKT+lYpA=;
        b=x+CU+INqMyCf0/lwgZm5JmeUUhzvyeY+AhUvhSZotsr7sig+4vTIXNRNJSJJKNXTVT
         g6W9al6HVcRzaOMRqfIVOfS49q7wbm5pvm6e4l8vUph3cZ52Alu7hXvDhDpaPNJU89CR
         aT7RXuqV1uwiRAdD3x55WETFxIzUkihRqcXGvU9Mw8LIzrwv3TKUQ26fR8pVOaJIVvh8
         qC8n2LUM9uz7mQgBRlIUTRWbzd51oxqTHsrRSWWk0jCXL2a/FOQhb8yOjGgM4AFA6I9q
         iP2K5gjZK6OCnuxhEpH4YNhhJHYkNdlcndzGwmt8aJ3yvZOS8PLLDTwGtmREKJEGErk0
         xm5g==
X-Gm-Message-State: AFq9FYKFKFVXu9vfHPB2XzZVSEqGR6fXY9ZR2eWlnb2IGaNDWIRBQpSr
	s5yJU1Zti3wyN+YFI16ULuC7ox1Cf0gqTKGP2eeStVcQ2k98L1shlwRD6gcfcw==
X-Gm-Gg: AYBFou0OedhSNQVy4yccoX6D5Gfhgk03x83L8L0PUMYzK0pmd7R8VDTi6ZOHMn7fBLl
	q7PnJ97+hTPDUxGNLDj6TcKE86dQ5ANlFxivNOftVOguCYZTR0M+139W6xs/nqJQEAlwUwm36dJ
	i8Arp/JfVVzLu5cI6ilnxxltig2zSbK22OfHvTFUYhGIPyna86RWrffuOD6VH7YBnTiP/99LAhS
	gkJy624MDuk1Jwv/RQZBWQyVEgSmXauXKASMFgbasvlvWxWP9VBDvZO2/yfJO+sFlFBUGNDxOo4
	AoyETxkt3OmB2PpwO6CAyUycx6VukATXzCU+96Y/kETRm0vfAnditT6SxS3zuUGJW/Kz/lW7Q6W
	VIhbH3EP64evIozBeLV7ce78WxlWmEFDBPkgn0n1oCki/9CAPsgSwBZjsbIB7KpGQ9hIB/4gWcR
	/fTOrtIU1ihEKC0dMFENWbWFTUcRJA+q560zXD/LNMdYs2OmXgcGjwzde5VszVj3XBkABmQF9rh
	M51BNF21fR2wdcsuStZ9+MDRjYtAXSkq0dYXeuQLorsG6dlh1xoJdLUoJwz+738uu0ihePkMBUY
	qCOu0xcAJbFUKJ8pXCb0tIixbEjBxVQoBRdF7OGs9qAzyKFtn9MqFf7SXFXZeKfWhGqPcLpdHRV
	84ccbSgIww2A/G8+PjT0h30YyIUN1rMXjV5NR6bfVni21/bOlR4vM9s5/3kkYVyzZnVQ6iB5mKM
	uOuBluPnfjTTM=
X-Received: by 2002:a5d:4573:0:b0:48d:ef7a:e59f with SMTP id ffacd0b85a97d-48e264ab28amr1382437f8f.17.1792564391779;
        Tue, 20 Oct 2026 23:33:11 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581eedesm3130790f8f.14.2026.10.20.23.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 23:33:11 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 06/13] pack-write: add support for pack index v3
Date: Wed, 21 Oct 2026 08:32:38 +0200
Message-ID: <20261021063245.2917625-7-christian.couder@gmail.com>
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

As part of the SHA-256 transition plan, we'll be adding support for pack
index v3.  This version supports multiple hash algorithms so we can
write both the SHA-256 and SHA-1 object names into the same repository.

To do so, let's add support for the compatibility object ID and the
entry number into the index entry structure.  We then use this
information when writing the pack.  There is no code to populate these
fields yet; this functionality will be coming in a future commit.

We always choose to write the minimum amount of padding that is
necessary to cause the end of the short object name table to end on a
multiple of 4.  Git reads many tables as 32-bit values and if we didn't
do this, the operations would fail on architectures which don't support
unaligned access and would be slower on all other architectures.

We choose to always write the main hash algorithm first in the pack.
This optimizes for the case when we're interacting natively with the
remote side by permitting us to use the CRC32 entries.

Note that we never write index v3, since we cannot read it yet, and
doing so will break the tests.  In a future commit, once we can read it,
we'll enable it by default when a compatibility algorithm is enabled.

Index v3 needs the objects both in pack order and sorted by object ID,
so when writing a v3 index, sort copies of the array instead of the
array itself.  Callers, like the bitmap code in pack-objects, rely on
the array being sorted by object ID when write_idx_file() returns,
though, so sort it before returning in that case too.

When asked to reject duplicate objects using `--strict`, look for them
in the arrays sorted by object ID, where duplicates are adjacent.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 pack-write.c | 263 +++++++++++++++++++++++++++++++++++++++++++++------
 pack.h       |   2 +
 2 files changed, 235 insertions(+), 30 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 85674e4b72..1834394a77 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -22,13 +22,20 @@ void reset_pack_idx_option(struct pack_idx_option *opts)
 	opts->delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
 }
 
-static int sha1_compare(const void *_a, const void *_b)
+static int oid_compare(const void *_a, const void *_b)
 {
 	struct pack_idx_entry *a = *(struct pack_idx_entry **)_a;
 	struct pack_idx_entry *b = *(struct pack_idx_entry **)_b;
 	return oidcmp(&a->oid, &b->oid);
 }
 
+static int oid_compare_compat(const void *_a, const void *_b)
+{
+	struct pack_idx_entry *a = *(struct pack_idx_entry **)_a;
+	struct pack_idx_entry *b = *(struct pack_idx_entry **)_b;
+	return oidcmp(&a->compat_oid, &b->compat_oid);
+}
+
 static int cmp_uint32(const void *a_, const void *b_)
 {
 	uint32_t a = *((uint32_t *)a_);
@@ -50,30 +57,156 @@ static int need_large_offset(off_t offset, const struct pack_idx_option *opts)
 			 sizeof(ofsval), cmp_uint32);
 }
 
+static inline int last_matching_offset(const struct object_id *a, const struct object_id *b,
+				       const struct git_hash_algo *algop)
+{
+	size_t i;
+	for (i = 0; i < algop->rawsz; i++)
+		if (a->hash[i] != b->hash[i])
+			return i;
+	/* We should never hit this case. */
+	return i;
+}
+
+static const struct object_id *main_oid(const struct pack_idx_entry *ent)
+{
+	return &ent->oid;
+}
+
+static const struct object_id *compat_oid(const struct pack_idx_entry *ent)
+{
+	return &ent->compat_oid;
+}
+
+static uint32_t find_short_name_len(struct pack_idx_entry **sorted, size_t nr_objects,
+				    const struct git_hash_algo *algop,
+				    const struct object_id *(*fn)(const struct pack_idx_entry *))
+{
+	size_t i, len = 1;
+	for (i = 1; i < nr_objects; i++) {
+		const struct object_id *oid1 = fn(sorted[i - 1]);
+		const struct object_id *oid2 = fn(sorted[i]);
+		size_t offset = last_matching_offset(oid1, oid2, algop);
+
+		if (offset >= len)
+			len = offset + 1;
+	}
+	return len > algop->rawsz ? algop->rawsz : len;
+}
+
+struct pack_idx_format_header {
+	uint32_t id;
+	uint32_t short_name_len;
+	uint64_t offset;
+};
+
+/* This struct contains fields beyond the signature and version number. */
+struct pack_idx_header_v3 {
+	uint32_t hdr_len;
+	uint32_t nr_objects;
+	uint32_t nr_formats;
+};
+
+static void write_v3_header(struct repository *repo,
+			    int nr_objects, int nr_large_offset,
+			    uint32_t short_name_len[2], int padding[2],
+			    struct hashfile *f)
+{
+	struct pack_idx_header_v3 hdr;
+	struct pack_idx_format_header format[2];
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	uint32_t nformats = compat ? 2 : 1;
+	/*
+	 * signature (4) + version (4) + length (4) + nobjects(4) + nformats (4) +
+	 * each format: identifier (4) + length of shortened names (4) +
+	 *		table offset (8) +
+	 * offset to trailer (8)
+	 */
+	uint32_t hdrlen = 4 + 4 + 4 + 4 + 4 + nformats * (4 + 4 + 8) + 8;
+	uint64_t offset = hdrlen;
+	uint64_t short_table = short_name_len[0] * nr_objects;
+
+	hdr.hdr_len = htonl(hdrlen);
+	hdr.nr_objects = htonl(nr_objects);
+	hdr.nr_formats = htonl(nformats);
+	hashwrite(f, &hdr, sizeof(hdr));
+
+	/* padding */
+	if (short_table & 3) {
+		padding[0] = 4 - (short_table & 3);
+		offset += padding[0];
+	}
+
+	format[0].id = htonl(repo->hash_algo->format_id);
+	format[0].offset = htonll(offset);
+	format[0].short_name_len = htonl(short_name_len[0]);
+	hashwrite(f, &format[0], sizeof(format[0]));
+	offset += (uint64_t)(short_name_len[0] + repo->hash_algo->rawsz + 4 + 4 + 4) * nr_objects +
+		  8 * nr_large_offset;
+
+	if (compat) {
+		short_table = short_name_len[1] * nr_objects;
+		/* padding */
+		if (short_table & 3) {
+			padding[1] = 4 - (short_table & 3);
+			offset += padding[1];
+		}
+
+		format[1].id = htonl(compat->format_id);
+		format[1].offset = htonll(offset);
+		format[1].short_name_len = htonl(short_name_len[1]);
+		hashwrite(f, &format[1], sizeof(format[1]));
+		offset += (uint64_t)(short_name_len[1] + compat->rawsz + 4) * nr_objects;
+	}
+
+	offset = htonll(offset);
+	hashwrite(f, &offset, sizeof(offset));
+}
+
 /*
- * The *sha1 contains the pack content SHA1 hash.
- * The objects array passed in will be sorted by SHA1 on exit.
+ * The *hash contains the pack content hash.
+ * The objects array passed in should be in pack order and will be sorted by
+ * object ID on return.
  */
 const char *write_idx_file(struct repository *repo,
 			   const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-			   const unsigned char *sha1)
+			   const unsigned char *hash)
 {
 	struct hashfile *f;
-	struct pack_idx_entry **sorted_by_sha, **list, **last;
-	off_t last_obj_offset = 0;
+	struct pack_idx_entry **sorted_by_sha, **sorted_by_sha_compat = NULL, **list, **last;
 	int i, fd;
 	uint32_t index_version;
+	unsigned int nr_large_offset = 0;
+	const struct git_hash_algo *compat = repo->compat_hash_algo;
+	uint32_t short_name_len[2] = { 0 };
+	int padding_size[2] = { 0 };
+	uint8_t zero[4] = { 0 };
+
+	index_version = opts->version;
 
 	if (nr_objects) {
 		sorted_by_sha = objects;
 		list = sorted_by_sha;
 		last = sorted_by_sha + nr_objects;
 		for (i = 0; i < nr_objects; ++i) {
-			if (objects[i]->offset > last_obj_offset)
-				last_obj_offset = objects[i]->offset;
+			objects[i]->idx = i;
+			if (need_large_offset(objects[i]->offset, opts))
+				nr_large_offset++;
 		}
-		QSORT(sorted_by_sha, nr_objects, sha1_compare);
+		/*
+		 * If we're using index v3, we need both pack order and sorted
+		 * order.
+		 */
+		if (index_version >= 3) {
+			DUP_ARRAY(sorted_by_sha, objects, nr_objects);
+			if (compat) {
+				DUP_ARRAY(sorted_by_sha_compat, objects,
+					  nr_objects);
+				QSORT(sorted_by_sha_compat, nr_objects, oid_compare_compat);
+			}
+		}
+		QSORT(sorted_by_sha, nr_objects, oid_compare);
 	}
 	else
 		sorted_by_sha = list = last = NULL;
@@ -95,7 +228,8 @@ const char *write_idx_file(struct repository *repo,
 	}
 
 	/* if last object's offset is >= 2^31 we should use index V2 */
-	index_version = need_large_offset(last_obj_offset, opts) ? 2 : opts->version;
+	if (index_version == 1 && nr_large_offset)
+		index_version = 2;
 
 	/* index versions 2 and above need a header */
 	if (index_version >= 2) {
@@ -105,50 +239,84 @@ const char *write_idx_file(struct repository *repo,
 		hashwrite(f, &hdr, sizeof(hdr));
 	}
 
-	/*
-	 * Write the first-level table (the list is sorted,
-	 * but we use a 256-entry lookup to be able to avoid
-	 * having to do eight extra binary search iterations).
-	 */
-	for (i = 0; i < 256; i++) {
-		struct pack_idx_entry **next = list;
-		while (next < last) {
-			struct pack_idx_entry *obj = *next;
-			if (obj->oid.hash[0] != i)
-				break;
-			next++;
+	if (index_version >= 3) {
+		short_name_len[0] = find_short_name_len(sorted_by_sha,
+							nr_objects,
+							repo->hash_algo,
+							main_oid);
+		if (compat)
+			short_name_len[1] = find_short_name_len(sorted_by_sha_compat,
+								nr_objects,
+								compat, compat_oid);
+		write_v3_header(repo, nr_objects, nr_large_offset, short_name_len, padding_size, f);
+		hashwrite(f, zero, padding_size[0]);
+
+		/* Write the sorted abbreviated names */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			hashwrite(f, obj->oid.hash, short_name_len[0]);
+			if ((opts->flags & WRITE_IDX_STRICT) &&
+			    (i && oideq(&list[-2]->oid, &obj->oid)))
+				die("The same object %s appears twice in the pack",
+				    oid_to_hex(&obj->oid));
+		}
+	} else {
+		/*
+		 * Write the first-level table (the list is sorted,
+		 * but we use a 256-entry lookup to be able to avoid
+		 * having to do eight extra binary search iterations).
+		 */
+		for (i = 0; i < 256; i++) {
+			struct pack_idx_entry **next = list;
+			while (next < last) {
+				struct pack_idx_entry *obj = *next;
+				if (obj->oid.hash[0] != i)
+					break;
+				next++;
+			}
+			hashwrite_be32(f, next - sorted_by_sha);
+			list = next;
 		}
-		hashwrite_be32(f, next - sorted_by_sha);
-		list = next;
 	}
 
 	/*
 	 * Write the actual SHA1 entries..
 	 */
-	list = sorted_by_sha;
+	list = objects;
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_idx_entry *obj = *list++;
 		if (index_version < 2)
 			hashwrite_be32(f, obj->offset);
 		hashwrite(f, obj->oid.hash, repo->hash_algo->rawsz);
-		if ((opts->flags & WRITE_IDX_STRICT) &&
+		if ((opts->flags & WRITE_IDX_STRICT) && index_version < 3 &&
 		    (i && oideq(&list[-2]->oid, &obj->oid)))
 			die("The same object %s appears twice in the pack",
 			    oid_to_hex(&obj->oid));
 	}
 
+	if (index_version >= 3) {
+		/* write the sorted-to-pack index */
+		list = sorted_by_sha;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			uint32_t index = htonl(obj->idx);
+			hashwrite(f, &index, 4);
+		}
+	}
+
 	if (index_version >= 2) {
 		unsigned int nr_large_offset = 0;
 
 		/* write the crc32 table */
-		list = sorted_by_sha;
+		list = objects;
 		for (i = 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj = *list++;
 			hashwrite_be32(f, obj->crc32);
 		}
 
 		/* write the 32-bit offset table */
-		list = sorted_by_sha;
+		list = objects;
 		for (i = 0; i < nr_objects; i++) {
 			struct pack_idx_entry *obj = *list++;
 			uint32_t offset;
@@ -160,7 +328,7 @@ const char *write_idx_file(struct repository *repo,
 		}
 
 		/* write the large offset table */
-		list = sorted_by_sha;
+		list = objects;
 		while (nr_large_offset) {
 			struct pack_idx_entry *obj = *list++;
 			uint64_t offset = obj->offset;
@@ -172,10 +340,45 @@ const char *write_idx_file(struct repository *repo,
 		}
 	}
 
-	hashwrite(f, sha1, repo->hash_algo->rawsz);
+	if (index_version >= 3 && compat) {
+		hashwrite(f, zero, padding_size[1]);
+
+		/* Write the sorted abbreviated names */
+		list = sorted_by_sha_compat;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			hashwrite(f, obj->compat_oid.hash, short_name_len[1]);
+			if ((opts->flags & WRITE_IDX_STRICT) &&
+			    (i && oideq(&list[-2]->compat_oid, &obj->compat_oid)))
+				die("The same object %s appears twice in the pack",
+				    oid_to_hex(&obj->compat_oid));
+		}
+
+		list = objects;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			hashwrite(f, obj->compat_oid.hash, compat->rawsz);
+		}
+
+		/* write the sorted-to-pack index */
+		list = sorted_by_sha_compat;
+		for (i = 0; i < nr_objects; i++) {
+			struct pack_idx_entry *obj = *list++;
+			uint32_t index = htonl(obj->idx);
+			hashwrite(f, &index, 4);
+		}
+	}
+
+	hashwrite(f, hash, repo->hash_algo->rawsz);
 	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
 			  CSUM_HASH_IN_STREAM | CSUM_CLOSE |
 			  ((opts->flags & WRITE_IDX_VERIFY) ? 0 : CSUM_FSYNC));
+
+	if (sorted_by_sha != objects) {
+		QSORT(objects, nr_objects, oid_compare);
+		free(sorted_by_sha);
+	}
+	free(sorted_by_sha_compat);
 	return index_name;
 }
 
diff --git a/pack.h b/pack.h
index ada506b5c5..86b2a8ba7b 100644
--- a/pack.h
+++ b/pack.h
@@ -79,7 +79,9 @@ struct pack_idx_header {
  */
 struct pack_idx_entry {
 	struct object_id oid;
+	struct object_id compat_oid;
 	uint32_t crc32;
+	uint32_t idx;
 	off_t offset;
 };
 
-- 
2.56.0.215.g47fdf2208c

