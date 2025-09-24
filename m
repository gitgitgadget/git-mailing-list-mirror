Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD392DECA5
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709297; cv=none; b=HswdHx/+E1YC4HAEb7Cc5Lo29U2HuWKuf+Cps9ycwBjFgdzXdKNPigonCJ++TCFOl7T+sSemN2B0DbFauoQs3tagKfkxuiO+7GjS7NC0ib6+7hZvpALWraebVR7tZ0mIjATEZDsUcavZp6A/KMfHMYoF/sGjJ14MreKt+GXmH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709297; c=relaxed/simple;
	bh=xKWC9vamklMK1ixUNfOwFxJ2pEv5MeM7MH7MkoDY6BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZ0OxCulbow8pmS586n3p8FE0oZXNrD7VgMsH3SbhatlhM6QoZDUOPn+hfBGt3aa6SUVbJlMjmFs8feVy5vM7IFWTAkFeQ7BQEjHz6hfrbzcEKG8lsRqFc+BjcfSRtRInTS2kwwlDuQFaGscMEeUqvyw3qElZzbSlMj4246iWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asFqnLIH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asFqnLIH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45ed646b656so57531635e9.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709290; x=1759314090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYpWE8Zslfsbxg3jlH5yVwIeVOGkP0dkvJNFymPo++E=;
        b=asFqnLIHd+55mQU5yN0HCFR23noPfgUcck29/0f9DfXbtHsZJviJ+rM3h9qGg5wosy
         sGdSCrXPJQjMdRr3OhTVPtej23OCN3p1NaQgSgKVE8LC9PGzGim4juxkglF+3jyoTGfh
         P2EY9BODTjkf7ktC42a5l9trglyKnmCOELDwt4L6oFf7uGvLpfsW4rJwRTN2gC34IXHV
         XP+q7gPV5NWK9CoV521IkBTatTGL59T/fo3HStSNkC6SySf7z3U0FD02hxesVRmboviR
         g3knR4Kb+1l8LTLrKOBO5qo/6j4iN4BKnK3Dzb8XduiLlNEcf0oqwqNfhFrvKwfNqYzS
         bn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709290; x=1759314090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MYpWE8Zslfsbxg3jlH5yVwIeVOGkP0dkvJNFymPo++E=;
        b=ZnA/FYJS+udQf3pGL42/EsEakf1SsMJK1NxeNLxLJOABThkFpSWpQIitWEwPO24HK9
         Z0UpeySgFLPCdxT2lbIid+nF7Q7zpLXjgMAAC0Oiduz4bLoP6RWnKA8/JBRxhFgT82KT
         vLk/JfAElM3TixA3DPPqUEP26AsFs3txtBrNHNUrJoqjXnft9NAUH/dc2EUdzpQa8b+2
         nKss7RXMCVF3rI/OtkaY6yzgXb5A7Dotjh7I/LAGlQQNNIKKdewJz5KX0pO7eAuRj6D+
         R3K2cZJozhxOLQEiiRk3jQigbhZHPCvc718rAGLFBv4e62O+B/a/E1GXXW9jKQwrJkPd
         olPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrOo/sEevsQSjsg4GB3NB2A4qi+FSgemMEGd3D3xM2Q/oZ00DtY614p09hrsextOriacY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs83LS1MwagisEmtqGkh5qdruiMSWz1pwM95OBZwTl/Svq/52Y
	0k1uTpMRaiH6/5vFE7ih86bUeFjacnz+pNykTFAui+AROoJ7QkKM47+d
X-Gm-Gg: ASbGnct8mE2aH2gA5kmwqmuFD8AoFrOsa++4qrpAupbmsP0TV2OqeLsD6yQZEwF4W6n
	2/PJ2LnydokwiTCwRyG7J21JWCywmfhIvp1eB1vJtTK4jnyyOlB54XO83p/nJSriAdoG8pCi27p
	lFzllJWdvcgZC27eeFDLfcKjDBkP3Z8gnpK9JJMduO2aofC1Nb/MyL2mhz5nyjglK68IbLfM0PP
	YQ9fEmNS+LxPt7ABPS7d6Iv2pLFyUGTicApiFNiNk03LjD8Ii+9T2d7ONUg3ejVOgH1BPaAokTe
	L0W9kxTJoAFAyOMmLsfzRU1AnbdFBJzS+Hj04dybpbE7+6eS4WzBtmkwJq99uZ7vn9uq+j5t+4s
	0/P8humWVXPf/ECSxHoC3yb894JfTL8MHLbkJ7+bmwy/LO51Zf4wh48RxNl82lhru8JXBZpKUhO
	sfkeYX/hakbY3C
X-Google-Smtp-Source: AGHT+IHM6/6XHRF1cFuxnDfL/1QhahHv+TLa1CbBgLXe1YNAMaEP/7ZrnpqNUk5ScLk48SnYw7H5uw==
X-Received: by 2002:a05:600c:c8a:b0:46e:978:e231 with SMTP id 5b1f17b1804b1-46e1e0aec9bmr68515675e9.17.1758709289275;
        Wed, 24 Sep 2025 03:21:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:5052:777:6f22:7bc0? ([2a0a:ef40:62a:101:5052:777:6f22:7bc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2aaca1eesm25784185e9.14.2025.09.24.03.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:21:28 -0700 (PDT)
Message-ID: <311f7dbe-b970-4a5b-9d53-05f019cc54cd@gmail.com>
Date: Wed, 24 Sep 2025 11:21:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] xdiff: use enum macros NONE(0), SOME(1),
 TOO_MANY(2) in xprepare.c
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <08a0fceb72b2bd0a2803d24b9874b7f9bd03703a.1758662670.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Rename dis1, dis2 to matches1, matches2.
> 
> Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
> matches1 and matches2. These states will influence whether changed[i]
> is set to 1 or kept as 0.

This message also says what is being changed rather than why it is being 
changed. I think the rename here is a good idea but I'm not sure what 
"rdis[01]" and "rpdis[01]" are used for and whether they should be 
renamed if we're renaming "dis[01]"

>   	/*
> -	 * Limits the window the is examined during the similar-lines
> -	 * scan. The loops below stops when dis[i - r] == 1 (line that
> +	 * Limits the window that is examined during the similar-lines
> +	 * scan. The loops below stops when matches[i - r] == SOME (line that

Thanks for updating the comments. Not reflowing the lines makes the diff 
easier to read but leaves the comments in a rather strange state with 
random long lines.

>   	 * has no match), but there are corner cases where the loop
>   	 * proceed all the way to the extremities by causing huge
>   	 * performance penalties in case of big files.
> @@ -207,40 +210,44 @@ static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>   
>   	/*
>   	 * Scans the lines before 'i' to find a run of lines that either
> -	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
> -	 * Note that we always call this function with dis[i] > 1, so the
> +	 * have no match (matches[j] == NONE) or have multiple matches (matches[j] == TOO_MANY).
> +	 * Note that we always call this function with matches[i] == TOO_MANY, so the

especially here

> -		if (!dis[i + r])
> +		if (matches[i + r] == NONE)
>   			rdis1++;
> -		else if (dis[i + r] == 2)
> +		else if (matches[i + r] == TOO_MANY)
>   			rpdis1++;
> -		else
> +		else if (matches[i + r] == SOME)
>   			break;
> +		else
> +			BUG("Illegal value for matches[i + r]");

Nice addition

>   static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
>   	long i, nm, nreff, mlim;
>   	xrecord_t *recs;
>   	xdlclass_t *rcrec;
> -	char *dis, *dis1, *dis2;
> -	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> +	uint8_t *matches1, *matches2;

Let's initialize these where they're declared rather than later on

> +	int status = 0;
I think we typically we call this "ret" or "res" in the rest of the code 
base.

> +	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);

Nice use of bool, strictly speaking I don't think we need the !! if 
we're changing the type from int. I think Junio recently suggested that 
we might start using (bool) instead of !! for cases like this.

Everything below this looks good, though some of the lines are getting 
quite long with the renamed variables and symbolic values so we might 
want to break them.

Thanks

Phillip


> -	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
> -		return -1;
> -	dis1 = dis;
> -	dis2 = dis1 + xdf1->nrec + 1;
> +	matches1 = NULL;
> +	matches2 = NULL;
> +
> +	/*
> +	 * Create temporary arrays that will help us decide if
> +	 * changed[i] should remain 0 or become 1.
> +	 */
> +	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
> +		status = -1;
> +		goto cleanup;
> +	}
> +	if (!XDL_CALLOC_ARRAY(matches2, xdf2->nrec + 1)) {
> +		status = -1;
> +		goto cleanup;
> +	}
>   
> +	/*
> +	 * Initialize temporary arrays with NONE, SOME, or TOO_MANY.
> +	 */
>   	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->ha];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
> +		matches1[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
>   	}
>   
>   	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> @@ -278,14 +300,19 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->ha];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
> +		matches2[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
>   	}
>   
> +	/*
> +	 * Use temporary arrays to decide if changed[i] should remain
> +	 * 0 or become 1.
> +	 */
>   	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
>   	     i <= xdf1->dend; i++, recs++) {
> -		if (dis1[i] == 1 ||
> -		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
> +		if (matches1[i] == SOME ||
> +		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
>   			xdf1->rindex[nreff++] = i;
> +			/* changed[i] remains 0 */
>   		} else
>   			xdf1->changed[i] = 1;
>   	}
> @@ -293,17 +320,20 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   
>   	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
>   	     i <= xdf2->dend; i++, recs++) {
> -		if (dis2[i] == 1 ||
> -		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
> +		if (matches2[i] == SOME ||
> +		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
>   			xdf2->rindex[nreff++] = i;
> +			/* changed[i] remains 0 */
>   		} else
>   			xdf2->changed[i] = 1;
>   	}
>   	xdf2->nreff = nreff;
>   
> -	xdl_free(dis);
> +cleanup:
> +	xdl_free(matches1);
> +	xdl_free(matches2);
>   
> -	return 0;
> +	return status;
>   }
>   
>   
