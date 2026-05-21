Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD837F8D5
	for <git@vger.kernel.org>; Thu, 21 May 2026 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359123; cv=pass; b=cFWwkhrwrUAU1/T7jg0ZuDbHpi/p+LZpONx1cZifzdUgAPZCRNB132XtH7bgOhI8C3l6oZyCgI995ACGIy5oWVIAqr6iYcqKHRkuDYKK4/kCMZWFzR2A6pfEVVlrj7PKKD9lAdIw39lL2ucK2+nI4rkz4/OF970n5Yb8wNlkg0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359123; c=relaxed/simple;
	bh=UL7RaEAVnhhbYxuEbI4ps5EOmPEyP9dWMyF9Vsv3xE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbBfBopHww0w7klJXghFugfB6Xh0jneoQYxvnpeStjoLSqAdNZi8NRlx0zmoAAlyDwYYFxoKwVusjRbUPxlk7uFdnyhHygfFC14YRxkD1e5Pw//APO4e15VC2KIihWOAGdxhKPQvdX2C8lEZHbBApUGPTB8mImTStDFVFahRbrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFJFRXre; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFJFRXre"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso9457545a12.3
        for <git@vger.kernel.org>; Thu, 21 May 2026 03:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779359120; cv=none;
        d=google.com; s=arc-20240605;
        b=aX3rsis7SegMnRnBiMPshJzBDBtnkYN6QuKxHLaXNyFJjsdBHP0O87XqngAgwIRjnm
         q8KmlLIpK5j7EKHA3ZU1BzQ90M5jiu9+vmTtLmMyfQ6z1DqzziEvc79/SmaYmzquPreK
         2VttweVfIpxMMnvzo+t6MJLmWUP7mlAyBH4roj4CiAuLb0f4ujEgEVCwwUQqQsx81ypl
         VBTgvQFzwqcipjr1MFEsL1pevgppeY6Lmjcpt7yzIQaoAiRqfOLbWbT9cwGkz0BSpJHn
         4i2hN64VoGpD3lyycTtpBsf65Svv9cZZvtn/fOizVW/SFbaRQop6eBl5AUOqKe9LGve6
         7YmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNNCbu0R/rcYJMKFI8/ZZHJvM8GHX7h8ZHDo4uBKW6A=;
        fh=HYObPq293bJ9dUdAAjd2A04iLft1ADAaCvOhDTeSDes=;
        b=kNrv+8zjgvh6hjXNwZCnb/vGAwkVVSwk3UgBK75glPe3sdfDKdpycYdjaE+elI9CZm
         Hl074BwsYKDCV3oshTnc2bB5SQHWbS0MpV5WFPloFpywfp6WQsFNruWVfDvto7t7RYT3
         cxIlF1U/VSMtTyndHaagYjupx84j8ZpMefm88T/3/iOhG2yp6dRYaO+Y1v5Gmrqa9AxQ
         ufKjnnTW48rR/RdW1mDZB+e7i0IDKRj1st1+31hM0/GnbojMSQy4NfhQR78ebjYy9tGD
         a1eW+Avs3ft/5HqjM4y6PJE9UJjOJIKbVXKQXg7KLGUGPBHHZVrBNmDcS8bhehkamExd
         Q2DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779359120; x=1779963920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNNCbu0R/rcYJMKFI8/ZZHJvM8GHX7h8ZHDo4uBKW6A=;
        b=WFJFRXreUXLFQUF8qfYtLWsSQOajoQg0xdBRKJlI5p2Ao2xhElgAvm4anp80AxemL7
         vYDm72rGKPO2bUAAtuNNwvgK80WYT6eiVz/CuO05/5+T9S5y80Q4Mu1N9KluJuf37WAT
         logQoSX0wRq4KkZgYj07UG+5qj5vpndKVpfyeiojPMNK7wci13n9UETSuQrMU8T0UJ5D
         zfzW0Tz90TWaQGzsyHxlinY2vBnFV2ss8rd7VTJSnxO5+xol2c6ZjVQoh5p56ZoiyKie
         wGYch28UsF/DbBiaOpu6aKj2BIgJ+zRojU9InoPqT9fuK76B54bO0AtNtSC4AC/TVDCx
         Hn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779359120; x=1779963920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNNCbu0R/rcYJMKFI8/ZZHJvM8GHX7h8ZHDo4uBKW6A=;
        b=iZ4tALZPDKbgGdW3bCzBL5h4ks9hZPlaDrlwmY2/cNkFEYenv21ZBA975Z2taapOak
         X0qjstWyZcDxnB3fA9LUGoHc7m2zxCOYZUiJ9UpjVVeXJR2jtonrZqBwhMH1US9KQKBz
         ixnFnxh4e/3MCh0KRGoixa9akU+Ks5x/nwppOA8P0FpH2MQAq7jdi1einzi6QVHge9vv
         X9v9X2JnTza3Ch2D0e/XYsLccwEElfNlUc1Lz+l5N83hQb/QXI1WAaZUJSaUq5SZJgfp
         5bwXaJssmRiqA0Q7ZhfVAqgbohqd7ovT7KyIIu49e52aC3leknK5r3WLSSwLG88oiHYP
         XgQw==
X-Forwarded-Encrypted: i=1; AFNElJ+laAnnzwD5+Y5570rNa+nGS3PFlyjTG0EY6/jIkKZJ8+GHz3OvWtKv4HIAG2Wz+uzh6wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUS7Ope4vxwyPasH3pZVzKGFxLnyXE614E5aX555eZFPF4Beg
	kEPyXKg4JYVZo4kHwNgkK27/CcYaO7ToD1ol/VGuMA4xsb3BM89Q+MjLD48bu76+C+LCDnxJoFv
	1fU5MTSipgwfOcixsBWlHs6XE+cvYfII=
X-Gm-Gg: Acq92OGTMk9S8ngfWbtG5Vrmuxs6XUOleKVqAs/L/8NXabSMj3h5QfjyP/vJAUbTJPf
	378Tp5s7qbflkySG4c3pEYj+OVT18lhSBShf4vQkAspK7dPP+/tai21/+GCIkgHrWTVJ47HP4CI
	iL7gHyntlOfxbQBatGbfB6quX+soV4oaR9XT7AAbJsspTctNGR4fqg/U+w7t5v0qAAi8l0/9qnG
	zFyMDYv1lsb+HPy9AXi2pntgxO8aa8YbVfssX02skxuXuIdMWZhvDmI1jdzWl+crZM4ZgJUaOs8
	wt/9/qA=
X-Received: by 2002:a17:907:160f:b0:bd4:d0f2:679e with SMTP id
 a640c23a62f3a-bdc14376954mr132869666b.33.1779359120247; Thu, 21 May 2026
 03:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
 <xmqq1pf77kml.fsf@gitster.g> <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
In-Reply-To: <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 21 May 2026 12:24:43 +0200
X-Gm-Features: AVHnY4JD7jn7eEv3C4aCnZq17aTW_nWndd6Au0vCWNmLpXFQrmxpzZ3zaU006Os
Message-ID: <CAHwyqnWeqQEoTM=pum0_Ui6+=cXdxFJgWEWxNWoFpFo8xaW8eg@mail.gmail.com>
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Interesting idea! I will think about it.


Harald

On Thu, May 21, 2026 at 11:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> On 19/05/2026 11:34, Junio C Hamano wrote:
> > "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>      checkout: --track=3Dfetch
> >>
> >>       * Find the right remote by checking which remote's fetch refspec=
 maps
> >>         to the user's start-point, instead of assuming the start-point=
 begins
> >>         with the remote's name. This fixes cases where the user has a =
custom
> >>         refspec mapping into a namespace whose name differs from the r=
emote
> >>         (e.g. fetching from origin into refs/remotes/upstream/*).
> >
> > This comment is even before looking at the patch text.  After
> > getting one issue pointed out, I'd expect you to think about related
> > issues before sending a new round out.
> >
> > One.  Have you considered the case where the remote-tracking refs
> > are overlapping, e.g., where "origin" and "upstream" point at
> > different URLs but they both store in "refs/remotes/upstream/*"?
> > Perhaps their URLs may textually be different but are pointing
> > logically at the same place (e.g., one ssh:// the other https:// for
> > example).
> >
> > What should happen?  What does happen after you apply this patch?
>
> It would be worth looking at what "git checkout --track" does in that
> case and seeing if we can share the code.
>
> Thanks
>
> Phillip
>
> >
> >>       * For a bare namespace name, follow <namespace>/HEAD first to fi=
gure
> >>         out which branch to fetch.
> >
> > What should happen if HEAD does not exist?  What does happen after
> > you apply this patch?
> >
> > Thanks.
> >
>
