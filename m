Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5923D7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jTYLH6BO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VOC0MM3K"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE07D78
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 01:27:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id A4E6C320098D;
	Mon, 23 Oct 2023 04:27:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 23 Oct 2023 04:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698049664; x=1698136064; bh=oN
	4MzERRZQPG+Jnl8nH79lKFpRhdqPbh5vaut8bac88=; b=jTYLH6BO9WOw47sqXk
	RfYg9PPB2jOIesKPJufhzdg0hj5Brdi/ocKMcVXOAWG9OUYLAS3qiP1UWielgn3X
	zp/U/yRZldujAm7+8aIMFY4TUXKHhtnNPgGV4vjf8xoUKMnVSGzBsVN20w9hWlUR
	KSvdxz+uU9bBnfWF3dXvImtqJeqBvhNm7B6/oVFUVFtVuyvR/t5tfLVgxGWxtg4w
	6Vr02jbK1/VZCeCpLwE+2qeHkkehhepURHh29Ma6dTan0hO1pPhCxUTlVZUz9Yf1
	qu/mZOr+X82WBBgN20rddMK2x8HpZYwoPYRv5Lb1iYj1a+Ob03epVr/9SIS0euJH
	Vbtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698049664; x=1698136064; bh=oN4MzERRZQPG+
	Jnl8nH79lKFpRhdqPbh5vaut8bac88=; b=VOC0MM3KkjL/19x1TDuJKrSSRm46z
	iXZn+5mjiSlIcBYj0SqHvf9p9nOTxixYwE/ngWNMRCERDbd2MGZcJmkA9WP61mUa
	y1uEHGJxprdte5wfw2QxQ7MahoDw20wMjD31pIahoT6lA7KwV99TDLGP41OuC/5r
	1ImDG0GdnO9vLU572ZjX7sBnW3oB5A7OBGXxd9zlumgR60A/m5g1hTsLEbUWQssp
	4rUNruYxsPOaJiA4gWA8c7j4LxFNoGi2X6jcwV44GteacaqQl4TY7N2yYMRUY/89
	Vy2U1yjZg4ImBDa7EHfeT0ALQDyheflqzFdqUx4oXSgaRcx/EaTD0c9cg==
X-ME-Sender: <xms:fy42ZV-8p4T6IbkPypXYS0SYGOyfMUvv26SSDMxSbH-Rq5BK92oJmA>
    <xme:fy42ZZuqMoC2kwJvL5w9lgpCqsXxopYfPFEAbNnAEWQJ_vJwqdMEV1tQz9vNto_a4
    4JVUGmOls3A3uf_SQ>
X-ME-Received: <xmr:fy42ZTA-HsNoDWoAlbq1a9SWe35AIKU_nNyzxdM_kYlUINEPx4jI8ItXE77-IPI3i7_voC_BV1Aa9rq3B9-AbNVk10YoMfzs1EGK-Mjl5cjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fy42ZZcG43jXZTEf8YgDwWmlkJcD4kNT-F0CZFbVTNcfkWxr6vmZxA>
    <xmx:fy42ZaM8DbL9cdoWe3I8aT7UtZjneOiCqEm5EHrxB0IUed78JO_OlQ>
    <xmx:fy42ZbnfR3XXJ9kIkfUrLXTBhwSj2sj6f4bCKarAQF50Aa9St9CVaw>
    <xmx:gC42ZTYbuOlJFpc5R0UlAH3D2vtP3pD50vI2JY9rrtwzhp3ZYt06UQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 04:27:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de83c168 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 08:27:38 +0000 (UTC)
Date: Mon, 23 Oct 2023 10:27:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
Message-ID: <ZTYue-3gAS1aGXNa@tanuki>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jAQmUQbRlR0EhAU3"
Content-Disposition: inline
In-Reply-To: <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>


--jAQmUQbRlR0EhAU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 10:34:33PM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>=20
> If an error occurs during an atomic fetch, a redundant error message
> will appear at the end of do_fetch(). It was introduced in b3a804663c
> (fetch: make `--atomic` flag cover backfilling of tags, 2022-02-17).
>=20
> Instead of displaying the error message unconditionally, the final error
> output should follow the pattern in update-ref.c and files-backend.c as
> follows:
>=20
>     if (ref_transaction_abort(transaction, &error))
>         error("abort: %s", error.buf);
>=20
> This will fix the test case "fetch porcelain output (atomic)" in t5574.
>=20
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  builtin/fetch.c         | 4 +---
>  t/t5574-fetch-output.sh | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fd134ba74d..01a573cf8d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transport,
>  	}
> =20
>  cleanup:
> -	if (retcode && transaction) {
> -		ref_transaction_abort(transaction, &err);
> +	if (retcode && transaction && ref_transaction_abort(transaction, &err))
>  		error("%s", err.buf);
> -	}

Right. We already call `error()` in all cases where `err` was populated
before we `goto cleanup;`, so calling it unconditionally a second time
here is wrong.

That being said, `ref_transaction_abort()` will end up calling the
respective backend's implementation of `transaction_abort`, and for the
files backend it actually ignores `err` completely. So if the abort
fails, we would still end up calling `error()` with an empty string.
Furthermore, it can happen that `transaction_commit` fails, writes to
the buffer and then prints the error. If the abort now fails as well, we
would end up printing the error message twice.

I wonder whether we should fix this by unifying all calls to `error()`
to only happen in the cleanup block, and only iff the buffer length is
non-zero?

Patrick

>  	display_state_release(&display_state);
>  	close_fetch_head(&fetch_head);
> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index 1397101629..3c72fc693f 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -97,7 +97,7 @@ do
>  		opt=3D
>  		;;
>  	esac
> -	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
> +	test_expect_success "fetch porcelain output ${opt:+(atomic)}" '
>  		test_when_finished "rm -rf porcelain" &&
> =20
>  		# Clone and pre-seed the repositories. We fetch references into two
> --=20
> 2.42.0.411.g813d9a9188
>=20

--jAQmUQbRlR0EhAU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2LnoACgkQVbJhu7ck
PpRNjA/+JTknYPLu1U9Zryto9dFpWCuGZHugi1j9rV3VGL2qCpXXHRllJ6BSKm2e
vFJ17riqgbjfk6Sllh+RVBfVNEY1wYYhFMYJiHg4g91zUNEZcxkqXuIMnRE9dvje
2KKiJWymanPvKyLzpcQHenf7LiCEbHx9+mgL1ecUhDW1stL5Z2r6LZw+BECdJge5
NxC+DWxcLqwY0Sw30UG/vPlUCjwV99C9YyhdLvYcXBHb00COITZYk5satG0OctZD
4I+ImcxKFaAXiB3NqXSjhpguug6snhpdP/Ho8rOWD7vByprmmXu1XnGBWnh1IhCq
nkgt9gK+n10qMV4Htmr4XWJJucbqCg7d/4P0fNICOkQkTMKO1436wMzxWo5oqXbO
ksu8vZjCQBhcyJR31ak4FctmC6ASPoByjntqq7BZCjV97gafx93ssijj8kVat5l9
6K9bgZf+29bDGocD1Tw7GSs1UqEvCiHzWUopHtBT+VgEVdx9MtkTJwaP1Ebo893s
uCjiYp1j4H2iZVEj5Z1wuW5AwCw/tff99C0MSObBFvGImfbJB4TKrMrpNRvb+hL6
pZk1YEG+jTEWf8ENJpWnLk4MCXLtEEMiIYkZ2G3NgRCY/1/ITYPUD6q+tLposQaS
rpfXAVhMhjiww9qqpkNujDRb6Z72svF+NQS4Gx3l7f+NWcvXW8o=
=4Ggv
-----END PGP SIGNATURE-----

--jAQmUQbRlR0EhAU3--
