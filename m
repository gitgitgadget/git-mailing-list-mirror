Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7029424
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lcwUypeg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JvnQEwA5"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24896F7
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:49:45 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 6A41C32009E1;
	Tue,  7 Nov 2023 05:49:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 Nov 2023 05:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699354183; x=1699440583; bh=4G
	vpnbXdbFMgkXxAWzAfwOBxqItuSUFlwJKTv1jpWc8=; b=lcwUypegCcgCmY/ZY1
	RIZUty+8WdvO5TQXOzMQooUDgxMx8IDFz+yFuw2cvupDONQoDiVylj+/upY+sMaz
	nE/BBVM5HioHv4lqiRGVRk5XH9TcuaFoSTUo+9PIvDXHWv2/bm5VoWfW+RcExPCy
	R5dv+ukcCoCbXxd34smNLglxyLwtTpE5siHSizyDUNxjDAwfCXpeSwk/qFAhLMcj
	vImPc3zgobIzNThSW2eze0SiGS4VJkyaB8AhF9srBvTqHHCTbLveyWzhlgjksIdp
	A4pEaiWrfRhulMi0mbpvF28dXV3060E/uT/jukaxJhuJwf0n7/QKZ248r0Fv/Pvl
	VIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699354183; x=1699440583; bh=4GvpnbXdbFMgk
	XxAWzAfwOBxqItuSUFlwJKTv1jpWc8=; b=JvnQEwA5JqAK4NSK0cp8lO19gjlZu
	WffLCeGG7UxoTXbSGhogCkUxdhf5vaCZLOr5yseum4eLI6e7P5h4y1q/D9cpJSof
	uKkuOLUejE2oxKm/fO20vHeybZoWjRek6ipIZoHrXkdJ8h72zlJHuD72ys9qBEyc
	VpVApfIxZqdl0nC4z38dxOMhc9YNcpl8tlnNXRUQ+K+NERrxJJuZVKkiWdvsvBHS
	ps3NA7Zx4xO+rACzNxhP+epSRv0dlnm6h78JIFN1SysMd/aOQDv88gWkPv/kLmKv
	p4kLbKeqGCKhB78ZSpVnDawvuzvBBTjaL+1NFwH6TubJjxEpZMRvdfEvw==
X-ME-Sender: <xms:RxZKZSBorkMnzrjx3qPhMH51DZmRv9PXwEYBHJsfH9kqJEQXR3eObA>
    <xme:RxZKZcgxRYgDTnvfyg84gQpiU87fmpF-R8B6ArZbCIFPbBEawbrHc93qnSRbrjNVB
    v_BepdgZol1pu0_VQ>
X-ME-Received: <xmr:RxZKZVk68Hu4d2ZZkjuQSx1j0Oyaf0x_XZUYp84G6tLfH9DJ0ZI9CJd70D_Wg1sTFZitteCu425zQG0kKNw9x97aO-u345OTiLAL7xf1IQjnCRvrmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RxZKZQw6pNbcSRkHKLOKqZagNCrSG_AwQxVQgZAwkSLs3Dp0xKRE6Q>
    <xmx:RxZKZXRDZxeed0SdaMmxK3vxZsgYZnmybNhQb55dJLc0lbk-Zs42oA>
    <xmx:RxZKZbaMaAXkhZN8xU-PujJ5Rk_5HEZ4wTZyGLrnrmW5xq2c7JjmqQ>
    <xmx:RxZKZeL6S57Z5VmjJ6nZuvauX1BN5GbacfBUY1VBTOv8BCAFU_5maQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 05:49:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a7f9167a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Nov 2023 10:49:20 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:49:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/9] ref-filter.c: really don't sort when using --no-sort
Message-ID: <ZUoWRZcD0xyfgVnc@tanuki>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
 <dea8d7d1e866d9784320051b372ff729fca855d7.1699320362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QkrSG3Kag9C2FXo2"
Content-Disposition: inline
In-Reply-To: <dea8d7d1e866d9784320051b372ff729fca855d7.1699320362.git.gitgitgadget@gmail.com>


--QkrSG3Kag9C2FXo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:25:53AM +0000, Victoria Dye via GitGitGadget wro=
te:
> From: Victoria Dye <vdye@github.com>
>=20
> Update 'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if
> the string list provided to it is empty, rather than returning the default
> refname sort structure. Also update 'ref_array_sort()' to explicitly skip
> sorting if its 'struct ref_sorting *' arg is NULL. Other functions using
> 'struct ref_sorting *' do not need any changes because they already prope=
rly
> ignore NULL values.
>=20
> The goal of this change is to have the '--no-sort' option truly disable
> sorting in commands like 'for-each-ref, 'tag', and 'branch'. Right now,
> '--no-sort' will still trigger refname sorting by default in 'for-each-re=
f',
> 'tag', and 'branch'.
>=20
> To match existing behavior as closely as possible, explicitly add "refnam=
e"
> to the list of sort keys in 'for-each-ref', 'tag', and 'branch' before
> parsing options (if no config-based sort keys are set). This ensures that
> sorting will only be fully disabled if '--no-sort' is provided as an opti=
on;
> otherwise, "refname" sorting will remain the default. Note: this also mea=
ns
> that even when sort keys are provided on the command line, "refname" will=
 be
> the final sort key in the sorting structure. This doesn't actually change
> any behavior, since 'compare_refs()' already falls back on comparing
> refnames if two refs are equal w.r.t all other sort keys.
>=20
> Finally, remove the condition around sorting in 'ls-remote', since it's no
> longer necessary. Unlike 'for-each-ref' et. al., it does *not* set any so=
rt
> keys by default. The default empty list of sort keys will produce a NULL
> 'struct ref_sorting *', which causes the sorting to be skipped in
> 'ref_array_sort()'.

I found the order in this commit message a bit funny because you first
explain what you're doing, then explain the goal, and then jump into the
changes again. The message might be a bit easier to read if the goal was
stated up front.

I was also briefly wondering whether it would make sense to split up
this commit, as you're doing two different things:

    - Refactor how git-for-each-ref(1), git-tag(1) and git-branch(1) set
      up their default sorting.

    - Change `ref_array_sort()` to not sort when its sorting option is
      `NULL`.

If this was split up into two commits, then the result might be a bit
easier to reason about. But I don't feel strongly about this.

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/branch.c        |  6 ++++
>  builtin/for-each-ref.c  |  3 ++
>  builtin/ls-remote.c     | 10 ++----
>  builtin/tag.c           |  6 ++++
>  ref-filter.c            | 19 ++----------
>  t/t3200-branch.sh       | 68 +++++++++++++++++++++++++++++++++++++++--
>  t/t6300-for-each-ref.sh | 21 +++++++++++++
>  t/t7004-tag.sh          | 45 +++++++++++++++++++++++++++
>  8 files changed, 152 insertions(+), 26 deletions(-)
>=20
> diff --git a/builtin/branch.c b/builtin/branch.c
> index e7ee9bd0f15..d67738bbcaa 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -767,7 +767,13 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
>  	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_branch_usage, options);
> =20
> +	/*
> +	 * Try to set sort keys from config. If config does not set any,
> +	 * fall back on default (refname) sorting.
> +	 */
>  	git_config(git_branch_config, &sorting_options);
> +	if (!sorting_options.nr)
> +		string_list_append(&sorting_options, "refname");
> =20
>  	track =3D git_branch_track;
> =20
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 350bfa6e811..93b370f550b 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -67,6 +67,9 @@ int cmd_for_each_ref(int argc, const char **argv, const=
 char *prefix)
> =20
>  	git_config(git_default_config, NULL);
> =20
> +	/* Set default (refname) sorting */
> +	string_list_append(&sorting_options, "refname");
> +
>  	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
>  	if (maxcount < 0) {
>  		error("invalid --count argument: `%d'", maxcount);
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index fc765754305..436249b720c 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -58,6 +58,7 @@ int cmd_ls_remote(int argc, const char **argv, const ch=
ar *prefix)
>  	struct transport *transport;
>  	const struct ref *ref;
>  	struct ref_array ref_array;
> +	struct ref_sorting *sorting;
>  	struct string_list sorting_options =3D STRING_LIST_INIT_DUP;
> =20
>  	struct option options[] =3D {
> @@ -141,13 +142,8 @@ int cmd_ls_remote(int argc, const char **argv, const=
 char *prefix)
>  		item->symref =3D xstrdup_or_null(ref->symref);
>  	}
> =20
> -	if (sorting_options.nr) {
> -		struct ref_sorting *sorting;
> -
> -		sorting =3D ref_sorting_options(&sorting_options);
> -		ref_array_sort(sorting, &ref_array);
> -		ref_sorting_release(sorting);
> -	}
> +	sorting =3D ref_sorting_options(&sorting_options);
> +	ref_array_sort(sorting, &ref_array);

We stopped calling `ref_sorting_release()`. Doesn't that cause us to
leak memory?

>  	for (i =3D 0; i < ref_array.nr; i++) {
>  		const struct ref_array_item *ref =3D ref_array.items[i];
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 3918eacbb57..64f3196cd4c 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -501,7 +501,13 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
> =20
>  	setup_ref_filter_porcelain_msg();
> =20
> +	/*
> +	 * Try to set sort keys from config. If config does not set any,
> +	 * fall back on default (refname) sorting.
> +	 */
>  	git_config(git_tag_config, &sorting_options);
> +	if (!sorting_options.nr)
> +		string_list_append(&sorting_options, "refname");
> =20
>  	memset(&opt, 0, sizeof(opt));
>  	filter.lines =3D -1;
> diff --git a/ref-filter.c b/ref-filter.c
> index e4d3510e28e..7250089b7c6 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3142,7 +3142,8 @@ void ref_sorting_set_sort_flags_all(struct ref_sort=
ing *sorting,
> =20
>  void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  {
> -	QSORT_S(array->items, array->nr, compare_refs, sorting);
> +	if (sorting)
> +		QSORT_S(array->items, array->nr, compare_refs, sorting);
>  }
> =20
>  static void append_literal(const char *cp, const char *ep, struct ref_fo=
rmatting_state *state)
> @@ -3248,18 +3249,6 @@ static int parse_sorting_atom(const char *atom)
>  	return res;
>  }
> =20
> -/*  If no sorting option is given, use refname to sort as default */
> -static struct ref_sorting *ref_default_sorting(void)
> -{
> -	static const char cstr_name[] =3D "refname";
> -
> -	struct ref_sorting *sorting =3D xcalloc(1, sizeof(*sorting));
> -
> -	sorting->next =3D NULL;
> -	sorting->atom =3D parse_sorting_atom(cstr_name);
> -	return sorting;
> -}
> -
>  static void parse_ref_sorting(struct ref_sorting **sorting_tail, const c=
har *arg)
>  {
>  	struct ref_sorting *s;
> @@ -3283,9 +3272,7 @@ struct ref_sorting *ref_sorting_options(struct stri=
ng_list *options)
>  	struct string_list_item *item;
>  	struct ref_sorting *sorting =3D NULL, **tail =3D &sorting;
> =20
> -	if (!options->nr) {
> -		sorting =3D ref_default_sorting();
> -	} else {
> +	if (options->nr) {
>  		for_each_string_list_item(item, options)
>  			parse_ref_sorting(tail, item->string);
>  	}
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 3182abde27f..9918ba05dec 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1570,9 +1570,10 @@ test_expect_success 'tracking with unexpected .fet=
ch refspec' '
> =20
>  test_expect_success 'configured committerdate sort' '
>  	git init -b main sort &&
> +	test_config -C sort branch.sort "committerdate" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort committerdate &&
>  		test_commit initial &&
>  		git checkout -b a &&
>  		test_commit a &&
> @@ -1592,9 +1593,10 @@ test_expect_success 'configured committerdate sort=
' '
>  '
> =20
>  test_expect_success 'option override configured sort' '
> +	test_config -C sort branch.sort "committerdate" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort committerdate &&
>  		git branch --sort=3Drefname >actual &&
>  		cat >expect <<-\EOF &&
>  		  a
> @@ -1606,10 +1608,70 @@ test_expect_success 'option override configured s=
ort' '
>  	)
>  '
> =20
> +test_expect_success '--no-sort cancels config sort keys' '
> +	test_config -C sort branch.sort "-refname" &&
> +
> +	(
> +		cd sort &&
> +
> +		# objecttype is identical for all of them, so sort falls back on
> +		# default (ascending refname)
> +		git branch \
> +			--no-sort \
> +			--sort=3D"objecttype" >actual &&

This test is a bit confusing to me. Shouldn't we in fact ignore the
configured sorting order as soon as we pass `--sort=3D` anyway? In other
words, I would expect the `--no-sort` option to not make a difference
here. What should make a difference is if you _only_ passed `--no-sort`.

> +		cat >expect <<-\EOF &&
> +		  a
> +		* b
> +		  c
> +		  main
> +		EOF
> +		test_cmp expect actual
> +	)
> +
> +'
> +
> +test_expect_success '--no-sort cancels command line sort keys' '
> +	(
> +		cd sort &&
> +
> +		# objecttype is identical for all of them, so sort falls back on
> +		# default (ascending refname)
> +		git branch \
> +			--sort=3D"-refname" \
> +			--no-sort \
> +			--sort=3D"objecttype" >actual &&
> +		cat >expect <<-\EOF &&
> +		  a
> +		* b
> +		  c
> +		  main
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '--no-sort without subsequent --sort prints expected=
 branches' '
> +	(
> +		cd sort &&
> +
> +		# Sort the results with `sort` for a consistent comparison
> +		# against expected
> +		git branch --no-sort | sort >actual &&
> +		cat >expect <<-\EOF &&
> +		  a
> +		  c
> +		  main
> +		* b
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'invalid sort parameter in configuration' '
> +	test_config -C sort branch.sort "v:notvalid" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort "v:notvalid" &&
> =20
>  		# this works in the "listing" mode, so bad sort key
>  		# is a dying offence.
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 00a060df0b5..0613e5e3623 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -1335,6 +1335,27 @@ test_expect_success '--no-sort cancels the previou=
s sort keys' '
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success '--no-sort without subsequent --sort prints expected=
 refs' '
> +	cat >expected <<-\EOF &&
> +	refs/tags/multi-ref1-100000-user1
> +	refs/tags/multi-ref1-100000-user2
> +	refs/tags/multi-ref1-200000-user1
> +	refs/tags/multi-ref1-200000-user2
> +	refs/tags/multi-ref2-100000-user1
> +	refs/tags/multi-ref2-100000-user2
> +	refs/tags/multi-ref2-200000-user1
> +	refs/tags/multi-ref2-200000-user2
> +	EOF
> +
> +	# Sort the results with `sort` for a consistent comparison against
> +	# expected
> +	git for-each-ref \
> +		--format=3D"%(refname)" \
> +		--no-sort \
> +		"refs/tags/multi-*" | sort >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'do not dereference NULL upon %(HEAD) on unborn bran=
ch' '
>  	test_when_finished "git checkout main" &&
>  	git for-each-ref --format=3D"%(HEAD) %(refname:short)" refs/heads/ >act=
ual &&
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index e689db42929..b41a47eb943 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1862,6 +1862,51 @@ test_expect_success 'option override configured so=
rt' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success '--no-sort cancels config sort keys' '
> +	test_config tag.sort "-refname" &&
> +
> +	# objecttype is identical for all of them, so sort falls back on
> +	# default (ascending refname)
> +	git tag -l \
> +		--no-sort \
> +		--sort=3D"objecttype" \
> +		"foo*" >actual &&
> +	cat >expect <<-\EOF &&
> +	foo1.10
> +	foo1.3
> +	foo1.6
> +	EOF
> +	test_cmp expect actual
> +'

Same question here.

Patrick

> +test_expect_success '--no-sort cancels command line sort keys' '
> +	# objecttype is identical for all of them, so sort falls back on
> +	# default (ascending refname)
> +	git tag -l \
> +		--sort=3D"-refname" \
> +		--no-sort \
> +		--sort=3D"objecttype" \
> +		"foo*" >actual &&
> +	cat >expect <<-\EOF &&
> +	foo1.10
> +	foo1.3
> +	foo1.6
> +	EOF
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--no-sort without subsequent --sort prints expected=
 tags' '
> +	# Sort the results with `sort` for a consistent comparison against
> +	# expected
> +	git tag -l --no-sort "foo*" | sort >actual &&
> +	cat >expect <<-\EOF &&
> +	foo1.10
> +	foo1.3
> +	foo1.6
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'invalid sort parameter on command line' '
>  	test_must_fail git tag -l --sort=3Dnotvalid "foo*" >actual
>  '
> --=20
> gitgitgadget
>=20
>=20

--QkrSG3Kag9C2FXo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVKFkQACgkQVbJhu7ck
PpSv4w/8D3dUBncQXMUwhOpXeAIgyBEkKQUrdwSan/dL5EyYoxVxBfsP7WfTHCW8
+6mguuoyzD+XDMkYy9x92BydQeu6m3qNLtsQxAiwoH1TfMGKyJ5EPAHt0GJSLfBn
tMuHculmPYLibQzmqPXhMox6q8PyHU6crZZHCrtJU11lLfB/iM3MP7MmjOgW4tI0
ZZMSQqiIIJhvGLuG6zmKqz6CXULx4Xq6zXzwAFb86l/fNZkdYrU4CjVbbR0itK/d
XLisHjxEZNEksC6Lpjr6jw6B0i9VDIz3WDaruLUdhxL5QguHVGxOoIQUDndyd7Js
EqIUmfz/hbYJULIRYU2IKGIPDYAWWdJDj5WX3ASBz2wARJrlSg+StW6Je2oJcIPe
YZwOkGJ3UfzVU1qZkpwTCP/77c1cB87QxLg0NTPvnZD0H7OL1fiZtDdiRjru4aZh
Yvtkl1ulTRH27JftE+TKLZDXk/QVFrzBgW3kw3XqQ6h1Ldl/oKG8ZUjeDufNHE1r
JncMB1FdYfTb3ntK4no4zF1hm2rgUTz/DmstVCjom8aqnYXsHmB/s0VuleDWl4Pr
Wywb22MqWrLu3ZaHrkiPinsoaEQYkOc9EifIZ1/mqr8GJ/cVzSWePAxdgE/dy1sA
yicU+NXxgtBOnA4C7c3S+I1PoeFWdTAN3U2zTGBcLZqMINdvU14=
=KxYe
-----END PGP SIGNATURE-----

--QkrSG3Kag9C2FXo2--
