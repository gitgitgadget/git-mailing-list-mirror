Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA622FE18
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951187; cv=none; b=amdijuwe97k+Ye9RpIhMjF1xyA3Hd2RDmIi07kjbKI0ljcWl786eS3N1BA8gWnSytWt/uwGMU6qUgdB0I1HjdRX7nYOBcHCQDddBsT2LDSald184wrdGbIijiWklcE85ObBbVIlk474EHZvdC5F9O3221dpLI2NJazgPmqYESDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951187; c=relaxed/simple;
	bh=Fi5uu+Fs0CPFYbGpzS4hZXHKvS4DoOCGE9Ay7w1NRFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZ7dVQW4nyeEn33aL8geYd/dqhwOagBqJqDUk+4XJdFQzfK0qHZKKSI4uxdP720PSNWkHbOQ/2b2KhfkKM8VjsJxLvqn1CkdR4n/wJmKTW9wFsWExotO/GF8avgtWEgP7rvXJxblgtPXlSMJ4yH+Xvzv3U7O6186SQSzGTfQvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcWKqo23; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcWKqo23"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7db6aaef22so4227352276.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 04:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748951185; x=1749555985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONFKaNMe0LEt+Q9lPpY3/c53kGLWT/m+f3PxJXWtgcg=;
        b=mcWKqo230SQ3BZpxHMyRgyvOkDoY602eR8tEqg0OoK03fpv3IvEhS481GJciZitKcO
         SAzhwfw98O6HiB2pfT2tT5ZYs26ON67EAgSKTziU9EGs/KP1op5oXM9odfy7w6TeYOOJ
         LZ5097JyZ4hmK/BkCImkP58WS6DlwLFE868U4bZUHveEzkpY2eu8q+/tTPjxc6c8hPMN
         ub4tvUoyNqY5ZbtoF4Sb2q8T++DUJHPMf4mqUsYom82QMC23p448it0RdezozoJXpcPk
         QGWWkvSIrF478VM/lNvf1TKf6hIzvRrvkR0yuR6vtAG8y5/xCiXnxwWWY7Dyu/23wev1
         +0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748951185; x=1749555985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONFKaNMe0LEt+Q9lPpY3/c53kGLWT/m+f3PxJXWtgcg=;
        b=kglgK+dHDhaBjkibrzTp+B8DmbJ5d32ZvkEsO7Q3qaY8wUL/2ucle+GHo5OsPPgcaf
         WmQWlBcP2qUWrzXBEIWzWDeyEi1hrhSjqq53u0YsW/ZXx14XKLEJd0kUxqJVmo/ZtDHd
         iunP033MphfNEJR9AoVp2EsDFGYnnTzc+CDh5xmhmPwTpvyPNfdIdEAVLWUJ2LosyZ5B
         l/7Kaa2d5ladoOhDWv8iDsMIRRm3jZrUH/Xla0StrK8NJdH/jGIXbvoaVL/s1WYVJ29L
         NuFn2AfEyXTIQhOgrWgPgXouXoTm2bLvzpcNbM3DjEHsSMjRAPPKQgwWaBnibspV+djJ
         tv8w==
X-Gm-Message-State: AOJu0YwB7ld7umXYbGFWYqnM6qoOE5QIOYwG4ucN/cG3YqYUaOQ8CPha
	FxAZCaOLpaNkITY5f2UyJkkNCxj7iEC+a5z5XNiVffSWw49YDoaZeMphJ7csM0nq4BhuqeznP3u
	HA+tFsfaiC/XqkFdNqqiWV0jW1tCPQdRvkp3slJo=
X-Gm-Gg: ASbGncs7eE3qoTyt1x5vjLCdqKYhjCc1vNlJNmyyCZ9pOu67GbyIRJ+KrG+4DM87szJ
	mZMJdXXDpz+hbTbXZHXMqB1KLj2IcNOmgAv6gNyFovrp25/dvsiY398mNhcmQojjpMCIlaxviav
	HkYsi7LZrwVHKn4awBwbmLwHnjcZGhQpUjTErtcZPH5RNn9wiheVtA8NI=
X-Google-Smtp-Source: AGHT+IFdK5f4Jb/DBHFd7aYa47F0DK4EgLfVYMKyWS2uw5Zx+fLXKzKOj7TNtc4z9yoEjOreSsRIcofVyF3RYx3iVUA=
X-Received: by 2002:a81:fe01:0:b0:710:c8bf:9929 with SMTP id
 00721157ae682-710c8bf9c99mr25472727b3.34.1748951184613; Tue, 03 Jun 2025
 04:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602122559.208780-1-kuforiji98@gmail.com> <20250602122559.208780-7-kuforiji98@gmail.com>
 <xmqq7c1uszu6.fsf@gitster.g>
In-Reply-To: <xmqq7c1uszu6.fsf@gitster.g>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Tue, 3 Jun 2025 12:46:12 +0100
X-Gm-Features: AX0GCFvlkl1jTcmPOw_s4eSBlXfNizEwt-ZyEBR2hbSfCqn8etXFHQZpP5n8e8Y
Message-ID: <CAGedMtcAYhCGkZ1rtwVCwKjAWHNXkt=2mM8psXmcC5tTHJnYKQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] t/unit-tests: convert reftable table test to use clar
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 20:33, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > diff --git a/Makefile b/Makefile
> > index 3cccc73073..0227fdb3e1 100644
> > --- a/Makefile
> > +++ b/Makefile
> > ...
> > @@ -3972,4 +3972,4 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
> >       $(OBJCOPY) --localize-hidden $^ $@
> >
> >  contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
> > -     $(AR) $(ARFLAGS) $@ $^
> > +     $(AR) $(ARFLAGS) $@ $^
> > \ No newline at end of file
>
> I'll fix this up before pushing this morning's integration result
> out, but here is an occasion for a quick quiz.
>
> Can anybody tell, without running "make <something>", what this
> accidental and unintended change breaks?  It may be rather
> surprising ;-)
>
>
Hi Junio,

I'm guessing this messes with the installation of dependencies, but
I'm not certain.

Thanks,
Seyi
