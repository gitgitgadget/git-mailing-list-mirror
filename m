Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFF224F3
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770839921; cv=pass; b=LdC4Gp28r9GVF/enQE++cp8ExWuJ5o4Dr2d8BYsLJx1Eb7dV5hoUBBBVZfkNf///reygn51b2jzEtQ9rXY2f2EnAM50yuC2htinQGCl8C1VFSwDsjBPIf5pTrCkbI01u2C+50p85jtwlSUmEnvHBWBFvCYDTYUVYpCs8bE2zAhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770839921; c=relaxed/simple;
	bh=mu7hyQ0/Lvh0u+TA67znR9lWqpgeK1lrAC4QRUhkMtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH2yx8px/UukLr2GxD2VOn0SbUpYsaPuuPa6MJk60wMx5HuNYrXB074/e9NOArP+Oz+TY/iHzOI+xho/UdPEm1sWTw9e+VXXUnQwWeHp8tlo6FlkdKah2MoJoSHvutKY6KVggfv64iz4baIwgaLPdsrIu5gmlGOpZXFwXh9+Qic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InJVnnq8; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InJVnnq8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e1837e053so594955a12.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 11:58:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770839919; cv=none;
        d=google.com; s=arc-20240605;
        b=h60NZ7Y8J607qxP8mBS9DQC1dHM9XC6Dy7XSh9sHvfm+tcMoGFtHEXqtzRnopkpNkw
         xpXU+sbaiZvYLUnHmRq5mMGZQhn9Ps8Thc4iEVnXIyjqMk64pUPz1LtUMP9MpKlzZCnX
         vn3lbPyMJsUFAIOB5v6EBk6JhGThyGOXxUxoSHLPWLBzl9Xy27ALTQ7Hk/XrvoaUcbnr
         P2hif8a/x3CehuvXsxLL8B7Yxd7+fQz6C8QSci7wv7hEYNlGOXVhMe4uhHL6oWt0+jHt
         sPEjkuNq7pOY3OeKw6pDQwyybtqd+2VvIo73fbvgAOkv3q3xWIkLhlTjkIRK4SAEZ3ne
         G9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dOgktW5CybeitBlFD6JKaVckHgHDMdixCbbG388zaj8=;
        fh=HEqfs/ctXWyS12qLvtoPt9o77uuH45wbDEFD9xV3i3Q=;
        b=MHrRUbaSxDj3hJ4PrqJ9iAeJ2LLYlgydRiduV/GXACpTOAWOSvZivA1bgVKZ3KSDaj
         6w8aE+u03sSMaJOSk+r+tEeFaR0F+Msi8WaO/NGsU039gXgkabvCJP70djSxvBOsVPZo
         xj9Zkt0+2QU+95btQXLUP7Rd3cY5KnrrU6yKivksPSQaYHOTZlzXtzd4a38I0dHcSM8M
         gVm8POJNe7/7w+yltsfmS2l46TyDxCtJrD80DmnBKGnwDli+QKQPJgzgqqHvHdV8D3z6
         1oJkZPdbzQGXbzRFP5oWMBnKzqAnhgI3gRXPYCFDWORLXHzOK4c7wpYauC5CiIwtdxNX
         v14g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770839919; x=1771444719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOgktW5CybeitBlFD6JKaVckHgHDMdixCbbG388zaj8=;
        b=InJVnnq8SIX6r55FJOB2e8Y9nHij0NurCicqb6W+A3KMa2qJXKPVnyi3aN3yVVdxxj
         cN+4zWduwzwNpB4T4oCWu/r9auYXCoOAvx0x1JzskGKD2OQcJ/nD9QERQf1Ji2NMwVuD
         jxe68GhR+NCjPf42GwCKVZ82oJgTpH/L+gjkRScqPVYj9LkKvaLIWgtKISaqpIQsMYBl
         7a+tc0Lud/5slvLv4dgEknryV2MeXmS4z20HH1akGSm4FKIHk1Q0OoQLSOWzw6KfXhkS
         xCRubnrx5Zt2B8E0v8QaDNNn8R2Jdg4l4bhU0eaGUuJg0GpS5XaDiogNw2uaXnAvJsH3
         R8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770839919; x=1771444719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOgktW5CybeitBlFD6JKaVckHgHDMdixCbbG388zaj8=;
        b=VrXD54SKsJuWJmyDySOmuPOyGvojdaR6Vzo5M4Iknrn+foA9QevLP3JKy95N9YkmEo
         O2kocerQQh9eQ68SX6QUJ4ZZY+O0GPsdJ2/1uKx4y8lFuk5+sl9lJtSzLjY3h/ViZrDt
         mKjA2982iDiHUvUpcBiwmJNN3Z3uHYCo+51S312Z9AR4ZuwdKLcKgj1a8sWvktMpPd6S
         UNjd5H/oeNDp/QLFnpTm3h3jrD2OzstTjLcN9eJsLLL4helpy94NLLav6SXGHaELZzwM
         OQAz2t7o2dBgJQM9eTeKaJtNtHr49UA6sfWcMnbFb0OjZ1/kkXPKwQKk2/bHhQBk040a
         NpgA==
X-Gm-Message-State: AOJu0YwqkXe5icGDKQDGAlizkuNzec85F4efwJvZZsQBdVlhVa/4rSg6
	1Ocqxu+oia/IpkXeuqmwqH7ZIpX7/Y5o/rjAgXiqcPK1vNwuKEkJvcENv+BnLX+skusHEJIjIY5
	eCzCUtirMsnnxnpB/mjJQgT9bAY3R1IU=
X-Gm-Gg: AZuq6aJvgEiu3rt9LLqxBhAUNrk2RJ1eD2sMCMNMp5yIG3R4/qZD9BsOylQFiWoo5eb
	QsucvISyviPqL5GehhL3bEL6VM1/sW4gxlSgutdKV8mOFhbLzJziTuFGbJdhjTLHFRe/kFW307S
	aqXJlh97Y8It4was+9+ylTU0fGc5NAC4PjfWp1ec5ZNz9mgA2LcMeSIt42LCcDpTc8A0Rv6Iy7k
	GUxz8W19yTPEf8NP+5vNEoVc+FA5j4zHvp/XJxvW1iFtgU0WQ+BzNZEQk7WETCn7t5gqQq1shxv
	R3sE6Dc4PkA0JIPNB+fvIJvAVZdiEzYWK25S0WMYdzPzTUInFPOkMD8XW0i+GmdF2XPysow7Pk5
	06w5BuVggLaCb/9M=
X-Received: by 2002:a17:90b:37c4:b0:356:24f0:af0c with SMTP id
 98e67ed59e1d1-3568f3e4f41mr553885a91.17.1770839919200; Wed, 11 Feb 2026
 11:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYn8XKv2hH2HX2xO@pks.im> <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im>
In-Reply-To: <aYwzAt-dugh_acj9@pks.im>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Wed, 11 Feb 2026 14:58:27 -0500
X-Gm-Features: AZwV_QgaCquo8_pEBfK8tj1kJWrvF_fow-RCCg3XqUrfgU2xBpovIY6o5d49d2A
Message-ID: <CALnO6CB2KXUKdJ2nOOGLAe2fxkj+c5yF-f34dao=p6nTAEQwfQ@mail.gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation changes
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Evan Martin <evan.martin@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not totally sure where the discussion ended up (what's actionable
isn't clear to me), but let me respond to at least this bit:

On Wed, Feb 11, 2026 at 2:43=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> > > On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> [snip]
> > Only, things are behaving oddly. For example:
> >
> >     =CE=BB meson setup build2
> >     =CE=BB ninja -C build2
> >
> > works fine, but
> >
> >     =CE=BB ls -l build2/config*
> >     -rw-r--r-- 1 benknoble benknoble 17169  9 f=C3=A9vr. 16:39 build2/c=
onfig-list.h
> >
> > I don't see the dependency file.
>
> > Further, re-building seems to get stuck (I get
> > similar symptoms if I add or remove a relevant config.adoc file, but le=
t's keep
> > it simple for now):
> >
> >     =CE=BB ninja -C build2
> >     ninja: Entering directory `build2'
> >     [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped b=
y meson to set env)
>
> With "stuck" you mean that it doesn't do anything, or that it doesn't
> actually rebuild?

I mean, that's all the output I get, and the build seems unable to
make progress without the depfile present. Maybe I'm misreading the
above output, so let me try again with a different kind of change that
would cause recompilation:

    meson setup build2 && ninja -C build2
    touch git.c
    ninja -C build2

Indeed, this time it definitely works ([6/6] Linking=E2=80=A6), so I'm
_probably_ misinterpreting the output.

> I guess it kind of makes sense that a new file wouldn't trigger a
> rebuild, even though I would have expected a removed one to trigger one.
> After all, the dependency file only tracks the set of _existing_ files
> so that we know when to rebuild, and of course the dependency file only
> gets regenerated in case any of those files changes.

Trying this bit again, yeah, config-list.h doesn't get rebuilt if I do
`touch Documentation/fooconfig.adoc` (I think make would rebuild
though). And I can't tell if that's due to the weird [1/28] output or
due to something else, since I can't "see" if Meson recomputed the
depfile or not; with the depfile gone, it seems like there's nothing
present to tell Meson (ninja) when to rebuild, which is weird to me.
It seems this is expected, but it makes it difficult for me to tell
what's going on here.

After `touch Documentation/config.adoc`, ninja executes 7 steps,
including rebuilding the config-list.h, at which point it also knows
to rebuild after touching "fooconfig.adoc" again. So maybe that's
expected?

FWIW, I ran into this because the staleness in the proposed commit
caused some trouble while bisecting a (spurious-due-to-staleness) test
failure, too. Hopefully with the fix in place I won't need to compile
twice during a bisect, ha
