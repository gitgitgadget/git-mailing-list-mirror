Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF486AFB9
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578639; cv=none; b=g7awlxaYNEUcuP+w0pYmg+c64FqnbFnptxpBM10mWDzBn0UQ0yQfeY5Jm52HMFP1BwGnBpT1U+V89FZQ8j4Vb7yAZC/Dd5k3FNU/yHz5Z4O+cuNDgUmwNjBDpE26imqLZYcI01Itw6N6yuRKZ77IuhYFaU72n5iAHxwGPFHdRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578639; c=relaxed/simple;
	bh=1UEgWNZnr9G4511/3cJBBdqCDUCMT9TgB+6HvJtmbgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm4MgaPTx2BG6hn27IVjSey/rzXcLHX+ptlUc1rPjPB8UwHP8lJChjj25WkSCY2CgfPHf0upgV3dTaAAxD1tVsYs97wE3u1lufprxdJX11+PvVS9GwDyKlykA4eVz0Hx3LOaJU5YcLUsVMKyzbQ5AhPL3exMbCind6Jtu04fa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKC7H7WR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l1/7/fk3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKC7H7WR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l1/7/fk3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 65E161140102;
	Mon,  8 Apr 2024 08:17:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 08:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578623; x=1712665023; bh=wEKJIAfU57
	wpqnBkP3PTUTptULU4fSXfGYx2Oz2y7J4=; b=XKC7H7WREtkTVffpLFbCWZgD3R
	Rx4pnRwXQDtgVfG3M4fqba8vRQ8wmO8naGUPk1yZJniTVBfr3DY8JI7R3QPE4uNz
	kKsFl7zTiCKy6YktfIz/1oi2ZcwXcJ6U3pp8WVFM5NrgmC4y5qfkbDftR/RL3U0Y
	tNdGatDVGZpir13akWTNiQsoE/BLFPm+r8k2ioDpOc3b9i3llDs/9cY0+uov+Rh4
	TVa8Oi10mJvmLOi8nVH/leIilNy1qenkYKCz1KkzbeaBHkVK+B6A0BeGeRePJXOf
	ye4WsvM2tk1ZPm2m/5su9y+ptPjWEza0BzNgU5+56hCGPRVOBVHWQMpF6huQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578623; x=1712665023; bh=wEKJIAfU57wpqnBkP3PTUTptULU4
	fSXfGYx2Oz2y7J4=; b=l1/7/fk3ieFJanyX3sCK6oXEgxjORBFuBztxONzyeed7
	5eRmfqGdf8yNrhFLhawmd8BPTp6M2MlyrPLP0IpfJx3ke/h+SEtQyxECb2CpXPET
	zV3RQjPeCj8d7O3PnNcWeUOmPf5OEJagLGX886sqTZXaEIrldeQOmGfbAIJfex1A
	B1ngu5wnw53z4KlNXhHjTJJPnZ5nQn5H3cQCB4aPAwHvS+QjIpOVTi0fi6k5/4ww
	fx5qBpP1X15yexLVf9M1u4xeDVWCWGH5vG0/HLAC1QNEYQibmEkq0PKCXFWim+/G
	HEhdnwbgTT8xDqshLX1iqGHaVHuvyow7ysNOUew1hw==
X-ME-Sender: <xms:P-ATZlFB2G00xwMtJmUM8B1ayrHArfgrMvlCz_fh8O-uLYZI8y2TEg>
    <xme:P-ATZqWxZMyLaKYu3_CqP4uQwosoKVHV8wWriUx-x-C3t5MzCvRMLgcr58zxmurrP
    306kqOfga4dTpxjUw>
X-ME-Received: <xmr:P-ATZnI59k8ZooE4sK9mvjvBcPLPEWHTFOVKURvxPgWlodEcbfN8L-cNKHqag9lUx4vLCpC3ob9qNcGYhe0Ynr-ADDthTFhRAS8YUTvllw9AvjAJ3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P-ATZrFNblmbC-nJ5bNrYJJPVmQgGKBy1LWMhbLf9kNryWFH28eokg>
    <xmx:P-ATZrXeM4fqqMwrcd_9cCtf6M99kHaIFQPGLFcaz5B2wNl2wSJiKw>
    <xmx:P-ATZmMN7_Dr6ngqhgb_gx74rhPSE4NrXRGSxYCUFgmlIPq-O4O9Fg>
    <xmx:P-ATZq02sf-FEUNQmO16JSqoZ8NIn-umwVKxd5oxphLqGPJDeUZhSw>
    <xmx:P-ATZhwOwLXvfJI4D3scQL1sKwucntmBKuDHc6SoOKda2tdP6orCU8Fw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:17:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id af7e23ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:55 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/10] reftable/block: open-code call to `uncompress2()`
Message-ID: <6635c7b986559e0684a3c5d374bb3460aeaa0084.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="akx34UdUtPRLNf3J"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--akx34UdUtPRLNf3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format stores log blocks in a compressed format. Thus,
whenever we want to read such a block we first need to decompress it.
This is done by calling the convenience function `uncompress2()` of the
zlib library, which is a simple wrapper that manages the lifecycle of
the `zstream` structure for us.

While nice for one-off inflation of data, when iterating through reflogs
we will likely end up inflating many such log blocks. This requires us
to reallocate the state of the `zstream` every single time, which adds
up over time. It would thus be great to reuse the `zstream` instead of
discarding it after every inflation.

Open-code the call to `uncompress2()` such that we can start reusing the
`zstream` in the subsequent commit. Note that our open-coded variant is
different from `uncompress2()` in two ways:

  - We do not loop around `inflate()` until we have processed all input.
    As our input is limited by the maximum block size, which is 16MB, we
    should not hit limits of `inflate()`.

  - We use `Z_FINISH` instead of `Z_NO_FLUSH`. Quoting the `inflate()`
    documentation: "inflate() should normally be called until it returns
    Z_STREAM_END or an error. However if all decompression is to be
    performed in a single step (a single call of inflate), the parameter
    flush should be set to Z_FINISH."

    Furthermore, "Z_FINISH also informs inflate to not maintain a
    sliding window if the stream completes, which reduces inflate's
    memory footprint."

Other than that this commit is expected to be functionally equivalent
and does not yet reuse the `zstream`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 9460273290..435922b569 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -195,10 +195,10 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 	}
=20
 	if (typ =3D=3D BLOCK_TYPE_LOG) {
-		int block_header_skip =3D 4 + header_off;
-		uLongf dst_len =3D sz - block_header_skip; /* total size of dest
-							    buffer. */
-		uLongf src_len =3D block->len - block_header_skip;
+		uint32_t block_header_skip =3D 4 + header_off;
+		uLong dst_len =3D sz - block_header_skip;
+		uLong src_len =3D block->len - block_header_skip;
+		z_stream stream =3D {0};
=20
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
@@ -207,15 +207,33 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(br->uncompressed_data, block->data, block_header_skip);
=20
-		/* Uncompress */
-		if (Z_OK !=3D
-		    uncompress2(br->uncompressed_data + block_header_skip, &dst_len,
-				block->data + block_header_skip, &src_len)) {
+		err =3D inflateInit(&stream);
+		if (err !=3D Z_OK) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
=20
-		if (dst_len + block_header_skip !=3D sz) {
+		stream.next_in =3D block->data + block_header_skip;
+		stream.avail_in =3D src_len;
+		stream.next_out =3D br->uncompressed_data + block_header_skip;
+		stream.avail_out =3D dst_len;
+
+		/*
+		 * We know both input as well as output size, and we know that
+		 * the sizes should never be bigger than `uInt_MAX` because
+		 * blocks can at most be 16MB large. We can thus use `Z_FINISH`
+		 * here to instruct zlib to inflate the data in one go, which
+		 * is more efficient than using `Z_NO_FLUSH`.
+		 */
+		err =3D inflate(&stream, Z_FINISH);
+		inflateEnd(&stream);
+		if (err !=3D Z_STREAM_END) {
+			err =3D REFTABLE_ZLIB_ERROR;
+			goto done;
+		}
+		err =3D 0;
+
+		if (stream.total_out + block_header_skip !=3D sz) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
@@ -224,7 +242,7 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		reftable_block_done(block);
 		block->data =3D br->uncompressed_data;
 		block->len =3D sz;
-		full_block_size =3D src_len + block_header_skip;
+		full_block_size =3D src_len + block_header_skip - stream.avail_in;
 	} else if (full_block_size =3D=3D 0) {
 		full_block_size =3D sz;
 	} else if (sz < full_block_size && sz < block->len &&
--=20
2.44.GIT


--akx34UdUtPRLNf3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4DoACgkQVbJhu7ck
PpRr3g//Qlu4uDgQ5R3cNvXYED6A1Aypb+kzo+tzTW9b8H6+cBzjQL1o93vBlXuW
nTi0nTHDXILnXBhctpCX08i1SQYAnaXJ9uVmSKIQvgZYk09HvRMnHtGJOmzAeDHz
6zVP/cBl0Uvw4651/XSQZ/l7jY1FfuYisAjr7xYML4zrbdB9eB3FRrR1z6ZcHg+o
BtWTmJD05gGPzUkDKukCDrRaIJY8pFIgfShf3NLaR+njSgVxaTess3LWhiUgcmDV
UAtlaWTgHEk3zc3qQePIrxAQEFXp+TRSTOGZn2E3hOR5+Dx4t4hSrCGbSF7+YphK
lITBQ9h12WgUw+ohKq+OR7fdmcQ99oir6ACvCgCjEmdyheBTF/2JzWP/8Aw2paTB
Ca0utB04yNBB2X+UJ7X+SCXu+tZLDGTlibmFsxwC7QVk9tJp7glBD0JUosC0P2nT
3tcu7uUvlHjhvKO8OSQk7cFtC2KvlnSvTOSqaKLAT+A4N6Gn+sY0zcXrb2HNO6Ep
+9m8mXYrS1GNnptDxX0ytIhcmEebF4zeTFz3uUnHlMJnVGBItY31jKCOkbnwLmg3
KwNsQyn0gZVh443iRY1oPHjGjM1qWmTKa3O9A2WnSzYaLZDCkGFmm+H+3IsAFnRy
FBh610J+ge74KwaZGgr8gUS8Tizs5WoMadVYuqAVuqTp+zewzhU=
=rFQw
-----END PGP SIGNATURE-----

--akx34UdUtPRLNf3J--
