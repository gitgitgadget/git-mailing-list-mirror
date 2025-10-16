Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5F522068F
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760644583; cv=none; b=sCIZw/OgAyS6G6aG0S9aBjwdTm7iLDlfNCqjjlunGsCYYavNXb16gLdNqn0HWes7RlhTXsnCUmlgBvZCHbDWVIGDFU0OaA42AfljuFz4eg3+kOKtoomaKEg17sIgbzqInPKtDxORyXNZw3g05Edf8iiR4SdSxhRU+wPBQMpcbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760644583; c=relaxed/simple;
	bh=E+qr24yy49vp9tmbDwa3bgFqUzLo8OLSC0WzaybhoaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwrXho/8mldB4oAEPM//zkhMdN/X9Sva6T+z24xo6/N3yoOdozdWnLd2zzqHXdPfuk+NnIYgIOdheu1ayBmATmKGwyW09SBLM15eHwwMGduHy2eumIhZFM90tPBFwgZvSO/UnxhS08TIGRNZ/3L1umj74wSJ1VyyquRA7yhkALg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=oWh6AWz+; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="oWh6AWz+"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430abca3354so10221375ab.2
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760644581; x=1761249381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WztbOnPZrjbYoVqhMI1jPmMfak9q1nUIehBnmCCwZOs=;
        b=oWh6AWz+n2oW3twVOm5GvM8gyO5VukY8l8+eUaTSipdRnyMB/goqcmlyJXwMR2d7Ao
         WPmk6FdPFhpXKvbM/vW1MwPXfOsqRKQpkc5Gvi5jGcyQCdrrRwrp5STJFDYVM5CfOSMf
         mmYQgWvBGVSTXe4vzsFqU2frj1zjvcalfJRyksrFedpEsmJoGk3yKbS2G+rCtgxOK20Z
         sY6wjf1WPAUKPrKv1c+tFEtu7zlMgIeiRLmPtyaKHxkbS/Bfqatp+K6ZWwDjy2xGRryb
         PPDu1OLIiwwBfnzeDe1b/CDGvPWzWT7NCaCkWw+3c3VyugjDgxmDVIwTuJ1FR0s9K1ic
         GsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760644581; x=1761249381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WztbOnPZrjbYoVqhMI1jPmMfak9q1nUIehBnmCCwZOs=;
        b=kCFwlgbWX2hTUQW+E1ovXBCyxfe41kMLQ68KQ0PtQAtKbTsRGZds5uIMsWcHQVdI0z
         mSR7msLbNedgY6qnyQ4p7o8BDkplqP5W30UxEGFy/7RJmTO/IbMfYwYnB58JLT+qOT5O
         o963ljrX7qP1qeC1xkOpKj9JxvSyDuzyLPhkl4usQLZ/GLoLmMaDUYnSLG7nENW25V3A
         7VfdBNXGmDibg/1uPEwKJ9xop8rp/Z6Vi6zFMtrLhkZZcQNACjbuucZu1wiuGBUQ6Yt1
         aTvQlVFa3YuBEVpxu5JDr37ok76GzMdcfCWkBlK/TpNiPmuQfNM0ttot3E0cliKkOBZ1
         jfpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK6FNdJEQKDiz8fKYAlDGhwkyIoASJDlGA7jrasMe0FgmA4wKdxLR1YgpuDbpTFlEb9ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTcFAASTuqETLjofFRHpOK7l8WhYifTVYjwX9rPj1b2Ib8VBE
	eGNjwl2NEnYrdsvMattq3wDeJ+hv7KAkeIPknqHaG0udXb0oCSQyKDf/EiF5yRvDDWy3dlZNy/K
	I+bp4pcXzqQ==
X-Gm-Gg: ASbGncviVGrt4zGzd3HmsvwNV0/uOkvm0LWfHv5pupHL1XkGc99gIkqzH93NRU0tjnA
	GGlLVkRN3OHjD++vnYOZO8KRIIwHwo36mPPjyeqgRw0K+eCXsoIEBdZN/s3I9TPhokKGfiAyEyo
	/aIz8IpguNKQOod2VmrJE8jmytfaG0m8eQlwmET90AhtkgW9rXAkphvwF9xfgns33GxvQeeo44Q
	LVVow7CUxSGOWvnoxsuWiOLvxkQ3B8A8ZYFuHAtHbbNHDhqFaxGUc4R4gNYDKxNkpqGeIxmBR2h
	NGIm6pbWQhmtjJwfsPi4uWEH3icIgLh5INlQImKuszs8W3uqykbT3zbOoLN60r0MumgmZVIum31
	9Mt4p4QgRltC3wVvBmu7Ry4iH1qZOUxkldXko0gpUZn/I2OsWR7wcjKJSVx6JXG4ljln8e2VETy
	m3vK6n4k8ofdsPNTSUkzx0z5McLhVinxTX5LeUMbd4MpDHdbkklzTaioGI89oik1LBRRQXk5oGs
	Ll5Tkw=
X-Google-Smtp-Source: AGHT+IGoU+K6GRRJFQ4J5o456wh1p7Pzm6JNabZOzhzX78vWS2jCmxtsu3D8klk61b3pUWnEuTxLig==
X-Received: by 2002:a05:6e02:1c0c:b0:430:b1ff:74cd with SMTP id e9e14a558f8ab-430c522d9f4mr25370095ab.10.1760644580616;
        Thu, 16 Oct 2025 12:56:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-5a76f71284bsm132767173.52.2025.10.16.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 12:56:20 -0700 (PDT)
Date: Thu, 16 Oct 2025 15:56:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 00/49] repack: prepare for incremental MIDX-based
 repacking
Message-ID: <aPFN2cURAlknAypj@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
 <aPDJj5e9GKLSeVfS@pks.im>
 <xmqqtszy4vrc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtszy4vrc.fsf@gitster.g>

On Thu, Oct 16, 2025 at 10:11:19AM -0700, Junio C Hamano wrote:
> > I didn't quite feel like reviewing all of these patches again, so I only
> > had a look at the range-diff. The changes in there all look good to me
> > and address my feedback.
> >
> > So I feel like all of this is in a reasonably good shape and a
> > definitive improvement for our code base. Thanks!
>
> ;-)
>
> Thanks for a vote of confidence.  With what I saw in v1 round, I
> agree these are in good shape.

Thanks, both :-).

Thanks,
Taylor
