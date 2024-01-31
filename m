Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DF12DD8E
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723099; cv=none; b=ZrlPgKUOynbsdz3JW/8x9VLfITfDO/l2/SklOA39SwZg6Q+qBsSiss2K+rCRPSRHuINnQ9gCCdnDMWIprWsPEN3Ok44Fjk7/d0kSkrkpt+RT0fLTpVRpGilDgAxrmZE2tLndPUQzFUta6NujATTmFtTCmnEUhY2CxgfRCZXh5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723099; c=relaxed/simple;
	bh=OdEIDTLKJRrvy6oY0Q563I1gGpVCLhI3rfPcZqlLKkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVGMWwAiHDCeSx32eYrZwOtWysRjkLwZcY6cYRWViRYAd2e6wnoRe2KAFpOVjrfeJ/W4X7OTrMS4On5uZdVJZWO+lk9s1u4ftHNvDmrVUEPE8vMXlQTHOIa/AmM4CEBNPUXt5yk19a9pkqVf+ET+wbuYGqDeQSE0hHLjrkjOjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c427136b0so228576d6.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 09:44:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723096; x=1707327896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMM7i/97hhYCHZfbFMyoSW6axIrQDFdNsUNNaZ+c7wE=;
        b=P6aK6E3ekhvd+BT4lGOdSQsxhK83wpOLc47b8JPA60jvRWbn8wvJXkYanGvkG5YY+9
         BPPxmBkGmi/hyjvrBHWg0Xo+ay9JxRbDk4/IzSqXiVq2ixfvsSZWFOmxArsY3C3rLflO
         Zkvus70VguA5Yvvt92TjAPwV/SmaaIeJJhO1uC2giUI155ftltprIXQrzi0WAuyGpvpB
         z+UWz1gH6eqtAo85X43mRyRxnUMwws8jFgtY/TjSnDUGBPxrbUl8up3HRV+iBSP83c57
         vdPc+tGFSRBKRRZu55SEakeqr+UdAI7FwBU/zvuQGAC5PCizxVr1zjXjZVpNW1ZEs3IQ
         zPAw==
X-Gm-Message-State: AOJu0YwggpbmQ2JazbMfUF6s34eff8mNkBRZ7lHH8tomIQgT5bHbEK+c
	yWlnA9bdUgWG///2DL87B4mk3JB/C3b3CKZS1+f9sucqRzMwonmYZgA6ztzj+SOc9rwT8j5sI50
	Nzb+AQKeXPCOJ5aCedMO2GREfEf6x+pNKcYU=
X-Google-Smtp-Source: AGHT+IF5wCztS4w0sdyC8pxp9Qr2xMsM03ZAU9HAr4y9O2Yv/m556g5OfaU+/aKmOGfG/JkJGOjG8XCGDBjb6fuEkwE=
X-Received: by 2002:a05:6214:20e9:b0:68c:47cd:fa80 with SMTP id
 9-20020a05621420e900b0068c47cdfa80mr1956600qvk.27.1706723095988; Wed, 31 Jan
 2024 09:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706687982.git.ps@pks.im> <0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
In-Reply-To: <0597e6944a1a65720d050f47bc82766d5bcf860b.1706687982.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 31 Jan 2024 12:44:44 -0500
Message-ID: <CAPig+cQ1gKt2jgmtxJErCCE_C-_Ne7VnqxWj4CtOPWE-Xf6_iw@mail.gmail.com>
Subject: Re: [PATCH 1/9] reftable: introduce macros to grow arrays
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> Throughout the reftable library we have many cases where we need to grow
> arrays. In order to avoid too many reallocations, we roughly double the
> capacity of the array on each iteration. The resulting code pattern is
> thus duplicated across many sites.
>
> We have similar patterns in our main codebase, which is why we have
> eventually introduced an `ALLOC_GROW()` macro to abstract it away and
> avoid some code duplication. We cannot easily reuse this macro here
> though because `ALLOC_GROW()` uses `REALLOC_ARRAY()`, which in turn will
> call realloc(3P) to grow the array. The reftable code is structured as a
> library though (even if the boundaries are fuzzy), and one property this
> brings with it is that it is possible to plug in your own allocators. So
> instead of using realloc(3P), we need to use `reftable_realloc()` that
> knows to use the user-provided implementation.
>
> So let's introduce two new macros `REFTABLE_REALLOC_ARRAY()` and
> `REFTABLE_ALLOC_GROW()` that mirror what we do in our main codebase,
> with two modifications:
>
>   - They use `reftable_realloc()`, as explained above.
>
>   - They use a different growth factor of `2 * cap + 1` instead of `(cap
>     + 16) * 3 / 2`.
>
> The second change is because we know a bit more about the allocation
> patterns in the reftable library. For In most cases, we end up only havin=
g a

s/For In/In/

> single item in the array, so the initial capacity that our global growth
> factor uses (which is 24), significantly overallocates in a lot of code

Perhaps? s/overallocates/over-allocates/

> paths. This effect is indeed measurable:
>   [...]
>
> Convert the reftable library to use these new macros.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

(Neither above comment is worth a reroll.)
