Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF92D481F
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459978; cv=none; b=E01u2QSiV2PpfvcQR4fa1GoY5zdj/M3stzR7tiwK3fyU83MBl7s7fvEqeVQKbLPVyFMB1J+Yv9TLlSvl6gfAjObNZGCuJsXIx184freHErvqMyDzlDXf4RR451Pe9sYfwbpOkU7vFfdAdXnQd4E4n2V6hHfjuvi9LWDSx/64azI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459978; c=relaxed/simple;
	bh=LzpQyqmm6VbmrGGkZEO4zJ/6YAjUXN3CTj4Nj6ckbv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezXoTWCPCA+ivuPd7y14X4AK8JE5WK43KN44wD2XC4dtZ/K9sz+Dk6lU5nyH/oicrg9ez6kccbI5Vv2+KmWuhoaLMtITOdgTiphl8HHR9nyczmYUGcrPYkCN8EWK2M/5Gg3GoYfRDVNUs2LSLTzSOMRWGzLbXt+kRkpPLl48R3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dazQUg31; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dazQUg31"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1466364f8f.3
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758459974; x=1759064774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9pW+NT7VmH18N+IUWBdvR2LtqEy7++ozj7UH8IKA9sk=;
        b=dazQUg31YMLOWil5y+QyXddOHXCriFTxp4E+VCoEBC4L+qRf3HiS0/NZVjmJ5QFDz/
         NiWUpB7F2xfPfRccFY5Uei7B+BJUYjcWmNLvVoQ9y2dSntIlINHzToft128SBHpR2+qd
         TgAUaNGV1N64DnfNFMvL/5h4lAxg2hx2laYoC5gBDyxQFNOdLQ8H89n4/4VrSYwDQpEk
         k4rkMQjNdr1GZsVvyvmTGeaXH0+IEuSpaN3PSQtqxUUfCS+vp2vh0mAcfwbiE997S0AM
         14uYiawPMGrZNjf0z8WPpyFoenv1G08kedM/U5D7pn4jNQ8luC4HeH4Za4StGr4aSqs7
         BXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758459974; x=1759064774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pW+NT7VmH18N+IUWBdvR2LtqEy7++ozj7UH8IKA9sk=;
        b=F2GAnGDFvr4OqnAxqF7of04TqJFbepNFYKYqYMOVPv+XK9L5QfWKTdh8ny+1z94zzq
         LHdD3mfMo0tpKdV2IKrUx19JLojm5ZSxDVc77SYWnAfoshhRTzOkIqTXQJQSs4h12pwZ
         ZnRu66AtrCtsUsTyuMIyftZz+y70TZgSjeKxiAP/IzA8XNDPZG9YVbd861Uaw5PTmVoy
         8XpvHmmH8ari7N0g7SgpBbrqdv+5azAPIIYuoJBiYZBFAJ5ztT1Dh2g++0xkerdvKiXz
         2zj9y97MrcxXNE8JrLIkBb/3fIRSezf0IVX8JNWozyjDKUjdAlB+3bRWk62+eHL8ApTN
         SUag==
X-Forwarded-Encrypted: i=1; AJvYcCUfcG77ZFo2YcyvcjblYDipwT4YoNUWdMbDWfNR/Gd5V+b/kmLZbDl23K7nCAk4loN8BmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7qXrAl0Vi5wnl5MfEYVEYm35+EqhqEsjrgxD0YgZGSTdbL3Q
	fMqDiyQcI1hqUJO2P/wGlY+EljwCIbmzkew1SrlAEOI2stEGfleQcAN9
X-Gm-Gg: ASbGnctY4ty7UEdQlmvTeOMFdiGaDC0n6ey7NuLzWWyXQkwNYYiIRskILEc3Gl+v0Fq
	xix1G0Q+t0c2cv4RIZYwWIlgaI1SVuukly6ndAqcF2OkSuDUAkgDP6Br7VC/bzd8rtXz7693mKj
	MJL41O++6kLGvwA35eX3thhCwLP1vskK7ziEdiOPmmyuXqP/Q9/cZC+tQR0MCsE3YaW3lJjAA86
	EehQIB5JSFluWi8133ltVTFiX9Syrez0TgmVw394Ya3pY8WcbCp3k0ujPj3/YCtmijTJKI1cV0z
	wnBvOraOrSgqs93eQsfOWaB724MOH7F1UUvcW7fiyyCgzXlPwhv0yvskPTlPhTcukMMDfUZbPT7
	jSKThiRkyorflHbYMINVE4wTnaTu5bvn7mPFtOTX2CCqv0R/XP0JsaTM1mvxBYPRbe2e0Ng7POF
	VAfJxy
X-Google-Smtp-Source: AGHT+IFSg2I9mHjMnUmfh5JIp6fGft+dcTi1M5AMJnRQ8XiZH87a86ErF/oTHQ83QYsnc6PHhDWH4A==
X-Received: by 2002:a05:6000:2307:b0:3ee:15b4:174c with SMTP id ffacd0b85a97d-3ee7bad0ffemr8473636f8f.3.1758459974126;
        Sun, 21 Sep 2025 06:06:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:600d:1d53:febb:27a5? ([2a0a:ef40:62a:101:600d:1d53:febb:27a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf3bfcsm16100077f8f.58.2025.09.21.06.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 06:06:13 -0700 (PDT)
Message-ID: <7979d8f5-1e97-4429-891a-678adb3ba54f@gmail.com>
Date: Sun, 21 Sep 2025 14:06:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] xdiff: delete struct diffdata_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <807ce3e5aae0253dd58c7a4d0bd04ca341b070c8.1758294992.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <807ce3e5aae0253dd58c7a4d0bd04ca341b070c8.1758294992.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 19/09/2025 16:16, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Every field in this struct is an alias for a certain field in xdfile_t.
> 
> diffdata_t.nrec   -> xdfile_t.nreff
> diffdata_t.ha     -> xdfile_t.ha
> diffdata_t.rindex -> xdfile_t.rindex
> diffdata_t.rchg   -> xdfile_t.rchg

That explains some of the changes here (so long as one assumes the 
aliasing is a bad thing) but it does not explain why it is a good idea 
to remove the local variables rchg[12] and rindex[12] and instead 
dereference xdf[12] inside the loops

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c | 32 ++++++++------------------------
>   xdiff/xdiffi.h | 11 ++---------
>   2 files changed, 10 insertions(+), 33 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5a96e36dfb..bbf0161f84 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -257,10 +257,10 @@ static long xdl_split(unsigned long const *ha1, long off1, long lim1,
>    * sub-boxes by calling the box splitting function. Note that the real job
>    * (marking changed lines) is done in the two boundary reaching checks.
>    */
> -int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
> -		 diffdata_t *dd2, long off2, long lim2,
> +int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
> +		 xdfile_t *xdf2, long off2, long lim2,
>   		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv) {
> -	unsigned long const *ha1 = dd1->ha, *ha2 = dd2->ha;
> +	unsigned long const *ha1 = xdf1->ha, *ha2 = xdf2->ha;
>   
>   	/*
>   	 * Shrink the box by walking through each diagonal snake (SW and NE).
> @@ -273,17 +273,11 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
>   	 * be obviously changed.
>   	 */
>   	if (off1 == lim1) {
> -		char *rchg2 = dd2->rchg;
> -		long *rindex2 = dd2->rindex;
> -
>   		for (; off2 < lim2; off2++)
> -			rchg2[rindex2[off2]] = 1;
> +			xdf2->rchg[xdf2->rindex[off2]] = 1;
>   	} else if (off2 == lim2) {
> -		char *rchg1 = dd1->rchg;
> -		long *rindex1 = dd1->rindex;
> -
>   		for (; off1 < lim1; off1++)
> -			rchg1[rindex1[off1]] = 1;
> +			xdf1->rchg[xdf1->rindex[off1]] = 1;
>   	} else {
>   		xdpsplit_t spl;
>   		spl.i1 = spl.i2 = 0;
> @@ -300,9 +294,9 @@ int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
>   		/*
>   		 * ... et Impera.
>   		 */
> -		if (xdl_recs_cmp(dd1, off1, spl.i1, dd2, off2, spl.i2,
> +		if (xdl_recs_cmp(xdf1, off1, spl.i1, xdf2, off2, spl.i2,
>   				 kvdf, kvdb, spl.min_lo, xenv) < 0 ||
> -		    xdl_recs_cmp(dd1, spl.i1, lim1, dd2, spl.i2, lim2,
> +		    xdl_recs_cmp(xdf1, spl.i1, lim1, xdf2, spl.i2, lim2,
>   				 kvdf, kvdb, spl.min_hi, xenv) < 0) {
>   
>   			return -1;
> @@ -318,7 +312,6 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	long ndiags;
>   	long *kvd, *kvdf, *kvdb;
>   	xdalgoenv_t xenv;
> -	diffdata_t dd1, dd2;
>   	int res;
>   
>   	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
> @@ -357,16 +350,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   	xenv.snake_cnt = XDL_SNAKE_CNT;
>   	xenv.heur_min = XDL_HEUR_MIN_COST;
>   
> -	dd1.nrec = xe->xdf1.nreff;
> -	dd1.ha = xe->xdf1.ha;
> -	dd1.rchg = xe->xdf1.rchg;
> -	dd1.rindex = xe->xdf1.rindex;
> -	dd2.nrec = xe->xdf2.nreff;
> -	dd2.ha = xe->xdf2.ha;
> -	dd2.rchg = xe->xdf2.rchg;
> -	dd2.rindex = xe->xdf2.rindex;
> -
> -	res = xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
> +	res = xdl_recs_cmp(&xe->xdf1, 0, xe->xdf1.nreff, &xe->xdf2, 0, xe->xdf2.nreff,
>   			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0,
>   			   &xenv);
>   	xdl_free(kvd);
> diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
> index 126c9d8ff4..49e52c67f9 100644
> --- a/xdiff/xdiffi.h
> +++ b/xdiff/xdiffi.h
> @@ -24,13 +24,6 @@
>   #define XDIFFI_H
>   
>   
> -typedef struct s_diffdata {
> -	long nrec;
> -	unsigned long const *ha;
> -	long *rindex;
> -	char *rchg;
> -} diffdata_t;
> -
>   typedef struct s_xdalgoenv {
>   	long mxcost;
>   	long snake_cnt;
> @@ -46,8 +39,8 @@ typedef struct s_xdchange {
>   
>   
>   
> -int xdl_recs_cmp(diffdata_t *dd1, long off1, long lim1,
> -		 diffdata_t *dd2, long off2, long lim2,
> +int xdl_recs_cmp(xdfile_t *xdf1, long off1, long lim1,
> +		 xdfile_t *xdf2, long off2, long lim2,
>   		 long *kvdf, long *kvdb, int need_min, xdalgoenv_t *xenv);
>   int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		xdfenv_t *xe);


