Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E261A6814
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781877867; cv=none; b=p2zPROted8iYPFiKIs83JGZWGLNSVuvlDE3jEwOAGmQ7gNfLLEjYsZYiTgcqo6aJ3v96WV/38Z7QZCDrDrg563rnX2hqLALDhoiBVu28A99nST6b4AaXNoXHDnKRZDMMkFaV4badWuD3aLkB2okkJ5Ik2er8kYZh6fOOS6+tOIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781877867; c=relaxed/simple;
	bh=Dr7pb2qrGoLc4fMg2ZX/MSi2bm9L13q6rwf13xxbDLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esg+hGjp8TtgXna/mBO7dlyC7UJ19sur0XvcdPcwSoneKdvPc+n1lgmdpUIgmOXD1P6UsB+XrVk6J3tAmt78qGxZRJK0+JUzpdX8mybUFVAIGpGGgCy6nfNJQ5+wzD7JPWlSeMfHOyd/UbaRM4AJZI8NFIuL3p1LC9yIhbPJRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GNT8BD6M; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GNT8BD6M"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dc6fbf3e86so29822907b3.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781877865; x=1782482665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr7pb2qrGoLc4fMg2ZX/MSi2bm9L13q6rwf13xxbDLk=;
        b=GNT8BD6M2i4J2ckJx3k0NNuLie0WI/1eJTRjR5LZCAwrG7UmW6JbrJBKmCR11lcgO2
         ktAiDq2BILdhg8QZe0tW65LCA9xzg9zyDCZVg+aRV0HueP84RXeujijsWbS70ySIQSZ8
         N67qpfQauJBFxcogX7iZCXyXrLeESZ828PRbgF6RZIMvccRMrYxzq8ZxRsyeNfV4Wb8y
         GI/j1bmveiMNiU4KtIeYeFr1XIj5pE2NCLrujGiJ+yzpiKlYI/s+bhvFd2cMH18R9nQP
         +eP74wnkl5Sj583eqa25ynQlVs4Eoyq1oZalSb62MJiUcc0NXxHmUJtfaZvA4z4/JHDn
         SbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781877865; x=1782482665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dr7pb2qrGoLc4fMg2ZX/MSi2bm9L13q6rwf13xxbDLk=;
        b=TL6VSj5wlF864dm4SR1Dd1jOnq4gNBXg/nUbdW/wbtSrLeBWO0tDAPEAKgVPydaIHb
         EAauoxYHY8KOyaIuwRgQc6uvVwTqXw/NlhWOW76lAo9B4RxUhhQIAC+DiEPpd94HHR3p
         kvKe/QXDWEQUImKg95C2nQLTS6Fy8RRWLnH0IsSyvA1hykt1k+IAujEuh+HihiS+jYlG
         4eHOSjSzOPHpBPzlrbVQrQKfoomqYV9po3knrKtmfilSb3Zabo3V7bC2K5pT75U62PO6
         N0mdvR0190LpW2N57buL2SWrLWbrpM1sDQjCvJH2EgmP+6yTnw64EJgzUV5Fo8YSuWvC
         fIFw==
X-Gm-Message-State: AOJu0Yxr6aW2k6I5xkrY5gZjnsjydyYGx5D+/UuZwT1aHuXp09kv6KUl
	8thTAdCcF12beq1sxnKRQP/hHaMSqTZG0/N95rBhs6xgElicj0UvCXR9ntO+2aQFzdw=
X-Gm-Gg: AfdE7cld6Mhs/wZkL4h556c/ys0hweZVYu/FZCJF6aIlZaUq8GP0xITwsHRZN13kO7V
	q0L8TcrRgPKqpOZQsXfKRua7uTtmjNHTZbwawC8NqWh2xPErChJSrM0ZJ3hOgqTjE0xEMAnKNKw
	fW+TMyQDHn8F3tJFXkzqp4Foh5E+xpXS4WiWb4CHIqJoTIhnayMF6kpP7y9iwdx3tDEvjid9pJO
	5PsnWHzIzk8WfUSp73ryM2tyqZB4bCuCDF1l3/tQ62+wEl+Q/Gy4TWv+BTSBmkSS1IymRaC1+c1
	+Nx6xrUH/TUnWIDhQXpk33e3QeKuXbG8PTRlDc9paSoF69bkm2IzWTzTiSRomN26FK+Od1VD53q
	9LbgCFuDlBcAHA9N/bghl0Uw5D9q2SvuXluTtUEW4DOR8Yw/9HBHQM8eSwvsgyFqyx+slEu1fqO
	HwFnnbp0jjIzEbtkflM2IrS96yJhboW4GdegtIqVu5MTrb4MIwIUQfln74TWqFoLstxkJz9T3KE
	Wlq55RATrFvnzXWWv6j77fwsRiG3Qgl/87H5Ye/RQX1dYfA6n9T9/f7vNtYSoF+e9C9LlVdb3No
	QW5i/Q==
X-Received: by 2002:a05:690c:3602:b0:7e8:769:8094 with SMTP id 00721157ae682-801766c5dedmr20947347b3.23.1781877864789;
        Fri, 19 Jun 2026 07:04:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8011a1e0c64sm12105117b3.14.2026.06.19.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:04:24 -0700 (PDT)
Date: Fri, 19 Jun 2026 10:04:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4216: fix no-op test that breaks TAP output
Message-ID: <ajVMZpjTKiXc7TRe@nand.local>
References: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>

Hi Patrick,

A couple of thanks are owed: one to Todd for reporting this issue in the
first place, another to Peff for analyizing why it didn't appear broken
before, and a third for you for proposing a patch to fix it.

If you choose to delete this piece of test infrastructure entirely (I
think that there is an alternative direction that I would prefer, but
see below for more on why), I think the patch you wrote below is OK.

But...

On Fri, Jun 19, 2026 at 09:20:20AM +0200, Patrick Steinhardt wrote:
> In t4216 we have have a prerequisite that is active in case the system's
> `char` type is signed by default. This prerequisite isn't really used by
> anything though: while it is used to guard one of our tests, that
> specific test is essentially a no-op. So all this infrastructure does is
> to provide some debugging hint to a reader that pays a lot of attention.

I don't think that this is guarding nothing, but I agree that the test
as written is strange. As I recall, this was to sanity check the v1
Bloom values, but allow failures on platforms where the `char` type is
unsigned by default.

I don't feel that strongly about whether or not we check the exact
value of the filter, but I think there are a couple of arguments in
favor of doing so. Most compelling would be that we know that our
murmur3 implementation is correct (in at least one case) and that we
don't regress that case in the future. We do have these checks for v2
changed-path Bloom filters where the signed-ness of `char` is
irrelevant.

> Besides that, the way we set up the prerequisite also results in broken
> TAP output on systems where `char` is unsigned by default: we use
> `test_cmp()` to diff two files outside of of any test body, and if the
> files differ we enable the prerequisite. If so, the call to `test_cmp()`
> would also print output, and that output is of course not valid TAP
> output.

Given this and the above, I would probably err on the side of
designating this as 'test_lazy_prereq' or otherwise silencing the output
of 'test_cmp' so that this does not taint the TAP output.

Thanks,
Taylor
