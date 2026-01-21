Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298862DF6F8
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007678; cv=none; b=i+i4/zwRaWg84eM0WCkzwp4I36BXoyT6hvmzgJCPsms27I4iskI0SF6tmRMf2m3sP926wYRuBVIhT/CThA7rCUih6B9V+EP1oLdEF4PLHZmbW+oXmfleudTNvvt3J2IoLwbZ3rFo8Otv+AqkvWzW9T7sYlbhcWDYwKCCYLK8OeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007678; c=relaxed/simple;
	bh=Hxuu1SL+DdqfEbv99oIVUWuPNeJlJe8rhw0O55Lz9I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS27KNTbzei1WwMwP3rVtdc+RacYwm4nyTVRt75ELeSLFhXpQNupQ8IomZBMM7qrPQRFP8IoDYgGLqjdSGafpdTfeFuZKUx8j6ftOouYsL6zncZZXyjAk8tTSpK2yHSiXi5GhPB/NtaQx5NYA/w8AcwcrO5u7p25ZjQP9g8Hdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjAJ2PNx; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjAJ2PNx"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso19486395e9.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769007674; x=1769612474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qWPDzE6/YDr8kM8npUgZDY9MYG6iYW9xKHYMoJ9iY3M=;
        b=AjAJ2PNxlJFDNmePexw61vliNfT49nOmu4390zE6aVDxkRMvPdnA5rd0G6x4dkUx84
         siyBzXHuMMcEepU5lRkMnO5Yn+DATpJqx+Nb9bbDQStf4Y9qF2g+nyn2W27prPe9sAfC
         E6PP++LPJGtWb+OgBXNPuvF9lSqXVRytkbYYE4ilpEOTspy8qouXal/xvfNZOXs1EHR7
         eKmfBBIaMAdrkin1bh/E1iAeAkvN7Ty1zqkNSU1lenwSTz5CeAXvfzjYrInHapXoSgOl
         /JsOaxHQG7Q4CYqUS9lL1xcyCqKprIHaA9E4WwXk2V5Ni/xOAT5qlhuZgcT13NdyOpqW
         FYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007674; x=1769612474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWPDzE6/YDr8kM8npUgZDY9MYG6iYW9xKHYMoJ9iY3M=;
        b=auDNbdzbujZ6CPGjl481m8U3dzz4iM1S1GE+V1M7ujzNYNubrHIRzlCayxZUb8A2xH
         QG+rRpTl9s9JgJMmtMBZs1kyCTCV4XERmvAo6o50FmCmCs/pZqEvM9HeVYtNjaEk5PKi
         4DMg/WlhaD6aPVWl9FRKVA6ylKkJ0C2KiBH0AfZpJMwqFx5IuH06pmrVptFDj+TtXnAe
         UAoOkddlP8B8g0ZrxtOXhBP/ZLQkfbYxQZtY89A6YeinQlZMX4Kjybkc40+kPoChkVR5
         SWojJjf1dcA99A1n8TzeW4ScGNHP5jwi6x4hCShgkO9B8b9TZDqnVmIRQr/4qfJG0uxV
         JxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUj4G9NbKbC2raRNUq5UYaOZLgRiqrlLW8DDyiXi8+vUktJ+8c8YCYuB2mKoEiqjixOoYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCHaRr3LVfLaVTGf4bTD3DCtbZfnRF2VxH9JEAh7LchvSrFptN
	NzZnSp3xaqXr8l+XhxiRy0WY1fOeEeh67OAtNgrNbIrgsKSAFVL8laG52bcT7Uto
X-Gm-Gg: AZuq6aLZJCEUxQC0sGu2XEoxLvTJp9+2cFVgl/3L+n0PUAaQ2sj0cMfX/g+rIcVEWkB
	Id0cZ+WE+JPrBNiHCkX8pAdR2+Y6/bixKcS3ydAGPv4DYqHjAvm6yj1JWSQaoATMkF+foCBRJOq
	SdbuPrAVgphWnIJUoDNholxr6m2t+HL7rDDvZjXoHzaNBODmx0VWheDm1EBMeBjNyAS2kfDYmtG
	kk+cVJ/g+yyvJ85nvme+xT6M8ipv6tD5w6dVz8w70f3DucXRzSusvU2pqU+dVL8D/9eKYsOZPrl
	pXiimZIqflkCZuynhxrvHguVIQ0uPlhSqrXz1VBtGHWzqxUSyTZP0OWOWbo8W3oXGXOtvtCo6xs
	KXhpWh1Yq+eHcQ+pX4c6Gq/F1cCkNc7l4OjXpmk2SE9G+iYRpGq7iCKgPt1E0Pi/C73JFEDcuTL
	Vlt+9fn4XRR8pRS4QHos/ARNb118iEZzejGLZEZrn32YB1w5/Lcafk7Zc8E2/bR57Yww==
X-Received: by 2002:a05:600c:c0d1:10b0:47a:810f:1d06 with SMTP id 5b1f17b1804b1-4801e4a38d6mr188113975e9.4.1769007674060;
        Wed, 21 Jan 2026 07:01:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042c3a7c1sm22747235e9.13.2026.01.21.07.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 07:01:13 -0800 (PST)
Message-ID: <99b28295-fb14-4f4d-98d9-2caa9be88e33@gmail.com>
Date: Wed, 21 Jan 2026 15:01:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 09/10] xdiff: remove dependence on xdlclassifier from
 xdl_cleanup_records()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <f9b10e71d23f8b4fa34dcffb371cf5a173760409.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Disentangle xdl_cleanup_records() from the classifier so that it can be
> moved from xprepare.c into xdiffi.c.
> 
> The classic diff is the only algorithm that needs to count the number
> of times each line occurs in each file. Make xdl_cleanup_records()
> count the number of lines instead of the classifier so it won't slow
> down patience or histogram.

Have you measured the speed up that this gives? It looks like it saves 
very little work for the patience or histogram algorithms and means we 
now make a second pass over the data in the myers case. If there is a 
reason to do this related to the rust conversion then that might be a 
more convincing argument. As Rene has said already this isn't a 
particularly interesting demonstration of struct IVec - it would be nice 
to see more of the API exercised.

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 52 +++++++++++++++++++++++++++++++++---------------
>   xdiff/xtypes.h   |  1 +
>   2 files changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index d3cdb6ac02..b53a3b80c4 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -21,6 +21,7 @@
>    */
>   
>   #include "xinclude.h"
> +#include "compat/ivec.h"
>   
>   
>   #define XDL_KPDIS_RUN 4
> @@ -35,7 +36,6 @@ typedef struct s_xdlclass {
>   	struct s_xdlclass *next;
>   	xrecord_t rec;
>   	long idx;
> -	long len1, len2;
>   } xdlclass_t;
>   
>   typedef struct s_xdlclassifier {
> @@ -92,7 +92,7 @@ static void xdl_free_classifier(xdlclassifier_t *cf) {
>   }
>   
>   
> -static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
> +static int xdl_classify_record(xdlclassifier_t *cf, xrecord_t *rec) {
>   	size_t hi;
>   	xdlclass_t *rcrec;
>   
> @@ -113,13 +113,10 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   				return -1;
>   		cf->rcrecs[rcrec->idx] = rcrec;
>   		rcrec->rec = *rec;
> -		rcrec->len1 = rcrec->len2 = 0;
>   		rcrec->next = cf->rchash[hi];
>   		cf->rchash[hi] = rcrec;
>   	}
>   
> -	(pass == 1) ? rcrec->len1++ : rcrec->len2++;
> -
>   	rec->minimal_perfect_hash = (size_t)rcrec->idx;
>   
>   	return 0;
> @@ -253,22 +250,44 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
>   	return rpdis1 * XDL_KPDIS_RUN < (rpdis1 + rdis1);
>   }
>   
> +struct xoccurrence
> +{
> +	size_t file1, file2;
> +};
> +
> +
> +DEFINE_IVEC_TYPE(struct xoccurrence, xoccurrence);
> +
>   
>   /*
>    * Try to reduce the problem complexity, discard records that have no
>    * matches on the other file. Also, lines that have multiple matches
>    * might be potentially discarded if they appear in a run of discardable.
>    */
> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
> -	long i, nm, mlim;
> +static int xdl_cleanup_records(xdfenv_t *xe, uint64_t flags) {
> +	long i;
> +	size_t nm, mlim;
>   	xrecord_t *recs;
> -	xdlclass_t *rcrec;
>   	uint8_t *action1 = NULL, *action2 = NULL;
> -	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
> +	struct IVec_xoccurrence occ;
> +	bool need_min = !!(flags & XDF_NEED_MINIMAL);
>   	int ret = 0;
>   	ptrdiff_t dend1 = xe->xdf1.nrec - 1 - xe->delta_end;
>   	ptrdiff_t dend2 = xe->xdf2.nrec - 1 - xe->delta_end;
>   
> +	IVEC_INIT(occ);
> +	ivec_zero(&occ, xe->mph_size);
> +
> +	for (size_t j = 0; j < xe->xdf1.nrec; j++) {
> +		size_t mph1 = xe->xdf1.recs[j].minimal_perfect_hash;
> +		occ.ptr[mph1].file1 += 1;
> +	}
> +
> +	for (size_t j = 0; j < xe->xdf2.nrec; j++) {
> +		size_t mph2 = xe->xdf2.recs[j].minimal_perfect_hash;
> +		occ.ptr[mph2].file2 += 1;
> +	}
> +
>   	/*
>   	 * Create temporary arrays that will help us decide if
>   	 * changed[i] should remain false, or become true.
> @@ -288,16 +307,14 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= dend1; i++, recs++) {
> -		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
> -		nm = rcrec ? rcrec->len2 : 0;
> +		nm = occ.ptr[recs->minimal_perfect_hash].file2;
>   		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>   	}
>   
>   	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
>   	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= dend2; i++, recs++) {
> -		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
> -		nm = rcrec ? rcrec->len1 : 0;
> +		nm = occ.ptr[recs->minimal_perfect_hash].file1;
>   		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>   	}
>   
> @@ -332,6 +349,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   cleanup:
>   	xdl_free(action1);
>   	xdl_free(action2);
> +	ivec_free(&occ);
>   
>   	return ret;
>   }
> @@ -387,18 +405,20 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   
>   	for (size_t i = 0; i < xe->xdf1.nrec; i++) {
>   		xrecord_t *rec = &xe->xdf1.recs[i];
> -		xdl_classify_record(1, &cf, rec);
> +		xdl_classify_record(&cf, rec);
>   	}
>   
>   	for (size_t i = 0; i < xe->xdf2.nrec; i++) {
>   		xrecord_t *rec = &xe->xdf2.recs[i];
> -		xdl_classify_record(2, &cf, rec);
> +		xdl_classify_record(&cf, rec);
>   	}
>   
> +	xe->mph_size = cf.count;
> +
>   	xdl_trim_ends(xe);
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>   	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
> -	    xdl_cleanup_records(&cf, xe) < 0) {
> +	    xdl_cleanup_records(xe, xpp->flags) < 0) {
>   
>   		xdl_free_ctx(&xe->xdf2);
>   		xdl_free_ctx(&xe->xdf1);
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index a939396064..2528bd37e8 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -56,6 +56,7 @@ typedef struct s_xdfile {
>   typedef struct s_xdfenv {
>   	xdfile_t xdf1, xdf2;
>   	size_t delta_start, delta_end;
> +	size_t mph_size;
>   } xdfenv_t;
>   
>   

