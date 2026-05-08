Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBC359A89
	for <git@vger.kernel.org>; Fri,  8 May 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228228; cv=none; b=PUizbNthzMqTB1C8CIDhZU/nlpjNK0T1DqPv1ypz8wmlXHdRRjrufSktuZIpiTrsf0mxwju3rFLNQzy+QD8yrzboJs1zcPZXA/1kT/XrIBZSoJuVOGazRkOyMhn3UCAUMDh49RifM+K+BtMCFXWjZQNtWmFGcZn2h9S1LfrDRWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228228; c=relaxed/simple;
	bh=kQ0Rwrei3exdHfQNJedSUUQjkt3Zay5G7Eci8zNeubk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rBPcvcYp3pNVhb/6IZzQOt3anhY41EzClOqZ2TXeSREQa1atBDTp3DwbBu4kIRY35siYeqAl8tPwtpCMeJb9VNf5273IGp91D5r9zhVIB/i2rH0Lakhuqgk8dZBmB2HfsfiB5V+0173Diuk5eUBECo/sg/X1lDQqechb/obmlJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfVgNVWB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfVgNVWB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee9ec26edaso191192785a.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778228225; x=1778833025; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCMAIkETl52RHpOZfP6vopkueaMN5wOXcSu+c8/I92Q=;
        b=DfVgNVWBgPXEsF9mav46IlFaF/+21Bp0JUFAvEJTrdWTYlRkSSVn9Kt2zNO6TTjE8s
         HbYbpvq9RFW6nvSBBEKzZgyoBOVeyCf0VfL0v4FLNlQUYbD3mKFexneBlu7jhcUEUyll
         y2WG0Z3TLr0lSVUtmzHjsIrYWAN4lwzNHSu4RsUE+YGCMfLGLAmrD9FMlP5lfCYVHu7r
         6lnDfl7oWlZDbemMzDbZOU2bGO+tSW5hp7/1cT5rPvfkhEZcAOZh6u/gSJhbYMbgP6w7
         LBBzvu3unkzaXwTd4DUZemkzKxsh/47WNgPjbT6yRWFbTOg66koDSaK+S0zGFr1dcBMp
         aYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228225; x=1778833025;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pCMAIkETl52RHpOZfP6vopkueaMN5wOXcSu+c8/I92Q=;
        b=ixBPM4br6IQNUm6ewSsAyxia+pzR+AR1prgIfmdmYwN0iJCcqyZ3dFJ+yE9woDIwMD
         lIHsI1+eQXrrr1+i4LVyndoVjREaEYsw9A03C7WLeqMmkm9J2w/6RLBer7Tj04mpI8s3
         iaF8LtDXNpf/nHCDOykESbrscSCGnypBUE88CbMKRZXtVj7NgQ5lyaCRfNBV25g+lPWJ
         24zsoFfpY2XfEDZVMz5DClBO3p1IpwlmHMS1fOTyar7ZimJsuLRBABHhMkmyDCt46B9t
         E8QAVBRc490B+e95RJ1ebX5f6s5ihl7JQ10M6L+Sczs9RGkizRztnfh0r3s+JoS5KFlc
         7mBQ==
X-Gm-Message-State: AOJu0Yy7piGJslx/eXpL+qAx6bl8Xk34fXv0Zh81NKgvIGMjSSbw4tMk
	00zQTM+hc4I8QSb6ED2G6LZghurt3ijSePL0dj5V2CKZwQvNOnTOFbIzAImr+g==
X-Gm-Gg: AeBDieuExiRio0WHqkoFQ2S11qOuj/kCrmkWyHML8sTuYWssf5xBcfAE2ZEL8yaJ1ox
	5WnA/bcCWfNX5b9Hqd+FUahO7Eh7p+Mc19TM4/7GGQdVi8p1GjivACIq8p+JIhQiDdgZn6Ocxvy
	NgFqmlapuJ6hfWZ8LfxVdFD1C9wddC5ih8xfMOw6nH8RqQv9HOtCRcy2VFXGCyV9+kX99Qzbxzx
	EFBZ2Me6F/tgTtYj4O46Dpagm8444dVXVr/sa0ofi/poBVLahlr2DRPJOJZ489VD4OJaOcc++Is
	djDzCgNWGZvJys4q3T/sGtNV+l1dw0CKWdzCThkO5302+T1oYwCO93eRtiZhJiUMKx8S5oTJipk
	wfpsttclGJQ7qqs5JVMfEk139WU7EOyuOUJB2fwn2DDzT9ytKG1X9iXEyLsryfMQ6Sl111KzSk2
	AqizhZvnaoQu95jpDoJKxQQdoqtQ==
X-Received: by 2002:a05:620a:1a20:b0:8fc:5ae9:7741 with SMTP id af79cd13be357-904d67e5c0fmr1734832085a.43.1778228224783;
        Fri, 08 May 2026 01:17:04 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.117.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd04ddesm2177683285a.43.2026.05.08.01.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:17:03 -0700 (PDT)
Message-Id: <2751c21c6e730ac7f0ce9c2606bbd8b56dede11e.1778228209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
References: <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<pull.2102.v3.git.1778228209.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 08:16:46 +0000
Subject: [PATCH v3 08/11] test-tool synthesize: precompute pack for 4 GiB + 1
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The synthesize helper hashes roughly 8 GiB of data through SHA-1 to
produce a 4 GiB + 1 pack (4 GiB for the pack checksum, 4 GiB for
the blob OID). Since the blob content is all NUL bytes, every byte
in the resulting pack file is deterministic for a given blob size and
hash algorithm.

Add a fast path that writes the pack from precomputed constants:
a 25-byte prefix (pack header, object header, zlib header, first
block header), the zero-filled bulk with periodic 5-byte deflate
block headers, and a 513-byte suffix (tree, two commits, empty tree,
pack SHA-1 checksum). This eliminates all SHA-1 and adler32
computation, making the helper purely I/O-bound.

The precomputed constants are stored in a struct fast_pack array
keyed by hash algorithm format_id, so that adding SHA-256 support
later requires only adding another array entry with its suffix.

The constants were generated by running the generic path and
extracting the non-zero bytes from the resulting pack file.

Benchmarks generating a 4 GiB + 1 pack (3 runs each, SHA1DC on
x86_64):

  generic path:   88s / 81s / 140s
  fast path:      14s / 13s / 15s

On CI, where t5608 currently takes 200-850 seconds depending on the
job, the fast path cuts the pack-generation phase from minutes to
seconds, leaving only the clone operations themselves.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-synthesize.c | 202 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index e2faaad7b4..83c40ee02a 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -112,6 +112,201 @@ static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
 	algo->final_oid_fn(oid, &ctx);
 }
 
+/*
+ * Fast path: precomputed pack data for a 4 GiB + 1 all-NUL blob.
+ *
+ * The generated pack is almost entirely zeros with a small constant
+ * prefix, periodic deflate block headers, and a constant suffix
+ * containing the tree, two commits, and the pack checksum.  Because
+ * every byte is deterministic for a given blob size and hash algorithm,
+ * we can write the pack without computing any hashes at all, reducing
+ * runtime from minutes of hash computation to seconds of pure I/O.
+ *
+ * The blob is stored as an uncompressed deflate stream: a two-byte
+ * zlib header, then 65538 blocks of up to 0xffff bytes each, followed
+ * by an adler32 checksum.  The pack header and deflate framing are
+ * shared across hash algorithms; only the suffix (which contains OIDs
+ * and the pack checksum) differs.
+ *
+ * Constants were generated by running the generic path and extracting
+ * the non-zero bytes from the resulting pack file.
+ */
+
+#define FAST_PACK_4G1_BLOB_SIZE ((size_t)4 * 1024 * 1024 * 1024 + 1)
+#define FAST_PACK_4G1_N_FULL_BLOCKS 65537
+
+/*
+ * Per-hash-algorithm constants for the fast path.  The prefix and
+ * deflate block structure are identical across algorithms; only the
+ * suffix (tree, commits, pack checksum) and the commit OID differ.
+ */
+struct fast_pack {
+	uint32_t format_id;
+	const unsigned char *suffix;
+	size_t suffix_len;
+	const char *commit_oid;
+};
+
+/* Pack header + pack object header + zlib header + first block header */
+static const unsigned char fast_pack_prefix[] = {
+	/* PACK header: signature, version 2, 5 objects */
+	0x50, 0x41, 0x43, 0x4b, 0x00, 0x00, 0x00, 0x02,
+	0x00, 0x00, 0x00, 0x05,
+	/* pack object header: blob, size = 4294967297 */
+	0xb1, 0x80, 0x80, 0x80, 0x80, 0x01,
+	/* zlib header: CMF=0x78, FLG=0x01 */
+	0x78, 0x01,
+	/* first non-final block header: BFINAL=0, LEN=0xffff, NLEN=0x0000 */
+	0x00, 0xff, 0xff, 0x00, 0x00
+};
+
+/* Every non-final deflate block header is identical */
+static const unsigned char fast_pack_block_header[] = {
+	0x00, 0xff, 0xff, 0x00, 0x00
+};
+
+/* Final block (2 data bytes) + adler32 of 4294967297 NUL bytes */
+static const unsigned char fast_pack_final_block[] = {
+	/* BFINAL=1, LEN=2, NLEN=0xfffd */
+	0x01, 0x02, 0x00, 0xfd, 0xff,
+	/* 2 NUL data bytes */
+	0x00, 0x00,
+	/* adler32 */
+	0x00, 0xe2, 0x00, 0x01
+};
+
+/*
+ * SHA-1 suffix: tree, commit, empty tree, final commit, pack checksum.
+ */
+static const unsigned char fast_pack_sha1_suffix[] = {
+	0xa0, 0x02, 0x78, 0x01, 0x01, 0x20, 0x00, 0xdf,
+	0xff, 0x31, 0x30, 0x30, 0x36, 0x34, 0x34, 0x20,
+	0x66, 0x69, 0x6c, 0x65, 0x00, 0x3e, 0xb7, 0xfe,
+	0xb1, 0x41, 0x3c, 0x75, 0x7f, 0x0d, 0x81, 0x81,
+	0xde, 0xb2, 0x8d, 0x1d, 0xab, 0x03, 0xd6, 0x48,
+	0x46, 0xb4, 0xb4, 0x0c, 0x60, 0x95, 0x0b, 0x78,
+	0x01, 0x01, 0xb5, 0x00, 0x4a, 0xff, 0x74, 0x72,
+	0x65, 0x65, 0x20, 0x63, 0x36, 0x38, 0x33, 0x66,
+	0x63, 0x63, 0x37, 0x64, 0x31, 0x64, 0x38, 0x33,
+	0x65, 0x66, 0x32, 0x66, 0x65, 0x31, 0x61, 0x66,
+	0x35, 0x35, 0x32, 0x31, 0x35, 0x64, 0x30, 0x31,
+	0x36, 0x38, 0x64, 0x62, 0x35, 0x32, 0x61, 0x33,
+	0x61, 0x33, 0x62, 0x0a, 0x61, 0x75, 0x74, 0x68,
+	0x6f, 0x72, 0x20, 0x41, 0x20, 0x55, 0x20, 0x54,
+	0x68, 0x6f, 0x72, 0x20, 0x3c, 0x61, 0x75, 0x74,
+	0x68, 0x6f, 0x72, 0x40, 0x65, 0x78, 0x61, 0x6d,
+	0x70, 0x6c, 0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x3e,
+	0x20, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
+	0x38, 0x39, 0x30, 0x20, 0x2b, 0x30, 0x30, 0x30,
+	0x30, 0x0a, 0x63, 0x6f, 0x6d, 0x6d, 0x69, 0x74,
+	0x74, 0x65, 0x72, 0x20, 0x43, 0x20, 0x4f, 0x20,
+	0x4d, 0x69, 0x74, 0x74, 0x65, 0x72, 0x20, 0x3c,
+	0x63, 0x6f, 0x6d, 0x6d, 0x69, 0x74, 0x74, 0x65,
+	0x72, 0x40, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c,
+	0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x3e, 0x20, 0x31,
+	0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
+	0x30, 0x20, 0x2b, 0x30, 0x30, 0x30, 0x30, 0x0a,
+	0x0a, 0x4c, 0x61, 0x72, 0x67, 0x65, 0x20, 0x62,
+	0x6c, 0x6f, 0x62, 0x20, 0x63, 0x6f, 0x6d, 0x6d,
+	0x69, 0x74, 0x0a, 0xc6, 0x55, 0x37, 0x6b, 0x20,
+	0x78, 0x01, 0x01, 0x00, 0x00, 0xff, 0xff, 0x00,
+	0x00, 0x00, 0x01, 0x95, 0x0e, 0x78, 0x01, 0x01,
+	0xe5, 0x00, 0x1a, 0xff, 0x74, 0x72, 0x65, 0x65,
+	0x20, 0x34, 0x62, 0x38, 0x32, 0x35, 0x64, 0x63,
+	0x36, 0x34, 0x32, 0x63, 0x62, 0x36, 0x65, 0x62,
+	0x39, 0x61, 0x30, 0x36, 0x30, 0x65, 0x35, 0x34,
+	0x62, 0x66, 0x38, 0x64, 0x36, 0x39, 0x32, 0x38,
+	0x38, 0x66, 0x62, 0x65, 0x65, 0x34, 0x39, 0x30,
+	0x34, 0x0a, 0x70, 0x61, 0x72, 0x65, 0x6e, 0x74,
+	0x20, 0x63, 0x35, 0x62, 0x32, 0x31, 0x63, 0x36,
+	0x31, 0x31, 0x61, 0x61, 0x35, 0x39, 0x34, 0x65,
+	0x63, 0x39, 0x66, 0x64, 0x37, 0x65, 0x39, 0x32,
+	0x63, 0x66, 0x39, 0x36, 0x34, 0x38, 0x39, 0x31,
+	0x34, 0x63, 0x61, 0x34, 0x63, 0x32, 0x34, 0x31,
+	0x32, 0x0a, 0x61, 0x75, 0x74, 0x68, 0x6f, 0x72,
+	0x20, 0x41, 0x20, 0x55, 0x20, 0x54, 0x68, 0x6f,
+	0x72, 0x20, 0x3c, 0x61, 0x75, 0x74, 0x68, 0x6f,
+	0x72, 0x40, 0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c,
+	0x65, 0x2e, 0x63, 0x6f, 0x6d, 0x3e, 0x20, 0x31,
+	0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39,
+	0x30, 0x20, 0x2b, 0x30, 0x30, 0x30, 0x30, 0x0a,
+	0x63, 0x6f, 0x6d, 0x6d, 0x69, 0x74, 0x74, 0x65,
+	0x72, 0x20, 0x43, 0x20, 0x4f, 0x20, 0x4d, 0x69,
+	0x74, 0x74, 0x65, 0x72, 0x20, 0x3c, 0x63, 0x6f,
+	0x6d, 0x6d, 0x69, 0x74, 0x74, 0x65, 0x72, 0x40,
+	0x65, 0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x2e,
+	0x63, 0x6f, 0x6d, 0x3e, 0x20, 0x31, 0x32, 0x33,
+	0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x30, 0x20,
+	0x2b, 0x30, 0x30, 0x30, 0x30, 0x0a, 0x0a, 0x45,
+	0x6d, 0x70, 0x74, 0x79, 0x20, 0x74, 0x72, 0x65,
+	0x65, 0x20, 0x63, 0x6f, 0x6d, 0x6d, 0x69, 0x74,
+	0x0a, 0xaa, 0xb8, 0x45, 0x01, 0x8e, 0xfc, 0xf0,
+	0x2f, 0x9c, 0xc5, 0xcc, 0x4f, 0x6a, 0x1a, 0xc9,
+	0x2b, 0x23, 0xa9, 0xff, 0x91, 0x06, 0xc2, 0x70,
+	0xe3
+};
+
+static const struct fast_pack fast_packs[] = {
+	{
+		.format_id = GIT_SHA1_FORMAT_ID,
+		.suffix = fast_pack_sha1_suffix,
+		.suffix_len = sizeof(fast_pack_sha1_suffix),
+		.commit_oid = "aac43daf40d0377af31aa9c798a4ae8a31b55c1d",
+	},
+};
+
+/*
+ * Try the fast path for known blob sizes.  Returns 1 if the pack was
+ * written from precomputed constants, 0 if the caller should fall
+ * through to the generic path.
+ */
+static int generate_fast_pack(const char *path, size_t blob_size,
+			      const struct git_hash_algo *algo)
+{
+	const struct fast_pack *fp = NULL;
+	FILE *f;
+	size_t i;
+
+	if (blob_size != FAST_PACK_4G1_BLOB_SIZE)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(fast_packs); i++) {
+		if (fast_packs[i].format_id == algo->format_id) {
+			fp = &fast_packs[i];
+			break;
+		}
+	}
+	if (!fp)
+		return 0;
+
+	f = xfopen(path, "wb");
+
+	fwrite_or_die(f, fast_pack_prefix, sizeof(fast_pack_prefix));
+
+	/* First full block: 0xffff zero bytes (header already in prefix) */
+	fwrite_or_die(f, zeros, BLOCK_SIZE);
+
+	/* Remaining non-final full blocks */
+	for (i = 1; i < FAST_PACK_4G1_N_FULL_BLOCKS; i++) {
+		fwrite_or_die(f, fast_pack_block_header,
+			      sizeof(fast_pack_block_header));
+		fwrite_or_die(f, zeros, BLOCK_SIZE);
+	}
+
+	/* Final block (2 data bytes) + adler32 */
+	fwrite_or_die(f, fast_pack_final_block,
+		      sizeof(fast_pack_final_block));
+
+	/* Tree, commits, and pack checksum */
+	fwrite_or_die(f, fp->suffix, fp->suffix_len);
+
+	if (fclose(f))
+		die_errno(_("could not close '%s'"), path);
+
+	printf("%s\n", fp->commit_oid);
+	return 1;
+}
+
 /*
  * Generate a pack file with a single large (>4GB) reachable object.
  *
@@ -127,7 +322,7 @@ static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
 static int generate_pack_with_large_object(const char *path, size_t blob_size,
 					   const struct git_hash_algo *algo)
 {
-	FILE *f = xfopen(path, "wb");
+	FILE *f;
 	struct git_hash_ctx pack_ctx;
 	unsigned char pack_hash[GIT_MAX_RAWSZ];
 	struct object_id blob_oid, tree_oid, commit_oid, empty_tree_oid, final_commit_oid;
@@ -139,6 +334,11 @@ static int generate_pack_with_large_object(const char *path, size_t blob_size,
 		.hdr_entries = htonl(object_count),
 	};
 
+	if (generate_fast_pack(path, blob_size, algo))
+		return 0;
+
+	f = xfopen(path, "wb");
+
 	algo->init_fn(&pack_ctx);
 
 	/* Write pack header */
-- 
gitgitgadget

