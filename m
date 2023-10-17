Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA33D97F
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9r8XCc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4SQkx3c"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5236F7
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id B9EA23200AB9;
	Tue, 17 Oct 2023 04:45:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Oct 2023 04:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532340; x=1697618740; bh=Ri
	laZSQw61bwnqosnlYILCwVhV9RfcYX8Uh+teLa2vI=; b=V9r8XCc9UHlRf4r8kw
	ccIE2m5fAunpsjVSbC5pBboNGgft48b/bHQpf3ZlbySepuGX1YN/NX9z+N06J0/W
	7ett/YGddsRQa7rcNb7j4iEjNQD6SIL3UZvdeiMeaB9Eyx1mXckrKuycN5CFHdjT
	ZGALUDQboF42mjvt0BOcuCRkaFq8WO3ABmQ2WdD+tKobIaG+AyoAELC8MwHlPYID
	l30gjHZsNOhZ2/sQYPYz9o8vEBix7Ky/IiSmazmid635Cv5KN9b5YBwEmWH7Inek
	9CP7rqGv19a1DiC0TZRV6cgsKNgZvHXLA+YQFAYzotGzodPgw8ooefDhxPWLU/or
	XlVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532340; x=1697618740; bh=RilaZSQw61bwn
	qosnlYILCwVhV9RfcYX8Uh+teLa2vI=; b=c4SQkx3cHtcDmaSJnst+8QGOOqRPp
	tmvEzqH2cs13m6cZg3DiplIumVG6ff83Gm64THmDNVtLJbn3EPsNtjpnssOS67xw
	sd3PCexZuLA/+4h1sEg6G/iyXIhV07/4fshBG6HpcYgBS+l9MEE5M/hqSE1v/pWd
	vrSesdKUi54QwQrEeXz6IIHj0WMl0aTJdQ9nHHbV/+JsNeoIE6KLfwZFkyn4imyy
	FlPhfZCQSI9TN+GHI281crHoSqPb5Bgpicp0tL0P3HZXVreCZ8JUlGHgbFkUQ54t
	zA1eBKO7Qmd6PlfVse7FaZ4YPGU/grLH0+ZpposgAEtYXtD+kPW6ynA8Q==
X-ME-Sender: <xms:s0kuZRi-sY-EueE4NyjwNXMUZ8jBwqG4tQ7PiSpu4ok95tr-i7zlpQ>
    <xme:s0kuZWCcjTUIbBjt79EQ8z8DgGSYQygK0HzowI0Xm5qyE1Q3YV8VTumYB3OatWdRS
    R1xktVzzoZEBAeDyg>
X-ME-Received: <xmr:s0kuZREtqmejxzqCcFGU5-AXpxgqMsFVkXE4bz7j0lEgRY-bXysbHuFWUpmjdAr3pdP4j6FVew4Ew0gz4hnT6sZ7Xcq3W3M9OcvmQy3akd1pCtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffevtdduhfdtfeejgfekfeelgeetvdevff
    ffvefggfeutdeuudelffffueekvefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    phhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:s0kuZWTigZYG_5NBtshUvUGN5vz7ga20NfermDAi-8RoClLg5dM2fw>
    <xmx:s0kuZewAJ2_iBjl6GYJ1SE_iCDpeUYr-meetpiyPcwcBy6yJJFy0qg>
    <xmx:s0kuZc4I5mCmfY8mTBggtCRexSgKfpye_RSjo7HwLWBvfHAoitWpkw>
    <xmx:tEkuZYvf6oemrkJKVQ8pJVIfyQpHr6W4h124WG33uQirPUopRBhC8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2dde478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:37 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/17] bloom: changed-path Bloom filters v2 (&
 sundries)
Message-ID: <ZS5JsDKk8RioQfOA@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JPvSSSIhA4JXMNhy"
Content-Disposition: inline
In-Reply-To: <cover.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--JPvSSSIhA4JXMNhy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:17PM -0400, Taylor Blau wrote:
> (Rebased onto the tip of 'master', which is 3a06386e31 (The fifteenth
> batch, 2023-10-04), at the time of writing).
>=20
> This series is a reroll of the combined efforts of [1] and [2] to
> introduce the v2 changed-path Bloom filters, which fixes a bug in our
> existing implementation of murmur3 paths with non-ASCII characters (when
> the "char" type is signed).
>=20
> In large part, this is the same as the previous round. But this round
> includes some extra bits that address issues pointed out by SZEDER
> G=E1bor, which are:
>=20
>   - not reading Bloom filters for root commits
>   - corrupting Bloom filter reads by tweaking the filter settings
>     between layers.
>=20
> These issues were discussed in (among other places) [3], and [4],
> respectively.
>=20
> Thanks to Jonathan, Peff, and SZEDER who have helped a great deal in
> assembling these patches. As usual, a range-diff is included below.
> Thanks in advance for your
> review!

As this patch series has been sitting around without reviews for a week
I've tried my best to give it a go. Note though that this area is mostly
outside of my own comfort zone, so some of the questions and suggestions
might ultimately not apply.

Patrick

> [1]: https://lore.kernel.org/git/cover.1684790529.git.jonathantanmy@googl=
e.com/
> [2]: https://lore.kernel.org/git/cover.1691426160.git.me@ttaylorr.com/
> [3]: https://public-inbox.org/git/20201015132147.GB24954@szeder.dev/
> [4]: https://lore.kernel.org/git/20230830200218.GA5147@szeder.dev/
>=20
> Jonathan Tan (4):
>   gitformat-commit-graph: describe version 2 of BDAT
>   t4216: test changed path filters with high bit paths
>   repo-settings: introduce commitgraph.changedPathsVersion
>   commit-graph: new filter ver. that fixes murmur3
>=20
> Taylor Blau (13):
>   t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
>   revision.c: consult Bloom filters for root commits
>   commit-graph: ensure Bloom filters are read with consistent settings
>   t/helper/test-read-graph.c: extract `dump_graph_info()`
>   bloom.h: make `load_bloom_filter_from_graph()` public
>   t/helper/test-read-graph: implement `bloom-filters` mode
>   bloom: annotate filters with hash version
>   bloom: prepare to discard incompatible Bloom filters
>   commit-graph.c: unconditionally load Bloom filters
>   commit-graph: drop unnecessary `graph_read_bloom_data_context`
>   object.h: fix mis-aligned flag bits table
>   commit-graph: reuse existing Bloom filters where possible
>   bloom: introduce `deinit_bloom_filters()`
>=20
>  Documentation/config/commitgraph.txt     |  26 ++-
>  Documentation/gitformat-commit-graph.txt |   9 +-
>  bloom.c                                  | 208 ++++++++++++++++-
>  bloom.h                                  |  38 +++-
>  commit-graph.c                           |  61 ++++-
>  object.h                                 |   3 +-
>  oss-fuzz/fuzz-commit-graph.c             |   2 +-
>  repo-settings.c                          |   6 +-
>  repository.h                             |   2 +-
>  revision.c                               |  26 ++-
>  t/helper/test-bloom.c                    |   9 +-
>  t/helper/test-read-graph.c               |  67 ++++--
>  t/t0095-bloom.sh                         |   8 +
>  t/t4216-log-bloom.sh                     | 272 ++++++++++++++++++++++-
>  14 files changed, 682 insertions(+), 55 deletions(-)
>=20
> Range-diff against v2:
> 10:  002a06d1e9 !  1:  fe671d616c t/t4216-log-bloom.sh: harden `test_bloo=
m_filters_not_used()`
>     @@ Commit message
>          indicating that no filters were used.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## t/t4216-log-bloom.sh ##
>      @@ t/t4216-log-bloom.sh: test_bloom_filters_used () {
>  -:  ---------- >  2:  7d0fa93543 revision.c: consult Bloom filters for r=
oot commits
>  -:  ---------- >  3:  2ecc0a2d58 commit-graph: ensure Bloom filters are =
read with consistent settings
>  1:  5fa681b58e !  4:  17703ed89a gitformat-commit-graph: describe versio=
n 2 of BDAT
>     @@ Commit message
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## Documentation/gitformat-commit-graph.txt ##
>      @@ Documentation/gitformat-commit-graph.txt: All multi-byte numbers =
are in network byte order.
>  2:  623d840575 !  5:  94552abf45 t/helper/test-read-graph.c: extract `du=
mp_graph_info()`
>     @@ Commit message
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## t/helper/test-read-graph.c ##
>      @@
>  3:  bc9d77ae60 !  6:  3d81efa27b bloom.h: make `load_bloom_filter_from_g=
raph()` public
>     @@ Commit message
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bloom.c ##
>      @@ bloom.c: static inline unsigned char get_bitmask(uint32_t pos)
>  4:  ac7008aed3 !  7:  d23cd89037 t/helper/test-read-graph: implement `bl=
oom-filters` mode
>     @@ Commit message
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## t/helper/test-read-graph.c ##
>      @@ t/helper/test-read-graph.c: static void dump_graph_info(struct co=
mmit_graph *graph)
>     @@ t/helper/test-read-graph.c: int cmd__read_graph(int argc UNUSED, c=
onst char **ar
>      -	return 0;
>      +	return ret;
>       }
>     ++
>     ++
>  5:  71755ba856 !  8:  cba766f224 t4216: test changed path filters with h=
igh bit paths
>     @@ Commit message
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## t/t4216-log-bloom.sh ##
>     -@@ t/t4216-log-bloom.sh: test_expect_success 'Bloom generation backf=
ills empty commits' '
>     - 	)
>     +@@ t/t4216-log-bloom.sh: test_expect_success 'merge graph layers wit=
h incompatible Bloom settings' '
>     + 	! grep "disabling Bloom filters" err
>       '
>      =20
>      +get_first_changed_path_filter () {
>  6:  9768d92c0f !  9:  a08a961f41 repo-settings: introduce commitgraph.ch=
angedPathsVersion
>     @@ Commit message
>          Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## Documentation/config/commitgraph.txt ##
>      @@ Documentation/config/commitgraph.txt: commitGraph.maxNewFilters::
>  7:  f911b4bfab =3D 10:  61d44519a5 commit-graph: new filter ver. that fi=
xes murmur3
>  8:  35009900df ! 11:  a8c10f8de8 bloom: annotate filters with hash versi=
on
>     @@ Commit message
>          Bloom filter.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bloom.c ##
>      @@ bloom.c: int load_bloom_filter_from_graph(struct commit_graph *g,
>  9:  138bc16905 ! 12:  2ba10a4b4b bloom: prepare to discard incompatible =
Bloom filters
>     @@ Commit message
>          `get_or_compute_bloom_filter()`.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bloom.c ##
>      @@ bloom.c: static void init_truncated_large_filter(struct bloom_fil=
ter *filter,
> 11:  2437e62813 ! 13:  09d8669c3a commit-graph.c: unconditionally load Bl=
oom filters
>     @@ Commit message
>          either "1" or "2".
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## commit-graph.c ##
>      @@ commit-graph.c: static int graph_read_bloom_data(const unsigned c=
har *chunk_start,
> 12:  fe8fb2f5fe ! 14:  0d4f9dc4ee commit-graph: drop unnecessary `graph_r=
ead_bloom_data_context`
>     @@ Commit message
>     =20
>          Noticed-by: Jonathan Tan <jonathantanmy@google.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## commit-graph.c ##
>      @@ commit-graph.c: static int graph_read_oid_lookup(const unsigned c=
har *chunk_start,
> 13:  825af91e11 ! 15:  1f7f27bc47 object.h: fix mis-aligned flag bits tab=
le
>     @@ Commit message
>          Bit position 23 is one column too far to the left.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## object.h ##
>      @@ object.h: void object_array_init(struct object_array *array);
> 14:  593b317192 ! 16:  abbef95ae8 commit-graph: reuse existing Bloom filt=
ers where possible
>     @@ Commit message
>            commits by their generation number.
>     =20
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>     -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
>     =20
>       ## bloom.c ##
>      @@
> 15:  8bf2c9cf98 =3D 17:  ca362408d5 bloom: introduce `deinit_bloom_filter=
s()`
> --=20
> 2.42.0.342.g8bb3a896ee

--JPvSSSIhA4JXMNhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSa8ACgkQVbJhu7ck
PpRicw/9EiwWEXvHwPv49BlYLt32lnfaK4TGIPlg/Cq05lWtWC5zOhs1s5o91J2e
+GqW1r6FPFUEJvrN0Xv2T4Bpisj8WdV+h1Ql/m3b1foXPVq4v7hJrZ1m2YhR13RH
SN3/s8q8QPoOiaxwoyiiHNpT1bQlGUQZ8Q7zpzvyeKBve/qYTYFnxam4K7lo2KNC
R+Zkgkc36HmjyI3xicIjjHn+cTQ5CLfUfoUzwBez0vwMB2WGtWDjUWPGZ8lnw75h
5G5uFK7eeUGLkcblHUn29+qk5HePSgOKZ0THZWdXZOa6r0Neq/Wyz+WSbMGGb8M5
UCtHz/w/DFnjutUtLuz4S2y8mrpvXWaQt043EYhtvpr6+5v0w9h9qQTx42e2GecR
6aj0eqRisqWLRVLkNSQobvPGc+jljXfZ0WrDNBMmhIbgKRQ2dV9atSpC6d85PVA0
88UZaikdSJmUOiV3+h/33+qkD+Z3nNg7+SRyMJMGOpAIPPipquJV6kztYuH20Ftf
wQgL7/KKIP7mS1IQW+ET5aO96j6JaC2D1tDfGONaItVNZ2XpQet0AdrpwzaGbpxL
CRt0nmNTBiO0MYq9LIvIKMQa/qRqDFQ4dE93QD4L99QNZTlMbivurAf34FNRElSw
HmEpVV5NM0ht1Z4qkceh6ISwHpwqjhAPxNv3IvYL21nfygqBwyk=
=lAGP
-----END PGP SIGNATURE-----

--JPvSSSIhA4JXMNhy--
