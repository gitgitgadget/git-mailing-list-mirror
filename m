Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2862BE7B1
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926530; cv=none; b=WySgmvei7Zt+j84/Mobv+KflaCgU184NbO5t6LSJ9EA5OXKQ0MdYJjmxN0qJNiFkE1GYTyI8Xa1HH0nMV9hyJcV7BQI0HOyHGcVYSSFmoVwmmwxzaxdEBthBhrvpjQ5JzYrw05wNGcTVIPhDG1lNXqcYgiM+1AIQ8n/3YCZtXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926530; c=relaxed/simple;
	bh=lmCRNnxLeD5SJzhT2nelqLeckSv1MfFI7Wjy6JjamS0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eLyivVtaU0MWf6Vth4E6R2EpHgx/F/a2vnot2E7LJ3zLSfiy2q4ecWm7idP4kuA5+Pstifmj0AWJqj7gXboJms2nEmGNJLVzqQQeBrtv8lziVeVV5MHo7x4RbUTAzOt2Kus2BwaPuk/b0NsEymu5O4DzFiECr9mwpiaTpV0Y7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYQpPQCj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYQpPQCj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-26a0a694ea8so24434805ad.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758926528; x=1759531328; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqjA8DEZHoa9JFS/gkH01fawPh0IubxBEBrVeKsJsXA=;
        b=NYQpPQCjtVkOV5Ny0mDA0Y/3aZJ1NwGjKr5dGj6yyOPQKVhMBPN638H6gpODf28Nv9
         B7JBQRGI1DIE5/J10rQXcMoj8qNwvzJoWStYEAFfcy7jdJzo+utcq4QLGWRu6IPin6zN
         f1K0mR4Aww1uASZpKxPRAGZkbd2RI8pwnAOFVAiTek2jmkTIzPdhRBA1Mllwdt0Gaxh5
         BxQZBzmzLkX06Wdwlxz1iGpeCTiP0F/tZuqCsLj608C4qMCtsk1gbU2+zKIWN43l9Yt5
         mzfKDoUHAje8DWM2+HuS99XX5hl3YBVye5AmtOMPhUq/60UNJstP5uyLDOhrqIhpYKQn
         5QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926528; x=1759531328;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqjA8DEZHoa9JFS/gkH01fawPh0IubxBEBrVeKsJsXA=;
        b=rXucR5ve3hu6ZDHXMxq6f7+uM79FR+eAp7GY6ya61ume+0uP5Tm1iPJk9BK+OgwPRJ
         QXUa6CTDVbV52l5kBfNvRQNvZF3cURFv0dPiAvfPS+R1ed45MdvCVkQKO+hsCGWD3tZ+
         S+T/GhF6Uu5M70YycY5LNYUkY8bvlRoTMKFt55fPq+6LegqhUHs/c32G/Na8caXuboy4
         MnO0YEBT2eXdT6o1L+qFr7OfEMEo8TPeZFqsGGYVeBljuGmPFwbbsVSGK7eUDA37lGXP
         vV4RQffc2WnfBzQdIIfybHfDheqmsRhm8QNAShTLZ63ZereYKBMdbvyB6iE/HF2CXe58
         YSdw==
X-Gm-Message-State: AOJu0Yyk05Fwv+gVFvsiQUF8NRhPZm2Dh1eqtGi1U23+105r6kYwrinv
	0vbPA3nYEFENCn0qTrxT7fKqIUhEI+u5fgUB+UmUI4gDvWXKT4hxJods2odCAVD8
X-Gm-Gg: ASbGncuADDaoYLA7KzpM0ukmBbbuosPZp5sKYPon3RU+KLlHTYTzFz2zdtrYJ9qG79Z
	sZwD9AbmpKhNhBWJviWXsE4vBcYt08bd2GnXxn3A5MDu16+9zfAbGPu6lmRG2lQj/XEMBzHEUDD
	zgvkRoEcJTVcEVLWMsZc1Nlg5QHO4jQHF9rt+0aZ6JKQHIH6iYXnx5AqOuUuHi2Q61a5IueGunj
	2Q3d6YJVJLRZS2CdHcCUgbA4SJrJoRZ217wzBOHYi7M3CuE9ZKWu0Q6CrDua0mDmf0XMRwLZrEl
	XeNhbvOPneE+1946pQ+GqW1JSzjhNtTMsGuTMISd9tALvmdfyryk/Ne5Ca/B2TTyUpEw/vHZmyf
	QkerV0hG8U6AcfgqWju8kI/EL
X-Google-Smtp-Source: AGHT+IE5n4+npeCTtjGyt+G/NgUnlp6ZCCHvyJBV1X6bu/RP10kVg+Pnks54T3mpJwzxV0Zu/WrrBw==
X-Received: by 2002:a17:903:4b27:b0:269:603f:420a with SMTP id d9443c01a7336-27ed49b3138mr106619005ad.5.1758926527626;
        Fri, 26 Sep 2025 15:42:07 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.5.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be14666sm9862676a91.15.2025.09.26.15.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:42:07 -0700 (PDT)
Message-Id: <7a9380328e3ee36d74093f5a174c1cb07c5802e5.1758926520.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
	<pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 22:41:52 +0000
Subject: [PATCH v6 05/12] xdiff: delete local variables that alias fields in
 xrecord_t
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Use the type xrecord_t as the local variable for the functions in the
file xdiff/xemit.c. Most places directly reference the fields inside of
this struct, doing that here makes it more consistent with the rest of
the code.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xemit.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 40fc8154f3..2161ac3cd0 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -23,12 +23,11 @@
 #include "xinclude.h"
 
 
-static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb) {
-	long size, psize = strlen(pre);
-	char const *rec = xdf->recs[ri]->ptr;
+static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb)
+{
+	xrecord_t *rec = xdf->recs[ri];
 
-	size = xdf->recs[ri]->size;
-	if (xdl_emit_diffrec(rec, size, pre, psize, ecb) < 0)
+	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
 		return -1;
 
 	return 0;
@@ -111,11 +110,11 @@ static long def_ff(const char *rec, long len, char *buf, long sz)
 static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
 			   char *buf, long sz)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+
 	if (!xecfg->find_func)
-		return def_ff(rec, len, buf, sz);
-	return xecfg->find_func(rec, len, buf, sz, xecfg->find_func_priv);
+		return def_ff(rec->ptr, rec->size, buf, sz);
+	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
 }
 
 static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
@@ -151,14 +150,12 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 
 static int is_empty_rec(xdfile_t *xdf, long ri)
 {
-	const char *rec = xdf->recs[ri]->ptr;
-	long len = xdf->recs[ri]->size;
+	xrecord_t *rec = xdf->recs[ri];
+	long i = 0;
 
-	while (len > 0 && XDL_ISSPACE(*rec)) {
-		rec++;
-		len--;
-	}
-	return !len;
+	for (; i < rec->size && XDL_ISSPACE(rec->ptr[i]); i++);
+
+	return i == rec->size;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-- 
gitgitgadget

