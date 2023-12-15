Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5149518C19
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ezqbVJ33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8nyUrZf3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 7503B5C018A;
	Fri, 15 Dec 2023 04:56:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 15 Dec 2023 04:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702634203; x=1702720603; bh=TgulH1rnbw
	+6WiR+uWY8PO5SN+QjbR/grbAccU57KHE=; b=ezqbVJ33UoY/pcYy8ice+hBxMx
	YkkZA2GZi7slP4cX0Xmj/zGtDOyRJVdZ65fxuZY3dcCXjwOeg8n4ytHYHizFBmp2
	Az7Zx81TKgwbn7iFVTYoCyQu8fs4VqBuOl+DJ69Xb9iAHpS3mXOdkcsa9bxkqsnS
	8IKjClJSzrAjhqLyCdPJ6bsNaaiHWHrNzfwuLjf81Z+WfSYFORr4mVR/F4Pp9/PB
	CNG3UoT9yd9M9OKOE7OqXto2Scb2a7WlYkAkhYDQE6bsy0kLZvuz5RGb/xPvBRza
	dwdXLwH5gyiEtDpkP5+Xr/alsnyO3ck8F3I74Tik5TGpvmy5U4tQY7QarFzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702634203; x=1702720603; bh=TgulH1rnbw+6WiR+uWY8PO5SN+Qj
	bR/grbAccU57KHE=; b=8nyUrZf35b/BxaxUMrafVXk30W4fVCdAGbt5DZDJ01vn
	2E3g+qCxMPJt9UqmUXBMllupnLJaUgjliUCLznYGDVHv7BSVHokaT7hSZcfTWfN1
	nhMTvsjKDBy8pQUC5gAU4JZlma4x88ggwA+I8bGuoYZMGlHlklc+n44jG77flmOx
	ejzjSrLzEOhVkp/60pkxcHisIPX4JmzmUDfDutoU9+D4pJrPIseWo0mwqGPHKhlo
	jS0R7GdOzmWO89IoNonKdUuv/GtHZ58B2Qua8VnIswgsxKKR35lI0a49gOdrfTae
	PIFHl7ppVB424fNikQDurDJvLbNY81PA0RZU1joUVw==
X-ME-Sender: <xms:2yJ8ZX-1baD1nj4i4VoCg4_ie5BFLl6i0NLQlbcWERyr1nNKNIzB9g>
    <xme:2yJ8ZTt90Jpk1Aia8e9YKY9-HlzFCbWajCTY8YX6aFu2vKV94h4MdN-D0B4TLqt8B
    ZQ69dgyRmskeWpgKA>
X-ME-Received: <xmr:2yJ8ZVCsDM_-0cyz_clzhcP-vmei229gvIDF9pDPSQ2BZwtr483ou6x5I4s8ite37d0G6pHY1JiDOKYXFr6HaRVJ5M2udPIY-78-uDLYcsznzlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2yJ8ZTeq2AkyjuvXeogI55361WkaA0Fe_VN_BtO526ltoNcyKsNw4w>
    <xmx:2yJ8ZcOnJbNBZGu9DnSqvTqNs0eabrlvccE9nJNHUaJ0tYKoUl_yJw>
    <xmx:2yJ8ZVk8bF4VFdQeXsunrpN1qWYyVaiLFFeoWQsUdOwaX3pYQ7_C4Q>
    <xmx:2yJ8ZVbKBpS5wVO9uJEzBlxAgco7t2K8sGCHl9nuGFUQcK33jfcYxg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 04:56:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2113e813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Dec 2023 09:54:57 +0000 (UTC)
Date: Fri, 15 Dec 2023 10:56:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/2] t5574: test porcelain output of atomic fetch
Message-ID: <ZXwi2MA-KUxszfGj@tanuki>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
 <210191917bcfa9293622908c291652059576f3e5.1702556642.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5cFdf1GcgdsCKFwi"
Content-Disposition: inline
In-Reply-To: <210191917bcfa9293622908c291652059576f3e5.1702556642.git.zhiyou.jx@alibaba-inc.com>


--5cFdf1GcgdsCKFwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:33:11PM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
[snip]
> @@ -91,36 +85,61 @@ test_expect_success 'fetch porcelain output' '
>  	git checkout force-updated &&
>  	git reset --hard HEAD~ &&
>  	test_commit --no-tag force-update-new &&
> -	FORCE_UPDATED_NEW=3D$(git rev-parse HEAD) &&
> -
> -	cat >expect <<-EOF &&
> -	- $MAIN_OLD $ZERO_OID refs/forced/deleted-branch
> -	- $MAIN_OLD $ZERO_OID refs/unforced/deleted-branch
> -	  $MAIN_OLD $FAST_FORWARD_NEW refs/unforced/fast-forward
> -	! $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/unforced/force-updated
> -	* $ZERO_OID $MAIN_OLD refs/unforced/new-branch
> -	  $MAIN_OLD $FAST_FORWARD_NEW refs/forced/fast-forward
> -	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/forced/force-updated
> -	* $ZERO_OID $MAIN_OLD refs/forced/new-branch
> -	  $MAIN_OLD $FAST_FORWARD_NEW refs/remotes/origin/fast-forward
> -	+ $FORCE_UPDATED_OLD $FORCE_UPDATED_NEW refs/remotes/origin/force-updat=
ed
> -	* $ZERO_OID $MAIN_OLD refs/remotes/origin/new-branch
> -	EOF
> -
> -	# Execute a dry-run fetch first. We do this to assert that the dry-run
> -	# and non-dry-run fetches produces the same output. Execution of the
> -	# fetch is expected to fail as we have a rejected reference update.
> -	test_must_fail git -C porcelain fetch \
> -		--porcelain --dry-run --prune origin $refspecs >actual &&
> -	test_cmp expect actual &&
> -
> -	# And now we perform a non-dry-run fetch.
> -	test_must_fail git -C porcelain fetch \
> -		--porcelain --prune origin $refspecs >actual 2>stderr &&
> -	test_cmp expect actual &&
> -	test_must_be_empty stderr
> +	FORCE_UPDATED_NEW=3D$(git rev-parse HEAD)
>  '
> =20
> +for opt in off on
> +do
> +	case $opt in
> +	on)
> +		opt=3D--atomic
> +		;;
> +	off)
> +		opt=3D
> +		;;
> +	esac

Nit: you could also do `for opt in "--atomic" ""` directly to get rid of
this case statement. Not sure whether this is worth a reroll though,
probably not.

Patrick

--5cFdf1GcgdsCKFwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV8ItcACgkQVbJhu7ck
PpQghQ//QQ3LoF9xmRcOM+2dLq1Xtvb4IrTfvJAEUU2BZg4gc52Rs3zqq6nbiLIC
qZTxmZRi5Kn5jY7s6OFz+KWct661JgJx7BPELAfW8LtkomiCZ2GkO3vqCa6c08y9
8uEhlZH/D4LavAr5SgRCeb2UCmFUb/iSmB4fPzb4a8x/1HDJrlnLqDtdPZ7b1Ynz
YTO4/VP9X3DnGKUq5LKcrMMxc5TVF+dBYb4p+OJ9yQeVLUYL2BHEUjFo+7HNExCh
dTMbBk2eYQ0RGz5GzDzTVU+6uixipbzUjOI9xaA+EC+UgkpvDqivCrdYjLrh+mkf
7ZB+MI9/gNo0DnxpErjdMOItC+zhZNGX1GiSXIkL2t+OU39iE0yYYO9GxWnDmf/q
iqaKGOjk6l/Sx/ObYj0zrecMFiYIaplh5Ry5DUzStVtGmGD7F5YlJt3m5Kj3a8Ad
iPwfFodqH3Y1tTy+dgkBBsv3x1QS0fzFLt3Z/8IqX51kiLEh108EDMJDUpWtIS0w
TNYY4BVu2heQXpNgofVh43puONV7PqS/RKBVDkgxgVewpuakCppbORzh8BJZaFVl
nRAzBtCycVVab0fWZiVscd+eOApLMB+PNiDHLGwULXDxXfl0910ecjZVflVL8YXt
rHtsKd4g9Pgpxq+QfgjyS42bqXcUecvfbc6Z39pA2jjDHLgMwQU=
=5wPW
-----END PGP SIGNATURE-----

--5cFdf1GcgdsCKFwi--
