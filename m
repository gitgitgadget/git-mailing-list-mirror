Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364412B8E
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0MI7liem";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kfrMGiIK"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB95B0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 02:19:20 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 1CD1E32000E5;
	Mon, 23 Oct 2023 05:19:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 05:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698052758; x=1698139158; bh=3I
	8p8kW3ZxfkNwOc35NjvyrZHq9+4T5znqklSJNTRXk=; b=0MI7liemVN5LyvCMTw
	WiX5m6cOEH0CioyjESv8Mih6mJS5rfOxpdld9WptLWEVURY/g3oCbA3q3sRaR/5z
	ddAVplTYYyZ5yor8LidTDJiczlRsc1zwLdVMmgqYLPl5ouO3OEDXbUFuaPIZIdAf
	EWZs4thxqnLKnXOB4BmkbnoJ+2nfI/F7HrbY9mAbZfLrK7fw0VEVz0PxZpRpR7js
	EItt3jUnRgt+PHVFx0cd7GJizEdcXe2ejFlw8tE0aS9AnP2KJZJujFW7G5QzGipU
	B4s5Ti+qqvZ2Dx6DqstD6WYV2aJm+PZ3Pb/JC2mH5Uz4xCDY+6wNFAhGsalHVpPm
	K9jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698052758; x=1698139158; bh=3I8p8kW3ZxfkN
	wOc35NjvyrZHq9+4T5znqklSJNTRXk=; b=kfrMGiIKblpsKAOM69QdWe+T6h470
	Rf5J2huUaqBfY6V0mHz5xUG4s0Tc1F7Rt8Tx7m04DosrnQxYKw+qH0PfhjfHHXYQ
	hsGazTZ5B6UxRGQGmGGXU00ToepIKX370IbbOCePYdTapya6vIxg38XlKOQyHY3y
	tzh2unXTCx3h0UEAc/E9Z6ZGE7UAQBDHsi3vq+sSt+RjqP8QojO7K1Q0kFJnzQSJ
	MiKi3hno7O3cVA4uou1S0xqoyoUYfWfMa/s4pSwvY/lRZsF5BLSyr7ot4RcSm1C/
	brPfmPOfdl1hCmlocWkZvTVAGBi389EuOPyVrzTuCJYLE8bhrq5UidI8g==
X-ME-Sender: <xms:ljo2Ze9oiJEPE6_CEowKkCM1IbEK0cYfMKc-zjMyq6wjuGpCioXGCA>
    <xme:ljo2ZeuDpcucgC6QTq_71lU59McZNHZTWq4F6fDpNUQ3zfiSrdM0NnPm37nrHsxou
    8S1tQHW9TOJLlwxdg>
X-ME-Received: <xmr:ljo2ZUClAsiEbIoMM_zaMEPGRrEezylYcRnFHKWp-1zw_5AaJ-BcMwzR2y32hlSDbgPowm8c1LdJpIRyzVLyQmATTw6RvEKZuXPBvFxWJ-ju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ljo2ZWdIe6U3-st4cJLYiOHWnuPDxws9PesBuVRvxh9718kmpdsWAw>
    <xmx:ljo2ZTMiwoX3DrmsMgYXWCmzhn_bCYLS_0JdK-96Y3bpG0-acUIE6g>
    <xmx:ljo2ZQn-TKBafSi82EmFtWnyMNNSicGe8GyT2iB3vw2KexUM43k7Pg>
    <xmx:ljo2ZYoQyGwxnWLyVWl7qT5hvLsEVfcXalNyw70qNCPIfvBTwLDLiQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 05:19:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a4bbdb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 09:19:12 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:19:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/7] bulk-checkin: implement `SOURCE_INCORE` mode for
 `bulk_checkin_source`
Message-ID: <ZTY6kTZT-ni16usH@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emjz+GuRGrQ+nK9U"
Content-Disposition: inline
In-Reply-To: <e427fe6ad383cc238c13f313dc9f11eab37a3840.1697736516.git.me@ttaylorr.com>


--emjz+GuRGrQ+nK9U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 01:28:51PM -0400, Taylor Blau wrote:
> Continue to prepare for streaming an object's contents directly from
> memory by teaching `bulk_checkin_source` how to perform reads and seeks
> based on an address in memory.
>=20
> Unlike file descriptors, which manage their own offset internally, we
> have to keep track of how many bytes we've read out of the buffer, and
> make sure we don't read past the end of the buffer.
>=20
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  bulk-checkin.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 28bc8d5ab4..60361b3e2e 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -141,11 +141,15 @@ static int already_written(struct bulk_checkin_pack=
file *state, struct object_id
>  }
> =20
>  struct bulk_checkin_source {
> -	enum { SOURCE_FILE } type;
> +	enum { SOURCE_FILE, SOURCE_INCORE } type;
> =20
>  	/* SOURCE_FILE fields */
>  	int fd;
> =20
> +	/* SOURCE_INCORE fields */
> +	const void *buf;
> +	size_t read;
> +
>  	/* common fields */
>  	size_t size;
>  	const char *path;
> @@ -157,6 +161,11 @@ static off_t bulk_checkin_source_seek_to(struct bulk=
_checkin_source *source,
>  	switch (source->type) {
>  	case SOURCE_FILE:
>  		return lseek(source->fd, offset, SEEK_SET);
> +	case SOURCE_INCORE:
> +		if (!(0 <=3D offset && offset < source->size))
> +			return (off_t)-1;
> +		source->read =3D offset;
> +		return source->read;
>  	default:
>  		BUG("unknown bulk-checkin source: %d", source->type);
>  	}
> @@ -168,6 +177,13 @@ static ssize_t bulk_checkin_source_read(struct bulk_=
checkin_source *source,
>  	switch (source->type) {
>  	case SOURCE_FILE:
>  		return read_in_full(source->fd, buf, nr);
> +	case SOURCE_INCORE:
> +		assert(source->read <=3D source->size);

Is there any guideline around when to use `assert()` vs `BUG()`? I think
that this assertion here is quite critical, because when it does not
hold we can end up performing out-of-bounds reads and writes. But as
asserts are typically missing in non-debug builds, this safeguard would
not do anything for our end users, right?

Patrick

> +		if (nr > source->size - source->read)
> +			nr =3D source->size - source->read;
> +		memcpy(buf, (unsigned char *)source->buf + source->read, nr);
> +		source->read +=3D nr;
> +		return nr;
>  	default:
>  		BUG("unknown bulk-checkin source: %d", source->type);
>  	}
> --=20
> 2.42.0.405.g86fe3250c2
>=20

--emjz+GuRGrQ+nK9U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2OpAACgkQVbJhu7ck
PpTe8w/+L7/q7t4ObqfvpplaexLfvm+Jg4kGYzKoUZgMIfW4rQy8l/9nUPdtXEbP
M8fnYd/WSUKIBnI27/e902LeUkBpOtXoAF5dVYS/eg/90ivuzwHYBD2es0jMc+Lf
/497tLBAJr+pBt3N1PqBEdWjNrQ+ywBbr5ovjdb0+3EcYoOPRHVE51j8lgv9XWDU
wEqxhs5U7jjqGjotMS6HpmQkIA086XqzyH+8EWB5cC7nSN6wnrrhbMjrEHPkFIxl
B2VFRMQ9HHQ5hvxzDGEo7WW8u23MkIm+YFpnCdm/iv5QAhT4/q/UP0ckasPk4O3o
LCYGXdT7e+mpysq4Hnely70GWGK6LINstLIoNZABBPEI/6iOKS1ms00mkDK2znaz
Gf9aQ4XtbJoa8h0d5M+mVWhY5gQ8NZY2cOkcAl6guH3hNBOuLh0Pdhq1EI7VbNcj
k5rKA5p6js1Xq68cpvb5990usm0Wdn53n00dzyttvq7POsK1G3mm8aIbrfFlLnGz
o5/NuM1oA15ZHO/ZgTyS8MWMPiFdEkx3ap/xIhSq87JbUcXNBN2dEPIjkBFm5+OG
Uni8ydKkwFIliGprcQ/68uTFcouz5G9AdKylY/SJotpnCz8DI6HIm3IzMjLXeJbe
mScXdxgpcoZBckyZXV/mFYF0CxGyU+XWhlI5HgiSanNBR/w2vU8=
=iIej
-----END PGP SIGNATURE-----

--emjz+GuRGrQ+nK9U--
