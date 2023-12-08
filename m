Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Su6S/xTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yduoodw8"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1BF172D
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 00:24:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id B5EFE3200A73;
	Fri,  8 Dec 2023 03:24:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 Dec 2023 03:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702023851; x=1702110251; bh=gQ
	MrucMK6KNVRQd3RDJeMHny+aTfnUE/8b4mphtXpPM=; b=Su6S/xTIGCB+B2+1dh
	HD1T8NtNynGWo6F+NRJDIaouFYqpyxgPhvh2jkm24ncEt9pNtXmRNBiQIZ0r6HSF
	w/G5syTFT3xXJt4PfhYt6TkLDBVBoq7RbdI/KKtl7onXJrRNoFWy6Kyd5Iu44ddZ
	ZFX8H3OEGnL1okoo3xtPnKIkNsHXcjpF4C9zPdGWrzTQpoAxYnrDxq8I1Vo3cphi
	NezsNrbYD5eBiltnJWXAH56x2Nn+yJbHmQ9LKPliO2gfN/XLG2a/g4e3m++YAzoF
	9aVQBijgDVXXnPji+lwk6OMyKMOjm4h6TyGkiEgrkILXALsRRTvzsRmhrNE5oUXM
	f78w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702023851; x=1702110251; bh=gQMrucMK6KNVR
	Qd3RDJeMHny+aTfnUE/8b4mphtXpPM=; b=yduoodw8IuMDt1Kc+bL7k5n644+ma
	EubxqPXmWjJnZLBN+deoLR81cjsotSVhIO9RsnNY3U5vPIdfSlraD9WQg37uakc4
	leQWUxL/DjtSA8X3lAKUWZx6Zhwlxi63X6YcBlVJbgbB22EdN/MGJI0p/pbnHd1T
	ErhqLv0syK5VCXu3WB22PGei8l76BYkR3XOxAld0JSgxoc1ozexyEX1u6WqAiUtJ
	ZOWw2CaQ1DT4N3PIK+x1N9LKLcXOU9koteZaKd5L+px8RAndy1tYf/Jn9TkPy6aK
	k7FvvMHxGFi9vNAzWmecdfc/JOeI3ztkTpArTC5L74HQFq8mqTzUW5Q/A==
X-ME-Sender: <xms:q9JyZXT6Dj69gfmAszL3i8ZYeqdVt-IXmSoVmrFaVHgTyXmx_FmlAg>
    <xme:q9JyZYz3SqTDimZ_cNua-ypzy-rqHC6h7Z490K0XR3yQgJJN4g1LNBwyN7Tx40hZf
    eYvhqbmNjNRDlWHmg>
X-ME-Received: <xmr:q9JyZc2Gw-KF3OJ2QXyv5bS748gAmjZ54qlPmWAAKhpcgrWUxgH88d-8BVJkDOZ7fTz-Rwqze7xkDH84N9HOcDEfpcYXZIiojqrlI1piytyQb6c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekhedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:q9JyZXD_O4gyYYcTHqDo5DwI3Hx0UaMK85cQpxF1R6BvLB_FrRnXaw>
    <xmx:q9JyZQgnjsBJVh0p1nb1vOmJez7O_yZ7yIsyIBr1dFDuH1af44zCVQ>
    <xmx:q9JyZbpq3h_7u1zLjbsSDikAh1_9BIQxAIMY04ycGVZhwt49MhWQDA>
    <xmx:q9JyZYLQ26ILW3zKYJE3ZzcN2aN-TR6-n4_CSzcTUD-v-adL-72fRA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 03:24:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f379a1cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 08:22:39 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:24:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Stan Hu <stanhu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] completion: refactor existence checks for
 pseudorefs
Message-ID: <ZXLSpyE5ZW0ANmsi@tanuki>
References: <cover.1701928891.git.stanhu@gmail.com>
 <1c6a747691f36ede4224b6d4c2e0c8fd4c0575fd.1701928891.git.stanhu@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mreX2BZ2KwUPR1XG"
Content-Disposition: inline
In-Reply-To: <1c6a747691f36ede4224b6d4c2e0c8fd4c0575fd.1701928891.git.stanhu@gmail.com>


--mreX2BZ2KwUPR1XG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 10:06:39PM -0800, Stan Hu wrote:
> In preparation for the reftable backend, this commit introduces a
> '__git_pseudoref_exists' function that continues to use 'test -f' to
> determine whether a given pseudoref exists in the local filesystem.
>=20
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index 13a39ebd2e..9fbdc13f9a 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -122,6 +122,15 @@ __git ()
>  		${__git_dir:+--git-dir=3D"$__git_dir"} "$@" 2>/dev/null
>  }
> =20
> +# Runs git in $__git_repo_path to determine whether a ref exists.
> +# 1: The ref to search
> +__git_ref_exists ()

I first thought that you missed Junio's point that `__git_ref_exists`
may better be renamed to something lkie `__git_pseudoref_exists`. But
you do indeed change the name in the second patch. I'd propose to
instead squash the rename into the first patch so that the series
becomes easier to read.

Patrick

--mreX2BZ2KwUPR1XG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVy0qYACgkQVbJhu7ck
PpTNWRAAkeePKbjVr8dUVey20OSotZwhplKN+7lxeWMHWDViHBzvQQXOYhjDsmX8
I6c6cyHLMCbDwtEFnH0ZLTh9HqDatMllSbmF1GX3MeJMY8a/AZMVlbe41IzDan0a
qmjv2tFoW4rEPH6O3M0To916RenBVTwA/3Rn27uBRWie9pFBGRbShcWMGpGUzqkR
u03qDK8OA1w3TgQQ9/gBcgI1A8tvsus+18SF5t4XoCDdLVcljyCsa5cVcjGAd/29
dtTC86AbA6pfDfOUNfITXPwHpTL6dTGQnatLkCNpuXzcMfaxx8WE4iQP7Dz3EJwk
WjjPh3sDdvQn7Aw5z8ZWSKzkHRg9e20vW11seTBXlisU940st6HCiduHe/jVxgbL
42qRY2dVS5LybGznJK1mLMLxtsMLAWq5LUd1IHrQzhnNSjKyvovNbf/W5V5O2B9S
Nj1ZJcq4em3htfH2CGguVVIaEHHTEnTA1FQfMI7BZ10ipZtXrXrrnPmcJjwwUg8L
J4+nROcjeIOw4lP3eMwD/S4L1swGE1CGF8xwGy7utBAgA71tptrULZ6tnQlcAvFP
oA9s29imCBT8mGQMOSL/Pgsxyt8bXYWF+KI9wenczxAREf9e7WbqBiENg28e1xm9
3FUeLTU1r4ZA2VlieRtPnvxEVnqBpdfRoCnVapYlKk64hvLNAx8=
=n+xM
-----END PGP SIGNATURE-----

--mreX2BZ2KwUPR1XG--
