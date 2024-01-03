Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE831C684
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UFsxBl6Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sM5CUCaK"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3917C5C0287;
	Wed,  3 Jan 2024 13:01:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 13:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704304873; x=1704391273; bh=eyWJhcWov5
	mjn9VAPVz1Ic47KN3aXV8sjecKd9G0cTw=; b=UFsxBl6Zhjmm/o2UDZQi0QchDB
	n3W8VFcxlBOXFPIvxyY0DeZs14ZZochTWG98J5htuUYSAr4zuVGmOHgVewXEDD09
	vTlLgzmFLXLD09OCqqQcubzZOpWfxSvtpCrjoJFRG+1XJOJ/KjvvjaKssynMf2qW
	iVSFuJvwhznxIUKwLvy2gCj66gDHnlyS2dOVwwmkYSa+ye+GNT2B2c5SgbtyfmI8
	Jr/zNgvObE7U6XLzthfAZpAH7KkNk57p+upE2NjMLcE+gwaexhaMfC8o5NXNeZ/k
	N+ylizc3sumtc9Rtj32nwghk4JlWmn+SEmZxvXXRUKl1HsQOL18Ob+frTCig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704304873; x=1704391273; bh=eyWJhcWov5mjn9VAPVz1Ic47KN3a
	XV8sjecKd9G0cTw=; b=sM5CUCaKTB4EZpW93t/N17F9sN/hS5y81S2ikVRiq+P+
	rpeG6/AOX6e2sZviNr8nYg0mbzccq7MUFL6rsPJrYa4w98u8jjOogDLOPyOEt4us
	FLb8DjyGJ8+S0VNtsZ3dPIH/DE9VOEjJx32S2RF/4XaipmUd/ABL5/g93MQxpU80
	prBTfwTYlRXSMUwz/DG3jrXCeCHAfuoOTukt4C66J11vGLkiyOiqXPEvRKbLFQe8
	e9ErCweMLFTkqUn4MTpaQ1rjUtX+M7aUrX4rV1MF9B8XE65n0Gf3+K7+nMaxPjsF
	3rhkR2bNI03mssdSCvX79hXjzsA++14E9AnClfWezw==
X-ME-Sender: <xms:6KCVZQt_pRQYWMpojZpnjpsYNRleOUuNeuzYfIy6oHxg1wrowdkc7Q>
    <xme:6KCVZdcVtWqLEDGlqRC5oxVV-8IzSex0g_dM2COEmKZZmc_eCOcfVG9PMme5-pgx6
    AFNp_jdYgyr8tLrzA>
X-ME-Received: <xmr:6KCVZbzOTaxorpBCaZqLmSkPnmWDGSTCzVr1xEyc-YXxcO50X-9xRNe5zNu6-vaqnkQd58xXqeNe1KWH87FaWLXjgGJkAh_0WnWL3vcB3rdvBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6KCVZTNaESeK1f6l4HAMNWluzxdMOC8DlGbZFwYnWWNJpNHapLS8qQ>
    <xmx:6KCVZQ_-tNY52aD7pq2QisN1Ko3nc1u1VpYWs8CFumez5yh8jrlE4Q>
    <xmx:6KCVZbVCDMDVXmy3TJM_6GsHQUaXmPSd_gpgYpsC0bfJwARnvfGqRw>
    <xmx:6aCVZfZp1FPUXA70HD9Ewy79SozaVNhc4UwSvvkFfb5NqHfMauemvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 13:01:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9369061c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 17:58:43 +0000 (UTC)
Date: Wed, 3 Jan 2024 19:01:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWg5JvjQymy2wcn@tanuki>
References: <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
 <xmqqwmsqbhyt.fsf@gitster.g>
 <ZZWCXFghtql4i4YE@tanuki>
 <xmqqsf3ebe1l.fsf@gitster.g>
 <ZZWIlx-9D2r9AfDW@tanuki>
 <xmqqil4a9vue.fsf@gitster.g>
 <ZZWbMekL2URby0qV@tanuki>
 <xmqqedey9u32.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1BLLXfqazYqyTr9h"
Content-Disposition: inline
In-Reply-To: <xmqqedey9u32.fsf@gitster.g>


--1BLLXfqazYqyTr9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 09:59:13AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> I think we should tighten things up over time.  First by teaching
> >> the ref backend that anything that is not a pseudoref, HEAD or a
> >> proper ref (one item of whose definition is "lives under refs/
> >> hierarchy) should not resolve_ref() successfully.  That should
> >> correctly fail things like
> >>=20
> >>     $ git rev-parse worktrees/$name/bisect/bad
> >>     $ git update-ref foo/bar HEAD
> > ...
> > Yeah, agreed, that's something we should do. I do wonder whether this
> > will break existing usecases, but in any case I'd rather consider it an
> > accident that it is possible to write (and read) such refs in the first
> > place.
>=20
> Unfortunately, the worktrees/$name/refs/bisect/bad and its friends
> are documented in "git worktree" and the refs.c layer is aware of
> the "main-worktree/" and "worktrees/" hierarchy, so while I still
> think it is a good long-term direction to make it impossible to
> create random refs like "foo/bar" and "resf/heads/master" via the
> commands like "git update-ref", we cannot limit ourselves only to
> "refs/" hierarchy.

Ah, I first wanted to point this out, but then noticed that you didn't
include the "refs/" prefix in "worktrees/$name/bisect/bad" and thought
this was intentional. But yes, per-worktree refs need to stay supported,
weird as they may be.

Patrick

--1BLLXfqazYqyTr9h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVoOMACgkQVbJhu7ck
PpTy/hAAqKIOviFRMrCVmLYMgOuyxfuD8+KCJtKTntcvpJ7sYskjTt3yObzAsvLF
zAlKzO6pwaeh5zrgVKjc/aOpd8k2lwFxe3yKMgpd2frLaKDzTYGzSoYoX3WmHGYY
rr5gTtAgc6GWg8JAtz7elmxsK3lwckppaySj5r4hFeJ3F2RQxbQh4egMxGMU+1Rr
2e1e0n3EY0hOXFdcpllceXPDpZskN3oqtPYFvbXKuVkF+lvw3Kv7/2Nc4QN3Xdvz
BaElSyBEbp6P56QW5wdN/1WMEU3ONYGpaYPgK0a2bWYyiudZy3RA1ryC+O/GgEDY
zvd7lVEmJSr7kcz77zSn0ob8ilCa4frJ8qn3Oqf7ehAgS9OGr7MgYZ8AAQnPQjZ8
D8AyFBKbD6JiTiu4An55Msr+bRG2eM3YwY8T7yKwOBKlgNPVH4lrFDDKYbNrFm+G
gtNstXLi9wl6IrXA+f9CtNMvH8Nf9rDgb8ss1Uq/t2nGCA8Xub8OVOmxG+iDwvVt
04WwC5keqqpRe6DOgoseS1qubj3IVxdDqFcGLPbkFpi4w5vufmoColT56fG0HmMk
S1GsmLHQQFMCIt36dROB+9beWYZcu63sdHghaC5pLXA3QhQwFXU9SPw9LKC80hSY
NjFYr7PdijudbgOouMbvG+sXolaFaY8T/MFIMe4Mouhz4vw6Pfw=
=cl43
-----END PGP SIGNATURE-----

--1BLLXfqazYqyTr9h--
