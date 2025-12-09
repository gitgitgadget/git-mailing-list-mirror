Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695283009F4
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765245014; cv=none; b=gbHAokcasZe9Vsu+dQ8JhHPyFCdVbirG4kVKoa9ETEY/cno7MGeDBla60vuSyvJoamuXvaNPDraiuMm0zeuJyzWMnBVAbBY0eKUAeJE9y/+qSA3M/SDNqwds5o28F3MRlBQtRrQLt4ZeZjZdNKUAYaaVM7ziCn48vQGo3NmK7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765245014; c=relaxed/simple;
	bh=ITXPEyHc3Jl2Px55w4dkM8OK4UxcTAV+WUwNbFQqMLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ1P7I5aQVtcsfgqS80bunt3qCr3fXFXFoFE3lEXwFJXDEooB5P7a/juNZ+aknRPHLhGOBxG6/clB65J65xNVGVeyOSakBulWG7zOU3RrG8IpzY93+5iIbM+nRGKxMhh5l+4SjwAD7AFN+AhTglXZlFEzVmaYVj682DP+23GKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=PLRncGro; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="PLRncGro"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-786a822e73aso49639197b3.3
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 17:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765245011; x=1765849811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITXPEyHc3Jl2Px55w4dkM8OK4UxcTAV+WUwNbFQqMLI=;
        b=PLRncGroQVPgnTCG6Ysrj3YTg4MYzEJcmnMASHdcJ73nm4m4oq/VIZpYKvyvsKH56L
         lCjZbnWJswljNLRBFnRIsEINLJNq4akCie6dszCS6xx8Og9s0if+oQvuE3XC+aJkWZ+I
         MNu8KJ5NfLIHqJWJgO6FaPX1gLbna64zlVFA1x5shN4mNgOaFMfovwAm9iW8SmQTQ63h
         hyX6AxSDKvzhoX1wGyAXLmWGSw5/LInBsacqb+hjQiXa2ukcFZR3RfkpNMY/Bp0xda3m
         1xGZfbMcQPKDAVYn2+4NuaOrGiDZxMmutr+ilu0Es9DsAJu4ut6IW486B1W3Hk9VNbSD
         XpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765245011; x=1765849811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITXPEyHc3Jl2Px55w4dkM8OK4UxcTAV+WUwNbFQqMLI=;
        b=WRR3M66fm6NhovdtomLbC+WnNmjihOl35PcNRpgVuq/x5aoMp8R5pE1epyaoz/2EZH
         uL/dhJEhI0lTP7B5klpHkDk/WEMBrVKzZwC6zwlHe6iO2FP/Y3DrC+QGCEYHw+X7vEJe
         cl9o+zvUlkLRzh3PUTvvt8WrkGqJ9ATYGIJBTSgKD9ubwiL7/wvAUTLJE8eiGJAQsRh8
         LXM+pvys37WcEJkhgnZ7Ojm8clZPpYSgWeQxZN8iifzbW2J5hiR6lx1vNDJWfulKDl7f
         TQHbVmiA9Gh8H0AZd5UZqYG/HKhnZ8klz+mVGUAWDURRGZwOxqdwNpi6j3FqJ3HJ17Wv
         VAOw==
X-Gm-Message-State: AOJu0YwJDDv44KdGA+Crwjp0Uv2IeJkgFmwLbR3FZEMz3cvNzL9Z4ayq
	qBfOEWMtp0E3OVWKwjE/BTwvooHkqv0oTKBlr2xHGSFuf5NQEN9PTfYMEfi5QMjdNhg=
X-Gm-Gg: ASbGncseuxxk9OcTOlsvklXFHJdz7pJ9tOS41ZErXGEb0pZRYnN3UYk2JQYicrvKOt8
	QI2Ij53qjFwLmCHN/M3/PUKhYjICr0VgKoOmf5nLATjLbmmVrTutgoPqIDKjXEbAIc+IYESbbax
	fSaomaqt6VhDkYMdo0gQZZsMsklEH2uWCxEG3HN6pGMxEZ+FvVqElYPPSjVhb3UwOo0kORU/NRk
	PE/X5+3Hsigs6rQPnyyJvMDvd8d4vogpSiA/DUON5nBwjjQ4MekmC/YZbRdh0yZua2Ao0gox3zJ
	nCe9M8WEFr83s/gFNvqrF8IC1jJN0nNFImvoPRuu1PFnZp35ByoHw0AQ6uWdKoEPmYeMHD48Syk
	P5sweDJfKi3yBoNg8chjKa16dxNmEwElzqpAVxS9cmBN3dGxrOLs2y9qfGDRiBR/TGa6KLpSZhE
	KqlhzI1lkpvTfgYbwSIv7jKSW+ZMeht9R60UJn0OuUZPOIlMgMxzaBS7+OflAL1x+uHWF5PuVez
	Y+u6J3hFWceORFOUA==
X-Google-Smtp-Source: AGHT+IGREIK0PQ026gGtdlPUFP0HePEB6I9OUB/96t7jmmTn+Ta9wNR/OarjlNynF4WIuL+ISmFd8A==
X-Received: by 2002:a05:690c:6c82:b0:787:b475:cef5 with SMTP id 00721157ae682-78c33b6e6ecmr92521397b3.30.1765245010062;
        Mon, 08 Dec 2025 17:50:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4e574fsm54079757b3.24.2025.12.08.17.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 17:50:09 -0800 (PST)
Date: Mon, 8 Dec 2025 20:50:08 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] midx: split `get_midx_checksum()` by adding
 `get_midx_hash()`
Message-ID: <aTeAUKrB89RM9p+i@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d583a169f08eea9d750622c6e3cf79774a2a68e7.1765053054.git.me@ttaylorr.com>
 <aTcYAdJ6lNCST7PT@pks.im>
 <aTd+fxpflcLuJXDn@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTd+fxpflcLuJXDn@nand.local>

On Mon, Dec 08, 2025 at 08:42:23PM -0500, Taylor Blau wrote:
> On Mon, Dec 08, 2025 at 07:25:05PM +0100, Patrick Steinhardt wrote:
> > If I didn't have the context of this patch series I would be wondering
> > what the actual difference between `get_midx_checksum()` and
> > `get_midx_hash()` is. The way the functions are named seems to rather
> > indicate that we talk about two different kinds of hashes, rather than
> > two different ways to encode them.
> >
> > Would it maybe be preferable to call them `get_midx_checksum()` and
> > `get_midx_checksum_hex()`? While at it, we could go even further and
> > rename them to `midx_get_checksum()` and `midx_get_checksum_hex()` to
> > conform to our modern best practices.
>
> Yeah, I think those are both reasonable suggestions; I'll apply those
> locally, thanks!

Hmm. Upon further thinking, I wonder which function should be named
which.

I think the _checksum() variant suggests that it returns the non-hex
encoded form, while the _hex() variant suggests the opposite.
Unfortunately, the latter is both more commonly used and more characters
to type ;-).

I wonder if there are shorter names available. Perhaps
midx_get_checksum() and midx_get_checksum_raw()?

Thanks,
Taylor
