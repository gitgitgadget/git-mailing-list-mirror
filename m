Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E22E8882
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639439; cv=none; b=M3m5dCmxovFVkvkED+9L8dBbSjx3bdZ7wkPHiTAgFhIKLFs8xNCxqYi4g7pMKmiy/0zARuE1XWTUSmXVeYLYv00LrnKGgnZ224QCHggMjBhp8N969P+Y5Hm941xya6KwkzJ6NLXGQsSAGr9W8jhi72JTekWngVYImG5+0H4vmis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639439; c=relaxed/simple;
	bh=UxohZYQjkXKH3qaXB5ZfZ8A4YGW3Hja6yqBAiQjVNGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YxQfsEnr7QAryxtg7MTlmsMNYhYaQJ9kvFzl2IgGXGzOr4GWAykIjXfnqtWTwwNeomM/teb/ouX0GPdtWvS1G6jgVIdd21yvzcpqEob7bE1ItpYQxASN/D+7zVxB0SzdZewXGhEuGxPKE4/JXjQrY0cuG9X9riZ2oOCtD7d97Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwrLNdW6; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwrLNdW6"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128b9b7e3edso2092762c88.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639436; x=1775244236; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QApsensiHDKTRxvPdiqOZ/aU2h/AvZzndC1TY3Co6xM=;
        b=TwrLNdW6IplcN9FqlVENGrrDUh5JEWe017iUlb+vimcTut+6tWhz3ouqcRhxceESiL
         H2d8Sdbl8SMca43GXChEfZtwrYydc41yOgPRkh3bzWU9qVlnyXKJhg6JQAFyIah7MS3d
         N2DwK4rNZ8NMJwWfDV9qIH269zUhu0YfIZBBpQilqoKFeT6+E+LsH39+QXvc0vgov/Us
         JDSm3uzELdnM+TMqWNm2U7sEzGtAEokSalrqq+zuFDGbv+0vuxl97H2fppHUFefsnUqJ
         w1hNfoorPhaieteIuEpZJClXePumSU58Hxo6beeus4zshGhqc20v4CBZklMeLn/GxLoe
         lNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639436; x=1775244236;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QApsensiHDKTRxvPdiqOZ/aU2h/AvZzndC1TY3Co6xM=;
        b=lB4sf4vtk1J1/GZMZd9rB3qVjpTtCMKgTM1fHcSyoIq3lsLBZe7jQhsg87vLlduOkb
         Z22GlYGnGFyVLYbu5N0H+HX2G9Tz87BswW+7K3HSx34ZX9H0XDLf8OhG/s6AkQPwYWEg
         zEZZkotB103hJtqbSTo3CZbGZAhZ9xVZs7/NmB3pZd8BjDbA2jf2QhTKZCzKKnzq68hh
         EmziWcCNwO/QQ8fGHmjmXJPDs5XstMb4TqRKcVL6CWEMjy6UsrSyG0WDJns+cBfKqu2Q
         6E/gqUOThxe10VUG+hPr1XvpDePhUoaXcLeMMYF7qcfo+xriimuGALEc2gO/XjGqej2h
         lB/g==
X-Gm-Message-State: AOJu0YzbzPKc6l9xkTFh7TEzzGLzY2TI5MVN0tlwt5HCZErrXjb6DE3E
	mGJNVLuOOroUs7MCwmMgsMpCzw/FSQQdcHAEcsrM24AblxmGI5ieqMoI6YRMZw==
X-Gm-Gg: ATEYQzz8H6Om+XyoHNNw/SWK7j3EpBLQIW8ezWqtheK/uzgpvJwsLKZCnOOZQMLEhO6
	ln+kvROtH62CM1dcfGSdkpKYY32XHkmJgrWGwBu1JIPTk4TTcAh8wc3//qvi06y8hguZNF52zv5
	cd7ARDAY0uZ6kGmoR9W43tjcnHjgtEGYgyRvN0C0GBc4C/QhiEy6Tpv9+0dhfn/OzKmFDfDWNFH
	yqBjGZDg51wYX1/TExHWyLaLo6xAWrInhkJ8gPS8RX7YWV9UgGKRKxNrBK/38HbuoYyiVMFV78R
	JrfpnHv7UFkVwCb1alL0nyXW4wGHxJvzlIFySqx5x/3CpuGDPDIoEFW6svnTPDYGa26WtLasWQz
	XTHLtDD8FMp2Zykm6Vt2rze2zC7NxKr1oKqbtqxQL8s/L2Yjg1gG0gW/VVSIeR+a0RbK5rpuBRF
	U0BqIk5YT0aM5HbuVkhQYTo923yyI=
X-Received: by 2002:a05:7301:578e:b0:2bd:e153:68b3 with SMTP id 5a478bee46e88-2c185e59b45mr2156653eec.18.1774639436132;
        Fri, 27 Mar 2026 12:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c3bda306sm257463eec.3.2026.03.27.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:23:55 -0700 (PDT)
Message-Id: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:47 +0000
Subject: [PATCH v3 0/6] Xdiff cleanup part 3
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
    Ezekiel Newren <ezekielnewren@gmail.com>

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
  xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity

 xdiff/xdiffi.c   |  2 +-
 xdiff/xprepare.c | 84 ++++++++++++++++++++++++++++++++----------------
 xdiff/xutils.c   |  4 +--
 xdiff/xutils.h   |  2 +-
 4 files changed, 60 insertions(+), 32 deletions(-)


base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2156%2Fezekielnewren%2Fxdiff-cleanup-3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2156/ezekielnewren/xdiff-cleanup-3-v3
Pull-Request: https://github.com/git/git/pull/2156

Range-diff vs v2:

 1:  8f9165d477 = 1:  da32a9747c xdiff/xdl_cleanup_records: delete local recs pointer
 -:  ---------- > 2:  86b0ad100c xdiff: use unambiguous types in xdl_bogo_sqrt()
 5:  a52787f019 ! 3:  39a35365ae xdiff/xdl_cleanup_records: use unambiguous types
     @@ Commit message
          xdiff/xdl_cleanup_records: use unambiguous types
      
          Change the parameters of xdl_clean_mmatch() and the local variables
     -    i, nm in xdl_cleanup_records() to use unambiguous types. Best viewed
     -    with --color-words.
     +    i, nm, mlim in xdl_cleanup_records() to use unambiguous types. Best
     +    viewed with --color-words.
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     @@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, long i, lo
        * might be potentially discarded if they appear in a run of discardable.
        */
       static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
     --	long i, nm;
     --	size_t mlim1, mlim2;
     -+	ptrdiff_t i;
     -+	size_t nm, mlim1, mlim2;
     +-	long i, nm, mlim;
     ++	ptrdiff_t i, nm, mlim;
       	xdlclass_t *rcrec;
       	uint8_t *action1 = NULL, *action2 = NULL;
       	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
     - 		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
     - 		rcrec = cf->rcrecs[mph1];
     --		nm = rcrec ? rcrec->len2 : 0;
     -+		nm = rcrec ? (size_t)rcrec->len2 : 0;
     - 		if (nm == 0)
     - 			action1[i] = DISCARD;
     - 		else if (nm < mlim1)
     -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
     - 		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
     - 		rcrec = cf->rcrecs[mph2];
     --		nm = rcrec ? rcrec->len1 : 0;
     -+		nm = rcrec ? (size_t)rcrec->len1 : 0;
     - 		if (nm == 0)
     - 			action2[i] = DISCARD;
     - 		else if (nm < mlim2)
 2:  62adaa8e5a ! 4:  86dd98db9b xdiff/xdl_cleanup_records: make limits more clear
     @@ Commit message
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xprepare.c ##
     -@@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
     +@@ xdiff/xprepare.c: static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, pt
        * might be potentially discarded if they appear in a run of discardable.
        */
       static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
     --	long i, nm, mlim;
     -+	long i, nm;
     -+	size_t mlim1, mlim2;
     +-	ptrdiff_t i, nm, mlim;
     ++	ptrdiff_t i, nm, mlim1, mlim2;
       	xdlclass_t *rcrec;
       	uint8_t *action1 = NULL, *action2 = NULL;
       	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
       	/*
       	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
       	 */
     --	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
     +-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf1->nrec)) > XDL_MAX_EQLIMIT)
      -		mlim = XDL_MAX_EQLIMIT;
       	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
       		size_t mph1 = xdf1->recs[i].minimal_perfect_hash;
     @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
      +		action1[i] = (nm == 0) ? DISCARD: nm >= mlim1 ? INVESTIGATE: KEEP;
       	}
       
     --	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
     +-	if ((mlim = (long)xdl_bogosqrt((uint64_t)xdf2->nrec)) > XDL_MAX_EQLIMIT)
      -		mlim = XDL_MAX_EQLIMIT;
       	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
       		size_t mph2 = xdf2->recs[i].minimal_perfect_hash;
 3:  8be7e4781a = 5:  ecc25be32f xdiff/xdl_cleanup_records: make setting action easier to follow
 4:  6abd052c34 = 6:  8f4def8814 xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for clarity

-- 
gitgitgadget
