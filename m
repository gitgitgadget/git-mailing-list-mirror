Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA56146D50
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586856; cv=none; b=ufKNgfJI6tN1DdLJmOEnRFTzjhK6r4FlbOBXRwOvpTj04CvicRd2AkXiwShFVmTv+L0YUhsS5z90C1K/ahuVRo4hj1MpBYqkHKz6aKWnjAu4ZrZHyC47GANFfm+ZVWj4lWhPDQqG81mnSs5Rz+4Ypsc9Ahi6SX9TtdKjc95NHd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586856; c=relaxed/simple;
	bh=YI2GZXd+yBM41nXkXBt7QsZASvBsJBxsHxBQF6FvZd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7QVzk6ccaPXh1lIp4/xSwZI1L2FGNaPjSwondWyTl+bVJzooruhNVPVUPVSDvme9c7Wtr+GUSqNyjMFtKtPdvRZVhqwvgSDqLm5BDHAzeL/TX5YGmUuQCFf1qSTiIJpisK6D4hgWLHd+1QzI7Kr9j3PopsBuBxq8k/4G7ufh7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kxlNbZAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kq6CZ3Ld; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kxlNbZAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kq6CZ3Ld"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 30FDE180012A;
	Mon, 13 May 2024 03:54:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 May 2024 03:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715586853; x=1715673253; bh=wTRbn7ToTn
	rLdnJfX5Mt0Btb0QtAaK004ipc4se/GXA=; b=kxlNbZAgYjzq/8XjMYWBKNXYg2
	ENitOlz79tOgqzD1IVht/jHMbYn3x37phqH0Z1qe7jHGm5gLeZVe+Zr8MjkTPcF2
	8royXVC+0vfqecp2avL0hbVk0CrRfXBVz9ofOLI5PGYUh9TpAqA231kV9u9NzX/m
	EHBTiEYjVLBfB1LSUpx1anP5SQTskBW4Jnryjq7YgtHd4M6Sk3MlIDHgob/e8TcJ
	MzmbcQTydYJz4tB34Szb9N6QnPnbTm+B1uOLUYM/+LrM1VOY0IZ6VC8pK11EBA59
	V12upwlI/RIaTX4omAzTgP57BHAf4bnxe8zAQhJ2yBL86zh7SXkMZyuOmMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715586853; x=1715673253; bh=wTRbn7ToTnrLdnJfX5Mt0Btb0QtA
	aK004ipc4se/GXA=; b=Kq6CZ3LdSQ6uWn4Y2/x4+nYZB4owlzzr8fspioad/kY9
	dsIXAy0052tg1C4lNL0UGujJJHKJ/7rcS8pecrYl9PnjKsHqThGSZyf5Nwd2QylH
	yRMMCfUTJTvVzujsLKVa7URTKVewQ99XStVuWZIe3j7ew4SNG5xMl3Gp0LGN0Fze
	b+6zAXUUsvaismSPit9exDB8cGE0AVUcGmpykzdWNHsjq5dZUHpDphKBOVWI3t+q
	8oex41T/Fxv6KLbXFZR8NqtFc1Q/NUxNb/+sUTNTHzh3Q/kFv0mnYOmorucBePK2
	/aah8asVLMS/2FBZvWPpMoAgjGXMkBoszPwwOIAbvQ==
X-ME-Sender: <xms:JcdBZgfVmCWAd6fSDk5LV7bQUNgbI3DwFU2fPeMgUyGWlyoSEty9ig>
    <xme:JcdBZiMa4Q0RAXMhOSRzAGUhoi_5I0sVAKKp9S9_5avOE2hmt-vr9JiWDsv3C8vK8
    PgZ7_fcqTGnV4-mNg>
X-ME-Received: <xmr:JcdBZhjr948YZkgW_K5k8x1M-gD7_LQNC8uALz-2FP-A82iJJR0rZGKq_igKjw-3ojTZVNAqWqf-1kj4D2Rarsb-OBw0-zyKvotJmYpE6VCJmIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JcdBZl8VytgmwTOvbwqOD00SKdFOEamzuHgTWAsrgahpi6cW-o9KZQ>
    <xmx:JcdBZss3Fi-rPnqcvOGgHCGhKJUYnt9i5pt4datGirKFxCVU7hULjg>
    <xmx:JcdBZsG_oPzS7auFSWVczCUvRijGgeQsIgJ_wtXTd39FhQu_LZyqeg>
    <xmx:JcdBZrOcQpPsbC0plviHa_6Dez2PRrbl3T4YOQ_29i2blQS82afYQQ>
    <xmx:JcdBZmW4ah76rtoEGFk0XVCG0sK4eCJT-h007_05DmmCbjGVrRur_Hgh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 03:54:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8e03def2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 07:53:54 +0000 (UTC)
Date: Mon, 13 May 2024 09:54:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 10/11] reftable: make the compaction factor
 configurable
Message-ID: <ZkHHIgyeWq9FCYuq@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <9d4c1f034038df2ae232b6665a0d9d7ee5833c5f.1715336798.git.ps@pks.im>
 <xmqqy18h1fm4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OjJ4whwvjS08USe3"
Content-Disposition: inline
In-Reply-To: <xmqqy18h1fm4.fsf@gitster.g>


--OjJ4whwvjS08USe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 03:12:03PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When auto-compacting, the reftable library packs references such that
> > the sizes of the tables form a geometric sequence. The factor for this
> > geometric sequence is hardcoded to 2 right now. We're about to expose
> > this as a config option though, so let's expose the factor via write
> > options.
>=20
> Hmph.  It is unclear if having this as uint8_t gives us a useful
> enhancement, but perhaps in the future hosters may find a more
> aggressive geometric sequence is better for their workload or
> something and raise it to 3 or 4?  I was actually wondering if a
> base smaller than 2 (e.g. fibonacci) may work better.
>=20
> Anyway, making it configurable is a good first step.  Allowing a bit
> finer grained setting than just integral values can be done later if
> it proves necessary.

That's a fair point indeed. I had similar issues with git-repack(1)'s
`--geometric=3D` option, where you can also only pick integers. There's
also a similar discussion in the patch series by Taylor [1], where I
proposed to maybe introduce floats into git-config(1).

So this may be good enough for now, and when we gain the ability to
parse floats we may convert this to accept floats, as well. An
alternative would be to convert this to percent, where the default value
would be 200. That should give sufficient flexibility without having to
introduce floats.

Patrick

[1]: https://lore.kernel.org/git/Zjk2UIV3kEwZUDW+@nand.local/

--OjJ4whwvjS08USe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBxyEACgkQVbJhu7ck
PpQtJA/7BWSZrZIev8hMYerX/kIJqw72PDk38g1ktWxWENfYgknH9qXgWY+T45UQ
fg5skv/C/MIpUcf6w9qGIGCd4Wpd6vMTyI5Jn9XOrrs0EGgOZzyHMJNa/lj7BoMy
Qdm26AHGzsrwNkxWRFQzFkKGXfvn9Anjamspkk2Om5iXHdM9NgvgRdljd222RtGT
Pio9ZMW5r6EXS82eHz/cV8jDs1nJCKVEC/DZ9YWhYb4Q+32KGgJl6XJy5Ipiupq7
jtqHWImdR6uDSQJ5ATqVWMHcSalK+4XP2c4c9C7J3ktU1gfIldXf9rV9CCGNUxsE
ko/lBFZrx1mB101JJFFRdwAkjlbejnBal8Lgah8TbYKwj5B31PevaWj9Xx1GMdAq
6IiIf4rh4ap2AlEsXgTdivWw9pYHxGFGuqWuMlS5fxnEoh7ATWVIWa75PHAnoT5I
9qE8F2A7RKBqZnWKVHLa9/avc1YNxZi0uEHcDxjrgPrW3eX46JRIx/e4RfhBD3ZQ
6jvWYborvCY4nYkOu02oE5Xs9ixb1oyT1toULpVQvblatr7tGq9Keo/0xXokRHKX
LAKHjTwC5IypJvwiEQzdUuUQsffwW9P8IMl78ngYgz+NGY71466Ngy4Tb6VGI0hu
dul/13oCaZ41eo/nFBhIZU2WT9LAPT7iLRGNVBRdFnhINusrfx8=
=msFY
-----END PGP SIGNATURE-----

--OjJ4whwvjS08USe3--
