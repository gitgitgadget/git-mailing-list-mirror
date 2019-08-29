Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07081F461
	for <e@80x24.org>; Thu, 29 Aug 2019 23:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfH2XJh (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 19:09:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58468 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfH2XJh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 29 Aug 2019 19:09:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8456960425;
        Thu, 29 Aug 2019 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567120175;
        bh=lMStHkKLXjugAhNPel3pzxLFH7KwrIrvLa9O890b1WE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CV9NLxgJCa4COY6kKBQE1EofZL6+KEKaGkXknGfjMszOH5TvR0TxPzA6wD4RdjXzt
         ZVuRcpo6TiUdjhKQP3V4jvqxTGbMK8DC5ytLw3tLa/MpHubL5OJWvKexHjV1+LOrrA
         tKqBubrL6q2w4MAacT3jbPm5ByrPDXPzYogSneHzc4oGduoux2TbszhmZxkII0EbWF
         g4g+iR0HjbJQr8XTTuXAS9k42IPp1ScEcIP/758Z6bkDh5YgalOF9gETxMVUb6yN6K
         +Le3uk0tbEc7F9K5QnfYg1+MnoVhaVgqpbRlI+m3CPZUucqOPQc6Tp+oJ6FLOyoXb9
         /Y4QWiwe8mLdxGaloVywlpQ7TS7pIdZUArLTzJBxsIBgkfCqKKrUKo3e/dJB2Kv8ku
         AEVD7uSogXspJmcxXpEIl9HZ6b9AFrMs1FQVTQEy6uO7nZy7639p32hGT71X6kXVuI
         xOdfdseTSGEK6kY3yqCMcpQJU/QyUR+/xAPrhbOQIZoHBNiCquf
Date:   Thu, 29 Aug 2019 23:09:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v5 2/2] am: reload .gitattributes after patching it
Message-ID: <20190829230928.GF11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
 <20190825233340.10894-3-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1908281327180.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1908281327180.46@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-28 at 11:30:53, Johannes Schindelin wrote:
> > diff --git a/convert.c b/convert.c
> > index 94ff837649..0e6e9d2d75 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -8,6 +8,7 @@
> >  #include "pkt-line.h"
> >  #include "sub-process.h"
> >  #include "utf8.h"
> > +#include "ll-merge.h"
> >
> >  /*
> >   * convert.c - convert a file when checking it out and checking it in.
> > @@ -1293,10 +1294,11 @@ struct conv_attrs {
> >  	const char *working_tree_encoding; /* Supported encoding or default e=
ncoding if NULL */
> >  };
> >
> > +static struct attr_check *check;
> > +
> >  static void convert_attrs(const struct index_state *istate,
> >  			  struct conv_attrs *ca, const char *path)
> >  {
> > -	static struct attr_check *check;
> >  	struct attr_check_item *ccheck =3D NULL;
> >
> >  	if (!check) {
>=20
> After this line:
>=20
>                 check =3D attr_check_initl("crlf", "ident", "filter",
> 				"eol", "text", "working-tree-encoding",
> 				NULL);
> 		user_convert_tail =3D &user_convert;
> 		git_config(read_convert_config, NULL);
> 	}
>=20
> I am a bit worried about `user_convert`: it seems never to be re-set.

Yeah, it looks like I'll need to reset that as well.  The only
consequence is that we leak a small amount of memory if there are filter
attributes, but it's better to avoid that leak if we can.

> Also, how thread-safe do we need `reset_parsed_attributes()` to be?

Since patch application isn't thread safe, it doesn't need to be
thread safe at all.  The original wasn't thread safe, either, since it
used a static variable without a mutex.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1oWygACgkQv1NdgR9S
9ovaJQ/+N19RAA1e08030EQDdhnll9YuL0TedeazjqNNWrwkiZtoC9Hcc+CD3jSi
ubHjrU55smFTFqnYiCplfq0dyS8dzZThumCpNGCyDIS9rAdJExBMp2QrumvmmVt1
RTzuI6kCRB6BDWNG79ps6NKR8Hgwm3NzTN90fzYNM4Ul8sdXLusK8laB5/BhPZy0
VtvFp+x9624/27IGDldaIjdAlP8M+cyaurUp2RHu4VdDeoyugVyeIvVpkLFAfadC
PubASvKJ/5ulDHJ2N0USt+5XP99K5hMYvWoM2ITfYrQOFUlj3apaL7478yB/H6Za
iS2ZNuYxMPjr4JFeQIAzqCJviYpBMP0MwDARdKh6rnUEhCvIDkkP4Y9f3P3rEl8+
X52kA6fmosiEoqZV0k8zSGQKE0Ddv1bqtYHRBKKy0r2iK3q4d0MleR8kgAwTnoGU
OeCXhn3JG4FqqeYEGCOZnppbEeOzUrQ+11vbXQi5a14eb1Kb2mgaEu2lUf/5s94p
ageRKpOD/L1uBvB4XSxCq3OsD91q5iQ2w0dNRpy+94SVQ7IXKHExuiYgC1CeLA1b
mN6duxAioVNtPWpUkpicHPAHuntaN3o1f0qnjqTzLV8v2xlPs1qYbkeF4UchSen2
UYOkgFYr6YUoUkMUlSedFNdA82AVGtyhYeMGUHXw+XrA6VTllbA=
=sIJM
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
