Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3334374FA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pulMTuYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DmRpcZNq"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D3FD
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 210AF3200AB0;
	Tue, 17 Oct 2023 04:45:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 17 Oct 2023 04:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532311; x=1697618711; bh=lK
	J3W0bBF/kYC/f+oQU4NmzToIowjl0ymDTkELNwX2Q=; b=pulMTuYCkjhCh0lZ3Q
	c35Pz+Z+mDdmTqYAT0+dC/TWsz7Y+FWl7SPaZV7LXymoCUrBmhN1leeYXGKXnSkS
	eNVCB/d2zJy3vehkWu2/pkkyJwbc3OkBC8Dxva5B64GAT5rbTv25+D4z5e7yuWET
	JpgUsqgwjwnZMhGVjQxDTsp8w+iXUEDLihYigB/1HAAzGDP58KD5CChpWXSP5Ocx
	NQUvrngOfGbQPthfqVgVlYRDlpAv6kq/ym2TXeYUlOPWymgwUn2ToizDCjIKwzqg
	czjZuCdi1XIYwdmjecKNjiME2N84DFnLV69MpfRi6JAgoUUoZ+a9ALPyLHvhyKmf
	pJdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532311; x=1697618711; bh=lKJ3W0bBF/kYC
	/f+oQU4NmzToIowjl0ymDTkELNwX2Q=; b=DmRpcZNqWY4EOG3OTdru4TX/rtH0e
	nPom8AKTkfdsxNya7kWsOoEi/Py4C03BX1G5bN4y6btxnH0NBR4mxpNOSwdPlIY0
	ExzxZJjY7OMxlr4Z+kRVWPBwVUpEhDvedJwwGdCbl+OJMEXF1TLmbrAEDEwOzP4O
	n6TrI/U7NoWRj/nlb0iw5XNdNtv2detsYJlU1eg5koXuLtl+WcaxV8M1BXjZdBVn
	OlW/SIgl5oP4R2R6seWCod2gQb6Vjz42TSRq5paN341uFDcyIxo3CFc8KLsAUJTs
	GP9IugM0lAiNK+x/G79ov/4g/LfeUooUzBAoBRUu8XVZLkymrypJZEiag==
X-ME-Sender: <xms:l0kuZSPaKJ4MhEKW9nSlOG2bSjhQ7Qd-vYbij2Poksn_T0V4xS2Jfw>
    <xme:l0kuZQ9vmsXwcF0-M82y41CqIyi6qbepYLyR6U79GTtFtRsvJCFZQUMiwiTRk0-7X
    kIYVniFdjGPHRKXww>
X-ME-Received: <xmr:l0kuZZQbvT1dqR5ESftln_MvA-w63lk_ryBuYXtyjc0lgImPCTHVRqFhYEw26RY78sJ-Dnk83gdNuNtP4Vf-T0L7mMv_nyjAud1MHYWNPvArsfo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekkefgff
    duhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:l0kuZSsinzmyn_bJLRTv-n4QngotVZ0_kSsOgeU5MdN-_JnIEgINwg>
    <xmx:l0kuZafyW4eu6PYNat8smvhMWKkrH4MKFhVhlh2BoIysSNFodXJjpg>
    <xmx:l0kuZW33AkPvF03WqcavuCF7JLQmCMbhSyeWJfFDDBBPjUppiTi4cA>
    <xmx:l0kuZZ72_Leh-z10Eez-AFbv9RFIVHBxhs-VD6eB_jGO7uJsQerH3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f9b3d8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:08 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 03/17] commit-graph: ensure Bloom filters are read
 with consistent settings
Message-ID: <ZS5JkyBuFzW09LXH@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <2ecc0a2d58432b149d73a3e2abfa948eb1f0aa0b.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XSaEBAR486zA/QiO"
Content-Disposition: inline
In-Reply-To: <2ecc0a2d58432b149d73a3e2abfa948eb1f0aa0b.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--XSaEBAR486zA/QiO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:26PM -0400, Taylor Blau wrote:
> The changed-path Bloom filter mechanism is parameterized by a couple of
> variables, notably the number of bits per hash (typically "m" in Bloom
> filter literature) and the number of hashes themselves (typically "k").
>=20
> It is critically important that filters are read with the Bloom filter
> settings that they were written with. Failing to do so would mean that
> each query is liable to compute different fingerprints, meaning that the
> filter itself could return a false negative. This goes against a basic
> assumption of using Bloom filters (that they may return false positives,
> but never false negatives) and can lead to incorrect results.
>=20
> We have some existing logic to carry forward existing Bloom filter
> settings from one layer to the next. In `write_commit_graph()`, we have
> something like:
>=20
>     if (!(flags & COMMIT_GRAPH_NO_WRITE_BLOOM_FILTERS)) {
>         struct commit_graph *g =3D ctx->r->objects->commit_graph;
>=20
>         /* We have changed-paths already. Keep them in the next graph */
>         if (g && g->chunk_bloom_data) {
>             ctx->changed_paths =3D 1;
>             ctx->bloom_settings =3D g->bloom_filter_settings;
>         }
>     }
>=20
> , which drags forward Bloom filter settings across adjacent layers.
>=20
> This doesn't quite address all cases, however, since it is possible for
> intermediate layers to contain no Bloom filters at all. For example,
> suppose we have two layers in a commit-graph chain, say, {G1, G2}. If G1
> contains Bloom filters, but G2 doesn't, a new G3 (whose base graph is
> G2) may be written with arbitrary Bloom filter settings, because we only
> check the immediately adjacent layer's settings for compatibility.
>=20
> This behavior has existed since the introduction of changed-path Bloom
> filters. But in practice, this is not such a big deal, since the only
> way up until this point to modify the Bloom filter settings at write
> time is with the undocumented environment variables:
>=20
>   - GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY
>   - GIT_TEST_BLOOM_SETTINGS_NUM_HASHES
>   - GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS
>=20
> (it is still possible to tweak MAX_CHANGED_PATHS between layers, but
> this does not affect reads, so is allowed to differ across multiple
> graph layers).
>=20
> But in future commits, we will introduce another parameter to change the
> hash algorithm used to compute Bloom fingerprints itself. This will be
> exposed via a configuration setting, making this foot-gun easier to use.
>=20
> To prevent this potential issue, validate that all layers of a split
> commit-graph have compatible settings with the newest layer which
> contains Bloom filters.
>=20
> Reported-by: SZEDER G=E1bor <szeder.dev@gmail.com>
> Original-test-by: SZEDER G=E1bor <szeder.dev@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  commit-graph.c       | 25 +++++++++++++++++
>  t/t4216-log-bloom.sh | 64 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
>=20
> diff --git a/commit-graph.c b/commit-graph.c
> index 1a56efcf69..ae0902f7f4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -498,6 +498,30 @@ static int validate_mixed_generation_chain(struct co=
mmit_graph *g)
>  	return 0;
>  }
> =20
> +static void validate_mixed_bloom_settings(struct commit_graph *g)
> +{
> +	struct bloom_filter_settings *settings =3D NULL;
> +	for (; g; g =3D g->base_graph) {
> +		if (!g->bloom_filter_settings)
> +			continue;
> +		if (!settings) {
> +			settings =3D g->bloom_filter_settings;
> +			continue;
> +		}
> +
> +		if (g->bloom_filter_settings->bits_per_entry !=3D settings->bits_per_e=
ntry ||
> +		    g->bloom_filter_settings->num_hashes !=3D settings->num_hashes) {
> +			g->chunk_bloom_indexes =3D NULL;
> +			g->chunk_bloom_data =3D NULL;
> +			FREE_AND_NULL(g->bloom_filter_settings);
> +
> +			warning(_("disabling Bloom filters for commit-graph "
> +				  "layer '%s' due to incompatible settings"),
> +				oid_to_hex(&g->oid));
> +		}
> +	}
> +}
> +
>  static int add_graph_to_chain(struct commit_graph *g,
>  			      struct commit_graph *chain,
>  			      struct object_id *oids,
> @@ -614,6 +638,7 @@ struct commit_graph *load_commit_graph_chain_fd_st(st=
ruct repository *r,
>  	}
> =20
>  	validate_mixed_generation_chain(graph_chain);
> +	validate_mixed_bloom_settings(graph_chain);
> =20
>  	free(oids);
>  	fclose(fp);
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 322640feeb..f49a8f2fbf 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -420,4 +420,68 @@ test_expect_success 'Bloom generation backfills empt=
y commits' '
>  	)
>  '
> =20
> +graph=3D.git/objects/info/commit-graph
> +graphdir=3D.git/objects/info/commit-graphs
> +chain=3D$graphdir/commit-graph-chain
> +
> +test_expect_success 'setup for mixed Bloom setting tests' '
> +	repo=3Dmixed-bloom-settings &&
> +
> +	git init $repo &&
> +	for i in one two three
> +	do
> +		test_commit -C $repo $i file || return 1
> +	done
> +'
> +
> +test_expect_success 'split' '
> +	# Compute Bloom filters with "unusual" settings.
> +	git -C $repo rev-parse one >in &&
> +	GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=3D3 git -C $repo commit-graph write \
> +		--stdin-commits --changed-paths --split <in &&
> +	layer=3D$(head -n 1 $repo/$chain) &&
> +
> +	# A commit-graph layer without Bloom filters "hides" the layers
> +	# below ...
> +	git -C $repo rev-parse two >in &&
> +	git -C $repo commit-graph write --stdin-commits --no-changed-paths \
> +		--split=3Dno-merge <in &&
> +
> +	# Another commit-graph layer that has Bloom filters, but with
> +	# standard settings, and is thus incompatible with the base
> +	# layer written above.
> +	git -C $repo rev-parse HEAD >in &&
> +	git -C $repo commit-graph write --stdin-commits --changed-paths \
> +		--split=3Dno-merge <in &&
> +
> +	test_line_count =3D 3 $repo/$chain &&
> +
> +	# Ensure that incompatible Bloom filters are ignored.
> +	git -C $repo -c core.commitGraph=3Dfalse log --oneline --no-decorate --=
 file \
> +		>expect 2>err &&
> +	git -C $repo log --oneline --no-decorate -- file >actual 2>err &&
> +	test_cmp expect actual &&
> +	grep "disabling Bloom filters for commit-graph layer .$layer." err
> +'

Up to this point everything looks sensible to me.

> +test_expect_success 'merge graph layers with incompatible Bloom settings=
' '
> +	# Ensure that incompatible Bloom filters are ignored when
> +	# generating new layers.
> +	git -C $repo commit-graph write --reachable --changed-paths 2>err &&
> +	grep "disabling Bloom filters for commit-graph layer .$layer." err &&
> +
> +	test_path_is_file $repo/$graph &&
> +	test_dir_is_empty $repo/$graphdir &&
> +
> +	# ...and merging existing ones.
> +	git -C $repo -c core.commitGraph=3Dfalse log --oneline --no-decorate --=
 file \
> +		>expect 2>err &&
> +	GIT_TRACE2_PERF=3D"$(pwd)/trace.perf" \
> +		git -C $repo log --oneline --no-decorate -- file >actual 2>err &&

But this test is a bit confusing to me, to be honest, also because the
comment for the second block here reads funny. We don't really merge
anything, do we? We only generate logs and compare that the log with and
without the resulting merged commit graph is the same. The actual logic
happened before.

> +	test_cmp expect actual && cat err &&

The `cat err` looks like a leftover from debugging.

> +	grep "statistics:{\"filter_not_present\":0" trace.perf &&

Also, why should the filter not be present here? If we merge the
commit-graphs with `--changed-paths` I'd have expected that we either
carry over bloom filters from preexisting commit graphs if compatible,
or otherwise generate them if they are either incompatible or don't
exist.

I feel like I'm missing something obvious, so this may be me just
missing the bigger picture.

> +	! grep "disabling Bloom filters" err

Can we make this assertion stricter and verify that `err` is empty? I
always think that `! grep` is quite a fragile pattern as it is quite
prone to becoming stale, e.g. when the error message itself would
change.

Patrick

> +'
> +
>  test_done
> --=20
> 2.42.0.342.g8bb3a896ee
>=20

--XSaEBAR486zA/QiO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSZIACgkQVbJhu7ck
PpQS8g/+JQ5Mx7eLDG0hFszknbN4HsKko8aTyIWKA0YKbzZLpdY+tPed7UxpADoy
GnmFVT8ZWLfsDSU+eEgeFQ2VKwvzaMOW9DU84ZnLMl2Fb/g88Ia6unkth0eedc43
wNomS4CgFojja3/TH3p72r04BTNYzrWm4IemK0EDmPVPbFR81bwRK4UIX6HEDOYU
KtOegnCq2Nh31b8tnWPMT8ZGxqBPNN+X1E51G8OOQ5versU67r74y0zKu64wtcOv
pGasL7jzIa2o29AyU3QKuRmPOjm/mt/yNlci8gyrXMoH4I760kchtIAGjL8vu+0u
wOomCv8pc0HL5ICBVZgXJoaCHsSQLcAqQfy2LPBY0iC0ruRWLWVCpZQC6SKYm+5x
p9mtqGJjx7FNmNdMPpopw1KUxEJf+VL5r9OiMCY9IQeNvM9CmX3A/skQkmO9Z0x7
ASEavJyvgrbuNixEh4PFIHf5Qd6ns88ytlobMTwPpBQiW0rPP2XeAqcGvzpiXwgI
WYmwmHdAxJqb2IUjT3aBnA6O1UY6veYlYbW/idgC00DC1g8aHljsFeuh+7aKaCSq
OnLWIcl/aP4okJDzD5x3rQKyF18yS70gWl8Tw8R9hCh/nimGrEmOZnx2ugE0Vibt
GZEa+4MvvLYyBBVQ3RVGm9NDyWjO7QYzcW0o2lpO0EaFbcY6A4Q=
=PpwU
-----END PGP SIGNATURE-----

--XSaEBAR486zA/QiO--
