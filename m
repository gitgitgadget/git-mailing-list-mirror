Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9859B1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 00:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbeLUAZg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 19:25:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57846 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729720AbeLUAZg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Dec 2018 19:25:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3586D6042F;
        Fri, 21 Dec 2018 00:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545351934;
        bh=9P8ptLyKrerkS/t3c1ZWxvh4wuVREZHWOwp46EDgDBA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=zHd1JbxofH4LvQ9qHym+r2dyOmtM0dY/lL9lZ1EWVni+ql4gLc3sn/GNrq1dBavyA
         lctTk3ke8HK2+dHynlQn7s9w6/aUFMLft8fEksDN7U3yBJ+Szh4Y9mZDlQZzkjnQco
         H368zOLwMSi0X/Mgam841WYAWCjyqTBckH/S25qdwaG5fqCou6TI5X+dKNwm/PHrOL
         LHXGX0JYKrnZ+U5MvRaH18ELojELuWaP8+INEeVqBlCjUwhe1xEjOJi1dQulUvFd5Q
         egGG3CkjRQuLr6SQUS+xmv0RBc1rXLlB417i+rWGHHAKTKbQB1P+pKapvkl4WRlQeq
         WtXsTLVysjfbVhvGWxvbRxd7LtwRuCZKaGdomCkSH1xshUIyasYyWDQaGh7iCoQmsk
         RGIEFhUinERwmJFh4Q5w7s0vgaWduHrUvzBqvbslyP3+ka7SPXZmd5YM8lSVyzxK9g
         XlGuHhZ5LCCsfxVcBoTkHIbGCyhYqDQImvyMDKrGmdLoKSTBNDC
Date:   Fri, 21 Dec 2018 00:25:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20181221002527.GF35965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <20181220154841.GE27361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <20181220154841.GE27361@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2018 at 10:48:41AM -0500, Jeff King wrote:
> The distinction is a bit subtle, but I think treating only the actual
> top-level arguments as symlinks would solve your problem, but still
> allow a more detailed diff for the recursive cases.

Yeah, I think that would be better. I'll add a test.

> Looks like spaces for indent, whereas the context uses tabs.

Will fix.

> I think "literal" is a good way to describe this concept. If we do grow
> a config option to make this the default, then countermanding it would
> be "--no-literally", which parses a bit funny as English.
>=20
> If you agree with my "only the top-level" line of reasoning above, maybe
> "--literal-arguments" and "--no-literal-arguments" might make sense.
>=20
> We could also in theory offer several levels: no literals, top-level
> literals, everything literal, at which point it becomes a tri-state.

Yeah, this is what the POSIX symlink options (-H, -L, -P) do. I
originally came up with "--dereference" as the name, but I decided to
change it, because it doesn't affect just symlinks. I think
--literal-arguments is better.

Theoretically, we could adopt the POSIX options for symlink/pipe
handling if we want to in the future, but I think that's a decision we
should make later.

> > diff --git a/diff.c b/diff.c
> > index dc9965e836..740d0087b9 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4282,18 +4282,18 @@ static void run_diff_cmd(const char *pgm,
> >  		fprintf(o->file, "* Unmerged path %s\n", name);
> >  }
> > =20
> > -static void diff_fill_oid_info(struct diff_filespec *one, struct index=
_state *istate)
> > +static void diff_fill_oid_info(struct diff_filespec *one, struct diff_=
options *o)
>=20
> It might be worth breaking these "pass the options around" hunks into a
> separate preparatory patch.

I can do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwcMvcACgkQv1NdgR9S
9ou07g//VzCB3D+hgI6WrREr2MoC1kVU0LyavVj2fEVn+/ZHay5lPNt7SAabOvNx
6DJXjCIQj5hgUOXpTgqzqvksjrnKBtuZ79u2s6UEvd+jGciAx4zew1En3Ux8FLns
TmAYIjU1wSgf/hHhHM5WGoL/4lSJGgMW64mZja4CU3cmZeiTvVwuM4Q6BjOF+Quv
c15cye2oWzSICNyCFcFFFj27BP1vl2MAkh9TISPQH3w7X5SO5U+/uOSh5iN0hbt0
C0JHeghQT6F/E4nXblpbz7ycvYuLX0qpeQUUHtEubtIhVCihdvlEtPK4csHTkBhA
ANSUvNbgr+9HksPLdjTPdBZ8pc8puH5qjEa5f8dO6U5+Gnm4SiV+oNKfNmX6RbCc
ouemtD0QLFo6mIpXB0Bb4NpvGoaMQNqi3SJiYfIBUTlDabxbas1RrbPS4/EXEc6S
/tZfhj7/xx9+2QOk9zDgBpKlHdYE0c87la+JJinsEnlVfGgM5CDPxf8C/8KnZgOU
mebfFPhnjzQkJgPlQRhZ7+gxbyhJxxxjrKbGftZzVJl1UwJm/9kWSdeA9WcTJjQq
Kb1LdD/zl95WBgE9ZpqFKap8p4Kr7DZRBofZAyFN74sICN5T+t5S0Qb0PyOqSpDZ
jimusiiPLIlAyKscVgOL0o0aBwdW/vK/XWe6zppWdnUnyurpN9U=
=ewww
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
