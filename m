Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C301EC002
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398682; cv=none; b=h0WVEkP9sG5PyoMYiQ4G96FHETeDfsev8TEGfckn0RiqrDOdaXzY2f7/TkTYmhHhfujG57x/PvKuRFg6WpG/POAyUVmteZAdF6/O56kmBCG2+SljAQeoK+NwAPA94wDv17UBpIPWQWRDMMVtGPDE/MtaIBOSItMzQhqlyPFNk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398682; c=relaxed/simple;
	bh=6FWISbqBH2x0Zkl3jBLSDEoNDXOoUictwwb1TjPLCho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQkZcW6zrWsFJgOOyCmrVoTHaIazOZVVsByKUIdkuKEfdOFV41PMRGUUIGSpz2vRr+nZ3UDx63y8Dgn3cFbyh9lskZhp+TPlyyBQoBCcacOPGAnCXzAC1ztRWsPYH6E7JeVajhwoVrNZPIfSBYNxZ6W3dJULr8ICj4fbPKGVrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VE6gYHvI; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VE6gYHvI"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c49c9018ebso54477307b3.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725398680; x=1726003480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XBnNV9yjGlPQoxFgkOglOMKjmlbqX/gkwAglaj/4G8=;
        b=VE6gYHvI4PLSrHD7DLGcBxqMjZ8Mugw3emdh3M8i+3fIT7g6yWkgHowlccGnROEINQ
         1Po7KsaVBWhdA1sO4kBkdsbyWQ0dmTELg9zOjoXWC2td4Ty49B+BBk0qZnscrP3LdfMs
         U0+fDcKc6cl0VE5B08NiufBmrFI8W/EfuRfR2tPDuPowktDE3k5IUAmseR3Y9UMy2hJR
         03Jvs3IIB/hg+EfjJz95JtoZE/72gn+9rfTPQ1VbVN9lcJCfMzRWQ1scn8WF9YiP4GjO
         7PpqIvMYmAcbhPhE3vGHWHhk67p2MzuuD3zV/nmWnv1wpaA1vM3UXzwdKCUM/USinFxX
         P/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398680; x=1726003480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XBnNV9yjGlPQoxFgkOglOMKjmlbqX/gkwAglaj/4G8=;
        b=W/3B8IyYzWjCh46H1Sc4V273RJgKTxAxXGmHG/1Z4APGYDpJTshaxfpbEOZ7Kt4ZJO
         14h6qaU9bidjihcOI/lRZr7F/3E+deXjcUx2iAzrK3GO3cSDKmlTt0oTEzm+i6MIWmOT
         Toos/8nh9MfSEYDcVF0mkLJBxQJO4zLDreTK9XdV34txX0tFPoF42uHqvR7alKoOZZly
         vCs8bVEEnW9Mc1/3QKpRua/PjtaQHkZj/3AE5uqbPpXieefFbeoYuOMrNo3aBSWY1YAI
         SoshAtvadflTIUbabw5V2oHTyegcmZpNJTpVCXEu/Pb5MR0Z0Yggtjzf9CQUSEziOyg5
         5Wqw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCUz61ubW564ARMCKGZyqs2gwtM60v6CFErj1chkWtKe1gx7K0jlUBRwAtO9khLlgXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/U1saC9+bufCzYuPXL3XcawzX/qAhASOuW7QYbcH0PvwxZYN
	p0BFBNu1WwSJ/f2wLHZAe9E7u2d7/qZ6spKG6xo594WNBqY2XjCCSPSt1KXJipU=
X-Google-Smtp-Source: AGHT+IFntvLD51IaxIvf95DjfuZk3nv+VIUD+OAEUSzsxmkQ34SXRm0mqysjYH2GnTqr4ysSFQGW1Q==
X-Received: by 2002:a05:690c:460d:b0:6af:c39c:da99 with SMTP id 00721157ae682-6d4101031b8mr133130957b3.43.1725398679965;
        Tue, 03 Sep 2024 14:24:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c7237sm21546197b3.9.2024.09.03.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:24:39 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:24:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <Ztd+lgWcRQs2IfvJ@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
 <ZtXAhP69zu7cDnsA@tanuki>
 <xmqqh6awlkac.fsf@gitster.g>
 <ZtdpFWtWae2r4Lj4@nand.local>
 <xmqqy148h3ci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy148h3ci.fsf@gitster.g>

On Tue, Sep 03, 2024 at 01:47:09PM -0700, Junio C Hamano wrote:
> > So I do not think that either of these two steps are necessary.
>
> I suspect that it is a wrong conclusion, as I meant (1) to be
> prerequisite for doing (2) and (3), that gives us the real benefit
> of being able to go faster than SHA1DC or even SHA-256.  If (1) is
> unnecessary (because it is already covered), that is great---we can
> directly jump to (2) and (3).

Ah, yes, after re-reading your message I am definitely mistaken here. I
think that in the future doing this would be more than worthwhile.

Thanks,
Taylor
