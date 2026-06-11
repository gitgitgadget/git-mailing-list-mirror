Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E083D0919
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191080; cv=pass; b=Br8nBJ8gMrEXfZbL7IlGhkbMct+c6OJDqw4P6O5QE1w2fzSI+uFJ72Oklr1UgnD+yTz3sFbcI6g/U5vgcPYiHc0/cYO+hXcPWIJNOK/vH5SFaGQGbML+gT0OnF2fIHmCFGS2z7U/fs78VJsUesq7W0ABveiQjptCPM8z+RVR8x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191080; c=relaxed/simple;
	bh=ZIfjj8yX/p6L/y7HmJbBZhdaKRkHp7sTDdh3kc1Nld0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkXY2Uwxk3NjzQKtlVg6pKcUbWlxgwjXdlo3AgfaderzKQW32fkFpe6wN7s1btHHuigusMt+QwlIuzsBlixjBY44B5qSi+msid6xM0gA23YEZ+7crffuRzwN3XeKS0Or77gOI3eSjCJwvq3lf8YC/hUb3OMOcivl5Oxy/i3V+Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqLK9Y6A; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqLK9Y6A"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39677242021so80124321fa.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 08:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781191077; cv=none;
        d=google.com; s=arc-20240605;
        b=Sd9JR/EvvmQXE/VXYEzQX7g/xDrFZPK4MKgJH4E85Vm5zerEVYOjZ1wXnR8hDwm0xF
         wylXL6gIvCLW8znt6zgVIU9dUM9wG7JeTCftl3M2NNQ+VstXN+pFTf2NJGUeoeD3mdEi
         LDpp5RtJfOlhKhUhVu86nMMAO8KWWe40iN4cBeJQOkL4ujxRvToF2UCblFOdZuMZh/VV
         3ALi7MGetUt6k+/K7GQ6+9ATrp3BFMmm5rpkBXVtu9oB4PnLQlRM1QWef2MU10e3tRAq
         9YE/GQH8avwvm4CJ8YlzBPXCZN2CVj0CH94Zvp3uCdUP35ivuHe5mEOA2Pt8doIytaKL
         iz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D+CucYzB61dx594osTE0OyQzPdYNqh1V50AkwfGUfOE=;
        fh=YgpuNuyQ2If4dFMh3Mnd8EHow64GMoZErSebpaKHzOY=;
        b=RQmKyhTOGWqiwGupPj/+Fd1WQDoz+cUTEILnmv3hQWsYAncr1CByn63vCTGimZMW1Q
         tl/kT3mzn+5GvCc3WZQzHYFfc+X7SBOZY2KoBf0Uf4WBmnNh3q7XMOiMZFaLuyvX9DsL
         JcElYAhmzM7kpPDAImP9joWybA162zh+z1ClDSPdnznGrfX57eN/MzpxNtRXCqlX5P1M
         fEdUVHINYy4AC9vkcCthaWxMhC+W5kayRMPvs9Hgv56ApxAxCETEt2wESIzBJZRkqZOx
         VPohjlL8Xb+lN7Rdnzsmjw+3Aj3gWBGBnFU56OTAJsRUbxfkGOEIyZvw/Ffh9Vx/FSHv
         +uyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191077; x=1781795877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+CucYzB61dx594osTE0OyQzPdYNqh1V50AkwfGUfOE=;
        b=lqLK9Y6AdBZGYVmsPCYF1MH435g4kIBTMZGhjnHurtNjl47FXzcAyz+sYvmgnRvHL7
         zNlp9qxz4hGXsdzqmIpEFvIh0eODWvKtKP08sHhoHPVLbvgWNyvkeZ2ZarFfzQ6aDhRG
         jL7UnxHuRdsYXQlPohJLQgBOrf0YlS+GKtjwFMfcmxoBdeFD9B+wJrQHwGJDtp2d8XBi
         DdAn7r+ELOjN5hSq0aGtNdkyL4GsXCjVueYFneZohm/v6509UJh+SHs9zdcR/ybrnR7J
         Wv2ZG5jYNULe6hh5Uqwk2KtLnFXtIzdid408dc+Y9busURIvquCvGOJh+oP5dwBf1P1k
         7CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191077; x=1781795877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+CucYzB61dx594osTE0OyQzPdYNqh1V50AkwfGUfOE=;
        b=m9yFABNkbQbBIFoULp77xF9vPGl9osqvCjgZY+gQH5QOAb/RLCRO2da7QSFUKoK1az
         tpaZVPo8nQsxbxnppAZYnY/0EWqfUX14xRokL2jai5qsBfcTu+pG3lWen6CsaDyAlU0b
         rZopBWsdIaaDwtKxdBm4tVsCZ2QQ5xf7LMUEKgD9QYh+1WVFczZC+fdfgx5h6DI55hH5
         A/fR7JNRPY9bF9h7qkE/PGJRQOWnUOhA3U8duzix52535gHUHbCNFIBPYpsN9aSKJypN
         0a/TCpJeCCyNWASNKKCuNPBStjx9UolZ98196wwYwBgDK++ErfjLSlzgoxpXVHtESuSu
         p8/A==
X-Gm-Message-State: AOJu0YxAgvjMPqdDXey2wnwK65KVW/04s14CSgmmASjxs6ODtdXFf7EE
	EzvUejpkAKP4GpHZLVleyOz5y/M+5j9aghfPz72bT8kxMClxZqZShKAOZv5mIdyJkWKtqXWI72q
	+gpcY8oPCueObhjIyrK20N4ikLrYbJISozojC
X-Gm-Gg: Acq92OHOnsHhogFyIjIJIa7B/ZnLaRLRCNsvhnts71EkDqK5IDCOWlAotgpMeNwcZ35
	hMPBtV5ebh0UcqdlYiaMkuUDvsf+1QrnU9z1CiAWbNQ998MawvSnRxR2vWgau9ZKfSicWO83+kI
	ykQlc47dA9jYmA8cJyjyTQnxJuEkq06MQJgdzYZEBIBtj71Zrx9IFaxyQxLDt3/mFAxfjKoVVEk
	wiQQK0za/aPlLAT8CeZWQZuCw0J7ZQV8cHWwcCRp6aaZstqxdivIFr0QW7J/UhbPMjxBOLpAwP8
	2YTyGFgw7p7fo8CBBNRjcpnicovIkLxIz1GMyAviEoC3HtKl+Rbr4jaMhb9+VgMPk4n4lmQs/uY
	h5mNZoEMWw4VIqEx9XY9//yy2S4dD
X-Received: by 2002:a2e:be92:0:b0:396:a4ba:f257 with SMTP id
 38308e7fff4ca-3991a0d32c1mr9240231fa.12.1781191076764; Thu, 11 Jun 2026
 08:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
 <20260609104119.GA1509396@coredump.intra.peff.net> <CAJ-ks9mJk-=xp1hW77hAoZwwQAfpMukYO8OvvkLx646-2Z3_kg@mail.gmail.com>
 <20260611084132.GK2191159@coredump.intra.peff.net>
In-Reply-To: <20260611084132.GK2191159@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 08:17:19 -0700
X-Gm-Features: AVVi8CeuEI6xssbK6jsc-TaHXQA4FpJpyFgS_6jjNEnOYeQeN86J6e9kZJty1B8
Message-ID: <CAJ-ks9kyPxGpBTQP4rBZaUpDYvyah8JpMx4mNPs8UbkddcHwOQ@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:41=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Jun 09, 2026 at 04:15:41PM -0700, Tamir Duberstein wrote:
>
> > On Tue, Jun 9, 2026 at 3:41=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> > >
> > > On Mon, Jun 08, 2026 at 07:37:15PM -0700, Tamir Duberstein wrote:
> > >
> > > > +             /*
> > > > +              * match_pathspec() is linear in pathspec.nr, so pref=
ilter only
> > > > +              * the single-pathspec case. Only entries shown by sh=
ow_ce()
> > > > +              * satisfy --error-unmatch.
> > > > +              */
> > > > +             if (pathspec.nr =3D=3D 1 &&
> > > > +                 !match_pathspec(repo->index, &pathspec, fullname.=
buf,
> > > > +                                 fullname.len, max_prefix_len, NUL=
L,
> > > > +                                 S_ISDIR(ce->ce_mode) ||
> > > > +                                 S_ISGITLINK(ce->ce_mode)))
> > > > +                     continue;
> > >
> > > This feels...kind of arbitrary, no? Surely it's also faster with
> > > pathspec.nr =3D=3D 2, and so on up to some nr closer to the size of t=
he
> > > total index. It feels weird to be making an arbitrary cutoff based on
> > > pathspec performance in calling code like this.
> > >
> > > It is not wrong, per se, as you are optimizing your case without tryi=
ng
> > > to hurt any others. But what do we do when somebody profiles it and
> > > comes along trying to bump the number to 2, or 10?
> > >
> > > I dunno.
> >
> > Yeah, absolutely it's arbitrary. The simplest answer is that others
> > are welcome to bump this, provided they make the case for it.
>
> OK. I can live with, I suppose, but I am tempted to say that it should
> just kick in always (i.e., removing the pathspec.nr check).
>
> Though I did show a case where the performance regresses, it was pretty
> made-up and not something I'd expect in the real world. And you'd see
> that same crappy performance with "git ls-files -- $(git ls-files)",
> without the "-m".  The real solution is making the pathspec code less
> crappy.

Maybe I can find time to look into this -- for now I'll treat this
series as not requiring further work.

Thanks!
Tamir
