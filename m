Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22E59C96A
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792097320; cv=pass; b=VE08XDdkREHWyQFoebJIJWKC9t9ibNJoAYlTHQOP9j3p6mr2/I/1d1bW+J2tXqOtPVbtFK4gFWAQ4AOIu518zL4dVLWfq3r8DPq2qodGZiC9HNVfIIigoKZf3Cu68lJATklvO3F8iRnUArk1h1ZSqoxPdQ7Xuol4TadpIOCyW4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792097320; c=relaxed/simple;
	bh=dEwSuInXDYIXbDR9skcdq6SpBfChsOOblbfIwGKNQZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lD8+JDJg2BZgSKqYd5B6BZiJ7DVrty8CjUO9oUifqU7wVo10ZcZnib2oViy+PkkDnYxRpo8wrfOKTDuThHcRt1spDFSWni+bCr9eKKI5BFR3zGNRqRyJ0jnE5FFOPZZOe88IYWGJZ6pJ3rjnuUzOROiuZN99586UOTR1WcXokM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNjyAK4t; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNjyAK4t"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so2006054a12.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792097316; cv=none;
        d=google.com; s=arc-20260327;
        b=gRx4YAPU2eYlYdZlEhfZ0C0sBZq9f1Q94oP5/IBiWXEtksu+B9P9UWjhWsPYQ89ulh
         RNoCMOgupTLnm/ySWuOy3t0kuKS2QUW5mV2XVu8FGglUAdn0MhXIhIIHo5ui1wiu31VI
         mTGH8MT26rSYbKm6FEg7kLyRLftt+Ek8yalLocisicXqnfYW2I6wdy/ALUXF5pwpT7fF
         JOsbvNOGb7DeEa/oUJkI8P996+spiHlHB/PphzfTIGNuzCPEO/gcW0mjaCxe/jOXSkR5
         G7p/QPu17mlGwWifuF172Dc3KxXNdhGZ4/ATaXm0uGz/iFVmEOiocNtgIKzgTwHHnbvQ
         nn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CsY3dEyFbaqpEQ2QkOjKM5smz608GMWcN2fEwo9wihA=;
        fh=DUOZ9z71QCc19OsP09QOLWrW+5BVCsYT08jQjG2ZFQ8=;
        b=sT5nX4lCO+9vpBQrWd35m7WNNu7RXiL2XXtTUcYvcvo4RSCgDEcDVzZFelmoVB/q8v
         PpRbuaS9Eq3K89rIKZG+rzl2rsK/A03BTuN3yT1z3+onWkRBsm1vDlr8RZYtUwRvpxdX
         9P7SaiKDx3tg6T9Uh53Na8O0itQcwGwLigcSwjHb6J+/Bp13WRBO10T4hTTw3KSl1QSE
         TcKKEGTPcgD9I4CO0lVBgDtNmJpUhCwrEoyz0AUAXjeJvNvOb6tl92k+/eeP1eAKm1yZ
         Uh4sqnsNFtbU1TL8MKaMaAMFSUZOaapIl1y/Z3En+6eqeBolCMTDgbyWA+EMzEtYoXO/
         4tIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792097316; x=1792702116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CsY3dEyFbaqpEQ2QkOjKM5smz608GMWcN2fEwo9wihA=;
        b=fNjyAK4tzkt7HpLOR8823WvJoKeOwm8jpom4siJyjLZZgY2O/zmrgp6ZfPAyZpdK3w
         u+F8oUwrbpCgwjjfmqgkMG7i7hlLdeD2hweun1WiPxkoqBHHVOxZAZLPBKYrPPKRTKKS
         6sMloIuABzVgnXhRwUbca8enqKRbNhj5D2n7/7kRLwkcsraT3lv/zrvsCkz+AgRtNFBT
         xjMZjZWTFLUsc1Lpg0Ps18m+WiU5NtTx6ZD/M78AjDpSELz0S6KLwdxi2tixeuGHh7sY
         5eQeYzEv0t38hx7Y51p20RSjFzUBqf9REqzF1tc90v/PMQ4ybFj3EPuPnxeoTds5B7R0
         R68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792097316; x=1792702116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsY3dEyFbaqpEQ2QkOjKM5smz608GMWcN2fEwo9wihA=;
        b=PnksIYkwepp0zrQtS0DgdxIaPiNz8sU8SpPwRF1ZKspoXWD798rpgCxfMZQ8YAiRFE
         5dcBwYpLkuJqx27Skx1meR3+vjKiO4fQIRHK2YomLCB4NZdrux+Oz8ix0BpcPbgUIkdA
         5w8oFtyWCFOZ3acaRf/gss7pkSXxaHMCCQUwnAhhy/ZrKlDSfhPYmKyhCJ2s9GIajOe+
         A69/rddevfG19YYOX5rse7eGig81QYSFlcCyd/JbEsqVVxBzepvQixmpPyscK4+MHkSl
         O+Vl5oC/lAkr7W92OVwyeAb8+UhTcBvHyClLcvvRPVy/0FUKtA4upKwx653rg139+BUO
         hMAg==
X-Gm-Message-State: AFq9FYJQAH69mVbVSFnFFyviqflV/6ePAvm2Xn5S/HIFO1Lt4YheJNh7
	cAYcRfUlsUP/86UhTGqc6aKZx0NqZq/XGoUQ+mBr0LKJLS0MIBUjl1MKSSBVzfsh6ML8aBI33vH
	rJnOLMYRWHVUihgkrUpv9qLqbmPpT7YM=
X-Gm-Gg: AYBFou2xsRVBaInwhYThduXZrqc+YVJtGONYFdiJePOXEYaF2Ram40cMr1pAHfAt2fP
	lgaxZKksZvLYjaxgpDdQItC9bXFQZ6xTwKsMJzJM5CWkS+w9vp+2Vyd6NPYoJZUA+WmzuYsjjTi
	Z8nZFwE5FX1l1goKpEt3d6DSk/rOBkjG27c2uLxBAgU3sPR26/omIExdAFdoTWtzOnPQCDgUNcv
	NZ0WlZAQJ9LInjgSYu5pPZ8ta39+KXRLp9wX+UqLZoxMDqMChnxF4yyOiomxYGpZAimN835Z6Aw
	jb2Ee38sh2vlM7oY6mkrfuimlEwG9eAf7+cLV/jblEM4Al/ZLzuzPr4=
X-Received: by 2002:a05:6402:52da:b0:6aa:f1d2:ddb5 with SMTP id
 4fb4d7f45d1cf-6b17c27172dmr14196415a12.31.1792097315751; Thu, 15 Oct 2026
 13:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com> <CAHwyqnWyYhRZ0=byi3_yqT2phmVa2DY8XtxA8bQT=pwcetkMAg@mail.gmail.com>
 <f06c7de7-f9d5-4c7b-8c65-fc2cec1ee698@app.fastmail.com>
In-Reply-To: <f06c7de7-f9d5-4c7b-8c65-fc2cec1ee698@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 22:47:59 +0200
X-Gm-Features: AclHuK_Vuta8m6TEuc4jOZBCtmIeIN839owQl3wfmJ_hjP5iIOQbJ7OxUO-v1Q8
Message-ID: <CAHwyqnWqVVsMPseg4oczAZf0gKo1+1c5-kAeNctVKVGe90V1eQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, GGGGGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Sometimes I'll just pick all the commits one by one and do 'git show'
> > on them to figure out which one to actually pick. Not a great
> > experience.
>
> :)
>
> I got a bit curious about this forced workflow now. I tried the first
> terminal navigate-and-click Git tool I could think of, tig(1), and it
> turns out that you can do this:
>
>     $ tig reflog
>     $ # navigate up/down j/k
>     $ # See the commit message and diff with `d`

I don't use tig, lazygit, github desktop or vscode=E2=80=99s version contro=
l
extension, not because they=E2=80=99re not good (they probably are) but onl=
y
because I don't want to be removed from the fundamentals. I want to
feel the pain of using git :)

But that seems like an improvement, yes, thanks for pointing it out!
Good news is that git options are passed through to tig, so with this
new feature we could run:

    tig reflog --operations


Harald
