Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33F81F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfJHTaQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:30:16 -0400
Received: from kitenet.net ([66.228.36.95]:35878 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbfJHTaP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 15:30:15 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 15:30:15 EDT
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1570562577; bh=O9WaBKRaEfZaNJnblG1yRUA/MWqP3JpI6lmy3EE29LU=;
        h=Date:From:To:Subject:From;
        b=cU2i1J/teBq5l2h4QFe0k8p2OQolPXBBUZdJWw8lYNcFzj7RRFEHb7znp8RIkrfWT
         wIRgat4dl5j7LPjPwv34/piFlhS+jJjL3PDbhCNYFXjS6TaHAShN7r+/5/oOvgU3aA
         upxkfgOONMKO5syWmrJU2Li437Bs1ymlTcyROR1o=
Date:   Tue, 8 Oct 2019 15:22:57 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Subject: git cat-file --batch surprising carriage return behavior
Message-ID: <20191008192257.GA16870@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm surprised to find that git cat-file --batch, on a Linux system,
strips the \r from an input like "HEAD:foo\r\n"

It's obvious, of course, that it will remove the newline, and so this
interface cannot be used to query about a filename that, for some
horrible reason[1], contains a newline. But very surprising that it
cannot be used for filename that contains a carriage return, at least
on a non-Windows system.

The docs for cat-file --batch say the list of objects is separated by
linefeeds. I don't know if updating the docs is the best fix.
(I'd be happy to use a -z if it had one.)

--=20
see shy jo

[1] aka "a large enough number of monkeys"

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAl2c4g4ACgkQ2xLbD/Bf
jzj0aA//TUoBvEy2rKGacdT5+/8KBYMs6RXnj3l+gXB3oersvWI8UU3bJdRF2Tid
8ChoYUsorja6LbE0NTiW4T9cMqyHOxJW1e57eYS2LM10WBmES9urABwwxIBbQ2im
LHXbsI/N7dOugITEm+x/NYQ/OMWFeBgy2RfKXLRZcXV1d4JVfViToiwZNrKrN8ac
aGUiUXj0Mgg/yVfYJFB9Lrmz+UxWf0HwcrzxcHX48nlLdjcUD/JQQCd/gLlvLnaV
fME+ZYGGaLiia33UyRQ79DPvYXZCK3V1ee6uDjyM/GC0VdHe5MnL3S/g/ft6RLt6
Ie5HzKfeiw7vaYCEqWMABLjB607o2YhxHt5iFcgZJODbtgzWrKAazmpRCTBsANJ1
YaJ0wNaugYOP+b7IIcFUYZxCwiW4SUTTVW/IVKK+6CSaWOSjw2yG9aO84ZgttSQA
4VX4fMT/6hi2sLXkvsbNEO3x7XxsCSSJIj5hmEkd/iln7uJgDMxhHMnZEo5rz+Sj
KWQMHRp9D6WHbUkNV53g7gCZcLdtwN3POXs1JlwW7SF73gBX9CbPaeSG6fpxAunS
bb+Kr3yGz+1Qd57OO4HmYqB9KxeRVcQLLTW3fxBaLZvJ2uO0K7CP5cc3nEWRWByT
N5uMKBo9+9RWEkLt2iiC/tCLxR+X6p9qRHFmLXXE3LvsaFGkaQI=
=gxXH
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
