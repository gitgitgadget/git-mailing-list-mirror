Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE221B274
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dw6evS6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5sGTfybr"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E93AA3200A28;
	Wed,  3 Jan 2024 10:52:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 03 Jan 2024 10:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704297160; x=1704383560; bh=qjXS8Ci5l0
	RyAjs6en1bgP6CWZ38m/my1gvVEfL0pJI=; b=Dw6evS6NWJ2YIvwD0GmAuIQ272
	hQJNImLcEoW6LSuA+7YUitg+AjnA+BOE42i6yaedZzusqcrflQcWBDKlh6bpql3Z
	s3971EEByAeZu6/PEcIb6gmAYRX1B4WP0ZMXEC7m+l51H3dI51heQi9JrVb1mXLV
	zOAKSYFNiXRED60XNJzgnXZD77SY6JOe/CJg3D9PIrEqA52BTSI5tLTRKTeaNUKa
	67tRh4AKUz277FzrHZpFHKIXyiH9Ii7BD9ysotAiUGeIx3teHG/izCd8gEmVxEX6
	bwmeOxOmIbLdOD9hlYe1TkwQcSo9TEUQgEpd/MIhh/ntK7zjBWEDELYC8KbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704297160; x=1704383560; bh=qjXS8Ci5l0RyAjs6en1bgP6CWZ38
	m/my1gvVEfL0pJI=; b=5sGTfybr8VUkP1zIkcm1LRA8fXNTelWOxiGy0GS6ICp8
	1+SbwEOUSJKx6HLMKXig895AWoRJswc0HslzY/IiNQGKBqo/9BRZ1DA5bPFKzZOB
	sk+BAPOx6jb6WdVQFvPpXdXeqzTSiDrmuKYaW1NHVZER+ukp0c7dUIy3W+kyYEH1
	I5a/AhdsKn3NNsA1BZ9d8fRe+cxhkvJ0WfA+7dKUN55NeZ5JYbRP+NJaWzeP6XR8
	4hsnZeFYfRzfwQUtI7KSeq8jjnhqnx+5cCtYNBP60edZz6zdCNCf9h8/pH4jmvHu
	a367YaZVi57nEK3PU/La1UXkHhAeTyn2l1qT/FJ12A==
X-ME-Sender: <xms:yIKVZTFWC5-TxFBY8hVskb4b9zNwmNOJG4rmQ4TNW0egh1FkU2eTvw>
    <xme:yIKVZQXVZSJIUDKENRoIcZjxGx3jMeE7Zrm7-ccErRxR3n6WQewCn48HUKb-9N3aa
    6V13cImrSxqq6C-uQ>
X-ME-Received: <xmr:yIKVZVKJutC0TxdOcB1zFC_KeOWyPqAu5yTVmkX0h_9XtzIwQRByU9fQJ7JNUJhhda78QNfL21NiWfvtjSlivwHdVF5WDWKr7OHy8nIG7NIejg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yIKVZRGQR28dr62SI2mm4k6gKCncCXjaOOLvkOEfrdCDZAfltsqumg>
    <xmx:yIKVZZVh13ao7ImmoOtriY8keC-HsQegCVu7GMNEjAQXy8SEwRe9PA>
    <xmx:yIKVZcMGo8dPgQ7W0qq4znCg38ymFD9rME6GsNmUMaxqf8y11J5MeA>
    <xmx:yIKVZcRhDvoet7bjyzlsHoxCr6aUwm94IYE6cCvGWOHIZ8vmQLbm-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 10:52:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0eb51b89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 15:50:12 +0000 (UTC)
Date: Wed, 3 Jan 2024 16:52:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWCxIHf9ySEOWEJ@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
 <CAOLa=ZRedfBUjukbN8dFT9CZETe4pz1UR+eWfJwORWuMHSk0Rw@mail.gmail.com>
 <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <ZZWBLafB3pIlZqpw@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DGofg0lS54i5g77n"
Content-Disposition: inline
In-Reply-To: <ZZWBLafB3pIlZqpw@nand.local>


--DGofg0lS54i5g77n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 10:45:49AM -0500, Taylor Blau wrote:
> On Wed, Jan 03, 2024 at 09:52:33AM +0100, Patrick Steinhardt wrote:
> > > I tend to agree that the special empty pattern would be a good shorth=
and
> > > for listing all references underneath refs/, including any top-level
> > > psuedo-refs.
> > >
> > > But I don't think that I quite follow what Karthik is saying here.
> > > for-each-ref returns the union of references that match the given
> > > pattern(s), not their intersection. So if you wanted to list just the
> > > psudo-refs ending in '_HEAD', you'd do:
> > >
> > >   $ git for-each-ref "*_HEAD"
> > >
> > > I think if you wanted to list all pseudo-refs, calling the option
> > > `--pseudo-refs` seems reasonable. But if you want to list some subset=
 of
> > > psueod-refs matching a given pattern, you should specify that pattern
> > > directly.
> >
> > Where I think this proposal falls short is if you have refs outside of
> > the "refs/" hierarchy. Granted, this is nothing that should usually
> > happen nowadays. But I think we should safeguard us for the future:
>=20
> Hmm. Maybe I misspoke, but I was thinking that `--pseudo-refs` would
> imply that we list all references (regardless of whether they appear in
> the top-level refs/ hierarchy). But perhaps I'm misunderstanding what
> you're trying to accomplish here.

Ah, okay. I think in that case it's simply a misunderstanding. To me a
pseudo-ref only includes refs that match `is_pseudoref_syntax()`, so
things like "HEAD", "ORIG_HEAD" or "MERGE_HEAD". So with that
understanding, a ref "something/outside/refs" would not be included,
but I'd very much like to see it listed.

Patrick

--DGofg0lS54i5g77n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVgsMACgkQVbJhu7ck
PpQR/RAAlIezKsJs2VdbvR68Oy7omAEyWj40A1kZd9l54y9P7Qwufcs+RfoBGraY
K5iujHXg1GXNlgezKGTAIOoXZpsXpA+/q7mKAQ+OzkpcUCHKDRWr8kPz7BFIbdz4
Mq1DH9f2gdGJl/vyrUqJPIdIMeuoiVN2VfsXkAVFAceLzVgcoP8svsIddu85aHJq
Yjs87MpiQZZKOtbCsZsRB9mmHXMmxV5R2Gg2z7xN4MgDgQ6betmVa58tNq8gbzv7
zWUhRhdpm48Qq1i+z/SdtXFdhMy3CJ2/psZ/LIY2gzqrAtKRyqWu9PsTvhD30pLn
ldOoIuPy2EGOQ6F0yt3qDF6uIPSRBpUM3/HedMketp+uvYJ4B3C3UFFqm8tH5wPP
QUahdKvVyIryQL6hUeD5i1Xtf1T6Sq5My//iZtwplbLxX+J4+bgVOm7JHLfcOvsq
9ZRsqtL/I8NHn4Yq8pfGa99+J755fWRfj4CKOComCqDZcB/xcjVvx1FBJFvKrfig
mnZooLTJral3nYnlu6FZVzAzvxICcOoSoTC1/u82h86ITsSg2D2KTlZRLSe2Yu8A
vSkvZ4Z8PDiAV7MvKb/QX8HSLFFg3Lpw6n1CqkmvorXcDk4+rhrSkSVx8/fBiD1s
oS6yPzYCeRsEdqgJ8L/U6ZhuDHmfTNjZ8dTJlYUW5SmsvEDmuAw=
=3zDZ
-----END PGP SIGNATURE-----

--DGofg0lS54i5g77n--
