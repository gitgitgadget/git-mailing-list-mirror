Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DC2DE6FC
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709306; cv=none; b=Iyqs12gCpO1yHggLI/5ljCoGTSpL9fPyHRbb6eW7paE8Z35pWC9N8Wqgpbs70FF2Zn1IpdoPR4HkYB0Rh63TSHonIJGG9rbPeL/tKF3+05PK3kQPwXgVtolRz4tEi4hz3HKxGwba8ZILGxPb1vGybiNRBhKYEcUoTWQ4yhg4EIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709306; c=relaxed/simple;
	bh=AuNogeFbMw58++d/pMXFzDibeyw+pTj89UtNtrf9/ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O8ZayPsaxjDfx06OUCXnrhaIKrq9fYKaZPV+TapqTGvGu3qTgOgQELNcmq0OB2Jqi0lcBK6XdwmPzihLl1QGVgEZ3MXV32ukHbgdXlew59hyZm7Oq8Catv7W+0qKl8LuBZCbEHXZh2Ah3woq3Rngk+8kgcxJHLwlibM6dY+JxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0kVuCwH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0kVuCwH"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e317bc647so48685e9.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709299; x=1759314099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QSAXbfyeIR9bHRbbNiuMqOnFJwk3F81ILrwsy7aXpdQ=;
        b=T0kVuCwH4wZPoNGfXTqkNSglSP96NnbUft8veMCgnIZTeKU8thgY40nz9zxpUNrAyg
         hJTQ9nfiUQO2jxg/gK8b8cvmNMBtWXUFUh6QrgEtuxXXIbq1b5EQtSkUQU9Ry/cwa+9r
         OlxM4V4b0DKN2H4x5mrqeU9ZTAG/Z/odYIAg8RLCdT/V5Q8v3C15OF9g/qFAdWt2j2az
         t9w6h41Dhr5hrvx44XKldq0i2LGwY789omIRrMSc8dQU7v7N2uWpWqgdxxNJ65ztmauz
         t0bWwguPTMKbmYQdpAFg9oK9hy7RYhCfG7nKx2JibDcQVMYFDSDCKtIFqJQk51ceuTL5
         7GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709299; x=1759314099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSAXbfyeIR9bHRbbNiuMqOnFJwk3F81ILrwsy7aXpdQ=;
        b=R7vgI+c5z4X9SWeGPKYAyn8RGhBisT1jnv7p8/s9R+m3F/iJpQtolE+99D05mBhCra
         HbhAGjbW2oGBSRwi60r0Ew8efSL8vEqVWJfOZsX0TIkwtuhuRojvyTEmM9IUtD2R/wmo
         hdblYgBMtChWCVRB9JofEK0YXru3yO3uqfsnq9wwSsmCAKPAOwTqM1nmOjHYp2dYNsQi
         3jb7e+ayKa56gghqy2EV5RPFFdNYRb1bRWB4XaM36W2p1gR0inF4S2Tn3q0aot4iTVsM
         qqvgdU2+TTgIwtBT7ce5f8qwBq5nitz+wAMbX+ix/JlhM+QAfvSY7UDYGibUClHjiXLF
         nJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7kly1MFer91ry9FM/l18CWJY8X5w8xE9rnewb/+CK2cmtNmIZDhGT7ZCfaC9ujlEeR7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2uaAcuR3Vg77aaZtNH60je1DdbDOXh8Qg4OmzCtmiRhVBf6T
	paGT+KgeMaAYWYE8/66FyZe5t8PVwmG8CM4xyaPfcRgQT0yDSAEvg7ij
X-Gm-Gg: ASbGncu1TV6Z6tIWIQK4OvrOJ+Pecp+kaJbMVj9b7HQ78EvmBfqdrSZ9TbE26PxlzqP
	euG6cg64Tzr4v9lNUgBhr+EtpJk72HyWRAQGi3e2XKoJcNz2N0vOoZrueYifc6oQzwOwmvM6AyN
	HMM69Iz0oJ4a/iNmhSG+HGvk/Hd4258nJKNNFLaK1161XUxfdegVdtlfW4EvNjU1pOInmd3+Hdd
	0/iPg+/IDl0YMul+Y1BzoFsx3l+1I4hJAUhP4+BHX+y+H3kIsOHUTTfjGFWRdcOcX5wdnnqf7Fg
	8T6nL6shtFGn0QbFNcXO0OOEPTTZ8vUcTpusPENUOzINgQWzt5xg4JEK0Z2rAgcKSqqZw7IaVmk
	xKT2BvF43IFXp5zCZbqSVt3JhUsfrkuCOFL2bGRQznvQLB3Gvlz8OX+LPx/j8LaQNonfaunMY00
	2zQ/V5i4LLzcU0
X-Google-Smtp-Source: AGHT+IE8UE42u9b4fIKnoOagpEuaFv0Z+8mLYeaVUrH5wQxwx+4bWtUh3zXU17wzIDvN+U9Di5GsQg==
X-Received: by 2002:a05:600c:3586:b0:45d:f7cb:8954 with SMTP id 5b1f17b1804b1-46e1d97f526mr72049925e9.9.1758709298419;
        Wed, 24 Sep 2025 03:21:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:5052:777:6f22:7bc0? ([2a0a:ef40:62a:101:5052:777:6f22:7bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc730dsm27720573f8f.41.2025.09.24.03.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:21:37 -0700 (PDT)
Message-ID: <82ee55d6-f8ae-4a88-84fc-47c6ce18139a@gmail.com>
Date: Wed, 24 Sep 2025 11:22:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/13] xdiff: rename rchg -> changed in xdfile_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <570ab9f8983d7507cd8f1937176f3268255da416.1758662670.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <570ab9f8983d7507cd8f1937176f3268255da416.1758662670.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>

I agree "changed" is a better name but the commit message should explain 
what "rchg" is used for so that someone who is not familiar with the 
code can understand why the change in name is desirable.

Thanks

Phillip
> Best-viewed-with: --color-words
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c     | 28 ++++++++++++++--------------
>   xdiff/xhistogram.c |  8 ++++----
>   xdiff/xpatience.c  |  8 ++++----
>   xdiff/xprepare.c   | 12 ++++++------
>   xdiff/xtypes.h     |  2 +-
>   xdiff/xutils.c     |  4 ++--
>   6 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 83c4cff6f7..5535452061 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -278,10 +278,10 @@ int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
>   	 */
>   	if (off1 == lim1) {
>   		for (; off2 < lim2; off2++)
> -			xdf2->rchg[xdf2->rindex[off2]] = 1;
> +			xdf2->changed[xdf2->rindex[off2]] = 1;
>   	} else if (off2 == lim2) {
>   		for (; off1 < lim1; off1++)
> -			xdf1->rchg[xdf1->rindex[off1]] = 1;
> +			xdf1->changed[xdf1->rindex[off1]] = 1;
>   	} else {
>   		xdpsplit_t spl;
>   		spl.i1 = spl.i2 = 0;
> @@ -708,7 +708,7 @@ struct xdlgroup {
>   static void group_init(xdfile_t *xdf, struct xdlgroup *g)
>   {
>   	g->start = g->end = 0;
> -	while (xdf->rchg[g->end])
> +	while (xdf->changed[g->end])
>   		g->end++;
>   }
>   
> @@ -722,7 +722,7 @@ static inline int group_next(xdfile_t *xdf, struct xdlgroup *g)
>   		return -1;
>   
>   	g->start = g->end + 1;
> -	for (g->end = g->start; xdf->rchg[g->end]; g->end++)
> +	for (g->end = g->start; xdf->changed[g->end]; g->end++)
>   		;
>   
>   	return 0;
> @@ -738,7 +738,7 @@ static inline int group_previous(xdfile_t *xdf, struct xdlgroup *g)
>   		return -1;
>   
>   	g->end = g->start - 1;
> -	for (g->start = g->end; xdf->rchg[g->start - 1]; g->start--)
> +	for (g->start = g->end; xdf->changed[g->start - 1]; g->start--)
>   		;
>   
>   	return 0;
> @@ -753,10 +753,10 @@ static int group_slide_down(xdfile_t *xdf, struct xdlgroup *g)
>   {
>   	if (g->end < xdf->nrec &&
>   	    recs_match(&xdf->recs[g->start], &xdf->recs[g->end])) {
> -		xdf->rchg[g->start++] = 0;
> -		xdf->rchg[g->end++] = 1;
> +		xdf->changed[g->start++] = 0;
> +		xdf->changed[g->end++] = 1;
>   
> -		while (xdf->rchg[g->end])
> +		while (xdf->changed[g->end])
>   			g->end++;
>   
>   		return 0;
> @@ -774,10 +774,10 @@ static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
>   {
>   	if (g->start > 0 &&
>   	    recs_match(&xdf->recs[g->start - 1], &xdf->recs[g->end - 1])) {
> -		xdf->rchg[--g->start] = 1;
> -		xdf->rchg[--g->end] = 0;
> +		xdf->changed[--g->start] = 1;
> +		xdf->changed[--g->end] = 0;
>   
> -		while (xdf->rchg[g->start - 1])
> +		while (xdf->changed[g->start - 1])
>   			g->start--;
>   
>   		return 0;
> @@ -938,9 +938,9 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>   	 * Trivial. Collects "groups" of changes and creates an edit script.
>   	 */
>   	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
> -		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
> -			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
> -			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
> +		if (xe->xdf1.changed[i1 - 1] || xe->xdf2.changed[i2 - 1]) {
> +			for (l1 = i1; xe->xdf1.changed[i1 - 1]; i1--);
> +			for (l2 = i2; xe->xdf2.changed[i2 - 1]; i2--);
>   
>   			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>   				xdl_free_script(cscr);
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index 4d857e8ae2..15ca15f6b0 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -318,11 +318,11 @@ redo:
>   
>   	if (!count1) {
>   		while(count2--)
> -			env->xdf2.rchg[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = 1;
>   		return 0;
>   	} else if (!count2) {
>   		while(count1--)
> -			env->xdf1.rchg[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = 1;
>   		return 0;
>   	}
>   
> @@ -335,9 +335,9 @@ redo:
>   	else {
>   		if (lcs.begin1 == 0 && lcs.begin2 == 0) {
>   			while (count1--)
> -				env->xdf1.rchg[line1++ - 1] = 1;
> +				env->xdf1.changed[line1++ - 1] = 1;
>   			while (count2--)
> -				env->xdf2.rchg[line2++ - 1] = 1;
> +				env->xdf2.changed[line2++ - 1] = 1;
>   			result = 0;
>   		} else {
>   			result = histogram_diff(xpp, env,
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index bf69a58527..14092ffb86 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -331,11 +331,11 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>   	/* trivial case: one side is empty */
>   	if (!count1) {
>   		while(count2--)
> -			env->xdf2.rchg[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = 1;
>   		return 0;
>   	} else if (!count2) {
>   		while(count1--)
> -			env->xdf1.rchg[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = 1;
>   		return 0;
>   	}
>   
> @@ -347,9 +347,9 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>   	/* are there any matching lines at all? */
>   	if (!map.has_matches) {
>   		while(count1--)
> -			env->xdf1.rchg[line1++ - 1] = 1;
> +			env->xdf1.changed[line1++ - 1] = 1;
>   		while(count2--)
> -			env->xdf2.rchg[line2++ - 1] = 1;
> +			env->xdf2.changed[line2++ - 1] = 1;
>   		xdl_free(map.entries);
>   		return 0;
>   	}
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 27c5a4d636..b9b19c36de 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -126,7 +126,7 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   static void xdl_free_ctx(xdfile_t *xdf)
>   {
>   	xdl_free(xdf->rindex);
> -	xdl_free(xdf->rchg - 1);
> +	xdl_free(xdf->changed - 1);
>   	xdl_free(xdf->recs);
>   }
>   
> @@ -139,7 +139,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   	xrecord_t *crec;
>   
>   	xdf->rindex = NULL;
> -	xdf->rchg = NULL;
> +	xdf->changed = NULL;
>   	xdf->recs = NULL;
>   
>   	if (!XDL_ALLOC_ARRAY(xdf->recs, narec))
> @@ -161,7 +161,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   		}
>   	}
>   
> -	if (!XDL_CALLOC_ARRAY(xdf->rchg, xdf->nrec + 2))
> +	if (!XDL_CALLOC_ARRAY(xdf->changed, xdf->nrec + 2))
>   		goto abort;
>   
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
> @@ -170,7 +170,7 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   			goto abort;
>   	}
>   
> -	xdf->rchg += 1;
> +	xdf->changed += 1;
>   	xdf->nreff = 0;
>   	xdf->dstart = 0;
>   	xdf->dend = xdf->nrec - 1;
> @@ -287,7 +287,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
>   			xdf1->rindex[nreff++] = i;
>   		} else
> -			xdf1->rchg[i] = 1;
> +			xdf1->changed[i] = 1;
>   	}
>   	xdf1->nreff = nreff;
>   
> @@ -297,7 +297,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
>   			xdf2->rindex[nreff++] = i;
>   		} else
> -			xdf2->rchg[i] = 1;
> +			xdf2->changed[i] = 1;
>   	}
>   	xdf2->nreff = nreff;
>   
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 3d26cbf1ec..c4b5d2d8fa 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -48,7 +48,7 @@ typedef struct s_xdfile {
>   	xrecord_t *recs;
>   	long nrec;
>   	long dstart, dend;
> -	char *rchg;
> +	char *changed;
>   	long *rindex;
>   	long nreff;
>   } xdfile_t;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 332982b509..ed65c222e6 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -425,8 +425,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>   		return -1;
>   
> -	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg, count1);
> -	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
> +	memcpy(diff_env->xdf1.changed + line1 - 1, env.xdf1.changed, count1);
> +	memcpy(diff_env->xdf2.changed + line2 - 1, env.xdf2.changed, count2);
>   
>   	xdl_free_env(&env);
>   

