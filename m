Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217327603F
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499443; cv=none; b=FYdf9ESz/k0Rxv6r/bR0RCRuCb90RS011nbUUsCzGJFlOdotiuuFuqmkwzKeCHd6oFrdCKC4/hb023pixGXa6NZr6AG7l6B1XrdJdYfnlC6CqZLT4JyFkMiL0OKdxAap9ggxHD7yUNuDWgSdNeIPZB6lrRnfzrtNvqnG95PV9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499443; c=relaxed/simple;
	bh=753QzuN//pbEO2xG6MMlUdYiGvW72Mh0dL2ChrGHdVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwGvW6ryXL6Fp1vh5vfmJf+6ibQD4sURCIxjxCkA75q8OLfjox/f4vVv3iGDWpZDIrGItP5hSdP3SsEqGR6EUVAqT7nONTU1sbOsmD7iLsxPep8jWD18fCCSrOrpOPgL84SQ+XPxxr3O80kDktVlI+R/W515RIWWC/hm/UFaLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emcvIn4k; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emcvIn4k"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-685013eb590so876609eaf.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775499441; x=1776104241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=753QzuN//pbEO2xG6MMlUdYiGvW72Mh0dL2ChrGHdVs=;
        b=emcvIn4kjlD4raPc9crluT/YsVdTX8Z9J418mFsJAkj0SsWnxCU5iW0LUJSkl4gCsZ
         8QPRBUS85cSpOxp2QTo/izGeYYf0tbdLZ0cRkTVYffLkO3HYeXVwFeKSJ1BQfm7UodQd
         LbkCM4wCOd526Zi8jNPH4dzaVHa0GvDiqMfI9RP56AfAA/Tf5Va8vzyuZWmd7TQxz9+U
         zMiKUe2hfaZGDJjSk6O2Ds8hO8XVxV/TRvETqXqTPLGvTP7cmC9Bx92psjXhIKtJspS+
         V9n+DIeJfXrW4EbLtNusl0MnhVLQT50BZMvwKKBtkFX5WfIudlLPWCHdjeWd2iV3WrfH
         t8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499441; x=1776104241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=753QzuN//pbEO2xG6MMlUdYiGvW72Mh0dL2ChrGHdVs=;
        b=q9n3CdnwhikAsXKE9HT+QzcjxZ6l0zXP8erlQEuSLLgRWdErIBLYoqbeYdSVFakayF
         0IG18aMPnS9JQEl++z12yaBtp1JJkDJz1Yf47+DGA1uSNNgor7Ld+gy/dOS7iU9lvHRl
         TyMMzvWgiivh5DengBHhbkSGyeINxF0X1x6ivWH6qg+w/6lAPYecnJ4BTmHF2Eh2Jf6/
         FNrMw1TxmnnzP9zCVTi/RhQ6+t2gPz5f6ZpqjUO8mZONMDqToL8np36lLh8aIQUGKYOa
         1SyryWu9PwQKep6A++2UkNpw0kvgZ3OxIBx2HQXP4dPfsZiz12KFOO0GldluxMhjrCwU
         gnvg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6T2pikziXrmg1Eqm4wKd5szp0XkFKmvNUEn5FbCSalIW3cYYBLE/2DLoKbvTwRbBixU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGP54UomBCwRBmx/ZlWd6hbosRTY2+T4JFvsyXLky3B+FW1FQu
	vDDVwu1eyeEo8zQYt7K9zZQU1A8kk0x5TK8ZlVCRXQVgnxBRdADM8CzcOSLRRQ==
X-Gm-Gg: AeBDietmpiTwAupcxkPJkrdUMOzuBfogkcIyPztso4r22Safmfk3m6bnIvNASdC2XKt
	I/R5n2VHTnodisx1wn6lFG9girGp9dj6JqtPOCKfgbMvL+MEJWo3+XjWWDGS2IaeuI2c/bYA7aM
	H5MhrxR1brbngBrXwbue6JlC+AGsH5/lxNFlBh6E9xS+nj15KGv9RZAi2IdjZhBbloIVm+10ORA
	J8hFxeFeCIU9a/ThG6F6a79w8pOfPEWS018aMI2Sjmy4UPVp5a8niQEXjWKIQrYDBNVQGXsy9h4
	u5xxy6eMmpRzZdd6LH3Qts8OVCuWFw2MYj90Imt3EHGfyRWjKTdrixR3uo7A+PiKmcxheQVR0KZ
	J19kj8hAezOdNiSOwDHKIrr1e6SO447e0ciJ3KRtD74XQ2i4GapoCCqAu4dhRTrBQCUuBbipiwT
	B/hyfPY5HcU1Sk9pn1
X-Received: by 2002:a05:6820:818f:b0:67e:f6a4:385a with SMTP id 006d021491bc7-68220845f36mr6421179eaf.24.1775499440778;
        Mon, 06 Apr 2026 11:17:20 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a540002csm8981955eaf.1.2026.04.06.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:17:20 -0700 (PDT)
Date: Mon, 6 Apr 2026 13:17:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>, git@vger.kernel.org, 
	cat@malon.dev
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
Message-ID: <adP0hnV7Gl08qqqf@denethor>
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
 <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
 <20260405191750.GA1525850@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405191750.GA1525850@coredump.intra.peff.net>

On 26/04/05 03:17PM, Jeff King wrote:
> But I think the actual code change in your patch is the wrong thing, so
> I also don't think we'd want to just squash that test in. I'm hoping
> Justin has some insights on how to do a more complete fix.

I agree with Peff here that the correct fix should continue to use the
object streaming mechanisms. To avoid this segfault, we really should
avoid using ODB transactions when there isn't an ODB in the first place.

I replied in another thread[1] with how we could go about fixing. To
summarize, it just so happens that I already have a patch[2] out on the
list that appears to resolve this issue.

For the use case here, git-diff(1) is only interested in generating the
hash for the "large" blobs and not actually writing anything to the ODB.
This patch introduces a separate "hash-only" variant of
`index_blob_packfile_transaction()` and is used to bypass creating an
ODB transaction when object writes are not needed.

If this is the route we want to go down, I can extract this patch from
the current series and send it as a separate fix. :)

-Justin

[1]: https://lore.kernel.org/git/adPjXKGIT5O7SK6E@denethor/T/#m9cee420941b66abfb0244ea4b7762ba8d0ff7b52
[2]: https://lore.kernel.org/git/20260402213220.2651523-5-jltobler@gmail.com/
