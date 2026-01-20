Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421433985F
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926779; cv=none; b=tF276K2VfxVpkMs/tNcO4jK4ALW9Z6CgViXj4v4MgBHLdiEZamELTjz9ZDVsj5IA9Sd/pEwk5xBXMGiCgmFzRk5g7XlpixVk6R7uK+h4tbuUHGSMY5L7qHXVUY4Ouu2Bnp52hSPyR4xVlvKoiWXYHzTy9CJA7PpSfj15M4dC/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926779; c=relaxed/simple;
	bh=WQdlOnEh1VYr1PoSAmcSLyYSIAn6MAHkhxgNedsNS8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqlkyeHm0OdO3HYQMghH2VpZokWY99hVLQ7GkrVYFY4zu1wVPEDGmpRvk67ocokXUBew3OgXJKi3HI3USDq1gpNxAJAf+wDwz+nkqqz+bFfRrgm9k4Lph1+4Rformvh3sfgN73L/8kI4jLiKmkkooRcXKjBtNsb1UtnPcNgjGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOy9Y9v7; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOy9Y9v7"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4801c314c84so36019365e9.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768926775; x=1769531575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QFr0ly3FbGMdWGGylMJA4JcER0w0U9mBiumht1eXNb4=;
        b=hOy9Y9v7SwwQmpFLB/QPYUy4d+su2j1Bt6SqukkqH1xrQUOw92IWfxe0kvCNHcjJYL
         i7EkkLLTHsrTTkEHCbFVDfuYnL5szp1uiBRKGxpAofoaxL5IoMOWhLfNwZTPif6f/1M5
         AM2jf4fYOo5SrwebkELC+pfSH4nLniTb7MwlFQVa6FJLDaGfYV5cl+/Y4t9/KF8wgIaL
         F3ETbmiZWpu80oCASVzmA1MT+iThav2Zfwmd08LlqPhuVVhn+Ad6kIeXPr/tVoxMqi6x
         BzLAvfOri9Y9xdWDNaJbJ057GabnmLj6+xcpKM0DWzpfkaDR9i9vvirQrwANvuZx8+pA
         z4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926775; x=1769531575;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFr0ly3FbGMdWGGylMJA4JcER0w0U9mBiumht1eXNb4=;
        b=nJzQO+7zzR1dX7PLJRnOVfPjzkEBX1rhoopAOeGvp/AkebvLz9wcwYu0sxV7yXYWTY
         J8RnwPr4fAU8kN3j8G1s2qXOQPlMeXtWLbrlr1tXgCc1/r5dQz2EAKFgTO6aQAPTXG40
         cG3x+oLoUJixtCu23nHvq+b43DZeplwplf9EYTAy/BBoMgiT+DIW4xsGyIwhbAjaZ0ax
         JUJwpv49417RPY0nbqbrSrkW5/Zu2azWapkBgduB81/PlMII/AJoz32QfpJ4szYTYoTK
         Us9USgp4TDNxrIS5pFRhTptZRakSHlOeUVSk1DOf051vvnUNlarx4NKJN3Yw1f1/pGu/
         tMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/oqh1PWr7jwABSPW1okDSymWMpnsbWv0j3tKAwVmB+728pt6Y4uXpeXhTkQL5L811+Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8sOYeQ5OnDWHBiaG9W6DJyC9A2UBbaGgXV/DZo7rQAEk6vEy
	iWsf0bmM3yOrDIurtDEC23jcZfjXFGSutFjRCtkOnorTllwHR9uoi89U
X-Gm-Gg: AY/fxX4aILju9LrWnDoZkHXY+p/lxjTrYrXoZJTtwlXJ4klHTo0HVMPamaNcmf4mBoc
	hvd3gDnyLLJcOySqhXHSPhZcdbsdU641eucIzeVgxNyuea9VYCT3QEFBYbQ8ihBzDDmQ0SXQZkJ
	yQfGbf5u120hAUz+KD3kgx2Bi4IorY4zZz/Iz8yR58zaocYwyLeCMhrlrPar9/r4NSSm6IjpSMs
	OpxsP1eHL9NvGO6JRiftWZeICIPSYpe5biSmiCpBqgv8KeCOWjn6WMUY9MMJYl9xfqs0uTeruU7
	Jq5YpSV/54T63ibgKUT+iFFUCn8+8Kh6jfKBj7znjxHzFF0BKLGU5kU4ek+059tJEv/P3+aM1Lc
	SubROieeTvkGNrq5FMYKAeX4RSplYcXGIYmkzNrwtr1q/Ruz2Vtdmk+nWfkDA+jE4M5MI0CnLxJ
	p6tx+WIIUQ5jADk958KwOmC1AQDE7nlCVXn/2Ht7z3JD1etatsVIuTP80iaHF/c4i/cg==
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr217349505e9.8.1768926775084;
        Tue, 20 Jan 2026 08:32:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe03b56sm115000345e9.4.2026.01.20.08.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:32:54 -0800 (PST)
Message-ID: <e9a031fd-072d-4810-b7e0-0d64ffedce10@gmail.com>
Date: Tue, 20 Jan 2026 16:32:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/10] xdiff: replace xdfile_t.dstart with
 xdfenv_t.delta_start
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <d74722538b693fb26e8684f9dd3fbc319a2a575e.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <d74722538b693fb26e8684f9dd3fbc319a2a575e.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Placing delta_start in xdfenv_t instead of xdfile_t provides a more
> appropriate context since this variable only makes sense with a pair
> of files. View with --color-words.

So as dstart and dend must be the same for both files we now store the 
values once in xdfenv_t. That explains why we start passing xdfenv_t 
around rather than xdfile_t in patch 5.

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xhistogram.c |  4 ++--
>   xdiff/xpatience.c  |  4 ++--
>   xdiff/xprepare.c   | 17 +++++++++--------
>   xdiff/xtypes.h     |  3 ++-
>   4 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index 5ae1282c27..eb6a52d9ba 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -365,6 +365,6 @@ out:
>   int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
>   {
>   	return histogram_diff(xpp, env,
> -		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
> -		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
> +		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
> +		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
>   }
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 2bce07cf48..bd0ffbb417 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -374,6 +374,6 @@ static int patience_diff(xpparam_t const *xpp, xdfenv_t *env,
>   int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
>   {
>   	return patience_diff(xpp, env,
> -		env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
> -		env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
> +		env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
> +		env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
>   }
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 06b6a6f804..e88468e74c 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -173,7 +173,6 @@ static int xdl_prepare_ctx(mmfile_t *mf, xdfile_t *xdf, uint64_t flags) {
>   
>   	xdf->changed += 1;
>   	xdf->nreff = 0;
> -	xdf->dstart = 0;
>   	xdf->dend = xdf->nrec - 1;
>   
>   	return 0;
> @@ -287,7 +286,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   	 */
>   	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; i <= xe->xdf1.dend; i++, recs++) {
> +	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; i <= xe->xdf1.dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>   		nm = rcrec ? rcrec->len2 : 0;
>   		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> @@ -295,7 +294,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   
>   	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; i <= xe->xdf2.dend; i++, recs++) {
> +	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; i <= xe->xdf2.dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>   		nm = rcrec ? rcrec->len1 : 0;
>   		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> @@ -306,10 +305,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   	 * false, or become true.
>   	 */
>   	xe->xdf1.nreff = 0;
> -	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
> +	for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
>   	     i <= xe->xdf1.dend; i++, recs++) {
>   		if (action1[i] == KEEP ||
> -		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->xdf1.dstart, xe->xdf1.dend))) {
> +		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->delta_start, xe->xdf1.dend))) {
>   			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
>   			/* changed[i] remains false, i.e. keep */
>   		} else
> @@ -318,10 +317,10 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {
>   	}
>   
>   	xe->xdf2.nreff = 0;
> -	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
> +	for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
>   	     i <= xe->xdf2.dend; i++, recs++) {
>   		if (action2[i] == KEEP ||
> -		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->xdf2.dstart, xe->xdf2.dend))) {
> +		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->delta_start, xe->xdf2.dend))) {
>   			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
>   			/* changed[i] remains false, i.e. keep */
>   		} else
> @@ -348,7 +347,7 @@ static void xdl_trim_ends(xdfenv_t *xe)
>   		size_t mph1 = xe->xdf1.recs[i].minimal_perfect_hash;
>   		size_t mph2 = xe->xdf2.recs[i].minimal_perfect_hash;
>   		if (mph1 != mph2) {
> -			xe->xdf1.dstart = xe->xdf2.dstart = (ssize_t)i;
> +			xe->delta_start = (ssize_t)i;
>   			lim -= i;
>   			break;
>   		}
> @@ -370,6 +369,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		    xdfenv_t *xe) {
>   	xdlclassifier_t cf;
>   
> +	xe->delta_start = 0;
> +
>   	if (xdl_prepare_ctx(mf1, &xe->xdf1, xpp->flags) < 0) {
>   
>   		return -1;
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 979586f20a..bda1f85eb0 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -48,7 +48,7 @@ typedef struct s_xrecord {
>   typedef struct s_xdfile {
>   	xrecord_t *recs;
>   	size_t nrec;
> -	ptrdiff_t dstart, dend;
> +	ptrdiff_t dend;
>   	bool *changed;
>   	size_t *reference_index;
>   	size_t nreff;
> @@ -56,6 +56,7 @@ typedef struct s_xdfile {
>   
>   typedef struct s_xdfenv {
>   	xdfile_t xdf1, xdf2;
> +	size_t delta_start;
>   } xdfenv_t;
>   
>   

