Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB812FC86A
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662675; cv=none; b=FYtPhewvYEmezlC53BMUIPGCG2slb46IL+nHee1yF1If9Zc8rjIfdzxNYzL3psBxf0ffMicyIoiEREAO03B4H5Sj9PW+aCMLWAm3M14IuIN5biz3F/hITFJszLaVmhQnOW6yikEV1YHaSFBiRoMX5Vr/vFwN6O/IWvlHZuVsbmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662675; c=relaxed/simple;
	bh=rgLEVwpVx0iPkgqvsH7S+cnhchemYke5xgE3Hi0IOnA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oOKTJi1n++OPqhNH5NSbgOYik4luZrgvyEAE5BoCi+1x46EkUUVlNhcAnqFBvk4vsK35vulunILiRekVp69lxRBvV8altb9kik7Z/6/kDH08wUxFy77l8CovCPysGz7famC640TUipbId32G46RDgULST54mdyctedjVUZKEhCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSTeGcla; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSTeGcla"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f2077d1c8so323276b3a.0
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662672; x=1759267472; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj5kpBauHRH56G+8WcdzVxVV1+VCV09MRTJMfww1Lis=;
        b=GSTeGclaUs4IlmTTWzBMXDHkZUXUaFWljkbuM9tqHHYd8CvCuA+IOFqVv7m9THuMR2
         AvSD2pyIzcrEeXGzgQoAQcatXl99AmQmHHOOdSkVpcUnLB+IGY43HYUtq3uk1zPa/aWg
         c8ssOBY6VWRW1EM/201vUVesrhCzGZHVXl13XEC/R2Vcup6w7qpb9lDfPHh5GVXH/2NK
         KiWThfdrSgY/GJsZp8m3AoyaQtEqcENSPAdAk42ZT4N5JLt2JmldMxkeLbITdwuUDWCI
         QVVH80ZW5ouDK6X85HXjUMU8BYm0q2UMt91AMVulUTSh3xrTJkZVDQUhEyGAPrckILOp
         sx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662672; x=1759267472;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj5kpBauHRH56G+8WcdzVxVV1+VCV09MRTJMfww1Lis=;
        b=kIy3EsvJ03jq6eY96Z0ZyjOo6UyhgQpJp8qfmDPWoGZm/eK63jwkc2riahc84z7H5F
         Rw9aSddZhMp8WtqkDTy5gwO9C3fJ+RkyA7wcRtH7ajZsr8E8NxVcMou5YidzrdXxFM37
         6GDFY+P9Sxxbq0Uwcr5fjaenbFlRFd7z7TZpj395mNorhaaapPep3XVoXVaiPff7dDop
         oxLJ41sCR8SnUSWUPko8kAmUL7Y//o+WYXdLenUL0NS76nFOdf1C5OIN6cwfHPAXded6
         TJhnGgTQfy2wSpSP/NRzdWFxJ2JB6s69KB05pKdvaseR966LpF1x9M2UsZnFhM3enz4P
         8XlA==
X-Gm-Message-State: AOJu0Yy0liO9gMCIGIlGBQ6isCF93pHfLFChtjFZYaEDUYL7Y8K5x4Xj
	L9ZDgWaH3OdqRs9LelI/TmBEMc4ZbfC32YykCBUKa5PQnHHFCaeIr5xIRGqPXO/Z
X-Gm-Gg: ASbGncsjWWZW6CfH1X1SvjjJtdT1sEvI3khX5jzvUxaYni5DmEuYr5vPOCEcWo4f0AG
	Dlt9ZgfKdsu2h7aO8BUM+8jUi9dgalqkkUtzKx0KlTqIfHVO4BK8hTB3AgaHKyhYsxf4uDHiPgm
	GpBIDY2U7/kg5S8mXt87fAXnubhBHA/wbUfZi/WpJXyasfnyygMBusQLmNd1FyuwqG3HJKM+HkK
	NjLsXtKWFP77CsmNt68PNDkcVZll0RMxx67tT8ct9A5MWJ398PDQ7oFnbmzpvNAgo6EVKYKWytY
	17gn0iSJOSkWAC33lntjgvNQsygLWS3D09MXN1u2l0AYnh9IwZdgNtG5FvfnZ1c0T8llf9T+I3G
	fYyAJIe2cJnxNjsl/hxqFR1wUzg==
X-Google-Smtp-Source: AGHT+IE6lYKBj8wlxdXJGIQUyYX5nHZiAxxCyQxagR4VbX8PHPk5ODvAz1lK1OJbsryIX/5EtiUJgw==
X-Received: by 2002:a05:6a20:a126:b0:261:ed47:c9b5 with SMTP id adf61e73a8af0-2de85023f56mr168325637.13.1758662672358;
        Tue, 23 Sep 2025 14:24:32 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b554aa612e7sm6825693a12.8.2025.09.23.14.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 14:24:31 -0700 (PDT)
Message-Id: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 21:24:17 +0000
Subject: [PATCH v5 00/13] Cleanup xdfile_t and xrecord_t in xdiff.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Jeff King <peff@peff.net>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes since v4.

 * Make it clear that the field xdfile_t.rchg (now 'xdfile_t.changed') is
   distinct from the local variables dis1, dis2 (now 'matches1',
   'matches2').
 * Use NONE, SOME, TOO_MANY instead of NO, YES, MAYBE.
 * Use bool literals for xdfile_t.changed.

Changes since v3.

 * Address review feedback.
 * Split the deletion of xdl_get_rec() into 2 commits.
 * Move NO, YES, MAYBE into xprepare.c, and use bool literals.
 * refactor 'char rchg' to 'bool changed'

Changes since v2.

 * No patch changes, just resending to get patch 9 to show up on the mailing
   list.
 * A few tweaks to the cover letter.

Changes since v1, to address review feedback.

 * Only include the clean up patches; The remaining patches will be split
   into a separate series.
 * Commit message clarifications.
 * Minor style cleanups.
 * Performance impacts included in commit message of patch 8.


Relevant part of the original cover letter follows:
===================================================

Before:

typedef struct s_xrecord {
	struct s_xrecord *next;
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	chastore_t rcha;
	long nrec;
	unsigned int hbits;
	xrecord_t **rhash;
	long dstart, dend;
	xrecord_t **recs;
	char *rchg;
	long *rindex;
	long nreff;
	unsigned long *ha;
} xdfile_t;


After cleanup:

typedef struct s_xrecord {
	char const *ptr;
	long size;
	unsigned long ha;
} xrecord_t;

typedef struct s_xdfile {
	xrecord_t *recs;
	long nrec;
	long dstart, dend;
	bool *changed;
	long *rindex;
	long nreff;
} xdfile_t;


===

Ezekiel Newren (13):
  xdiff: delete static forward declarations in xprepare
  xdiff: delete local variables and initialize/free xdfile_t directly
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: delete superfluous function xdl_get_rec() in xemit
  xdiff: delete superfluous local variables that alias fields in
    xrecord_t
  xdiff: delete struct diffdata_t
  xdiff: delete redundant array xdfile_t.ha
  xdiff: delete fields ha, line, size in xdlclass_t in favor of an
    xrecord_t
  xdiff: delete chastore from xdfile_t
  xdiff: delete rchg aliasing
  xdiff: rename rchg -> changed in xdfile_t
  xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
  xdiff: change type of xdfile_t.changed from char to bool

 xdiff/xdiffi.c     | 101 ++++++--------
 xdiff/xdiffi.h     |  11 +-
 xdiff/xemit.c      |  38 ++----
 xdiff/xhistogram.c |  10 +-
 xdiff/xmerge.c     |  56 ++++----
 xdiff/xpatience.c  |  18 +--
 xdiff/xprepare.c   | 330 ++++++++++++++++++++-------------------------
 xdiff/xtypes.h     |   9 +-
 xdiff/xutils.c     |  16 +--
 9 files changed, 259 insertions(+), 330 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2048%2Fezekielnewren%2Fuse_rust_types_in_xdiff-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2048/ezekielnewren/use_rust_types_in_xdiff-v5
Pull-Request: https://github.com/git/git/pull/2048

Range-diff vs v4:

  1:  79d1099656 =  1:  890e508000 xdiff: delete static forward declarations in xprepare
  2:  9142f28fcd =  2:  0cfd75b1ff xdiff: delete local variables and initialize/free xdfile_t directly
  3:  13f00f5683 =  3:  92c81d2ff6 xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  4:  311279c123 =  4:  7d3a7e617c xdiff: delete superfluous function xdl_get_rec() in xemit
  5:  d84658ac83 =  5:  1d550cf308 xdiff: delete superfluous local variables that alias fields in xrecord_t
  6:  bf16453846 =  6:  2a3a1b657e xdiff: delete struct diffdata_t
  7:  4ef7f243e9 =  7:  4c6543cbe3 xdiff: delete redundant array xdfile_t.ha
  8:  3b6c2127c4 =  8:  21bf4b5a20 xdiff: delete fields ha, line, size in xdlclass_t in favor of an xrecord_t
  9:  f7b5021e48 =  9:  ef6ae7d29c xdiff: delete chastore from xdfile_t
 10:  97135495e2 = 10:  7b0856108a xdiff: delete rchg aliasing
 12:  034a4a7b2a ! 11:  570ab9f898 xdiff: refactor 'char *rchg' to 'bool *changed' in xdfile_t
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: refactor 'char *rchg' to 'bool *changed' in xdfile_t
     +    xdiff: rename rchg -> changed in xdfile_t
      
     +    Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
     @@ xdiff/xdiffi.c: int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
       	 */
       	if (off1 == lim1) {
       		for (; off2 < lim2; off2++)
     --			xdf2->rchg[xdf2->rindex[off2]] = true;
     -+			xdf2->changed[xdf2->rindex[off2]] = true;
     +-			xdf2->rchg[xdf2->rindex[off2]] = 1;
     ++			xdf2->changed[xdf2->rindex[off2]] = 1;
       	} else if (off2 == lim2) {
       		for (; off1 < lim1; off1++)
     --			xdf1->rchg[xdf1->rindex[off1]] = true;
     -+			xdf1->changed[xdf1->rindex[off1]] = true;
     +-			xdf1->rchg[xdf1->rindex[off1]] = 1;
     ++			xdf1->changed[xdf1->rindex[off1]] = 1;
       	} else {
       		xdpsplit_t spl;
       		spl.i1 = spl.i2 = 0;
     @@ xdiff/xdiffi.c: static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->end < xdf->nrec &&
       	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
     --		xdf->rchg[g->start++] = false;
     --		xdf->rchg[g->end++] = true;
     -+		xdf->changed[g->start++] = false;
     -+		xdf->changed[g->end++] = true;
     +-		xdf->rchg[g->start++] = 0;
     +-		xdf->rchg[g->end++] = 1;
     ++		xdf->changed[g->start++] = 0;
     ++		xdf->changed[g->end++] = 1;
       
      -		while (xdf->rchg[g->end])
      +		while (xdf->changed[g->end])
     @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->start > 0 &&
       	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
     --		xdf->rchg[--g->start] = true;
     --		xdf->rchg[--g->end] = false;
     -+		xdf->changed[--g->start] = true;
     -+		xdf->changed[--g->end] = false;
     +-		xdf->rchg[--g->start] = 1;
     +-		xdf->rchg[--g->end] = 0;
     ++		xdf->changed[--g->start] = 1;
     ++		xdf->changed[--g->end] = 0;
       
      -		while (xdf->rchg[g->start - 1])
      +		while (xdf->changed[g->start - 1])
     @@ xdiff/xhistogram.c: redo:
       
       	if (!count1) {
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = true;
     -+			env->xdf2.changed[line2++ - 1] = true;
     +-			env->xdf2.rchg[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = 1;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = true;
     -+			env->xdf1.changed[line1++ - 1] = true;
     +-			env->xdf1.rchg[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = 1;
       		return 0;
       	}
       
     @@ xdiff/xhistogram.c: redo:
       	else {
       		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
       			while (count1--)
     --				env->xdf1.rchg[line1++ - 1] = true;
     -+				env->xdf1.changed[line1++ - 1] = true;
     +-				env->xdf1.rchg[line1++ - 1] = 1;
     ++				env->xdf1.changed[line1++ - 1] = 1;
       			while (count2--)
     --				env->xdf2.rchg[line2++ - 1] = true;
     -+				env->xdf2.changed[line2++ - 1] = true;
     +-				env->xdf2.rchg[line2++ - 1] = 1;
     ++				env->xdf2.changed[line2++ - 1] = 1;
       			result = 0;
       		} else {
       			result = histogram_diff(xpp, env,
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	/* trivial case: one side is empty */
       	if (!count1) {
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = true;
     -+			env->xdf2.changed[line2++ - 1] = true;
     +-			env->xdf2.rchg[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = 1;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = true;
     -+			env->xdf1.changed[line1++ - 1] = true;
     +-			env->xdf1.rchg[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = 1;
       		return 0;
       	}
       
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	/* are there any matching lines at all? */
       	if (!map.has_matches) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = true;
     -+			env->xdf1.changed[line1++ - 1] = true;
     +-			env->xdf1.rchg[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = 1;
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = true;
     -+			env->xdf2.changed[line2++ - 1] = true;
     +-			env->xdf2.rchg[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = 1;
       		xdl_free(map.entries);
       		return 0;
       	}
     @@ xdiff/xprepare.c: static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, lo
       	xdf->dstart = 0;
       	xdf->dend = xdf->nrec - 1;
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
     + 		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
       			xdf1->rindex[nreff++] = i;
       		} else
     --			xdf1->rchg[i] = true;
     -+			xdf1->changed[i] = true;
     +-			xdf1->rchg[i] = 1;
     ++			xdf1->changed[i] = 1;
       	}
       	xdf1->nreff = nreff;
       
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
     + 		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
       			xdf2->rindex[nreff++] = i;
       		} else
     --			xdf2->rchg[i] = true;
     -+			xdf2->changed[i] = true;
     +-			xdf2->rchg[i] = 1;
     ++			xdf2->changed[i] = 1;
       	}
       	xdf2->nreff = nreff;
       
     @@ xdiff/xtypes.h: typedef struct s_xdfile {
       	long nrec;
       	long dstart, dend;
      -	char *rchg;
     -+	bool *changed;
     ++	char *changed;
       	long *rindex;
       	long nreff;
       } xdfile_t;
  -:  ---------- > 12:  08a0fceb72 xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
 11:  b544c15a67 ! 13:  975e845bfa xdiff: use bool literals for xdfile_t.rchg
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    xdiff: use bool literals for xdfile_t.rchg
     +    xdiff: change type of xdfile_t.changed from char to bool
      
     -    Define macros NO(0), YES(1), MAYBE(2) as the enum values for dis1 and
     -    dis2 to make the code easier to follow.
     +    The only values possible for 'changed' is 1 and 0, which exactly maps
     +    to a bool type. It might not look like this is the case because
     +    matches1 and matches2 (which use to be dis1, and dis2) were also char
     +    and were assigned numerical values within a few lines of 'changed'
     +    (what used to be rchg).
     +
     +    Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
     +    for changed[k] makes it clear to future readers that these are
     +    logically separate concepts.
      
          Best-viewed-with: --color-words
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
     @@ xdiff/xdiffi.c: int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
       	 */
       	if (off1 == lim1) {
       		for (; off2 < lim2; off2++)
     --			xdf2->rchg[xdf2->rindex[off2]] = 1;
     -+			xdf2->rchg[xdf2->rindex[off2]] = true;
     +-			xdf2->changed[xdf2->rindex[off2]] = 1;
     ++			xdf2->changed[xdf2->rindex[off2]] = true;
       	} else if (off2 == lim2) {
       		for (; off1 < lim1; off1++)
     --			xdf1->rchg[xdf1->rindex[off1]] = 1;
     -+			xdf1->rchg[xdf1->rindex[off1]] = true;
     +-			xdf1->changed[xdf1->rindex[off1]] = 1;
     ++			xdf1->changed[xdf1->rindex[off1]] = true;
       	} else {
       		xdpsplit_t spl;
       		spl.i1 = spl.i2 = 0;
     @@ xdiff/xdiffi.c: static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->end < xdf->nrec &&
       	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
     --		xdf->rchg[g->start++] = 0;
     --		xdf->rchg[g->end++] = 1;
     -+		xdf->rchg[g->start++] = false;
     -+		xdf->rchg[g->end++] = true;
     +-		xdf->changed[g->start++] = 0;
     +-		xdf->changed[g->end++] = 1;
     ++		xdf->changed[g->start++] = false;
     ++		xdf->changed[g->end++] = true;
       
     - 		while (xdf->rchg[g->end])
     + 		while (xdf->changed[g->end])
       			g->end++;
      @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
       {
       	if (g->start > 0 &&
       	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
     --		xdf->rchg[--g->start] = 1;
     --		xdf->rchg[--g->end] = 0;
     -+		xdf->rchg[--g->start] = true;
     -+		xdf->rchg[--g->end] = false;
     +-		xdf->changed[--g->start] = 1;
     +-		xdf->changed[--g->end] = 0;
     ++		xdf->changed[--g->start] = true;
     ++		xdf->changed[--g->end] = false;
       
     - 		while (xdf->rchg[g->start - 1])
     + 		while (xdf->changed[g->start - 1])
       			g->start--;
      
       ## xdiff/xhistogram.c ##
     @@ xdiff/xhistogram.c: redo:
       
       	if (!count1) {
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = true;
     +-			env->xdf2.changed[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = true;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = true;
     +-			env->xdf1.changed[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = true;
       		return 0;
       	}
       
     @@ xdiff/xhistogram.c: redo:
       	else {
       		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
       			while (count1--)
     --				env->xdf1.rchg[line1++ - 1] = 1;
     -+				env->xdf1.rchg[line1++ - 1] = true;
     +-				env->xdf1.changed[line1++ - 1] = 1;
     ++				env->xdf1.changed[line1++ - 1] = true;
       			while (count2--)
     --				env->xdf2.rchg[line2++ - 1] = 1;
     -+				env->xdf2.rchg[line2++ - 1] = true;
     +-				env->xdf2.changed[line2++ - 1] = 1;
     ++				env->xdf2.changed[line2++ - 1] = true;
       			result = 0;
       		} else {
       			result = histogram_diff(xpp, env,
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	/* trivial case: one side is empty */
       	if (!count1) {
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = true;
     +-			env->xdf2.changed[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = true;
       		return 0;
       	} else if (!count2) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = true;
     +-			env->xdf1.changed[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = true;
       		return 0;
       	}
       
     @@ xdiff/xpatience.c: static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
       	/* are there any matching lines at all? */
       	if (!map.has_matches) {
       		while(count1--)
     --			env->xdf1.rchg[line1++ - 1] = 1;
     -+			env->xdf1.rchg[line1++ - 1] = true;
     +-			env->xdf1.changed[line1++ - 1] = 1;
     ++			env->xdf1.changed[line1++ - 1] = true;
       		while(count2--)
     --			env->xdf2.rchg[line2++ - 1] = 1;
     -+			env->xdf2.rchg[line2++ - 1] = true;
     +-			env->xdf2.changed[line2++ - 1] = 1;
     ++			env->xdf2.changed[line2++ - 1] = true;
       		xdl_free(map.entries);
       		return 0;
       	}
      
       ## xdiff/xprepare.c ##
     -@@
     - #define XDL_GUESS_NLINES1 256
     - #define XDL_GUESS_NLINES2 20
     - 
     -+#define NO 0
     -+#define YES 1
     -+#define MAYBE 2
     - 
     - typedef struct s_xdlclass {
     - 	struct s_xdlclass *next;
     -@@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
     - 	 * current line (i) is already a multimatch line.
     - 	 */
     - 	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
     --		if (!dis[i - r])
     -+		if (dis[i - r] == NO)
     - 			rdis0++;
     --		else if (dis[i - r] == 2)
     -+		else if (dis[i - r] == MAYBE)
     - 			rpdis0++;
     - 		else
     - 			break;
     -@@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
     - 	if (rdis0 == 0)
     - 		return 0;
     - 	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
     --		if (!dis[i + r])
     -+		if (dis[i + r] == NO)
     - 			rdis1++;
     --		else if (dis[i + r] == 2)
     -+		else if (dis[i + r] == MAYBE)
     - 			rpdis1++;
     - 		else
     - 			break;
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
     - 		rcrec = cf->rcrecs[recs->ha];
     - 		nm = rcrec ? rcrec->len2 : 0;
     --		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
     -+		dis1[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
     - 	}
       
     - 	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
     + 	/*
     + 	 * Create temporary arrays that will help us decide if
     +-	 * changed[i] should remain 0 or become 1.
     ++	 * changed[i] should remain false, or become true.
     + 	 */
     + 	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
     + 		status = -1;
      @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     - 	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
     - 		rcrec = cf->rcrecs[recs->ha];
     - 		nm = rcrec ? rcrec->len1 : 0;
     --		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
     -+		dis2[i] = (nm == 0) ? NO: (nm >= mlim && !need_min) ? MAYBE: YES;
     - 	}
       
     + 	/*
     + 	 * Use temporary arrays to decide if changed[i] should remain
     +-	 * 0 or become 1.
     ++	 * false, or become true.
     + 	 */
       	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
       	     i <= xdf1->dend; i++, recs++) {
     --		if (dis1[i] == 1 ||
     --		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
     -+		if (dis1[i] == YES ||
     -+		    (dis1[i] == MAYBE && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
     + 		if (matches1[i] == SOME ||
     + 		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
       			xdf1->rindex[nreff++] = i;
     +-			/* changed[i] remains 0 */
     ++			/* changed[i] remains false */
       		} else
     --			xdf1->rchg[i] = 1;
     -+			xdf1->rchg[i] = true;
     +-			xdf1->changed[i] = 1;
     ++			xdf1->changed[i] = true;
       	}
       	xdf1->nreff = nreff;
       
     - 	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
     - 	     i <= xdf2->dend; i++, recs++) {
     --		if (dis2[i] == 1 ||
     --		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
     -+		if (dis2[i] == YES ||
     -+		    (dis2[i] == MAYBE && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
     +@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
     + 		if (matches2[i] == SOME ||
     + 		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
       			xdf2->rindex[nreff++] = i;
     +-			/* changed[i] remains 0 */
     ++			/* changed[i] remains false */
       		} else
     --			xdf2->rchg[i] = 1;
     -+			xdf2->rchg[i] = true;
     +-			xdf2->changed[i] = 1;
     ++			xdf2->changed[i] = true;
       	}
       	xdf2->nreff = nreff;
       
     +
     + ## xdiff/xtypes.h ##
     +@@ xdiff/xtypes.h: typedef struct s_xdfile {
     + 	xrecord_t *recs;
     + 	long nrec;
     + 	long dstart, dend;
     +-	char *changed;
     ++	bool *changed;
     + 	long *rindex;
     + 	long nreff;
     + } xdfile_t;

-- 
gitgitgadget
