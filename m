Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CDB1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 02:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfAYCE7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 21:04:59 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33292 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfAYCE6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 21:04:58 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5551A6042D;
        Fri, 25 Jan 2019 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548381896;
        bh=6Sj4vHNi28/hmiMCE3/7YGNSvb1wrmGl/OiQTx84U+4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kIqxZ5kX7+6zG60gdlYVGZX88WOS1LO6jjHvvzQ3N5m9UnNPjUiRVDFBlKQeUNxt1
         E8WGq3nofXnaKx9CAXuYeCES4RcrBUc/XyENxtZQTTr8GSVQL67CxUp0cobXmT0IaO
         dKKNNPAsSpSEagRQINPWkmxE7YYUVHo/cvj43JIiB33MNoPmQ1KZQY/lzXewEE81FG
         dUTKmABZJtHRrbMM7ndy/Zd4aWqBCL1Pi2FUnxxavSmMkB5S3qHnAgSvbtmTGzEIAP
         QucYemnMnfN0ofu469NmU8tEjWQjY3LZr1cuyAsv7cyjzGFmAlMdAIAQ1lRcPCLE9p
         9ts+i4KbWoU9OMKaF27rFyCnpWGbjqTKWoQj1daJ2I9rnUiyWxT32PT+s+OwPxqYPM
         wjX05eHsBcx8G+BUtAZA4SM55KK4yn7J/EMbDlpt5YUupb3+/P4yBt3cx6TS05/yau
         Pb5e+oDx5AD3gFLtUiZdza0982KS0EtCjNoEtRY1dRWwqwG85DL
Date:   Fri, 25 Jan 2019 02:04:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arti Zirk <arti.zirk@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, wil@nohakostudios.net
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
Message-ID: <20190125020451.GU423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Arti Zirk <arti.zirk@gmail.com>, git@vger.kernel.org, e@80x24.org,
        peff@peff.net, jnareb@gmail.com, flavio@polettix.it,
        wil@nohakostudios.net
References: <20190124161331.25945-1-arti.zirk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+epxrXWOh++2HLjY"
Content-Disposition: inline
In-Reply-To: <20190124161331.25945-1-arti.zirk@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+epxrXWOh++2HLjY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 06:13:31PM +0200, Arti Zirk wrote:
> With this patch it is possible to launch git-instaweb by using
> Python 3 http.server CGI handler via `-d python` option.
>=20
> git-instaweb generates a small wrapper around the http.server
> (in GIT_DIR/gitweb/) that address a limitation of the CGI handler
> where CGI scripts have to be in a cgi-bin subdirectory and
> directory index can't be easily changed. To keep the implementation
> small, gitweb is running on url `/cgi-bin/gitweb.cgi` and an automatic
> redirection is done when opening `/`.
>=20
> Python 3 is by default installed on most modern Linux distributions
> which enables running `git instaweb -d python` without needing
> anything else.

I'm glad we're using Python 3 here, but I wonder if the name "python"
will lead people to think it will work with Python 2 as well. There are
people using up-to-date Git on systems like CentOS 6 and 7, where Python
3 is not generally available.

Could we call this "python3" instead, or provide some other way to
communicate this to the user?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--+epxrXWOh++2HLjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxKbsMACgkQv1NdgR9S
9oviCBAArk4RtrobkGtdjZrgj7vNJqXArQh9P9vQVJlzGJswWga6w8vpyDZP7179
fBPlg/0tHYbdeaO5LnBj1UkiI59QcYJLKTPtGX3jujwAh5SLobL3sExKkbwlqy6C
r0iCknObraDbYCELOA4xMsI0F6VScfE6Ka/PSm6ve0LuL2z+K1308THvUpdZOnis
fg2Uq65tfSnAlKQW2eI7pFPumcqglxLmnHGZD88zfP8C30ZNq+2/rcclIBvPnaUt
QGmIVEBweCTlrmRsxnZc+2o7bFWzXSPVizfruoxuPZI9/6kTWYwI0KHZlELQKiFb
bGJI6Dz8TvUjUUfqh46HWQ6exCZ+3rrBKyZXwMLNm0Ic0XbNXEHARLb5TVZqUxth
8G7qhWkCscwTvih3cgcGa2lyg9XcddSS+mc7TUCpNiQWH9DEeeJT8bBINovv4SjB
d8Kc8dQVaxuFHJraN2HWqQUwtS8ulvZv2TvTmKkLu6sMILA6UNLqs7YU1FZtk0eh
Ym4eTHIY8rN+EghP6BbQZwFTPPFE3t+TL5z6Whm2l4t53WoKo8tjDmspMKsdCY6k
DUgbTa0Ppg2S3AaPT4OY0JeSLHrokHTJPgSY2pwyWtWkxMy5lsMRl3KJXNv3e08A
KcsNcCQpQmLbvDXTB2T/g/FRrodYsV1QVkA+3CB0nhCmSeOFa5M=
=aCeX
-----END PGP SIGNATURE-----

--+epxrXWOh++2HLjY--
