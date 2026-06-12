Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BE3A7F58
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294890; cv=none; b=BmY5S0G1UUQGb2YbzFJ+NSPNzNaTep4zZ3uXR8/CW0zynd/gcmsJzYuNQavm2hZjUtGTF+IlOLdZ0vAltX4JTJg8GunzURhO31qyYBNjdXSDLJFDrTAj85aA22vQzRiVDNTW/kaRic5FH8eHRrDBKL3hCIZX5ehILKS9kGUqY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294890; c=relaxed/simple;
	bh=6bS4VtmGL6UPK1g0lo4ZX8kUyzvH6QJS8Mi3fCRFHpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz7AwTCRjyPH7DXbb0V03CgbJ6IEEn4KmQGfacEihJ/+G+LqIevz/V3Jof2B1I142gGECoOqspV1nHOfc5QDo/L8ednIl3W1AY5LYia1lC3v7wxlZV64jADGhiiH6yDGCVj3qIa0dkz5AJKUMtEfVtAr2127riKPVs++ltr96k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=NXxr7JWw; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="NXxr7JWw"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7ea16f090b4so18171787b3.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781294886; x=1781899686; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2qFlCvZKMR/PSSlD7u3y1NtwbcXb06tCySNYAsailk0=;
        b=NXxr7JWwGwPx0T9IvwKdRsJqS4YrAxA6SJ3CIEa+cad5qwF53Db9XQ7J0QezkwbfDo
         yP62acXHcnUo8hnFNPGW5CjJI1dUJZROQJrf4sXEdfJdPOxZrM+0MI62+KOKSn4r8RF4
         WgdKZe7dU5gmaG6NYWlx+vf85rImIULwemJgfUGyCV9IZXeVSyQ+hPd3GUZEfOjgYfkO
         V5Ur95j98EQABXYamyGrKo9mR07aabJ9fL2mZYnXHMnW4IqWXVUeTypc2ih5Htp9/2XC
         7Ha9XogybE8J4YDL3X95WFOGUTs2A9axQfF85sihln5p/Icpwdw7RSq9Ua0iDDsiE3NJ
         UhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294886; x=1781899686;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qFlCvZKMR/PSSlD7u3y1NtwbcXb06tCySNYAsailk0=;
        b=MFiD91/NnqrXhWKYnj9isvFgKgRrLyTs2CDstWE4HcynDSOGJG5FUH8JDIU1P+94+8
         Fvr8v0ZLobKqsDHauJbfHndtWHU44A/JOrKSomWKzrQNnLi5+vgpWJxlzAqYSTAfUhqt
         VzOP0ZXqXEsIEqzZTgguM9+iC7Rew6FT5/dnzQuBgBHBrP9KBmPVh4I0SsApxORTVSQS
         4SKnJc9yb+Yv9N5wCKxhsDLaiqgehpp1UNweYsCCog+ioxXmEPT2BLLV8cm1gNFCW06b
         dihGCyoqEpAjWiRaTIu1dMatAuDQcJ7kuFOwfsK2TM7jz2KYCymyJIqA6zjGMA6JV1WO
         QKIw==
X-Forwarded-Encrypted: i=1; AFNElJ9D2SHO/mQ+yYv53l+QStCGExELWMWO5o3a2J73TG2E2F9Mq5M7050rKNlUps79U/VP+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqteCPno+cMuIflUG7mr3AVCoZ9MWt9Ed6EllSos8U0Ljxzs1
	Ddum5wqbr27m0TXrdEMAEn6f+VZTsoU/6eA1fJN+zwxeaGYHXmnk93wduR/pJ6UusRA=
X-Gm-Gg: Acq92OEEpJXf/sUcOUDkRoZBlM36YTpWT5aCxR1nEDVeoirasedB7CFHSIJH1Ar1+1a
	PaOoHcRTmZOnWJYuwcEGfbtgaOtteRAwWeTuiRoZ7eFj8hP4F9oy4UgdxQDY79HR2XsG7ef+h1P
	bAZWWPZpJcbkRAJQuHpKYtskGnc6D0B442NnGY/ou9uyJY13XLoR5ANSRn20g4QYBtN96noZQTs
	k29GPzzhB81HLtRa0xk209Wnslv+FI2Nk6E3DYZz0k+Jm9yJw1p8x44zoRkG0LipqOw1E1tL0R8
	kx0poPq18SwgufSJ9K38LjtE6E7Pq8dB85Dg8yCwXbaUdOzTS8TDSYt95iQdvBFjVoxeoY525xi
	lVu6DpG7/kDXMCOUwo9wcJRwLQRZpeWBqCNGgzsNYKERujRSGWJsG+RsyJPu1bKuXdJqBS/9hQs
	hzUMluY44ZEpDu4A+lO5XFNG0SNoqU+Um2VnuvL+g/VyFPVZ+VWBdIrfW4ZeEcrd4v2J+CSOpuB
	UZUKD+TukbRVd8OBouEIZgbwY3B3kpF+ecVm38wTU4mVbp+IF+lJd1CmnLCCOme9+PYhe5/NdoN
	eMyhvYZm89WJTsSn
X-Received: by 2002:a05:690c:3392:b0:7bd:5c9e:2397 with SMTP id 00721157ae682-7f8c45cc084mr11903197b3.30.1781294886547;
        Fri, 12 Jun 2026 13:08:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f770d05a1bsm14254337b3.24.2026.06.12.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:08:05 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:08:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 06/16] midx: support custom `--base` for incremental
 MIDX writes
Message-ID: <aixnJJuDLOo/FsGt@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
 <1bbb387d6b6204045d97882fd8775dbff12dedbb.1779206240.git.me@ttaylorr.com>
 <aiuaf3fKJ6kIITrf@szeder.dev>
 <xmqqqzmbj3mb.fsf@gitster.g>
 <aixNXOxfPZnAVLgK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aixNXOxfPZnAVLgK@nand.local>

On Fri, Jun 12, 2026 at 02:18:04PM -0400, Taylor Blau wrote:
> On Fri, Jun 12, 2026 at 06:21:48AM -0700, Junio C Hamano wrote:
> > SZEDER Gábor <szeder.dev@gmail.com> writes:
> >
> > >> +	layer="$(git multi-pack-index write --bitmap --incremental \
> > >> +		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
> > >
> > > There is no 'nth_line' helper function in this test script.
> >
> > Good eyes.  It has been there in the file next door t5335 since
> > February, but not available here in t5334.
>
> Good spotting indeed. Fortunately or unfortunately for us, pulling on
> this thread revealed a bit of a rabbit hole. Patches forthcoming..

  https://lore.kernel.org/git/cover.1781294771.git.me@ttaylorr.com/

Thanks,
Taylor
