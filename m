Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D7E55A
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101894; cv=none; b=fDTWwGsJgc44FpugNuXJNqtO1fU9moGf1tlHpsprdgBgzKtHPorQmzHto85VgWIDwhrYcHW1hnNiFYGC9SK+ChOdzZ4kTuAdMGPMaqeERJkqAHD+pEFRd8hqTMFy2pt9W4wab1SzY0XI58AdGA5SptYBRQz1xq49C7ctRyQKvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101894; c=relaxed/simple;
	bh=13i+tUGHB/SjWR4hdIsLplyRaDBO8ujPcvTqITwf/2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTX4vPf5Ih3ik/bQiTjIh6ZnQ6sRmta/kSYnLdAEgtRwMgkvGgxviJ9c3ddydblRfEyr89uUBREpCGg2bPC17i1WyurYA4UXWnELS45u18OhaRT0o7BXwFb8pZFRa2Vuh1yP0g90kGwXXEoQlamPfmg5GCUbJZR6G9CcNl4Rzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xXKAeNFt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xXKAeNFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1757101890;
	bh=13i+tUGHB/SjWR4hdIsLplyRaDBO8ujPcvTqITwf/2Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xXKAeNFtjon0IOv8ZBQYoiWn+KQTrML4Rz4ZLYUO6+ZTGGatdAItoy7a8OnvFXiJ9
	 pgd37KZYmvCubYsQZQJ/xZ+XsxBOALl8DKMzKHWFm9IuqEx9JQ9a7Nugcxi6T1omub
	 fM809N27Oq0jgHEXJWpjBl/55+wmXNbLfBeHHdjXHy9Z4sXxY0Hsq7ja4mf+m0ZEL4
	 nNSbsbwm8p9DkAQgFTY9DltR0hSVThYqXp4eHmqvur37zA88mzF3sgk+kbVgjaOGyT
	 N/SyCAe37wkKwt32x5wyUE/x62OgXnGxCSN0A6ZMcPckktspYslh4uE+Dgz0Ji53NM
	 DaQKkgv9x45dXLPzuqefzN4MFKu+/TWQzLNgINsvC5eapnMz31Byjzlab6JaQW+y6Y
	 f7fEDahh3ufLcGLwxfyZxuJ7T9RPhaEMqV8torj2XCDVqSA4HBWcy1kd+wWDFsu5Tz
	 ll2wyQajlBB8iphUt0L44/cc16FYHEHHzRWQBb4a7zyf/vRtwVb
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f8f0:4bbe:8989:f575])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7FDFC20100;
	Fri,  5 Sep 2025 19:51:30 +0000 (UTC)
Date: Fri, 5 Sep 2025 19:51:29 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v2 3/7] help: report on whether or not Rust is enabled
Message-ID: <aLs_QZ9eBGevcGfb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
	Ben Knoble <ben.knoble@gmail.com>,
	Christian Brabandt <cb@256bit.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
	Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
References: <20250905-b4-pks-rust-breaking-change-v2-0-6939cbf4a0b8@pks.im>
 <20250905-b4-pks-rust-breaking-change-v2-3-6939cbf4a0b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SQrSqGyV0SjbFMRv"
Content-Disposition: inline
In-Reply-To: <20250905-b4-pks-rust-breaking-change-v2-3-6939cbf4a0b8@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--SQrSqGyV0SjbFMRv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-05 at 11:50:59, Patrick Steinhardt wrote:
> diff --git a/help.c b/help.c
> index bb20498cfd..5854dd4a7e 100644
> --- a/help.c
> +++ b/help.c
> @@ -791,6 +791,12 @@ void get_version_info(struct strbuf *buf, int show_b=
uild_options)
>  		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> =20
> +#if defined WITH_RUST
> +		strbuf_addstr(buf, "rust: enabled\n");
> +#else
> +		strbuf_addstr(buf, "rust: disabled\n");
> +#endif
> +

I think this is a great idea and likely to be super helpful.  Thanks for
including it.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--SQrSqGyV0SjbFMRv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaLs/QAAKCRB8DEliiIei
gRDWAP0T4ljr1yrR70fFxHqgeoUisx7E56i+rzOXUB3RHR1WNwEAxQEo043cXlNq
fZGpF7yShGkChwVPs5S0872ceIHUtAw=
=nD4j
-----END PGP SIGNATURE-----

--SQrSqGyV0SjbFMRv--
