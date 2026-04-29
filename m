Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6763425CF7
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500500; cv=none; b=jfunsAQvA7xIhQpa1a0GDgPUje5vCzcQ480wcq8M4EL5g67JhOytOsRtRTcf/3mxvsZcWAdUrUhnXUJ2hv+YNmjQgE+ev5yox8yjIHpPTh//zyT7hDBiS3HVsBc5m+jhSDYfsqWoaKhEdw7SDF8NJqFIK30rtIJCrDn9+ohixs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500500; c=relaxed/simple;
	bh=iRN9UecPREz+T/SDcn2AKXlYLSkBp4p7Ie2mMmjShtg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j41WKX60g2UtsWmvHkGvyrC4fZ8EmX9HwW9QFQj9OWnsyV1Pk2eImQGyUXc21ybKWuwxdOftuMegdQmiiugIbONlEdlNBIo5upii+UWTLJyhGZan+1zZ28gkeu6iLiXPNdvzYTBdL1V4ZOZyWbNz16Jghk1CbPmM7OylEL3CQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPIZOhB0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPIZOhB0"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d880e6fbbso13026311cf.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777500497; x=1778105297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG48xb1rOoViNKBeA7ePinx6sEwHAA8Gmuciomlkmvc=;
        b=XPIZOhB0OQcWl/1Vr4yG7hw9e9h8ifmX1y2scp6L5sBK/l5XqRrohHdpn8GEyh/4FE
         N9T1lJnePiKN+wtPLFryCUsGkTFc8MonbbxZECp/i312PwX732kwzp3vtf6tFEUSRU/8
         lGyaxPL/55jKMQy1PFAt7mO6jszeaNimFKO0p0+NVKEBVahyfZlEDKyjYsepORC2S3AN
         vmYZ3XknKktyPuT3BIVEdZc0C3uJAKfLt91FyP5zmfh4LC+9idx8Jo60lYmsD5ICTPra
         O0AhfhJHulioHs6vK0jJNXRTLzj9l7mGP+h9RrgKG7sPNqSiK/lhse40wR61jj70UhkM
         qoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777500497; x=1778105297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BG48xb1rOoViNKBeA7ePinx6sEwHAA8Gmuciomlkmvc=;
        b=I0I7Z9cvs4lhHqx7zo40NfgvlwKHndJH71TghfvoxND+Llide0xmZKC6Uh41KvNLND
         WNTBACMeyAlBQSuE/Y+/6ZAYUsfqHv4JgDHnlkTlfLpuowigJRKHdsx24bSQWqdsmJPb
         rKt1HMsMcNcd4oawljDiab/JA8j2X9//DYvfpZm6Nw7yVsdu35TjDhIH7Z8G59o3CmPA
         oV5wQ/VAU6bVDSWBZRc/mAgUgB6xI7ZfK+Y2xzbqKFizioqxgSU8oOy+Ezq7qgFJFPuV
         XExgZCgoN9p4xLjwsjGyK60eLX2OS3fR6nfwKuYdQJnVeTF3V6egDYrWC2R8UuzAX+Aq
         boUA==
X-Gm-Message-State: AOJu0Yx252SMGGc8jOA2la0reKLg9iLLnp8nTWhHU7BppYK+0dIF6Cd/
	Tsp7NzKe6IRxDq9N7U11NGyoifQXc9bqZJayQ8gyeyBoxrzmgKgasXGvfUGjCg==
X-Gm-Gg: AeBDiesfB1WCwaJxeejreBRtpW2S3aYA8ZryqW5jAKJmO547TOUK3AU2ao3IWdbBtui
	dgj6gk4sdxgwE7hQv50tS0ObtUfFDsIAOgemdj5mBkFVe2YXbkHYNsbnFWKgBAnQK38Km2eilHO
	GJ8Cj/5dxlL5fnJJRBjOA9HCByipe+breiqaPKLPk5YfYRUxjoDN4jdJLM5n/Lm79KH7TaMhlzj
	gWKoLUiYFOq1m2dXIikzPG+K+0/CF3wLQQUEo49TG4Jj3g4aqIjA7Bj9M9bMsmpAD6XfNjQAmJS
	kbCydecs0XCyBAqH2QRW4eJZsVU9YWCPAmgBhPHydv602Zr4fia+kLRr66NH22lafcodHlnxA8D
	9iRyQ0Fz0Td4SBwmvsIHDQDpW3o41s76PSU8atOVqzd+ImMWBrwU1jCcj1MQ51DRZMqBH/gFsmq
	SacfaWtAQ8Dc4A8fFXMC8Hy1YlCWFB6/xRAXbvYUA=
X-Received: by 2002:ac8:5706:0:b0:50e:474a:47e1 with SMTP id d75a77b69052e-51019a290ecmr65205231cf.10.1777500497016;
        Wed, 29 Apr 2026 15:08:17 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.100.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ff43997dsm906416d6.24.2026.04.29.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 15:08:16 -0700 (PDT)
Message-Id: <pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 22:08:09 +0000
Subject: [PATCH v6 0/6] Xdiff cleanup part 3
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v6:

 * implement suggestions by Phillip Wood [1,2]

Phillip's second "if" in [1] differs from his first one. In my changes I
made both of them structurally the same.

Something I'm confused by is the range-diff of patch 5. I'm confused why
range-diff states that this is different at all. I don't think this is a
problem, I just don't like not being able to explain a difference pointed
out by range-diff.

5: 88c68fa89a ! 5: 099b08c33f xdiff/xdl_cleanup_records: make setting action
easier to follow @@ xdiff/xprepare.c: static int
xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t * + action1[i] =
INVESTIGATE; }

-   for (i = xdf2->dstart; i <= xdf2->dend; i++) {
+   if (need_min) {
+@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
            size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
            rcrec = cf->rcrecs[mph2];
            nm = rcrec ? rcrec->len1 : 0;


[1] limits
https://lore.kernel.org/git/d88af7e1-e8dd-4423-9c6c-977e1f1dc074@gmail.com/
[2] action execution
https://lore.kernel.org/git/df244360-e9a9-44c0-946d-29288e6dd269@gmail.com/

Changes in v5:

 * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
   clarity".
 * add braces around the else clause

I didn't see a better way to rewrite how action is used so I reverted to
what it used to be.

Changes in v4:

 * Change SIZE_MAX to PTRDIFF_MAX.

Changes in v3:

 * run make DEVELOPER=1 on each commit and fix all compiler issues

v2 is a radical departure from v1 Changes in v2:

 * make the flow of xdl_cleanup_records() easier to follow

There is no performance or behavioral change introduced in this patch
series.

=== original cover letter bellow ===

Patch series summary:

 * patch 1: Introduce the ivec type
 * patch 2: Create the function xdl_do_classic_diff()
 * patches 3-4: generic cleanup
 * patches 5-8: convert from dstart/dend (in xdfile_t) to
   delta_start/delta_end (in xdfenv_t)
 * patches 9-10: move xdl_cleanup_records(), and related, from xprepare.c to
   xdiffi.c

Things that will be addressed in future patch series:

 * Make xdl_cleanup_records() easier to read
 * convert recs/nrec into an ivec
 * convert changed to an ivec
 * remove reference_index/nreff from xdfile_t and turn it into an ivec
 * splitting minimal_perfect_hash out as its own ivec
 * improve the performance of the classifier and parsing/hashing lines

=== before this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; ptrdiff_t dstart, dend; bool *changed; size_t *reference_index;
size_t nreff; } xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; } xdfenv_t;

=== after this patch series typedef struct s_xdfile { xrecord_t *recs;
size_t nrec; bool *changed; size_t *reference_index; size_t nreff; }
xdfile_t;

typedef struct s_xdfenv { xdfile_t xdf1, xdf2; size_t delta_start,
delta_end; size_t mph_size; } xdfenv_t;

Ezekiel Newren (6):
  xdiff/xdl_cleanup_records: delete local recs pointer
  xdiff: use unambiguous types in xdl_bogo_sqrt()
  xdiff/xdl_cleanup_records: use unambiguous types
  xdiff/xdl_cleanup_records: make limits more clear
  xdiff/xdl_cleanup_records: make setting action easier to follow
  xdiff/xdl_cleanup_records: make execution of action easier to follow

 xdiff/xdiffi.c   |  2 +-
 xdiff/xprepare.c | 97 ++++++++++++++++++++++++++++++++++--------------
 xdiff/xutils.c   |  4 +-
 xdiff/xutils.h   |  2 +-
 4 files changed, 73 insertions(+), 32 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v6
Pull-Request: https://github.com/git/git/pull/2156

Range-diff vs v5:

 1:  b31924a949 = 1:  b31924a949 xdiff/xdl_cleanup_records: delete local recs pointer
 2:  1822166fef = 2:  1822166fef xdiff: use unambiguous types in xdl_bogo_sqrt()
 3:  85aa0da90c = 3:  85aa0da90c xdiff/xdl_cleanup_records: use unambiguous types
 4:  fec2b0f38a ! 4:  51c62ed454 xdiff/xdl_cleanup_records: make limits more clear
     @@ Commit message
            * The additional condition `!need_min` is redudant now, remove it.
          Best viewed with --color-words.
      
     +    Helped-by: Phillip Wood
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
     @@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t
       	uint8_t *action1 = NULL, *action2 = NULL;
       	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		goto cleanup;
     - 	}
     - 
     -+	if (need_min) {
     -+		/* i.e. infinity */
     -+		mlim1 = PTRDIFF_MAX;
     -+		mlim2 = PTRDIFF_MAX;
     -+	} else {
     -+		mlim1 = XDL_MIN(xdl_bogosqrt(xdf1->nrec), XDL_MAX_EQLIMIT);
     -+		mlim2 = XDL_MIN(xdl_bogosqrt(xdf2->nrec), XDL_MAX_EQLIMIT);
     -+	}
     -+
       	/*
       	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
       	 */
      -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
      -		mlim = XDL_MAX_EQLIMIT;
     ++	if (need_min) {
     ++		/* i.e. infinity */
     ++		mlim1 = PTRDIFF_MAX;
     ++	} else {
     ++		mlim1 = xdl_bogosqrt((uint64_t)xdf1->nrec);
     ++		if (mlim1 > XDL_MAX_EQLIMIT)
     ++			mlim1 = XDL_MAX_EQLIMIT;
     ++	}
       	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
       		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
       		rcrec = cf->rcrecs[mph1];
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       
      -	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
      -		mlim = XDL_MAX_EQLIMIT;
     ++	if (need_min) {
     ++		/* i.e. infinity */
     ++		mlim2 = PTRDIFF_MAX;
     ++	} else {
     ++		mlim2 = xdl_bogosqrt((uint64_t)xdf2->nrec);
     ++		if (mlim2 > XDL_MAX_EQLIMIT)
     ++			mlim2 = XDL_MAX_EQLIMIT;
     ++	}
       	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
       		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
       		rcrec = cf->rcrecs[mph2];
 5:  88c68fa89a ! 5:  45ad2ae62d xdiff/xdl_cleanup_records: make setting action easier to follow
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      +			action1[i] = INVESTIGATE;
       	}
       
     - 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     + 	if (need_min) {
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
       		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
       		rcrec = cf->rcrecs[mph2];
       		nm = rcrec ? rcrec->len1 : 0;
 6:  699e198fa9 ! 6:  a5174802f4 xdiff/xdl_cleanup_records: put braces around the else clause
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff/xdl_cleanup_records: put braces around the else clause
     +    xdiff/xdl_cleanup_records: make execution of action easier to follow
      
     +    Helped-by: Phillip Wood
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
     + 	 */
     + 	xdf1->nreff = 0;
     + 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     +-		if (action1[i] == KEEP ||
     +-		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
     ++		uint8_t action = action1[i];
     ++
     ++		if (action == INVESTIGATE) {
     ++			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
     ++				action = KEEP;
     ++			else
     ++				action = DISCARD;
     ++		}
     ++
     ++		if (action == KEEP) {
       			xdf1->reference_index[xdf1->nreff++] = i;
     - 			/* changed[i] remains false, i.e. keep */
     +-			/* changed[i] remains false, i.e. keep */
      -		} else
     -+		} else {
     ++			/* changed[i] remains false */
     ++		} else if (action == DISCARD) {
       			xdf1->changed[i] = true;
     - 			/* i.e. discard */
     +-			/* i.e. discard */
     ++		} else {
     ++			BUG("Illegal state for action");
      +		}
       	}
       
       	xdf2->nreff = 0;
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
     + 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     +-		if (action2[i] == KEEP ||
     +-		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
     ++		uint8_t action = action2[i];
     ++
     ++		if (action == INVESTIGATE) {
     ++			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
     ++				action = KEEP;
     ++			else
     ++				action = DISCARD;
     ++		}
     ++
     ++		if (action == KEEP) {
       			xdf2->reference_index[xdf2->nreff++] = i;
     - 			/* changed[i] remains false, i.e. keep */
     +-			/* changed[i] remains false, i.e. keep */
      -		} else
     -+		} else {
     ++			/* changed[i] remains false */
     ++		} else if (action == DISCARD) {
       			xdf2->changed[i] = true;
     - 			/* i.e. discard */
     +-			/* i.e. discard */
     ++		} else {
     ++			BUG("Illegal state for action");
      +		}
       	}
       

-- 
gitgitgadget
