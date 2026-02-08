Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE614E2F2
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770518065; cv=pass; b=Iz0Pkki1RGfdc5kRT8Z/YwHXzfzxvP4+8KtMhAeSoWJfttfePd1OQJrsl3dYzhRYdRnmsg/RbyYQHdPk2LvWP9nPNE3AnBWsfyuL/XGgituMHhAzM6L5NXze97OCJuGd7JOVr1rvGzMEpwQMkt0zGwQVYT2WNofu38jOo8gcUeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770518065; c=relaxed/simple;
	bh=rUiqJw1eXsETemy50qiaTPBOHfOWeZJBe7LCCHbC3e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1ch6JHWa5LS9OXF91PvOyjL80INlvQg9KKyMun1rqkxJVrSJVV86eRmtUKfbIsb9ByVASpZIu95LpCBIx6irtde9Ugs4o9K7sa0Yoyx36yxJaWb/Pmu9jdL5r0i+LGrqvly3I4NyL/6aDLPoqvYUU7o4cCRSwvTUcks8mWpCqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRWFEWww; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRWFEWww"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-352dda4a34eso1380573a91.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 18:34:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770518064; cv=none;
        d=google.com; s=arc-20240605;
        b=LxXX+Xs+FgqWR4w0pTOj6PEwLohUloUmp4yXnd558yIwDuvFM6/2J9QL05QgB8mYyi
         ETxAhhb1I383Ch7LDW4PjiU7iVixKc2FZrg+LQTZShYid9cTUma/3XKX4b2ZfAVmQrex
         HNch11qJRIGZlhVKmn+DlAfSQV51JFZLvB6wzllZQ23J02cm9AmtvDa3JsYfUGACImGw
         6gWUw3yRGrScX1P1XYTBVtHdCJhmjeYDPxbbIyPSOL6OVBLBVomjHvR9vQS3CPQV4im5
         H4z5oV2cjFhc5tb5ruL+0n7rAkYHnjhHZENmAGHzkK1dkmiyL2x9AVMzNDnWP5lQdqm6
         ESXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4ZiJztcndDXSY6yHB97xiXZOR4ltANXDdUs87UTUVTc=;
        fh=gufDFpp/YKRKGLb/aXsvmgwOEw9HXGp/ynRTMJheky4=;
        b=bZFvyxYw8qbmlyKwvvHBsZyqVWtnu5zH+oiQ5pAVA0krq3USzAQ2oOWD8ijYHPoGpa
         G8AUXBAyMfC8qxnWJZYRM0UtJaD0ab05KX21X4iVV6B+CObSMIOWTxnC+9WEqvZ+/qsM
         /8Ocf1mvzTnAdbbpHKP/kNaLC8dgRHEwtHWjheTa/hL0jFWVk1FDXVhduLbvFhq0gOt/
         uJA6GeLWfJ+tpEFvxgBopn3/E5VlpqkJDxwK9mjvw014ZisWJhKXo0hPYVU0OZ0v5+Z8
         JjOph7hXa3EJpBv/yz2OmYKpQjDOS7mZA6pTkqYHKvkrDvpGnho6dKFtVPeYivWFF0D3
         Ke6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770518064; x=1771122864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZiJztcndDXSY6yHB97xiXZOR4ltANXDdUs87UTUVTc=;
        b=JRWFEWwwXTH6G0S/GmIeHSvRlubm/nxDX/wOd8/p5uac0pBUdOZc3xaA4pznkpU9wV
         u3GyNVaEo5XMTsd4K5e7Spq9nTvXzdiw8xut2ellnSRFN3+hEqNRBesZGsCNzn9s/pFa
         m8WEsHPRSwOVEgsiNH9rbPAA5fVUcQka6W0bUKdcL3lraQO+kodJu3ztHC6EDVqzqcf9
         uGXn2qUoqKm//cz4iP3ICqgHazh6qnlOcJVRMZDNPtJEH/8EQh33y+6SuzYbQnYN2xlY
         qMdm3m/3L2ALF3QXdfdSeZAaSyHM//FnjX0PPvnho1wWHmu4yR3OCBt6OvcsYuazFyzd
         vDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770518064; x=1771122864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ZiJztcndDXSY6yHB97xiXZOR4ltANXDdUs87UTUVTc=;
        b=UUl97eb4zX1ag/6wzF7YcNGGvcDULilw/XcIyiAYbI7OCIeLDHgRCp8nJhS+UzDiqr
         6WGlaEzLqWEoo4NZ+fgdN26jvbaucM4hPPkUt9DZUX0AwI1uQQ28/ADfjzginKtjA2jG
         Yjynvu/Gw6tUJ9gN0Xrp5CLbNC1McvDHMRUxzbhX3eeKd8Sk/XIckAYxd8q98uaAhLnr
         hTmoDHrqgHmqWch0WEqX/792JRIyJOTa2bG5lNFIsd7nv3WXVoyc2dJpbMNowmMczABK
         yQEMAvBdBnboOM053tqCeDNqm2qfwZkyib3YT1ovJtUhbQIuvvUfxSyy7Vdhd0O38Yq8
         s07w==
X-Gm-Message-State: AOJu0Yx08WZy4H0JykfCIogWrfQ6Wis/qUcaA/ohtpd7rfpK2keHIHXR
	v2Xv0g6RRez4X1LYNh/NeBZ3vMrmcH29v+vAbWqHPeiRBDolW4mAtokcgHBkAiy/CQCQM5G+lvy
	6qC1j0uqRHvsSulVyZX5TH31T53JD308=
X-Gm-Gg: AZuq6aJV74qjGRO5KuAAyPUde7fg0xEXuDVJywC4uFj5v5mpKR0v8+js7VqSBGjB/W6
	MkzQUahk10VabsaVSuNivKDDpyee6QLR1VeT984xz82aUo5/vHFXUpVp+u9L9myCnQ+07Sdr49r
	7If46Gr5D9rTwqyJWNfH8v5j/1Hb4Rv7M+5Nyhfslt1a0WRHuUt+cu4M86Kb2IIiw+S5ulp3oAC
	29XosB3FvzgbQ+5E0x+9lVTBJ6TCOCHojKyjwsrAqFELmGBgMJtpNPHIhrYn5F7VNs3kXdGWEEc
	0fCkxv8FgISiEykjBKGxewnjacDyvMaj5WszvkkmN2EEHngK8117JiM7kY5ZW6mIeP07nDOV9cf
	rBb0bPukfYz7AAQ==
X-Received: by 2002:a17:90b:58ee:b0:356:2bdb:a375 with SMTP id
 98e67ed59e1d1-3562bdba742mr1137726a91.14.1770518064229; Sat, 07 Feb 2026
 18:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_doc_patch-id_4.275@msgid.xyz>
In-Reply-To: <CV_doc_patch-id_4.275@msgid.xyz>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 7 Feb 2026 21:34:12 -0500
X-Gm-Features: AZwV_QgkfRQrQJrYVLrO-cegqY7EwRaFQHPardObz7nO0ohGdxaQ3EoWBx-bflc
Message-ID: <CALnO6CBnGf6M=a__5mbGNFZ--kDj45nzFBpsv-jPcwO-e5ThOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: patch-id: explain how to map efficiently
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 7, 2026 at 10:06=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: kh/doc-patch-id-4
>
> Topic summary: Explain and emphasize how to map commits efficiently and
> add an example script.
>
> This is the fourth patch series for git-patch-id(1). This one focuses on
> emphasizing how the command is an efficient patch ID=E2=80=93commit mappe=
r and
> how to use the patch IDs to join commits in a script.
>
> =E2=80=A2 Patch series 1:
>   =E2=80=A2 Topic: kh/doc-patch-id-markup-fix
>   =E2=80=A2 https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.cod=
e@khaugsbakk.name/
> =E2=80=A2 Patch series 2:
>   =E2=80=A2 Topic: kh/doc-patch-id-1
>   =E2=80=A2 https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.cod=
e@khaugsbakk.name/
> =E2=80=A2 Patch series 3:
>   =E2=80=A2 Topic: kh/doc-patch-id
>   =E2=80=A2 https://lore.kernel.org/git/CV_doc_patch-id_3.1ab@msgid.xyz/
>
> Kristoffer Haugsbakk (3):
>   doc: patch-id: emphasize multi-patch processing
>   doc: patch-id: add script example
>   doc: patch-id: see also git-cherry(1)
>
>  Documentation/git-patch-id.adoc | 49 +++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> 2.53.0.26.g2afa8602a26

Short and sweet with a nice demo of how to use git-patch-id(1). One
nit on the script, but otherwise LGTM.


--
D. Ben Knoble
