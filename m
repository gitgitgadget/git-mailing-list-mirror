Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0430CD88
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505275; cv=none; b=HnIoguQfqz63hUlVOTSZzO5TJXUlacGQURACt7Gi3jZCvS19hbcS+dqx49d/OadLgB32fE5G9YIecZEvu8rM/7bl4k4/uI62PNb3sfFTLmBBrmw0nQa0Knt5nK6a1BozPp+slGUrPKguG+0GZBO56Y/wNDJLPcLHn9QfOLBIE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505275; c=relaxed/simple;
	bh=jo1IlnFz42/8SDaTBJZaMSKJ+twLydnjT7arp+1Yozw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m/zibpnPhnGUUejTcCzSBws2UAm3lmj9qd0aLL0xD1L8U6ZOSEw9Fy5mrcp1o/g8MAzp8Jt861efsRWpe9PwQofD+m1SgLN2QgdHB+hDETUcEVMaehDuaH81OpX/2G337J0/KZoH8ijobwHEmXNOe3f02AdYf0pXkjYiVrKPoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXRcFqTs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXRcFqTs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29555b384acso61789725ad.1
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505271; x=1764110071; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=ZXRcFqTsP8S2qUKpHd8+9y9S8NzBdduC8mDPjYg2nIn5U/0vi6wZKQQrmOOv7Qpmkd
         46azsda6tm3w3JdipnwqhHzL/J7u+Iaafu+rKYG4632h5c56KDPM9nHT85iFAgkpjW3w
         hyTXnxJOOfQHpo/rRZg/EorD1bodlEhtUzm6sCJq2NhT0pLVB2gnWsaTrBgpwxfgkq+A
         /Lw/3isNcBz0wDjRGByLdCCKln38vuRTWmz1nipnmBeUMt1Dkxje6eJrhFagI1LPn9kW
         89yH+FfvOFkOJJMCE3nWogR4/fI5EH9dapGyv3PCF1+5aPbFwqmgJPQOlRAziogszl95
         zGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505271; x=1764110071;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=cKC25UKsFdKVRaJXp+nflScflC2YKl/lO2sZEKwcKwr1Q84ZU/l8kUM7xqyFL8/Z9z
         9rmihscEw2rSdBhpC8qRW/9EQfxs9Y03AnwaDr4fVRmXW5+Exoj0i2oiP1S6Pd1CKcUe
         zBKR/GfMP5tI6zXs/ofEPG2wHFqwl03i+32xqy3g9qYVfluWK5NzYgW4bUxNgHbCNRP+
         NewekpEevXXDN2BhmGXQTFSYn9vwg3Pfi6UssXhb0dbAV3aTCCiYw8f+lpdtoUU/4sU2
         7QLZigS55lDgRUQNbiD0rZPX3lZvmXPrnJQ/O3fhrWMn8U5LAkhTY9DlAp1LgC6A8jcZ
         bUig==
X-Gm-Message-State: AOJu0YyXS8isiJ4/yNoundCKJLNYTydOAZiwz0vxxZ14dd2b+5Q0rTnp
	Zg1oK6/lE9xLTUhQFgMsfbfxCtA3LZv4XbxWhv6UrHwxonW0wnWoa+BrzPKZ8A==
X-Gm-Gg: ASbGncu9C9vFUWhyUXY23nDCddA+03N57NuWzayIgevLbxmXgE/PR2FGxnHtMJIMHr5
	ijofZ9rywZpRppSqXGjXx2isyoHPh0K7PM2AbkfsqPmq46y03g7zPacGTPE6SMvv9dPxdFZ4ucV
	CINERcID8joHXTnQQQ+KE2MEbQWoaOvxa67e1JwPeMHpeTWTMWxOGzKJEExA1oWUzgkZPXcdU1f
	FqHofDQ5LZDxwZGgf1ZxUl93Mue+0hnF1SFqhtLYJRmWt7w6tBbcl8OhQeh7/AZhkR6EvNC32mR
	j6Gbclxo20MwCpXyMRV0U6qPctV+Y6IdBitVLTK03Y6tDjR30HGivxPyw127s9ss8sQn2TaGKYv
	3RWhySQujuf9DE7rXhEU9l0gy+ibFVz68ygJLjGyBco0kS4XRlVZ5Ip1iOn5EnkNCpxCoBWb+KD
	kts5Q8zxEgSAOI
X-Google-Smtp-Source: AGHT+IFT8GNHJ4ExLQ6iCM7pi7er+dHDzDT7xhB13iPv+UDPrZoAO0nKwwUUkTMjowue9u0HXWMPfA==
X-Received: by 2002:a17:903:196b:b0:294:f1fa:9097 with SMTP id d9443c01a7336-2986a73b221mr199956305ad.34.1763505270605;
        Tue, 18 Nov 2025 14:34:30 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0d17sm184325695ad.72.2025.11.18.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:30 -0800 (PST)
Message-Id: <6f267360b705e6d5ee62a67c22b1de2d3ff38196.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:17 +0000
Subject: [PATCH v5 05/10] xdiff: use unambiguous types in xdl_hash_record()
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Convert the function signature and body to use unambiguous types. char
is changed to uint8_t because this function processes bytes in memory.
unsigned long to uint64_t so that the hash output is consistent across
platforms. `flags` was changed from long to uint64_t to ensure the
high order bits are not dropped on platforms that treat long as 32
bits.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff-interface.c |  2 +-
 xdiff/xprepare.c  |  6 +++---
 xdiff/xutils.c    | 28 ++++++++++++++--------------
 xdiff/xutils.h    |  6 +++---
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 4971f722b3..1a35556380 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -300,7 +300,7 @@ void xdiff_clear_find_func(xdemitconf_t *xecfg)
 
 unsigned long xdiff_hash_string(const char *s, size_t len, long flags)
 {
-	return xdl_hash_record(&s, s + len, flags);
+	return xdl_hash_record((uint8_t const**)&s, (uint8_t const*)s + len, flags);
 }
 
 int xdiff_compare_lines(const char *l1, long s1,
diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index b3219aed3e..85e56021da 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -137,8 +137,8 @@ static void xdl_free_ctx(xdfile_t *xdf)
 static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
 			   xdlclassifier_t *cf, xdfile_t *xdf) {
 	long bsize;
-	unsigned long hav;
-	char const *blk, *cur, *top, *prev;
+	uint64_t hav;
+	uint8_t const *blk, *cur, *top, *prev;
 	xrecord_t *crec;
 
 	xdf->rindex = NULL;
@@ -156,7 +156,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
 			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
 				goto abort;
 			crec = &xdf->recs[xdf->nrec++];
-			crec->ptr = (uint8_t const *)prev;
+			crec->ptr = prev;
 			crec->size = cur - prev;
 			crec->ha = hav;
 			if (xdl_classify_record(pass, cf, crec) < 0)
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 7be063bfb6..77ee1ad9c8 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -249,11 +249,11 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 	return 1;
 }
 
-unsigned long xdl_hash_record_with_whitespace(char const **data,
-		char const *top, long flags) {
-	unsigned long ha = 5381;
-	char const *ptr = *data;
-	int cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
+uint64_t xdl_hash_record_with_whitespace(uint8_t const **data,
+		uint8_t const *top, uint64_t flags) {
+	uint64_t ha = 5381;
+	uint8_t const *ptr = *data;
+	bool cr_at_eol_only = (flags & XDF_WHITESPACE_FLAGS) == XDF_IGNORE_CR_AT_EOL;
 
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		if (cr_at_eol_only) {
@@ -263,8 +263,8 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 				continue;
 		}
 		else if (XDL_ISSPACE(*ptr)) {
-			const char *ptr2 = ptr;
-			int at_eol;
+			const uint8_t *ptr2 = ptr;
+			bool at_eol;
 			while (ptr + 1 < top && XDL_ISSPACE(ptr[1])
 					&& ptr[1] != '\n')
 				ptr++;
@@ -274,20 +274,20 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 			else if (flags & XDF_IGNORE_WHITESPACE_CHANGE
 				 && !at_eol) {
 				ha += (ha << 5);
-				ha ^= (unsigned long) ' ';
+				ha ^= (uint64_t) ' ';
 			}
 			else if (flags & XDF_IGNORE_WHITESPACE_AT_EOL
 				 && !at_eol) {
 				while (ptr2 != ptr + 1) {
 					ha += (ha << 5);
-					ha ^= (unsigned long) *ptr2;
+					ha ^= (uint64_t) *ptr2;
 					ptr2++;
 				}
 			}
 			continue;
 		}
 		ha += (ha << 5);
-		ha ^= (unsigned long) *ptr;
+		ha ^= (uint64_t) *ptr;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 
@@ -304,9 +304,9 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
 #define REASSOC_FENCE(x, y)
 #endif
 
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
-	unsigned long ha = 5381, c0, c1;
-	char const *ptr = *data;
+uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top) {
+	uint64_t ha = 5381, c0, c1;
+	uint8_t const *ptr = *data;
 #if 0
 	/*
 	 * The baseline form of the optimized loop below. This is the djb2
@@ -314,7 +314,7 @@ unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
 	 */
 	for (; ptr < top && *ptr != '\n'; ptr++) {
 		ha += (ha << 5);
-		ha += (unsigned long) *ptr;
+		ha += (uint64_t) *ptr;
 	}
 	*data = ptr < top ? ptr + 1: ptr;
 #else
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index 13f6831047..615b4a9d35 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -34,9 +34,9 @@ void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
 int xdl_blankline(const char *line, long size, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
-unsigned long xdl_hash_record_verbatim(char const **data, char const *top);
-unsigned long xdl_hash_record_with_whitespace(char const **data, char const *top, long flags);
-static inline unsigned long xdl_hash_record(char const **data, char const *top, long flags)
+uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top);
+uint64_t xdl_hash_record_with_whitespace(uint8_t const **data, uint8_t const *top, uint64_t flags);
+static inline uint64_t xdl_hash_record(uint8_t const **data, uint8_t const *top, uint64_t flags)
 {
 	if (flags & XDF_WHITESPACE_FLAGS)
 		return xdl_hash_record_with_whitespace(data, top, flags);
-- 
gitgitgadget

