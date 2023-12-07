Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cd8btcbG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gx5pyDWr"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA19D53
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:58:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 42F0D3200A39;
	Thu,  7 Dec 2023 03:58:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 07 Dec 2023 03:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701939484; x=1702025884; bh=xa
	AyG2tR+P2iU614TgqY/sNcTvDHQy1Oy4qe3d3sxrM=; b=Cd8btcbGyTDVmdeRLZ
	HgsK2Hd52yp4eEJPJfaTd9aR5Rj+1Nh1jWMk+gO/vvI39kk7AXibeZB1TVUD5GDP
	vqf4NVuecEwidhGlGQ69pday2YEwerGtoawR45FA5SAxFuafVkV8uAg3lrNvBo7Y
	6aUNpbEjFGz+/ZgExd/5XQzWUv0UjmeBR6jPtncHOJ4MOB4uxL0y6GtdfT5m7Cta
	p/yxCWF9s7Ql306MtTghCAdaMtpot6D68iFQh+Rme6daDCWcvog1Tw0bMHrMN8Sr
	8tI2dcn+6Gky+ow2ihPMG149VNMqlBffmxcNnWnvTe9E9avlvZCTIoNh13UhMCOr
	s3Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701939484; x=1702025884; bh=xaAyG2tR+P2iU
	614TgqY/sNcTvDHQy1Oy4qe3d3sxrM=; b=gx5pyDWrkn0mKFfXCpNv7FIZ/lkBV
	vBAhx82krSlF1WXETGCdNwNunfE3bc6MMfkY4PBeYYWR2SqKl8lMw5aQimfwB2/r
	zCdj4pspjD/27A57XjaPR55IQui/7IKJnopU+/+/Dklqdfoz1pUQayrEu1BCaj7t
	zCgAIhPJeR8KUAuR6yzyCQ4BmIQS33CTSkxGe1scTUwZKDyxrOCgZxL32ZhC1ZSG
	G+MX/GNwrG1RiVMo4jYCR8uMLajl+agNvDyeKoNP8YE7jkrLkOZLYdcKhDBgqVPi
	vnHY3R8v7MAQWwY3/T2dUZ7c/Yk59ByUo4idhkdBG2bbyydBYpPQ7zxqA==
X-ME-Sender: <xms:HIlxZTqv-iloEhYHiDw7zDHOgzt4hrs--MjbdpeBE6VCOJ7ecBVAPg>
    <xme:HIlxZdrTmDY8Pj6tpLYTXHT95zRZOX5HEy1aMsaDsSSanKwYfRzLA5F0Otfk1Hzik
    sCjG8btCjBBAxm61g>
X-ME-Received: <xmr:HIlxZQNowN35oAly9xUJD8lZogkmGFosyI8dUoSMzCHuFuv7gH7Rs9ou0zco8ulFcwjnKIqfk8lZMBQTpLtYcr9fxueuLS8cy6auSF2Zp2rkeyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HIlxZW5nBgqljgtHqsq5zXqTxTf0mBuMTqzRE1Y8SLwsjn58ol-BVw>
    <xmx:HIlxZS6iUv8A_fAD8rw33b_-wBQMn1oL3IFQQLsyRsQASFZIbCEBiw>
    <xmx:HIlxZej9MttAIMnjUPFJRaA8Wq8yzgLmpM2gRapMqK_qljLDNcJ8zw>
    <xmx:HIlxZXhiIyRVV4d3_O70xkohWv44aXTGDb1qituJdLTAAMAB_QDILg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:58:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e72a9d4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:56:29 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:57:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/9] imap-send: don't use git_die_config() inside callback
Message-ID: <ZXGJE-pkb3BjlO-d@tanuki>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
 <20231207072458.GC1277973@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ap7Rdgl5AFLcl/nw"
Content-Disposition: inline
In-Reply-To: <20231207072458.GC1277973@coredump.intra.peff.net>


--ap7Rdgl5AFLcl/nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 02:24:58AM -0500, Jeff King wrote:
[snip]
> diff --git a/imap-send.c b/imap-send.c
> index 996651e4f8..5b0fe4f95a 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, const char *val,
>  		server.port = git_config_int(var, val, ctx->kvi);
>  	else if (!strcmp("imap.host", var)) {
>  		if (!val) {
> -			git_die_config("imap.host", "Missing value for 'imap.host'");
> +			return error("Missing value for 'imap.host'");

Nit: while at it we might also mark this error for translation. Not
worth a reroll on its own though.

Patrick

--ap7Rdgl5AFLcl/nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxiRIACgkQVbJhu7ck
PpRVHA/9FuDfJCkwwrZ7r2bCVtRWWzajX4Rk234xcI3/PPq4jZa6dAJ+DXoXB+4T
k31HawQ2caE3CP0YodFmtSIKtBIbkVXIJTfBDo//c1fm52tGi+z0Ryjoom7OHRtU
EfzqPeyX7D1HhdWBGshqB0cTcryAlVf/sWV8eoYcUaXHhupKmHJpUicQrqlyXzqY
+naJx0q6EO+TqqGHaHQzuZG8/nus8+jSUjQ8JVXG0ooAVIcjHGNt6ija8+WCQY6t
C8sPw0sqBMgfPXnR49751oZqU34n70Te1I28jBII99kT6g/D5wb6AQvcYSVUBWaF
BHi5rcQhmpe2q+g6GxcuWoCbTLBJf+Y72Wg9HSsJxEsZHxcjnwkfA/B90sFv6BRC
E70GM7dnEljSxdccArIettLCKm9PH0X2DUuImWmeDhdUOHx6qO0O45IhV9cZ0Cne
KVvRLxEFMTQT9u/h55zs2W35ISwHCKDSPqcmwiu4bE+tn81d3BpFA7zi/bBjb3cr
8iMLVOJiIqQKYHXMp4v7rcuMAmLO8HCqbQdsvlYJyioaFZLWXduggiqp582szWtG
IQzpcWk/t5EjePXANOLwP44nJzPcji0B85v4qfSwJrLh13H+HYlc1tP01fRex88f
+bldCrjmG2cKWytET22NcDjn9ZzZjOGiGX2GWrvI9jDbfry0oBc=
=JOPZ
-----END PGP SIGNATURE-----

--ap7Rdgl5AFLcl/nw--
