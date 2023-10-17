Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450E3D978
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kDvGQOpK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwZEqiIK"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960AF5
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C42043200AC8;
	Tue, 17 Oct 2023 04:45:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Oct 2023 04:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532332; x=1697618732; bh=qs
	rEtyedlHQWBROYSksAPYlpHHEv7ZOwELbQZ2c8/ws=; b=kDvGQOpKEdQPNVpVBZ
	heUSQhBBpusfu8UnEL28/+AEi0WyCduh2bq22TbJjJq2T+FSzFUnE9wpyiDL3eDO
	lhSM9I6VfiTzLLK6MEtPvs9QJ0YTvlHwn4nzORM0zMu7+zj3R/a8+p3pXKMBu7pQ
	b+9KPnx/raYJ9y3RE/5ouos4wyfDFeuPQ0zgvJTA3P9hj3Gw98omrnWOJqzxZVDP
	IJzS2kLppyQNqbL0A91zU5ou95h0x7euwvbW9Vmk9CDtdR0FG4gB6WjC/wnoQuIv
	UtLdf6m/EEy8Ot/Ygc4xWqIQVPcH0+1oO9LVm0hs4aX68oimL58nxXh3kWKe7oYY
	cksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532332; x=1697618732; bh=qsrEtyedlHQWB
	ROYSksAPYlpHHEv7ZOwELbQZ2c8/ws=; b=OwZEqiIKatg4Srombf//uKYq3szLw
	EmxQINbvQvjnF20vLZOQGHMW5bs2q02Dh8vDE7r1BP3keaIDQAOSG0eRaCuUF7Sm
	/p5tsQHTaUHyaT9dsUaaultyrHF5Dhi+jiCFYpt1MBqfFcrZOMCG1pNgoF3qV9/O
	FrBt2IHFEmVIlhXddvdos6Su9NuEvD0NcHJUHbjJa7y2vd+2U0/KnU6/oDNe7xe2
	YrTTItwcAgJ7wPxXRzAbO3TWcvIh+YUEOX8Ft4VeBS2tXzBbYPc6GsY49r6AJbFC
	PS4lfey+Tyv5BLBo3GYdvHgJXpn/ulDBUCpKl3+emO2SpzufQJku9BQKg==
X-ME-Sender: <xms:rEkuZWkv5X9halBcLHxvcZL_JEdS79WsGoFJpvQMseim4vjdz2fxMw>
    <xme:rEkuZd2h72dGoXHnbGnGIB6lTQgBX6CKDMMDLRnv8ZIZ1AYbAv1aEuNfKnPtmfU2e
    FlP4koQuZhksBu5-g>
X-ME-Received: <xmr:rEkuZUrRkGE2ui0i4AcVf6aPVeVbXsj7YTfCTdulTjtHCj1J5OWBTzRsCFN31W-6dXwt7CuKnSxaljDHV0wG7q6pWwt1viZMVmSH8OvXH52ykxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptefhueekheekhedvueetgfeitddufeffgf
    ejhedtudelueetuddtgfettdelheelnecuffhomhgrihhnpegthhgrnhhgvgguphgrthhh
    vhgvrhhsihhonhdrnhhofienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rEkuZakEzQdcenXI7BvIV0fB-vC_u2b-NKdmRJYruFKsjcPFu-oKhQ>
    <xmx:rEkuZU2WippgjQpoTN9MnUFrIYSNTIwNpMCrOEVG38Eb8WG3llNDWQ>
    <xmx:rEkuZRvJ7SWGA8rVOYqlhR_2I2Wh414WB9_yy17CSklo7vEilnjuWw>
    <xmx:rEkuZXSe9ibiUrzgxmv16-eqroQ0dv0qJS1s4nbxWmUSN6qtbcZDDw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba72000f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:30 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 13/17] commit-graph.c: unconditionally load Bloom
 filters
Message-ID: <ZS5JqdUmUWZ8OMoo@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <09d8669c3a074e7a2ace9d650a345244b2362f7e.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GKdizlbO5ifqJIJE"
Content-Disposition: inline
In-Reply-To: <09d8669c3a074e7a2ace9d650a345244b2362f7e.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--GKdizlbO5ifqJIJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:59PM -0400, Taylor Blau wrote:
> In 9e4df4da07 (commit-graph: new filter ver. that fixes murmur3,

Nit: It's a bit funny to read this reference to a commit ID when the
commit in question is part of the same series. Isn't it likely to grow
stale?

> 2023-08-01), we began ignoring the Bloom data ("BDAT") chunk for
> commit-graphs whose Bloom filters were computed using a hash version
> incompatible with the value of `commitGraph.changedPathVersion`.
>=20
> Now that the Bloom API has been hardened to discard these incompatible
> filters (with the exception of low-level APIs), we can safely load these
> Bloom filters unconditionally.
>=20
> We no longer want to return early from `graph_read_bloom_data()`, and
> similarly do not want to set the bloom_settings' `hash_version` field as
> a side-effect. The latter is because we want to wait until we know which
> Bloom settings we're using (either the defaults, from the GIT_TEST
> variables, or from the previous commit-graph layer) before deciding what
> hash_version to use.
>=20
> If we detect an existing BDAT chunk, we'll infer the rest of the
> settings (e.g., number of hashes, bits per entry, and maximum number of
> changed paths) from the earlier graph layer. The hash_version will be
> inferred from the previous layer as well, unless one has already been
> specified via configuration.
>=20
> Once all of that is done, we normalize the value of the hash_version to
> either "1" or "2".
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/commit-graph.c b/commit-graph.c
> index db623afd09..fa3b58e762 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -327,12 +327,6 @@ static int graph_read_bloom_data(const unsigned char=
 *chunk_start,
>  	uint32_t hash_version;
>  	hash_version =3D get_be32(chunk_start);
> =20
> -	if (*c->commit_graph_changed_paths_version =3D=3D -1) {
> -		*c->commit_graph_changed_paths_version =3D hash_version;
> -	} else if (hash_version !=3D *c->commit_graph_changed_paths_version) {
> -		return 0;
> -	}
> -
>  	g->chunk_bloom_data =3D chunk_start;
>  	g->bloom_filter_settings =3D xmalloc(sizeof(struct bloom_filter_setting=
s));
>  	g->bloom_filter_settings->hash_version =3D hash_version;
> @@ -2473,8 +2467,7 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->write_generation_data =3D (get_configured_generation_version(r) =
=3D=3D 2);
>  	ctx->num_generation_data_overflows =3D 0;
> =20
> -	bloom_settings.hash_version =3D r->settings.commit_graph_changed_paths_=
version =3D=3D 2
> -		? 2 : 1;
> +	bloom_settings.hash_version =3D r->settings.commit_graph_changed_paths_=
version;
>  	bloom_settings.bits_per_entry =3D git_env_ulong("GIT_TEST_BLOOM_SETTING=
S_BITS_PER_ENTRY",
>  						      bloom_settings.bits_per_entry);
>  	bloom_settings.num_hashes =3D git_env_ulong("GIT_TEST_BLOOM_SETTINGS_NU=
M_HASHES",
> @@ -2506,10 +2499,18 @@ int write_commit_graph(struct object_directory *o=
db,
>  		/* We have changed-paths already. Keep them in the next graph */
>  		if (g && g->bloom_filter_settings) {
>  			ctx->changed_paths =3D 1;
> -			ctx->bloom_settings =3D g->bloom_filter_settings;
> +
> +			/* don't propagate the hash_version unless unspecified */
> +			if (bloom_settings.hash_version =3D=3D -1)
> +				bloom_settings.hash_version =3D g->bloom_filter_settings->hash_versi=
on;
> +			bloom_settings.bits_per_entry =3D g->bloom_filter_settings->bits_per_=
entry;
> +			bloom_settings.num_hashes =3D g->bloom_filter_settings->num_hashes;
> +			bloom_settings.max_changed_paths =3D g->bloom_filter_settings->max_ch=
anged_paths;
>  		}
>  	}
> =20
> +	bloom_settings.hash_version =3D bloom_settings.hash_version =3D=3D 2 ? =
2 : 1;
> +

What if there is a future version of Git that writes Bloom filters with
hash version 3? Should we really normalize that to `1`?

Patrick

>  	if (ctx->split) {
>  		struct commit_graph *g =3D ctx->r->objects->commit_graph;
> =20
> --=20
> 2.42.0.342.g8bb3a896ee
>=20

--GKdizlbO5ifqJIJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSagACgkQVbJhu7ck
PpSlmQ/9H85zj9A9PIl5nV/ja34F0s9GAY3AajSBMyjqE0xcGvvhNHQ9akm5TWle
lq4XkTCDLlraccHNgfmZnGCMZ2czINr91WFg0/4FAUQ1Iq8d1ZT5kxJJgA0KvZdW
0mDYL7LfBO2Yc64E/aukv0YWedwezKLOXAXnWyHmxRzHA4AstKeDCwkDC3IwEKAL
OLDjhLh4kuNx6V1Ru13PD1wdxOsrfSD69qVLw6oKuEk7KN0u+dXsRE+chjpcu4Pm
6ZANhYP+A1zPZRLDHRAdaIEVcauxM53BSpOwbWd6Qiic6jUDZ7pK/8QLQycF+Y7E
JB39yDEM4X5isQoONNmaFA6HPkVinztRs9iCoZjr3FHEtWzF455QDB9gMWT5e3Oo
aL87WbgNG43BJ6Y/GJYu3SX/gSmbLe4tjbAjbQtMnHBWsKKJ+7GVcljdEy6EWqdF
9Bnx0eQYAXm4kxz82UrDcm9B2sig5Sk6ub+AQ8lbh06yfTTDb45hTTelbX0Yl17v
UOkOZnumOFCv/N9GQAYdp6sCsHQJIJcbmt5iLhFzRxG68TbkPvSwDKV6enX3F8vz
gwuhv6GgnjBPiDU3m86BzssRVLt8VcXik2O9Idllxb6AGKafLShtBKW/Urpg9Cu0
6as7Wdj1BVWO2t2Y5tcEmJXQ1yNSLcE/zCL7GgbEUe/MY3YHiTo=
=xu20
-----END PGP SIGNATURE-----

--GKdizlbO5ifqJIJE--
