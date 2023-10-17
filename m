Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD513CD1B
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SlB1PCpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wC9hIg/S"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D293
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 7EFD83200AB0;
	Tue, 17 Oct 2023 04:45:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Oct 2023 04:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532322; x=1697618722; bh=+T
	0ZCp1m7golbQapZdds8051n04zEW06m1HGxUHwzMw=; b=SlB1PCpeTXRuUjHlDn
	DMWG2RhugyDJJK9RH+FH8B1a+JYSu4LwH0PgePlgj8VPDLPTc+/GQJPoyj9CdfNP
	5N9LbSIrdcKHb1oo2/FCEcLs3UnMRu7URHccU0RKWt0M5DtC7tSlr3Zh83dq2Fo8
	S04fiWB93TahxNZzx5PG2RZyVd5F2POGBmU5jMrphL5pC7DD2QAhgYqdr1shiJLd
	Wx7s68BRXQC9M23uHA4ymKeBktIC/JElIbCYIs1KhKVf65ai+VfW0WRA9TxU/+Ez
	ooNB3CwY6l9sTc1S5LoAPqwBKasDtzipz10EGDtd2FCre+kE0yTJE1aCiHULvDWw
	c58g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532322; x=1697618722; bh=+T0ZCp1m7golb
	QapZdds8051n04zEW06m1HGxUHwzMw=; b=wC9hIg/S9g53Vz2wODJXMhBOsqTYW
	Okr3IKmP3jyGAJyqjEUyFR0/NYDUWRz8a/fXc1cMsFDXk1M/J/6eP2UT6443UWUV
	8/Rc/LcO4ul5MK0GPvfUzPqQwwb8i7K7PqCYIczFPy07R4aPvwnRAoD28cgB/b5+
	+qOGLF/oAMsVCd6leZ7ngDDRtG3cV09CsJyfVGPxvFhb8st/MeUfpgQhSI9Hwn+Y
	o/coKlEaPlCZgZ+2EK85R4bUM9X7LCOxZPt8i9xjuEoASyJkHHOdCKRRc05gnbt7
	L20rBMx/B3OFdR5ob5f2HU5ixdnBRnKEXZf//pyB6MhqaAeCFlai/m+3Q==
X-ME-Sender: <xms:oUkuZcRyrK4_x6Jo686u5KLcjJQxrFwq6x96UpF5cXjVGAw0pfBP8g>
    <xme:oUkuZZwRL1uFVJ0ccqANEaSEUGLawfph5TvjM6b0faBDlrWVaTxBd3N_oHocNDREk
    YHViYWmOdt1nB_k7A>
X-ME-Received: <xmr:oUkuZZ3_DJhx0UZc8Zc3tupukzVHd2VeXwcOwTsQxQExE_BleRtDIwKVdXSnwRcoykNwfEbwyyLOAiZOo8T5TTQu3-EEJVFtC6NA8_6xgf6tEA8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oUkuZQBQz3pWrsNqeofMVEXTooYXou2XYjfZPF0tvPdtIpoL5sqjaQ>
    <xmx:oUkuZVjUaIh7nyJNSK24zl_t2zb4JiZODKP5N7TReyTzX6krsZbzEA>
    <xmx:oUkuZcoVcNX97G_7scpdvd-vUJL_EM5aPL_fGB620JY6mYzQa77G_Q>
    <xmx:okkuZVfshsS0QFozUrPW1TjNqkNR1FogHGlGsyki8ukQ1Yp_ndJxOA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7aa4b8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:19 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 05/17] t/helper/test-read-graph.c: extract
 `dump_graph_info()`
Message-ID: <ZS5JnkybxvetTUzu@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <94552abf455c6d341a0811333ae4edb4a8cea259.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mlBaXSmMgKvEccDB"
Content-Disposition: inline
In-Reply-To: <94552abf455c6d341a0811333ae4edb4a8cea259.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--mlBaXSmMgKvEccDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:33PM -0400, Taylor Blau wrote:
> Prepare for the 'read-graph' test helper to perform other tasks besides
> dumping high-level information about the commit-graph by extracting its
> main routine into a separate function.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Nit: your signoff is duplicated here. This is also still the case for
some of the other commits.

Patrick

> ---
>  t/helper/test-read-graph.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 8c7a83f578..3375392f6c 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -5,20 +5,8 @@
>  #include "bloom.h"
>  #include "setup.h"
> =20
> -int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
> +static void dump_graph_info(struct commit_graph *graph)
>  {
> -	struct commit_graph *graph =3D NULL;
> -	struct object_directory *odb;
> -
> -	setup_git_directory();
> -	odb =3D the_repository->objects->odb;
> -
> -	prepare_repo_settings(the_repository);
> -
> -	graph =3D read_commit_graph_one(the_repository, odb);
> -	if (!graph)
> -		return 1;
> -
>  	printf("header: %08x %d %d %d %d\n",
>  		ntohl(*(uint32_t*)graph->data),
>  		*(unsigned char*)(graph->data + 4),
> @@ -57,6 +45,23 @@ int cmd__read_graph(int argc UNUSED, const char **argv=
 UNUSED)
>  	if (graph->topo_levels)
>  		printf(" topo_levels");
>  	printf("\n");
> +}
> +
> +int cmd__read_graph(int argc UNUSED, const char **argv UNUSED)
> +{
> +	struct commit_graph *graph =3D NULL;
> +	struct object_directory *odb;
> +
> +	setup_git_directory();
> +	odb =3D the_repository->objects->odb;
> +
> +	prepare_repo_settings(the_repository);
> +
> +	graph =3D read_commit_graph_one(the_repository, odb);
> +	if (!graph)
> +		return 1;
> +
> +	dump_graph_info(graph);
> =20
>  	UNLEAK(graph);
> =20
> --=20
> 2.42.0.342.g8bb3a896ee
>=20

--mlBaXSmMgKvEccDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSZ0ACgkQVbJhu7ck
PpTz6w//UfEd74jmCi6YCM5D6rDIIwrZq+FpjE85q3knuvJS0PDQ1UYGzFXdJbd6
tSlgynktUgxt1p3JZJdvkR8So49RYI2fW4AgX0OVhWKHen495z46Wee7gxpW5KhG
msV0N+DtpMNAQamoolaUxo5acHTBjqRUQHCPl5SUqfjXXomQ/ELUdP0zmTbwyoUz
JjABcVFbGY7d/WRQ/qX0VM/vr/fgYN2QNGsFh8oa6MJycXii47evISq9QywXt18q
V5ZKZ0wlm9jULBtOfberN73QhgY7KLzqZjJKaJPTkbBPnnNCgH9mNm9gw7oLum2U
O3MRXhRCFfXkjG+G4D69eTlWeB4BpoBWVdwzdhRlNjUZv2V4ZldtSkU453U6njH6
+cklFsPBWDsA7XV5s+iigB4hKGAcivRNlAkc69G4omGU0IMnfEry2W6SMGhcnilo
VhSbO5wQhXNzppoc0TY7ahnTasTFmtXTfopGVXTNIz8z852yP2frWjO3ED4/IsHf
BHDPM0mm4+Eb+Eat7hb5auk2ynp9m7JbthGrxuF8Hxc2+wmcDUdvP+V6+L19A+3L
k6BGy7U61V4nFmuRkL/BaWACKxOOQuySjrGx2Wwym3rF6nSazcYuP1lOxhfW4RAM
46u7jW8kmrlZQotxrrZi5oTidPlIxDrvAJNr4YDhfKe5N8UJGq8=
=8uSq
-----END PGP SIGNATURE-----

--mlBaXSmMgKvEccDB--
