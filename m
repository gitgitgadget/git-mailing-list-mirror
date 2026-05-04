Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA83DEAEC
	for <git@vger.kernel.org>; Mon,  4 May 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903599; cv=none; b=hbqJlbzp6HpwU7fcZzdKNzY+9YP2rD/1zaDikK17TbfECwpgSEO1ptmYtq+4dCCF28YTjxnfbdUUsOQinsPEgCibU6SFISCpFHufTj89arDjHEVH1uCIqhXL+fCsCaQ7ELp7SAlf6hjjAuzHNpjLwzE+Qo1uQ3rMxdA3j7PiHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903599; c=relaxed/simple;
	bh=kGBDFAtKzC/Zgkfpl1RTNoJMc0O5eCfKpC+galiN6eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUQghkDcqX6tk7ZPs2oThauCZl7Reownm3eNjFJHMzsqdJa5GXNuV8ErCCU+AV52ij3xoE+t12vswlvmvNPdpcZrsbhPl/gU4BmdPEMLi8DWFENwFWH3QM16TnFix/f8f8gOjGqGQxxNKKKa6ruWqq/8sK5f39M4+ADMYk90IZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ob9ZVqA0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ob9ZVqA0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso21563675e9.3
        for <git@vger.kernel.org>; Mon, 04 May 2026 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903596; x=1778508396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1pbLmSsvuvhUKCfo7eIn0Z1b3C0BFfoHA+u0FW1jeGg=;
        b=ob9ZVqA0S6eZHXA5U1qZzF33eOhdiRLdnYJdXi5KjgxwBnadsk8Zl4XjpMsVBXqg37
         Lt7cFP2MZ8kFQpB/IWAT0tNZKJaA/cp5J301Yn00P2/AIvtvOulBqJ4eU3T1XaTsXx9S
         8k/pBTuVs+GJwMNyPhzLFdr+/80dsCzJU0e2hd3DZqJjShXmQDLOZO98Vo5K6rAMnv9f
         +8LlDzi9QeoqVR0dLfnGoYvyz17krkiwBxg563D7CF+svrilcQPKxGIyEG7XJM0qPO7b
         R8PKd34ofIMk1yXCe+lc0IsvvD3rG57f5/rCSHqEZZNhYUFFWEp3gCVupQc0lt5ECnoY
         5bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903596; x=1778508396;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pbLmSsvuvhUKCfo7eIn0Z1b3C0BFfoHA+u0FW1jeGg=;
        b=KSEkMB6VdtJhe6cnzciP08xiNSs2lS+tkXl9qHlimRP6ITDoetAxos22ZbuwC5QK8/
         luuUtOwM3s8ws5hcoERPZ5pQ1iOHKm0N+SOrjHhGYga7WtfG/vIFc4Bnpu/qSAFv2br0
         OBNsXSi5mQTwRmVcNvMieyfeudb1NL/yu8BFcTRsByWMJ/y5541HYkBK7+wkr4LzIbL8
         rdiX85tDE5e96f3hAm9/UPT9CWg6xFyN1CB1kjVHQPG3nRYUojdgousabJSCmBaIzLqr
         /BkNJUZ2DwTqa25Rq7GBNNOij/0b6ZWn5eutExjTZO/nnjUchgXQtfraBIH+llx6pwVj
         pY9Q==
X-Gm-Message-State: AOJu0Yy0M73zsXYaxhPQnOAUdrvzWEQtdgCdqqu26uAQpjgXPmgGT2Yw
	6tMon1RhyyOfg5eOYLk9q/gNDzO3RLh9koKEXijVrLGVXEsWSkWTwIFfo9dKUA==
X-Gm-Gg: AeBDiesTD99rxatSLUOF14cBhXlS4n60k0dl7Tj6jqV6CYbPXc4bX9iXXGiGwhNeIrh
	7MLbWZ2lw6szMbM+PfinEYhJlwSm8jentEp/MZwVVVMVVNZJ81K1c45rrwuVDXSRB2WMzenSfnX
	k8udqzNu8Ldem6Sc+GDAzI6OvOlIH81J9AuhAVJZZOc6pwc8ZkjuNn8kYqUppVXXGR2S020ta9M
	XwrUKuse6lsoO84qH3qbvKzOFGRAysU1nN8s7H+txxM+4+uNwzItt70Kk4oyXBhJrgsF71LKZ8z
	P4lxQm/FspnjzX+e6gkglxl3nZIWkQRztNFLAk6BYWHTAAMTjvNcw8ial0nfsShzhOmVl0qFFtO
	gDcGKS+54MStFGTuqUTZLlbpq6lmtOJ0fNrwkZZMMzyXw3IPCwE3glbEt3kSLF8uewRHCiGHklp
	p1jSMVK+MB9LYvxb1A5rTFcn9EY1e0IQ1g+yk4n3o=
X-Received: by 2002:a05:600c:927:b0:48a:5970:2003 with SMTP id 5b1f17b1804b1-48a9886c2a3mr93207255e9.3.1777903596280;
        Mon, 04 May 2026 07:06:36 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1706:1a01:7ae4:ef77:45ac:8456])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm390520555e9.3.2026.05.04.07.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:06:35 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/4] xdiff: reduce the size of a couple of arrays
Date: Mon,  4 May 2026 15:06:17 +0100
Message-ID: <cover.1777903579.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.rc1.174.gd833f386ac5.dirty
In-Reply-To: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
References: <cover.1775141855.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the myers algorithm is selected the input files are pre-processed
to remove any common prefix and suffix. There are a couple of places
where we allocate arrays large enough to hold the whole file when
they only need to be big enough to hold the remaining lines after the
common prefix and suffix have been removed. This series adjusts those
allocations to avoid allocating space for the common lines.

These patches are based on 'en/xdiff-cleanup-3'

Changes since V1:
 - rebased onto updated upstream

Base-Commit: f87808b7014cf06db4a7e19b193cf9aa7e965ebc
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fxdiff-reduce-array-sizes%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/f87808b70...d7cb49a7c
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/xdiff-reduce-array-sizes/v2


Phillip Wood (4):
  xdiff: reduce size of action arrays
  xdiff: cleanup xdl_clean_mmatch()
  xprepare: simplify error handling
  xdiff: reduce the size of array

 xdiff/xprepare.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  447b8c0af17 ! 1:  ec692cabfec xdiff: reduce size of action arrays
    @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      		goto cleanup;
      	}
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
    - 	/*
    - 	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
    - 	 */
    + 		if (mlim1 > XDL_MAX_EQLIMIT)
    + 			mlim1 = XDL_MAX_EQLIMIT;
    + 	}
     -	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     -		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
     +	for (i = 0; i < len1; i++) {
    @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      		nm = rcrec ? rcrec->len2 : 0;
      		if (nm == 0)
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
    - 			action1[i] = INVESTIGATE;
    + 		if (mlim2 > XDL_MAX_EQLIMIT)
    + 			mlim2 = XDL_MAX_EQLIMIT;
      	}
    - 
     -	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     -		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
     +	for (i = 0; i < len2; i++) {
    @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      	xdf1->nreff = 0;
     -	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     +	for (i = 0; i < len1; i++) {
    - 		if (action1[i] == INVESTIGATE) {
    + 		uint8_t action = action1[i];
    + 
    + 		if (action == INVESTIGATE) {
     -			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
     +			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
    - 				action1[i] = KEEP;
    + 				action = KEEP;
      			else
    - 				action1[i] = DISCARD;
    + 				action = DISCARD;
      		}
      
    - 		if (action1[i] == KEEP) {
    + 		if (action == KEEP) {
     -			xdf1->reference_index[xdf1->nreff++] = i;
     +			xdf1->reference_index[xdf1->nreff++] = i + off;
      			/* changed[i] remains false */
    - 		} else if (action1[i] == DISCARD)
    + 		} else if (action == DISCARD) {
     -			xdf1->changed[i] = true;
     +			xdf1->changed[i + off] = true;
    - 		else
    - 			BUG("Illegal state for action1[i]");
    + 		} else {
    + 			BUG("Illegal state for action");
    + 		}
      	}
      
      	xdf2->nreff = 0;
     -	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     +	for (i = 0; i < len2; i++) {
    - 		if (action2[i] == INVESTIGATE) {
    + 		uint8_t action = action2[i];
    + 
    + 		if (action == INVESTIGATE) {
     -			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
     +			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
    - 				action2[i] = KEEP;
    + 				action = KEEP;
      			else
    - 				action2[i] = DISCARD;
    + 				action = DISCARD;
      		}
      
    - 		if (action2[i] == KEEP) {
    + 		if (action == KEEP) {
     -			xdf2->reference_index[xdf2->nreff++] = i;
     +			xdf2->reference_index[xdf2->nreff++] = i + off;
      			/* changed[i] remains false */
    - 		} else if (action2[i] == DISCARD)
    + 		} else if (action == DISCARD) {
     -			xdf2->changed[i] = true;
     +			xdf2->changed[i + off] = true;
    - 		else
    - 			BUG("Illegal state for action2[i]");
    - 	}
    + 		} else {
    + 			BUG("Illegal state for action");
    + 		}
2:  78e9313fd44 ! 2:  977f4577521 xdiff: cleanup xdl_clean_mmatch()
    @@ xdiff/xprepare.c: void xdl_free_env(xdfenv_t *xe) {
      	/*
      	 * Limits the window that is examined during the similar-lines
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
    - 	xdf1->nreff = 0;
    - 	for (i = 0; i < len1; i++) {
    - 		if (action1[i] == INVESTIGATE) {
    + 		uint8_t action = action1[i];
    + 
    + 		if (action == INVESTIGATE) {
     -			if (!xdl_clean_mmatch(action1, i, 0, len1 - 1))
     +			if (!xdl_clean_mmatch(action1, i, len1))
    - 				action1[i] = KEEP;
    + 				action = KEEP;
      			else
    - 				action1[i] = DISCARD;
    + 				action = DISCARD;
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
    - 	xdf2->nreff = 0;
    - 	for (i = 0; i < len2; i++) {
    - 		if (action2[i] == INVESTIGATE) {
    + 		uint8_t action = action2[i];
    + 
    + 		if (action == INVESTIGATE) {
     -			if (!xdl_clean_mmatch(action2, i, 0, len2 - 1))
     +			if (!xdl_clean_mmatch(action2, i, len2))
    - 				action2[i] = KEEP;
    + 				action = KEEP;
      			else
    - 				action2[i] = DISCARD;
    + 				action = DISCARD;
3:  cdcad99edc4 = 3:  24e65d42b72 xprepare: simplify error handling
4:  a3438dc0933 = 4:  d7cb49a7c99 xdiff: reduce the size of array
-- 
2.54.0.rc1.174.gd833f386ac5.dirty

