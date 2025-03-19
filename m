Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEDC207E02
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423183; cv=none; b=J5iKSmyYSWVQPHeirErdaiyrPGKlpDTqfzZEfIx2EuduresekUslrCNGpEjz0mWXLr6nIkiwV0HtT4uePAHjDZBP3e3/1s8uYjudOGjTibxZr4k6r2BWaZKttKdwQ9PZDRh06Lv6ZRByM/HTOXpn/Q78N6wQW2KjH+WRFfVw9yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423183; c=relaxed/simple;
	bh=XK4ebel4UBA+wTLb545FXyojU2oZQGmLgZJy43khIAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0X/GDFX3VqTQb+S+/bACy+uNrygtd/ox5nozsRZBsRo0jNKfyPcbTm66tW3z0VlFxUtY8vBThnn1aMwzSpUyG3atprMgsbOWpqtYfJWITI7tN18U1CVUDAK9KPBZ2Is+gFdbptAduB0aXTDiQYjcZmH5e7nXoZ3kqPEwE0J3tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=o6PBOMM0; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="o6PBOMM0"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c546334bdeso15771685a.2
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742423180; x=1743027980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oOtYB0eJKVePgUg159HTus1ve4+nZDE26EcDIukyOms=;
        b=o6PBOMM0GjF78Bl0Wf6uotrsAMtjkwM042ngDV64YZuzICRbEsXngstwiAtHNUpW4L
         sEjcHgQgCff3js1zuKW3UscvirVg3u9DxN92Ij7l4bCDKvqJw4KOWVrisoEvQr3mG7Q0
         YSteDy497H5CyqRd2nqZVo3KgYzS/SEYOITZmsLUtAupUAzbdRee7g8PCbfNx8qkomcW
         MkMkU0CKmhTU3SCqtETd6ZIawGjaWg69MynoHd0ZMlLY9htTMVSooyvYMHRPHpFMxilo
         ASte51udhNrfoVEWUpRHGVKzQ0MVU1hwhCAj2yW+Jol3GK8MGW25EgQWYENmlZoYzer9
         oLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423180; x=1743027980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOtYB0eJKVePgUg159HTus1ve4+nZDE26EcDIukyOms=;
        b=Brei5z8hAn2zxixywS7aAjDd5kxEK/DqwVzyH9P6t3QvLk+cuMdg072iu8HNqPhEXX
         ls0A5xG5kQ46MinP2K44W0SO2VGxeyRuRG+msj8Q+rBeuP2vGPOPDUnbDvGHcgVp3yyb
         qfoOyHlTrUS5HUIxEfMkpF6gmpK1tnC+YY1VfkGIUtCsjT+Z2pMInpJWkrR7hu9K5p8o
         QYfwvQtKwaYIWw6s8A2QueTqHGLRc0q2KalH4iDXuN1Zf1+rhuFXCg8yISHRkAEqVf9F
         LESAZzwembQH22Ynf6ltEoQwsLYDB0HgnSs6wTT7Ivb/S4Xr/sQa9MFoUeDF+xH3YhiV
         z8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVF27NN7Gpkv8O+6+vz4t/m03/6K9fzZufVojMEi5z4hDTPGZs61YGfhTnqXobFBw+mLQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC6ugt5xSh3s+qE3vJeOwuVL67/He0veFASVE2n0tdkwvBLlV
	JEJfifrp1V5DaX9dcko31Zug0+hPqhB4HjXiX3lhGG+4rD6UOXBpQsO6SOwwoIs=
X-Gm-Gg: ASbGnctvaVv1RosZeeGQ/dbSYHxhD1LqCM4h2pDa3OFil+JgUIglGwac9CIm2i3L3bh
	2XIfFDUySbAr7eTTxQJzrmLzxjaXFFtQIwHl5wetI6LZNnSZu9xsEsnrgwbsRPqEoqKQkv04PW8
	Un15hSicJoNmFpN07J9k46t/7hsw4Flxji+QzFNCuaqk2mJx/SdlWamSNmO3Uza7ohwNKET3gj+
	PIpm2c4ZARc90lHN2qRITL22Uc4ysH4wMr4+ZtFR2+reH8cj5UXPU/Tldftb2aKddUQK3knWdJo
	wuuKS5MA/SSax4+5dDUmO6ql/P6n9nmvFz95gAAa7sNIXKxUgLJhvp8/dHpyw4Y7J3OvcU3TnBM
	6LjJ4Vv7oVKt1lnkd
X-Google-Smtp-Source: AGHT+IGAyRwkb8d3stWhUljKQrg5ApAvF5LVjb8A9wMC93plti90fbhissQgteCeBvJYoWP81uDNQw==
X-Received: by 2002:a05:620a:40ce:b0:7c0:a3bd:a787 with SMTP id af79cd13be357-7c5a838eae9mr611554485a.13.1742423180265;
        Wed, 19 Mar 2025 15:26:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c6fbf0sm912033085a.33.2025.03.19.15.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 15:26:19 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:26:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] ci: add build checking for side-effects in
 assert() calls
Message-ID: <Z9tEilK0OOEBX/JQ@nand.local>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <58cb8f6a1609b10d761e86bdad541d1c018cb582.1742107322.git.gitgitgadget@gmail.com>
 <Z9iinbyrn4PeFmCl@nand.local>
 <CABPp-BHxYec4LBTrhg+Bq9NrpyGXkt8fBgofuy=D3X2ArM6wiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHxYec4LBTrhg+Bq9NrpyGXkt8fBgofuy=D3X2ArM6wiQ@mail.gmail.com>

On Wed, Mar 19, 2025 at 09:21:59AM -0700, Elijah Newren wrote:
> > I wonder if it might be useful to explain this in
> > Documentation/CodingGuidelines as a follow-up to this series. I was
> > thinking of a scenario where someone either writes a side-effecting
> > assert(), or a non-side-effecting one that is too complicated to prove
> > otherwise.
> >
> > If that person runs 'make test' locally, they might not see any
> > failures, but then be surprised when CI fails on the new step. It may be
> > worth mentioning that we have such a check, and that we expect all
> > assert() statements to be side effect-free, and that developers can
> > verify this by ci/check-unsafe-assertions.sh.
>
> The same could be said for coccinelle patches, hdr-check, check-pot,
> fuzz tests, asan/ubsan, GIT_TEST_SPLIT_INDEX, pedantic build, osx, vs.
> windows vs. linux, and perhaps others, which users won't catch on
> 'make test' locally but can result in failed CI builds and aren't
> mentioned in CodingGuidelines.  I usually think of CodingGuidelines as
> being the place for documenting things that can't be tested in an
> automated fashion, and a brief mention that both cross platform and
> additional more thorough but non-default tests can go in
> SubmittingPatches.

Fair enough ;-).

Thanks,
Taylor
