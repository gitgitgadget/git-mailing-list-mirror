Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F1C56202
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30CC2227F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 02:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKPCPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 21:15:07 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbgKPCPH (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Nov 2020 21:15:07 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8A06760427;
        Mon, 16 Nov 2020 02:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605492905;
        bh=pJGAQAR1mrufGLeV8pfHdfmDkXMF0OGe5cGZ7RX+uM0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OEQBRVMnp0hiuB0FrKTzH3U1cIHp5M0OWZBbW5mPEacIscaYQcg9sBj3/Sl6Rig7j
         23+l+KkV8wXVwM/b55LZ0GnSdsY6/GKfdM2JEL5zs+hT4G5U6hf8MPWq+bhzp8Fk7Q
         GFLP6tNJL9zxfEUh9uvkr4VYP6exL9VUXKD+PdcWlEtycaFyF9dAUvoM+G1sw8NrBn
         yH9V9nVMIru69ebo1XTOQ4R+cDZJ35A30ps8PUQsem1wVn5wMtPwc2dHBzTw0/I/8h
         inJm3J68MI6SvefPTpUjof8jyltfS+LpRG4RHojoCHwG+iYnj5QoYzjwBiQuqZYIfI
         U4LdYgIZcfHVbLiQqh5rmuAlZP559tUCIYP22+NQWaSHLhwGMUhoGXhiKAPxLVkR+o
         pwN6XPT4azoaipW7m2tGG9B3nyEoyGLo2nWy6sMLSvnTHw1i3HxfRPffKsmNkE5pN8
         sH1BfTWRMQJrHgiXLI3OWMvoVMwgLAvzZ4kSskxeIMHQGiRh9Cg
Date:   Mon, 16 Nov 2020 02:15:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/2] rev-parse: add option for absolute or relative
 path formatting
Message-ID: <20201116021500.GA389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
 <20201009191511.267461-3-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2011091457300.18437@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2011091457300.18437@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-09 at 14:46:13, Johannes Schindelin wrote:
> On Fri, 9 Oct 2020, brian m. carlson wrote:
> > diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> > index ed200c8af1..ec62b4cd16 100644
> > --- a/builtin/rev-parse.c
> > +++ b/builtin/rev-parse.c
> > @@ -583,6 +583,76 @@ static void handle_ref_opt(const char *pattern, co=
nst char *prefix)
> >  	clear_ref_exclusion(&ref_excludes);
> >  }
> >
> > +enum format_type {
> > +	/* We would like a relative path. */
> > +	FORMAT_RELATIVE,
> > +	/* We would like a canonical absolute path. */
> > +	FORMAT_CANONICAL,
> > +	/* We would like the default behavior. */
> > +	FORMAT_DEFAULT,
> > +};
> > +
> > +enum default_type {
> > +	/* Our default is a relative path. */
> > +	DEFAULT_RELATIVE,
> > +	/* Our default is a relative path if there's a shared root. */
> > +	DEFAULT_RELATIVE_IF_SHARED,
> > +	/* Our default is a canonical absolute path. */
> > +	DEFAULT_CANONICAL,
> > +	/* Our default is not to modify the item. */
> > +	DEFAULT_UNMODIFIED,
> > +};
>=20
> I wonder whether it would make sense to consolidate these two enums into a
> single one.

Technically, we can, but because there are cases in each one which don't
make sense in the other, we end up with a situation that is hard to
reason about in print_path, which is, by this point, already a little
complex.  So I think I'd prefer not to consolidate them.

> >  int cmd_rev_parse(int argc, const char **argv, const char *prefix)
> >  {
> >  	int i, as_is =3D 0, verify =3D 0, quiet =3D 0, revs_count =3D 0, type=
 =3D 0;
> > @@ -595,6 +665,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
> >  	struct object_context unused;
> >  	struct strbuf buf =3D STRBUF_INIT;
> >  	const int hexsz =3D the_hash_algo->hexsz;
> > +	enum format_type format =3D FORMAT_DEFAULT;
> >
> >  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
> >  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> > @@ -650,8 +721,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
> >  			if (!argv[i + 1])
> >  				die("--git-path requires an argument");
> >  			strbuf_reset(&buf);
> > -			puts(relative_path(git_path("%s", argv[i + 1]),
> > -					   prefix, &buf));
> > +			print_path(git_path("%s", argv[i + 1]), prefix, format, DEFAULT_REL=
ATIVE_IF_SHARED);
>=20
> One thing that the original code did was to reuse the same `strbuf`. Not
> sure whether this matters in practice.

I don't think it does.  I'll make sure to free it, though, since
strbuf_reset doesn't do that.

> >  			i++;
> >  			continue;
> >  		}
> > @@ -683,6 +753,16 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
> >  					show_file(arg, 0);
> >  				continue;
> >  			}
> > +			if (opt_with_value(arg, "--path-format", &arg)) {
> > +				if (!strcmp(arg, "absolute")) {
> > +					format =3D FORMAT_CANONICAL;
> > +				} else if (!strcmp(arg, "relative")) {
> > +					format =3D FORMAT_RELATIVE;
> > +				} else {
> > +					die("unknown argument to --path-format: %s", arg);
> > +				}
> > +				continue;
> > +			}
> >  			if (!strcmp(arg, "--default")) {
> >  				def =3D argv[++i];
> >  				if (!def)
> > @@ -803,7 +883,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
> >  			if (!strcmp(arg, "--show-toplevel")) {
> >  				const char *work_tree =3D get_git_work_tree();
> >  				if (work_tree)
> > -					puts(work_tree);
> > +					print_path(work_tree, prefix, format, DEFAULT_CANONICAL);
>=20
> The way `print_path()`'s code is structured, it is not immediately obvious
> to me whether the patch changes behavior here. I _suspect_ that we're now
> calling `strbuf_realpath_missing()` and react to its return value, which
> is different from before.
>=20
> Wouldn't make `DEFAULT_UNMODIFIED` make more sense here?

It's documented to show the absolute path of the top of the repository,
so it should be safe to do either one.  Will switch.

> >  				else
> >  					die("this operation must be run in a work tree");
> >  				continue;
> > @@ -811,7 +891,7 @@ int cmd_rev_parse(int argc, const char **argv, cons=
t char *prefix)
> >  			if (!strcmp(arg, "--show-superproject-working-tree")) {
> >  				struct strbuf superproject =3D STRBUF_INIT;
> >  				if (get_superproject_working_tree(&superproject))
> > -					puts(superproject.buf);
> > +					print_path(superproject.buf, prefix, format, DEFAULT_CANONICAL);
>=20
> Shouldn't this be `DEFAULT_UNMODIFIED`?

Same thing as above.  Will change.

> > @@ -868,14 +950,14 @@ int cmd_rev_parse(int argc, const char **argv, co=
nst char *prefix)
> >  				}
> >  				cwd =3D xgetcwd();
> >  				len =3D strlen(cwd);
> > -				printf("%s%s.git\n", cwd, len && cwd[len-1] !=3D '/' ? "/" : "");
> > +				strbuf_reset(&buf);
> > +				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] !=3D '/' ? "/=
" : "");
>=20
> So `DEFAULT_CANONICAL` ensures a trailing `/`? I do not see that in
> `print_path()`'s implementation, and also, I would love to see a different
> name for that ("canonical", from my Java past, suggests something like
> "real path" to me).

I don't think that's what's happening here.  I believe the intent is to
insert a slash between the current working directory and the ".git"
component if and only if the former lacks one.  My code doesn't change
that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7HgowAKCRB8DEliiIei
gUxIAQDqXIAy/dMJkNndA4BGGk6V/9k+0zwram8yFqaFvJf24QEApXiC5KJ4nmLr
pOmf7LHqwJ56c0lzZ/MULBO63YtIbg0=
=9+hC
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
