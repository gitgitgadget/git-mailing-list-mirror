Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397B61F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 02:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfADC5c (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 21:57:32 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58170 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbfADC5b (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 21:57:31 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 87CFA6042D;
        Fri,  4 Jan 2019 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1546570649;
        bh=HmrLRhwyn63CD+NWTXZOJQH4yXDs4f2EztIfG4HHgUI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EQez8W3RxKjg+BVfermSy06ogZTlUueTQ1m4JmpES7/SaMvf57Zn2N+PkJiEZS6+K
         SWtaivJxBiQV5h9cEk2Rh3OYu2PGK5D/Oona7ec42EDqfQmQ0a8mNRWdjvQ/IKOtNw
         s0D8QFBr1COOwfaZve/qruuHk7Uh2RrCWMnh96HcKlCh4pwTLo0Ux3nQ3g9130ex7Z
         0j2tz7nn5JPMwTn/bhmeLMR0DekNXaEUPwp4zIEKXQAFkZQdwAc3e4BSvaG2fkBwmT
         dE7aMPeK2oRhjxgCAWRZFX4Fzy6/1+gRGviI7SgMfv+WPZT6qa8FPdm8ZM26sD/EE3
         HVIkbulTGwEQWErrje8alwNhnYzndW0/vwnR+KfAOh6VDmvzNzBdCKbsCsNJJJSj3c
         FL5cnJsGemooKMrfBecNkP2dhL6pn48WEkRlMwPEa0aUM4ne3xMknhlNOSg8G14PBS
         QS52FLiJadwTfVYGGnGlckiAbVRo/PheK5fxtbVTnwo1epvJyQh
Date:   Fri, 4 Jan 2019 02:57:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20190104025724.GG423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <20190104021855.GB97188@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline
In-Reply-To: <20190104021855.GB97188@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 06:18:55PM -0800, Jonathan Nieder wrote:
> I may be a minority in this opinion, but I had trouble understanding
> what --literally would do from its name.  I suspect we can come up
> with a better name.
>=20
> Unfortunately, I'm terrible at coming up with names. :-P
>=20
> --dereference would be a good name when it comes to symlinks, but
> it's not a good name for reading what is on the other side of a pipe.
> On the plus side, it matches "diff" and "cp"'s name for the "follow
> symbolic links" option.
>=20
> --plain captures the desire a little better --- we want a plain
> read(2) from the file instead of trying to be smart and look at
> whether it is e.g. a block device.  But in the context of "diff", that
> would seem more like an option that affects the output.
>=20
> What would you think of
>=20
>  - always reading from fifos instead of describing them, since I've
>    never encountered a use case where people want the latter
>=20
>  - --dereference to control whether to follow symlinks

This is actually surprisingly difficult. The reason I implemented this
only for no-index mode is because there are actually several places we
can stat a file in the diff code, and implementing a --dereference
option that catches all of those cases and getting the option passed
down to them is non-trivial.

Since my primary environment is on Linux, I need to implement functional
--dereference semantics before implementing the FIFO functionality to
know if it works in my use case.

I agree that would be a nicer approach overall, so let me see if I can
take another stab at it in a way that isn't excessively complex. It
would also make the name less controversial, since "--dereference" is
the obvious choice for dereferencing symlinks.

> [...]
> > --- a/diff-no-index.c
> > +++ b/diff-no-index.c
> > @@ -75,7 +75,25 @@ static int populate_from_stdin(struct diff_filespec =
*s)
> >  	return 0;
> >  }
> > =20
> > -static struct diff_filespec *noindex_filespec(const char *name, int mo=
de)
> > +static int populate_literally(struct diff_filespec *s)
> > +{
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	size_t size =3D 0;
> > +	int fd =3D xopen(s->path, O_RDONLY);
> > +
> > +	if (strbuf_read(&buf, fd, 0) < 0)
> > +		return error_errno("error while reading from '%s'", s->path);
> > +
> > +	s->should_munmap =3D 0;
> > +	s->data =3D strbuf_detach(&buf, &size);
> > +	s->size =3D size;
> > +	s->should_free =3D 1;
> > +	s->read_literally =3D 1;
>=20
> Oh!  --read-literally works perfectly for me as a name. :)

If I can't manage to split this out into two pieces, I'll pick that as
the name for the reroll.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwuy5QACgkQv1NdgR9S
9osnQA//eLYVhQPKlSv2DdaLeJvkRKwasyi9a4rDjb+S2aeeN1omfPH1Gh36+8uY
52wcXw66d/ahFK7HvGsQGsYE+CHZ8rowP/QeGK6IOBTUNPTsCmHGXzbi955wil6M
h9Fh43KS/7BWA5v2wqO+z5ZS1nZcauKMDunZyB4RUTbSbgEIeXWBUK5qAgTwhqN7
balzgvWGNC8HAyc1VhI5QLlXXCHlBamVrmzjBk0VbDEgmDpWOgq+SPBM1fO4FLjo
EYyrAao03eAKRwtyoFM5RImhhPVKprjnUsdUa1IMLFw+01VkJ8qYOlBJ/Y3c+gvB
NAEInigwl+PqGtduAVjbwdwWWiB8dhqJCZ6/wBtHQVVNIc7SjIIoEl5p04mlFfFV
6/nVNyIaZolxm3rwZ62uwnNiCo/4Lvst4TQtc5LLJIK04mUfxWOoEFRBKpl0ip9P
Zl5ABHvPoFGnYyRIEZT/JcXHBULoK6ZHPjp9LEMiCBc7gy+p8bLsqCbKicPNAgcr
pGwi9HKk5gXC8Pv3obQkO6nIQDJvftNX8pcb8/ss9HwnfXC+J4N2gX7ZdSqlN5LR
D5dXhUtq/HT3ybHdqRt7ur7sZDPUuptPsc6sU50la85gVtzCF/N+sBZX3WduYt3L
O26xKe/FILPCxmnLPeLoY39T7c3EFLkp9DRbY+QTILXrYJIvA04=
=69hb
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
