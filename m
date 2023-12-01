Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OdEGd4V9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSJk/3r9"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7C810FF
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 00:17:46 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 6CD803200ACD;
	Fri,  1 Dec 2023 03:17:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 03:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701418664; x=1701505064; bh=M3
	x4AxreTJHgBBFQdetoCCtSEZ1+fM5S7ADa+xG/nYs=; b=OdEGd4V9Fpm2LKvlHt
	pDyxXuKCiG3dWxUp6lH9iHWTXUNTA9813w+S7pxI0IvU6KoCxQ6/0Kk9K0upSrzh
	0CJOhcdhGktr/8m9v2aB+kWl6TvaQoRHfrX4GZCYS9xoHOs3lEvVV1Wv0c1e97IB
	wjElqPp/SnC6k+/cZUeKguw9EAzRmHXqZ2l9XuR4udV1RUx0q8K+A0IKVzGYKB+c
	b9oKZiXWiiCPCfsiXZf2Nu9xLVTsBvgPkZbO3PhVVgc2vwt1GyaxLjYo7963TBfo
	ZFPxRmmkL/gUYKzda3Tdm4pGR5TWJ3fMA4xgvMzLsC79TWJbxBucXC117V9a4b10
	/FFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701418664; x=1701505064; bh=M3x4AxreTJHgB
	BFQdetoCCtSEZ1+fM5S7ADa+xG/nYs=; b=pSJk/3r9osdZ3byjX11fTHUUuggsk
	474wveXzInKtpFjatXmmvD72hQewPWeTdV8fpCrlNVHQyERbVg9w9LdDbvsgMsh0
	OgwflhEp+IIz3fyPU5FbrjfvEf55eZ0MW9qPM9mwyKQH4TBtl5vcNCuYcDbIvUAf
	ZXhHu1AahFYNCQYsF+Jw/KOFcw3UIa5v4BP9S6XTelEaOwZk2/EhOpSU0udaaMzW
	E9+E7EUOl7XXzHgrqjRmw+332+GyiSXf38yQ82B5ATM5WyMkRO4O16EtrOImcJWx
	vJnxagMN89gxiW9ytO15C6ZeIY7RVVTY6cWV88Yf1O1CK7SaC5VU4YOdA==
X-ME-Sender: <xms:qJZpZVKC7GCK1hgaplOBDcec70aYI5vV4vP42nSFvrTr8MQemW6Y7A>
    <xme:qJZpZRJFV0lYxIx8FeXmj1AV_X5W5PLaTDJf3www1BcliHVxpazPWLP3mBJhB7raW
    cQwzse-AcMNc58mxQ>
X-ME-Received: <xmr:qJZpZdvsLuIbxqbNFEnWvze5hLO9niZp9vzDx3Wda6WWMsBCZH3RfTbFHejCGZdy8NQkZjfSEzLGCUDxD_yMDKgYr19o3QYb3QcV-iorooz28K8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qJZpZWYHj_9WVrObzqXy241xMxQD--212h2YDwaQBveA0XlZdu4ZKw>
    <xmx:qJZpZcaO19JmYpOM7h-cFcGWTtrMlCRCt9sby8EgZBAZ6dwA36y-jg>
    <xmx:qJZpZaBKfEOJYQh1yfdtz9ir0rb_cK_cTlbD_u3V1m7Z6VAbOJtn0A>
    <xmx:qJZpZblu32giChrVm_cy_dXxEJ_oP-FdnePUWYJ1lxc9FSRVYnrB7w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 03:17:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ff3c702 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 08:16:25 +0000 (UTC)
Date: Fri, 1 Dec 2023 09:17:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/24] pack-objects: implement `--ignore-disjoint` mode
Message-ID: <ZWmWojF6BlOTzkcc@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>
 <ZWhhkdnVZ9w7tDBv@tanuki>
 <ZWjjSOJHw6Q1qQ+y@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fv4saU0ev/1W88jM"
Content-Disposition: inline
In-Reply-To: <ZWjjSOJHw6Q1qQ+y@nand.local>


--Fv4saU0ev/1W88jM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:32:24PM -0500, Taylor Blau wrote:
> On Thu, Nov 30, 2023 at 11:18:57AM +0100, Patrick Steinhardt wrote:
> > > Instead, teach `pack-objects` a special `--ignore-disjoint` which is =
the
> > > moral equivalent of marking the set of disjoint packs as kept, and
> > > ignoring their contents, even if it would have otherwise been packed.=
 In
> > > fact, this similarity extends down to the implementation, where each
> > > disjoint pack is first loaded, then has its `pack_keep_in_core` bit s=
et.
> > >
> > > With this in place, we can use the kept-pack cache from 20b031fede
> > > (packfile: add kept-pack cache for find_kept_pack_entry(), 2021-02-22=
),
> > > which looks up objects first in a cache containing just the set of ke=
pt
> > > (in this case, disjoint) packs. Assuming that the set of disjoint pac=
ks
> > > is a relatively small portion of the entire repository (which should =
be
> > > a safe assumption to make), each object lookup will be very inexpensi=
ve.
> >
> > This cought me by surprise a bit. I'd have expected that in the end,
> > most of the packfiles in a repository would be disjoint. Using for
> > example geometric repacks, my expectation was that all of the packs that
> > get written via geometric repacking would eventually become disjoint
> > whereas new packs added to the repository would initially not be.
>=20
> Which part are you referring to here? If you're referring to the part
> where I say that the set of disjoint packs is relatively small in
> proposition to the rest of the packs, I think I know where the confusion
> is.

Yeah, that's what I was referring to.

> I'm not saying that the set of disjoint packs is small in comparison to
> the rest of the repository by object count, but rather by count of packs
> overall. You're right that packs from pushes will not be guaranteed to
> be disjoint upon entering the repository, but will become disjoint when
> geometrically repacked (assuming that the caller uses --ignore-disjoint
> when repacking).

I was actually thinking about it in the number of packfiles, not number
of objects. I'm mostly coming from the angle of geometric repacking
here, where it is totally expected that you have a comparatively large
number of packfiles when your repository is big. With a geometric factor
of 2, you'll have up to `log2($numobjects)` many packfiles in your repo
while keeping the geometric sequence intact.

In something like linux.git with almost 10M objects that boils down to
23 packfiles, and I'd assume that all of these would be disjoint in the
best case. So if you gain new packfiles by pushing into the repository
then I'd think that it's quite likely that the number of non-disjoint
packfiles is smaller than the number of disjoint ones.

I do realize though that in absolute numbers, this isn't all that many.
I was also thinking ahead though to a future where we have something
like geometric repacking with maximum packfile sizes working well
together so that we'll be able to merge packfiles together until they
reach a certain maximum size, and afterwards they are just left alone.
This would help to avoid those "surprise" repack cases where everything
is again packed into a single packfile for the biggest repositories out
there. But it would of course also lead to an increase in packfiles in
those huge repositories.

Anyway, I feel like I'm rambling. In the end it's probably going to be
fine, I was simply surprised by your assumption that the number of
disjoint packfiles should usually be much smaller than the number of
non-disjoint ones.

Patrick

--Fv4saU0ev/1W88jM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVplqEACgkQVbJhu7ck
PpTNkA//ZJcgANOveHQ/FoylgUgoXV9u22a9BR3vXjfUZ/PMzYphyoIKu3B6OZz0
ZhAR8MauOEb0ICBx0nn6DehVxXRUeNXroQFfrZPwyKSfm82d24eVqMKfNONvCbUE
COfgNB6ag826kRWMwbAFMYWjGzl23xoHAeo5EJevrKmyORHQlNph/jvwP3eAunRf
HX8TvvYkbfiA5KmeKMWhv795kaWZ33fVA850dKxSXS8cWvHyXkxMPQmB4fPGmf/W
hRb1JaXypjKp5S9ctJO370cWMLq6zcXEN+FPB59zKmffKY2rZdeww5whGhmwFVCR
JHTzcUE2/5R/waqhmBJHqPNAeEXrqY/O/je9eCRzUhSKAYSEnasOnHaT6VhsnoeH
yrFL2xP7tax9HIxjwMGPbO07OVrpq8fMqopj2caVJutomOxcf8tcd3Wj85nB+/BV
QJCanvFHOm4h+NAvpjBZ33m2caTJpnY/VluthAIHog9lQtOOlbX750QecUFC1+Gs
DY0E5Z//aTnFR9fgs7tKXZYAg3kbwpdDsdjLJUrogDJ1x0ufrglev8PSGdPvy0UR
5RU99uvaa+8qYAdgjKKo6FllReo6vMESp+eCr56lszKWte27QMjTm5AGO4c7vr6e
ko27DXLn8feNf49mzasgK+a/6sV8bqzDEIoefy1eoEF7dfZ5ZiY=
=ZRZt
-----END PGP SIGNATURE-----

--Fv4saU0ev/1W88jM--
