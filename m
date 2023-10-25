Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D96D24
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CQg7H1gz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="on2WJlhU"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE25E5
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 23:40:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 7AA6C5C03C3;
	Wed, 25 Oct 2023 02:40:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 25 Oct 2023 02:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698216041; x=1698302441; bh=js
	R54VE4dnoL6MfnzJ4K4u5OYEbbHLUfa5omJqrRB34=; b=CQg7H1gzlSGWWAxkmz
	vt9AB+e3ZB6Y+tq3Fxl7EnEudrV9fRBZ3Oh3k/9KS09kROQnEa4/R9aRqFN665fZ
	yZphEyG9dvsfsZMIVVtKUQ5Gc7rHybh8e/uxjNV7PDNFGhFoX9rxDEG0wsGjf+kM
	l1OyfrGW4q6TYmy/OfrC6C/DRAvT4TkCbjOMuudN8qxZI+0kmZV6GXgfwPDpatm/
	2gqrCD8fg/NmvswSJBxoywfBNu8vg0EqVSMqBID+zZdTeHdmczfUvhRwLgFU3fQt
	RUDSy/igWHSK7i4Ha54sYqDlK0XCKTtmgNrH13hih6VVoVvwnBhfxtXJWamhBQYr
	rybQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698216041; x=1698302441; bh=jsR54VE4dnoL6
	MfnzJ4K4u5OYEbbHLUfa5omJqrRB34=; b=on2WJlhU9SyYIMZSoYp3D31znTyT5
	QDxcQTZ7uFJJz69OZL+bJWrewd+IUxdfjYvO41jsqx5+qisQPGLGuEe1p4E2nT2A
	jo/z99Qil1W1ujoBHjjZlmg0fYwl0qKDg2JxA4BeXJlCazLMsO3Q4BciSqTTThnM
	zSnZXvf8U7ktxU1hjofIdGLwRCc7JCRZcbmR9gyxt8sfTEUtx2svFpaSOVed0++Q
	NARpPNhGlCtQF3y8Qs3R7iA27jh7S7gks+mGkERagD9aPWs5TxkGWq5rrObMkuWz
	sRIiKzFQ61N9uvpTXwAb0Qb2Oh1Rb+x92BYKTPpnVkaZmU8an577RvVSQ==
X-ME-Sender: <xms:abg4ZfaAVL1L0-fhZd-bzBvUFxljjAKPj3MlT-dFMK4y4fKbo4QOww>
    <xme:abg4ZeYIlgdJrGg_Hc176286E2Tcu2ZWiXtcrvx26nPQnmxf2p0NaNvMyMkniFIGd
    xoEM82CaXfF3Wi-nQ>
X-ME-Received: <xmr:abg4ZR_GSKajqzePksWp6j4ryiimauNgnCz1VNmWLbcFMu8FHqJN7IOhaad7Jp7dCxq3iJOxgt517WZWSPPXYfb0cxClxKqL_Mnt3DyHrn0VniY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:abg4ZVqhc_pFoaSea8zPXwVd3FAHyWmqNBc1mqg78Ovg5q062iKrww>
    <xmx:abg4ZapTbo1HMHqccceqGwE2brHpzArbJqOze5Fq9Km9iiGHg-RM9w>
    <xmx:abg4ZbT3wmQO18UQTA9MWp53Up70WxGovQEGEbQozJo6YRzKmFdbww>
    <xmx:abg4ZfC9d20sYVHh8PBnE2z1PDd3_3K1YRXgZF_wKRoAcNopSbzgsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 02:40:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ce8841d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 06:40:32 +0000 (UTC)
Date: Wed, 25 Oct 2023 08:40:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 3/3] rev-list: add commit object support in
 `--missing` option
Message-ID: <ZTi4Zd1by53q5gtM@tanuki>
References: <20231019121024.194317-1-karthik.188@gmail.com>
 <20231024122631.158415-1-karthik.188@gmail.com>
 <20231024122631.158415-4-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxOwBgVJB8wKIIni"
Content-Disposition: inline
In-Reply-To: <20231024122631.158415-4-karthik.188@gmail.com>


--lxOwBgVJB8wKIIni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 02:26:31PM +0200, Karthik Nayak wrote:
> The `--missing` object option in rev-list currently works only with
> missing blobs/trees. For missing commits the revision walker fails with
> a fatal error.
>=20
> Let's extend the functionality of `--missing` option to also support
> commit objects. This is done by adding a `missing_objects` field to
> `rev_info`. This field is an `oidset` to which we'll add the missing
> commits as we encounter them. The revision walker will now continue the
> traversal and call `show_commit()` even for missing commits. In rev-list
> we can then check if the commit is a missing commit and call the
> existing code for parsing `--missing` objects.
>=20
> A scenario where this option would be used is to find the boundary
> objects between different object directories. Consider a repository with
> a main object directory (GIT_OBJECT_DIRECTORY) and one or more alternate
> object directories (GIT_ALTERNATE_OBJECT_DIRECTORIES). In such a
> repository, using the `--missing=3Dprint` option while disabling the
> alternate object directory allows us to find the boundary objects
> between the main and alternate object directory.
>=20
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/rev-list.c          |  6 +++
>  list-objects.c              |  3 ++
>  revision.c                  | 16 +++++++-
>  revision.h                  |  4 ++
>  t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 101 insertions(+), 2 deletions(-)
>  create mode 100755 t/t6022-rev-list-missing.sh
>=20
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 98542e8b3c..37b52520b5 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void =
*data)
> =20
>  	display_progress(progress, ++progress_counter);
> =20
> +	if (revs->do_not_die_on_missing_objects &&
> +	    oidset_contains(&revs->missing_objects, &commit->object.oid)) {
> +		finish_object__ma(&commit->object);
> +		return;
> +	}
> +
>  	if (show_disk_usage)
>  		total_disk_usage +=3D get_object_disk_usage(&commit->object);
> =20
> diff --git a/list-objects.c b/list-objects.c
> index 47296dff2f..260089388c 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -389,6 +389,9 @@ static void do_traverse(struct traversal_context *ctx)
>  		 */
>  		if (!ctx->revs->tree_objects)
>  			; /* do not bother loading tree */
> +		else if (ctx->revs->do_not_die_on_missing_objects &&
> +			 oidset_contains(&ctx->revs->missing_objects, &commit->object.oid))
> +			;
>  		else if (repo_get_commit_tree(the_repository, commit)) {
>  			struct tree *tree =3D repo_get_commit_tree(the_repository,
>  								 commit);
> diff --git a/revision.c b/revision.c
> index 219dc76716..e60646c1a7 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -6,6 +6,7 @@
>  #include "object-name.h"
>  #include "object-file.h"
>  #include "object-store-ll.h"
> +#include "oidset.h"
>  #include "tag.h"
>  #include "blob.h"
>  #include "tree.h"
> @@ -1112,6 +1113,9 @@ static int process_parents(struct rev_info *revs, s=
truct commit *commit,
> =20
>  	if (commit->object.flags & ADDED)
>  		return 0;
> +	if (revs->do_not_die_on_missing_objects &&
> +		oidset_contains(&revs->missing_objects, &commit->object.oid))

Nit: indentation is off here.

> +		return 0;
>  	commit->object.flags |=3D ADDED;
> =20
>  	if (revs->include_check &&
> @@ -1168,7 +1172,8 @@ static int process_parents(struct rev_info *revs, s=
truct commit *commit,
>  	for (parent =3D commit->parents; parent; parent =3D parent->next) {
>  		struct commit *p =3D parent->item;
>  		int gently =3D revs->ignore_missing_links ||
> -			     revs->exclude_promisor_objects;
> +			     revs->exclude_promisor_objects ||
> +			     revs->do_not_die_on_missing_objects;
>  		if (repo_parse_commit_gently(revs->repo, p, gently) < 0) {
>  			if (revs->exclude_promisor_objects &&
>  			    is_promisor_object(&p->object.oid)) {
> @@ -1176,7 +1181,11 @@ static int process_parents(struct rev_info *revs, =
struct commit *commit,
>  					break;
>  				continue;
>  			}
> -			return -1;
> +
> +			if (!revs->do_not_die_on_missing_objects)
> +				return -1;
> +			else
> +				oidset_insert(&revs->missing_objects, &p->object.oid);
>  		}
>  		if (revs->sources) {
>  			char **slot =3D revision_sources_at(revs->sources, p);
> @@ -3800,6 +3809,9 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
> =20
> +	if (revs->do_not_die_on_missing_objects)
> +		oidset_init(&revs->missing_objects, 0);
> +

While we're initializing the new oidset, we never clear it. We should
probably call `oidset_clear()` in `release_revisions()`. And if we
unconditionally initialized the oidset here then we can also call
`oiadset_clear()` unconditionally there, which should be preferable
given that `oidset_init()` does not allocate memory when no initial size
was given.

>  	if (!revs->reflog_info)
>  		prepare_to_use_bloom_filter(revs);
>  	if (!revs->unsorted_input)
> diff --git a/revision.h b/revision.h
> index c73c92ef40..f6bf422f0e 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -4,6 +4,7 @@
>  #include "commit.h"
>  #include "grep.h"
>  #include "notes.h"
> +#include "oidset.h"
>  #include "pretty.h"
>  #include "diff.h"
>  #include "commit-slab-decl.h"
> @@ -373,6 +374,9 @@ struct rev_info {
> =20
>  	/* Location where temporary objects for remerge-diff are written. */
>  	struct tmp_objdir *remerge_objdir;
> +
> +	/* Missing objects to be tracked without failing traversal. */
> +	struct oidset missing_objects;

As far as I can see we only use this set to track missing commits, but
none of the other objects. The name thus feels a bit misleading to me,
as a reader might rightfully assume that it contains _all_ missing
objects after the revwalk. Should we rename it to `missing_commits` to
clarify?

Patrick

>  };
> =20
>  /**
> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> new file mode 100755
> index 0000000000..40265a4f66
> --- /dev/null
> +++ b/t/t6022-rev-list-missing.sh
> @@ -0,0 +1,74 @@
> +#!/bin/sh
> +
> +test_description=3D'handling of missing objects in rev-list'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +# We setup the repository with two commits, this way HEAD is always
> +# available and we can hide commit 1.
> +test_expect_success 'create repository and alternate directory' '
> +	test_commit 1 &&
> +	test_commit 2 &&
> +	test_commit 3
> +'
> +
> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	test_expect_success "rev-list --missing=3Derror fails with missing obje=
ct $obj" '
> +		oid=3D"$(git rev-parse $obj)" &&
> +		path=3D".git/objects/$(test_oid_to_path $oid)" &&
> +
> +		mv "$path" "$path.hidden" &&
> +		test_when_finished "mv $path.hidden $path" &&
> +
> +		test_must_fail git rev-list --missing=3Derror --objects \
> +			--no-object-names HEAD
> +	'
> +done
> +
> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	for action in "allow-any" "print"
> +	do
> +		test_expect_success "rev-list --missing=3D$action with missing $obj" '
> +			oid=3D"$(git rev-parse $obj)" &&
> +			path=3D".git/objects/$(test_oid_to_path $oid)" &&
> +
> +			# Before the object is made missing, we use rev-list to
> +			# get the expected oids.
> +			git rev-list --objects --no-object-names \
> +				HEAD ^$obj >expect.raw &&
> +
> +			# Blobs are shared by all commits, so evethough a commit/tree
> +			# might be skipped, its blob must be accounted for.
> +			if [ $obj !=3D "HEAD:1.t" ]; then
> +				echo $(git rev-parse HEAD:1.t) >>expect.raw &&
> +				echo $(git rev-parse HEAD:2.t) >>expect.raw
> +			fi &&
> +
> +			mv "$path" "$path.hidden" &&
> +			test_when_finished "mv $path.hidden $path" &&
> +
> +			git rev-list --missing=3D$action --objects --no-object-names \
> +				HEAD >actual.raw &&
> +
> +			# When the action is to print, we should also add the missing
> +			# oid to the expect list.
> +			case $action in
> +			allow-any)
> +				;;
> +			print)
> +				grep ?$oid actual.raw &&
> +				echo ?$oid >>expect.raw
> +				;;
> +			esac &&
> +
> +			sort actual.raw >actual &&
> +			sort expect.raw >expect &&
> +			test_cmp expect actual
> +		'
> +	done
> +done
> +
> +test_done
> --=20
> 2.42.0
>=20

--lxOwBgVJB8wKIIni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4uGQACgkQVbJhu7ck
PpQI+hAArSOUhGRsn64RJMY+HYxm85xAY1zzCXVurRq1oQeHCDAzVa1dAkrTbher
uhPWCpec32rDHDv3brjNaUZ1dehuLskwsI117FryxTlKilM9j5OPBPyJAy5rDer6
hIdJYwvPo8fwBFL7J5ToCBmkQzwyZVrtYvVmsb4KFqRWZyq/UWmvjcGMLBhkXu+a
og9hnSgseU+vHTh70nPt+1RRgL4gszFQ4kANaPuS97dhUjqfAEM+SBEDDoTZEUN8
H0NkaNPJVTZhmxg0VMblu0uEa2e7C1JHThl1EwIAG+qs8UYsFvn1iQ/QUS9jBxiU
akW3fugo3i/OXq0qBT5v3s01kl15CEAOgZYxMZNbKeJ7d7b4/R8KEAma2o/qmZYN
9FVrutp8uQyl0NMKDYEY+RaZX4OnrSGYmsvE8gVmRBLgp5UujCv7gnEh+z74Q8MY
ZW7UnNVWvziWOC4KCSVNYxoYmchqbwkNue1N0WdL9sTGPO4a3G9KxQj5Gf8dYqwP
ousLPBfJcK2v3/OnSeAkjzAZEOFSaqKsfREMg+mALowPZTk0FENzBDmv4aLWvdhY
G1EohGdZYeToz1BNr11OkwIy+MmEwXqRuky27QwrMykv5Ls4E7kqSAje3+sSGfkb
watWFwx0VdvkXZvfsDNnkrZZamVZnmVREDoVS+HtvqyEYV0h5rE=
=4Hme
-----END PGP SIGNATURE-----

--lxOwBgVJB8wKIIni--
