Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031540D576
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046981; cv=pass; b=mfqwwK3JREFWo5ahDlMW2qtPvjMLK9RKYnbZjccrVM/ab+r5W5D9e7DwU2ENHHtf6e+svXNXO1SkJe/PNcVNXM0uwu+v2qIjyRYf8pMQ3xI5iL/aKGLbeuTjDozy9IyWePi5Jfoisymz75VShz7U2/JjSuFv/kF5TSQYQC6z+ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046981; c=relaxed/simple;
	bh=tOQnJGH42MhWO1n0FNsrJAD10RtAWzshhYtcvoGlf9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1J7eqmYJYkipdpOhRIhum0BabNNXDNKuriQV996xZflimkCuQQDPYDsbIoY7RuJli6tfKJnoLnw3HTYEGqLLtspMjQKQ599sCG+MG5Y7hqoyIRrDv8to6EXVDwQJPY6s72zcLEDEWenpzKCeKWuwa08CIWBpzB8x1X3b7cvPwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9qNDyET; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9qNDyET"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so6519248e87.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 16:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781046978; cv=none;
        d=google.com; s=arc-20240605;
        b=Nr4eWc9SAWmqfjO/1+7mBXg5LacMFyfuIk5xiVP7yS8ltgFKypX/ZLg85LRvc5WzGA
         a2f9oRW0ormjQZY6bNFKG3f03DpDbzqz2XDp3CCK4NZufXv4A9oUry+PODeYU0eK0h3j
         tVo4aAVhKkBQ1fU3P90KyWIRbHiuyvQ7ypSf128VRWlXhp2n6rFQX5hmRtGUejd4XCYL
         pdRiAqJDn9ABSxUf6NkzRL9KmZkVggfKZ7T9ncXS2W5YZ1uOUYKygkxosU9kOTzLv+v3
         CXhvyF3XSW21Mwj7Kn3WUzZM6Zj2cHsTV1PhdZB3rCXESHpWeHklj/HcESjVcR4ZDljh
         3sDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2gweNirFdNhtYL7vzjU8Mj5DPFFyZZcTOmk5s03X8Lk=;
        fh=YgpuNuyQ2If4dFMh3Mnd8EHow64GMoZErSebpaKHzOY=;
        b=HIpZlmGaXRqzgb/P/zacsxiffHdN56UBXLddndS3Z96ZGGhjAwlr2E27LI4EIvhdTP
         pw+JneyE5bVpWA0QZmFDa5IA+fOanrLX6h5InP6wyhIkClIgfuXiGUQrRn2IoFCLd4qM
         ZppSS9ob6vEbK9MoIi0JL3ukZZtrfyyU+curFR55wSahFtJA1184xRTnExsAo03ubjnx
         tlxCwaN8ZRBVhhKXnBIt0uO7cV2iDsi571lg1WDOHq1utVBWtH082y9j29KMoEAVhTGp
         1Qpjmqy7xXiei+t1nl9mmGN6gApRUzTqRj+SgwTY1fqB1X5JITYkHL02ykCRklbBFNkt
         uCvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046978; x=1781651778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gweNirFdNhtYL7vzjU8Mj5DPFFyZZcTOmk5s03X8Lk=;
        b=W9qNDyETftfPrLG0QAaEU3s+Oeuzq9wa4QaAgRKNLrgGnXtEITDSc3XbSWHkVbcVGy
         mx40lQG4uVoFk9OHxeZFL0yigoxp/BFsQ9Bb87lyD9NpXWVvO/PEBz6bfYQ/LaVqa0Y1
         4U5jDIhBL53grA4402VjYEzZkcpsKL7wPttKk6uTg5H4juqzu8TKcP0oc26sW8yBntCv
         r36lGyECR8dCE4PZIISqtbqS274h63iD64II6W/OagDb+ZgTPLqKkkA0QBS7FLKOAU4e
         nYGVvsytamDwILQvKjP9Yrh4cIV0vfScya/qXFTjNdFGU4+Idlvebk/0aQCA94WvEtm7
         nLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046978; x=1781651778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gweNirFdNhtYL7vzjU8Mj5DPFFyZZcTOmk5s03X8Lk=;
        b=nLPP8JhBbqfMGyvkPgRZdMZX9EhyUT69hzcNlIoZFul2ULirqZdktbbKBKAvAH1gjA
         gzl5222k/K/YUZ9Jmo3Zb0IT3mdJJZkjQB/L+Z838QtJc03QiJD4UGnBokInIJylfoHe
         w5YS46y/ao8gGU5swRrGQmuPo/6GlslRRuv6hT/LFpNfml1jE2TF6IRr5W7hY+bkYO1J
         bOcnYiNCoQbMOW78NCJOJ4qV0iFWBwIZUWNYAtJJ9oPrEHCDV43oC9CCsgIskuWj3G0k
         MaTJ+h94RlqRggV4wMoE1fV2giIkPZRLwGfjHNX7QBeqaB4FTO2wivJpBZS+FKekDnTU
         ULgQ==
X-Gm-Message-State: AOJu0YyDYfCrkeBefpiryaERxgDRn8S/HirxQiVtyenYDEFQcH7oNbPj
	B4Y1N+v2LRBn5nMP7D0yBxL4/VTBGv6DE3P+6UeqnA45cgfKVu0pootOhIS+aSXUv3N8rVMfheB
	u6wP9Q3qKyrn9R01Y8zoUkeHCe95bQtNp6/loOtc=
X-Gm-Gg: Acq92OHWDwgsLEvrKeCZGZVQkxUFGXPM5mjLgoj7fjXtdfU9ANyTqhDwux4e6B7PKZC
	pVQwJw58nk2O+HU+yANA+Q9Ip6RL9QaAMEf7X8TfIOxmB/YzDJnzj9bEz+EAdKuiHho+W/HFXoB
	fqpWqokUYHGJBHf3PhsJUKj5M3Stpyr3+hA5cYTiBIxCuYpwrhDHi6WIgsJ4M+9xAZaM04J1sQv
	q19E/BupiPowJRiD2X2V8PiN89102rwLWdPGbC52et/QiXfogxsu0dMBd/QclQQG7RmDiyWYERh
	6MEOQr04weabEOpFYSkpnVCvC8XSjBxZ6w4E3BtJYeU3yYJ/Mbvn41vcema/95Fv/h2uYeKafHg
	OcsU/pg/lsNQ/0E+7M5hoCs8fE6Fsyt1d19ZJ
X-Received: by 2002:a05:6512:1114:b0:5a8:8222:7fc9 with SMTP id
 2adb3069b0e04-5aa87ba35c2mr5629682e87.13.1781046977988; Tue, 09 Jun 2026
 16:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com> <20260609104119.GA1509396@coredump.intra.peff.net>
In-Reply-To: <20260609104119.GA1509396@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 9 Jun 2026 16:15:41 -0700
X-Gm-Features: AVVi8CdryDxes8uqTG3TH2dir48Z97culgNl7w3trkYn6UaL5PdYu3n0Ood4c_g
Message-ID: <CAJ-ks9mJk-=xp1hW77hAoZwwQAfpMukYO8OvvkLx646-2Z3_kg@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:41=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:37:15PM -0700, Tamir Duberstein wrote:
>
> > +             /*
> > +              * match_pathspec() is linear in pathspec.nr, so prefilte=
r only
> > +              * the single-pathspec case. Only entries shown by show_c=
e()
> > +              * satisfy --error-unmatch.
> > +              */
> > +             if (pathspec.nr =3D=3D 1 &&
> > +                 !match_pathspec(repo->index, &pathspec, fullname.buf,
> > +                                 fullname.len, max_prefix_len, NULL,
> > +                                 S_ISDIR(ce->ce_mode) ||
> > +                                 S_ISGITLINK(ce->ce_mode)))
> > +                     continue;
>
> This feels...kind of arbitrary, no? Surely it's also faster with
> pathspec.nr =3D=3D 2, and so on up to some nr closer to the size of the
> total index. It feels weird to be making an arbitrary cutoff based on
> pathspec performance in calling code like this.
>
> It is not wrong, per se, as you are optimizing your case without trying
> to hurt any others. But what do we do when somebody profiles it and
> comes along trying to bump the number to 2, or 10?
>
> I dunno.

Yeah, absolutely it's arbitrary. The simplest answer is that others
are welcome to bump this, provided they make the case for it.
