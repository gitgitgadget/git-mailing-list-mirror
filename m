Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8D18624
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tGdHn/8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiJrdWFz"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A7D545C006B;
	Wed,  3 Jan 2024 03:33:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jan 2024 03:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704270806; x=1704357206; bh=kuao2uUHQN
	FiRFrzo8tjgkTcLGiPCkUk3jUdoxE8Pqo=; b=tGdHn/8DBGi08m0nBscqX3Kcjj
	GgxvQjc+r12w6TH5n2DJ9iR5N75hdury8Fukd1Pv/kfcDeCRva8wDlF+M22K7RNt
	kTg+jWrSn5TNa0KJVWDJWzKXi24axHIrcMgszOq24MNecLWvMM+l0Hy/QicDPj1I
	ZU3nXXL+KsCwF3TldjQyXnJa4WfTh2m475ROfXN9zLoSxV4f1sDXprppnb4bNNiz
	ikILqeiaeptexNSnDRNnvPkiH7gWA9RHP3yoMN8yMdpktPlgWK4WgCaDuxdu9YAn
	mFx3nVU9WmHu1m6bZfssMioyoXU52tUiH467orZWE/ubGMSGSnyDi4AxfgWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704270806; x=1704357206; bh=kuao2uUHQNFiRFrzo8tjgkTcLGiP
	CkUk3jUdoxE8Pqo=; b=SiJrdWFzY9g2BPojYRy7ZA9NTdtgkp7xUWMXP3v6x8a/
	3hbHFqR9V0UoGWKCFxWv4GZ3ayY7aACj6ewiQL2aGf6TnJhUxmY2xbxF0MOrUHhV
	SF0uOqyvw9JZm55Okfm/r+BGAdVsHJxnzVEBHiVk+NnxTJEO1O13HR1Q9Cegdhvt
	G6ayBiWTsbdYZAEeQtrsQ8IO9sh0uBVBfUSVCwjcpKqnyZhm6CoFZKGlIBkd45us
	Jqat+wL2UuSnBR/fqhMW7NvDxbzfQA4ffZGgMR/0wFtZ9rUca3JVHOAUl4t/o8lE
	0xjuWlCYIlBtGAdLhPWmQ45QvVsGDes1muTmsMKOGA==
X-ME-Sender: <xms:1huVZVn9v1kqWYEdwBY6E8vLRqcrDUzSD_-P3Gucr9N7mSdZDfmi_Q>
    <xme:1huVZQ3xXrh-agrEARzIU56tsAMzWRlVk4F6TTCENQ3r8RjDnRon8y-LQOEoFqkKz
    YF3O4Zu6BEBcOZB9g>
X-ME-Received: <xmr:1huVZbqoWkKns4BjIWNoLJXbv8dTcuehVBu5oxldjIV1dcEPBQJQDtj5-tp7vyvSJSZdzslvtNyVfcs7OQCRQFkSjy7Hp7hj6_PX7MK4o05rWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeggedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1huVZVlfjNAUL4UaGhXFCJDN6Wj9e2VWfAWJVfcceios0twBb1uacQ>
    <xmx:1huVZT1Tvjn_rHUTwZqQ68O8qWKSGpWnUDnVbnUaZxhAsPm1rZRwlA>
    <xmx:1huVZUvb9LefvIYd1lwZjhH6klOn3ecwvL1WmO3vvDRjofpTJFih3w>
    <xmx:1huVZQ9jqu19CcplEn-nf2s9ldVi5UwvtWrVppKBFsaz07C8HC0vhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 03:33:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d8e86a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 08:30:58 +0000 (UTC)
Date: Wed, 3 Jan 2024 09:33:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] setup: move creation of "refs/" into the files
 backend
Message-ID: <ZZUb0rj7be6wLQz5@tanuki>
References: <cover.1703754513.git.ps@pks.im>
 <ae013eaa4aba0d68172ff03dbe9f2c2bca596285.1703754513.git.ps@pks.im>
 <CAOLa=ZTR6aW5aoxcMOS3U3TL1VxSfmyVno9fu7B5201pJTqyyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="izlt0sxPtqHSkJFY"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTR6aW5aoxcMOS3U3TL1VxSfmyVno9fu7B5201pJTqyyg@mail.gmail.com>


--izlt0sxPtqHSkJFY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 05:23:18AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Move the code to create the directory into the files backend itself to
> > make it so. This means that future ref backends will also need to have
> > equivalent logic around to ensure that the directory exists, but it
> > seems a lot more sensible to have it this way round than to require
> > callers to create the directory themselves.
> >
>=20
> Why not move it to refs.c:refs_init_db() instead? this way each
> implementation doesn't have to do it?

True, that would be another possibility. But I think it is conceptually
unclean to split up creation of the refdb into multiple locations. The
"files" backend already has to create "refs/heads/" and "refs/tags/",
and the "reftable" backend will set up "refs/heads" as a file so that
it's impossible to create branches as loose files by accident. So both
do have specific knowledge around how exactly this directory hierarchy
should look like, and thus I think it is sensible to make the code self
contained inside of the backends.

My opinion on this would be different if we expected a proliferation of
backends to happen, but that's quite unlikely. Furthermore, we may at
some point decide that repos don't need "refs/" and/or "HEAD" at all
anymore, at which point it is easier to drop the creation of those files
and dirs from the reftable backend.

I'll update the commit message to include these considerations.

Patrick

--izlt0sxPtqHSkJFY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVG9EACgkQVbJhu7ck
PpQM9Q/+JfQlINzGyNJ3i0onBSwwRiCepzml8aHea6gU7Fd6AI7VcvLSnh07FRqd
HdhoSwx/V7X+fM85G0s8Nn1S2NTLWF1bZbqpg8z9y6hQUPj8hdo+rmlYr2CyUqbL
YWyjXiMDMwE2nu5PnCzvj3rl1NiPsDQXzf44u7oKRZYyvnExlcXS2xb1YdsvZzE3
8WKBeg3CkV+43WVnW/P9danoAqFuJFSznneRyLIzg3kbZYoIu4BFEgiyZg1gf0Zj
kvzf/F5yPCaRuoAkKiSSRmweiKu1E/3gvl60zYjwno5VKAgL2hKw9yTQKoBos1V2
WcDLmHBKdJWRzad5BVKcA97/KO7MfIXIys7ufDJpON/pK0lTpn/SjvEacWfbIfK3
/LBac85uiqqsMdLJYuUCxQ9HmTkX2cKtwuuvd0Y764UK299QcSxSnv2ncMsxDIB3
JA8sfAhIt2TEmyhBLn1XLYQhRLrLpImNgsDVUi8llVUY4HXViI2H4Kiu8IPhu0BV
W6jWr9x4s92r7HuzErEJxWh5wk5X6ODCBBdA62TWgoqHFHvZBzXtbjOTYnvpXjnb
Gn3PLzJs//XpY3p9zhZZWQK0Eok77kkg4hXJLUSBNTgaDZFv3mrd6Z8LYwb9E3zm
iIUKhX5qq5tFZiqdOK1kkPL4KlTwa7I1NhDGdgezQM75u4c67vw=
=TZBH
-----END PGP SIGNATURE-----

--izlt0sxPtqHSkJFY--
