Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFE5B1E1
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335261; cv=none; b=AkguSgbUCd40O9BpbtOrpZUBrKeauC+tjZgJnAPzlHdQGYW4FPYaK6uulwXL8ZnzZ6EIEfwxs0kk+BBPNNRTSJ2bv1XQ9nrRGoUi0+ZlvlTIOP7/MkpUIVZlUeY2+lHhv7Ln5U35P660MnKykR8qi2FJ0UkQww78NGC9pQQ/fPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335261; c=relaxed/simple;
	bh=E2+nVhGD5+IVgfvra34/3m0sZ3cQmb+z9/FGKghoyvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfBRwhYkZqkPatEF7Fx+p+SsWR/nqA8xmCUBRe98FzJOj6a7ITj0+hZnGnUHlJw4+AHfof4YHOnLIsZBPmbjHshfkm28GF+hACG9F/85JF9Un7t40NU8EVFW7mDQDiuFnCZlK97CmJtFAg9scJUL/0aCfYauZyumO7f/ifl6vaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lbXOr/yU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zoj1Y7Nh; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lbXOr/yU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zoj1Y7Nh"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 1173D1C00081;
	Wed, 17 Apr 2024 02:27:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Apr 2024 02:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713335258; x=1713421658; bh=N4W/xQ4F5m
	wR+l+qM7bCjo7iI9pcroyVx2UKLHbv1w0=; b=lbXOr/yUJ0AlvpWUAB6h3BECwY
	ZLmWS7OkX2M/4zsLANYSed8oILrvl9Xq78BSnpCcaYltmxAD167yNJ+8XL1m1HSa
	zPBOSy7K3cDTTqMklrkKX2LD+Z05d05sHvrZnCHfqpp6UXl21UfovfLcPrr50Jkn
	wxXaDUDhODfOSAbDkg4OgWqQ3UY5tvCxApg1BEeh4L7U3AqFS27m2HhLNxUdIEtN
	3SsxEw8yq3WH0nkN34P5Kyg4FYePA1OpRAkBLy+YrafePNqheGEvjmF+jUm83fA6
	VQClXLfrH9ElnVKvTHtMqDbQ3JqpbWgwvKIGOgwD1UQbhafjkJhxl9KlVKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713335258; x=1713421658; bh=N4W/xQ4F5mwR+l+qM7bCjo7iI9pc
	royVx2UKLHbv1w0=; b=Zoj1Y7NhxmVuxOnbrAPvK5yHVbFhvK0W6rlJ0fTfKmdy
	T0RmbFqg5U+MpASkbtpFWZLOVNvmW9NWXbQTBaeBPSVj//eUyyjhwlU2QzUNP+e8
	RI03K/Zgw95UbqMkStLIO58dUYmYLOwSitl+rUFdw1jw9PLTOyyklYTiZJakF96Q
	naFxmVY8UiTIb0bELDU/dFZrlKHbk00jdiTSJYsl5X8EySzT1TdypWgFWk5jOApQ
	veuWzraBbGGOm5F2eR7q3FnloI6S1riNI9sr09RSCSW70vlvx5962u1VtXuGZtVu
	x0+EWB8MTbq2G2ihnVI2RjWupixnw6xOHfC4X0fm0w==
X-ME-Sender: <xms:2msfZkdcl1LPrFR9KTu8FYY8S6_LSPhIo4oayYvJ5oiK_8680KglCg>
    <xme:2msfZmMwxBKp6n8yHtYF1bZKpaeLbbuLZ_V7dzYAVEL0qh3XCQ9e6vf5iApa7_eCu
    ErTVBWcQbd4mHDD0A>
X-ME-Received: <xmr:2msfZljkpa01dOHvuPp1ohxdXJUqlv3So1sruHgcIrZiZ3MOcCVGWzyn_rIfbOpZAKJkiO2B4rF1Fheb1_gTh2q2MJ8S8OHfsUpMYb9h0Auts0Kd4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejjedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2msfZp-1zBC1RN9z5Kxc9-5ppQgjtIAvBQ_R7tPCezDeB7MZtFV7bg>
    <xmx:2msfZgvzLZ9fsTQtqmKomgDlfq_SJPzhB9BRdSZaLzT6e4bOW8oFdQ>
    <xmx:2msfZgH69iek-UDqdpgjBxEzqV8ocVLvpk5nW9TEvd3WiBiAZW8BxQ>
    <xmx:2msfZvPpTrLd9-1gfWEYheMOQAVkZ1jvl7CuI89ev3GaZ632-A_xRA>
    <xmx:2msfZp42QsHYUcTAeqG-fn1Bl_G7q7eH6cTx4Mkp3a3cKUjOaSX1PZRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Apr 2024 02:27:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6e2730c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Apr 2024 06:27:11 +0000 (UTC)
Date: Wed, 17 Apr 2024 08:27:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] format-patch: fix a bug in option exclusivity and
 add a test to t4014
Message-ID: <Zh9r1K2_T5wvVJVC@tanuki>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfWTlQR/c1yJMXw0"
Content-Disposition: inline
In-Reply-To: <c975f961779b4a7b10c0743b4b8b3ad8c89cb617.1713324598.git.dsimic@manjaro.org>


--jfWTlQR/c1yJMXw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:32:42AM +0200, Dragan Simic wrote:
> Fix a bug that allows --rfc and -k options to be specified together when
> executing "git format-patch".  This bug was introduced back in the commit
> e0d7db7423a9 ("format-patch: --rfc honors what --subject-prefix sets"),
> about eight months ago, but it has remained undetected so far, presumably
> because of no associated test coverage.
>=20
> Add a new test to the t4014 that covers the mutual exclusivity of the --r=
fc
> and -k command-line options for "git format-patch", for future coverage.
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  builtin/log.c           | 5 ++++-
>  t/t4014-format-patch.sh | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/log.c b/builtin/log.c
> index c0a8bb95e983..e5a238f1cf2c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2050,8 +2050,11 @@ int cmd_format_patch(int argc, const char **argv, =
const char *prefix)
>  	if (cover_from_description_arg)
>  		cover_from_description_mode =3D parse_cover_from_description(cover_fro=
m_description_arg);
> =20
> -	if (rfc)
> +	/* Also mark the subject prefix as modified, for later checks */
> +	if (rfc) {
>  		strbuf_insertstr(&sprefix, 0, "RFC ");
> +		subject_prefix =3D 1;
> +	}

As an alternative fix, can we drop `subject_prefix` and replace it with
`sprefix.len` instead? It seems to merely be a proxy value for that
anyway, and if we didn't have that variable then the bug would not have
been possible to begin with.

Patrick

>  	if (reroll_count) {
>  		strbuf_addf(&sprefix, " v%s", reroll_count);
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index e37a1411ee24..e22c4ac34e6e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1397,6 +1397,10 @@ test_expect_success '--rfc is argument order indep=
endent' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success '--rfc and -k cannot be used together' '
> +	test_must_fail git format-patch -1 --stdout --rfc -k >patch
> +'
> +
>  test_expect_success '--from=3Dident notices bogus ident' '
>  	test_must_fail git format-patch -1 --stdout --from=3Dfoo >patch
>  '
>=20

--jfWTlQR/c1yJMXw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYfa9MACgkQVbJhu7ck
PpSUMA//a0RrUA6RjiFAGjVNG4tZfUzvAx1ERXpZeloIPWmKLbX744OpEMYJT9ku
ifud+0GLcKq+QZ/Mnf4s7XFTsvQDXal1/LDYgerrXZFf70N1dRpwq/4dtTXyjEBn
WdpXSiczFLpphitJPMavMkd8qqoUSKh86DZZxgsMWPyLXp7Q7oqDFDWW9eeKNgAh
ujnkv755q31/BEFwddQfkLDhLQzKsHVd+piUKJCA/X/27/2Ptkz/Z9vvKzT/Km9H
s04DvjSPd4h4eIUBO2FGfzMhOpfUUoHuWi3XGHM/dQCqQ7ciK9KJULpcMkE0wJly
Vz2TdhE2u2HVTJeLKL024ORog0AWcNlPR6QD8iv3z7Q20acg3FQg7Kbs8ewFyrP0
4ZR8FUeTdoXJwEfKkxRR9zriAHtiDfUmtXFvrK250qKPuzVROIV3pi/otntv5NZ7
7w8HEjMHU2QYMblT0KgkYS6VGIIoKCIpnfyR5JXk9VtvQA9jb3LrF/6mi5uPsfGk
/YUKdslPuy3WI+iFhYY4asja2L5W5+EBsjYHAmwhg0cvtTu1u4Sgz36f8/LYGccl
BH55BzeUws4sweffBjD45NEod/gcExC/DLKxnJ6sM/lkPn2xxURiN8Vah/5No14l
RzETrY2DzhReI4uQlgv1xek0uAbwY4W/edDqrvGeoNYj9ptiJoM=
=Gh2G
-----END PGP SIGNATURE-----

--jfWTlQR/c1yJMXw0--
