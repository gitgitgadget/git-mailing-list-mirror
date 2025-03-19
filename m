Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB5DF58
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343452; cv=none; b=efx/LlR3b1qbbzoVRVSfeyL4gD73jJ3NkuJCHoXXQi+EMz1OKk72LDJVnSRSgzGDktDND/4pJn2lHmsfDLGYe/FZm0rGSGobMmZ1XnfSUfKQBjYUyQXEKscUcvgNqVlp2LTsIu3Y/miUNtQ+nBUc9p+YxWFeBSAeNuLlcUQX5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343452; c=relaxed/simple;
	bh=+0MsJobqlwaU9XGjs4NdExSAvJnilnEA+PFKReEAeb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEFEoOY8UkU6aU0dMHEhjLgguqPV3ywasUO8wzMHmYuVpDDpeCaZov7z1mxwRJSgQMJ9gY45w99WRACRuXkfr4KkJz5251nFXc/A7rDaXLJJdiI6lrh4ebmqqMBGr6uAPv+4sKiBd5Blp1VL7d+4EClFXljaHCis8R/2/PXkJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0LK9Clzo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0LK9Clzo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c04df48a5bso606135085a.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742343449; x=1742948249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+0MsJobqlwaU9XGjs4NdExSAvJnilnEA+PFKReEAeb4=;
        b=0LK9Clzo/TTWY+4oREXl6CSSAJ7Is+qQOVCrR2nQxtlIFgV6lsjxQNuyuXqlxZsgTV
         Sq13DlWxGap+m3ic4t/ZAL8u8hRn8+cGEzSwAjj/jOMKLlUHDvc8doNYPnVGOcc8SOts
         /qfgTv8ZWiqEziKFopTbuOYo4Z9Dc9XdFGq3VA8Lw3NZBMtvXAgL34odTKDS1RWkpf6w
         FoW8K011frT1xMnhFeIV9GmGlbh4jNn5/DNBeq4XOutpQ5PqBNERg0rCPRiAZBat0TMF
         6rRx11vxqr+2JVfJ7QGX8JGTZBT446pyPRP5kuaAQzGumK6zmO6vfhGUFIR0UFBMmERG
         ZWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343449; x=1742948249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0MsJobqlwaU9XGjs4NdExSAvJnilnEA+PFKReEAeb4=;
        b=GvUHj941LRUskGJoqLjam42Brass+TbenpddUjAgKpWnK+PMG4771uN48N/MRzpbrp
         04R9V7EkeSFZ4g1h86QG3N63xziRuKZQ5FxyCxc6CSkv/tvMQlbZdge3AcSP1VOLZu4K
         PBj8ZO2AGH/ESUS1a8n9IM1OW/COIA3SiGh+619Y7+O2kJvcIVE6u6+NtihOoBFNwj28
         OdYPEjTM1CFwH9aHeF/aZEeFRMxewEaHaPhj9WKw9dAKjrFREpWiY+T8+clcqLCx0jyg
         U2JV9arMj2WTSTa6kw0e/ArANCJdGzB1ITtScXgoASmOACyq68pbD8VimhVSzz2zGHQ+
         FUCA==
X-Gm-Message-State: AOJu0YxVkG3DXD5OZljk7fpekCPgF1DYADcY5Kqxqh1xKYaA2GFSnfVi
	B9VLomWSKxGkzO24B9rbCI/3ci2Ja2v0zV7FublYRbz0u6NrIx2iR4EcoHneIQgqh2azc7eWv28
	Tk5g=
X-Gm-Gg: ASbGncs8Y1g9FISS54JEGm5o/h19PetVk1vCNwKKBawnG/SDt+3gsGmpdv/TYaMQJgk
	fb3F12ANOb3wOvOxwkkmJhJyd4GfGUyNA98C5GQwxNZEqj9zBfZCaObGFBJwYf7OWjHHugEfciQ
	F4jj7HalF386v4ibGMTbE9WriH+tjyrYRrcNx4KM5rt1mdjY4ybwe1QujKYH0wRwnz4ko4FpgTv
	WvLNwEeRY00EKZAzGZednwBgLlHugHImBGhrDL/MmxkP83jcLzPumrvpRfsmLYU8olefuemWqLX
	GV/13fehiArw7dQtkb7rHEQiVaKn0b/2bViIMBx4moFomOvL8XLUywmVOlR6sTMWTxaXAkOThvD
	+DHm6A+6hxgoBmJsfaEn/VGPrxHU=
X-Google-Smtp-Source: AGHT+IFTcZX3ELpNBVdPEZItwe+pOFW73vwILaEtby8FefWnuQyG+JBkf46QkCC2DNcCs68GhI2Thg==
X-Received: by 2002:a05:6214:cc8:b0:6e8:8934:337e with SMTP id 6a1803df08f44-6eb29418985mr17037146d6.38.1742343449494;
        Tue, 18 Mar 2025 17:17:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade330ec4sm73368856d6.84.2025.03.18.17.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:17:29 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:17:27 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 06/13] pack-bitmap.c: support bitmap pack-reuse with
 incremental MIDXs
Message-ID: <Z9oNF7+xuQKqYNPX@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <14d3d80c3d301233048004fe9de18154aa597782.1741983492.git.me@ttaylorr.com>
 <CABPp-BH3h_XY-+K1uB5SWWKrr7UrN1JHpQX+fxgJ=pTaLwPZ9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH3h_XY-+K1uB5SWWKrr7UrN1JHpQX+fxgJ=pTaLwPZ9Q@mail.gmail.com>

On Mon, Mar 17, 2025 at 09:13:52PM -0700, Elijah Newren wrote:
> On Fri, Mar 14, 2025 at 1:18 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > In a similar fashion as previous commits in the first phase of
> > incremental MIDXs, enumerate not just the packs in the current
> > incremental MIDX layer, but previous ones as well.
> >
> > Likewise, in reuse_partial_packfile_from_bitmap(), when reusing only a
> > single pack from a MIDX, use the oldest layer's preferred pack as it is
> > likely to contain the most amount of reusable sections.
>
> "most amount" => "largest number" or "largest size" ?

Good call; between the two I prefer "largest number".

Thanks,
Taylor
