Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467E4C9D
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 03:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044517; cv=none; b=DhCVY5eLSd08zifkZrtTZ5OYpV0byfO3cNtL+sOJKYITxbtPHwag8PXTviG3qkPMfdPre4UHNva4I1nAzHNAyvGFgkTGBt8+tGAjnERVMRHaLzLgoMk23QyaLF1ot+5yoINvL59rWnO7wKUpHEYU91BAr5bQH5/bfDT/ByDpmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044517; c=relaxed/simple;
	bh=b4ZDAOmpAarxEfTbnjZ2G3/wIWmvcBYXzW2/55QNGSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gn/NRwKm47C5Qtc2qOvsgHXmPlGuH/8t4zzpdAbz1rc6K6YS9QixJpXf1bdD14fJ9/B2gP75383Zu9g1aKGP4R+B1x65sQgmzXjOL4AA0Vq3ZB1Rf28ZoiWg6NBOTGr+LvaWIe6DJkD8TR3JwOakVLDE9W6KnIyN8ztODRMtLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKUCfITZ; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKUCfITZ"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3f664c47ae0so10146775ab.0
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757044515; x=1757649315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3qQDs4HVqJPxSMWU7mHKAtXm36hIloL9pNIhwwdGgg=;
        b=LKUCfITZJama3BPqG01SJaaW2Se55wCKykLxvYdSA2azB500e/BY0YtyG+wy+mVDHn
         F6mzFZtKYzd2AJTNrN/Quc7DS8PGqkQPMo/Eo6TRohnHDP0g1uBWJNLFtEA0tm0gqjau
         8PRjoW/5LNkPJv0Eld9pwyZnlfpcWg7DXjjgVaqCziA0sva/YGIwtCTo5VUmLkIqozgY
         CHjT//QRmiYAp6g7f3gDJ4c7m9hwkCe/mGHyRbpjMLGYE0UJkz2TLLx6yJLvFf0JnPMe
         WMiNlvT5mpHX/Y3GbR5R7iafEe7py5CZTUKxa378cxzfMT9u51ZowYGnKSRVo1c2OQFu
         ndxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757044515; x=1757649315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3qQDs4HVqJPxSMWU7mHKAtXm36hIloL9pNIhwwdGgg=;
        b=cwkGEsnaniUPDkZIBZKJClrEg0zGWBdDcOn985QeBghTzKIeqpJWom8B0+1ZBWobI/
         6E+nkeGeonArilzr6n1yeFKmDfj6dgSEpZzcrql8h2pCnpfojxfKivHG6YqtDfTQhFpI
         bCzNe3Rol8SK0l2PEtxMzTneYjWiIIQ6iZDxLZ5krsPWOAR35NVJJyBgWjLvaUeljy/o
         hk34LqY/b5emkTAKS3VUYDfwk9MHXy3Ofw/vGs+J/S2tD/ArkyrA8iBNTIi7bs/Y9Exw
         wWwlLtKdKDtkEQ5Dyrjy1Xld37CqVzG9pQXKbQlX1jMGr1EWMT+/fWaeaAqwn/MvE1Wf
         r2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW7u+IU34XbkdwQEAqh7J2RD6XPxa4BAOXvKMrLUG4+DgxIiwDtyM7Nr2WZ3YP+ggqi1Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRaIymuXIgSB80xZ+btNcB13V6ARJU8zl4gVmeRPf9r4ODfnA
	qsVlcVUZkSTVCs6kFfWvzBE5w7LWgP6A6KFZ3zAWtFdltrm8dFn6RWc38y6pgQKKVdIHSBppPbS
	Gre5Zz8xg7H0UBNexCwI+BOUEQKGE92g=
X-Gm-Gg: ASbGncsVou4WdPXN3xS24ufP+PG78mEEVuK+sl89n7JOF35WhKlxKcmxqJujMkn/beG
	/sn9gFhmZrW7sAzCEIQrC8GFiDSzn29zQrqGjpjDnoc8cVdYqsHcfWULn0CiXiGmBoKDEfJDAFL
	4HIL4q9I/bOhK5Z6KxtAXn5pR8oyag8gPWa9YuWx5NO64qxgUL0Uo/ProdQe39xILQwHFhqah/+
	aX1O4VvhDLUbqdoILw=
X-Google-Smtp-Source: AGHT+IEtLmcE4Um+QtRzuYrRMG3pEuHRcmgRzUxE4VfqrSJM+31U8yjyFEMiXDuQKqXCus2i1LBFngaurJfaoKbblD8=
X-Received: by 2002:a05:6e02:4411:b0:3f6:5e42:9ec0 with SMTP id
 e9e14a558f8ab-3f65e42a7b4mr165159375ab.13.1757044514605; Thu, 04 Sep 2025
 20:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
 <aK5mJI1NfVQDmDXN@nand.local> <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im> <87v7lymiik.fsf@gentoo.org>
In-Reply-To: <87v7lymiik.fsf@gentoo.org>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 4 Sep 2025 20:55:02 -0700
X-Gm-Features: Ac12FXx5ws9yv_8zoixGZBIstHXve_3MuqeICBMBPwCIRIw3vFtYk4adHAMznT0
Message-ID: <CABPp-BEgzQg4MOsepFwnfg8AfE5xv2JxKpQa1rGyOpwWW00HqQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: Sam James <sam@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 6:53=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:

[...]

> >> Also, the approach of making it an optional component directly
> >> contradicts the proposed policy I wrote up.  That's a recipe for
> >> additional burdensome work maintaining two implementations, when we
> >> actually want to make it easier for people to contribute functionality=
.
> >> It also doesn't provide any of the memory safety benefits or address a=
ny
> >> of the concerns from governments, security professionals, and other
> >> parties about the real and substantial risks of continuing to develop =
in
> >> C.
> >
> > The only reason why we want to have it as an optional component is to
> > make the transitioning period easier for downstream distributors. And
> > the intent is not to convert major components -- it should be trivial
> > components that we can use as test balloons, similar to how we did it
> > for all of our C99 test balloons.
>
> Yes, even if it were just for one release, having it optional for
> something would mean we can adjust packaging without some huge pressure
> where git had 0 Rust in one release and then mandatory Rust in another.
>
> (I would of course prefer far more than one release, but I've tried
> throughout this thread to give options even if the one I'd prefer isn't
> pursued, not "teeth gnash").

Rust has been an optional component of git for the last three releases
already, going back to v2.49.0.  See the v2.49.0 release notes, or
e.g. https://github.blog/open-source/git/highlights-from-git-2-49/
[*].

[*] A quote: "This release marks a major milestone in the Git project
with the first pieces of Rust code being checked in..."
