Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D125622
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008238; cv=none; b=nIf43XIxO7kSyvsfsjmGAVoqiCoytdSe1OBQ4LXfIVs0j1UCg8RBA2EVxI2MP7Prnp0P0F0wL6z5oLSZQ9/LsjNolnAoVju1uHP+YubmPT+jhLVjA8hyGhIie3L4uQYDEwOSaci8qPr6JdGu7mL9zazwRbJ/yFrFq+0Cdz82v5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008238; c=relaxed/simple;
	bh=QgDGDc36A7bzWNOERbKZD3UdGQZR7QPV2ORuSLy9uIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH83N3gIKk3Q3zQi3X4go4I/RGwWt5KNgz+7Sz1LfNXE5CBFdqBknihTDT9qrVK2bTvP2K1UJKmN9G2up0ZSh0C5m+kZcZLQsR6XRClPfCH6yEDi9hok4uNbg06AjNFbu7jcPgfXrpgVmgwVZj4bMaXXl3wVq5HgdEFX2q4bHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XsJ/ykMk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PqxUcyqv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XsJ/ykMk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PqxUcyqv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 732F0138FCEB;
	Wed,  7 Aug 2024 01:23:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 01:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723008235; x=1723094635; bh=8QdjrJJPhA
	+rYD8ARO8i12e92kIGBUARN0mf5yhC4Wg=; b=XsJ/ykMk8aXgQqh0HJxJkC8KdQ
	xWRwBjvVATHkDyJLmKnncVD1YTmUfMlpFw0Olx+9t1lyyaHqp9x5JqQTvxYgfJXo
	dZJT0uxY65VAP4g9TqO6CUl3MPvN9d4wUngqm4Xe1z41fFA1P03mkxnERBaVm+Hu
	fhm4TYEMD1bJK9so2rgYN6puUpLjXbvdMcxK6kzTK7IVMBaJi9S4x/Z9HZT5ljWl
	AxSEbIoXHfRv7Nmcb7hfHL000sudaSxwaVuDbHxFro800ciNxHyBXrSVN4XK7m/F
	JNfvU2ItVvpPHFk8bEkIIAgJswE1ZuUtQsHUD+2fP5cGnTCALS2jcG2ZbMog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723008235; x=1723094635; bh=8QdjrJJPhA+rYD8ARO8i12e92kIG
	BUARN0mf5yhC4Wg=; b=PqxUcyqv66fxPM+8Qckm5DDNAuHKvSDZDfOHlYpo3iMo
	FwYGVAhfiZBs7qiKLym8ZfDxlcmHBMcEEqz+l0FC4rD4LNC86sj4qiz9j+DVMg6G
	D+7J3EGllKq9p5wvkb8g4X0eEbJc8vC2dM/bbWGXiFTGcx5HcBvbVVzBnUzJUJ0N
	bPrmRErflzEx1tijXXnaPAGYyrkCfRnrsYpSBOfJVLhflVa+E3HqiE2qJTYS3506
	PznKpdmUEcBVSgx71YfYl1TFNDvAiF5LKITfrRV0VUtU6Hu76FswtzHOf4y3MAxK
	rhxGfTMQoxCF1I+UiK6ujf4k5AZKxjyZjp3i3r/Q1Q==
X-ME-Sender: <xms:6wSzZmR9fd9sRxQtlNwoBWH70rEUj9cDoLZvxSctecy7PPE6TY0c8Q>
    <xme:6wSzZrxXPH8FOGOPCLvNM74p4notQ2uygBdR6bDpObAlxgGiWzANxPoVT_jZ5eE3v
    oo_FIi14I3hHesDfQ>
X-ME-Received: <xmr:6wSzZj2bNEQWP8zhoWTMbCBr7_xq32W04etDGvI8L2nLFoNPfL4PUnQFS5H3sghDPl4inc6btApqTb0rI-MnBJGkm3u5K_fndZf8HG-6Jx8hDaUv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6wSzZiBT_pSgvTq75Tnl5Avl9WQa4Qkr_Myly4AXC7yVUau6gKP3Ww>
    <xmx:6wSzZvjou4ze_SAxoHfmuesjYhU2yRNBrz5KmA60_KB5JF7fx6cx-g>
    <xmx:6wSzZuqd1xRSMx-KizWhs2LoQFc3cahaynmnAPuw0PPwcdln7fI0UQ>
    <xmx:6wSzZigKBIoxD-FPyQAA4Tpx3VsdnS3aDweBbD0tZ1RjQTsjIC9GMw>
    <xmx:6wSzZssWWqlT2KdB48v0BO2o209qMguJIHal5NjUO3DJlmZl81FQEel9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:23:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 65b1305e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:23:50 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:23:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/6] t-reftable-stack: use Git's tempfile API instead of
 mkstemp()
Message-ID: <ZrME6CR7eX_Fj0DQ@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-4-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E1P0fbySTssP2Z78"
Content-Disposition: inline
In-Reply-To: <20240806142020.4615-4-chandrapratap3519@gmail.com>


--E1P0fbySTssP2Z78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 07:43:39PM +0530, Chandra Pratap wrote:
> Git's tempfile API defined by $GIT_DIR/tempfile.{c, h} provides
> a unified interface for tempfile operations. Since reftable/stack.c
> uses this API for all its tempfile needs instead of raw functions
> like mkstemp(), make the ported stack test strictly use Git's
> tempfile API as well.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-stack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-st=
ack.c
> index e033feb8ee..14909b127e 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -76,7 +76,8 @@ static char *get_tmp_dir(int linenumber)
>  static void t_read_file(void)
>  {
>  	char *fn =3D get_tmp_template(__LINE__);
> -	int fd =3D mkstemp(fn);
> +	struct tempfile *tmp =3D mks_tempfile(fn);
> +	int fd =3D get_tempfile_fd(tmp);
>  	char out[1024] =3D "line1\n\nline2\nline3";
>  	int n, err;
>  	char **names =3D NULL;
> @@ -95,6 +96,7 @@ static void t_read_file(void)
>  		check_str(want[i], names[i]);
>  	free_names(names);
>  	(void) remove(fn);
> +	delete_tempfile(&tmp);
>  }

I'm a bit torn whether this is a good idea because we are using a higher
level interface that doesn't have unit tests itself. As I see it, both
low-level primitives and anything that is already verified via another
set of unit tests can be used when writing unit tests. But as far as I
know, the tempfile interface does not yet have any.

Maybe I'm being overthinking this though.

Ideally, we wouldn't have to care about the underlying issue at all,
namely cleanup of the temporary file. This is something that the clar
brings to us for free: it can create temporary directories that it also
knows to clean up automatically once done.

Patrick

--E1P0fbySTssP2Z78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazBOcACgkQVbJhu7ck
PpSnCw//bg1kbVYiwx4s/wwHXIhoFUaExdZLJyQE/5gNXhud/9+rPfZXYUP1ImEF
VUg3PHZ/qGcC32GUdb0AU0+UqtriJ5FT6XQlzgReXCBWIkGt7zymQqxD/7Xkj1k+
T4wCQe6nEXul4VXDpEmUYZEVPTqOGg0/u3qPJnQZTY98zLvwSRz1mfZXRrhdvd5p
udE7qua8Fd/S7Z44vkU+27MEsowEloQPhOcMrJD1CwD8gfrp/KZKKIn6Lcexij5r
GVMy84SBhtM+V8JapLzIuJuLteI4DXXY4REucSAIoC4iLSjjHelcKjPYzAqk3bAQ
LQiF7/hDHnrAKerBad/ilB+EetIR8fZwcj/qZCSk+Dxkgi6GDURbZyCutdmND35E
0ZFcETIva7P9+oUKnmm1sOuf0pLveiigJQ6UA1G9Y91yu/tt522i4VlSJ/ZrM1zf
4UrxNIVAZ79VtKi6+9SKxNaDPgf7INHRirvUVzBqW5nhM9gSJ6JQB5lpqDLmc836
+ZP+MwuUE+pPtiuKnAUm9qyhi2etCZhHZ7CC0+Xdy0tVmk6bKiTetTlPCTcsERN3
HqihhRnMUxCJbmQT8vbpyWcf7mEGhe0ewIPFM/eYfDRpP2p2s/diRF16ttJsyx1i
sx+AnIKoJiyNJRJMKvIW5Uj4/tRNjYUoQJNzENonWB8vtavtWYI=
=0jm0
-----END PGP SIGNATURE-----

--E1P0fbySTssP2Z78--
