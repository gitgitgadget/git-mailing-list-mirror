Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CF481FA8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632958; cv=none; b=HCN3kDtgYoBKRXmYrt0PZSIZVQeNLF+CgrykOIxtFYvwlhNQBhkvxpxoFrqS1OZILeSH5CZ//Leq7p060bmnX18JsjMwwPSPhIdLaLcrXiDpkjmFeDcCq4/puLLNqk/NFWP9WLls5jpSABgp3pTerRGa6FPZKKXj6eYZu96fK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632958; c=relaxed/simple;
	bh=XBD/7nxptagjs5H2PpX5CLiH2Z9YzMUXPv/q39eA2BA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=A1yigpMNalA2vSYqxkdg5JKTfv20Ch4Ahk7fy8xItGTU2kIbZRPIWOUbV8uawJC2P22+kBSqhFNXc9sw2IEpn22Gep1RWCpwzB6gXFVc+bwhGXHKnY7qM2O68Zp1luFSGsFUzlS84H8N8btsTnlXsWjoe1garl46z0O5D16vrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZ0iBJLW; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ0iBJLW"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9d7464b71so15279a34.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632956; x=1787237756; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xB9c5ioOsoU7YRqllaZjae3d00lxOg3IiwEUaaVOg2M=;
        b=rZ0iBJLWR3E+SnmkDzqi2dtUhGFQRLx1W50/dmqDWA9jGaKdNvflqMv+WY5CZLovPM
         U/oYe3raCdAeUv2PU7zf4iumXcaPSka5ofIF4TYAIdgxRT7uiBqpQrtq7H93KA7mjktF
         OlSKRH1bSzGRyY9wgAPNvBVlLRvgJ27IlNR28uRlyhPmfOv3pG3gZBSELVyAAmLkpWx3
         CaZgnLFfFqpsoFgf9hN/txgiEnLSipSnsSYNjCmL10FTrKHyGvBq4vYEtUzu0rYufc5Z
         FGJGJmuOCiV/+OroI0pOGKHOakxcrJTRDJ+pZ5tUDrs48sFQKpvBwRtlswkZWzsmXrAa
         DBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632956; x=1787237756;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xB9c5ioOsoU7YRqllaZjae3d00lxOg3IiwEUaaVOg2M=;
        b=IPocQ++qVUebRUigMICW4onpJwGunoSR3bOumlXURmdAlNFUi2QdF1qC8xcBRlS3VS
         vZeQ2JdybZeGbhK+8QU4FCfVBmz5Xv082/i9zRi0+8d5ilbIptTTg97Krd6PmX48dZfc
         UJuzGUqq2Hk1Tx3Z5knIA2tEdhtnnBHgzttYEm7knSNeTL2IUR96mBiXnrdHdulJ4IQE
         7hSfqvJpPC2SkznQQVhSzVeVjXBSADMX0zUfXdlCl8b9YowMlBxcw2m8Tkdr13W6Xez4
         yuw5jPA9eVnerCs6v/BUXsphPXE10AynZn3w6/tr2wzgLl/D/jEXGTvtp1jo3+ndPivL
         GZ4w==
X-Gm-Message-State: AOJu0Yz6AWzaM91rCCyQyOTBjvajZYQCUDyyLL7llgcBmpE5vAEUE9lx
	e2Jc8J99OWJm1YIWCe7GZ7D/MS6gywvuVbtDNbto52B20nL3YoPwuyccsvbnnA==
X-Gm-Gg: AR+sD12KHsih8rAKaSHvtY/Le3lPaHIvRLLXzJxO5/WB78bXvZ4plaTyvVsJERZxIEI
	3ho+QXgfsWGt8njVGzWVXwNCuf7UjvRH1h3fGCJdXiRUd6Pah5+wYVB9I2NKvFuyYublFRboycN
	8LGzoYdJgSYSsfNcwXIOM3j6lTfx4ftbMrRKgcjZdXI1hsAcq9SlyaCtTBaNfPKLwss8hbKAXPN
	XItwQkFQ5AGsZAL6mctDKIQBrHjjEW0X5pfNIP3MFup0EXa/X9cW9TeAVPszWkNSrpd6PBGg8bY
	RjY4zdd+UAalvjlYb75OT+hhGxJsf7uGm4MTAL7LR6kiiQgYQZaOIfogzPhmiMUUjjQKI+loeWx
	MC8GHAoeVTmm5HDZWZgcHB+94uQoeA3pgOua0BkxQfuwTM5akeAaDRFgHaAHCe4PevlyxZfJSzm
	JAW/rPBT3mnteMkBfw02f+xcYsCuQ7ZUW6YDvIeknnP1bMiPEuCucZFYJNpZRm55XQ
X-Received: by 2002:a05:6830:6111:b0:7e6:c9eb:535a with SMTP id 46e09a7af769-7f3ca659be2mr6672438a34.6.1786632955755;
        Thu, 13 Aug 2026 07:55:55 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3c99c63c0sm2179645a34.6.2026.08.13.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:55:55 -0700 (PDT)
Message-Id: <0012c1007bc5d0e6ab143a0ab8201456e4f33a24.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:39 +0000
Subject: [PATCH v3 01/13] diff-delta: widen `struct delta_index`' size fields
 to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Preparation for widening the delta-encoding API to `size_t` in
subsequent commits, which is what lets pack-objects drop the
`cast_size_t_to_ulong()` shims that 606c192380 (odb, packfile: use
size_t for streaming object sizes, 2026-05-08) had to leave behind in
`get_delta()` and `try_delta()` because their downstream consumers were
still narrow.

The struct is private to diff-delta.c, so widening its fields in
isolation is a no-op at runtime: the values stored continue to fit in 32
bits on Windows because the public API around it still truncates.
Splitting it out keeps the API-change commit focused on caller updates.

Since the `memsize` attribute is returned by the `sizeof_delta_index()`
function verbatim, that function's return type is adjusted, too.

Assisted-by: Opus 4.7
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h      | 2 +-
 diff-delta.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/delta.h b/delta.h
index eb5c6d2fdb..ab0279168c 100644
--- a/delta.h
+++ b/delta.h
@@ -28,7 +28,7 @@ void free_delta_index(struct delta_index *index);
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-unsigned long sizeof_delta_index(struct delta_index *index);
+size_t sizeof_delta_index(struct delta_index *index);
 
 /*
  * create_delta: create a delta from given index for the given buffer
diff --git a/diff-delta.c b/diff-delta.c
index 43c339f010..9e1f9e6f95 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -125,9 +125,9 @@ struct unpacked_index_entry {
 };
 
 struct delta_index {
-	unsigned long memsize;
+	size_t memsize;
 	const void *src_buf;
-	unsigned long src_size;
+	size_t src_size;
 	unsigned int hash_mask;
 	struct index_entry *hash[FLEX_ARRAY];
 };
@@ -140,7 +140,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	struct unpacked_index_entry *entry, **hash;
 	struct index_entry *packed_entry, **packed_hash;
 	void *mem;
-	unsigned long memsize;
+	size_t memsize;
 
 	if (!buf || !bufsize)
 		return NULL;
@@ -302,7 +302,7 @@ void free_delta_index(struct delta_index *index)
 	free(index);
 }
 
-unsigned long sizeof_delta_index(struct delta_index *index)
+size_t sizeof_delta_index(struct delta_index *index)
 {
 	if (index)
 		return index->memsize;
-- 
gitgitgadget

