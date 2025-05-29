Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950A1DA5F
	for <git@vger.kernel.org>; Thu, 29 May 2025 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748548674; cv=none; b=lYi7TUXOEsKGHaSO0dvOmGdHE6QLdDZhMCiLi2GdrsbEfSVngYYoD8JDtC4VbGNIpOhreV2k4bdlQd5JVBiO8Nb52ahZ94YJEY+JNb89fbovLFlSpPjKEtyfHOjZT/qdBmeJ43aIySh/va3jeIxiiRBbIaVOLsUYTZkFTdturyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748548674; c=relaxed/simple;
	bh=HyLLVUbvV1r8GAi4DFWmZoIu0C1oeRIxmn5lsBYG7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ4Adf0gkKg4EbkFCeL6MTHqMjJCPm8VR+dtWo9VNScfjzPEt+9Sx4WlftBeBbOddX5Vewn+US9HvhS5DPA0EgHLobVppMB551ZNySUOA+OcUiAbwRPx4uVOewhxCjxhhXlB5jg/oGoLQygeVedcBOMktOpjDzOJ2nvMmTFNOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BC3J70PY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BC3J70PY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e75f30452so9978337b3.2
        for <git@vger.kernel.org>; Thu, 29 May 2025 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748548671; x=1749153471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ij1ZdYKTqqmTVPLN/dyl2ykP7FHpkyWoji0gwzA42w=;
        b=BC3J70PYNAMYvHw4pkbwgqWtCvu9sLu5HyzqDmt/AfsSsUG65lnTyeuzbMokc9WFIJ
         5AbRRNSy0Wm/Wxm7QsLlR6pcbOLEb8Vw0VK17Lu6L6zCcMulYXT0WtkFK54FEJH2/Dri
         +lUb8a5hcVzm2LstyD4QZ9BXpNLENWCk1xCvoeQf0f61tDvgutb1Rn5YZXHXajXW8ATP
         jVK24kE9C3W/reKQ6Sw5ABD4z0CSgmgafXSAZMhESv0udSFt3D/AQ8QF3KOg/UmD+Eqi
         qYDhAlVVlsCAD7UKpG6UkEGwf8BuPFZL1ccgfNNCN92XHqB+tPZjsyuwXvzfo3hkM11Q
         Ukgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748548671; x=1749153471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ij1ZdYKTqqmTVPLN/dyl2ykP7FHpkyWoji0gwzA42w=;
        b=jGgXrq6yygEzVgk8BHF1kLck0KwIh0rNahuKMw0TfMEQA9CFrFjpVd/y8fnIhmmGVz
         ao8JyINCgJvkW/sA3rGGu9o3FhyXhhqnXCFG8vN4VOsVpDAoLy1yNkTx1zZ6Du3zl9LI
         4QNFiMyae1NythEZiHyNpEQX0yI5B+otPkWYXWGfZ3fpOHzj840PBP6Of+f/h1Hra4UK
         /DvwsXW1EtNXJIChg+DuSy6zhsPulmidhmGY6ClplksmY+SFSsFXOlCnl4kvrxNzuh+Y
         EYSAAIkWgSaJq6ROHp0cumbe5BVQYZvSNdN0vALx4AVhll6vpR/84g9JYktL4AAub5Rf
         hx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWiaA0X5HPQ6UaKtHkr8BClOnbF8KOPsL56nGuUqTe4DSj9u9GZWizll+xgqSWhdQEOHLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFemdKnL2TqO5q0h5h1IO2P6BIKMlhGnfxQbwJ5NikBX7P+bBX
	1Q6tYVTSZL38lRjFga45z27vhF3VrckffPwlow70/IksRD9iADe0N7fzgWt/Z4TOT44=
X-Gm-Gg: ASbGncsnCAFn7pDyW465NXII7sIHSbsY0I15Z5h9Iksbvq1V9wxhC2D/RR3yeu+yozE
	wTH7xZIiJrIDKjZmm0QSFkDMct6VqvGBJPhcYSbgf7yOvpkiFFN9jOhqDFuPeFN1t6OHI7zdZS3
	eoWgAvNOdPRA/cfzNlyoVurs2IXw0tOm2bj7spzYskS/LqIfqjVdGnL8hGUpQGX5tPP0FLdv6o6
	AcwjPmB9hUrLJ/fhA+wPuh1R5JTgupJd8F3Lo5+QeTW4aY/scGoULKcstVrW7yUYCEfAUV05iOW
	vw1297TgB1aE9ZcIOcz/b5GB+onKuMyIZtlWegpv3FYUTznJiq9WQ3k9QcudNjOGzm8vrIEib4w
	cjOQBoCUte7B5FMF/gPJOjqNd8mY2vcvlTg==
X-Google-Smtp-Source: AGHT+IGZeWlt/eJ28YYXQqtibMeG/rqFovPvf0o55t/QcJFrPEHIiA7URVU1Fz6/TAkZgwWiOyzPqw==
X-Received: by 2002:a05:690c:6e13:b0:70e:272c:95ae with SMTP id 00721157ae682-70f97f30115mr12276117b3.32.1748548671161;
        Thu, 29 May 2025 12:57:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8acd7f8csm4541607b3.89.2025.05.29.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 12:57:50 -0700 (PDT)
Date: Thu, 29 May 2025 15:57:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v4 1/2] pack-bitmap: fix memory leak if load_bitmap()
 failed
Message-ID: <aDi8OD08I6+6BLja@nand.local>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <b6b3a83a22486d0c104c494d1950fdaa2f2a658c.1748140983.git.gitgitgadget@gmail.com>
 <xmqqjz5zmnxy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz5zmnxy.fsf@gitster.g>

On Thu, May 29, 2025 at 08:33:29AM -0700, Junio C Hamano wrote:
> "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Taylor Blau <me@ttaylorr.com>
> >
> > After going through the "failed" label, load_bitmap() will return -1,
> > and its caller (either prepare_bitmap_walk() or prepare_bitmap_git())
> > will then call free_bitmap_index().
> > ...
> > The solution is to remove the error handling code in load_bitmap(), because
> > its caller will always call free_bitmap_index() in case of an error.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
>
> As this is Lidong relaying <aCOFqYdnPp1Lne4Y@nand.local> that Taylor
> sent to the list, shouldn't Lidong's sign-off be after Taylor's?

I've always assumed the answer here was "yes", but I don't know that our
documentation suggests the same.

In c11c3b5681 (Documentation/SubmittingPatches: What's Acked-by and
Tested-by?, 2008-02-03) you added:

    Notice that you can place your own Signed-off-by: line when
    forwarding somebody else's patch [...]. Indeed you are encouraged
    to do so.  [...]

and that text survives into the current version of SubmittingPatches.
So I think that while our documentation encourages people to add their
own S-o-b to others' patches sent on their behalf, it doesn't
explicitly require it.

Thanks,
Taylor
