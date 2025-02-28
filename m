Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA37182
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701551; cv=none; b=g2RXQ7m/euurET0WMSUPveS85JYuuGTX8UWgQy3UcYghO7eqa7gIYPGh6kVz2jyxF+qW2mVXiWwEwfGmh2t+ULjxHJD7uTjMo4inkCJuGnqmr+y8grGAvNsjeeKEGYT6d7KNHNUoHpm420ER49GzIp81U7heF+CoLTMgWAYL7is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701551; c=relaxed/simple;
	bh=Q5yq2cfQ33xx8TlIpqP5ARsP1nmU1AWfn8EdxYIDeAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0j653asKY6kEwBvPvvB5phN11lMg8QT2wwZnk+cW86JlO9Jv7U52MLQEOnOEGqrFu+B5Kxazc//XR3Cj2J9T9Iy5CHVVYraJMprufvVyGywWr0WS/0CVo7Gvm77/EN5USmEkj2+ZOIvrNHYFvZtirShVJoAnsJ021TcQm2AiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=JYuG13h2; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="JYuG13h2"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb95249855so13519337b3.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740701548; x=1741306348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSdvptOJNKMTTG3RnCnH5LAioNfK3evYAd+j+gaHBcM=;
        b=JYuG13h2IUGs6ouS6RIhQbcMrdynaaDNCl4GL7y1CSRYLK9JwpxdlY8NCauFPLwybQ
         AvyseQAG8VlHFBe29J5OsYZzJMtMdn2UD3RaFIoEVN9DuTHQFuB92GGaSh/wAVxi+4pH
         YZ7cHssnPv1QdI/Imwqdyzh46DaCt46vSnvsCGShh9CVffqFPPzY+gXN2f74Pn7KOCmd
         LCBK22eWPeoiS7EJFuWgjiAjkSehKgh7vFYCvHQyXV0Kl9gyzDjT2xCeSJ86uB/5LZ70
         C6FwY7IF7aMmvoWdTXrP+KOfcH2jFi+epEjT6N4A442Qv+9B5iy8ixt5MGU+diU71jNM
         cc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740701548; x=1741306348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSdvptOJNKMTTG3RnCnH5LAioNfK3evYAd+j+gaHBcM=;
        b=AtKfixvZHbh1TIU6c5gHTCJfgkHmyQJdgWZzR2F67Z/wDDsfnhZ5Bdew84Yg2AS1ER
         GbVQnx8BONRoxNc3HgtrDn/9HtAG7mBux66zoYkVsEn0SbXR3vp99emZNrwql6h9Z9AU
         Q73jvTEXkXvH1bBK/C9/UXBCsOlZyU2BdteDhE0TNpQ9MKZTIsG4GaaavRHQhtorjiHZ
         STw7SwNFjJqqtysZmnKdrVmkgNlr/hFSm2iWZQTGyM6l9rj2Q5GNDz3zI1t17X8tI+r/
         giEKfWSgcPzjmHSHwct/wpfNGwupw5A1eEJepSX8S0WLVs7yfECcNkks5ZNV65biWkjx
         keaA==
X-Gm-Message-State: AOJu0Yzezx7sr2lPD1xyPjQTNHvahGJCyJunp2Og1RiSFFL4qObak7NA
	vVVjsfrzTpM69VauE0tbq9yziElHqmt9GgcdJFoIE3dhfcLScjfiEzTNMu4atTs=
X-Gm-Gg: ASbGncvaWPSbh9Q2YsCzQd9I0ntGDWG+kNdax/Ny/KDucJodxsfrveD/FHff2x3NXIg
	v4IfVP6OUwPWJhQX7GME7YK14D8w8kGYmVngaw9zw8RGOaHYzk9TsgLDLw1H4l5fb8sm9+CD0FU
	oLoIyKC1DjxDDfuSYKOBq607CXBIbb9V877KFtOgMCXIikyjaCBrLLB9CaqHTVJKwIvzjjNnCDy
	3JpwPY95+Oq2oHHTBjEPcjI/9oxAl2GvWO+4TVWzRyBQVeuX14/CzURMf12q0yTNo3J5cgDqm4Q
	U3sLLV2jH7VrWmfRMxI9ZLF4P/N3/8gbekUQwroAfEPMKESnhOkdJe+RPzEJEuvZ3ns1JRF/Aw=
	=
X-Google-Smtp-Source: AGHT+IF/VIjIRYJnWvA43avkCnjWj+OHInI1M3vga3snzpXaCnaeoMtazb2ru+ugMQVBycQshJZDKw==
X-Received: by 2002:a05:690c:3686:b0:6f7:567a:4576 with SMTP id 00721157ae682-6fd4a03af7cmr24467567b3.2.1740701548544;
        Thu, 27 Feb 2025 16:12:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e281sm5039977b3.69.2025.02.27.16.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:12:28 -0800 (PST)
Date: Thu, 27 Feb 2025 19:12:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: SURA <surak8806@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <Z8D/aiqN5e/aRSn7@nand.local>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>

(There's a parallel discussion going on in [1], so it isn't entirely
clear which thread to respond to. Since it seems a little premature to
comment on the patch itself, I'll respond here.)

On Thu, Feb 27, 2025 at 03:24:07PM +0800, SURA wrote:
> I found that packed refs are excluded by the transfer.hideRefs front
> match, while loose refs use full match (when transfer.hideRefs ends
> with '/', it is prefix match, which is normal)
>
> When the server uses git, after setting transfer.hideRefs, the
> references that the client can see before and after server repo gc are
> different

It's true that the low-level loose references iterator does not know how
to handle excluded patterns, and that is by design. In the packed-refs
case, we can skip over whole sections of the packed-refs file according
to which patterns are excluded.

But in the loose references case, we haven't implemented anything like
that to skip over, e.g. enumerating the contents of
"$GIT_DIR/refs/heads/foo" when "refs/heads/foo/" is excluded. (As an
aside, this is something that we could do, it just hasn't been
implemented yet).

So in practice today the only way to exclude loose references according
to some set of exclusion patterns would be to filter them out as we
iterate over them. But that is the caller's responsibility, as we see in
a handful of comments in refs.h which say "any pattern in
'exclude_patterns' [is] omitted on a best-effort basis".

So upload-pack / etc. will see all loose references, and it filters out
the ones which it's supposed to hide via:

    upload_pack() -> for_each_namespaced_ref_1() -> send_ref() ->
    write_v0_ref() -> mark_our_ref() -> ref_is_hidden()

, where mark_our_ref() tosses out references that the low-level refs
iterator gave back to it which match one of the excluded patterns.

And there we have ref_is_hidden() doing the following for each hidden
pattern:

    if (subject &&
        skip_prefix(subject, match, &p) &&
        (!*p || *p == '/'))
     return !neg;

So if the reference either matches the pattern exactly, or matches up to
a '/', then it is hidden and thus not advertised.

I have to imagine I'm missing something, but perhaps it would be useful
if you could provide a reproduction script that demonstrates what you're
seeing.

> It seems that 59c35fa accidentally damaged upload-pack when optimizing
> git for-each-ref

No. 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10) predates any behavior changes in
upload-pack, which were introduced later on in 18b6b1b5c5
(upload-pack.c: avoid enumerating hidden refs where possible,
2023-07-10).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/MA0P287MB06412DF70BCDA0D99641129FE4CD2@MA0P287MB0641.INDP287.PROD.OUTLOOK.COM/T/#t
