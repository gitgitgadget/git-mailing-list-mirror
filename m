Received: from mail-oi2-f29.google.com (mail-oi2-f29.google.com [74.125.231.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B85477E22
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034594; cv=pass; b=PEYaNlE02Vi7jK5yoXA5qm3sNnfmpyOkmYgkdgu/FeDCK/UeYG9gVcxNGEs4bH82MIy8CJfzQZtxURVF8l6xnrAk973SiqQoem5qJPM2FYAUSZjkpdUARIkfwZfn/FjAx/h5RxLkBy7CqzA/CEDjVI9S8ER/IYAVeDpadV+iy48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034594; c=relaxed/simple;
	bh=SmEJARNVVuy7dBbIvy3HBs49VTQzvoRq7JmMhT/Rhj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vyy22CZXYvNzTvscRLm3RY2XjgNmXtmzLjGDwDSwJ/nU3dHu7Rnlw6tqV3FdvcvIOkZ+kF7tGD4rOtHzglwGP6JJJsmK/1oHKJiAh6v4Gl8SvKQ3LnZ2LSpbtJpxJTOb4lfEAKvjN9FGeKMr6pkybC9DRnBmRl3ai3mJqRu47Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtKPe7XA; arc=pass smtp.client-ip=74.125.231.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtKPe7XA"
Received: by mail-oi2-f29.google.com with SMTP id 46e09a7af769-8144632e066so437841a34.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790034592; cv=none;
        d=google.com; s=arc-20260327;
        b=DNf0l0d7f8123PjTAoFbN4wJJxQ+4kdGuyZi8oPN0GpFu5eaO0LFMi3OsxNEBiuwoS
         7kFjDVMtZTX7Ghvkg+WfglHwXh7LKW/he6NtILbHwwXXbaMbt40NbfK1MJ1h2wETtFFb
         1zUAs8X8gyvFXILjk520wZQze3uz1liEM5nmes+3aLCMzw/SNfJOSmVD2NbJMNhwJ8Mg
         4fcPrxnwdsyLHAdeNRcDwBeoeoiXC1gy1DEWQ5e6XRVsbX8BqnlFb7jovrRNRWz3HWrd
         hqPpJ1mXlG57jabLvN+GP3e7jnNBUAGfmfGuoNxyU4JAyBJ0/QjZpH7qt2yMEf5jVHeH
         EXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nFyt0ZjMvlZZQENHQApMuQI5921FXMiXO5ScQStWCEo=;
        fh=TKbqSx7BNcDF7NoaLKhy3nLXGdJ4sxL1HMtlq5mBFXU=;
        b=MlrSR/rPgeKkMxBa9C3bR958gwZNX5g0nn70TzrVhoQri6uprEmtxkqRrqtGXdvXvU
         pO1Ow9VFq0jTJsd5bbiflOKxC/5Ex5MxR83cPHb35HIsp0hs0Xt4uby7UnxZdXxj+LZM
         BXKDYbQ/l27V/3prSiLFEI604pjdAXjjt+GMp1SDeEnY4JgJR895VFhSJ1BJQFkN8SPA
         j3ZhU4qPn9rmAIVJ+JjGasU+RRXtu9ePAVEgYEGrsr0F+QajxS7RLg/LLw+zrZS4JWLn
         TbrQQAkDIKUQfiJG3afucTqM1e47TARSVPHwzT7FbwYuCU8rkDEeEpJCPmjRx768Uo1y
         D3Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790034592; x=1790639392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nFyt0ZjMvlZZQENHQApMuQI5921FXMiXO5ScQStWCEo=;
        b=LtKPe7XAi7sGEaK+fgnSP3okIxvqN/OJPUUt1S221R4Rvn4ieWUc6ZqN3wFPiyld2a
         QOhbbHmO8quPOUU6e/Zoe2kUZAJbGjyLxq+9sf3ufb/ZnL9SXo4fmgRUmZENhvAWcfJj
         Fu0vUNkZBjr5HW1LT6Nx+cOCXrrZ9QZ2oQrHMkLipR9JFBqlswTlvBcY665dQmv9iJFC
         UEqmaL4fS/hIsNRkZaZ4F0aGwFE9wUAw144gUSiNxYGeNVaRlRfKb6bzpMqcGw2FvPMt
         Gz1DAuMPKxcoEPlNHbbkMMq3+avZrt8rpy2597RBang0ncDahAASRBlVhx36/ld+zVbE
         xhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034592; x=1790639392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nFyt0ZjMvlZZQENHQApMuQI5921FXMiXO5ScQStWCEo=;
        b=sRzcjm63AlZIfSFTNO+ei1sOdXYzEfeCgQhq56yZc3vbFH4+aDLHzdpaEo206oXlRb
         uy/rOw0U6AYjllNc492MThRn50DXc5sxaJFHexOu9TRM+juWRlp+y99mbmYAJ3WTLJoz
         it8rrDn3615WzvQcRAPqD6UhRxJJ/o9glr1C6mxq/CSXZJyvXQPVuSq0rnGAVo6+bt1f
         FlKDzJJtPjspv+TD0cgAcnbHNtSyyMKe2hRge0wtsimR+mSajWIeAuYxo9nPYlpjdJS5
         1/xAkLYMQMHlK65Jlt4/rZiU+8MW2HeyFuIVHrg4kmq1W0Ve3lJY39vUyQayv8IVB+6q
         DGzQ==
X-Gm-Message-State: AFuF++lRNcXN2+DnjKbEEH4opHCL2H3jKZZ04aKhNfIUxsi6tpKFQ4kg
	wN5iZkioUuPpvRDHFFdyWc0HBlevbM4TkJq2kLjL+7rLKViKsg6EGUPv/Fc7zngV6MIlUIe7u5e
	M/JmVx8vMRnJ8KLps6kLwIboTtN5npHY=
X-Gm-Gg: AYBFou2fHsp6ENjSBd9vSSawGVEqPNFTvhTbP/pSHr4xzxyZnlr+ChJPPDkW+WJEycf
	6wAHrmUtHFLrxz9YpbTn+Z3H2bLYJ5zPU+O+h1YpMiqhUnHgWHU/3CHwihfow2KqdaQvPB4ZbL0
	DnQouI2zLSFi+VQyCjzaiaXPy3P9BhWxBhxVUgnFgiwEMEiaCG85lIg80HIG+zDPmIhutmHHrTR
	+ifnE8cUeGnkKTTNzHRcNj2ti7BflrlEnG4/+KK9E67sdoX/kZegsQsX5da112H0kp2SqsuG+SN
	lpN0lmNqwvhaP/lW4ex1adK3JcU3UzPX1kQdPNDvv8gSZ4ZA4S6awB3KFZwHcSIukZhztylk+Rv
	7MrkXvP8k8HA=
X-Received: by 2002:a05:6820:3393:10b0:6ce:7f39:7c32 with SMTP id
 006d021491bc7-6ce7f48cc26mr4328575eaf.80.1790034592106; Mon, 21 Sep 2026
 16:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916042312.35891-1-yqtian668@gmail.com> <20260921062114.14450-1-yqtian668@gmail.com>
 <xmqqwlsemsjt.fsf@gitster.g>
In-Reply-To: <xmqqwlsemsjt.fsf@gitster.g>
From: Yongqiang Tian <yqtian668@gmail.com>
Date: Tue, 22 Sep 2026 09:49:41 +1000
X-Gm-Features: AcwNN1U1mNrRH2MK7buon45OnEbxWiTBBdLhA09HVdJV-y-c-lMmvSastl0bi-I
Message-ID: <CAEs0Zp7M3qtAznHj_0yyab7e0xDLWjd3+Ja1Yr3GfEPJZQr+Vw@mail.gmail.com>
Subject: Re: [PATCH v2] compat/winansi: fix die_lasterr() argument formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

Thank you very much for the suggestion.

> Unless the set-up to test this change needs some special care, we
> usually do not write such a thing in our proposed log message.

Oh, I see. I'll follow this convention. I've moved the build validation
details below the separator in v3.

> I would probably have added a Helped-by:
> to credit j6t, though.

I've added Helped-by trailers for both Johannes Sixt and Ren=C3=A9 Scharfe.
I'm grateful to both for their guidance on this fix.

> Is that a change, meaning v1 was sent without building, linking and
> testing?

Ah, sorry for the confusion. v1 was also compiled with MinGW and checked
with a Win64 probe under Wine. I should have listed the v2 validation
separately rather than under "Changes since v1".

I've sent v3 separately with these message updates and no code changes.

Thank you very much!

Thanks,
Yongqiang

On Tue, 22 Sept 2026 at 03:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Yongqiang Tian <yqtian668@gmail.com> writes:
>
> > During WinANSI initialization, duplicate_handle() reports the handle
> > when DuplicateHandle() fails. die_lasterr() collects the formatting
> > arguments in a va_list, but passes that va_list to die_errno() as an
> > ordinary variadic argument. die_errno() consequently formats part of
> > the va_list representation instead of the supplied handle, producing
> > an incorrect fatal message.
>
> Interesting.
>
> It's a shame that nobody noticed the broken calling sequence since
> the bogosity was first introduced into the codebase at eac14f8909
> (Win32: Thread-safe windows console output, 2012-01-14).
>
> > The helper also converts GetLastError() to errno, losing the exact
> > Windows error code.
> >
> > Remove die_lasterr() and report GetLastError() directly at its four
> > call sites, following the existing Windows diagnostic style. This
> > passes the handle to the formatter correctly and preserves the Windows
> > error code. Keep the existing %li representation of the handle.
>
> OK.
>
> > With MinGW GCC 13, compat/winansi.o builds with DEVELOPER=3D1 and the
> > complete git.exe builds and links.
>
> I am puzzled here.  What's the relevance of these two lines?
>
> Are you telling us that how you have built and tested the patch?
> Unless the set-up to test this change needs some special care, we
> usually do not write such a thing in our proposed log message.
>
> > Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
> > ---
> >
> > Changes since v1:
> > - replace die_lasterr() with direct die() calls;
> > - preserve exact GetLastError() values instead of mapping them to errno=
;
> > - follow the existing Windows diagnostic style and retain %li for the
> >   handle;
>
> Good collaboration.  If I were doing this commit, judging from the
> discussion on v1 iteration, I would probably have added a Helped-by:
> to credit j6t, though.
>
> > - verify compat/winansi.o with DEVELOPER=3D1 and build and link the
> >   complete git.exe with MinGW GCC 13.
>
> Is that a change, meaning v1 was sent without building, linking and
> testing?  Improving on that is a very welcome thing ;-).
>
> >  compat/winansi.c | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
>
> Nice.
>
> > -static void die_lasterr(const char *fmt, ...)
> > -{
> > -     va_list params;
> > -     va_start(params, fmt);
> > -     errno =3D err_win_to_posix(GetLastError());
> > -     die_errno(fmt, params);
> > -     va_end(params);
> > -}
>
> Very good to see this go.
