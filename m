Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+U/4Ti3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fhTvpCse"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75CE5
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 00:18:39 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 5CACA32021B8;
	Mon, 11 Dec 2023 03:18:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 03:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702282717; x=1702369117; bh=ac
	EIVAJ8Wez09uhyJTiT+54xy30Hu+mm26jDYLJrd+M=; b=K+U/4Ti3LWlPJi5Ki7
	2qu7iRQHbtDoUxL8l236PQkEr4R4HZNgHD3kXPyWqHW0xNjoYb9kZYqg9yr/CGvf
	WgD/RLLiFN8o8NYemeRDFSSTTtITTL/qVKgcXtBFK+0oPigOMqrSXSQxl0KRGAdx
	t5LR3bendad7Fsv23W7fRWceAMHBOcYCwhynXxGRlKyHUW398eAzOTeCsa7iF9ei
	cGm1nB+EpOguy/J+kxTJCM2ptXC4KbzHPuvXlisWWUsi+inPmvMtu7LjF7oiySH4
	L5J0pVa+VS/tt2wBHZnpQJ2QQjdZVybBPeigQvwFjpvuXm34NcbFkun5EWpVFL89
	KujA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702282717; x=1702369117; bh=acEIVAJ8Wez09
	uhyJTiT+54xy30Hu+mm26jDYLJrd+M=; b=fhTvpCsei+THy9bBd6wMcxlklmMy2
	srZdZjo1+hi8XCZlp0j3EH4Nhj2R+FY5yw4B0RC42P1fGEqygQHdUotYjm9LJh5o
	jWqPX3Dx8FGJbCzZ+rZfNj2JRuFYNlZwYgVbR09iFmwdB9azxsepDakGFmnVpU1D
	pVua7ruoRqDnD2SlKhVc9WrZMVV4ZNK2xrHsSmoUGLescM6mqkvWZMDsAApcSHUQ
	36a2rlgq+FEkjYeu+5iI1wNPYImWkpEx5q3IfsmP9AcCb7WQMd8TcbH+a+Nf4NBt
	rR6DQ0vzhesMLpMSppr/Tj00GieTQ9VcweYdtkfu4/4kB/fDPrZERfQHQ==
X-ME-Sender: <xms:3cV2ZRJ-7UWuVetLdStCXYA1r02qhMSGfhVeOt5bcib_pmT0TMD2BA>
    <xme:3cV2ZdL18EHFVq0ig9tXJHJ4zadVcXwb9uPWwJIQA1hGSuPRpOHYsiuCmwz-_jKyW
    0kpR-pKULUHmRAH2A>
X-ME-Received: <xmr:3cV2ZZuua0FmRXfZeSW7cnaye1Uit1cV9M66TtbOh4dA_v0sc9MRizP3lpw-zSmGDzWq_OQqol7XvdBXZRv4wfRa1vqkr_9c6XRQMwoNr4Mp9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3cV2ZSYGgD9HsBqLbbU76s5WgPPFlQysxzAUFL7qUOr_zgGk3u6cwA>
    <xmx:3cV2ZYaGVOq9gaoBzc_VJPpZsYwcNAEgDiqFE1iewAHA8-p1MItHsg>
    <xmx:3cV2ZWBHSG93iF4bOEwVxqmW8lLc56GQg2hCGtJASz8zF9TerYhDvQ>
    <xmx:3cV2ZXmemxwJzgVRSKAsT021xG6fDVAxzJzub-sTcfUQFFu2y9eTdA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 03:18:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a3e2d05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 08:16:58 +0000 (UTC)
Date: Mon, 11 Dec 2023 09:18:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/24] repack: implement `--extend-disjoint` mode
Message-ID: <ZXbF2O4qjIr2L7b8@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <b75869befba26899d88d6c6d413cc756aeadbd80.1701198172.git.me@ttaylorr.com>
 <ZXHE5Lce_6CAWKFT@tanuki>
 <ZXIq4mjDUoqlGvgW@nand.local>
 <ZXLRjeu66qE6J1K1@tanuki>
 <ZXOdPLotcS5daNke@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5WW4dz3tKGbmJrBN"
Content-Disposition: inline
In-Reply-To: <ZXOdPLotcS5daNke@nand.local>


--5WW4dz3tKGbmJrBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 05:48:28PM -0500, Taylor Blau wrote:
> On Fri, Dec 08, 2023 at 09:19:25AM +0100, Patrick Steinhardt wrote:
> > > > One thing I wondered: do we need to consider the `-l` flag? When us=
ing
> > > > an alternate object directory it is totally feasible that the alter=
nate
> > > > may be creating new disjoint packages without us knowing, and thus =
we
> > > > may not be able to guarantee the disjoint property anymore.
> > >
> > > I don't think so. We'd only care about one direction of this (that
> > > alternates do not create disjoint packs which overlap with ours, inst=
ead
> > > of the other way around), but since we don't put non-local packs in t=
he
> > > MIDX, I think we're OK.
> > >
> > > I suppose that you might run into trouble if you use the chained MIDX
> > > thing (via its `->next` pointer). I haven't used that feature myself,=
 so
> > > I'd have to play around with it.
> >
> > We do use this feature at GitLab for forks, where forks connect to a
> > common alternate object directory to deduplicate objects. As both the
> > fork repository and the alternate object directory use an MIDX I think
> > they would be set up exactly like that.
>=20
> Yep, that's right. I wasn't sure whether or not this feature had been
> used extensively in production or not (we don't use it at GitHub, since
> objects only live in their fork repositories for a short while before
> moving to the fork network repository).
>=20
> > I guess the only really viable solution here is to ignore disjoint packs
> > in the main repo that connects to the alternate in the case where the
> > alternate has any disjoint packs itself.
>=20
> I think the behavior you'd get here is that we'd only look for disjoint
> packs in the first MIDX in the chain (which is always the local one),
> and we'd only recognizes packs from that MIDX as being potentially
> disjoint.
>=20
> If you have the bulk of your repositories in the alternate, then I think
> you might want to consider how we combine the two.=20

Yes, in the general case the bulk of objects is indeed contained in the
alternate.

> My sense is that you'd want to be disjoint with respect to anything
> downstream of you.

Ideally yes, but this is unfortunately not easily achievable in the
general case. It's one of the many painpoints that alternates bring with
them.

Suppose two forks A and B are connected to the same alternate. Both A
and B now gain the same set of objects via whatever means. At this point
these objects can be stored in disjoint packs in each of the repos as
they are not yet deduplicated via the alternate. But if you were to pull
objects from either A or B into the alternate then you cannot ensure
disjointedness at all anymore because you would first have to repack
objects in both A and B.

For two forks this might still seem manageable. But as soon as your fork
network grows larger it's clear that this becomes almost impossible to
do. So ultimately, I don't see an alternative to ignoring disjointedness
bits in either of the two linked-together repos.

> Whether or not this is a feature that you/others need, I definitely
> think we should leave it out of this series, since I am (a) fairly
> certain that this is possible to do, and (b) already feel like this
> series on its own is complicated enough.

I'm perfectly fine if we say that the benefits of your patch series
cannot yet be applied to repositories with alternates. But from my point
of view it's a requirement that this patch series does not silently
break this usecase due to Git starting to generate disjointed packs
where it cannot ensure that the disjointedness property holds.

As I haven't yet read through this whole patch series, the question is
boils down to whether the end result is opt-in or opt-out. If it was
opt-out then I could see the above usecase breaking silently. If it was
opt-in then things should be fine and we can address this ommission in a
follow up patch series. We at GitLab would definitely be interested in
helping out with this given that it directly affects us and that the
demonstrated savings seem very promising.

Patrick

--5WW4dz3tKGbmJrBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV2xdcACgkQVbJhu7ck
PpS52g//eottqsbo3ZNKg6fxKoWcQ4KlYt3dpVnXUprnCG39jUTX09aJl3SwnmAI
U+rBcqcXEn0YGDZBqb0RwQdW6aKf//+LYKO6aHmTeJRHLwJv5eKkPUS+OJqtRwBG
//ttKpuLVMh9drBVgsEPK4MDmCwz5Wh/jE4hDI8pKXFXVT+pN4/Z1PZ4wQMaGtq0
yZKfeSq5jqz4WjR+ykaRBvgYhF+55pNW1q6XMCwYHsZScaN+Z3eMrOm8DoNLfpN/
kpchAVZ0i+ssebT5LKyGy+lqp9J58XfgEk1AOwJu+Ciqca+d8j+B1A5wfI0cjRCp
9k5raaII+I5r7eOwVBC7BXbRq9IW3/6T+W22LwpLxn+0aUcIOkbz+efewIQpeKIb
Qzb4oRcWz/DaJP6LjUJwIUfPWXd1Y/rHnqbGcpmdN/H3KogkKs8g48duKmseVPyS
5czK1KwBkTJKlodyPyRd0dCIl74XamWefoHguc8xklowXyc62L4/T39/cl+eFofO
PY/2CsDCPFBU/l0xxqFUc8nd92VlfJeCRoVkhsPqCMLlAyxA3RAMocs48rtdqRtC
NIjdjyP6wn8LqQqBzJPt2u6wR9IL6Bj92vwOY9cqy6OcPTShD6cVud4NjsuuHuuM
6yiHxu0lJNg6+GmcNm4iwlX/L8frC51xzU3O+3isfiJsblMjxgY=
=HJbg
-----END PGP SIGNATURE-----

--5WW4dz3tKGbmJrBN--
