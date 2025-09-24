Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95872DE6FC
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709315; cv=none; b=Tri0xlyAV9JEHYhFSpmXwEg3KuhzUGGMxwbiaR9U+6nLioSaQtesM2VwBwKDxveH7YquzBxsN+fP8W2nzujT4l53ve2kPfgpt7fxmBMtBd5Y5BtCCruuEMK0laWfTcCygdTLfLCvL4x4lFZm/8GGjScTPOUrr19kLtibwB0eSdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709315; c=relaxed/simple;
	bh=1Ei/wF+Dh1PHzmvtVqOn57sOlZTMNfkfVbOhabGVNWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=joTolBtGIuqNosnoGw/bb6ZO3AwGr5s7ImWxviwCE8pmXdQ4SMBHg0POc7LAklbl8ZhW1k88c+Sdkt1X6XAuW45AlsOsER6bjXetc67SL3vlXru2owEfpQjWL881QgMhgA/b1II79oA0LUrFCh/waWA2eYTvHGRXIWoWHKLVMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzS7SXoS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzS7SXoS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso5043965f8f.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709308; x=1759314108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZqR0AkMtnWckjGnV6odZx/yDnMEwKPu8vKQ1vJFJR9o=;
        b=XzS7SXoSrw7VWWKYv0svdFtFvUcNm18HQ4RGvbgJOEuhocTp9pcOZA+ifZozTLH3hB
         UkDgslHL7XcYxx8SXQOp7a+R1UNYr6IgsRATo2ijVMKYM6jz+iOAml6sHBuxkjjpNMSL
         ZRy84LmZ2wY4JeaGhUUXtOHXtdFlBHJWy45GNKlDmhQn8TzM4Ov0VaOmNA19Mp/OGwmR
         ZZK0QBv8cHhjq7seG5oMoxCy0umTMVYdhl6K+Of8vDGsgOE/42MfWFlTHIxxCPkYXnFB
         Pl2LJrteyAcbop9sOCCdRmepcd5vxvIFCCfwLrP17rM4BLkmy8gmusIjG8jOYCuOGfrc
         UyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709308; x=1759314108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqR0AkMtnWckjGnV6odZx/yDnMEwKPu8vKQ1vJFJR9o=;
        b=Q1Iv04qFmCdMldRjiPJaBhmy75mrtM31dAmuYgOT9pXxPLNm5uRgGjbYzYyJJ/WWua
         8ccNvvMpSzji0FOwM52GJAuEkH2a2cmprsDNCSm7DJyrWLtvj3TMyk9hseW1JWio4mRo
         951L6qzc5v0bsrzwJ6fx5DYRiEOlTNY0zn//RjE6CsOI68YuMbapgAKlSlTP8oda3PI3
         JuijZlnFqgxfumuFMTLG/7zJIpOdUpzU/ZXHi+sq+i4cXvMXI8wqmq1n0Ktg4pLFhS8f
         G64L7jJb/25pgYqUjppGFMyRl3sZ3TO7xNjaYLgjTUQAQKj9IYKN1z9POIaim7iyVGUk
         kC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAuqOwm8WbGeNE2IWPzbn0+C9q0/kBrzqtwbhSMfvrPeAybJfj3/ZupVDbS7v94yEtcS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6Zk8OSdt9BHXDCBrOQgW8QVxm4hvsZTrbWEO55A+TxAskx9E
	o0E5lCHG8U9PJds6zfzxa/ki91/908TeDmCPqi0Nrf2qSLZHqOl0QwLC
X-Gm-Gg: ASbGncuGqmrl3XtmhNc87DEXYB7WgcE84sJsFfK3HfOPQwmeiswWymMNfk8iSvfFfSl
	2Gb0QeFw+qoxvNoD7SOAYWLwuUbA+hDbAzaTqzjODvomtZq/6hosnrY9IByBnWquu48F/xPRpoP
	W40VlPJZfYMfDx6Z/UF0BtWNff6brYAT9iy/XrCZ3D3bhpCw+xq814ZvyqudO1qX5yL6ei/Av/4
	aYiBS7tlKXw6VxxM+MsR1XDzRA1omH1sdpT0FxVNfIEwgFFgT77JZ/IOkVS18EHqWzZNirWq7sy
	3gwtPV+zPepXsgCximD0w/KxDbeYDYYlxkTurmqQ3dYO5fUW7zYDdurNhFKChZwvmKqviTcLY9Z
	nFwbwoGIRmRbBu9ajnNYtxBauuYRr7PPqFm9C1ZJaorCPZSRvO/MIvzdQawd1RIoOEuQDXYuXVI
	j2mA==
X-Google-Smtp-Source: AGHT+IFjtwnM+Kz2UcI1/bPUt8RDhI5P2crmUKg4TiU/G2EwZ39vLdrBodwlo20IKFTeeBqzz+8slQ==
X-Received: by 2002:a5d:5f49:0:b0:403:e61e:82e6 with SMTP id ffacd0b85a97d-405caa50462mr5165426f8f.46.1758709307994;
        Wed, 24 Sep 2025 03:21:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:5052:777:6f22:7bc0? ([2a0a:ef40:62a:101:5052:777:6f22:7bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f70b47ca57sm17027688f8f.0.2025.09.24.03.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:21:47 -0700 (PDT)
Message-ID: <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
Date: Wed, 24 Sep 2025 11:22:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Phillip Wood
 <phillip.wood123@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>

The commit message should explain why this change is being made

Thanks

Phillip

> Best-viewed-with: --color-words
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index a66125d44a..83c4cff6f7 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -932,16 +932,15 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   
>   int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>   	xdchange_t *cscr = NULL, *xch;
> -	char *rchg1 = xe->xdf1.rchg, *rchg2 = xe->xdf2.rchg;
>   	long i1, i2, l1, l2;
>   
>   	/*
>   	 * Trivial. Collects "groups" of changes and creates an edit script.
>   	 */
>   	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
> -		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
> -			for (l1 = i1; rchg1[i1 - 1]; i1--);
> -			for (l2 = i2; rchg2[i2 - 1]; i2--);
> +		if (xe->xdf1.rchg[i1 - 1] || xe->xdf2.rchg[i2 - 1]) {
> +			for (l1 = i1; xe->xdf1.rchg[i1 - 1]; i1--);
> +			for (l2 = i2; xe->xdf2.rchg[i2 - 1]; i2--);
>   
>   			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
>   				xdl_free_script(cscr);


