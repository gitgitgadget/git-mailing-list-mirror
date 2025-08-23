Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF2224B04
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755921377; cv=none; b=EThvEOaNGuSRHR+/+rcc5NmlX3MslRGyczEeqE9krlnQkqjPtHBh2LBJmltwY47IpoabEuiIoQiygX0DQBW+o8ntZsxOr0KRZI/9UBN2OLrnvfYP+WFcjhEfRfWHCFy02SpXAAUnQV5x+u/AocehxHwDOm70emThqzzwwrjHrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755921377; c=relaxed/simple;
	bh=BK9luMSvac4FBcrO0C39jLil+ja+JszCYZOW6mzjiE8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bBY8v6hEyvyLA/LaDwPOllmWGB1Y3QSQIVOVPdn8aCfOMb6BO6xi0EwtMRnCnLP5wqFbqQOGxlIAX3wfd2y5TZ0dSmxXwF4R8pPc6qt3IoXz9lnEy7Vnjv0capjeaav8C21oeKA4kX0Peu6EOqNJj/CZKVvDqWh7thr2XvrbtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlrXyTx9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlrXyTx9"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so496482f8f.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755921374; x=1756526174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD9Y3wduwemwBkTOOpUeOJITBL8+/u2olZmSKiapuxI=;
        b=PlrXyTx9UV15XD6bFenMhd+4acyscZYwoVTNitHfmgB90BwMaTtv0Nunmwfyqadnso
         EeB2itsElW5bWPbC3nM7GKxu9B61xBE1PxOzTht4zd0/TxEx2Bn8x2fCIidXRH98MiHh
         eHsjmsq6XfWxAbBKTyd3PBaAohtXPcs9YO4VLmygaaUzxesBRs93N6RXh3i+9jjoCIAN
         /sHWkAW50zmcRylDDUfQ3PgodBlHbi7scHfUOMHG0Vzg4frYAIiowfTEq6MMvytBWmKo
         PvwsgVP3WNZ4sKTGHNkTRMrW/TsShN1e4bi6Mgmzhr3pa4wrm1ydrLmdQNk5JeUwGW+u
         lw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755921374; x=1756526174;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD9Y3wduwemwBkTOOpUeOJITBL8+/u2olZmSKiapuxI=;
        b=DGaiaSihsKI9U3cluRwRQJXcF1pJWvcmMzt8HvShbFsVNVyK9exFf6xER9zFmuLw4Y
         WCJgtW3AsztOmsZpQfE5eAvxO02hcSDwXLS+X8o/6MdrzGAGAxOR+io8iz4dp7Pk6Dek
         S5BYtE/rzc6w3960AFg1jHwzxI+aQh65lLLtOtztffeEjgpd7ZuxAgmgHezMFLhcMKQ8
         7kD/8XAyf8GU9/KUIBEWqfESGf7XTY4TBQPoqi34vmPpHFo9qb8RcPVNpoF2tE3EFPLy
         013HDMq/DuraCzvEZhW86zc9y7f//QGfK2498Hh4pMp66oARtXx9UJOYJzoRjeEC4b3H
         fmDw==
X-Gm-Message-State: AOJu0YxcKOQYnmBvDUacQW747N0FN/evIuosbhBYZMU47KUYsUR/Ik79
	J0VJOC+3QvDWFh2vluhFlJYUew1641x8d84aXDM/S6GOQVeZSdF4a5V2gfFSRA==
X-Gm-Gg: ASbGncvWF9LhJCl9n3/YX9cwBfWzt3FIV2jfh0Lb1qG4jHBRba7hpaoi12wogObTXNw
	mONkVK3Un5AUBDb95xIkT4Q9i7DwxXVLDISCbVL7Lzh6WP0c/J4HTaMtSmevf9t3BGg35fQsENH
	OcdQS1gfaFroLHYGKtHpPVrDbUjG4Z+x3k+8x3ZwXQKogQc7psq1T8KarC9xwwvp/aqwxToDEl2
	+uIshP6N0kBVMRAQlgWKVgmWLP+R6kgzkGE7NKlQK6GDVbeqZ6guoy/UXVU58pflEEQLLGh1b8N
	FR10MtI5YEtcScYatyDHf7hEUYssHHr4GBI4D2+8U5ycKHSmbOtxHZiEZ4ArIMSs3frFaTZGAeD
	gWBPkqRVdJ5azWvr+WRIyiJKg+P8=
X-Google-Smtp-Source: AGHT+IH6zPrL6zWqEW5lw1pcbymQCLpZZsT7v6Hfy+Z9Zym72SEkSL60oy7M3aJFBBn0A2sL0qSMDQ==
X-Received: by 2002:a05:6000:310b:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3c5db8aae86mr4015504f8f.10.1755921374140;
        Fri, 22 Aug 2025 20:56:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e83a50fsm52785095e9.2.2025.08.22.20.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:56:13 -0700 (PDT)
Message-Id: <ea699135f95283c05ff20ff47e0c73154ca60eca.1755921357.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 03:55:55 +0000
Subject: [PATCH v3 14/15] xdiff: make xdfile_t more rust friendly
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
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
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
index ebdb72432261..0509b4875996 100644
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
index 126c9d8ff4e4..c766ee115c99 100644
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
index 849f218b3277..66b3dfae8bdf 100644
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

