Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5C1C684
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+ZiVerD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGMgGL9S"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790B3DE
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 00:58:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id E64FE5C033B;
	Wed, 25 Oct 2023 03:58:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 Oct 2023 03:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698220694; x=1698307094; bh=kN
	GK99XR7jWwj07oHbaREduEYBEx56sgCdGPB6NM9g0=; b=J+ZiVerDTO96oDpOin
	frL1xR6pjudnJGkjL3EzDKBazFBLHNXw7zjg7Mn/5jyL2FxKPSsVzZLI/C1AEqC0
	VAfhrETUeZWm9ubsN2pkrBh2nBgtpwp1spRgfWikd2ggOBQyfdF6350114QlrF4u
	TlaJx9EqmGNoxXdUd4AqwzoccYzBcisijUFYpvkPUVqb++sG7AfBoixwNl9Pi0V8
	Y3IskRJfgcpLIRrzPVvB4GSlyanOJw8nGDtzfjoaO53K83DMmv5OD1WmNUv/RcgJ
	bUSE1CwvEUhQulWMJzwBK6viRpnIJ9x/RvOWEizHB96m3Dkf+jMzrPVGbAs2StnN
	IkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698220694; x=1698307094; bh=kNGK99XR7jWwj
	07oHbaREduEYBEx56sgCdGPB6NM9g0=; b=PGMgGL9STwbcInounxAvzn3Bfqq4c
	b+1ZPPW0tFBHvivniOvYkXMw1f8il028d3wnyEkHnWF4yS8hZ91hFnfs169rb5RQ
	1N9lhez+zqii1kaD1z/trkapHWIMpMW4IYMnvMrtkOXcvhQ1uDS/rv/sMOZwfCRK
	EGYBND15JQrNyc2UquJJO5iEiTuT58wbmvnaktVAE0lmD+qStC2NrX0pU9c/bly+
	2LxttN7xprwu8IZp7GeoZQiiKCyKk41ImR+jeX5ExoYl8xE3oQSlDFjxryjQQcxQ
	s7a9fPIvq74L9z+bSr5QyldwCTd66pwCbwKjl6hNJA1st6/LKD1ycEccw==
X-ME-Sender: <xms:lso4ZcprAB2WbQyzsUVYTmJf25MhUXChjJGoXklZR5Dyw8_dxPnMOw>
    <xme:lso4ZSp9M4yo6-cW3mN0mUGZxuK5PPG4HzIV9d1e95ixcyy5_HWf-DZnNV61AMHcX
    _AN7CK4HMj2FiuqCw>
X-ME-Received: <xmr:lso4ZRNfeLrmO_q61Kl3oZI0Y8Ep1_MXrLvJ7eLljowYJEB2Tt4MldTr1LLaxWuNTq2fpiAQEIM0k6Pdf65oaOWh6sVCpjiTijTMQlqJv7krenQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeelgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lso4ZT75Eu-AWfTiwtGcH7X2BQTYqtBYCZZbIxMq-mBXWLsBdZdeKg>
    <xmx:lso4Zb6XbZz82kb-JvnAqjmY8BNFJfrRg_IwLONcPKFakwfxiwaHTg>
    <xmx:lso4ZTjsDDlb0H14UNCFblIioazvCB3ZSZ7xMSoG7lSZtjZu45xchA>
    <xmx:lso4Ze0RdEqm78LxoJEqmrjK5vMEfKU1oEkruYp-qL4kMcy273aUXw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Oct 2023 03:58:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd061893 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Oct 2023 07:58:07 +0000 (UTC)
Date: Wed, 25 Oct 2023 09:58:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZTjKk8E55M7lQN1m@tanuki>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZCS3jSAUCiYWttB7"
Content-Disposition: inline
In-Reply-To: <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>


--ZCS3jSAUCiYWttB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 06:45:06PM -0400, Taylor Blau wrote:
> When using merge-tree often within a repository[^1], it is possible to
> generate a relatively large number of loose objects, which can result in
> degraded performance, and inode exhaustion in extreme cases.
>=20
> Building on the functionality introduced in previous commits, the
> bulk-checkin machinery now has support to write arbitrary blob and tree
> objects which are small enough to be held in-core. We can use this to
> write any blob/tree objects generated by ORT into a separate pack
> instead of writing them out individually as loose.
>=20
> This functionality is gated behind a new `--write-pack` option to
> `merge-tree` that works with the (non-deprecated) `--write-tree` mode.
>=20
> The implementation is relatively straightforward. There are two spots
> within the ORT mechanism where we call `write_object_file()`, one for
> content differences within blobs, and another to assemble any new trees
> necessary to construct the merge. In each of those locations,
> conditionally replace calls to `write_object_file()` with
> `index_blob_bulk_checkin_incore()` or `index_tree_bulk_checkin_incore()`
> depending on which kind of object we are writing.
>=20
> The only remaining task is to begin and end the transaction necessary to
> initialize the bulk-checkin machinery, and move any new pack(s) it
> created into the main object store.
>=20
> [^1]: Such is the case at GitHub, where we run presumptive "test merges"
>   on open pull requests to see whether or not we can light up the merge
>   button green depending on whether or not the presumptive merge was
>   conflicted.
>=20
>   This is done in response to a number of user-initiated events,
>   including viewing an open pull request whose last test merge is stale
>   with respect to the current base and tip of the pull request. As a
>   result, merge-tree can be run very frequently on large, active
>   repositories.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-merge-tree.txt |  4 ++
>  builtin/merge-tree.c             |  5 ++
>  merge-ort.c                      | 42 +++++++++++----
>  merge-recursive.h                |  1 +
>  t/t4301-merge-tree-write-tree.sh | 93 ++++++++++++++++++++++++++++++++
>  5 files changed, 136 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> index ffc4fbf7e8..9d37609ef1 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -69,6 +69,10 @@ OPTIONS
>  	specify a merge-base for the merge, and specifying multiple bases is
>  	currently not supported. This option is incompatible with `--stdin`.
> =20
> +--write-pack::
> +	Write any new objects into a separate packfile instead of as
> +	individual loose objects.
> +
>  [[OUTPUT]]
>  OUTPUT
>  ------
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index a35e0452d6..218442ac9b 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -19,6 +19,7 @@
>  #include "tree.h"
>  #include "config.h"
>  #include "strvec.h"
> +#include "bulk-checkin.h"
> =20
>  static int line_termination =3D '\n';
> =20
> @@ -416,6 +417,7 @@ struct merge_tree_options {
>  	int name_only;
>  	int use_stdin;
>  	struct merge_options merge_options;
> +	int write_pack;
>  };
> =20
>  static int real_merge(struct merge_tree_options *o,
> @@ -441,6 +443,7 @@ static int real_merge(struct merge_tree_options *o,
>  				 _("not something we can merge"));
> =20
>  	opt.show_rename_progress =3D 0;
> +	opt.write_pack =3D o->write_pack;
> =20
>  	opt.branch1 =3D branch1;
>  	opt.branch2 =3D branch2;
> @@ -553,6 +556,8 @@ int cmd_merge_tree(int argc, const char **argv, const=
 char *prefix)
>  			   N_("specify a merge-base for the merge")),
>  		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=3Dvalue"),
>  			N_("option for selected merge strategy")),
> +		OPT_BOOL(0, "write-pack", &o.write_pack,
> +			 N_("write new objects to a pack instead of as loose")),
>  		OPT_END()
>  	};
> =20
> diff --git a/merge-ort.c b/merge-ort.c
> index 3653725661..523577d71e 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -48,6 +48,7 @@
>  #include "tree.h"
>  #include "unpack-trees.h"
>  #include "xdiff-interface.h"
> +#include "bulk-checkin.h"
> =20
>  /*
>   * We have many arrays of size 3.  Whenever we have such an array, the
> @@ -2108,10 +2109,19 @@ static int handle_content_merge(struct merge_opti=
ons *opt,
>  		if ((merge_status < 0) || !result_buf.ptr)
>  			ret =3D error(_("failed to execute internal merge"));
> =20
> -		if (!ret &&
> -		    write_object_file(result_buf.ptr, result_buf.size,
> -				      OBJ_BLOB, &result->oid))
> -			ret =3D error(_("unable to add %s to database"), path);
> +		if (!ret) {
> +			ret =3D opt->write_pack
> +				? index_blob_bulk_checkin_incore(&result->oid,
> +								 result_buf.ptr,
> +								 result_buf.size,
> +								 path, 1)
> +				: write_object_file(result_buf.ptr,
> +						    result_buf.size,
> +						    OBJ_BLOB, &result->oid);
> +			if (ret)
> +				ret =3D error(_("unable to add %s to database"),
> +					    path);
> +		}
> =20
>  		free(result_buf.ptr);
>  		if (ret)
> @@ -3597,7 +3607,8 @@ static int tree_entry_order(const void *a_, const v=
oid *b_)
>  				 b->string, strlen(b->string), bmi->result.mode);
>  }
> =20
> -static int write_tree(struct object_id *result_oid,
> +static int write_tree(struct merge_options *opt,
> +		      struct object_id *result_oid,
>  		      struct string_list *versions,
>  		      unsigned int offset,
>  		      size_t hash_size)
> @@ -3631,8 +3642,14 @@ static int write_tree(struct object_id *result_oid,
>  	}
> =20
>  	/* Write this object file out, and record in result_oid */
> -	if (write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid))
> +	ret =3D opt->write_pack
> +		? index_tree_bulk_checkin_incore(result_oid,
> +						 buf.buf, buf.len, "", 1)
> +		: write_object_file(buf.buf, buf.len, OBJ_TREE, result_oid);
> +
> +	if (ret)
>  		ret =3D -1;
> +
>  	strbuf_release(&buf);
>  	return ret;
>  }
> @@ -3797,8 +3814,8 @@ static int write_completed_directory(struct merge_o=
ptions *opt,
>  		 */
>  		dir_info->is_null =3D 0;
>  		dir_info->result.mode =3D S_IFDIR;
> -		if (write_tree(&dir_info->result.oid, &info->versions, offset,
> -			       opt->repo->hash_algo->rawsz) < 0)
> +		if (write_tree(opt, &dir_info->result.oid, &info->versions,
> +			       offset, opt->repo->hash_algo->rawsz) < 0)
>  			ret =3D -1;
>  	}
> =20
> @@ -4332,9 +4349,13 @@ static int process_entries(struct merge_options *o=
pt,
>  		fflush(stdout);
>  		BUG("dir_metadata accounting completely off; shouldn't happen");
>  	}
> -	if (write_tree(result_oid, &dir_metadata.versions, 0,
> +	if (write_tree(opt, result_oid, &dir_metadata.versions, 0,
>  		       opt->repo->hash_algo->rawsz) < 0)
>  		ret =3D -1;
> +
> +	if (opt->write_pack)
> +		end_odb_transaction();
> +
>  cleanup:
>  	string_list_clear(&plist, 0);
>  	string_list_clear(&dir_metadata.versions, 0);
> @@ -4878,6 +4899,9 @@ static void merge_start(struct merge_options *opt, =
struct merge_result *result)
>  	 */
>  	strmap_init(&opt->priv->conflicts);
> =20
> +	if (opt->write_pack)
> +		begin_odb_transaction();
> +
>  	trace2_region_leave("merge", "allocate/init", opt->repo);
>  }
> =20
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 3d3b3e3c29..5c5ff380a8 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -48,6 +48,7 @@ struct merge_options {
>  	unsigned renormalize : 1;
>  	unsigned record_conflict_msgs_as_headers : 1;
>  	const char *msg_header_prefix;
> +	unsigned write_pack : 1;
> =20
>  	/* internal fields used by the implementation */
>  	struct merge_options_internal *priv;
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> index b2c8a43fce..d2a8634523 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -945,4 +945,97 @@ test_expect_success 'check the input format when --s=
tdin is passed' '
>  	test_cmp expect actual
>  '
> =20
> +packdir=3D".git/objects/pack"
> +
> +test_expect_success 'merge-tree can pack its result with --write-pack' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	# base has lines [3, 4, 5]
> +	#   - side adds to the beginning, resulting in [1, 2, 3, 4, 5]
> +	#   - other adds to the end, resulting in [3, 4, 5, 6, 7]
> +	#
> +	# merging the two should result in a new blob object containing
> +	# [1, 2, 3, 4, 5, 6, 7], along with a new tree.
> +	test_commit -C repo base file "$(test_seq 3 5)" &&
> +	git -C repo branch -M main &&
> +	git -C repo checkout -b side main &&
> +	test_commit -C repo side file "$(test_seq 1 5)" &&
> +	git -C repo checkout -b other main &&
> +	test_commit -C repo other file "$(test_seq 3 7)" &&
> +
> +	find repo/$packdir -type f -name "pack-*.idx" >packs.before &&
> +	tree=3D"$(git -C repo merge-tree --write-pack \
> +		refs/tags/side refs/tags/other)" &&
> +	blob=3D"$(git -C repo rev-parse $tree:file)" &&
> +	find repo/$packdir -type f -name "pack-*.idx" >packs.after &&

While we do assert that we write a new packfile, we don't assert whether
parts of the written object may have been written as loose objects. Do
we want to tighten the checks to verify that?

Patrick

> +	test_must_be_empty packs.before &&
> +	test_line_count =3D 1 packs.after &&
> +
> +	git show-index <$(cat packs.after) >objects &&
> +	test_line_count =3D 2 objects &&
> +	grep "^[1-9][0-9]* $tree" objects &&
> +	grep "^[1-9][0-9]* $blob" objects
> +'
> +
> +test_expect_success 'merge-tree can write multiple packs with --write-pa=
ck' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +
> +		git config pack.packSizeLimit 512 &&
> +
> +		test_seq 512 >f &&
> +
> +		# "f" contains roughly ~2,000 bytes.
> +		#
> +		# Each side ("foo" and "bar") adds a small amount of data at the
> +		# beginning and end of "base", respectively.
> +		git add f &&
> +		test_tick &&
> +		git commit -m base &&
> +		git branch -M main &&
> +
> +		git checkout -b foo main &&
> +		{
> +			echo foo && cat f
> +		} >f.tmp &&
> +		mv f.tmp f &&
> +		git add f &&
> +		test_tick &&
> +		git commit -m foo &&
> +
> +		git checkout -b bar main &&
> +		echo bar >>f &&
> +		git add f &&
> +		test_tick &&
> +		git commit -m bar &&
> +
> +		find $packdir -type f -name "pack-*.idx" >packs.before &&
> +		# Merging either side should result in a new object which is
> +		# larger than 1M, thus the result should be split into two
> +		# separate packs.
> +		tree=3D"$(git merge-tree --write-pack \
> +			refs/heads/foo refs/heads/bar)" &&
> +		blob=3D"$(git rev-parse $tree:f)" &&
> +		find $packdir -type f -name "pack-*.idx" >packs.after &&
> +
> +		test_must_be_empty packs.before &&
> +		test_line_count =3D 2 packs.after &&
> +		for idx in $(cat packs.after)
> +		do
> +			git show-index <$idx || return 1
> +		done >objects &&
> +
> +		# The resulting set of packs should contain one copy of both
> +		# objects, each in a separate pack.
> +		test_line_count =3D 2 objects &&
> +		grep "^[1-9][0-9]* $tree" objects &&
> +		grep "^[1-9][0-9]* $blob" objects
> +
> +	)
> +'
> +
>  test_done
> --=20
> 2.42.0.425.g963d08ddb3.dirty

--ZCS3jSAUCiYWttB7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU4ypIACgkQVbJhu7ck
PpQHpg//b7k2SnR8ChnRP4IZmrQQODPOlKSGM6L+McIdii7P4WZerqT/dr/O/b+p
uHSoW5xp///vyfM8gCOMaBI2O85IH/b7xTOSuYce90D6afndD96PcQS1/sV5p6vn
mFzFYqH2odqqzQ8F10Aig5Q2AVeKu/7Dd/Qjc12/gcegtZKRMI8qszmRgR3MYBTD
WOBtcTZNerkRGUb3sLftbEvgLamU2WGflR3uFDsGimC/ktluuRZYyH4P3JOHB5VC
AFXjHdantFcXn1bNCwTOUwn/bNTgQ9eQxUkrNqlyAUI+2lIJOHOG/Ic7KrErK6zx
T0xtVGEsIiq3yThOE3dTfbCUKIpPG8vXahEe7x4IKp15SagX9jmTl4aFwNoIvksc
JBsNwbZTvzlPKWb6kuxdfPfkyr17U1SwZro9Iv2iR/8Gpm4X3FQbzOBw2j0RNarG
Uno1MTCcCPTMibSmSP8WaDOfxpRf8fRy/IKWwWQ8rZWeGm6B9l3GsXlAxkCiGt/V
TayTKBlBAByizaBPO16ZcH3nxmpmAudJ9n3KVkF/B6+AV7KhUVpyVPdX34dwPARE
HcDcra/5ZFxkMhiEAzAEZDwH297SVxAAqHd0+ohDcHHZ+Sg4WG1Xav0wnGL2KNvY
IKpzFgS/6kGBWbNKJLOLrHXidIu7ApGzBCpuj5xURQJs4iOlPc4=
=z0ON
-----END PGP SIGNATURE-----

--ZCS3jSAUCiYWttB7--
