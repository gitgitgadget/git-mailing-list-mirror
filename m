Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxYkhpCO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0Nmqle+U"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EB5110
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:15:04 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5443D3200ACD;
	Thu,  7 Dec 2023 03:15:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Dec 2023 03:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701936902; x=1702023302; bh=k0
	Lu9DEgsVOhVzp8/K90unKQCPr11OJ3jEdcQi1ncLA=; b=GxYkhpCOSwuFuzvZgy
	mo7L7rboAJEPUXDZbnl2sPHWsDsmkiCAzudyp5BHxRZdmFrgDjUwxLYZQKWyQ4hs
	rxk0EYkM20rvrtIIcm4oDtzGcdBxeLjtf1Y+eao1Sw9NXo3zCLvK/IFCHPGDktVa
	TmZMY/9TE2jeBlreg5KyEFhwhLAn9LGCehaN2UTBCunYtrEWXHZtYkqXwDTbvD4f
	0Oxm5JtWmbVW3pV9/E1ov/wzEyC5DHiY2EjpPO0PbZ4xb83okpgmPhzQUaEKSGWp
	t+92tX80c2GJMmWa8bpsq0kIlLYZqi11et+roGIxhfub3D/+QOir11rOGflsBaG2
	AYAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701936902; x=1702023302; bh=k0Lu9DEgsVOhV
	zp8/K90unKQCPr11OJ3jEdcQi1ncLA=; b=0Nmqle+UjdrHn9iaL++qGLfXkNmRi
	jvvvUkz9NsBrABQ9GGCIKbLMEOEWxQX5Av8bbiaKvbOfppIgDdhvftxBhqk7p53u
	r0+3COmVXkc3QqWJgR5KG8unBt2MpzZd3M/ZNxYncxU0jpJWas2/tscTSV5ODVqV
	XcnX/KdNT9Cfb5Z5Om0Ey1Hi4Uom0OGYOs2LmRnykN85tYQW/uuNGzkELJppUnjU
	M9gC+ODLRJO/+WtAatEAZWHfZPdR6Ix5cws7W06axRm3j9HlkXXhId99K7LnEmEq
	mGjLxgaya369MnIvcq7LrgPvZmE4KOXv5ZzXkaEDwB0kY0TMkwMN1cHqw==
X-ME-Sender: <xms:Bn9xZfCSR4bnpgUObqw4CprlRq-BydxSuYePRaQvP_lPD7EDiDuEPQ>
    <xme:Bn9xZVhMs1eMPXfzb1d_z1Jb7PD-8FWSZgzhNlPoA96OsUU4ApoZpiWx4K_Sgfu8P
    dnaYu2u9NDRWA0JBg>
X-ME-Received: <xmr:Bn9xZanpbhbWu2PtJ62rRyPQoyzXpzh5iXagCwKxKysnNSc46eVi3bH949A1RhQa22TBgmn0XewAHg3KqLM5th10vgQMIlnzXcWrawUmd_kj8Ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Bn9xZRy_1m311Z4uH1gv60HhH_lg4CGHEQDWCSkO0p75mGO4lcXw0g>
    <xmx:Bn9xZURLNmZokmfn7_4LuSH7FhG2nKM1oLTTmRG55Mkzuiguvd2GYQ>
    <xmx:Bn9xZUbAUyi8Ivob1g68PORfXfL2jdBh0pTFK7pWpLSWiSZU-NhSIg>
    <xmx:Bn9xZfIRxKepza7Xu1EPGgiGbXH_VqQQXFZ_XXgLGNWhv79vu4Q49Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:15:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 22bb3c93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:13:34 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:15:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 7/7] fsck: handle NULL value when parsing message config
Message-ID: <ZXF_BHFubnPJWNhQ@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071135.GG1276005@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jMnMgHBZL6R681gq"
Content-Disposition: inline
In-Reply-To: <20231207071135.GG1276005@coredump.intra.peff.net>


--jMnMgHBZL6R681gq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:11:35AM -0500, Jeff King wrote:
> When parsing fsck.*, receive.fsck.*, or fetch.fsck.*, we don't check for
> an implicit bool. So any of:
>=20
>   [fsck]
>   badTree
>   [receive "fsck"]
>   badTree
>   [fetch "fsck"]
>   badTree
>=20
> will cause us to segfault. We can fix it with config_error_nonbool() in
> the usual way, but we have to make a few more changes to get good error
> messages. The problem is that all three spots do:
>=20
>   if (skip_prefix(var, "fsck.", &var))
>=20
> to match and parse the actual message id. But that means that "var" now
> just says "badTree" instead of "receive.fsck.badTree", making the
> resulting message confusing. We can fix that by storing the parsed
> message id in its own separate variable.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/receive-pack.c | 11 +++++++----
>  fetch-pack.c           | 12 ++++++++----
>  fsck.c                 |  8 ++++++--
>  3 files changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 8c4f0cb90a..ccf9738bce 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -142,6 +142,7 @@ static enum deny_action parse_deny_action(const char =
*var, const char *value)
>  static int receive_pack_config(const char *var, const char *value,
>  			       const struct config_context *ctx, void *cb)
>  {
> +	const char *msg_id;
>  	int status =3D parse_hide_refs_config(var, value, "receive", &hidden_re=
fs);
> =20
>  	if (status)
> @@ -178,12 +179,14 @@ static int receive_pack_config(const char *var, con=
st char *value,
>  		return 0;
>  	}
> =20
> -	if (skip_prefix(var, "receive.fsck.", &var)) {
> -		if (is_valid_msg_type(var, value))
> +	if (skip_prefix(var, "receive.fsck.", &msg_id)) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		if (is_valid_msg_type(msg_id, value))
>  			strbuf_addf(&fsck_msg_types, "%c%s=3D%s",
> -				fsck_msg_types.len ? ',' : '=3D', var, value);
> +				fsck_msg_types.len ? ',' : '=3D', msg_id, value);
>  		else
> -			warning("skipping unknown msg id '%s'", var);
> +			warning("skipping unknown msg id '%s'", msg_id);
>  		return 0;
>  	}

Same remark here. We would only generate warnings for an actual boolean,
so I'd think we might consider doing the same for implicit booleans.

Partick

--jMnMgHBZL6R681gq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxfwMACgkQVbJhu7ck
PpTN+BAAn4oKRaSXfPNkTdqs3QGBEIoAoakfKvKct4XNPVw5eiiE9OhxvTbtFUvX
FpJVsQ1UMEL6cMfRWyKIzhrKWDEr/jXMWPNM5uB40orZX9bw6kOESuP/R67lsJF4
0q402foMTQ1AwGW2OTyeXVe2u2cwGCYVc8De44M9H8aQCPJUPJGTO/2LKAIj10Jf
HYrHjHCEWKqjWBC/lwR4MAiFOyb1Oh+jXxIHKhLAbIqMhEM3PTrkH8Jgf3bIWAD6
O748SxWFhyr1sc+uHy5bVKOL+st+IRfq/0EfVhqqrZvgxY+mVTXdpAMRVbsgz+wK
WHULuX+0YcGtUixD1rpCVke1WOCAnv16mZs77P26FfU8d4j/X0opAx7iF7nMqyXu
KLEcxDBHgDh0akXDriiGX+0vvO5PfAHKMhqdTVrLlT/uWa/ASFoEOPmF2ctPWPth
WqbJQfoZVuW2Th+wWp0PJ5JTdxgW9Bo5ONKg1zypFbvm9VlIg3/75YJ3LZuvbokW
sHC6tZwEDR7WFp4jIX3ss2xh646BXBe+7436nLUQDt/CyvZla1ywdEqXLHNyQY4e
DoAHg0LOcbexhHH1FjYiWUC8/bbJzscmcL3n/TlEGEVhE/yiRakm8IyonKX2E8Ps
77xB/Ks+VQQNgmOnKdUpBzLQJJJ1uYghXss2j/fqfnhlS/+zg/A=
=Vf+k
-----END PGP SIGNATURE-----

--jMnMgHBZL6R681gq--
