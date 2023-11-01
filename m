Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474997F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C5b0Rart";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdejmiRd"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B498A2
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 21:55:30 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id C443C320097E;
	Wed,  1 Nov 2023 00:55:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 01 Nov 2023 00:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698814527; x=1698900927; bh=8u
	Rm3nLZFgGpQyy3aPOhAaBllVxLfdAc1sWQ0IhdDo0=; b=C5b0RartmnFeiZNypF
	fPLaeVWcTLSVrklnPn5rtQmevRil0g/cUxdWoFTRwiOyJHNG2ma1+qmdR7c9G8Gt
	2wRz6MdSYWMX4ZK3mkV+4UQGF7a6sgap4bHHoq9paXmiX2S8nZvowz0b/VO0Q7KX
	qsozIOEdcuTUJZYnY3raf0rqp/LON6JpX0vZvu1EzVxMbSH4u0zsxP9w/Jyx/HuL
	wEnWG1O6iAWkYXRRwibXAxdzJ9rY7a3wTuv4+Mxy+SiesL6+A40Qq045bagydQLB
	y697qaNzJa4BGHIbWRfG1ygy4CK3dyfecoA/WxMxcCafBAeV1N2OleuAGt/WnrWI
	3CYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698814527; x=1698900927; bh=8uRm3nLZFgGpQ
	yy3aPOhAaBllVxLfdAc1sWQ0IhdDo0=; b=HdejmiRdPBJ2aamZdhtHvcU5+8F/f
	mdHjX+80TtQM0SKDgC4Mm1o1gEEIjZn/LTzCP9tk2aTM7nvwMNe3/VymyEWlcBwZ
	TB+fM5zAxhHaFXTFK/FGA6vgK6BpekXeL7zrVZ2vhh961EfaRDNYWkDud8o5XuNC
	QwOQ+0+rtu3kt9QTRdfB/NtgO7DQrGBY4OR276i1/ilT2biOm7X86QXn6ARcsNmR
	ByZP/4CyiHqD0rmeNRq0dVzURyo/XrIr+OwJ00CVr2YldM+hnyCSrwtj8PVT6Qac
	Z5TpTD4yOJiFZmJwXp41P+eD7dDInO1Yxx99Y+BLqI9FFlWSP0VVatR3Q==
X-ME-Sender: <xms:PtpBZcbN6pIcCGRSpuSjtPBcPH-v40QpNtc8BSnFsBCC-4EIaG-6eg>
    <xme:PtpBZXadVzFJplcQZ0ZSg9urpHjKpaVYgbui0A5OTx49mI655alhPLQYPV4_6S5w7
    o9tqoFc43w9fhTCpA>
X-ME-Received: <xmr:PtpBZW9n7i0c7MDx25IkxvZ4-OVAW_nHfyqvMLkVt0HdoN5ZEaOvInsawwuD3U9LtezPw4P9_f-db_eHZcyj94gVdL52VnpzImD1XvesLeHARw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtfedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PtpBZWowp6AU7p5QLspnAjXh_RiZ-MNUR2p6t93KpMYFs_TC59yYVQ>
    <xmx:PtpBZXqdqmZwqhVrX23TrC6hkxC4ZjRifrqQUnZVFWHVQD_fve7TYw>
    <xmx:PtpBZURFf3k1uj1sO0kvCT8uheoy5eBhlrLQZUMMOwkVdlKRc-WoqA>
    <xmx:P9pBZWWP6dmHm90-bYsarQD_dJum-vacV2scXaoJj0SFEq_F4EOIqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 00:55:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a113a307 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Nov 2023 04:55:13 +0000 (UTC)
Date: Wed, 1 Nov 2023 05:55:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
Message-ID: <ZUHaLqslYFDahNkq@tanuki>
References: <cover.1698060036.git.ps@pks.im>
 <cover.1698736363.git.ps@pks.im>
 <ZUFSqRYXhwsWC+EA@nand.local>
 <xmqqh6m6z6pe.fsf@gitster.g>
 <xmqq34xqxm5u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yKdltzVb2oLYnUdV"
Content-Disposition: inline
In-Reply-To: <xmqq34xqxm5u.fsf@gitster.g>


--yKdltzVb2oLYnUdV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 11:06:05AM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> Thanks, the range-diff here looks exactly as expected. Thanks for
> >> working on this, this version LGTM.
> >
> > OK, I'd like a version as incremental to v2 (since it already is in
> > 'next') that results in the same tree state as v3 then.
> >
> > Thanks for working on it, and reviewing it.
>=20
> In the meantime, here is a mechanically produced incremental I'll
> tentatively queue.  Hopefully I did not screw up while generating
> it.
>=20
> Thanks.

Ah, sorry, didn't notice it was in 'next' already. Anyway, the diff
below looks good to me, thanks!

Patrick

> --- >8 ---
> From: Patrick Steinhardt <ps@pks.im>
> Date: Tue, 31 Oct 2023 08:16:09 +0100
> Subject: [PATCH] commit-graph: clarify GIT_COMMIT_GRAPH_PARANOIA document=
ation
>=20
> In response to reviews of the previous round that has already hit
> 'next', clarify the help text for GIT_COMMIT_GRAPH_PARANOIA and
> rename object_paranoia variable to commit_graph_paranoia for
> consistency.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git.txt   | 15 ++++++++-------
>  commit-graph.c          |  8 ++++----
>  commit.c                |  8 ++++----
>  t/t5318-commit-graph.sh |  2 +-
>  4 files changed, 17 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 22c2b537aa..3bac24cf8a 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -912,13 +912,14 @@ for full details.
>  	useful when trying to salvage data from a corrupted repository.
> =20
>  `GIT_COMMIT_GRAPH_PARANOIA`::
> -	If this Boolean environment variable is set to false, ignore the
> -	case where commits exist in the commit graph but not in the
> -	object database. Normally, Git will check whether commits loaded
> -	from the commit graph exist in the object database to avoid
> -	issues with stale commit graphs, but this check comes with a
> -	performance penalty. The default is `1` (i.e., be paranoid about
> -	stale commits in the commit graph).
> +	When loading a commit object from the commit-graph, Git performs an
> +	existence check on the object in the object database. This is done to
> +	avoid issues with stale commit-graphs that contain references to
> +	already-deleted commits, but comes with a performance penalty.
> ++
> +The default is "true", which enables the aforementioned behavior.
> +Setting this to "false" disables the existence check. This can lead to
> +a performance improvement at the cost of consistency.
> =20
>  `GIT_ALLOW_PROTOCOL`::
>  	If set to a colon-separated list of protocols, behave as if
> diff --git a/commit-graph.c b/commit-graph.c
> index 376f59af73..b37fdcb214 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -907,18 +907,18 @@ int repo_find_commit_pos_in_graph(struct repository=
 *r, struct commit *c,
> =20
>  struct commit *lookup_commit_in_graph(struct repository *repo, const str=
uct object_id *id)
>  {
> -	static int object_paranoia =3D -1;
> +	static int commit_graph_paranoia =3D -1;
>  	struct commit *commit;
>  	uint32_t pos;
> =20
> -	if (object_paranoia =3D=3D -1)
> -		object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +	if (commit_graph_paranoia =3D=3D -1)
> +		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> =20
>  	if (!prepare_commit_graph(repo))
>  		return NULL;
>  	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
>  		return NULL;
> -	if (object_paranoia && !has_object(repo, id, 0))
> +	if (commit_graph_paranoia && !has_object(repo, id, 0))
>  		return NULL;
> =20
>  	commit =3D lookup_commit(repo, id);
> diff --git a/commit.c b/commit.c
> index 7399e90212..8405d7c3fc 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -574,12 +574,12 @@ int repo_parse_commit_internal(struct repository *r,
>  	if (item->object.parsed)
>  		return 0;
>  	if (use_commit_graph && parse_commit_in_graph(r, item)) {
> -		static int object_paranoia =3D -1;
> +		static int commit_graph_paranoia =3D -1;
> =20
> -		if (object_paranoia =3D=3D -1)
> -			object_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +		if (commit_graph_paranoia =3D=3D -1)
> +			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> =20
> -		if (object_paranoia && !has_object(r, &item->object.oid, 0)) {
> +		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
>  			unparse_commit(r, &item->object.oid);
>  			return quiet_on_missing ? -1 :
>  				error(_("commit %s exists in commit-graph but not in the object data=
base"),
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 55e3c7ec78..2c62b91ef9 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -847,7 +847,7 @@ test_expect_success 'stale commit cannot be parsed wh=
en traversing graph' '
>  		test_commit C &&
>  		git commit-graph write --reachable &&
> =20
> -		# Corrupt the repository by deleting the intermittent commit
> +		# Corrupt the repository by deleting the intermediate commit
>  		# object. Commands should notice that this object is absent and
>  		# thus that the repository is corrupt even if the commit graph
>  		# exists.
> --=20
> 2.42.0-530-g692be87cbb
>=20

--yKdltzVb2oLYnUdV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVB2jgACgkQVbJhu7ck
PpSbVhAAloUYsrq7KdRyNTF01od9CdvOZ8PKqFqqteJjTo2KqfYZAKsNVtPf33Vi
H00KmuJDlYUMMS14OC/ePMfCyRmt8rczJWbAkMukeUzCodxxp+htkJXU+NqRXLla
UJxMQ3vgQqfAiT/KkJkilASpKsrQDGXYbhrrBeOqk1x+FC8SF0PNdCYwGNE28U8n
brBwcZxj4fpBkdaH4GWCLcK7BJlrqkQrTKoueFhs0dFjQ9l6hjlkODFwy27SlCIY
LVG7ux5MjtxrN7tFnjGhD5Q8OHP+3+BY597iPbgna2YN4PbvTYkftaliRcVrDGQ/
hBiCNw/NWtBDGCDLAtxqbLoOi0d+thZH8kW/pmOpQgQ4uu0Hu+oztGbhlBNn92YU
qXofJqjKM31uF6pqo3OB8TMjRhEi2L7MeFrs8qnmuBFOzbC3/FLe6FdTIEw91/EX
ISctitbcPJ05/v+urrWeonCM7K5BzWBPO6ihHAVdmeHKMzwwT0ShWgyB/EU2snHy
TA+4QWXhoH/+sVvdt+mALsIbeQTe11Aq1c8tmU1+zKyYvjZcJxRqxgjIWLBSZJly
I7A8THtJxVSCRKmpthWLdn6HfK9O9b6D5gE/YrJ9I13NtYMY9xLobAQRLMenWddc
1igFiQVv9xdlC9Bx4APM/EiM2YFy7esHDpoMXkdgnzw8x4uukEg=
=r9hM
-----END PGP SIGNATURE-----

--yKdltzVb2oLYnUdV--
