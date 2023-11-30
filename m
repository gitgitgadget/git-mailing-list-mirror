Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mwys7zLc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HF3RobTA"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB6B1A3
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:19:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 7642C5C01A1;
	Thu, 30 Nov 2023 05:19:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 05:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339540; x=1701425940; bh=ny
	KcqzcbyaQSbIj7PvwzrQuTEczUoxUBccqxmZvhK9w=; b=Mwys7zLciOnYepE+ZC
	3WbTCR/2Ail/TgRFOXRrUutu1/j8rFFQexcSFpPjbV7CJY67KvSOkOROEZm8Kh/O
	HFqWODC0ARo4DqhgM8rBISJyw/Z1ZC9aqwQsMZWEn7bG+6XDQbM2zxTPhvYC7Oo0
	HkkaO3A+CebP+pS3KO0kLloFL5vEIXFzJZiGq0xi7kaQiQF7pZZqQAymgZFBUnUO
	TQ001luO7qywB+JuxD2b8tOnK6uGDGWYhCeKS3AKPMLi0gpIlAZJj082z0MHbEl0
	iZhSP+HscBE5bQiTmFWvhN9sqyLM9Pvx8NLnUKV5XGS054qHETM5k+FASncun9XB
	zZBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339540; x=1701425940; bh=nyKcqzcbyaQSb
	Ij7PvwzrQuTEczUoxUBccqxmZvhK9w=; b=HF3RobTAgyMAXp7mnJWSe+5xXhYqZ
	SJlLqaQiQS2n8OcH09GGJ87JTchV1D36p+zAkPFtaXt/dmfZx8wdfhBH2jlFMirl
	+JoqL6G370D0qIiWavW4NuEnn9pgQjCJPkQ5hd+XdhCyQJaePIqTKA1rvlk6wvct
	00lbrhv6vdklmGDJAC4MIL1H+sTMyYmyTP0vRneuWWFYFL52MY8mNEeeCrNzFTnC
	eOVqqu+3wmyI649jHq4DZ/3gfiWMEZskkFiJiRZIeU74S6j72rTFlKtz4qicW2pt
	PxOnYwwSPz3YZlsDLghd8CMMvTVC2mtTpVoFMM9yzmi5kqqohU1cj4tqg==
X-ME-Sender: <xms:lGFoZRMpAwZeNemP5s-xXL-4gjlHjQ2aQM7VwmgbYStvwlMsgL6YIA>
    <xme:lGFoZT-ruQWUIlKxIJRQwzZFdjFWAiTuqZtFPI31pXh4slGz-9QcOiGAOj084LXPg
    JXAOTuATe3-K2N7FA>
X-ME-Received: <xmr:lGFoZQTcXLeM9QfxUSwGIZ0V_xa3l_OjoMu2fX4zuY_vA1rPmJY4sa33jMSWLtdT2vUJn3WLbPumw0N4iLIq4dsIKXn-i6A1-YE0miho5L3sp4aF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lGFoZduxyBAhYUddz3Ai8duy55CJCbKkIrekjZrZrzX7Cv_0nnH5IQ>
    <xmx:lGFoZZdAZpEVCSMEgXbYsaBdfHLGtQG7C7cyCpLEj3tRpdbvx9JdrA>
    <xmx:lGFoZZ3Gq8RySOo64vuk0tNjbbc3Ar50F3UvpwtIusKHzLEAda7Qpg>
    <xmx:lGFoZaop6hvVyzVWhyHUmEWAOd6xehmAw5gEhazLouYt4mQVlGPpGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 355b8233 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:46 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/24] pack-objects: implement `--ignore-disjoint` mode
Message-ID: <ZWhhkdnVZ9w7tDBv@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CBbXuFyW4uyJNown"
Content-Disposition: inline
In-Reply-To: <0368f7ab37669163b50b82185725935bde5bc946.1701198172.git.me@ttaylorr.com>


--CBbXuFyW4uyJNown
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:16PM -0500, Taylor Blau wrote:
> Before multi-pack reachability bitmaps learn how to perform pack reuse
> over the set of disjoint packs, we will need a way to generate packs
> that are known to be disjoint with respect to the currently marked set
> of disjoint packs.
>=20
> In other words, we want a way to make a pack which does not have any
> objects contained in the union of the set of packs which are currently
> marked as disjoint.
>=20
> There are a various ways that we could go about this, for example:
>=20
>   - passing `--unpacked`, which would exclude all packed objects (and
>     thus would not contain any objects from the disjoint pack)
>=20
>   - passing `--stdin-packs` with the set of packs currently marked as
>     disjoint as "excluded", indicating that `pack-objects` should
>     discard any objects present in any of the excluded packs (thus
>     producing a disjoint pack)
>=20
>   - marking each of the disjoint packs as kept in-core with the
>     `--keep-pack` flag, and then passing `--honor-pack-keep` to
>     similarly ignore any object(s) from kept packs (thus also producing
>     a pack which is disjoint with respect to the current set)
>=20
> `git repack` is the main entry-point to generating a new pack, by
> invoking `pack-objects` and then adding the new pack to the set of
> disjoint packs if generating a new MIDX. However, `repack` has a number
> of ways to invoke `pack-objects` (e.g., all-into-one repacks, geometric
> repacks, incremental repacks, etc.), all of which would require careful
> reasoning in order to prove that the resulting set of packs is disjoint.
>=20
> The most appealing option of the above would be to pass the set of
> disjoint packs as kept (via `--keep-pack`) and then ignore their
> contents (with `--honor-pack-keep`), doing so for all kinds of
> `pack-objects` invocations. But there may be more disjoint packs than we
> can easily fit into the command-line arguments.
>=20
> Instead, teach `pack-objects` a special `--ignore-disjoint` which is the
> moral equivalent of marking the set of disjoint packs as kept, and
> ignoring their contents, even if it would have otherwise been packed. In
> fact, this similarity extends down to the implementation, where each
> disjoint pack is first loaded, then has its `pack_keep_in_core` bit set.
>=20
> With this in place, we can use the kept-pack cache from 20b031fede
> (packfile: add kept-pack cache for find_kept_pack_entry(), 2021-02-22),
> which looks up objects first in a cache containing just the set of kept
> (in this case, disjoint) packs. Assuming that the set of disjoint packs
> is a relatively small portion of the entire repository (which should be
> a safe assumption to make), each object lookup will be very inexpensive.

This cought me by surprise a bit. I'd have expected that in the end,
most of the packfiles in a repository would be disjoint. Using for
example geometric repacks, my expectation was that all of the packs that
get written via geometric repacking would eventually become disjoint
whereas new packs added to the repository would initially not be.

Patrick

> The only place we want to avoid using `--ignore-disjoint` is in
> conjunction with `--cruft`, since doing so may cause us to omit an
> object which would have been included in a new cruft pack in order to
> freshen it. In other words, failing to do so might cause that object to
> be pruned from the repository earlier than expected.
>=20
> Otherwise, `--ignore-disjoint` is compatible with most other modes of
> `pack-objects`. These various combinations are tested below. As a
> result, `repack` will be able to unconditionally (except for the cruft
> pack) pass `--ignore-disjoint` when trying to add a new pack to the
> disjoint set, and the result will be usable, without having to carefully
> consider and reason about each individual case.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-pack-objects.txt |   8 ++
>  builtin/pack-objects.c             |  31 +++++-
>  t/lib-disjoint.sh                  |  11 ++
>  t/t5331-pack-objects-stdin.sh      | 156 +++++++++++++++++++++++++++++
>  4 files changed, 203 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-=
objects.txt
> index e32404c6aa..592c4ce742 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -96,6 +96,14 @@ base-name::
>  Incompatible with `--revs`, or options that imply `--revs` (such as
>  `--all`), with the exception of `--unpacked`, which is compatible.
> =20
> +--ignore-disjoint::
> +	This flag causes an object that appears in any pack marked as
> +	"disjoint" by the multi-pack index to be ignored, even if it
> +	would have otherwise been packed. When used with
> +	`--stdin-packs`, objects from disjoint packs may be included if
> +	and only if a disjoint pack is explicitly given as an input pack
> +	to `--stdin-packs`. Incompatible with `--cruft`.
> +
>  --cruft::
>  	Packs unreachable objects into a separate "cruft" pack, denoted
>  	by the existence of a `.mtimes` file. Typically used by `git
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index bfa60359d4..107154db34 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -207,6 +207,7 @@ static int have_non_local_packs;
>  static int incremental;
>  static int ignore_packed_keep_on_disk;
>  static int ignore_packed_keep_in_core;
> +static int ignore_midx_disjoint_packs;
>  static int allow_ofs_delta;
>  static struct pack_idx_option pack_idx_opts;
>  static const char *base_name;
> @@ -1403,7 +1404,8 @@ static int want_found_object(const struct object_id=
 *oid, int exclude,
>  	/*
>  	 * Then handle .keep first, as we have a fast(er) path there.
>  	 */
> -	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
> +	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core ||
> +	    ignore_midx_disjoint_packs) {
>  		/*
>  		 * Set the flags for the kept-pack cache to be the ones we want
>  		 * to ignore.
> @@ -1415,7 +1417,7 @@ static int want_found_object(const struct object_id=
 *oid, int exclude,
>  		unsigned flags =3D 0;
>  		if (ignore_packed_keep_on_disk)
>  			flags |=3D ON_DISK_KEEP_PACKS;
> -		if (ignore_packed_keep_in_core)
> +		if (ignore_packed_keep_in_core || ignore_midx_disjoint_packs)
>  			flags |=3D IN_CORE_KEEP_PACKS;
> =20
>  		if (ignore_packed_keep_on_disk && p->pack_keep)
> @@ -3389,6 +3391,7 @@ static void read_packs_list_from_stdin(void)
>  			die(_("could not find pack '%s'"), item->string);
>  		if (!is_pack_valid(p))
>  			die(_("packfile %s cannot be accessed"), p->pack_name);
> +		p->pack_keep_in_core =3D 0;
>  	}
> =20
>  	/*
> @@ -4266,6 +4269,8 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>  			 N_("create packs suitable for shallow fetches")),
>  		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep_on_disk,
>  			 N_("ignore packs that have companion .keep file")),
> +		OPT_BOOL(0, "ignore-disjoint", &ignore_midx_disjoint_packs,
> +			 N_("ignore packs that are marked disjoint in the MIDX")),
>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>  				N_("ignore this pack")),
>  		OPT_INTEGER(0, "compression", &pack_compression_level,
> @@ -4412,7 +4417,9 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>  		if (use_internal_rev_list)
>  			die(_("cannot use internal rev list with --cruft"));
>  		if (stdin_packs)
> -			die(_("cannot use --stdin-packs with --cruft"));
> +			die(_("cannot use %s with %s"), "--stdin-packs", "--cruft");
> +		if (ignore_midx_disjoint_packs)
> +			die(_("cannot use %s with %s"), "--ignore-disjoint", "--cruft");
>  	}
> =20
>  	/*
> @@ -4452,6 +4459,24 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  		if (!p) /* no keep-able packs found */
>  			ignore_packed_keep_on_disk =3D 0;
>  	}
> +	if (ignore_midx_disjoint_packs) {
> +		struct multi_pack_index *m =3D get_multi_pack_index(the_repository);
> +		struct bitmapped_pack pack;
> +		unsigned any_disjoint =3D 0;
> +		uint32_t i;
> +
> +		for (i =3D 0; m && m->chunk_disjoint_packs && i < m->num_packs; i++) {
> +			if (nth_bitmapped_pack(the_repository, m, &pack, i) < 0)
> +				die(_("could not load bitmapped pack %i"), i);
> +			if (pack.disjoint) {
> +				pack.p->pack_keep_in_core =3D 1;
> +				any_disjoint =3D 1;
> +			}
> +		}
> +
> +		if (!any_disjoint) /* no disjoint packs to ignore */
> +			ignore_midx_disjoint_packs =3D 0;
> +	}
>  	if (local) {
>  		/*
>  		 * unlike ignore_packed_keep_on_disk above, we do not
> diff --git a/t/lib-disjoint.sh b/t/lib-disjoint.sh
> index c6c6e74aba..c802ca6940 100644
> --- a/t/lib-disjoint.sh
> +++ b/t/lib-disjoint.sh
> @@ -36,3 +36,14 @@ test_must_be_disjoint () {
>  test_must_not_be_disjoint () {
>  	test_disjoint_1 "$1" "no"
>  }
> +
> +# packed_contents </path/to/pack-$XYZ.idx [...]>
> +#
> +# Prints the set of objects packed in the given pack indexes.
> +packed_contents () {
> +	for idx in "$@"
> +	do
> +		git show-index <$idx || return 1
> +	done >tmp &&
> +	cut -d" " -f2 <tmp | sort -u
> +}
> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> index 2dcf1eecee..e522aa3f7d 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -6,6 +6,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> =20
>  TEST_PASSES_SANITIZE_LEAK=3Dtrue
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-disjoint.sh
> =20
>  packed_objects () {
>  	git show-index <"$1" >tmp-object-list &&
> @@ -237,4 +238,159 @@ test_expect_success 'pack-objects --stdin with pack=
files from main and alternate
>  	test_cmp expected-objects actual-objects
>  '
> =20
> +objdir=3D.git/objects
> +packdir=3D$objdir/pack
> +
> +test_expect_success 'loose objects also in disjoint packs are ignored' '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		# create a pack containing the objects in each commit below, but
> +		# do not delete their loose copies
> +		test_commit base &&
> +		base_pack=3D"$(echo base | git pack-objects --revs $packdir/pack)" &&
> +
> +		test_commit other &&
> +		other_pack=3D"$(echo base..other | git pack-objects --revs $packdir/pa=
ck)" &&
> +
> +		cat >in <<-EOF &&
> +		pack-$base_pack.idx
> +		+pack-$other_pack.idx
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +		test_commit more &&
> +		out=3D"$(git pack-objects --all --ignore-disjoint $packdir/pack)" &&
> +
> +		# gather all objects in "all", and objects from the disjoint
> +		# pack in "disjoint"
> +		git cat-file --batch-all-objects --batch-check=3D"%(objectname)" >all =
&&
> +		packed_contents "$packdir/pack-$other_pack.idx" >disjoint &&
> +
> +		# make sure that the set of objects we just generated matches
> +		# "all \ disjoint"
> +		packed_contents "$packdir/pack-$out.idx" >got &&
> +		comm -23 all disjoint >want &&
> +		test_cmp want got
> +	)
> +'
> +
> +test_expect_success 'objects in disjoint packs are ignored (--unpacked)'=
 '
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		for c in A B
> +		do
> +			test_commit "$c" || return 1
> +		done &&
> +
> +		A=3D"$(echo "A" | git pack-objects --revs $packdir/pack)" &&
> +		B=3D"$(echo "A..B" | git pack-objects --revs $packdir/pack)" &&
> +
> +		cat >in <<-EOF &&
> +		pack-$A.idx
> +		+pack-$B.idx
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +		test_must_not_be_disjoint "pack-$A.pack" &&
> +		test_must_be_disjoint "pack-$B.pack" &&
> +
> +		test_commit C &&
> +
> +		got=3D"$(git pack-objects --all --unpacked --ignore-disjoint $packdir/=
pack)" &&
> +		packed_contents "$packdir/pack-$got.idx" >actual &&
> +
> +		git rev-list --objects --no-object-names B..C >expect.raw &&
> +		sort <expect.raw >expect &&
> +
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'objects in disjoint packs are ignored (--stdin-pack=
s)' '
> +	# Create objects in three separate packs:
> +	#
> +	#   - pack A (midx, non disjoint)
> +	#   - pack B (midx, disjoint)
> +	#   - pack C (non-midx)
> +	#
> +	# Then create a new pack with `--stdin-packs` and `--ignore-disjoint`
> +	# including packs A, B, and C. The resulting pack should contain
> +	# only the objects from packs A, and C, excluding those from
> +	# pack B as it is marked as disjoint.
> +	test_when_finished "rm -fr repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		for c in A B C
> +		do
> +			test_commit "$c" || return 1
> +		done &&
> +
> +		A=3D"$(echo "A" | git pack-objects --revs $packdir/pack)" &&
> +		B=3D"$(echo "A..B" | git pack-objects --revs $packdir/pack)" &&
> +		C=3D"$(echo "B..C" | git pack-objects --revs $packdir/pack)" &&
> +
> +		cat >in <<-EOF &&
> +		pack-$A.idx
> +		+pack-$B.idx
> +		EOF
> +		git multi-pack-index write --stdin-packs --bitmap <in &&
> +
> +		test_must_not_be_disjoint "pack-$A.pack" &&
> +		test_must_be_disjoint "pack-$B.pack" &&
> +
> +		# Generate a pack with `--stdin-packs` using packs "A" and "C",
> +		# but excluding objects from "B". The objects from pack "B" are
> +		# expected to be omitted from the generated pack for two
> +		# reasons:
> +		#
> +		#   - because it was specified as a negated tip via
> +		#     `--stdin-packs`
> +		#   - because it is a disjoint pack.
> +		cat >in <<-EOF &&
> +		pack-$A.pack
> +		^pack-$B.pack
> +		pack-$C.pack
> +		EOF
> +		got=3D"$(git pack-objects --stdin-packs --ignore-disjoint $packdir/pac=
k <in)" &&
> +
> +		packed_contents "$packdir/pack-$got.idx" >actual &&
> +		packed_contents "$packdir/pack-$A.idx" \
> +				"$packdir/pack-$C.idx" >expect &&
> +		test_cmp expect actual &&
> +
> +		# Generate another pack with `--stdin-packs`, this time
> +		# using packs "B" and "C". The objects from pack "B" are
> +		# expected to be in the final pack, despite it being a
> +		# disjoint pack, because "B" was mentioned explicitly
> +		# via `stdin-packs`.
> +		cat >in <<-EOF &&
> +		pack-$B.pack
> +		pack-$C.pack
> +		EOF
> +		got=3D"$(git pack-objects --stdin-packs --ignore-disjoint $packdir/pac=
k <in)" &&
> +
> +		packed_contents "$packdir/pack-$got.idx" >actual &&
> +		packed_contents "$packdir/pack-$B.idx" \
> +				"$packdir/pack-$C.idx" >expect &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '--cruft is incompatible with --ignore-disjoint' '
> +	test_must_fail git pack-objects --cruft --ignore-disjoint --stdout \
> +		</dev/null >/dev/null 2>actual &&
> +	cat >expect <<-\EOF &&
> +	fatal: cannot use --ignore-disjoint with --cruft
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done
> --=20
> 2.43.0.24.g980b318f98
>=20

--CBbXuFyW4uyJNown
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYZAACgkQVbJhu7ck
PpRpZBAAgSg+09+EQ5iPXvhPgCmcR6nL2I/Ja1w76pTOReAvJETBxtAQ/iDy+7+W
eo3KpPoTOIxUvomyhAjS5sVgGInW9hpMKfu20IGcrBXOswp4Y9m2d65ib27XFsDH
PUSyC6PoIDcibCES5r8a6u2mNBlO4AGblu/lVMkBrPx+ILrbyPZZVfng42Nb39am
mlk4u3Pfe0W2pEaee+tkby0TnNlG9Rb5RcuZzUIMOwhI93NDNs9mXxFP/sy7Jup9
22AZEntdcH4Oy5FGUGIvFGLJOI6nrfYdTJjFyUbXARAuIF5cTpD/gpZaHS67T8Fp
yt1DoS+xQbbZLC/bxV1CnzJAx+tr//bqVheQ143eu3MGx2cG2FBeIMfz3XGpTWAk
FiCo2zJSQS/rxlUMksTvHvOtxN0bQHU4dOC+J1iJ51TzI8BFeayXI/WzmUFPPOFn
kE+58D2qe/ybV6Hno537pdn25amkdpLd8yF/0TA7F9r7f4LeKMuVCIqpClv0Da4U
GpSo4FfPHithVHofvd2GkkxH9+Dn3yDULL3fgOa1EWpo7X/3zeSZBzhM94MH6Ttw
w7HzdLLCR7wNrXCpsfZ6sNtMcNwWNuKIuW+GbSaCw9Gwhp1nqKsY6qvZmbUuqzMq
4Tpm5awZvqM0xAqTF8qsadX9F64g3g4x56UGPp7hSFbORLRgKic=
=1O63
-----END PGP SIGNATURE-----

--CBbXuFyW4uyJNown--
