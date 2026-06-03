Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254BF2EBB86
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493431; cv=none; b=PeXKRqOBiP2ngRbBlZJe7rYRV93PfjP1ULaSK8ZLrTbURP4SeQFBUHCD8NdfhuA+m63Blu6WJlJzzfw1gs50pZIHvZbKxztbkb40H99712P34PnHof5KLZhDOMnaUvnfc6M7EaKpwCYufvCWkRAYw4KtPNRHZRkJEVMrZ4MoGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493431; c=relaxed/simple;
	bh=T/tPQpTAtTpRyMMdmQjeIC2tp+v3hZhNbihID5i/RS8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0verNAjEvo62xZQoa1TdAWCP1DPLORlc2PXLBouQYiCvmw7yjWBuYQTSkHqedYUIQZO00uKm1H1Rp02gfEfWI1M6Fp88l9J5Iz0ep7RTB0Go64KGg95jwoWtsvBjBGOz1WkLsNgftuvAucjyZAlS9KuRA3ickzMrX2J3rI9Pyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=HnIZQwV5; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="HnIZQwV5"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 653DUI0M030659-653DUI0O030659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 16:30:18 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wUlfm-000joV-7Y;
	Wed, 03 Jun 2026 16:30:18 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 16:30:17 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6b04aac9;
	Wed, 3 Jun 2026 13:30:17 +0000 (UTC)
Date: Wed, 3 Jun 2026 16:30:17 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
CC: Patrick Steinhardt <ps@pks.im>, Weijie Yuan <wy@wyuan.org>,
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] b4: introduce configuration for the Git project
Message-ID: <20260603133017.XkcQR%taahol@utu.fi>
In-Reply-To: <aiAK9eLvew+mgWt+@szeder.dev>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
 <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
 <20260602170955.Z4b7y%taahol@utu.fi> <ah-Nhr2PboWUq6eU@wyuan.org>
 <ah_PyDwO1Sffr5yq@pks.im> <aiAK9eLvew+mgWt+@szeder.dev>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ex19-06.utu.fi (130.232.247.46) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXUhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhRSBgbKBgDG0YB
 BUhYSFpYSBsSDQwNGkYMDR4oDwUJAQRGCwcFSFhIWVpIHxEoHxEdCQZGBxoPSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=GhW4r3vSySoMuTpxnRt5qR5lXiyp34YiT+YP7SBl6Ng=;
 b=HnIZQwV5IkJ4+WR9EbatIQUor1BPMWfonj374bAhNSBvn6ny75h8SdM6I286RhEYBNkNpGioLvuv
	Bf3gSknTG2RvY2FmPuggQK5OMn3BUJZS31G28qAT860avr0+eMpBsMm+5EnFpAc7ttyp4ZRrdBU2
	pOMTnzhGhuyAeJEzlEc028x6XunaIR0ElGd5u/eJN8fkfI60XrnYCCuqaE24qgAYqKlrWGp54UDa
	xiULJLbSiKCOu5lgY8m7S41/xjNnwwKPvgv3pGU6sSim0B75c1pcPXr2kHMcyUkMFs8YwdXBFrNb
	C3DZGSOEkiBzyefQRkaPYqi84LhiUAxRgbn1vw==

SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote:
> On Wed, Jun 03, 2026 at 08:55:04AM +0200, Patrick Steinhardt wrote:
> > On Wed, Jun 03, 2026 at 10:12:22AM +0800, Weijie Yuan wrote:
> > > On Tue, Jun 02, 2026 at 08:09:55PM +0300, Tuomas Ahola wrote:
> > > > Huh?  Doesn't MyFirstContribution speak *against* shallow threading?
> > > >
> > > > 	        [...]  make sure to replace it with the correct Message-ID=
 for your
> > > > 	**previous cover letter** - that is, if you're sending v2, use the=
 Message-ID
> > > > 	from v1; if you're sending v3, use the Message-ID from v2.
> > >=20
> > > I don't get it. Doesn't shallow threading means every following patch=
es
> > > are replying to the cover letter? Replying to the previous one is
> > > --chain-reply-to, if I'm not mistaken.
> >=20
> > Shallow threading basically means that all patches are sent as a
> > response to the current cover letter, and the current cover letter is
> > always attached to the cover letter of the _first_ version.
>=20
> No, in Git shallow threading means that all patches are sent as a
> respose to the current cover letter, period.  It has nothing to do
> with whether the current cover letter is sent as a reply to the cover
> letter of the first or the previous version.
>=20

That seems to be the established meaning of shallow threading, e.g. in
`git format-patch --thread=3Dshallow`.  Unfortunately there is a slight
terminology clash here.

Indeed, in B4 the config option `b4.send-same-thread =3D shallow` *is*
about whether the cover letter is a reply to v1 or v(n-1).

> > So this quote is definitely at odds with the configuration I have
> > proposed. It's actually quite surprising to me that we recommend deep
> > threading -- I personally find it extremely hard to navigate as the
> > nesting eventually gets way too deep.
>=20
> Deep threading means that every mail is a reply to the previous one.
> Again, it has nothing to do with the relation of the current cover
> letter and the previous cover letters.
>=20
> Therefore, we do not recommend deep threading.
>=20

In the usual meaning of the word that is the case.  Most certainly
we don't recommend that kind of deep threading, but that wasn't the
question we were discussing here.
