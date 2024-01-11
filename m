Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D76AA1
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l5DXvEXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ual/VVa/"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 0166A3200AA2;
	Thu, 11 Jan 2024 00:05:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Jan 2024 00:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704949504; x=1705035904; bh=xTf7blrUNe
	D/E3S/8pORKsVrTt/QCH1z+bj/YQ6sBIQ=; b=l5DXvEXFK6+bakrdu7pLhrmbq8
	CEc76qARO18137rkVuYcVDBSdr+PbIrkd8yfp/I4NEistWTEc3DHkXx8DCbEgIQA
	4h+PXt37WIF/gkWteVc7cPxA1sVM67Hzkf+AQwwogc9SDoT0qzrjcwgeRSJLAk5S
	fNJbC4n91sKzmpIVsgtpG9bxFkoQpT2u74on/JgVDze+P2PIil8tYOqv1W3l+rRL
	Vup4PIR5H3XIEw+84qDkeJM7qKhI6gTo8YkGod2reF511ogPDX3ChyoligVeT/2r
	g4XlcE4AGe4arcakN6bLMQOX5f30VrT3BmKLge6huxkaCtF21vCwHfzRDRGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704949504; x=1705035904; bh=xTf7blrUNeD/E3S/8pORKsVrTt/Q
	CH1z+bj/YQ6sBIQ=; b=ual/VVa/Pl5gVmQ31HmXSkV+wbE7XZY6rTFHNQeAk+ud
	JC5hH5qoAzimjPErEbh8nz7E7W2hzLKKNFkgk842p82ZtEDacIHW5LY7WLQNg6PH
	df1JKuSJTEOWfXKo7gdGIqaxqJQW/WhMwpLLrjmjZ3TEI+dbr61G16tx7Tqebs4J
	bIwQSjAcYVrKkHW72beXWfjfP4FfJtcGB6OL2y2ZvXLt/z3Ypreds97EhpHszusz
	4egWuwIkwt/zDUiaky81yI0kaPNobENYiKkVu4Hm04WyHqRnZovF0f0qrKgkwmu7
	WcO0ALH7+ThoXX4Wmi0zi9OoQ8zZRaBGKmgF7gI49g==
X-ME-Sender: <xms:AHefZVbVmyTArk-Z1x7vap52V-57aFbiOymCK0YHY0MFHJloj5eNJQ>
    <xme:AHefZcY1Qx8RKXhEP_ME1iC9YL0wGIw17l5oyjZ6vk4tuowfol9dKHgsqtJYYQE56
    lGJ_ezkQWL5Qev0Bw>
X-ME-Received: <xmr:AHefZX8h1u8qL1ryzWR1CskRN2hZe9JEittABteU8m5hYRScOhwjiJTJHm5CXcXeyoQyPLkB3WkwTmoa4hANTfLbrBzKJczODU6xftRRiu3lZy6oKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeeihfehkeduueeufeejueetfeelleejkedukefhieffjeevjeehfeelleehffev
    necuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AHefZTrJO8jaS8zb9qC1BFx8vi_kCDEF5epZdcj0cUAOl-TjxI8bkQ>
    <xmx:AHefZQqO-gFQ3QUzhgH8a85MhUJ7VqvI5ExGKeMzy-MyBWEdzgPCaQ>
    <xmx:AHefZZQSahGWAQqr3U0QPmC5zV0hZeaQgo1ic74boOWdhLErfb-8Xg>
    <xmx:AHefZdABaSgDJLmacGd90pF5ZHYJQR7eotOCeRHtAzlD4RDB3B76Xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 00:05:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c52a78d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 05:02:20 +0000 (UTC)
Date: Thu, 11 Jan 2024 06:05:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] t1419: mark test suite as files-backend specific
Message-ID: <ZZ92_PdDwPTgaJ4f@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <d7c6b8b2a7b3b4d776f06ce577bdbdbaff66f225.1704802213.git.ps@pks.im>
 <CAPig+cTAiEFu9p1nRe9LC3mxyPmfQ9m4r7aQUj_9OC8pSbwbig@mail.gmail.com>
 <ZZ5HrY76O1x8QABG@tanuki>
 <xmqqcyu9duha.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yJHhJw+ZyvWmmRd7"
Content-Disposition: inline
In-Reply-To: <xmqqcyu9duha.fsf@gitster.g>


--yJHhJw+ZyvWmmRd7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 08:27:29AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> On just this (non-technical) part...
>=20
> >> > file, but not for loose references. Consequentially, all callers must
> >> > still filter emitted refs with those exclude patterns.
> >>=20
> >> s/Consequentially/Consequently/
> >
> > Hum. I had the last time when you mentioned the in mind while writing
> > the commit message, but seemingly misremembered the outcome. So I now
> > looked things up in a dictionary, and both words seem to be used in
> > equivalent ways. As a non-native speaker, could you maybe elaborate a
> > bit to help me out? :)
>=20
> As a non-native, I often find this
>=20
>   https://trends.google.com/trends/explore?q=3Dconsequentially,consequent=
ly&hl=3Den
>=20
> fairly useful.

Good idea, thanks!

Patrick

--yJHhJw+ZyvWmmRd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfdvsACgkQVbJhu7ck
PpRwwQ/7B1XW8mph0qD+YtuY/eKJTnTAI9LxkPSYecPad1zKafspj51iaslcwyDH
EjzXZ+tP0DhSVZho70VqmoDAUoTa9324P7AHt8jaEoK45Wr8HveIhZLev1OfGKlm
tPlH/T5b40LqL2PwGXpf0kAJe/GQuULzBKFbYVfLkMs7t0HryUU7Yk9rc+yGkDjs
keOsdnCHUZSauFB2INObrhPxU86fTlIQfi8QgGRpSr0wpVo7fjOoeTvCyg9+Dwok
N/vggIP/k6KpshAf6nDzte1gJ86ojM4gI9tCYJx2won1dYAdHNEiqFKiNvXio5gj
8lO3VS8jHH1s8Q/qYmKsK+VTOPtUAsLC9TOyEWCGeWLVWBnwOPrSRVFRNnRYBXcB
ZHKBGGEMEgQEQj7QpVEG9iSIoqXNSZwaAVOqypKkAOTsA/sojsiULFGDKgGRuvN/
dux6pwoAaS0pwARl+55ybk5hCB7lVvgTmzyuhOln5OdgZdCUv2d2yShThw6ufODu
lpbAHPS4wCkyYqzzLjQY/pvRwNTGlHs+kbkDMW76IcpJA07kU272h9gYFB9g0DLG
1Mwk+PwhLhsgoLeYjcyy+xKYWJnLqjsZ8ySZ2dZp+A3xtxucIsN6QggOa26xHYUy
uvGy16VVIiGqb9XgfydARFaVbkCc0Y57JV1iJWvpss/Wj/hkYm0=
=qoNx
-----END PGP SIGNATURE-----

--yJHhJw+ZyvWmmRd7--
