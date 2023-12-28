Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAA63CD
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lvzzIV2S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="djv2n4kA"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E775B5C0095;
	Thu, 28 Dec 2023 05:34:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 05:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703759666; x=1703846066; bh=+4hr1G92QT
	kqFZMEU/mTvYqIevWoTcsD81hY7Oi1QYI=; b=lvzzIV2SeQn69v96Tt4E7SsVRD
	0VN6tIvcSWS8A4Z+VquDz2+Nri9q87Q/mtdKDcL9wCf53oD5RUorpUCt/mlQWNDV
	T6nv6ZzN3o46RIvsPOFydC7jwtDmswlgaQ6cuQJN315nvEi9TuuYfthlhu8k5em9
	uzc7nQ5384YKYIGIe7Tblps0XiXXBSyCYp4NCy5NkdM//2ukkIpMBQfMz7/AHtGj
	VC4wKDUM/puA55DHkP9MJfPB34mzB+Ul2NigHuIuQSsHgD7o10oshs87nuYk0N4d
	1ozLK2IVqklLjEmNCUjWDJI4B7k2a0vUUr9pmB82pufABo2VzRjWzkt401Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703759666; x=1703846066; bh=+4hr1G92QTkqFZMEU/mTvYqIevWo
	TcsD81hY7Oi1QYI=; b=djv2n4kA8GYfDWc4XGRJJ2vYYbYW7OMd+1XrdTzOi3lB
	asWJgXhxl3TBqfJ+XkC30/hQNHnMJJM4YhySv9bzy4bJM40EqFNThKXi2ZbBZfMS
	YcDID8/A9otO4L3LDq0LcD9Jm0VRwRSyl/5hZ2nGDNo4dfEJbDJEB1tmKyPdWugF
	oP87RBv3h91rNKQVbxu7aJ4vRSgs+YDvLcxbwIsEb/+Isci8S4Pn+QFjMsaocKhp
	eW6D/xvD/Rv8fdjFh7Cjjy9QGlkx9Er27b1duEKPWNRQwOwGvnxyGG2TukwuOuVi
	RKtEBAkLYGFAoGz7MKov9pV5o5LBPLb1QH0BqopkgQ==
X-ME-Sender: <xms:Mk-NZTMjMeuzCL_54s7ZDNnrQJMKvHE7rUWvuq7tySJxIjYvwZ1OUA>
    <xme:Mk-NZd_qhT6F3f1ZwpDPHysKvy29Qv954HE_XwIuLl9NFhy2qJb7j6kFTY3FuFbYD
    6VRlwX9is8SWjFZgA>
X-ME-Received: <xmr:Mk-NZSSz_c6AIx39Ov1iKTwA_NQy2eHiM7_QHeq7BQCmF0TRpWXXLfE4nEK4HW821L0UUX7DfFX2i4dvi0U7J7t_Ma5p-Xxd3qK0WR5r1CFReQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Mk-NZXsKC7MqIvbmdCO9JdPeDx17ZFJCT0zFkwxT1YWx49PL6ZrpVQ>
    <xmx:Mk-NZbe8xbbuxewHVU13_tDGUFye6T09kG9EqGUy-BEb7hCpAr2xhQ>
    <xmx:Mk-NZT1gWKUzrHQq6Tp7QRUCjo10xbIOB9y-_kYoHDlo6jFt8yJm0g>
    <xmx:Mk-NZcoJ8QtpR2yRdpblJTXRokkcs2xNKcOvm2B4WAcjsPcDS-eoLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 05:34:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 736ddd77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Dec 2023 10:32:10 +0000 (UTC)
Date: Thu, 28 Dec 2023 11:34:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZY1PLtPue4PgbhwU@tanuki>
References: <20231221170715.110565-1-karthik.188@gmail.com>
 <20231221170715.110565-3-karthik.188@gmail.com>
 <xmqqzfy3l270.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxZAxkSEhaSyT5Wc"
Content-Disposition: inline
In-Reply-To: <xmqqzfy3l270.fsf@gitster.g>


--oxZAxkSEhaSyT5Wc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:40:03PM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> > With the upcoming introduction of the reftable backend, it becomes ever
> > so important to provide the necessary tooling for printing all refs
> > associated with a repository.
>=20
> We have pseudoref (those all caps files outside the refs/ hierarchy)
> as an official term defined in the glossary, and Patrick's reftable
> work based on Han-Wen's work revealed the need to treat FETCH_HEAD
> and MERGE_HEAD as "even more pecurilar than pseudorefs" that need
> different term (tentatively called "special refs").  Please avoid
> coming up with yet another random name "operational" without
> discussing.
>=20
> With a quick look at the table in this patch, "pseudorefs" appears
> to be the closest word that people are already familiar with, I
> think.

Agreed, this thought also crossed my mind while reading through the
patches.

> A lot more reasonable thing to do may be to scan the
> $GIT_DIR for files whose name satisfy refs.c:is_pseudoref_syntax()
> and list them, instead of having a hardcoded list of these special
> refs.

Agreed, as well. Despite the reasons mentioned below, the chance for
such a hardcoded list to grow stale is also quite high. And while it
certainly feels very hacky to iterate over the files one by one and
check for each of them whether it could be a pseudo ref, it is the best
we can do to dynamically detect any such reference.

One interesting question is how we should treat files that look like a
pseudoref, but which really aren't. I'm not aware of any such files
written by Git itself, but it could certainly be that a user wrote such
a file into the repository manually. But given that we're adding new
behaviour that will be opt-in (e.g. via a new switch) I'd rather err on
the side of caution and mark any such file as broken instead of silently
ignoring them.

> In addition, when reftable and other backends that can
> natively store things outside refs/ hierarchy is in use, they ought
> to know what they have so enumerating these would not be an issue
> for them without having such a hardcoded table of names.

Yup, for the reftable we don't have the issue of "How do we detect refs
dynamically" at all. So I would love for there to be a way to print all
refs in the refdb, regardless of whether they start with `refs/` or look
like a pseudoref or whatever else. Otherwise it wouldn't be possible for
a user to delete anything stored in the refdb that may have a funny
name, be it intentionally, by accident or due to a bug.

In the reftable backend, the ref iterator's `_advance()` function has a
hardcoded `starts_with(refname, "refs/")` check. If false, then we'd
skip the ref in order to retain the same behaviour that the files
backend has. So maybe what we should be doing is to introduce a new flag
`DO_FOR_EACH_ALL_REFS` and expose it via git-for-each-ref(1) or
git-show-ref(1). So:

  - For the reftable backend we'd skip the `starts_with()` check and
    simply return all refs.

  - For the files backend we'd also iterate through all files in
    $GIT_DIR and check whether they are pseudoref-like.

Patrick

--oxZAxkSEhaSyT5Wc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWNTy0ACgkQVbJhu7ck
PpS5HBAAmatLoGBJxEh98iH268KW6yIO0rLRoKKaNSsxqDeS/rUWyD/0yStrDT4N
dRT1B5heZaOof3MwzXEsBucz0P8Zh86IkYXtI6C8HDOiNQBNJECspwwca10uwO+k
3XMvWuhI1TkpFFedNMg+AoA/OgJbxeS/ML3Sv2TXf712Vu2k3aqTAKPxBjX2R+ii
7ZycdLZCOTTN1UsoYHpkIwBoxylADcCU/TH2GYj/7lvUUsKV2HaF5l0nUY6IBAF3
FH5gd0U/fpY9srivBLCDysr1zMZdR+V6BdzxsEqXnIHDIMzPRwt8nvZgr34hyYSF
tNFBRtE9sb6QZwLXcqGKuZBKeI+abwVOU/AT/V41snis4iITRLPStHSopZNGHC+j
wrjQPfsI+yew+jjGbgw2SQk2WOdBSnnNHCrR+3BoNBzOrnguG8jGrsb2E4eWWqYn
JxG5BYY2WWwKDgoXFvNvJqdGlNr8pPQAztwwgP6pk7HsKs7QHgB7s3NCmwp8bsQV
lfIINN7JEyYrgh9hs+R59WpD8GUI7piW2qQaSDT5IQ9dT16fzeDYlq+2GxNozxS9
/GCND0IHImPDh85cM1VIjCuCv/G8lTXfctfzHqnW90de+uvInBzXrYu6PLD2HdBL
kad5gUmb/acKnS+MIE0TuRd40FX0VCAyw9biA5hoP12hm/CZLqk=
=nY5E
-----END PGP SIGNATURE-----

--oxZAxkSEhaSyT5Wc--
