Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3759A21422C
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085469; cv=none; b=fTNmM0osVoeZvhF70/yQqj2UZM0ElP0Yb096OQerRhjVza5NuvXKsxACD3lSZm9Z78trw82a1rpCltic++HB2juzTrNvpJgEvxQ9g8fpz/VfVI2iRjVx8v32zlb7l4K3U5AFvPovPxH5IDAkiYzYQpu0zOydAbUz2Ji884ayjic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085469; c=relaxed/simple;
	bh=ikikWZMoRaPGT/RuIrc5BEpeIpl6KRgEbHpjMHYayJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcmw2h64k50TIdS7Eib5Fa5Wfm+8f3/rSElQL+mV46deZjQ2rmLk4iPnGrkvVAZnf3w+NADU4nNYOj7h896riYffNM63Fw1RPKP8xBcjdK6uN55Tv15TXLyFGl6aLmb19bOVOAdPewURs/zl2woKDLJr7HSxjlFuO6QS/FGSrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0RssCshN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0RssCshN"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c554d7dc2aso191004485a.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 07:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1743085467; x=1743690267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28EKXIwyjlUOt4fgGT1vSLxM1YwJJdi1ZeZYwHd1k2g=;
        b=0RssCshN+TSrI/6Nm9PT/gef0VNQwuO4y+jYQfxvjRklicgnofTm/mYTAnFjKvwIzw
         1JdY3hdMCz37DOxRZjkNiJ26tNUYCE8O0ogPeG/1zNWfQr9tNAK3DO71yqT5lFaCd5RV
         Rg0cnkmmCM+8vc8VWjMIn3GPlepOPIf1NLNP5TizWMXXHcJDrut/WiM44VfOgauCbD8v
         308nZaJIXRrBBJHqdzvC257LXiaLLgVR9E2ZgCVj8PC1j2agKF+bKTOxsMhIjirM7DDw
         e8fLO2E40+TJWhJdHHh1Hgot97efRByEawHwaZkweSvIQfcrPHTRl820xTYPpcTZI8BK
         aDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743085467; x=1743690267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28EKXIwyjlUOt4fgGT1vSLxM1YwJJdi1ZeZYwHd1k2g=;
        b=R8J+Y/biLc33nWojYJ+ZljL+8fwwJ9sg7qF0hfyV8OKV8g10besuCsfk+avalX49T3
         WDVVL/dlfpc7URgzcUTeHHfH3DgzKDXwZ6s/ZGn1b7cODzHhqTBON4nOK+/OEQyeOgk+
         QwjqJEnM/QbGiVvQ8MukcEVAmeEk9GJbEokv5ttybayQIQ2PN8Zw8ftsweAeDTiWjW2s
         ilmXsBtdtVqHIXRrLqH2tcx+zFlAyMsERJ2lxKuq8SCmycvN/VvHwfy+S43lZSoQy1rj
         avl4IT1OiKU98hAgETEe/Ykh57VQp56L3rUdrUp14eISKv8E6WOEdn1F8lYJ8w5UUAnF
         A56w==
X-Gm-Message-State: AOJu0Yx4BCIsdLn/bHmvWkq/+3U4RmneUVoOXJsSqkr3H4EHtaWLh9h3
	K8r5CUmn6f2a3ArJ/39zjtY2L4vTKwvbNTZkXlYGNy33iyuI/SN6zW+OqkGPUrg=
X-Gm-Gg: ASbGncsQduMrLGdHX5bAC1SjoCnWm2V11b9LHYdqBkvaQeBrikEzBmohGLaCyRr51mS
	TDM2xrQtqto0OBHf8bV4r59MPMqL7TJRZwdtgB8yFlevR9aQK6zce/suS/pQhlq6puNXNzhddsm
	VIWQzkY/m2vw2jxsrZvnLM1u+xJZOBQVMgK3XuaIH2qPusgNMGXPzPMXbMzdu+n7KT3TNMzjFGO
	K7wv8PkI38pfr8JNs8s9+3NdpPs/Jv/JjOtCc18/TpBeQtZksRQM9BdXMcNgW6VUEdXr0zGD5sT
	DF3sCem7KhYb4ffKnEswysS+URLenaZ71lhw2Ww+ZSxHgmH2dEXzuML0CUez/VZUDMCdM0uCXzI
	ENrBFu4P+0LEJ4IzR
X-Google-Smtp-Source: AGHT+IGenkJRvkGrujuptDLMwzPZfYNLcbcVrqanltsM8LHIZjfbhFDHm/5Sw8ZhRPvZ/VeYQJaTyg==
X-Received: by 2002:a05:620a:4508:b0:7c5:5670:bd6a with SMTP id af79cd13be357-7c5ed9f521fmr478914485a.24.1743085466886;
        Thu, 27 Mar 2025 07:24:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c5b935528bsm894370885a.100.2025.03.27.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:24:26 -0700 (PDT)
Date: Thu, 27 Mar 2025 10:24:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] load_pack_mtimes_file(): avoid accessing
 uninitialized data
Message-ID: <Z+VfmZ4RZ5OjU/ed@nand.local>
References: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
 <d630e95b9672e6b4b3114c077f2995c5170a6a8f.1743079429.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d630e95b9672e6b4b3114c077f2995c5170a6a8f.1743079429.git.gitgitgadget@gmail.com>

On Thu, Mar 27, 2025 at 12:43:49PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `mtimes_size` variable is uninitialzed when the function errors out,
> yet its value is assigned to another variable. Let's just initialize it.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  pack-mtimes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-mtimes.c b/pack-mtimes.c
> index cdf30b8d2b0..c1f531d45a0 100644
> --- a/pack-mtimes.c
> +++ b/pack-mtimes.c
> @@ -29,7 +29,7 @@ static int load_pack_mtimes_file(char *mtimes_file,
>  	int fd, ret = 0;
>  	struct stat st;
>  	uint32_t *data = NULL;
> -	size_t mtimes_size, expected_size;
> +	size_t mtimes_size = 0, expected_size;

Hmm. This one follows an identical line of reasoning as in my previous
response in the thread. So I think this one is likewise unnecessary
(though not harmful, and certainly useful if it appeases static analysis
tools, etc).

Thanks,
Taylor
