Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0FC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCA7610F7
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhEGW7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:59:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49816 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229470AbhEGW7K (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 18:59:10 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3CE1660459;
        Fri,  7 May 2021 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620428259;
        bh=bqoG8cStY6DvFcoeN7ATSRLR4ckKvPwU1GnRNbPk4oA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=J1A6X0wiCiEXHbjnyuH5vuAkBafVUSEkSeAh8qru5EvWFzi5muc2+8AAsHcKRmVPJ
         xZAzjs9y5vmLfYyaKLZXfltaeCmVFUYRbki2jFCyNb71Tgm5ofluBHKF80dRao/haE
         kI/588WKIV7Hzr4aSWCY7jAuWEW16ATbYyXumgR2s4/53ooH7aP9t6Amr7qyDbBqJq
         AaN751oMVKsZGoO6aYToArCMIDulU3qkb67NvveHxP1CGZps+x0WW32PcqRmTHOPvW
         iZanV6olktqnlrQvlJJtOpvQupVxs73wu9uWF9A26juZf9gw0trA3y/JKWBOlSrEXN
         Uoio/cqYd9HNCUa9+lGJ+b+qbh0dMSj76QhO5R4nwyhM3GEn2NXUks9TwipExguKjb
         hgeXH6+MIU+Jspwe0CrDQxHLUQ3kERCwO7+1QfgMpOHzW+QotdBw+dOrlUIQ68KV0M
         X6TPZeaDPP+B6o1B8wHzwKPRDFaHiSa5vE0n7iu6QCidRUpYAhE
Date:   Fri, 7 May 2021 22:57:34 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Bagas Sanjaya' <bagasdotme@gmail.com>,
        'Git Users' <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJXF3oq4n/NFJSx3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Bagas Sanjaya' <bagasdotme@gmail.com>,
        'Git Users' <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <00db01d74338$d45615c0$7d024140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IQNNOIGsV0w7FSAX"
Content-Disposition: inline
In-Reply-To: <00db01d74338$d45615c0$7d024140$@nexbridge.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IQNNOIGsV0w7FSAX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-07 at 12:02:13, Randall S. Becker wrote:
> On May 7, 2021 2:07 AM, Bagas Sanjaya wrote:
> >To: Git Users <git@vger.kernel.org>
> >Subject: [RFC suggestion] Generate manpage directly with Asciidoctor
> >Asciidoctor has support for directly generating manpage, see [1].
> >
> >We support using Asciidoctor as drop-in replacement for original Asciido=
c, but
> >currently we need to use xmlto together with Asciidoc(tor) to produce
> >manpages. However, most users don't inclined to install xmlto toolchain,=
 partly
> >because they had to download more than 300 MB of data just to install xm=
lto
> >and its dependencies (including dblatex and texlive).
> >
> >So completely migrating to Asciidoctor can eliminate xmlto requirement f=
or
> >generating manpage.
> >
> >What do you think about above?
>=20
> Our toolchain does not support asciidoctor itself because of porting issu=
es. I am not sure it is available everywhere.

I think Asciidoctor is pure Ruby, since it also uses JRuby and Opal to
run in Java and JavaScript environments.  Ruby is relatively portable to
most architectures and systems (for example, it runs on 16 Debian
architectures).

Is the problem in your case Ruby or is it Asciidoctor itself?  I'm happy
to send portability patches to Asciidoctor if necessary, but I'm not
sure I'm a good candidate to send patches to Ruby itself, especially for
an OS I don't use.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--IQNNOIGsV0w7FSAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJXF3gAKCRB8DEliiIei
gWzFAPoCJZj0t5h/GZLH8bWHf213uPsqGTX4fEM/b9AdIcvS4AD8C1hOOd0IY0uE
8ZI7LZxeCRJV0Yz5e+EvBDbWjIfVZQk=
=OD1k
-----END PGP SIGNATURE-----

--IQNNOIGsV0w7FSAX--
