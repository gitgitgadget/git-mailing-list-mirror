Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8772D030
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCLbcncr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tAUJM1G6"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D6A3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:50:06 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 91A4232009D1;
	Tue,  7 Nov 2023 05:50:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Nov 2023 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354205; x=1699440605; bh=hY
	RM64Fl/bqemWqTW301iKLqIECm1muQs6A5Tdg/0rM=; b=JCLbcncrTLEoqsAyeN
	qOQE9qeDd1JaAx20Bstuo4BRgcen4420fz/2Qjl9i+jBam0fV8qk+ooFU5iE0fev
	My7dgwVxAUPoDuOCrc2U2Kfz/W0NXHgDm3K9+7N/3rFZ8TOhDKsnZwuJh++QPdbn
	zwmLCJPJxLr8rneSHDEb1OlcviCu6Nfb46ynReLrZz9Kn0Mx1u31B5G/YRTc0HuY
	VDNMwdL7V+3HNpqOw8mwFz0HRSljnIugCfG2wojaBUR4IxDVHzhFEhzyekk29HTd
	I9LdCNE3FAr/kFvZSiFk1gA2+etM+HoYkwOnlBH0zpRktyPlZZ+iu1UdN6IJOU2W
	3qIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354205; x=1699440605; bh=hYRM64Fl/bqem
	WqTW301iKLqIECm1muQs6A5Tdg/0rM=; b=tAUJM1G67CZghtjfH5kgZpmHOu4EY
	jsRP61E4uXG/3Xrwc6veIlK2uCu5/AQ8bezmJTXNsLRT+ELjebKDs6HnEoX8EASV
	HChDi5AvSpquZ92wVkMWZXe1DN0ZV5mAEjkVLAy1IZPawlRyxrzfoeIAxpxSN94f
	OuJvy96JOAOSH/tdmDm7+kPqtacq/YB+C30qJMSWmhcY7uPKqDyfhO43bRv3u2e9
	VLOcb5okSyQbunriPfYjZsuDym1Vzp0+Upz9iheerx0HMw6wv46OEYN1cFPvmtK/
	rjsDTeF1Xfn5iQ4U8QnsANe+l/QnHpq9aHd+jWEQYm0jIJAXWnpRQU58A==
X-ME-Sender: <xms:XBZKZbGm624kBzzWNFnNhC3K7CPvKoOc7S_NBkxzy6on0_PZg55aQQ>
    <xme:XBZKZYUbO2PGNjEFOnIqeriDOM3mkl2bOrnEOp7tolTnxfntPZ7sS32mXhmGeXWf8
    6vI0LbxZzt7FkF8fw>
X-ME-Received: <xmr:XBZKZdKN4AZGb7OTUTQcTHX9eDd4cdZGtgaprBSiq13cpy2V0zNDDqzs0Ha5JqAuWHvNXyuhpjdQoJA7RDWDdoDwDYtHQhRyWZBTSaKFG9Ux3UX4qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XBZKZZF6gst4Pe6Be4Qb3fZYIVGQAXGAYKxMXz3deai6e4XWA8Tdug>
    <xmx:XBZKZRU6nNhySh4iHDNHlA6d-MJWMMJDsLbinIeVLkjRvClxAc_ivg>
    <xmx:XBZKZUM19thLvs6PILvU3ihlfvFXQ6KsrckVUoNzC3jqDuRWGevyBQ>
    <xmx:XRZKZQfnPSejPV5_W41gt05PLZe3Hl08x7ajaGDjBj4adVKcUV1u8Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:50:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa77a0af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:41 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:50:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 8/9] for-each-ref: add option to fully dereference tags
Message-ID: <ZUoWWo7IEKsiSx-C@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h9u4CUkJrJGx1jk+"
Content-Disposition: inline
In-Reply-To: <352b5c42ac39d5d2646a1b6d47d6d707637db539.1699320362.git.gitgitgadget@gmail.com>


--h9u4CUkJrJGx1jk+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:26:00AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Add a boolean flag '--full-deref' that, when enabled, fills '%(*fieldname=
)'
> format fields using the fully peeled target of tag objects, rather than t=
he
> immediate target.
>=20
> In other builtins ('rev-parse', 'show-ref'), "dereferencing" tags typical=
ly
> means peeling them down to their non-tag target. Unlike these commands,
> 'for-each-ref' dereferences only one "level" of tags in '*' format fields
> (like "%(*objectname)"). For most annotated tags, one level of dereferenc=
ing
> is enough, since most tags point to commits or trees. However, nested tags
> (annotated tags whose target is another annotated tag) dereferenced once
> will point to their target tag, different a full peel to e.g. a commit.
>=20
> Currently, if a user wants to filter & format refs and include information
> about the fully dereferenced tag, they can do so with something like
> 'cat-file --batch-check':
>=20
>     git for-each-ref --format=3D"%(objectname)^{} %(refname)" <pattern> |
>         git cat-file --batch-check=3D"%(objectname) %(rest)"
>=20
> But the combination of commands is inefficient. So, to improve the
> efficiency of this use case, add a '--full-deref' option that causes
> 'for-each-ref' to fully dereference tags when formatting with '*' fields.

I do wonder whether it would make sense to introduce this feature in the
form of a separate field prefix, as you also mentioned in your cover
letter. It would buy the user more flexibility, but the question is
whether such flexibility would really ever be needed.

The only thing I could really think of where it might make sense is to
distinguish tags that peel to a commit immediately from ones that don't.
That feels rather esoteric to me and doesn't seem to be of much use. But
regardless of whether or not we can see the usefulness now, if this
wouldn't be significantly more complex I wonder whether it would make
more sense to use a new field prefix instead anyway.

In any case, I think it would be helpful if this was discussed in the
commit message.

Patrick

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  Documentation/git-for-each-ref.txt |  9 ++++++++
>  builtin/for-each-ref.c             |  2 ++
>  ref-filter.c                       | 26 ++++++++++++++---------
>  ref-filter.h                       |  1 +
>  t/t6300-for-each-ref.sh            | 34 ++++++++++++++++++++++++++++++
>  5 files changed, 62 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-e=
ach-ref.txt
> index 407f624fbaa..2714a87088e 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=3D<key>)...] [--format=3D<format>]
>  		   [ --stdin | <pattern>... ]
> +		   [--full-deref]
>  		   [--points-at=3D<object>]
>  		   [--merged[=3D<object>]] [--no-merged[=3D<object>]]
>  		   [--contains[=3D<object>]] [--no-contains[=3D<object>]]
> @@ -77,6 +78,14 @@ OPTIONS
>  	the specified host language.  This is meant to produce
>  	a scriptlet that can directly be `eval`ed.
> =20
> +--full-deref::
> +	Populate dereferenced format fields (indicated with an asterisk (`*`)
> +	prefix before the fieldname) with information about the fully-peeled
> +	target object of a tag ref, rather than its immediate target object.
> +	This only affects the output for nested annotated tags, where the tag's
> +	immediate target is another tag but its fully-peeled target is another
> +	object type (e.g. a commit).
> +
>  --points-at=3D<object>::
>  	Only list refs which points at the given object.
> =20
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1c19cd5bd34..7a2127a3bc4 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -43,6 +43,8 @@ int cmd_for_each_ref(int argc, const char **argv, const=
 char *prefix)
>  		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only =
<n> matched refs")),
>  		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to=
 use for the output")),
>  		OPT__COLOR(&format.use_color, N_("respect format colors")),
> +		OPT_BOOL(0, "full-deref", &format.full_deref,
> +			 N_("fully dereference tags to populate '*' format fields")),
>  		OPT_REF_FILTER_EXCLUDE(&filter),
>  		OPT_REF_SORT(&sorting_options),
>  		OPT_CALLBACK(0, "points-at", &filter.points_at,
> diff --git a/ref-filter.c b/ref-filter.c
> index 384cf1595ff..a66ac7921b1 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -237,7 +237,14 @@ static struct used_atom {
>  		char *head;
>  	} u;
>  } *used_atom;
> -static int used_atom_cnt, need_tagged, need_symref;
> +static int used_atom_cnt, need_symref;
> +
> +enum tag_dereference_mode {
> +	NO_DEREF =3D 0,
> +	DEREF_ONE,
> +	DEREF_ALL
> +};
> +static enum tag_dereference_mode need_tagged;
> =20
>  /*
>   * Expand string, append it to strbuf *sb, then return error code ret.
> @@ -1066,8 +1073,8 @@ static int parse_ref_filter_atom(struct ref_format =
*format,
>  	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
>  	if (valid_atom[i].parser && valid_atom[i].parser(format, &used_atom[at]=
, arg, err))
>  		return -1;
> -	if (*atom =3D=3D '*')
> -		need_tagged =3D 1;
> +	if (*atom =3D=3D '*' && !need_tagged)
> +		need_tagged =3D format->full_deref ? DEREF_ALL : DEREF_ONE;
>  	if (i =3D=3D ATOM_SYMREF)
>  		need_symref =3D 1;
>  	return at;
> @@ -2511,14 +2518,13 @@ static int populate_value(struct ref_array_item *=
ref, struct strbuf *err)
>  	 * If it is a tag object, see if we use a value that derefs
>  	 * the object, and if we do grab the object it refers to.
>  	 */
> -	oi_deref.oid =3D *get_tagged_oid((struct tag *)obj);
> +	if (need_tagged =3D=3D DEREF_ALL) {
> +		if (peel_iterated_oid(&obj->oid, &oi_deref.oid))
> +			die("bad tag");
> +	} else {
> +		oi_deref.oid =3D *get_tagged_oid((struct tag *)obj);
> +	}
> =20
> -	/*
> -	 * NEEDSWORK: This derefs tag only once, which
> -	 * is good to deal with chains of trust, but
> -	 * is not consistent with what deref_tag() does
> -	 * which peels the onion to the core.
> -	 */
>  	return get_object(ref, 1, &obj, &oi_deref, err);
>  }
> =20
> diff --git a/ref-filter.h b/ref-filter.h
> index 0ce5af58ab3..0caa39ecee5 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -92,6 +92,7 @@ struct ref_format {
>  	const char *rest;
>  	int quote_style;
>  	int use_color;
> +	int full_deref;
> =20
>  	/* Internal state to ref-filter */
>  	int need_color_reset_at_eol;
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 0613e5e3623..3c2af785cdb 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1839,6 +1839,40 @@ test_expect_success 'git for-each-ref with non-exi=
sting refs' '
>  	test_must_be_empty actual
>  '
> =20
> +test_expect_success 'git for-each-ref with nested tags' '
> +	git tag -am "Normal tag" nested/base HEAD &&
> +	git tag -am "Nested tag" nested/nest1 refs/tags/nested/base &&
> +	git tag -am "Double nested tag" nested/nest2 refs/tags/nested/nest1 &&
> +
> +	head_oid=3D"$(git rev-parse HEAD)" &&
> +	base_tag_oid=3D"$(git rev-parse refs/tags/nested/base)" &&
> +	nest1_tag_oid=3D"$(git rev-parse refs/tags/nested/nest1)" &&
> +	nest2_tag_oid=3D"$(git rev-parse refs/tags/nested/nest2)" &&
> +
> +	# Without full dereference
> +	cat >expect <<-EOF &&
> +	refs/tags/nested/base $base_tag_oid tag $head_oid commit
> +	refs/tags/nested/nest1 $nest1_tag_oid tag $base_tag_oid tag
> +	refs/tags/nested/nest2 $nest2_tag_oid tag $nest1_tag_oid tag
> +	EOF
> +
> +	git for-each-ref --format=3D"%(refname) %(objectname) %(objecttype) %(*=
objectname) %(*objecttype)" \
> +		refs/tags/nested/ >actual &&
> +	test_cmp expect actual &&
> +
> +	# With full dereference
> +	cat >expect <<-EOF &&
> +	refs/tags/nested/base $base_tag_oid tag $head_oid commit
> +	refs/tags/nested/nest1 $nest1_tag_oid tag $head_oid commit
> +	refs/tags/nested/nest2 $nest2_tag_oid tag $head_oid commit
> +	EOF
> +
> +	git for-each-ref --full-deref \
> +		--format=3D"%(refname) %(objectname) %(objecttype) %(*objectname) %(*o=
bjecttype)" \
> +		refs/tags/nested/ >actual &&
> +	test_cmp expect actual
> +'
> +
>  GRADE_FORMAT=3D"%(signature:grade)%0a%(signature:key)%0a%(signature:sign=
er)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprint)"
>  TRUSTLEVEL_FORMAT=3D"%(signature:trustlevel)%0a%(signature:key)%0a%(sign=
ature:signer)%0a%(signature:fingerprint)%0a%(signature:primarykeyfingerprin=
t)"
> =20
> --=20
> gitgitgadget
>=20
>=20

--h9u4CUkJrJGx1jk+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFlkACgkQVbJhu7ck
PpT9TA/+MamsJyS67KgsxS+CcG6s1Kbo6MnKtZYEMDwBHwf/WyhEyrgCSlXewlly
p5cOqET9Z+HTMWM+v9WsLJIRj6IQ2ibAKLsxxItI1j8sK9ju3vU1aoY3QOR1kJTd
wxVZ+cL/TynHiY6hfrEepbyFb4nEt2D2WEcJ5gTRK2auB05blf2yi+et1F/wLsJs
gWB+iwwb9hfpc+myIdUJSO4pSwqSBYqQKnv5QNHj/tJ52WLRFj+sFPlBcEIpVXNo
O9hw2YjJsLrp+Jic2i+jT2ozJKJRALgAGnnLgUoD2TZWuzI7/tzFlBHYBCy4i/Nz
SwXMAqnujJ15CK2o1fdrrdAq766FXVGqP6KlZnahU7oYWYwsP0En9Icx14SJYhT4
vNM17FoorxUoC8OvsMWfFZYz3+Ypur2tg1TjJkrhequCm7cJLlroBoX2MfSlXoFz
PbqZLC25lSQXLqQT5ARgaogs1W1zlGTAAaGW8jX0D9uJFKHdP95vNTmfciIlQou5
2jUs/toXOSyO/wAQJpFT5JzMo5DGyp0snDFRVMJnf9EG8jTcTFRY6XPgwTQtLZB9
E0DDEATm7rqKGxSlVkUQRG4LEH1jeQv+khwlyxpOPJABenNmKM4MSMqir9Lge192
VjJdLj7Ed2x0bWRse834PN0YP2G/Rtodu4BOJSOuKWREH17tpLs=
=/OOf
-----END PGP SIGNATURE-----

--h9u4CUkJrJGx1jk+--
