Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D1330D28
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890163; cv=none; b=raAZ+oORBYNGCy4tgTtspaReWBJeqzkUICUTUEy/0pNMH7uIZWMiQ140JbIEisByL7WqxgpDZzVgqpGU7AbzCQuAEyhLc4pTwQtMFAmyFIu+qNqB4U2mX3vFrmC9ikQ5FTkA6Teh1/gNj+D15rvf9RQWzQPYHFZtuIONpNef7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890163; c=relaxed/simple;
	bh=jo1IlnFz42/8SDaTBJZaMSKJ+twLydnjT7arp+1Yozw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=saf/TuYN7/gct6f4YQq7nF7NhUqvO0TTzHc6KSJXP8lu2UvDH05mL0IjP2RGNfbFua0jFNV1xmyhWal1ws3Gtv7+Ty1Fqy7Wk5VJn6B4heUZPZhFdQbeMq+h4h0tdV58IFPCIE0YwAL2qIJ2eRSJ7wrsVuqd76+Q6rkMzyx+tNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/eeEGjP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/eeEGjP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so44666d6.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890160; x=1763494960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=Q/eeEGjPvSpJqePpjt6KfL65NXw+Hi70yy5DgHsagGJSn1UW05nPA+b+wO6HsEpKdg
         B3Z2L8xyYr077Dau+QVucYRnozy9M+d+TXhru0p1xwj7g7F9M7pNRw5gHMDpNSYhztkV
         Y7Bj6hjsNuaXSPz5V8lqctmxey75tlZAfg2H9aslyfwjMg33tYqFceRQuboAcihQ0Rw1
         LBdWu1iHZrqDr7wFCmpH0ydISEWyzCi5Pj4oYDStey6Acg+zJRQNQjCyXNYs578jfw3c
         PWfTsbZ5RqR/LhvokduSMIMHH1qlx4/S35EZElbniMpa8lGattWZBiyyEd6EmNFOry5d
         W5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890160; x=1763494960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iH8FcmGy1oRc6fqMlgCcgNP40wVVSi8RJN1Rl/guiI=;
        b=cmc0JLZ1kYpEFnYeV5X0FN/SBlkmhV/Gz9I3RSJVUofHsqfcqH9Fki1yxO+75ccdT+
         fk/0fkuJvyRXuRA8Bo+Gq+DoVTtTdaNn1D/uodpZJOTw1hmUb+KXZvomMITr6VqMFmKX
         drB/fbRkdDonUyDZowFOi0UC9nFU5hg6jrpEtXIIjbRPOqoxMkBqvIKsV0R96zHd0N3c
         zT5ObW2YXCghUd4aR/8ZeuUp1Mu+qVaXdFNNR20NDOtKyX7wDpTY258L2lJXy6gOvICA
         mC7sqSSGAC+o+vHSso7ZK6w0bFv8KaCHxyBlJv0k4G+jFwWdUMYXTXBneYx2H+ft2fAA
         KxsQ==
X-Gm-Message-State: AOJu0YwySip9oxPOUnifozio6PfoNJU4kUTGN6l7NX9OV1QHtcvI+jnr
	QxgZQ8M7NC2XNjSkzlrsgjWXVkeYOA40AYR9LZXO3jRGbWGxS+5F1bvOIAuVUQ==
X-Gm-Gg: ASbGncsYpWgd+i3u5nZhYJifqIlENP1gBM78SxtiRDQ3dRpnnwMi18sZj4irTo2o7Xh
	6Qt9jvA3yRFpvhrkEw/09hxWTpeWcvZ3cdVVUSksXmzbEfmrzeOpBcfVOuMyuQqS1pUE/mCMyOw
	dlNcgRy6849iGEXFJoYXBT+MoVw/dajzMzhagUu1PSgLO6PZXySC0MpYd6J5NHT1W2pvDKrS1Jm
	RokMLxpmwtVKrFt99QF/g87hDPawsPobgmxJkRLRjFu91aV6lb6mLjJT8nwa4GpbNUy5bkZGRM9
	NntElzkuZvZ1VAdowjq6Uou28q4wFMoupOtFD0bdbntjRZ/4y/5FllLMMCRo/fceCSOdG/dB1Er
	vQ0Tn4o9gUfvoed1T8ZWUlN08ZdJmL98fnbUDxbneZn3Ra5xRcU+OVQvldjAWn24OHdyZqo1Rqa
	EhBnU=
X-Google-Smtp-Source: AGHT+IF0MydXMrWUmRAi18BgaxKA7LlqA8oRkKrV8WgQaG22Xh84oHwYEkAY8mU/Nu/x4oIbmj7HqA==
X-Received: by 2002:a05:6214:528f:b0:880:51f0:5ba0 with SMTP id 6a1803df08f44-88271abf157mr7546636d6.26.1762890160263;
        Tue, 11 Nov 2025 11:42:40 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b75620sm77482596d6.47.2025.11.11.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:39 -0800 (PST)
Message-Id: <c6ba630ac53ea56d567ccfabe263d2d8c31719b5.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:27 +0000
Subject: [PATCH v3 05/10] xdiff: use unambiguous types in xdl_hash_record()
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

