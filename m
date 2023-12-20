Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD131F5FC
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JLA7hSnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q8WaxHQ4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 39C645C01A6
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 04:25:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 04:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703064318; x=1703150718; bh=k5K03GOljj
	94eBIBVPouY3rIMOYF88RGeHD8hYCnQ18=; b=JLA7hSnQqIMHQbnnUBpCWMEr3c
	8B/BjSY734qAeTkZFB9BsbcULURt+lHS23F9YIIRXKPrKOG/Gh4JgKxHc8Mj2Cjh
	oXlTc9SAEjU/4pBs4DK8HLzUsiTKJbhbnTVgIFLkwQSEe688f/ANuc29WAKtBkba
	8LN+YbB2OgHTSiJVvjZwmXzf+clucui3vKUFByfxpjUXwIYZM1gTTE0NsMvhB3OZ
	a3z+tf6C7kSdsChAo6UKy2omBbeSDHKf2k6opuKvzfK70RzwFc/0SuQ+K+SbHvmc
	V4DVd9NdG9o6GCh6ASQZagPVGsiqRcNC6aNmmhdGR0LmvlPSo8nMHm4jP9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703064318; x=1703150718; bh=k5K03GOljj94eBIBVPouY3rIMOYF
	88RGeHD8hYCnQ18=; b=Q8WaxHQ4pbw/WP05notCsTuiVvq3YfYHfHPSlynCNfJ0
	8AaCmtsx14cQIUs5f3KRgQxCUm3eLrJa9aXb97AGkEoFuCLq7te2Z6Gc751GgA+j
	/hHfk03W6oLifr+rf4OOQT8VOEa6ffZuhIbjF0v9692c5ZgBQ8Czg3ZDqER8GUwb
	ZRN3RPI8XhkVsIy70m3PIh7BkXt9S57GxIw3W12xWittpsZGYetzqUnAx3e0Pv0G
	36NdwleISUSLCP8d4QHxOwv06WioV7TAxVZpgLU9BvASrD8BTNsQsiiS1u08Ald6
	fioHNsQ8zHJAFQA5lwzbJG5ILYi9EJN1goE+ZBRodQ==
X-ME-Sender: <xms:_rKCZbYnYBU6o3dc6tFkK7KJ51aIAA7bHp7_3G9MZFs_Ehq5fCiWwQ>
    <xme:_rKCZaaIXDWJB9myWnYBmyRd3rooVTvlIPlalqTrRdVsJ0GFCUldcaNNU1FcZjLDe
    xVajrypI_5YMfJJrQ>
X-ME-Received: <xmr:_rKCZd-qk78TVLBjv8jHSOROQ7KchXAzdtok_N4LZNNUxSHI_yHPLC68kFOGy3rJ0TDpdAFnMYyPKa0LYCtbPcOC4cZJsqBAxE1ZrTx9-VvFMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_rKCZRqH22k6Yc4EmqmNIYppkyPMN6w5RBiTB9Fae-aQK6RGYiKWjw>
    <xmx:_rKCZWqmFaI7jmjl6dh-67dlFprXatalgvnc1eOYEsX3q5QalVXC7w>
    <xmx:_rKCZXSzWU3nWDl31pSe3HdV0muI5zAHZ41nRaJ1G3doxqIaV-R3Zg>
    <xmx:_rKCZUHqjqOQoeU65kymgWKNwbC2gMRizhwAwifhlrYkN540iOskNA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 20 Dec 2023 04:25:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd11feb2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 20 Dec 2023 09:23:21 +0000 (UTC)
Date: Wed, 20 Dec 2023 10:25:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 4/7] reftable/record: store "val1" hashes as static arrays
Message-ID: <ZYKy-nnZ3xjXwUmV@tanuki>
References: <cover.1703063544.git.ps@pks.im>
 <06c9eab67802ba933b44d32f5c8d11fddc216c26.1703063544.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8tIOcgqIrI57VQWM"
Content-Disposition: inline
In-Reply-To: <06c9eab67802ba933b44d32f5c8d11fddc216c26.1703063544.git.ps@pks.im>


--8tIOcgqIrI57VQWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 10:17:17AM +0100, Patrick Steinhardt wrote:
> When reading ref records of type "val1" we store its object ID in an
> allocated array. This results in an additional allocation for every
> single ref record we read, which is rather inefficient especially when
> iterating over refs.
>=20
> Refactor the code to instead use a static array of `GIT_MAX_RAWSZ`
> bytes. While this means that `struct ref_record` is bigger now, we
> typically do not store all refs in an array anyway and instead only
> handle a limited number of records at the same point in time.
>=20
> Using `git show-ref --quiet` in a repository with ~350k refs this leads
> to a significant drop in allocations. Before:
>=20
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 2,116,683 allocs, 2,116,491 frees, 76,098,060 byt=
es allocated
>=20
> After:
>=20
>     HEAP SUMMARY:
>         in use at exit: 21,098 bytes in 192 blocks
>       total heap usage: 1,419,031 allocs, 1,418,839 frees, 62,145,036 byt=
es allocated
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

I screwed up the rebase. The following diff is required on top:

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 56c0b4db5d..87b238105c 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -809,11 +809,10 @@ static void test_write_multiple_indices(void)
 	writer =3D reftable_new_writer(&strbuf_add_void, &writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i =3D 0; i < 100; i++) {
-		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
 		struct reftable_ref_record ref =3D {
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
-			.value.val1 =3D hash,
+			.value.val1 =3D {i},
 		};
=20
 		strbuf_reset(&buf);

Will fix in v2 of this series.

Patrick

--8tIOcgqIrI57VQWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWCsvkACgkQVbJhu7ck
PpSKxQ//bMnBMZGI38vkzFbpP8fLLn/W8ILh/jC6UJWxY6n52Rfhtx5joMy0/G0/
cpKKeCvROEiy8osP7kpV7GgrUf83IR4DwoisF4+czvHZD0MMXJBABTyoTtg/6+Zt
RMURMYE66WWlPUy+fLPa5ecq2605ee3xjx5KOAprl4XjxXMgO8I0hRZpbmIaMzMj
TZDo0L/dcnfaCwrgVzXp/GvlprjHhwmd5Q9X6X8PznbgqEh3N88SCBH/wSh5uXND
8EL83RqQNPVLWyusHXQx3MqMihfCBTl16cvgnA1xROChOW6oLBKe7jZ23VEEB2nj
V8ju1PpVbhG/U5N/9uWmZoeBIrux7o6LUVoWZrR0V75uiCNrrDJDZQANMSdWu3yU
KpVS4+ACjRHabrl0Lzn6MvpinO8P9QEU/a+YMslyX4cGkxX4QuYD6fUUDGEN0wIZ
jpkYi0jsHHDdspZ2Jn7AI+rbHCRbCOCW0MPktjPjBOl2lPSBHjGFTfeo+a3UTMvU
xrjwdwQ6NElNGBoV1Tz6VjU808xZVh6x/GsFl+/Mrc3rlzbsNC49Pyfa5kACy0jt
QyO5UiW26tGvjAfEY5B3Zt6JsZCrBlZdDL6DeHu6N1TgDaW0drgm11VM8q5RmOcz
UWwVN3MvBkA4XYHiMvi9T1cMpGudEalwORAT8nxJi1zw0Peg9/c=
=yKtm
-----END PGP SIGNATURE-----

--8tIOcgqIrI57VQWM--
