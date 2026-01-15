Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48F239A812
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768481774; cv=none; b=TFxxieyUZCjMkDHF8KNci5HMRhbUadLXR++sAx3CmfkNaVT09wjYlJIdHjblYTMNNBLeT4yiKZUe0S7cTBJRYXW4nyYvNNil3uaVKG7bbT+/Xo63bqraVBEDsbh/OMFZOHwtrSdPu0hjkIbr1wids4hDqlhRDFaSnbW5jkIaYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768481774; c=relaxed/simple;
	bh=+Xwk5FR5CVT6xkFCBKVtaJ5BfdayrhGj/ljE2qqRiOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZioO1HxbEtAHFgZzJKtCTJC575QdE06n49+q0MX2aEErenyadfuvW/fuyG9I5/Yd0TC33E365CY11AMuHSCbIh25uRJ8/eJnUDnKGKRy4cnQKUViEWjBwkPgf8Ot6arcSVtEFiL0mNJqXPTKBmBw6H5DYcR7M/D/o1dTwLMjH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1IW2Sbx; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1IW2Sbx"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b453b17e41so1039110eec.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 04:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768481772; x=1769086572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTUgYhXx2lg3ChxYka0COem5ubpiTA2A71A1OouvLdw=;
        b=i1IW2SbxLeCcnMGyyWb1rlqGsOtfDFqNYR1RFrMllYHKaaiBSvTZBDWgKlK3rtSaCA
         44wOGHWvvq70YVy50mBl3Ysz8Qw3NBwBeQoCJeYnhtHIhen24d/RAlMEEKVodyUOAnuS
         xH7tGVDGdwF+jxbPIGNOO8ych4PqwJIeIZ0BTOhU80Ot4nEVDN88tA6CXYyjRI8N+HUl
         vQ1c5HlF3QaJ+OR4q8fLIMeVNmBpM2N3CiO/YR3/hvOnlqcSs19uokDidxfGHqlH4OL+
         kBhSyuSZ3QrcUItB7/RKdmTMzUf3JdSd9bSMzXHsimu330cfKCVq5I9eJA8PpnpHNG0S
         LYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768481772; x=1769086572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTUgYhXx2lg3ChxYka0COem5ubpiTA2A71A1OouvLdw=;
        b=ohn+x2TP4TnIk4TPOlKV1VXUt4XtKnF7OyatBSa/exQAu3Di0n6mHpR1Fk5PvEx3IL
         ArmeB48hxHkYXfYZt33KaN8X2YUoqTRNBwHmQzqCE0pe2Ji52lUeTFLDljHAq6ERLIHG
         tredZ4wf86bLx85NXPh+Bp+/RQHulfH7tyR/aSM3//uRUK/g9J01eYm+dbye9Oq06H6C
         VMu903fTn3QFtHKaxi0iVud28PlMf4dmgP2S44W4nExVSEAr9/lkjLbkJjYmHyAgLjLD
         ONkbrjoQNQTXolFxy/JeIzEblgNZq9/OgM8hv8qzmQBCw8oViLUNE3ozyUgBpEqkjtFs
         x5Pw==
X-Gm-Message-State: AOJu0YyOJrC9MomYDPjiy3HWMBDUbGxK03ktkygOG2+EHCFfm3NDeSad
	mZJ6WwmJe9UDkwLX1Z32eJ3lrXHZermcPwd7khBlyjtkYeIflGRsCCUwyZvHFA==
X-Gm-Gg: AY/fxX7gSZkHFm4MBZHUV7yoctYqWzc1Ftr3P9zLaUwtqLlsomTs+HdYdYr+N9YP//W
	yE0VwKVu7Sic+jFEJBvAtH9QH/LFSYlV7L3gUbu/bsC1xrV8gLWFv9D3dDdL7zczCpILT2DwGEP
	RqT4EcLgudZXW6yvn/yazPvmeVA9dwb58vPM5gorGOhIQzv/bH0OK+LDozSB9g0akinUbdyLpdI
	pZ5+Vdow18BjBeewEaiyMx4/txmXPEWC0LphoeUnYNXDOb+bvRCKH7wbRFIaorR3GJ6qjRHKUN4
	CAxzQJmdJ+7rnCN7cFetO6xBctK2Dyq2K1X6L6tzVz/livL7Wdp8jVyPDze9rTPdrSW5wvXB5UC
	/xvqHBqgigDR+/8CEIF1a9MAnoou6EG/vznoWC97uO/w5jzcGjTVKioz/+R1gCuCHmlJKO90/Qm
	ehtSMM8A==
X-Received: by 2002:a05:7300:8c2b:b0:2ac:16c8:ff8f with SMTP id 5a478bee46e88-2b65ba5bb92mr3481631eec.15.1768481771830;
        Thu, 15 Jan 2026 04:56:11 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a5d3dsm20354829eec.13.2026.01.15.04.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:56:10 -0800 (PST)
Date: Thu, 15 Jan 2026 20:56:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/17] Fixes and improvements for ref consistency
 checks
Message-ID: <aWjj5wBi71KZy0dd@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>

On Mon, Jan 12, 2026 at 10:02:49AM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series contains a bunch of fixes and improvements for ref
> consistency checks. It is structured as follows:
> 
>   - Patches 1 to 4 contain a couple of cleanups for the consistency
>     checks done by the "files" backend.
> 
>   - Patches 5 to 7 introduce checks for root refs for the "files"
>     backend.
> 
>   - Patches 9 to 14 introduce infrastructure for shared checks with the
>     "files" and "reftable" backend.
> 
>   - Patches 15 to 17 move some ref consistency checks that were still
>     driven by git-fsck(1) into `git refs verify`.
> 
> Changes in v2:
>   - Remove unused `errors_found` field.
>   - Fix a commit message typo.
>   - Fix a copy-paste error in a function comment.
>   - Link to v1: https://lore.kernel.org/r/20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im
> 
> Thanks!
> 
> Patrick
> 

The range-diff looks good to me.

Thanks,
Jialuo
