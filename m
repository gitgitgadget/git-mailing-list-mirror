Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45255224CF
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmxfYEka";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FYHRiA81"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F07126
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:35:13 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0BE155C02C0;
	Tue, 14 Nov 2023 05:35:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 Nov 2023 05:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699958113; x=1700044513; bh=Yq
	9hFjemRS3hRL7ZmkMMoHsF5PrhFi9ORohXc88X38E=; b=fmxfYEka4XhrNu4OoZ
	mQkk9NmxQTdpvYe6muzTL6G17XaKW8/kni8YGwSuHy5QB805oVJ5kXiauz+L71Sh
	6MByimLqaD9DItI13L+pDQ5lC8rZy8zkWWGjQU/Q/pt9Y0CqOh7XROyuDUTGS+1p
	t+ZHGnSj4uBNt7dnuaMLWwbnPJpfjP+puJ77YgN2Vnbr2z6XE3BR7hkEzKbAdx7k
	l5PYhPAYmczCfkuNUgoIQm76mhqi2gTSr+DMbjD5pk6PnI6JZ+PCImJdEwSqpdeI
	uPxHwPXPjeZWcisQMQZ3r9WNp0WgirxIryfocf2va1X7/4jbGco/hYkd5FQAyHEp
	B3uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699958113; x=1700044513; bh=Yq9hFjemRS3hR
	L7ZmkMMoHsF5PrhFi9ORohXc88X38E=; b=FYHRiA81REg4g6kIeuQrk5YwkVY0k
	/GpkItBJ7VZ249Knel1ghCtaaTmwjLdU+UzNK87Qp+h0CzyGjicxwTKu3uBn+/0J
	wM1cAdtme5ZB9+az/7qyJ9L0BMv0sGY18ieHW6kC/kVn1m0UHCEANuQkyaWRRkuw
	lJzQM3PkJk+e5+v1Z3SZFAjIxI6HtYXua0x7DGc+xkxUW2/ualonSddnUEUsGsCU
	8dSH0vwZ/Rf8FCBDgS4ZOnR6K75TV8o/65I1wQVIxhoJprqcSB2KCdsGgsfSpmeb
	xJpxe5iHv/hHvDWWzuuEl80ZM0dMFbwUNys6tSN2cjS+h3ZehSfGt8XkA==
X-ME-Sender: <xms:YE1TZfWhyQ6_hcfyiQTc6ZgKkOs1xouqNMVd2ZaNsurYcb7tHQFBqw>
    <xme:YE1TZXkvLn8Fx6n4SbNNEX5qBo5AG4c1JwBnVP2poVqwiPizaWF71TWV_mbh_TyY9
    iRDQIdoAw4o_l4aew>
X-ME-Received: <xmr:YE1TZbZEPU41sNikmfQdwix4e26EkfZtGhqetVgvmoQjimnJiLssHfGWe3UsBntkuOAC-dhAOCfxOTTJBLeeSu_1W-oA4UZB-o3f40cLTqaHyoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YE1TZaUxfczbQXEQQ720xUVbf7ZETKKpEYjpurq8odMPQ-G5bURXsw>
    <xmx:YE1TZZklSKIJcxeZ4EYyaeghdPPaDYvaBTo4NAYeaDmBIm1NV86YZQ>
    <xmx:YE1TZXcUcsIEoPOescTFsX8pZNOFNpKKR9smavxFnXl0Xer__dyaHQ>
    <xmx:YU1TZezsju3ixoqDBggAPDwZyHymjqPZIfkAbantR8MfjKE5cfR8xg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 05:35:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7b36674 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 10:34:32 +0000 (UTC)
Date: Tue, 14 Nov 2023 11:35:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
Message-ID: <ZVNNXNRfrwc_0Sj3@tanuki>
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yoVGbZzXgdpdfbO+"
Content-Disposition: inline
In-Reply-To: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>


--yoVGbZzXgdpdfbO+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 11:23:05AM +0100, Patrick Steinhardt wrote:
> In 7a5d604443 (commit: detect commits that exist in commit-graph but not
> in the ODB, 2023-10-31), we have introduced a new object existence check
> into `repo_parse_commit_internal()` so that we do not parse commits via
> the commit-graph that don't have a corresponding object in the object
> database. This new check of course comes with a performance penalty,
> which the commit put at around 30% for `git rev-list --topo-order`. But
> there are in fact scenarios where the performance regression is even
> higher. The following benchmark against linux.git with a fully-build
> commit-graph:
>=20
>   Benchmark 1: git.v2.42.1 rev-list --count HEAD
>     Time (mean =C2=B1 =CF=83):     658.0 ms =C2=B1   5.2 ms    [User: 613=
=2E5 ms, System: 44.4 ms]
>     Range (min =E2=80=A6 max):   650.2 ms =E2=80=A6 666.0 ms    10 runs
>=20
>   Benchmark 2: git.v2.43.0-rc1 rev-list --count HEAD
>     Time (mean =C2=B1 =CF=83):      1.333 s =C2=B1  0.019 s    [User: 1.2=
63 s, System: 0.069 s]
>     Range (min =E2=80=A6 max):    1.302 s =E2=80=A6  1.361 s    10 runs
>=20
>   Summary
>     git.v2.42.1 rev-list --count HEAD ran
>       2.03 =C2=B1 0.03 times faster than git.v2.43.0-rc1 rev-list --count=
 HEAD
>=20
> While it's a noble goal to ensure that results are the same regardless
> of whether or not we have a potentially stale commit-graph, taking twice
> as much time is a tough sell. Furthermore, we can generally assume that
> the commit-graph will be updated by git-gc(1) or git-maintenance(1) as
> required so that the case where the commit-graph is stale should not at
> all be common.
>=20
> With that in mind, default-disable GIT_COMMIT_GRAPH_PARANOIA and restore
> the behaviour and thus performance previous to the mentioned commit. In
> order to not be inconsistent, also disable this behaviour by default in
> `lookup_commit_in_graph()`, where the object existence check has been
> introduced right at its inception via f559d6d45e (revision: avoid
> hitting packfiles when commits are in commit-graph, 2021-08-09).
>=20
> This results in another speedup in commands that end up calling this
> function, even though it's less pronounced compared to the above
> benchmark. The following has been executed in linux.git with ~1.2
> million references:
>=20
>   Benchmark 1: GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-list --all --no-w=
alk=3Dunsorted
>     Time (mean =C2=B1 =CF=83):      2.947 s =C2=B1  0.003 s    [User: 2.4=
12 s, System: 0.534 s]
>     Range (min =E2=80=A6 max):    2.943 s =E2=80=A6  2.949 s    3 runs
>=20
>   Benchmark 2: GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list --all --no-=
walk=3Dunsorted
>     Time (mean =C2=B1 =CF=83):      2.724 s =C2=B1  0.030 s    [User: 2.2=
07 s, System: 0.514 s]
>     Range (min =E2=80=A6 max):    2.704 s =E2=80=A6  2.759 s    3 runs
>=20
>   Summary
>     GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list --all --no-walk=3Dunso=
rted ran
>       1.08 =C2=B1 0.01 times faster than GIT_COMMIT_GRAPH_PARANOIA=3Dtrue=
 git rev-list --all --no-walk=3Dunsorted
>=20
> So whereas 7a5d604443 initially introduced the logic to start doing an
> object existence check in `repo_parse_commit_internal()` by default, the
> updated logic will now instead cause `lookup_commit_in_graph()` to stop
> doing the check by default. This behaviour continues to be tweakable by
> the user via the GIT_COMMIT_GRAPH_PARANOIA environment variable.
>=20
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Gah, I forgot to run this with GIT_TEST_COMMIT_GRAPH=3D1 before sending
this patch. There are two test failures that this change introduces:

  - t6022-rev-list-missing.sh, where we test for the `--missing=3D` option
    of git-rev-list(1).

  - t7700-repack.sh, where we also manually delete objects.

Both of these are expected failures: we knowingly corrupt the repository
and circumvent git-gc(1)/git-maintenance(1), thus no commit-graphs are
updated. If we stick with the new stance that repository corruption
should not require us to pessimize the common case, then we'd have to
squash in something like the below.

Patrick

diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
index 40265a4f66..9e3f063d08 100755
--- a/t/t6022-rev-list-missing.sh
+++ b/t/t6022-rev-list-missing.sh
@@ -27,6 +27,12 @@ do
 	'
 done
=20
+# When running with GIT_TEST_COMMIT_GRAPH=3Dtrue we write a commit-graph, =
but
+# don't update it before forcefully deleting the commit object. We thus en=
able
+# GIT_COMMIT_GRAPH_PARANOIA so that this case is detected with such a stale
+# commit-graph.
+export GIT_COMMIT_GRAPH_PARANOIA=3Dtrue
+
 for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
 do
 	for action in "allow-any" "print"
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index d2975e6c93..ca8ad9c420 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -271,7 +271,7 @@ test_expect_success 'repacking fails when missing .pack=
 actually means missing o
 		ls .git/objects/pack/*.pack >before-pack-dir &&
=20
 		test_must_fail git fsck &&
-		test_must_fail git repack --cruft -d 2>err &&
+		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3D1 git repack --cruft -d 2=
>err &&
 		grep "bad object" err &&
=20
 		# Before failing, the repack did not modify the

> ---
>  Documentation/git.txt   | 6 +++---
>  commit-graph.c          | 2 +-
>  commit.c                | 2 +-
>  t/t5318-commit-graph.sh | 8 ++++----
>  4 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 2535a30194..6c19fd1d76 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -917,9 +917,9 @@ for full details.
>  	avoid issues with stale commit-graphs that contain references to
>  	already-deleted commits, but comes with a performance penalty.
>  +
> -The default is "true", which enables the aforementioned behavior.
> -Setting this to "false" disables the existence check. This can lead to
> -a performance improvement at the cost of consistency.
> +The default is "false", which disables the aforementioned behavior.
> +Setting this to "true" enables the existence check so that stale commits
> +will never be returned from the commit-graph at the cost of performance.
> =20
>  `GIT_ALLOW_PROTOCOL`::
>  	If set to a colon-separated list of protocols, behave as if
> diff --git a/commit-graph.c b/commit-graph.c
> index ee66098e07..a712917356 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1029,7 +1029,7 @@ struct commit *lookup_commit_in_graph(struct reposi=
tory *repo, const struct obje
>  	uint32_t pos;
> =20
>  	if (commit_graph_paranoia =3D=3D -1)
> -		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +		commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
> =20
>  	if (!prepare_commit_graph(repo))
>  		return NULL;
> diff --git a/commit.c b/commit.c
> index 8405d7c3fc..37956b836c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -577,7 +577,7 @@ int repo_parse_commit_internal(struct repository *r,
>  		static int commit_graph_paranoia =3D -1;
> =20
>  		if (commit_graph_paranoia =3D=3D -1)
> -			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 1);
> +			commit_graph_paranoia =3D git_env_bool(GIT_COMMIT_GRAPH_PARANOIA, 0);
> =20
>  		if (commit_graph_paranoia && !has_object(r, &item->object.oid, 0)) {
>  			unparse_commit(r, &item->object.oid);
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d4fc65e078..4c751a6871 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -909,10 +909,10 @@ test_expect_success 'stale commit cannot be parsed =
when given directly' '
> =20
>  		# Verify that it is possible to read the commit from the
>  		# commit graph when not being paranoid, ...
> -		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-list B &&
> +		git rev-list B &&
>  		# ... but parsing the commit when double checking that
>  		# it actually exists in the object database should fail.
> -		test_must_fail git rev-list -1 B
> +		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-list -1 B
>  	)
>  '
> =20
> @@ -936,9 +936,9 @@ test_expect_success 'stale commit cannot be parsed wh=
en traversing graph' '
> =20
>  		# Again, we should be able to parse the commit when not
>  		# being paranoid about commit graph staleness...
> -		GIT_COMMIT_GRAPH_PARANOIA=3Dfalse git rev-parse HEAD~2 &&
> +		git rev-parse HEAD~2 &&
>  		# ... but fail when we are paranoid.
> -		test_must_fail git rev-parse HEAD~2 2>error &&
> +		test_must_fail env GIT_COMMIT_GRAPH_PARANOIA=3Dtrue git rev-parse HEAD=
~2 2>error &&
>  		grep "error: commit $oid exists in commit-graph but not in the object =
database" error
>  	)
>  '
> --=20
> 2.42.0
>=20



--yoVGbZzXgdpdfbO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTTVsACgkQVbJhu7ck
PpQEew/+N6rYMJfefIvFcf8mrT1EnOBVT8ujQGVbOU4yV9c9AG6Zx6FapmStdThN
hUsVSria1CypCDVnuksgPeL+TS62ekVXNsbYsgAq7UpJHUoEO7e13B/3hM3annmp
E+XE8fmTJrgWBP5z89SYOWrEFeSqQ2P1AuE/wRpkcLpoqddNBEDTt+Rq1y/2AWt6
Z+XG2OgHBDVuwpR4TwU+Uj2xQOzGVGqj4ZCMVmxkL1T2diOUrj9EOEitodbmN6mg
dmGQjFN8Y9Dyqyh08CpSDIsHpq3rIn6YJajQVfD3qJuAKQ5V0dzB2niNjSPC7ElQ
LtJhg5YVXH5QPJqWLMWfze/MASUSZCM1+bshCoq95i6y8FN2xF6fJx41pZzrzxJ6
3/NAl3tB9uEpfHkWoQ30kxcQWKI8Lom+Xji+/gcdCpj9CI4rWHNrK9nALKO8vdLV
R1nNRNHny7YDr/fBwkYs0Iqj2f9/Vx2uJQqZ0cvY8nlX4fbiaww2i0iaB+dLVo5t
v1e080LKKwuyPSzYOxJM8ZBIo9Q+rjiiG9IEVbrNL2wryq4+kP1lzMAWYDW61IIk
vXSvGWp2So7Y5ixYKCzIjkSHIoOZI7am1n7jpGeC1RyLuZlvQn4IHShz1YLXqFbX
asv9reKCQCS0Si66b2SGcqsThgmjHiQBIhWy4xsr7DzNqO6LUYc=
=3jIi
-----END PGP SIGNATURE-----

--yoVGbZzXgdpdfbO+--
