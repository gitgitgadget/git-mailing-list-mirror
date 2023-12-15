Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61487DDA8
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xhe7JWpR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7cETM9d"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 35EEF3200AB8;
	Fri, 15 Dec 2023 00:36:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 00:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702618569; x=1702704969; bh=z/xNxMzHHU
	j2PmF6NgtgfX2b6w40jZVwStb87OmOYdg=; b=Xhe7JWpRNtOMG2X0XX9wkHVjTE
	KEkD5e6t7Kx+KzZcNC642mTi0W3HWEsOr62S0g+90RLWKD+jW2PdKS+6XhyDFpDf
	OLN3SIKhYVGf3+kCVrCodQzgjU00AtL3twNToEroaC2yavAtLnBler4b8192+rUL
	2thxI2xODPgFe/EnwaJ5OhDAsYQkPn8Ejd722gkUK6B53tQu2DjFdNyTR6n1VzgG
	38rQUo3xb7MqI5FEtr98NUruxmr/UUWUJPPDEuBR76awNRdzzBSngykqoN0xBAZZ
	wG42UDI3toyxgVkpqgs17sl23u19nvAlBwol+oQ6NUU7CM3fMI84hleX2P2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702618569; x=1702704969; bh=z/xNxMzHHUj2PmF6NgtgfX2b6w40
	jZVwStb87OmOYdg=; b=h7cETM9dGYjZCYMHuq2M0Y5hW99F6EgK1F3FsohvGVqj
	tP7yGAsCNJtndVMPkOhWOLkFxpipJyAer81o2jOV+hgExPlpK1VjRzCNLnEDwPzY
	zpwApfG7tR9TmhkKpE1UGUcX77XE8gXRtQgjTP4H6Le+0NyW4RUJH4Q3C9O1hG2Y
	Tdjd0GwTdFVm5VKr2Efy3jJgsDG5Xk3CONXMh1xywbcqWPCTuNrpz7Q/v9Ql4jPs
	aHQWlwDteFxmhEfEcv1h7UrcmZ6atUO7dKUK/wRkMZPvlVqo0rbUI96oXqmUwAVE
	yWgjX+5DtcvzAz/QmZml8B24Fymy6+IWxksxt5Pj1Q==
X-ME-Sender: <xms:yeV7ZdTLaf4OW6fkKF7tq_qkaRKtWtqWGkAi0ZM_9fgEKFUPB-2KAg>
    <xme:yeV7ZWxdkmcl5dIHNuAFprclzHFLfN3cvjmoMLf0kmQ7cCkJwbEryVviOwDhyOY-t
    pZsAHmAqqrWpgyM4w>
X-ME-Received: <xmr:yeV7ZS0nMVgP9u8VyMSASHflEUTv9K1NXS7ekfE-pcpzOMlNs5_LnArm_bjeio9hlqNqg-9c6M44Gx3T-YRrIQigKBX2WdaLBdomBCywkmXkRX0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtuddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yeV7ZVCIfx6ybuUA4IF6t6U3vfPLoU4o4cIPrKDEYrMg7KHO-CEMCg>
    <xmx:yeV7ZWiuyNaikVKz04CmWFdtTCqsGP3SwBo2euw9GQXdbSGkPrlDhQ>
    <xmx:yeV7ZZpO6jhV_Dks-3yGuRAw-41b2TIZ6Y2iskmiZgUXVIcsLmNJIw>
    <xmx:yeV7ZXst8MRVJsYjNyEAnpErEQE9Dtb4nEOAZKB3aa_smXksSd4HWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 00:36:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id caf067d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 05:34:23 +0000 (UTC)
Date: Fri, 15 Dec 2023 06:36:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org,
	Eric Sunshine <ericsunshine@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: drop dependency on `git diff` in check-chainlint
Message-ID: <ZXvlxqsCV9GJ7580@tanuki>
References: <20231214032248.1615-1-ericsunshine@charter.net>
 <ZXq3YdK2RSKF3npE@tanuki>
 <xmqqo7esohjm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="87OUZk/I3tr176Z4"
Content-Disposition: inline
In-Reply-To: <xmqqo7esohjm.fsf@gitster.g>


--87OUZk/I3tr176Z4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:49:49AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > This strongly reminds me of the thread at [1], where a similar issue was
> > discussed for git-grep(1). Quoting Junio:=20
> >
> >> I actually do not think these "we are allowing Git tools to be used
> >> on random garbage" is a good idea to begin with X-<.  If we invented
> >> something nice for our variant in "git grep" and wish we can use it
> >> outside the repository, contributing the feature to implementations
> >> of "grep" would have been the right way to move forward, instead of
> >> contaminating the codebase with things that are not related to Git.
> >
> > So this might not be the best way to go.
>=20
> That is not a conclusion I want people to draw.
>=20
> Like it or not, "git diff --no-index" will be with us to stay, and
> "--no-index" being "we have abused the rest of Git code to implement
> 'diff' that works _outside_ a Git repository---now go and do your
> thing", we would eventually want to correct it, if it is misbehaving
> when a repository it finds is in a shape it does not like, no?
>=20
> We should have what you quoted in mind as a general principle, and
> think twice when we are tempted to hoard useful features for another
> tool we initially wrote for Git and allow them to be used with the
> "--no-index" option, instead of contributing them to the tool that
> does not know or care "git" repositories (like "diff" and "grep").

Okay, thanks for clarifying!

Patrick

--87OUZk/I3tr176Z4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV75cUACgkQVbJhu7ck
PpT0IxAAhQV3JPa0slEQoS0eEQcZU5t421ZcTIbgsObWmArFS9rV8EsEPIHes3to
aEd5Y8PQ4qNSOgsdg5WtPhhYMffRTsygCsQABtCQ29E8YkhL+y/J5+M1ecA1NMr7
gz7BBJ+UljMhv97opdjuekfRvdFMZFAl5g83C4zlL+539Uf1jyHnx8gQSmHmBXkG
dzrh3v4JRLTFdfFODoVsPIkF8uFFYLozc3clJd7jkxERE4XxEykTMITllDIUmOQl
jUDcGmLNd3vSjS4BnteVcW1u/8h5QB550ZQ6WQogxuhO9djtloiOwPRvFwfUTpKk
ghw38B7859tzdmTn8Awe5OH2IGytZKymjIfWks355GcVY8hWvKEB1ikgHdAFRDXw
fLBGL+b1LHZKnNq02/2PBLg/AXIPMf/fkcmblEFhR+U94VpNaFYiuKnjR0X7K97V
bEx67heGyD49sTfw9r2JeCIEqzH6v3d1++8yS5ig2icl1OaOHuFEajOPX0rrUP7/
JSC8k2eOcIF9p07zu4Q6FnBEQ0/fZbMA5PsNBXJrHiCc26pAObVAfNJ74ioQ5jHP
Atd1xelM2hW5i50IhLycUiNgSeBYu/kFD7WQHBOdoKD4DOFdWbfr6OQm2rh+HbFR
Xb8wEiSQhcQXpujdtfr5EVxcxIN1jIiU9VQjZG8kdnylHnykyQQ=
=HbGm
-----END PGP SIGNATURE-----

--87OUZk/I3tr176Z4--
