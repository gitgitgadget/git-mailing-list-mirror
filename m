Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7201C44CAE9
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921356; cv=none; b=Tbm7GsIN6D1c9iVrTPuS1AafYbXrtuKiSwSooq/vbSp3t2uUiz4K/Jiq4DisZSZyPcldsMkzmJG9s5Lb1vmsGNSCZ2x0uzH4jZA2SG/poubGNQ0FX+7X7PTUPmhBBN5A0kjn0Ppgn3ZxWQ1XOZie2OPVG2KcFyAbkk9+fjZESO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921356; c=relaxed/simple;
	bh=bVjvTLxjt5pN1PSEsTVwnxXwbQ3UnqtIot/QT6WDGH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhftbMMopiAf1VdiYWt9BinXY4ejh+dyq8ATl28+KJDG1hk6ac23Oyt/OBeKTCOR3H8ZKxmxPdD+QAfAvGiizbhhu/YPv/veU2og5drgYngCSizX/MoBL0EnngzoTcPyuzf1QXmofOgTZcYxcJwxL2t+IK18yw7txtGcuFVRhBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TN/jXWCC; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN/jXWCC"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so4821655f8f.0
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 07:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768921351; x=1769526151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E+0x2jy6ELCB1saVonU4EPVj6D/s6FVvGXLar/+MhA4=;
        b=TN/jXWCCpUzH1iG12G6wXV3oXpghKFU11Vs28Hsy++iom65WQre/Jp72raH0xCHT8c
         JJ48sRAw3oBhpyz1lWAXwziG6ORSOTGlZ+/LWbdngBh+QnAJww9iB8rZNQ5sMYjxyLQD
         0gnbxV1l2wucanCEHYzCzLPXCGRy2ubvTsK8943q/eLMtG7qwxkBA/VgCNojiMDDvlYt
         tDclC10vnVhzeIAP5zFKwZihcHtNQEFjmXSi/4y+ZAgHL0SE0DgZ1iyXSiAPJGijKKjz
         N2RASCzRgr354pEId1W5Ib6uPom5Vxd8VpXNnXSXyF2q2kZmRa9nZEh5PRg2hCgF85rC
         9TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921351; x=1769526151;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+0x2jy6ELCB1saVonU4EPVj6D/s6FVvGXLar/+MhA4=;
        b=b8JHQUd7sHBgt16+TCIlE/NYrQytkupcwNxtdW71vbn+kmlJHjzeihu04GxgjSNm/D
         Ax6bklHuzKt8ND62Qtw9Jcj87DjY2e7bRcOq2YrXtLfrBVbB+v+pLmKSFVP9beSR+CCI
         LyqSpSMzacN1YzjwiUdFIHKnooGHnDGjmE5dJ81BkGFkOtfzZo6b1dlTI1KlwJhagvH6
         jiqJ3xKo8+0ZZj3r7iVwuor5bkc/y4RyrOMYE+pdgnVbW3WdQIM8M4ZCBckEijaj/NL5
         pU5yVV/da1E8V/d4/qNNEOZc8Dj2q30VexCbcqhPN7iKrBUxyIqNUdrdBCpnU/Aco5zx
         Qo7g==
X-Forwarded-Encrypted: i=1; AJvYcCWxRz509qurmU/4zow81NLcy1Car//wnVJw1Qc6YLCvWiDOmm2oj9anjgvJTx3HREZnEYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlvp3yH+jBbXRMgpFBoMm1FrQxLP189e3/OQ6qHWhKe/j+8BKV
	emJ6P3kVT8xnXbF65pXaHOXaUyOpot/EWgrru59sDHdcCrbT0ZNTI9pA
X-Gm-Gg: AZuq6aI09isIXq1N40b6Ck4k11TJNh6wtGvmBL9unp2wQS1SR+exfOdQF5d0j8c3rZF
	IJhhesOC3RA0Et2tquIJzrw2z3tW5BzHdzYQ62/qKIFrW6aCHosIMuT/Iq3pIhwx1PA9X2f8bO6
	/2Vrt4MQMpy5Xp13e37CKQOIMsfQT6EflVEYkPAbBbdNZnqdbeekfQeaKVJgJsA5/QrFIkF9lhy
	CFHEKaSaIZJ90OxTFxmB085fmeTwS4+wpcbeaE/bqAJe77hBeLVfnUG0iWdrn/NnEpWDFhIDQVG
	Lw1QWDrGL/DbTFImbPivVCFIBCobom8vFB4rD4ZoHFI+qyDz7eCfvGwb52ys4eLnE0EC1CU/L4N
	LOQL1k5TMgmPIn/9fQ9N4yxB+R/74gT+PWKOlQ3PiZDt+0fYxk655IZAxlILo0ddtTnT+rXDOSy
	6Z6gzdz51ZBiBogjdny7sSfl7/E0R3Ggq7YSRVqhgYo2tfl8E1bbcnQn20rLP59XJtM/C8PmPeU
	S2c
X-Received: by 2002:a5d:5f94:0:b0:430:f879:a0ee with SMTP id ffacd0b85a97d-4356997f1c7mr22031470f8f.5.1768921351446;
        Tue, 20 Jan 2026 07:02:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921da2sm29919834f8f.1.2026.01.20.07.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 07:02:30 -0800 (PST)
Message-ID: <208da094-8a5d-4f16-b42b-5d5204576b5f@gmail.com>
Date: Tue, 20 Jan 2026 15:02:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/10] xdiff: don't waste time guessing the number of
 lines
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <53e4840c1653772379dc8d5c883b34717b81ac43.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <53e4840c1653772379dc8d5c883b34717b81ac43.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> All lines must be read anyway, so classify them after they're read in.
> Also move the memset() into xdl_init_classifier().

So instead of looping over the input lines one and a bit times (the bit 
being from xdl_guess_lines) we now loop over them twice as we split them 
first and then classify them in a separate loop. It does save some work 
not to call xdl_guess_lines but it is unclear if that offsets 
classifying them in a separate loop.

> +	for (size_t i = 0; i < xe->xdf1.nrec; i++) {
> +		xrecord_t *rec = &xe->xdf1.recs[i];
> +		xdl_classify_record(1, &cf, rec);

We seem to have lost the error handling if xdl_classify_record() fails.

Thanks

Phillip

> +	}
> +
> +	for (size_t i = 0; i < xe->xdf2.nrec; i++) {
> +		xrecord_t *rec = &xe->xdf2.recs[i];
> +		xdl_classify_record(2, &cf, rec);
>   	}
>   
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 77ee1ad9c8..b3d51197c1 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -118,26 +118,6 @@ void *xdl_cha_alloc(chastore_t *cha) {
>   	return data;
>   }
>   
> -long xdl_guess_lines(mmfile_t *mf, long sample) {
> -	long nl = 0, size, tsize = 0;
> -	char const *data, *cur, *top;
> -
> -	if ((cur = data = xdl_mmfile_first(mf, &size))) {
> -		for (top = data + size; nl < sample && cur < top; ) {
> -			nl++;
> -			if (!(cur = memchr(cur, '\n', top - cur)))
> -				cur = top;
> -			else
> -				cur++;
> -		}
> -		tsize += (long) (cur - data);
> -	}
> -
> -	if (nl && tsize)
> -		nl = xdl_mmfile_size(mf) / (tsize / nl);
> -
> -	return nl + 1;
> -}
>   
>   int xdl_blankline(const char *line, long size, long flags)
>   {
> diff --git a/xdiff/xutils.h b/xdiff/xutils.h
> index 615b4a9d35..d800840dd0 100644
> --- a/xdiff/xutils.h
> +++ b/xdiff/xutils.h
> @@ -31,7 +31,6 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
>   int xdl_cha_init(chastore_t *cha, long isize, long icount);
>   void xdl_cha_free(chastore_t *cha);
>   void *xdl_cha_alloc(chastore_t *cha);
> -long xdl_guess_lines(mmfile_t *mf, long sample);
>   int xdl_blankline(const char *line, long size, long flags);
>   int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
>   uint64_t xdl_hash_record_verbatim(uint8_t const **data, uint8_t const *top);

