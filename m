Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556862DE6E6
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709288; cv=none; b=qfevUPT28wRkTd+XcALcyuxdKkYmJjVC8aejSI+YQwnWRwrxzTBwzyPhrjBEACU9eUvHis7pd8Atk/0+uvy6UWyh1ALhNuXvl/8PpSC+g2JLKm2V6RkdrBWDS8rDeNTI1CSWB1AxYQQ0PZ7CdkNzkWH7qW64zUgIl9kw+KQ2zwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709288; c=relaxed/simple;
	bh=06rBbLXG252REZd61p1JUm6Hn+gbVpJSTPnICAWegQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoMRy9eDQeDGqR6njbLT0hfStCO5QS9I6dZxnh8dt9DbkojdT/Ns43Q9hLdt8Ueei8sm7ucL9SMZlupH5jDSxi7zxUCNsn9GabB27n4SAynFwf/NCNui/9CIb6lhTW+1RoR5TsViPLrhevOZlgPIDTBWj8FY/7+454LaBLATfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyxftuq+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyxftuq+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so41382275e9.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709282; x=1759314082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4BJ+hlR/zqy89pgeVC5MjJEQY4M0mSZJbFQrGDF7+c=;
        b=Fyxftuq+68oMj0odhHcuEQ8Y4mdI0clxeFhGGdnAnLv3kwmCN+qeokoQwfQjTfk+Ry
         Fq2RfdMAJufTQ5ZEi70fOunwtg6ncoHYkzbVEK4J2D6tyC+r/FEiT6G74foRmUVjB6nT
         FM5UgXe7Uiri8VcjcW+lE6VSAlhloC5YvbiA9G7H/CJWiqsrRL3IOR3dQtoTdg3CR7GH
         jsCcBsG42q9eik/eT7s5Ey1ZRn0rSVjCy32ATMglQd9fhRHqa55TFJpDubbN/YOe58Gi
         EkuuoxgoR34Eh0j2dF3NvpWABa5XKTkggNx1anEEWLXrC9XjhsJ6L/BstSfzzMUmXIvK
         V6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709282; x=1759314082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BJ+hlR/zqy89pgeVC5MjJEQY4M0mSZJbFQrGDF7+c=;
        b=vLETPCrCSPWKTufNiKgk8brhbFEqMSAISGwbQg8LY7pD473s9ShoGhpH6LaDNpNnpd
         gH+dsTe7J9p6SbVTGnRWGRQQSH/O7Wjhp/6EL3UmR3AwzgP8M2YojO4z5wg15tIRUNIX
         Evem5S9RwFWy43gUZyNrNwLaRnRi/N+qvFC8v6nn+WzLSDLLFUQvXFpIwLgC1euLgD33
         Y592Fu4GCuHgXDi5bPMm8hnOk410ii/0aAmdV50nzqzs/k96opWd/oR3Wj3OAZcq2J2+
         VXdrlR9TsLYryXJWcbqdeee+cxYHhKDFndrQHf0WpX7xIZ0ZIzWq1f7LDBqtC7UFduq3
         Gqcg==
X-Forwarded-Encrypted: i=1; AJvYcCUbrFM2SKViDM2yYnM5RpmsRMyo2maVM+qi8sQCxhvd90kLmRhxT89fA25Lff4uynLXIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCXResxh1ATduz0lkIg2eWTN0ZbeH/v8Yd5KbudQfQ9Y82R89
	NlXNSLzg49pAkZlCQKs9yvaLZ4yJJRuskHuA1PtvmdNGRM3uBO/ndoXOwPYMsQ==
X-Gm-Gg: ASbGncskgtbWXsYsnsY0RO+YCQnAzZIsauxPS5U0ocCzywFzE6zgVug8dHjl2rRlnsq
	+O4O1zI2k0ymyHB04d0ezHHk45f6W3XssfPMqIzrlYgAS7gkEjNIQ0Hn/x5bNTm9qLmwRAS/W84
	HXgdVKG1C9PUYuE1ewJWcE4MM18HSvUr9hYQpZ8C+4Kk0G+xhgoGl7syVELlyOd9kI64x7POBVP
	QvITn6fsRTcNCJt+2thXYt2v8tbtRP89v6eDGnN1U3IwRfNaXi4JpqecYqTuzXDkBi0cpgU5oRJ
	OVkYKtvxBD8L9ULSazxSDpKKnm7+CuKwHtwzUKY+nW4EQz0Y/Uf5AzbDeBXt/LLlJaWjIS1pf8d
	6C2M6hae1NvH0yb5JOQEqcLCCx39aqfQC2H69nDAlb8YzOYx1htfo4q8AZtsQC4x4uMh9HEV5ag
	RScA==
X-Google-Smtp-Source: AGHT+IEcxxHYRd/QspX9BDVSgeTun2ThkMX+pMEkBV6cNjWozou33Y0jfH5IHUsHMsCjN+eCnaEcaw==
X-Received: by 2002:a05:600c:3b93:b0:467:f71c:147 with SMTP id 5b1f17b1804b1-46e1dae65f3mr60272795e9.36.1758709281229;
        Wed, 24 Sep 2025 03:21:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:5052:777:6f22:7bc0? ([2a0a:ef40:62a:101:5052:777:6f22:7bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f02f332c31sm21544628f8f.45.2025.09.24.03.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:21:20 -0700 (PDT)
Message-ID: <a17e00fa-bf4b-4b53-817b-297236178101@gmail.com>
Date: Wed, 24 Sep 2025 11:21:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] xdiff: change type of xdfile_t.changed from char
 to bool
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <975e845bfa80fe838433f7f64759a72f6d565aea.1758662670.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <975e845bfa80fe838433f7f64759a72f6d565aea.1758662670.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> The only values possible for 'changed' is 1 and 0, which exactly maps
> to a bool type. It might not look like this is the case because
> matches1 and matches2 (which use to be dis1, and dis2) were also char
> and were assigned numerical values within a few lines of 'changed'
> (what used to be rchg).
> 
> Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
> for changed[k] makes it clear to future readers that these are
> logically separate concepts.

Nicely explained - I think this change is a very good idea and 
separating it out like this makes it much clearer what's going on 
compared to V4.

Thanks

Phillip

> Best-viewed-with: --color-words
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c     | 12 ++++++------
>   xdiff/xhistogram.c |  8 ++++----
>   xdiff/xpatience.c  |  8 ++++----
>   xdiff/xprepare.c   | 12 ++++++------
>   xdiff/xtypes.h     |  2 +-
>   5 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5535452061..b902be9d0e 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
>   	 */
>   	if (off1 == lim1) {
>   		for (; off2 < lim2; off2++)
> -			xdf2->changed[xdf2->rindex[off2]] = 1;
> +			xdf2->changed[xdf2->rindex[off2]] = true;
>   	} else if (off2 == lim2) {
>   		for (; off1 < lim1; off1++)
> -			xdf1->changed[xdf1->rindex[off1]] = 1;
> +			xdf1->changed[xdf1->rindex[off1]] = true;
>   	} else {
>   		xdpsplit_t spl;
>   		spl.i1 = spl.i2 = 0;
> @@ -753,8 +753,8 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
>   {
>   	if (g->end < xdf->nrec &&
>   	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
> -		xdf->changed[g->start++] = 0;
> -		xdf->changed[g->end++] = 1;
> +		xdf->changed[g->start++] = false;
> +		xdf->changed[g->end++] = true;
>   
>   		while (xdf->changed[g->end])
>   			g->end++;
> @@ -774,8 +774,8 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
>   {
>   	if (g->start > 0 &&
>   	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
> -		xdf->changed[--g->start] = 1;
> -		xdf->changed[--g->end] = 0;
> +		xdf->changed[--g->start] = true;
> +		xdf->changed[--g->end] = false;
>   
>   		while (xdf->changed[g->start - 1])
>   			g->start--;
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index 15ca15f6b0..6dc450b1fe 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -318,11 +318,11 @@ redo:
>   
>   	if (!count1) {
>   		while(count2--)
> -			env->xdf2.changed[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = true;
>   		return 0;
>   	} else if (!count2) {
>   		while(count1--)
> -			env->xdf1.changed[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = true;
>   		return 0;
>   	}
>   
> @@ -335,9 +335,9 @@ redo:
>   	else {
>   		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
>   			while (count1--)
> -				env->xdf1.changed[line1++ - 1] = 1;
> +				env->xdf1.changed[line1++ - 1] = true;
>   			while (count2--)
> -				env->xdf2.changed[line2++ - 1] = 1;
> +				env->xdf2.changed[line2++ - 1] = true;
>   			result = 0;
>   		} else {
>   			result = histogram_diff(xpp, env,
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 14092ffb86..669b653580 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>   	/* trivial case: one side is empty */
>   	if (!count1) {
>   		while(count2--)
> -			env->xdf2.changed[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = true;
>   		return 0;
>   	} else if (!count2) {
>   		while(count1--)
> -			env->xdf1.changed[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = true;
>   		return 0;
>   	}
>   
> @@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>   	/* are there any matching lines at all? */
>   	if (!map.has_matches) {
>   		while(count1--)
> -			env->xdf1.changed[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = true;
>   		while(count2--)
> -			env->xdf2.changed[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = true;
>   		xdl_free(map.entries);
>   		return 0;
>   	}
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index e1d575f779..070d220f3b 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -273,7 +273,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   
>   	/*
>   	 * Create temporary arrays that will help us decide if
> -	 * changed[i] should remain 0 or become 1.
> +	 * changed[i] should remain false, or become true.
>   	 */
>   	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
>   		status = -1;
> @@ -305,16 +305,16 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   
>   	/*
>   	 * Use temporary arrays to decide if changed[i] should remain
> -	 * 0 or become 1.
> +	 * false, or become true.
>   	 */
>   	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
>   	     i <= xdf1->dend; i++, recs++) {
>   		if (matches1[i] == SOME ||
>   		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
>   			xdf1->rindex[nreff++] = i;
> -			/* changed[i] remains 0 */
> +			/* changed[i] remains false */
>   		} else
> -			xdf1->changed[i] = 1;
> +			xdf1->changed[i] = true;
>   	}
>   	xdf1->nreff = nreff;
>   
> @@ -323,9 +323,9 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   		if (matches2[i] == SOME ||
>   		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
>   			xdf2->rindex[nreff++] = i;
> -			/* changed[i] remains 0 */
> +			/* changed[i] remains false */
>   		} else
> -			xdf2->changed[i] = 1;
> +			xdf2->changed[i] = true;
>   	}
>   	xdf2->nreff = nreff;
>   
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index c4b5d2d8fa..f145abba3e 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -48,7 +48,7 @@ typedef struct s_xdfile {
>   	xrecord_t *recs;
>   	long nrec;
>   	long dstart, dend;
> -	char *changed;
> +	bool *changed;
>   	long *rindex;
>   	long nreff;
>   } xdfile_t;

