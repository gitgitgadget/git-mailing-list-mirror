Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F58F43
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yWian3de";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlcLBqOm"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D011A1
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 23:25:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 5228D5C0222;
	Fri, 27 Oct 2023 02:25:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 27 Oct 2023 02:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698387935; x=1698474335; bh=ni
	BENvPreCyeUInNMjAQ8UtZ3irohQCIpc1sKDG1ywI=; b=yWian3dez1LZqseWUr
	fObgj+jR1r8qmxqtwfbngIZ075vKtWe5KnrJnHuAM9gF9o878YRGmphyHOeneJOA
	WheWJC+YDzI1NQDFPubh5YQxx7u6Q0AvLLtZrkDHaLFPrnluevRWHvmXdVviUogp
	eTS5tdr0L8Z6JB45xZ8JK6bkGZzpxyYePGYf6Agl6np78I/74tOCGZCbSdMNg8kh
	hv5PZLFQpGn+4NIYKqCQOZ1E0LlzRfo+LSaMofqgFJo99qfnCp5uR/VUwVR4ituf
	tRMlw5u/pRe+Mo3PRl7VDVpjkVzRMQiY2gkjQ0QAnxmvfmUN2bxadTzDx02LU/rF
	fdwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698387935; x=1698474335; bh=niBENvPreCyeU
	InNMjAQ8UtZ3irohQCIpc1sKDG1ywI=; b=MlcLBqOm5CYRy0vXcDYyJhTr1uHHK
	5tZslE8CXUr6jO5VODSMOH3479r+PncRkycW+KKT0zVeCfrgpByhR58HQp8KEekR
	ZZ57y8D9JM9G7+9Golg9JVV9T7EYQETmI8FsKIz6e5cmajH87+Bdhlgre+VyHoU4
	m0SoNvy2v4pCScC0lLccbN6RA8FAg6SLTB09gRc2yImNMJZtjFhtC24pk4w3PEh5
	I885F53qw4A2ru4PtrnqdUppC2DLVWSPZW4SlNs3i5KDHzvr90jXgfW5WdNLy0GA
	bSHIA4pol4YivfU0eZJgsWlFqApEDKLOyIFtKPVcfhB+G9sLuFLFOkDpA==
X-ME-Sender: <xms:31c7ZcLTcmh93W0cWIx78cTlPoZwbQ-aisoPH-fPTI3Z1X3K8y05jA>
    <xme:31c7ZcKR8l233uXD9iGseN32BP8IcFPTwy_X3qQHAM80wWguXZGGaU49ddXl3o1au
    nSXAaDhxPM43zzaIg>
X-ME-Received: <xmr:31c7ZcuzdIEMqAzTkVUrUvHP88YZNamkQ24XUVnQ2rQL49N1sOTfoIsPHQ0g21VzMR_yPN-9TXgj0UeuzmhmKh_ZoNDvkaActXjuicXAvTb0mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:31c7ZZZbQAb9H1XpDaUrVJpb8ztMqKGRk0igd9x--8WUYQ_c5kNRUw>
    <xmx:31c7ZTaHOzrkBgbBhTZRombBehqra93rrL9NqmMQkPQMA3fS2g0yew>
    <xmx:31c7ZVCygUEAq23mkejTGXdMbPnYRS1wBPsdPrGyc7pEyMpUcXIUbA>
    <xmx:31c7ZawDM0mr0GAFaQFUmB54wdNABsducOjA5yArZLYFlFX-_x65pw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 02:25:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91bb3b70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 06:25:21 +0000 (UTC)
Date: Fri, 27 Oct 2023 08:25:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v5 3/3] rev-list: add commit object support in
 `--missing` option
Message-ID: <ZTtXzg4NGJZzAqfS@tanuki>
References: <20231024122631.158415-1-karthik.188@gmail.com>
 <20231026101109.43110-1-karthik.188@gmail.com>
 <20231026101109.43110-4-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YAI++KLx/rmyB7XN"
Content-Disposition: inline
In-Reply-To: <20231026101109.43110-4-karthik.188@gmail.com>


--YAI++KLx/rmyB7XN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 12:11:09PM +0200, Karthik Nayak wrote:
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
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/rev-list.c          |  6 +++
>  list-objects.c              |  3 ++
>  revision.c                  | 17 ++++++++-
>  revision.h                  |  4 ++
>  t/t6022-rev-list-missing.sh | 74 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+), 2 deletions(-)
>  create mode 100755 t/t6022-rev-list-missing.sh
>=20
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 98542e8b3c..181353dcf5 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -149,6 +149,12 @@ static void show_commit(struct commit *commit, void =
*data)
> =20
>  	display_progress(progress, ++progress_counter);
> =20
> +	if (revs->do_not_die_on_missing_objects &&
> +	    oidset_contains(&revs->missing_commits, &commit->object.oid)) {
> +		finish_object__ma(&commit->object);
> +		return;
> +	}
> +
>  	if (show_disk_usage)
>  		total_disk_usage +=3D get_object_disk_usage(&commit->object);
> =20
> diff --git a/list-objects.c b/list-objects.c
> index 47296dff2f..f4e1104b56 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -389,6 +389,9 @@ static void do_traverse(struct traversal_context *ctx)
>  		 */
>  		if (!ctx->revs->tree_objects)
>  			; /* do not bother loading tree */
> +		else if (ctx->revs->do_not_die_on_missing_objects &&
> +			 oidset_contains(&ctx->revs->missing_commits, &commit->object.oid))
> +			;
>  		else if (repo_get_commit_tree(the_repository, commit)) {
>  			struct tree *tree =3D repo_get_commit_tree(the_repository,
>  								 commit);
> diff --git a/revision.c b/revision.c
> index 219dc76716..738bacad08 100644
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
> +	    oidset_contains(&revs->missing_commits, &commit->object.oid))
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
> +			if (revs->do_not_die_on_missing_objects)
> +				oidset_insert(&revs->missing_commits, &p->object.oid);
> +			else
> +				return -1; /* corrupt repository */
>  		}
>  		if (revs->sources) {
>  			char **slot =3D revision_sources_at(revs->sources, p);
> @@ -3109,6 +3118,7 @@ void release_revisions(struct rev_info *revs)
>  	clear_decoration(&revs->merge_simplification, free);
>  	clear_decoration(&revs->treesame, free);
>  	line_log_free(revs);
> +	oidset_clear(&revs->missing_commits);
>  }
> =20
>  static void add_child(struct rev_info *revs, struct commit *parent, stru=
ct commit *child)
> @@ -3800,6 +3810,9 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
> =20
> +	if (revs->do_not_die_on_missing_objects)
> +		oidset_init(&revs->missing_commits, 0);
> +

We unconditionally clear the oidset now, so shouldn't we also
unconditionally initialize it?

Patrick

>  	if (!revs->reflog_info)
>  		prepare_to_use_bloom_filter(revs);
>  	if (!revs->unsorted_input)
> diff --git a/revision.h b/revision.h
> index c73c92ef40..94c43138bc 100644
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
> +	/* Missing commits to be tracked without failing traversal. */
> +	struct oidset missing_commits;
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

--YAI++KLx/rmyB7XN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7V9kACgkQVbJhu7ck
PpSo3xAApkHTdiHsav1x58RmTCHwh1SPF9wOm1B1W6yu+IUSCbHv6atlDtLm7m1w
hyrOvQU9Ps/pRYDYspylipzJtDJDEjUCuSO6MefKuknMyxxbSs2MRhvtWiAo0tAN
/9MtS2Ywfg7vunsAxG8ESkodEnSZG9BKFbQw1tx1r9JgJtDeK88wJQOP5xbyBZMy
OssJaj6VheRCbrlgu6ZbjPc3uHm8YpWG6q2Bg/QRT694rCQqDubql5yO5nLyfL3i
QmLrTL3f4xM4kK0/l6bN2PhulPMrpFvTLngtY3zMNasNcPgfvhdIHWGSZcRTK/6Q
t9ypkhf9cU86rqAQdnLYeUaRKUk3nZ1YO417RyFCw96XOotn4pAvVU+5hiR8GTSr
EJVn/3s0tOT7rQE6rW59AVgoXeidi7TGP7oJx4f4pgQrqbdC1LHgpabXjRAwMKtw
AnVkqKvceoNPHJVfism2dHctnwjnH9zPBx8gSIeGRGJ4CpO8R/Y3uTe+sjrSeEDP
NnanuPOllAOQzO3IlZrmeuo36PToPgd8bp8UibgtElhECG7e1ukvbDXbcuRxqmou
xUUGdOUd2a7cXDZG6NYN5izLGb5FATiWTE2HkzPYwDVjBgCZ9l3nNDNkna4KL2+j
qfTMHf0MQP1Zy627XKKYovV0quXzZfLD8sdInbVOHgwsSEZvl58=
=QNAH
-----END PGP SIGNATURE-----

--YAI++KLx/rmyB7XN--
