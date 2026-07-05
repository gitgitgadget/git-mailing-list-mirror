Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264236403A
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 23:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295798; cv=none; b=HDSsPeq0Q6Rjzfkzksds+Mh6xK4xpuvwHDUikYf0SnLpIY5rUpbEHa6wsEN6q2D/xXZ9ekEXhjl8r9jF7JRI6eu+uSEN/1cF+QlddyvlDZazuJkxbgZrdNUwiJrLkEpjXpCz/sJbYY9A7iPhVQMQpfTbxRKA56cvoN9hkYGaPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295798; c=relaxed/simple;
	bh=1WXPl8DU5HQqUHj+xnp3v9TU3REY6P9E+s1ea6tBm5c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FweaYS0x5FNcvxKJA2FaEl+SXYAHBZxfa8/I6zHdnCEMIJc0FESr9dN+4BT1CpV/6/fz1QR9SClqSfUKnk7hMfhbolnn4Ab/bsBuIFAymxKursaFcXdp9KFMK7hP/OdWYieKHqx0Z0VjSVZXBZcKSxPB4+G+j0400pczJJCE0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sswCWowD; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sswCWowD"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80e2cfe6918so34163747b3.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 16:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783295796; x=1783900596; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U24nYVNuPqqurPRi6dmpHYUMm1E91+mSfOlcbcI+5xg=;
        b=sswCWowD75e7osLicPp+rbv+ohOXZAwgWhuDBMQODQ7L7IPxWxlE3uGVUGtp6DnLhS
         lqRYk9ZiF2YpIIaoAFGoREK4+Np9p1Zfyr43GTx/4GeF+/7Dr1NNmZPCvUDZ5Z0IPB07
         X9OBDxK2NSSKvvi4QHihQ5Qjky3QdLGzaWBtZoW110iEssVjqN93UXLjDK8M3c8LFJPX
         cigoX2bdBu6c1LKMKtVa8VpxE9tZm/R5h47wkDt8tZHm2pRizymzHfKWzOWJqH2XK5lw
         Z3wqQhzky0h/+fKt3/H370MDlZfpzdmUBcrBNrd+mmRquGIofNl7wV7AdHBxuEuBQUiL
         cj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783295796; x=1783900596;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U24nYVNuPqqurPRi6dmpHYUMm1E91+mSfOlcbcI+5xg=;
        b=dDmBtXsSBGrzFUXRfNpzVoo9Cv5OMKroI1hTFh0Y3Aw3icW207z3z5lvgoBEnefVCB
         KQVJB/EB/xat+aQZ7MXnVje3zJ09QFgoNUhdgtv36A2w23Dkc6NKlq7i91q4U14MJmot
         jaVaoNwgoqhhXW4LIMVG0fCSAvAtosatIx4g/mbgR1j5//TLAG8pn2HEi2SjwFjI3+VZ
         IIXZYb9xskKqXEMxpokiJQ6aeCN1UHLhNbfinm34RnTaro6Cu5znJk2tb91nHuQj0aXl
         x0t2DbkqeshzB0kfjGAc00hB9VygCcwUKWCWMKJeZ5Qm1gsRV3UZILrjAYZbfUDFxap4
         SW7w==
X-Gm-Message-State: AOJu0Yy9uJ2DSVGMVM30x/OOxXQQq4Wm7kQRTMA3eMy9ogKYh6tAokmc
	N7Y5LC7bNteZkbK409JEDvMuHwLdOpVMWf2ZTuK1Oss9evLpIpuCqhhDE+b6Tphp
X-Gm-Gg: AfdE7ckR7XJ/mdlhorkOVGywQpZJQBfns9Ssf9pHnXSVRNrwbyoZQx+QaAGAxnr53th
	feTGWzybZrHdyhjg6rQ8mTT0Bm7ZugzRqYsyRyX4gFegz65MK2S3Oe4yOSqdKQFvldJYaTdPIiR
	e+FBRp2j4ezlvXHYuObIVZOk+0wt5uMzgj1pkqCgse1KjnAmJRbvfc8BXuXKSm5r39w0v5dJXvU
	XnnavK+NJpFjBRp4gXpSC58qLa2Qj/AClOZeJT2nKCRJNI5Vtx+cEUj3zoyalAHCFnuswO1aNEb
	CrFO0j4mk19OsLxS49Gsb06EpCkDJs017aRGzzG1o6JeUqFP1NsNL5+/NOHJX1uxCEMX64vkrbt
	gcZj4ojOgEknBZIeVp9wDzwJGa1KFIz3FDsjq5ka4lDNTk91mNdVjfT9J1aMMVMbCRbH2S7P/dG
	5Apdso32NpIlWLbKPyrSix6hdjWyGuUK2IGzEpD09ouALsS8shSRzMOScvN/izrxjly9f8DNm9P
	S/P4DTljfKuA3Ku2iZqC0cGx48yNAxkuuQChG+4N9m+JaecJW2Cxy+HNMmb+aibOWP8gACmhaHz
	jQ==
X-Received: by 2002:a05:690c:b15:b0:80c:85c6:8982 with SMTP id 00721157ae682-8173a0ee341mr96233637b3.65.1783295796273;
        Sun, 05 Jul 2026 16:56:36 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:60d4:5dad:89ad:c36d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144ba2665dsm50609457b3.41.2026.07.05.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 16:56:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: CARGO trouble appeared from 2.54.0 to 2.55.0
Date: Sun, 5 Jul 2026 19:56:23 -0400
Message-Id: <81CE676D-CBBD-44E9-8DD6-B34068E35769@gmail.com>
References: <bb2a925e-0b01-4e12-88ed-44deea0c90a1@lyn.dk>
Cc: git@vger.kernel.org
In-Reply-To: <bb2a925e-0b01-4e12-88ed-44deea0c90a1@lyn.dk>
To: Kurt Mielke <scr@lyn.dk>
X-Mailer: iPhone Mail (23D8133)


> Le 4 juil. 2026 =C3=A0 20:23, Kurt Mielke <scr@lyn.dk> a =C3=A9crit :
>=20
> =EF=BB=BFHi
>=20
>=20
> I had a clean alma10 and wanted the newest git BUT building fails:
>=20
> make
>=20
> ....
>=20
>     CC version.o
>     AR libgit.a
>     CARGO target/release/libgitcore.a
> /bin/sh: line 1: cargo: command not found
> make: *** [Makefile:3021: target/release/libgitcore.a] Error 127
>=20
> I got 2.54.0 and it compiled just fine
>=20
> I found out CARGO is rust related

Git=E2=80=99s source code has included some optional Rust components for a f=
ew releases now. Rust is planned to be a requirement for 3.0 (IIUC), but I d=
on=E2=80=99t have any recollection of the proposed timeline. [There was also=
 some discussion of delaying the Rust mandate timeline for platforms which c=
urrently lack support?]

> Changing make command to
>=20
> make NO_RUST=3D1
>=20
> And I got my 2.55.0 version, but allow me to suggest it again is the defau=
lt

2.55 is the first version to flip the default to =C2=AB build with Rust =C2=BB=
, but it remains optional as you=E2=80=99ve discovered.=20

> II have no caommands in path beginning with the letters 'rus'
>=20
> Thank you in advance
>=20
> Kirt Mielke

Searching the internet shows Alma has packages for Rust, which you should be=
 able to install if you want to compile with the Rust components.=20=
