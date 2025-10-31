Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BBD34D3B0
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761950650; cv=none; b=Xata52TQITx0S7CQrLbw6yJvQjjIXHOyhpUdrjsHcRBHBizcGMWKbB1ArZE4UOFq84QxSTRpMbCiMb9Zb9Uj8IZvY/DxT00SFwhvcJTs97jRce5FRto3NkLUAHrO76523M3E8ua7/ksyCDfp4VlUxyasulbJzjZpJahv3k2NzEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761950650; c=relaxed/simple;
	bh=9Rk0UYO4zn2JL1QY7iGF0z4wNSfO6gLaZmsuQDZBojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHtyEFiM7iWbPuSL1LtVWVrBGXLHsb9KF1pFprYw88bBPbu+EA9mdQ0d+JY+xs7CkfFKoA+RPvcHT7B3MqdrS7aBVu2RuWFDMWEzGzk12qexr53D+f4yXGF2fKKvCGybKDWlkf5HhLSlUlNOXR+1sN6a7nrP9TSmF+E8R3Z2p6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEtvZAj+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEtvZAj+"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3737d0920e6so795031fa.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2025 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761950646; x=1762555446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNe2SXHvR01zUgxT6bBxDqipiOtRFbdvSfSvwP1HL2A=;
        b=gEtvZAj+Swo244lgfVz/aAloHQzrX21DzQs1QMBwyXKyja6Xgdqo4XuB2cIERBLfdB
         HUU31RmeFGh7LvqHPnd0SbjAhCGq9i7c2SBDTitsqEOAoB82fN8CIZsLmFk5YWnrPgRP
         bkClxdj8QTiy74rJvwnorP45O3wtDC76UG+WrSPlaQRmpVrgBfs9ycvJRW9e+HLxhH+A
         wWjzcA4arLPcee5ScpZoq6hbLYORkalusVblSdkPVPeps8VFkDZqqyBTXn7+SYnfBbO7
         jDx9h/Iq/CFABdL0rGavJaw8SrdIzOEh5hp7sd8UFzt/YblmkMI/snX/scqxs5mSiKrn
         0OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761950646; x=1762555446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNe2SXHvR01zUgxT6bBxDqipiOtRFbdvSfSvwP1HL2A=;
        b=S5mGi2Y3/jOy79jS0KS1q6bhnY1B/21zd2yNC7uyQttC4MqRwj/puMXKlZoFNGmgBt
         zmIcdaDWNbhdKhlKX3crlhDgaZAnmPkd+rS1EL5BSJLKSyW6vGU3iviGu9/jKCU70p9z
         4kQtfij7arwMGwjR8o9SONffbczNFx0dlOX/bVGvYmqXx2FljCsQmjOt/4IqRJkkaozp
         vcm3RfJDr0x5Rp7kIdSvrCGUhj4FeEMq2TWfYq7gZH6XPdAeME7NvByCX/nmNjCVNOOB
         7/Mo1c+Mh7OC+UHH0Sz1iHMGWIe6HbXyDeDvHCMlegAkq749Ctqb45DyT1wF0C0MlvR5
         lqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWson35fkVmFJ+7069Sdr/FJXUaNMcMRKZ/rQoLnYPLHrUfDjoyre3KWvBb5kqiAtcFdZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPkbZGS/8lbxNGhCBinVYQsWK6DjltCJHsJtJcHe5YA9mW5ji
	oIhO8KXZz2IRp0tFMi87Gw3vg7781SSteKt5HSDPjRPdss/ucTjX3JPocnRBl0dbEYjosLH6DPZ
	qO9/ye7NMMRKjC+FUaUAmSlElg3+U39Y=
X-Gm-Gg: ASbGnctse2Nsss6c3OzjEHWntv3Fv3Mk7tTvdbZUxM1BS89+5SgVpsKy9aLXEfJzUHZ
	oeemM6xwevGOhwlcjsJYwUXTPXHlbxaX9f1d8XIPQ2yjN0hol4f6epH2XtJcHtp9AnzDvXkuoXb
	1YcW7UVpoGft3PrsbasU7N6AoFRWT3Rt+oCBGdaJo5fvWeqVvMYqLQzWsIahZvlROaw4xzroMo7
	hVCp2jHp0YNddqQcoH5jvRWN4Imzijt3ruWfjiMbIePpdUdixsUWeBU1HlMzAq6DgfglqtK
X-Google-Smtp-Source: AGHT+IFm1JfEen8y7VEa46LEn2O1ArkzWm/iQ1b+ZwKCDnWpQgRkIAlFwzR2w3F5cyuSD/onf/wLpn/W0E0bTAlUnz0=
X-Received: by 2002:a2e:82ce:0:b0:375:ebfa:2986 with SMTP id
 38308e7fff4ca-37a18dd5164mr12684841fa.34.1761950645563; Fri, 31 Oct 2025
 15:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-11-sandals@crustytoothpaste.net> <xmqqms59acak.fsf@gitster.g>
 <CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
 <xmqqwm4d716i.fsf@gitster.g> <aQMFFZ_uDZxHvExW@pks.im> <xmqqsef07avt.fsf@gitster.g>
In-Reply-To: <xmqqsef07avt.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 31 Oct 2025 16:43:53 -0600
X-Gm-Features: AWmQ_bmpjhO9ZTsz9lnXVRzOWaQM73xvnoSOjOsGW4GCTqgEXfu9o6mRIyxFXGU
Message-ID: <CAH=ZcbALuWqaAF21Dho38xJpoaa66Hzs-SgBV4HhywdKopCgoQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > The question I have here is what the benefit would be to have separate
> > libraries.
>
> Mostly flexibility.  If we do not value it, then that is OK, though.
>
> And personally I would have to say that "meson rolled everything
> into a single library archive" is a bad excuse---whatever came later
> doing things differently from the incumbent has to have a good reason
> to do things differently, or it is a regression.

I don't understand why "Simplify Cargo's job of linking with the build
systems of Makefile and Meson" Isn't a good enough reason by itself.
Nor do I understand why having libxdiff.a and libreftable.a produces a
better developer experience. My developer experience has been strictly
worse because of this separation. If we keep Makefile the way that it
was and change Meson to also produce separate static libraries then
we'll need to keep 3 build systems in sync with each other. If we roll
everything into libgit.a then Cargo only ever needs to know about that
static library, Meson doesn't change, and there's no question about
where new object files should be added in Makefile. If we do add a 3rd
conceptual stand alone library then we'd only need to add the source
files to Makefile and Meson, but if we insist on separate static
libraries then we'll have to add the source files (as usual) and make
sure that Makefile, Meson, and Cargo are all in agreement about the
static libraries being produced.
