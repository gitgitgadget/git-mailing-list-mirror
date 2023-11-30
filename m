Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MzXdcwBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obLe6WCS"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4310C9
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:18:40 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id D72785C02B0;
	Thu, 30 Nov 2023 05:18:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 05:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339519; x=1701425919; bh=5I
	sLX7sXmIcZxWHF+bixqvBSUwk7v+mUtwev5k4Q7PQ=; b=MzXdcwBNKVFWYBBxBh
	gTFqgGysbLbVXbjr2EHLyr9D778swMN/t1UIMtibAFB1Q/yFeuGl4eurccgztX18
	6hginUkUiTvERcIa3/jgC5TSxcmrYfDNOhXtEd0ZJtscm8By1kWx9udWD2HzcjQd
	pKT31//5zcL5HHhv3dq8yCAooKXiiv71pJrKL7VWF+6peBETjAfYuBio2nDGqE8q
	YFhZ4wZOwekMwsCfXQpCR8GHhMtw6ivlLo0qqxjff+L8d447FFcTtyI/HGwRxKnX
	bgSIRLq1v+MhHBM97NChesU+oFB2za5awGm0jHjeJqNiD5AAB9VtRmQmy4Iz4D6u
	W4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339519; x=1701425919; bh=5IsLX7sXmIcZx
	WHF+bixqvBSUwk7v+mUtwev5k4Q7PQ=; b=obLe6WCSmqLlbhCB9YmuRATaHdrTW
	TCsBgqiQfjb//EHksp9SX2zCdDtKdbXISMQ+yaDgOsisFPmAJasaLVvrmyLG02N7
	Inxdg0QT9A2o1VLblL0Im5qMD1AB7N4prbD719IHcd2QmRqv/z+SLtL9HOpYjeDB
	JxM/EUNwbQK+ieGVhyTCxDN3cq/oipkuG1/4rmA1DDYq4uZJbsJ8uUM6Wzwq5Flq
	A3JDbNwyNFUu6te+IR75Vo1H5kPHYHoRzb4mBsfWZmtq6uXSKvmWYFDDevK5n8CJ
	4on3BJpuUX8FYBzn2nuyVToWijyhfHDESrj9cnQy5WpWTHn5A2XYo4dLg==
X-ME-Sender: <xms:f2FoZekq2yWfpbaFpUyAKnZrcusxqONs0YPzwGK8Fdn7uzbnygGghQ>
    <xme:f2FoZV23oOtJzO3KKOKHt1kXpSAOEKyCylzw5Qd_hlLOh0kKoWYQQh3LEO3F6xfTG
    smOERgQzHEPfo6vuw>
X-ME-Received: <xmr:f2FoZcr4R19YSqYDF57tHsJenpBg8CkFvfsPZ3Z6NBc0e8-t7lqLVLNIXg0zZEkFAwhNFlQeYRuL41bQfp8uGRLq_5NZMU0d2PwnTLl7veAECzg3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:f2FoZSnWRQYzwTfQXZCoCGyMke1bSEVwlJDM6CLULZ1hhgM4j_X5NQ>
    <xmx:f2FoZc3JNKInGiDPd4eg--vFbVKywudlt2w5TGBxQaoVoPP-0ovjIQ>
    <xmx:f2FoZZu2qs0YJGQyPXWkKJCtdFkylEbQuZQxwMhmP6I7z1QB2ELDfA>
    <xmx:f2FoZaBjkOw1IlplQNGczbKSHyAKGIUjVkH4OmdfofdCZWI1OWazSA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ddd19d9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:26 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/24] midx: factor out `fill_pack_info()`
Message-ID: <ZWhhfXoovgYzIYE0@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ccf1337305db60f1c8174e9b309e2a9e04ce1487.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+QTIJKExXFAswEs5"
Content-Disposition: inline
In-Reply-To: <ccf1337305db60f1c8174e9b309e2a9e04ce1487.1701198172.git.me@ttaylorr.com>


--+QTIJKExXFAswEs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:05PM -0500, Taylor Blau wrote:
> When selecting which packfiles will be written while generating a MIDX,
> the MIDX internals fill out a 'struct pack_info' with various pieces of
> book-keeping.
>=20
> Instead of filling out each field of the `pack_info` structure
> individually in each of the two spots that modify the array of such
> structures (`ctx->info`), extract a common routine that does this for
> us.
>=20
> This reduces the code duplication by a modest amount. But more
> importantly, it zero-initializes the structure before assigning values
> into it. This hardens us for a future change which will add additional
> fields to this structure which (until this patch) was not
> zero-initialized.
>=20
> As a result, any new fields added to the `pack_info` structure need only
> be updated in a single location, instead of at each spot within midx.c.
>=20
> There are no functional changes in this patch.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>=20
> diff --git a/midx.c b/midx.c
> index 3b727dc633..591b3c636e 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -464,6 +464,17 @@ struct pack_info {
>  	unsigned expired : 1;
>  };
> =20
> +static void fill_pack_info(struct pack_info *info,
> +			   struct packed_git *p, char *pack_name,
> +			   uint32_t orig_pack_int_id)
> +{
> +	memset(info, 0, sizeof(struct pack_info));
> +
> +	info->orig_pack_int_id =3D orig_pack_int_id;
> +	info->pack_name =3D pack_name;
> +	info->p =3D p;
> +}

Nit: all callers manually call `xstrdup(pack_name)` and pass that to
`fill_pack_info()`. We could consider doing this in here instead so that
ownership of the string becomes a tad clearer.

>  static int pack_info_compare(const void *_a, const void *_b)
>  {
>  	struct pack_info *a =3D (struct pack_info *)_a;
> @@ -504,6 +515,7 @@ static void add_pack_to_midx(const char *full_path, s=
ize_t full_path_len,
>  			     const char *file_name, void *data)
>  {
>  	struct write_midx_context *ctx =3D data;
> +	struct packed_git *p;
> =20
>  	if (ends_with(file_name, ".idx")) {
>  		display_progress(ctx->progress, ++ctx->pack_paths_checked);
> @@ -530,17 +542,14 @@ static void add_pack_to_midx(const char *full_path,=
 size_t full_path_len,
> =20
>  		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
> =20
> -		ctx->info[ctx->nr].p =3D add_packed_git(full_path,
> -						      full_path_len,
> -						      0);
> -
> -		if (!ctx->info[ctx->nr].p) {
> +		p =3D add_packed_git(full_path, full_path_len, 0);
> +		if (!p) {
>  			warning(_("failed to add packfile '%s'"),
>  				full_path);
>  			return;
>  		}
> =20
> -		if (open_pack_index(ctx->info[ctx->nr].p)) {
> +		if (open_pack_index(p)) {
>  			warning(_("failed to open pack-index '%s'"),
>  				full_path);
>  			close_pack(ctx->info[ctx->nr].p);

Isn't `ctx->info[ctx->nr].p` still uninitialized at this point?

> @@ -548,9 +557,8 @@ static void add_pack_to_midx(const char *full_path, s=
ize_t full_path_len,
>  			return;
>  		}
> =20
> -		ctx->info[ctx->nr].pack_name =3D xstrdup(file_name);
> -		ctx->info[ctx->nr].orig_pack_int_id =3D ctx->nr;
> -		ctx->info[ctx->nr].expired =3D 0;
> +		fill_pack_info(&ctx->info[ctx->nr], p, xstrdup(file_name),
> +			       ctx->nr);
>  		ctx->nr++;
>  	}
>  }
> @@ -1310,11 +1318,6 @@ static int write_midx_internal(const char *object_=
dir,
>  		for (i =3D 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> =20
> -			ctx.info[ctx.nr].orig_pack_int_id =3D i;
> -			ctx.info[ctx.nr].pack_name =3D xstrdup(ctx.m->pack_names[i]);
> -			ctx.info[ctx.nr].p =3D ctx.m->packs[i];
> -			ctx.info[ctx.nr].expired =3D 0;
> -
>  			if (flags & MIDX_WRITE_REV_INDEX) {
>  				/*
>  				 * If generating a reverse index, need to have
> @@ -1330,10 +1333,10 @@ static int write_midx_internal(const char *object=
_dir,
>  				if (open_pack_index(ctx.m->packs[i]))
>  					die(_("could not open index for %s"),
>  					    ctx.m->packs[i]->pack_name);
> -				ctx.info[ctx.nr].p =3D ctx.m->packs[i];

Just to make sure I'm not missing anything, but this assignment here was
basically redundant before this patch already, right?

Patrick

>  			}
> =20
> -			ctx.nr++;
> +			fill_pack_info(&ctx.info[ctx.nr++], ctx.m->packs[i],
> +				       xstrdup(ctx.m->pack_names[i]), i);
>  		}
>  	}
> =20
> --=20
> 2.43.0.24.g980b318f98
>=20

--+QTIJKExXFAswEs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYXwACgkQVbJhu7ck
PpSWchAAk9EZy2FlLB6SpeBW7OcQCioEqVvc0B4hE7hiOdYxTRqdoUtq/UjquSc7
+K6Fu1WEyXaq2pEwGNH0GjB0BDmPsXdYUubnWFS6dfA+iJSmS4AqxGkAmDyr6C7r
MwSe3eYLQGHlL/QXHz6vJJsknmHikIzG/dRsiz98XuxUGvyMrqSoh5OdY/jb/G28
ZjzddNZYXRjYD8KJZ5+yWtV6h8HlLyb8DQT8CmGedtodXFk6WAoDo6Pz63qeWhC1
6lj4+/eMwekZKHwi7ufPNmtOde743yJ2C2jLFxeYck/3GOhS5lSh5Qblu8+e/O6J
WsIceWctBo3Zyyo8hstqgOAC5AOS+aZ1vtIlmFyKDWMT+puNGdotHJfhBwtWBSJT
E/U1nogAajpt5WcRk6nvB0rM4ZBTUA9pHXhZ5+jHbLKLJjhcSydFnmoVvhljUcgq
xl4r8hIEYLCL1TdaSbSjtCZyjq/FtsHmGVggoH/Qzf7vbhJ/ShABgVwewhPlwGeF
GG3sKIUW0Nj1q9VMn2g08Oqq6TthG9JeI43BeGx4X/BtH/Icr6cbnNWPJPsRlQIq
pR+eOwO1Lg8oWfL4jJMDQ3jzu2+AOLFUs0xbgZuTWeTtAE2tzW6XDcc1qg2GWZF4
N+hzhTF4Zk0zt3X3jS9HaskvI0ea0M8g9ERLcJUBqZR0njxho0E=
=fqLR
-----END PGP SIGNATURE-----

--+QTIJKExXFAswEs5--
