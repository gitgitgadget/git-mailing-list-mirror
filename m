Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRDXxy52";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uc5QnlDo"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A2A121
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:14:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 9ABA6320092C;
	Thu,  7 Dec 2023 03:14:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 07 Dec 2023 03:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701936885; x=1702023285; bh=vY
	aaWyrgmv1cThhlPjqQ6FAC8iMzv2EDGXIHj8Sh7S4=; b=GRDXxy52gvIivzHVGr
	sYqv/oZ29equTHwRn3nRoLJ/vX1LE4BYTbkDkMKqWBirL7ToWYgkVdEM2uNHsMki
	pkSLStY1q7t+783EiGeVyMYg4lDNtTAeZOkhY4joHYdAati90dEXBKHVbnrOuS2R
	U4vaAtOy+kD3u0VbNhje4IUFNFwg9E2P+pTX9YkJS1iukdHeHDrjVo/6ySgCCobb
	Q0L+sUsmb6544H9aphuHD0hOKHk3Gw04QdGV58kDzUNxsMWicJEtQR5py9gha7OJ
	zk7T3IH5nIrl+ulPkzhj+W0QFTcHKcnWs98ipQOD5S+xtdFuuSI0QfF0hmvpEGWr
	m4PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701936885; x=1702023285; bh=vYaaWyrgmv1cT
	hhlPjqQ6FAC8iMzv2EDGXIHj8Sh7S4=; b=uc5QnlDo30vtzjlJa8gOPCdRFZQ9Q
	mm+BppokPulpmkhDKHYQU2vDOWfOPPy5p4BJ243YnP1d73fUPqj0tyT/axHpmkAs
	MMrtZbbjOio4fyQJlDaXFpgz14tIblgCgoHzbcydOXaWCsJ2e0F7QZ5z3KyNTUec
	427DGr0HQcOX6pnjFhJPFi8Pc7pNCvncqLdm24kokw0q7NpRwoTsQaF1QuW4Vixn
	TDEFWXvsyVBV/FUEYSUp/0nll7raUjtqyGzXrkudCOmvt5JR4UirUMfQ23Gq2OyU
	pwkrHOJqYaoeB3qIRgZTuZ7phI9hsK6r3YpnFrH5EzcokAxVGf3LXDZWA==
X-ME-Sender: <xms:9H5xZe_qo5D9mroVhZMaFrNhO2VCAKODYO1ENNgqse2qAmFV4Z16qg>
    <xme:9H5xZevdJ_kWEcJHTwklKZaHXZEcWqu1N0R2AV03huMHlIIzs7FcDJi0jm0Sr4IoX
    LKCD5DVVddzU0qvzw>
X-ME-Received: <xmr:9H5xZUD3Xj2eK7Q064xDRPnxwPuGOs0qX1Td9AYbaJv-icL00VEtpleDZE97zXzepDpoZw-2wWRH-_5gE22lMDRGXX12jfeh9Yn-kdyu5Nute-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekke
    fgffduhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9X5xZWcydifKQd0hLRiBgtIIgPg-AO9RBKrGUNV4cm4aHLZSzeWVXg>
    <xmx:9X5xZTPE0wNJWqBvymJh7g6r0j5WKqQ4YaTfKQ3iYi_ATJ4r8ZncVw>
    <xmx:9X5xZQn4Wn3gV4CKBzatiRbLRVik4o6C9bATEAXbEQhp71lRzc0ztw>
    <xmx:9X5xZZ2DxNxdODyCx0J6BCSns9Ac3KHh7fD32XsfUUXpLgUwjwFCZw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:14:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09063668 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:13:16 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:14:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 1/7] config: handle NULL value when parsing non-bools
Message-ID: <ZXF-8iNH0qaJSVl9@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071114.GA1276005@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtn0eZR2KuyqIY8+"
Content-Disposition: inline
In-Reply-To: <20231207071114.GA1276005@coredump.intra.peff.net>


--qtn0eZR2KuyqIY8+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:11:14AM -0500, Jeff King wrote:
> When the config parser sees an "implicit" bool like:
>=20
>   [core]
>   someVariable
>=20
> it passes NULL to the config callback. Any callback code which expects a
> string must check for NULL. This usually happens via helpers like
> git_config_string(), etc, but some custom code forgets to do so and will
> segfault.
>=20
> These are all fairly vanilla cases where the solution is just the usual
> pattern of:
>=20
>   if (!value)
>         return config_error_nonbool(var);
>=20
> though note that in a few cases we have to split initializers like:
>=20
>   int some_var =3D initializer();
>=20
> into:
>=20
>   int some_var;
>   if (!value)
>         return config_error_nonbool(var);
>   some_var =3D initializer();
>=20
> There are still some broken instances after this patch, which I'll
> address on their own in individual patches after this one.
>=20
> Reported-by: Carlos Andr=E9s Ram=EDrez Cata=F1o <antaigroupltda@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/blame.c        |  2 ++
>  builtin/checkout.c     |  2 ++
>  builtin/clone.c        |  2 ++
>  builtin/log.c          |  5 ++++-
>  builtin/pack-objects.c |  6 +++++-
>  compat/mingw.c         |  2 ++
>  config.c               |  8 ++++++++
>  diff.c                 | 19 ++++++++++++++++---
>  mailinfo.c             |  2 ++
>  notes-utils.c          |  2 ++
>  trailer.c              |  2 ++
>  11 files changed, 47 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 9c987d6567..2433b7da5c 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -748,6 +748,8 @@ static int git_blame_config(const char *var, const ch=
ar *value,
>  	}
> =20
>  	if (!strcmp(var, "blame.coloring")) {
> +		if (!value)
> +			return config_error_nonbool(var);

In the `else` statement where we fail to parse the value we only
generate a warning and return successfully regardless. Should we do the
same here?

>  		if (!strcmp(value, "repeatedLines")) {
>  			coloring_mode |=3D OUTPUT_COLOR_LINE;
>  		} else if (!strcmp(value, "highlightRecent")) {
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index f02434bc15..d5c784854f 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1202,6 +1202,8 @@ static int git_checkout_config(const char *var, con=
st char *value,
>  	struct checkout_opts *opts =3D cb;
> =20
>  	if (!strcmp(var, "diff.ignoresubmodules")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		handle_ignore_submodules_arg(&opts->diff_options, value);
>  		return 0;
>  	}

This one is fine, `handle_ignore_submodules_arg()` dies if it gets an
unknown value and `git_config()` will die when the callback function
returns an error. The same is true for many other cases you've
converted.

[snip]
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 89a8b5a976..62c540b4db 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3204,14 +3204,18 @@ static int git_pack_config(const char *k, const c=
har *v,
>  		return 0;
>  	}
>  	if (!strcmp(k, "uploadpack.blobpackfileuri")) {
> -		struct configured_exclusion *ex =3D xmalloc(sizeof(*ex));
> +		struct configured_exclusion *ex;
>  		const char *oid_end, *pack_end;
>  		/*
>  		 * Stores the pack hash. This is not a true object ID, but is
>  		 * of the same form.
>  		 */
>  		struct object_id pack_hash;
> =20
> +		if (!v)
> +			return config_error_nonbool(k);
> +
> +		ex =3D xmalloc(sizeof(*ex));
>  		if (parse_oid_hex(v, &ex->e.oid, &oid_end) ||
>  		    *oid_end !=3D ' ' ||
>  		    parse_oid_hex(oid_end + 1, &pack_hash, &pack_end) ||

This isn't part of the diff and not a new issue, but why don't we
`return 0` when parsing this config correctly? We fall through to
`git_default_config()` even if we've successfully parsed the config key,
which seems like a bug to me.

Anyway, this case looks fine.

[snip]
> diff --git a/config.c b/config.c
> index b330c7adb4..18085c7e38 100644
> --- a/config.c
> +++ b/config.c
> @@ -1386,6 +1386,8 @@ static int git_default_core_config(const char *var,=
 const char *value,
>  		return 0;
>  	}
>  	if (!strcmp(var, "core.checkstat")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		if (!strcasecmp(value, "default"))
>  			check_stat =3D 1;
>  		else if (!strcasecmp(value, "minimal"))

We would ignore `true` here, so should we ignore implicit `true`, as
well?

> @@ -1547,11 +1549,15 @@ static int git_default_core_config(const char *va=
r, const char *value,
>  	}
> =20
>  	if (!strcmp(var, "core.checkroundtripencoding")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		check_roundtrip_encoding =3D xstrdup(value);
>  		return 0;
>  	}
> =20
>  	if (!strcmp(var, "core.notesref")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		notes_ref_name =3D xstrdup(value);
>  		return 0;
>  	}

I wonder the same here. We might as well use `xstrdup_or_null()`, but it
feels like the right thing to do to convert these to actual errors.

> @@ -426,10 +429,15 @@ int git_diff_ui_config(const char *var, const char =
*value,
>  	if (!strcmp(var, "diff.orderfile"))
>  		return git_config_pathname(&diff_order_file_cfg, var, value);
> =20
> -	if (!strcmp(var, "diff.ignoresubmodules"))
> +	if (!strcmp(var, "diff.ignoresubmodules")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		handle_ignore_submodules_arg(&default_diff_options, value);
> +	}
> =20
>  	if (!strcmp(var, "diff.submodule")) {
> +		if (!value)
> +			return config_error_nonbool(var);
>  		if (parse_submodule_params(&default_diff_options, value))
>  			warning(_("Unknown value for 'diff.submodule' config variable: '%s'"),
>  				value);

Should we generate a warning instead according to the preexisting code
for "diff.submodule"?

> @@ -490,6 +501,8 @@ int git_diff_basic_config(const char *var, const char=
 *value,
> =20
>  	if (!strcmp(var, "diff.dirstat")) {
>  		struct strbuf errmsg =3D STRBUF_INIT;
> +		if (!value)
> +			return config_error_nonbool(var);
>  		default_diff_options.dirstat_permille =3D diff_dirstat_permille_defaul=
t;
>  		if (parse_dirstat_params(&default_diff_options, value, &errmsg))
>  			warning(_("Found errors in 'diff.dirstat' config variable:\n%s"),

Same here, should we generate a warning instead?

> diff --git a/notes-utils.c b/notes-utils.c
> index 97c031c26e..01f4f5b424 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -112,6 +112,8 @@ static int notes_rewrite_config(const char *k, const =
char *v,
>  		}
>  		return 0;
>  	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
> +		if (!v)
> +			return config_error_nonbool(k);
>  		/* note that a refs/ prefix is implied in the
>  		 * underlying for_each_glob_ref */
>  		if (starts_with(v, "refs/notes/"))

Here, as well.

> diff --git a/trailer.c b/trailer.c
> index b6de5d9cb2..b0e2ec224a 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -507,6 +507,8 @@ static int git_trailer_default_config(const char *con=
f_key, const char *value,
>  				warning(_("unknown value '%s' for key '%s'"),
>  					value, conf_key);
>  		} else if (!strcmp(trailer_item, "separators")) {
> +			if (!value)
> +				return config_error_nonbool(conf_key);
>  			separators =3D xstrdup(value);
>  		}
>  	}

And here.

Patrick

--qtn0eZR2KuyqIY8+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxfvEACgkQVbJhu7ck
PpQHrg//RopcxlfPb0pm1vmMS9MjndosEyRCPyapndVOZSvw9HfaGGowCmo1SV+s
wH/ztvOXeCj8VdBexb7xsQ1V/EEpz/WYfND6JNpOfJDT2EZ47UWlt5MTmX1/eba5
Z2GMwhgr8ibp4WFqBC4J5ILDVLjcg+7bHnUsXA/kN4IgZ1uPMzZ4GPBYcoYzpMGb
lYKJ4P7vXluOSBPBRzQ4wZE16DqbcTiNxxGXUcq1RYtt232qCAJiqxeNW1s/Wdmt
unHt4iCMg6awzhZX82iANX6QhgAUm3RtA0AbWaZ49NIHAeX3WjkcSei91fPEVosA
oPA7Y3iBG6rcqD8OJFN5tZ7TiESCBNZOxqalMtXWPyuh5I9y/LInBTtRZPOb079g
MiAAJdjclvsyLVH4kkAfBKRzDMbdku3iFw2dQLV+Jcfb63gWzQQVDHJy6fCdPAk0
nKzv7oUrr1KtNZrzbRnGjYnXv7tAjZcMd9rdQ7N2LUi7YBUoXU09+8pjQgEIV3WD
gsIxbdtpXJAI5jRR50ToWBFOkUlAltaauE3zY/J3P8hNrXTM1+gEcovpgN3UCcgc
/w++5nLPHy4Md7udtvzZiEtKJJhd6qqoxh539UQOXYUzIlaWsIs7z7zkCZQcQrYV
xWd5JqRQroEozZ13uKgsdoC6rjktwZ6V/MPSPRft5tK24D3jql8=
=TS7Q
-----END PGP SIGNATURE-----

--qtn0eZR2KuyqIY8+--
