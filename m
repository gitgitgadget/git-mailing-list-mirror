Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676511A0BF8
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735559933; cv=none; b=s2iJT3AXtEXjzTd3gUuBsXXZ395mAzPR6bJFb9VGWs0b7bm2ikX1U+h9L9cUnV7wtsf4qcNODnxAOLS7ufVLVJooYlC2fkM7ssrwb3pTSzz6STLqwI+0q4+isH6gs1O4OBax7YSehgR8BS4PCfPHhPE8SznHBZS2QPthgFnmT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735559933; c=relaxed/simple;
	bh=7JL3oW5gaqv3E2y5Jp4x6HJLTl4lEpvAtuB2df9Kmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oopOTbkQ+p8XQbEGt9cN9wWv7EjrKNQb07Xa5dpjJ2/27/EkXhKarqZNC6EHsy4xw/bi5d9onPf3OPrSZZvLzLz6nU8zdYb6wLa/EcwH0gtgNlbWB+0HzuQpv9qQhql443gNdNfkmj/YC0FB0mqgA7OKf5fWvUajNsfMq7Of51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6yZPyZB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6yZPyZB"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaecf50578eso1097171966b.2
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735559930; x=1736164730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB7kwPFS6QFZv4f8NlbLjZLYxA0e+NTOGxNB9w8lG00=;
        b=j6yZPyZBAtMAHflpQwCQCbi+m6AvFPhL9hfaABLAS3gcOpKFYmaBB5bGMwfRkvtaxL
         AE9AIL+Wcet6bhnMG8z57dqz+3LPd1I01GFNwTYY2N1YP0Glte9ITrrpzS5Om/+ZUaVj
         u16tRD+uTeaQRqGGWS9tx0vZ5DX+VQOCAmJ5lHvgg04z/jeJAAKBAGirjkNircrMb2YP
         NiwqQAqO/ZGFejSDjx+IIfBuooKhRgCLzpwfJByLKXXyU2W2ZP3bBxrFhFgd9c0E7vIv
         tbr0dPp2oNTbQ1hEo5g+GpgfSehcGZlMemLD4sbR2R1hh1zteaK67hNJclL2V/AXj2sP
         BgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735559930; x=1736164730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB7kwPFS6QFZv4f8NlbLjZLYxA0e+NTOGxNB9w8lG00=;
        b=Q9UW8YL3qKYrISKBlhwgDKI3LfMLBPzKLuFscQBhJ3vm3irFn2dbngsiLZ33e1mWW2
         O+cGNxcPJMqGKHURfUdTU8r6JlXx94pEGjtAJhb5f0X8kYOi29q2R0zcXT9WFT4mYQ8w
         ZqHMQ5w2aDdZ5F8PvZ89Ge5LkGhFezpbVn9+d7e9yXAG8bh8/p16vy2V/HqoGCAsVkdd
         1FCl9VjzlGgUWj7baIyIFewJy8BTNvXNnakOFisObPqCLiCDatvcUSVR1P5fj+y4LMyc
         9kB83+9DuEjIcEh8LJSnHRnKK40WSPja9yhD+crLPaP/3UlbRWec1CULkHVCQ4MamYhL
         ailw==
X-Forwarded-Encrypted: i=1; AJvYcCXTx2p46bgGLbC+M8SH4ABh2YrMy+eYZlQXzHNh5jtpurpGxWem0FQE81LSGlsSqy6D830=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/d77TiFuS+NsBL/BYS7lW3BoY+YbHi/u8RuRsBUDk+mcnXm+C
	ibBQwaltTsNTUF42acySZ7IiluXaspZfqW/BNn+EZw8wRrHifraCxMJpJjgZvR862s/NUVz5d2H
	hNckhIzQnmgbnCjHaWFC1yXInNe9m4cbVu98=
X-Gm-Gg: ASbGncu20593AbuAvFrfQS/kjYQzngjhRxDNDIpTfo0w84Ng55hct7ocMluzAbHj7QC
	qX3uBuLHLWZcZcZCEzA5WTEm90PwqFTvuD3kTUQ==
X-Google-Smtp-Source: AGHT+IG2WNUez1PM07yD1HRF8ya2fUBQ/qyqVV8g50I4Sjrc9ZUcyKStqX1XyG9BXyW1b7qTPnYaB0FWPfU3BJyshHg=
X-Received: by 2002:a17:907:8689:b0:aa6:8600:24f3 with SMTP id
 a640c23a62f3a-aac2ba3f4dbmr3401960766b.25.1735559929588; Mon, 30 Dec 2024
 03:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
 <CABvF+3ZU=96jQBmGw3eWmAQ4DjCdcm1VT7fHMVz_MxvW2xxPng@mail.gmail.com>
 <CAOLTT8TraRjBObcLotNr7+a9Ap7Fy8VVy7HjHLLWwEB_LvBrUQ@mail.gmail.com> <20241226152347.GA68791@coredump.intra.peff.net>
In-Reply-To: <20241226152347.GA68791@coredump.intra.peff.net>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 30 Dec 2024 19:58:38 +0800
Message-ID: <CAOLTT8R3WRiTcNjYzHdiazK9F0ppC9RG5m+9gyX6KrcTEF6jyw@mail.gmail.com>
Subject: Re: [Possible Bug] --cruft option not work with git gc --prune=now
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> =E4=BA=8E2024=E5=B9=B412=E6=9C=8826=E6=97=A5=E5=
=91=A8=E5=9B=9B 23:23=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Dec 26, 2024 at 02:19:56PM +0800, ZheNing Hu wrote:
>
> > Okay, I know that gc doesn't have an --expire-to parameter,
> > but here I was hoping to use git gc --prune=3Dnow --expire-to=3D<dir>,
> > where expired and unreachable objects would be stored in <dir> for
> > easy recovery in case of repository corruption. Moreover, it's more
> > convenient compared to using git repack + git prune
> > (isn't a single gc command much simpler? Plus, most users are
> > likely familiar with gc rather than repack and prune).
>
> I don't think there is any reason that gc _can't_ support --expire-to as
> you want. But any patch to do so would have to adjust how it calls
> git-repack.
>
> Up until now, "--prune=3Dnow" meant it was fine to run "repack -ad", sinc=
e
> that would just discard any unreachable packed objects without further
> consideration.  If we're keeping any objects, then we have to tell
> repack what to do with them (which traditionally was just passing
> --unpack-unreachable, but these days can include --cruft).
>
> With --expire-to, that logic wouldn't be valid anymore; even if we are
> expiring all objects, we still might want to tell repack where to put
> the expired ones. So I think you'd want to adjust the if/else in
> add_repack_all_option() to pass --cruft, etc, when you see --expire-to
> (but still continue to "repack -ad" otherwise to keep the traditional
> "git gc --prune=3Dnow" as cheap as possible).
>

You're right. Only when using `--cruft` and `--expire-to=3D<dir>` in git-gc=
,
the behavior of `--prune=3Dnow` should change: it should pass
`--cruft-expiration=3Dnow` to repack instead of passing `-a`.

I will cc you in the patch for supporting --expired-to=3D<dir> in git
gc. Thank you :)

> -Peff

--
ZheNing Hu
