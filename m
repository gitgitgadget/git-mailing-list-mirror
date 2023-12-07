Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HsXeyCMc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9DSZ1hg"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAB6110
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:14:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E6ED23200ACF;
	Thu,  7 Dec 2023 03:14:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Dec 2023 03:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701936896; x=1702023296; bh=zs
	9jsPkmVqdWxhvfckKeI7UQabrLWthhrDK3D9w/ELI=; b=HsXeyCMc32OmNli5JR
	VY3fSKdf/qq31tykmFqk77IwudXB+w3IYwGfGHKB0KQCJ65w1Z47s7NvJvDhMaNC
	PSAQ6j9AdvCzow01gvXFmNrPEgstlntlWCxYBfD9L39wBWNbnIcPHjiDfj2cHI3g
	SQ+6hpzwkOKNagFFBaUvganKhct4qovCD24f6oURLpfxZVM1QeFnkas+QownCmX4
	e+6jv8q7vFuRWJIXPFzBUlAHwdofCPsJvjtma6c5graEDUcsFP+SI2lrTJGkgccy
	aL2V54sVAlqR2dyNFvTIWi0h5zvg4buazKSWqMKumCz0zCP8bubgp/xKtKh3IpwQ
	vwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701936896; x=1702023296; bh=zs9jsPkmVqdWx
	hvfckKeI7UQabrLWthhrDK3D9w/ELI=; b=h9DSZ1hguFmqSAtHfku/yKcOLfgrB
	DDw+NIzp0LBuBs/lB2/tsgDDmHEK71cuAECA+7H5O5SQT2v+AtetEqmMjuhrB874
	sc32cYmsP2xFx8+LruhN3msc0aXc7/5EkZ8Kb0u4kL1JNyMsxenk/k5+PcRzemZu
	JTwtKuj0XxFuOS9Umi8Uymp9zuB7hG9GHOFJC8nxFyyIWciiBXmA02gLX5IWsrZ4
	wTFsBEVdoy1ckr2FnvhVvqDgq2KU6yq4uOsVb2VsYDLVZsqDH7gelWJl1CosmSHm
	ENBGrXy/DydncfChEWodzCej20t9CQUWlfIjZxXtN+flhOQBUIfV7J++w==
X-ME-Sender: <xms:AH9xZT0CJkFgyjOyOx9QJNUkyfjIznUu29i1azuk09HKNkISTm_rMg>
    <xme:AH9xZSHeYyGIDS3Lk4D8qmoOt9V0zuUA7kH4DvfIOfIRx01UJ5WBPKKvDvPhyha_3
    5w0KvnHjIi-xBr4ZQ>
X-ME-Received: <xmr:AH9xZT6S40ye79Kw3gE__rT04AHpAQYTzf9TAVhElcRUboWA3bOOKLQNnu-vaPB7AHisEWqV8bFutqf9Wb67_oOrPc_z7aaw2o2KGnmZUc0IxD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AH9xZY1kVAw4Av2Uvv_1rDge5lx_wlX949yCbLLdLlId45wCXMXAMA>
    <xmx:AH9xZWFChUZ5_dTcxXkLiROMFYJ05E5BPLAA5xvO0Qtk2IJ-GnDUXA>
    <xmx:AH9xZZ8Fs5BjZQ76R_JnflcYcKYTZWdqECXNbmgAfyX1mtB2sDv2xg>
    <xmx:AH9xZYOUDDgQQAsOero77Hkf9dMZdwdbemy7WvheX872FeV_UWNWSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:14:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24b3507d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:13:28 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:14:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 6/7] trailer: handle NULL value when parsing
 trailer-specific config
Message-ID: <ZXF-_bS6upwHIWMh@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071132.GF1276005@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y2q4ZAS0uJtKJAh7"
Content-Disposition: inline
In-Reply-To: <20231207071132.GF1276005@coredump.intra.peff.net>


--Y2q4ZAS0uJtKJAh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:11:32AM -0500, Jeff King wrote:
> When parsing the "key", "command", and "cmd" trailer config, we just
> make a copy of the value string.  If we see an implicit bool like:
>=20
>   [trailer "foo"]
>   key
>=20
> we'll segfault trying to copy a NULL pointer. We can fix this with the
> usual config_error_nonbool() check.
>=20
> I split this out from the other vanilla cases, because at first glance
> it looks like a better fix here would be to move the NULL check out of
> the switch statement. But it would change the behavior of other keys
> like trailer.*.ifExists, where an implicit bool is interpreted as
> EXISTS_DEFAULT.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  trailer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/trailer.c b/trailer.c
> index b0e2ec224a..e4b08ed267 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -553,16 +553,22 @@ static int git_trailer_config(const char *conf_key,=
 const char *value,
>  	case TRAILER_KEY:
>  		if (conf->key)
>  			warning(_("more than one %s"), conf_key);
> +		if (!value)
> +			return config_error_nonbool(conf_key);
>  		conf->key =3D xstrdup(value);
>  		break;
>  	case TRAILER_COMMAND:
>  		if (conf->command)
>  			warning(_("more than one %s"), conf_key);
> +		if (!value)
> +			return config_error_nonbool(conf_key);
>  		conf->command =3D xstrdup(value);
>  		break;
>  	case TRAILER_CMD:
>  		if (conf->cmd)
>  			warning(_("more than one %s"), conf_key);
> +		if (!value)
> +			return config_error_nonbool(conf_key);
>  		conf->cmd =3D xstrdup(value);
>  		break;
>  	case TRAILER_WHERE:

For the other cases we only generate warnings for unknown values, but
return successfully. Should we do the same here?

Patrick

--Y2q4ZAS0uJtKJAh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxfv0ACgkQVbJhu7ck
PpSJvBAAnbNY9eunBRYpNlTFwLwC99pkEuOmCumfVrzUgMWPPei3XQmdiGjD/b2R
mIMLWoZm0tX+/Ef9NluFkzQoNpApXilS2s9asuLDwibwiMm6NYadERNaEqNaofHW
zQpQKepKpHuvDgSeRcWBLjwXqg9tXUX1L+J4LSTa/TKszX4/vMXLmSCiMiW0qVGT
NJfGW92E4n3edhx7Me9AIWHIpAKmvMkTKE2qXjPZFLLsOybN/mlEnZBYzonBH23x
BqwCH26v6IoQeTf4RD6BQBkZ35YtkhiOUIrihteewrXPHwXj4KxCYB9jsrWaOyTG
FB8TTTDqpBDRCkRjR+MjnZVzpgbs5FPTd6bhJLSAyESekM9oB3tX7XJeLG6W1zzh
s1ZdpQ9mi4ynj/EXtaF1Fc8CqmA2hQjjFw+ME8pfvwSYymScKyLLW+OTOolG80J8
Zkf5sam0cp9p+5+VJB6zufnLXGlRGULlGQMExgSYBdZqLjeTDmtGjZVsUBP4STeu
VPKTWQmjHgJYSPy2+TTQnkH4UWTpHwmtF6pv3ZLJGaTJrjgaegUaahajLf8QYmIq
GR0E8Bq7nIO+8G7W3Xz7YcEUspJhihDGTVrYfRGZck7PVyT1PykGiwKhsZtH5Y87
b9A69oCSar4CsjgMdXL6prUMDX1QsupPcSJmGSMIx5AQIVE33tE=
=ywlq
-----END PGP SIGNATURE-----

--Y2q4ZAS0uJtKJAh7--
