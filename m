Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6E24467A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496563; cv=none; b=oJFVZPBhYtbsDK0CCKUH7vyhADQdIDpfMNWD1OriyCCf8ivf40G2gCLnNq446x6fs6O0TF5+oz8zUp56s553tGDvaJSIS8F3ViVvfMJf7s/if13KTWT+rt7mFKZd54oGrkg2ZdHmpJDcxpIFALjcvKQ+Xolf70HoQB1algk+W6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496563; c=relaxed/simple;
	bh=J/LWJAaOaCbhBXVIpMdmWZdwznqJMGZVzPojtfvCYNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PeazcbGVypfIIgCuCp1jokWz3aNFFaM4+3EPliSos17mcuI/kM4MzQeK6ru0Jw+o0uLyrD58LVcaHpzhC26TGZA4CW96ZqLU/8BdsMP7s6v360Fzeh2Rqlv7R9IGYDuU2egybyhk2TWo5RW6d2mYXcIl7DS/JdxDx/ywqAFzx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAaejzP9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAaejzP9"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771fa8e4190so1771103b3a.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496561; x=1757101361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AzopeWoWlK2mnIEinCe6QTa8mZWB9qVUroIHBVTTQM=;
        b=BAaejzP9+KsXzALrb+SP6iTWPOCg+DZhUvcE/dLpIQ3A/9BLHV4xLTEIwm4Klb/awS
         g8aD7F8qi2+Li62sM+BClQnwilwADyUzbqVgm20hZsHqLoexm8oQNSPIzJyUIsfX8cZQ
         2a+4T8aGZ07Pv+wimH71S4+o+uw73OEgIZIRarVk7AZAX0zobwfGVmzM2hgAsDvFEUmQ
         webYaaFoW/1eOlNRvaqFprDaXjUd0OhNDq0xR3NNHR4A0pexRRpFnNjmVdeszEnSVUqF
         wmZZ1IDXHRqUcNnBUXBpRmG4ouUDLMeKBGHTfVxp9O+tIlTrcTyWQkNSVCAWBa7hXFPm
         94Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496561; x=1757101361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AzopeWoWlK2mnIEinCe6QTa8mZWB9qVUroIHBVTTQM=;
        b=FGHP1l2ZLF35j2zxcHpZzmLppI8lb4rzs5NT7UhZzkiFOVbfYF/POyXl6fW8xJwgh7
         9r++zHyOD/BLrqR3LrGjQWz0BMFSLMtLkInW6b/r61SYagK7SlinShN7wXllwthXIgHJ
         12SistcsW0AIvzFiZFDkEdoFo9GxMJAikKH0a3oqqKcRoQzvgl3FDRAvARb4bLSoGP90
         LSr9wx1BXrMOrxwVvMJVWSAtCgkbkNY6VGpiaSLAUF3WsG+P7TN8zccK6+7mq+SR+KXl
         1mol5Mbqms8mTfFPdbmShiu7UbngrQSmABHzGZ+JtjztW9XVc3yQ7ZcngSw87zBIwBoi
         sDXA==
X-Gm-Message-State: AOJu0Yxo31fS/7Ai0hImsl5bAL/rd6X1AU5+6fLgi2Mhcv5aaNSOukhR
	BqAH6L8jEj4G3qq2HIVulhgCm6sMs08hUcnS+qounibYowuNJTTK3qWsGtMQdg==
X-Gm-Gg: ASbGncvjpEQNYZDoSUYz0pzEvVEuNtWxFutwfghHK6fdYkE1mXWpj8ZIR7g+jaDS2hu
	MrMX1dji+tTL8ASU+kOQkRTGg7Ipoh2Tg7PU49IWBKqSqjPdnHvV66ytidJd2+UDGHgB3VdlJzX
	6Xz2T0MU/lrD7xRInD2Nj6ZfWhJLK6VQGmNc8MDy67Z9YPQ+oZW9nxLwMr/g5n5eXN9IcE2p8hb
	NhS9Pg+jW4941K34GV5Gt8PGUZcCbMcHSRvcKvZr2uHJwp4YBzfTuw3fQ3f7BkvT79lQy1RUCz2
	Yq9XOA2cd3e/p9kHmqJMAE2k+xKitRYkGCd7VDmQsdJzdM8p9DCdvVN6San6JSCxiXbSwcx/7qw
	gNH3DBb56mryBdVQ7kfDqRWjN22U=
X-Google-Smtp-Source: AGHT+IElWdKHD7gyy4dfWKvmR6dxSCmAqZILQSPMJxJqLbBgUuLdW1Og89uIWPZ19oxC44zTe7EeCQ==
X-Received: by 2002:a05:6a00:6b85:20b0:736:a8db:93bb with SMTP id d2e1a72fcca58-7702f9e0cc1mr24098768b3a.5.1756496560776;
        Fri, 29 Aug 2025 12:42:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm3167849b3a.30.2025.08.29.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 12:42:40 -0700 (PDT)
Message-Id: <3dacb2c09dd6f2b718033a181a53479f52863917.1756496539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 19:42:18 +0000
Subject: [PATCH 14/15] xdiff: make xdfile_t more rust friendly
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Convert the remaining ambiguous fields in xdfile_t from C types to Rust
types for interoperability.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xdiffi.c | 16 ++++++++--------
 xdiff/xdiffi.h |  8 ++++----
 xdiff/xtypes.h | 10 +++++-----
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index ebdb724322..0509b48759 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -42,8 +42,8 @@ typedef struct s_xdpsplit {
  * using this algorithm, so a little bit of heuristic is needed to cut the
  * search and to return a suboptimal point.
  */
-static long xdl_split(unsigned long const *ha1, long off1, long lim1,
-		      unsigned long const *ha2, long off2, long lim2,
+static long xdl_split(u64 const *ha1, long off1, long lim1,
+		      u64 const *ha2, long off2, long lim2,
 		      long *kvdf, long *kvdb, int need_min, xdpsplit_t *spl,
 		      xdalgoenv_t *xenv) {
 	long dmin = off1 - lim2, dmax = lim1 - off2;
@@ -260,7 +260,7 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
 int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 		 diffdata_t *dd2, long off2, long lim2,
 		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
-	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
+	u64 const *ha1 = dd1->ha, *ha2 = dd2->ha;
 
 	/*
 	 * Shrink the box by walking through each diagonal snake (SW and NE).
@@ -273,14 +273,14 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
 	 * be obviously changed.
 	 */
 	if (off1 == lim1) {
-		char *rchg2 = dd2->rchg;
-		long *rindex2 = dd2->rindex;
+		u8 *rchg2 = dd2->rchg;
+		usize *rindex2 = dd2->rindex;
 
 		for (; off2 < lim2; off2++)
 			rchg2[rindex2[off2]] = 1;
 	} else if (off2 == lim2) {
-		char *rchg1 = dd1->rchg;
-		long *rindex1 = dd1->rindex;
+		u8 *rchg1 = dd1->rchg;
+		usize *rindex1 = dd1->rindex;
 
 		for (; off1 < lim1; off1++)
 			rchg1[rindex1[off1]] = 1;
@@ -944,7 +944,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 
 int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	xdchange_t *cscr = NULL, *xch;
-	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
+	u8 *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
 	long i1, i2, l1, l2;
 
 	/*
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 126c9d8ff4..c766ee115c 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -25,10 +25,10 @@
 
 
 typedef struct s_diffdata {
-	long nrec;
-	unsigned long const *ha;
-	long *rindex;
-	char *rchg;
+	usize nrec;
+	u64 const *ha;
+	usize *rindex;
+	u8 *rchg;
 } diffdata_t;
 
 typedef struct s_xdalgoenv {
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 849f218b32..66b3dfae8b 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -48,11 +48,11 @@ DEFINE_IVEC_TYPE(xrecord_t, xrecord);
 
 typedef struct s_xdfile {
 	struct ivec_xrecord record;
-	long dstart, dend;
-	char *rchg;
-	long *rindex;
-	long nreff;
-	unsigned long *ha;
+	isize dstart, dend;
+	u8 *rchg;
+	usize *rindex;
+	usize nreff;
+	u64 *ha;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

