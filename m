Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4EA1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 01:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeHIEF2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 00:05:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45714 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725757AbeHIEF2 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Aug 2018 00:05:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1154:872:78d7:2211])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6799F60745;
        Thu,  9 Aug 2018 01:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533778988;
        bh=sLG7Q585hh/gaDjS65aEkSLX90VudAArWWlpugkC99Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=dYeyQ9GkumAwjR3fR+34ZApL2Puo5gIevXKiGuBFO+sgc07HhgL3ng8UfX3NkgYPK
         4ZDs14ld3mmlVhvlEhk3R0bNEh4iuj5qKup0s/iJlgiaSYzo0CMX1HgqJ0XMPCDKcw
         eLXbzEXmDvarw8X3tIDa2e2jjefl1ietftIS/6gxjzs4s46eQHKh5jgMLG/zmFFgAq
         8tHdgdhylNjZQWvCvBPSGTsSjMGZxtyO7aHGRgDah0/aL1GmNej298yb1193FPKwKq
         7ouNS+Li0VYdf4X1smvF3nzHLAEch6XxanOb3mAo5Ry6w2Vjf0AA/aceEmJT7wD/bh
         dm80FaK1ysa55Si/T0TMZXYsWK7Blbu2UFcXolMYI6HPakegBgdZx6MnQWKxw03QWm
         AXzW4Xx1GL3YfQUpr8F4jygBdsTaOVa9OSDI9VZqJ6H2Q0UNqbshygNY89eG8q7E3I
         GRZ4zrq/U7D+E7WybOfDCxu/XnKaPxk4zOLBI2qD/8FgiCyq0s7
Date:   Thu, 9 Aug 2018 01:43:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <20180809014302.GB34639@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
References: <09f9803c-3f4b-a97c-2c59-e9d6b924892f@nic.cz>
 <20180801001942.GC45452@genre.crustytoothpaste.net>
 <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
 <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2018 at 05:59:43PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> >> FWIW, I'm on board with returning non-zero in any case where gpg would.
> >
> > I think that's probably the best solution overall.
>=20
> FWIW, I am not married to the current behaviour.  I would not be
> surprised if it mostly came by accident and not designed.

Since apparently I was the author of the commit that changed the
behavior originally, let me simply say that I was not aware that gpg
signalled the correctness of a signature by its exit status when I wrote
that patch.  If I had known that, I would have deferred to gpg in my
change.  My goal was consistency between verify-tag and verify-commit,
and in retrospect I probably made the wrong decision.

> > There's a bug report
> > in Debian (https://bugs.debian.org/895048) that requests that behavior
> > instead of the status quo, and also it's the behavior that's documented:
>=20
> The last bit is a bit questionable; I think you are reading too much
> into the description.
>=20
> A substitute for gpg.program MUST signal good (or not good)
> signature the same way as gpg would with its exit code---that is all
> the description says.  It does not say anything about how that exit
> code affects the exit status of "tag --verify" and friends that
> called gpg.program.

I agree that the description doesn't specifically say that.  In fact, it
doesn't explicitly say that it must exit nonzero on a bad signature,
although I agree with your interpretation that that would be logical
(and, AIUI, the behavior of gpg).

However, I would assert that we do want Git's verification to exit
successfully on a good signature and unsuccessfully on a bad signature,
and deferring to gpg may be the most robust way of ensuring that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltrnCYACgkQv1NdgR9S
9otRzQ/8CwCESKocMXVVmxn7QF7DSHE9A9dmy3IcFeqwCZfFiGi+EQ651FRnYcYy
vovJiti8cPHNN2jrXolOvwOJTbIXwaFh1khuo8CXxreTFjxPGEmuXQ3mlJ/suzt6
SCnyiHLzFY+WUYgzvZTTNUlVo9graefkbt8NIMn9yZLkjyP+4ozamuSbuoUgPVfQ
4ngial6xTKManyQkJHtTMIJQobdDttv2ogojRyefwwS0ierml1tx5Q3HFFwRJatP
eULeDEQpd5F6B5m4wL5VwcFMpmzz8kymbQ9F59DFomcAkBomuRpfbGYvW05fA688
lP3wZjkUi6uN2n+n1HxTGN/1zssNlqkyvcKjrrFapPt2pOsXbsa64FtmiZAg45Ov
UlPagnZEPNjpfbZcRD7CDl40ZLukvfiZWhjsDcfG7diGpOjCcGeHrC5cEWquysse
XxvmcaysORUVRAo5NZXvlKPHglnxHUvnOb1ATJkcTQg+PvvYXVeXoUfBqLRfilrt
ehOmAtI84lyz3H3P9t7MCjgDqnCLVv0hy/OH6DbNxxVtwCHmb2Bmo+Wb+78khFEY
9GbnWgztOtxVPKspwPU3sdrpwDQfwzYbkGHB5HztUtVZQTzlfPamgrmnNRc4dC2q
DPYVaI/xUhC5G2Ql1rAUUTWPOUJWfOkohJxndYI+0KzXZr1StZU=
=OrMD
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
