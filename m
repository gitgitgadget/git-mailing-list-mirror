Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BED37B030
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791641473; cv=pass; b=FPmEcefAL9EdM9UJlxFNL7oXHlEKc8wdRL0epiWrvZjBJjoUCWCGNFq5G604eMLQp3STCfBd8EYpSxNFeEn5ogVhBg1WeYh2KLAdlxp3sjQklU/iXCliNivPp4/Im3+iiol0g3B2b0EaJkdmli8tYJ3+4LbDHVWiKLjiVp15ZUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791641473; c=relaxed/simple;
	bh=lPwD1FjffM2iLj8bfFKKdE/7HwrZ3l85zPXvITXiAOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTHsHgxTxrXJKCvXZZt+sbQOnh6olTypeWsRfyXdbj+6TkxmJV78y5OdpPV3I79ihbXELMcdxmBvUKnLEYF/8lDLGIL64RC6lOJ90NE50+Yg0QmPzpMjJIW51lIhTwiM1I3WyqaDFtApn22AhiS5WANXJjkXRm3Q+ZDUBsmoeUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3ALQV6s; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3ALQV6s"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e836252e1dso4665345ad.3
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 07:11:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791641471; cv=none;
        d=google.com; s=arc-20260327;
        b=EhIRwrnW8WBiii7A9LiWDBpi16svlidhT/p8nkoR27VCD3uUeaYvEPPcALRJBBHXwf
         9R9dLo4kCdn2DuAg05bhbOH0RqqCXco686BrRtC7qN5sYKjQ/t5ebu3W0vPN7CNiru0O
         qZxjrO7OQ1k8/CqAZxZQxjhAwYXqCtnmT7djqYiLCPtN3Jnn3fU6Lp0YdTRUbZ1OcJn7
         r7NWOkzMIL3V/c3kbqiZu+rhJi+cSxleMFC02wiX21z6ifVdyKFdV7xzIFG9WWAWLrDg
         gWmR96kpT1Kuhla+TKo2xLN5RvTs1praKBkExf+ubBQvCGw+bq/aebKymNlR3ChUkzRV
         LsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKGmQSd+uPxqDF7fgazzndHiCTbuZlaE7CjPgAwoKFI=;
        fh=UPFYV2Bf5A+GtmZylp0bUBv1NSXa0IzzOBIEHH4hU6c=;
        b=KdcItkVhwy1nQy6l0MTSFaOaGCQ+Ov20El/UUH5wbrHwn307KSHswnvRWHw7A34CwY
         XDa1orMkTuUqd8JO1wYXAgZmvBsX86DC8hStbi52sCwDHiUj60N8BYa0acu1lSWA3hrO
         xRh9HTnBioNlfwXhLJpXPuROV/PfEE59klpXhdPOaWcs0G+UmVc0QCvoZ04Zq1vv04P2
         dXWtwKbepIUZ4ztFuW/5Im1MLGkzmINmL4+ocEm7R9j4ENZyc+9aJERMbudcJN5EFd4C
         px5lm3caEO9MnHUcFrdgb/N1OL88x/dgpEr+V0xsNmdE02rNH7Gsol4t2/zr/+gLmo/B
         gcXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791641471; x=1792246271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BKGmQSd+uPxqDF7fgazzndHiCTbuZlaE7CjPgAwoKFI=;
        b=f3ALQV6snsZ38fKwS108nLTreAvwux825qboyMA7c05ocJMM2oQdw/p6adoGmugPTs
         SinfHigvDNYMiTpP4dF9Hlyogdd7TCFEvw8fOMyq/olNGWO5vIL9tU5vyauvA1SQpwcv
         CU4SYSjFXvJ5aWgfjmNtCOSuXwsA0to77xb6Ndeg6ddejVbZ/fM+v9I4rasqISk/Q+Uc
         7UXDM/zOoR2iZ2L5ZVhSBUKplsvnOCSNtQcu9SWqszIsYaNSGama/TVQQ7kwQho1Wh+G
         yTH89CX3tXlLA52UGNmdU2tX41hR6T5zHT7R5ZITjgbsSxdOWLAvxP07ePO9YYdwBvUI
         4W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791641471; x=1792246271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BKGmQSd+uPxqDF7fgazzndHiCTbuZlaE7CjPgAwoKFI=;
        b=tfC+kLMeYs9GSinxq5/3N6E8f0KdU6figamtpBICEgIQWrMps52By0EufADBpFuaqO
         S6yTzVOPhB0viersKpQgTwOtu/HQPwmK46dyzLaTSvnvZWPi0GvaN1YLEwk/M5A7ucFq
         qYyUpOAEeQYrJqdTXnSf1D0oyh5Dc2Zb8M+/DdAk4SXeQs9HxcgbM7Lj+Q31EjGzMmNq
         YrY+4K3Q1mLFhP8RV/nXsnOgEqV5I9gc/GEr8D94JGEdSgxS39UTW0MX9pX7yKAQ8Oax
         Xae8dzXcivtEpODkZK2dxZ8mwL5ahRm+nAEGLOAfXVJMOck6upecKnHvsbzVLnpJZAqk
         KFvg==
X-Forwarded-Encrypted: i=1; AKwUvBwmzWLEtnMSf+ERPaY8IOcLlvUJf4zYdMfpSA94cE8Fk7FUJd+wJ81x3W0c/oSZjj38KLE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLgEZCa3m40ZsS7f/ir12MIsjsKU/GlAK/vHh6eWeCRGmoEdalV
	VzaHnUeJu9BHOl9kqlYI3KKYpXBYwdSnGY5dxs0mopvn9PvBUjOy40dl9tn/XMEYLJ+1t2WOnZZ
	c6Rpj00kz7DMvtSB5Sm/Bn79ImT/NyE8=
X-Gm-Gg: AYBFou2Dc0kJbQWIp1QsD6bxIQR74KNeqLoHW4poKAitBxp60dl/rgaTWtrxzgo/oB6
	dbUNBHe9aNWYzoSibgQuSgXfg9NHEsGhAZFqtTYHt/z4zmWvTver+0QKzF7hW4it9K6VW4pg9OW
	FtEl8yRAM/srneyFZWndARDPiguPKnsNl7bfCKeoQuBDGiexu7yWe0/a3nEc0dtcPVOEjuHCVHE
	1QzhKFRyNzKpj37ghGSCZvdern35E9PLr7G7dr/65NoKf/aWPJXX8ljmL6EYnksbMDRdkcXN0O3
	8rqAkB4wOQkqfIRNGBp+GStJwcMgYzEsVT0KJvKCJ28hEdeWJlHeWieOmG+IVfLooO43Xm8gjNi
	2jKbJfyh8VCAyb4hpMxVMUO8DvrSKTOSMIe/ORzSGP8xSKg2nvaw/ubEyerpdjQ68h9L/wqDfMp
	2E8IsrSNc=
X-Received: by 2002:a17:902:d50a:b0:2e2:e240:57eb with SMTP id
 d9443c01a7336-2e842aa6640mr44352245ad.12.1791641471191; Sat, 10 Oct 2026
 07:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929112544.86511-1-scott@gitbutler.net> <xmqq5wzda0h6.fsf@gitster.g>
 <CAP2yMaL51H1OAG25nQ0NuLQLb0wevd4CicCG1_ezsJfrZDqfUA@mail.gmail.com>
 <79ae606b-cf99-4867-9db3-bcd7ff03626d@icloud.com> <CA+Te0V+-O3avrvH353KfCDjAEzMa=_H57G4OmiJ8+d1dDzZ6aA@mail.gmail.com>
 <CALnO6CBbtKomawqc81MPV5Ngtc9J3M1ej4enGD3ZUzWnPSfsgw@mail.gmail.com> <20261009203749.x4V9kN18@teonanacatl.net>
In-Reply-To: <20261009203749.x4V9kN18@teonanacatl.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 10 Oct 2026 10:10:59 -0400
X-Gm-Features: AclHuK-WED1lo3g13kJuBUbjsG16IJmuHw0h_pmgcNdEZulOGqR6uYjXFn-digg
Message-ID: <CALnO6CAEcjieW48DkA9Pt1eqZ5hctwihmTXMxZ29YBrmzrp1QA@mail.gmail.com>
Subject: Re: [PATCH 0/4] faster SHA-1 collision detection
To: Todd Zullinger <tmz@pobox.com>
Cc: Sam Reis <sam@opencanopy.dev>, Sebastian Thiel <sebastian.thiel@icloud.com>, 
	Scott Chacon <schacon@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:37=E2=80=AFPM Todd Zullinger <tmz@pobox.com> wrote=
:
>
> D. Ben Knoble wrote:
> > Interestingly, Gentoo claims Git's license is only GPL-2, but I think
> > they compile in the sha1dc code since it's the default in meson.
> > Should we be claiming the Git package (with sha1dc) is actually GPL-2
> > and MIT?
>
> I _think_ that that depends on whether Gentoo's license tag
> is meant to be the "effective" license they are distributing
> their Git package or attempting to encompass the license of
> all of the code which goes into the Git package.
>
> Fedora's Git package has:
>
>     BSD-3-Clause AND GPL-2.0-only AND GPL-2.0-or-later AND LGPL-2.1-or-la=
ter AND MIT

Oh, curious! Where are the (using Gentoo identifiers for the moment)
BSD and LGPL-2.1+ sources? I guess I assume by looking at our COPYING
that the GPL-2+ came from contributions that said they were willing to
be 2+?

> I think I was the last to touch that, in ef75bcd (update
> license data and convert to SPDX format, 2022-11-07).  I
> attempted to capture all of the licensing, but I most
> certainly could have missed some things.  And things may
> have changed since then too.
>
> Fedora's guidelines have a lengthy page on the License tag=C2=B2.
> It includes a 'No "effective license" analysis' section
> discussing this.
>
> I don't know if any of that helps. :)
>
> =C2=B9 https://src.fedoraproject.org/rpms/git/c/ef75bcd
> =C2=B2 https://docs.fedoraproject.org/en-US/legal/license-field/

From Gentoo's packaging guide [1], I think we might want to list all
the license, except it really does depend on the license of the
(installed) *output* files. We build from source but don't install the
source, so maybe Junio's cousin reply that indicates the built product
is covered under GPL-2 is sufficient ;)

[1]: https://devmanual.gentoo.org/general-concepts/licenses/index.html#dete=
rmining-the-correct-license

In the case of other packages [2], it seems we try to handle
multi-license cases, but I think there (it's been a while since that
particular linked PR stalled) we might be installed both a shared
library under one license and a binary under another.

[2]: https://codeberg.org/gentoo/gentoo/pulls/1340#issuecomment-18812828

Anyway, thanks all! I'll assume the Gentoo maintainers knew what they
were doing :)

--=20
D. Ben Knoble
