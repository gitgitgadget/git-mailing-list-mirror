Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511911F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeGMTD2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:03:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57386 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731956AbeGMTD2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 15:03:28 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9DBC460102;
        Fri, 13 Jul 2018 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531507656;
        bh=BkSrNZfMfjrJH8ZNd+3f/ZpDoUrqVhkmamhk5F/2ouo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ueQcWav7yeGlhXSUs8Ir6+Fc1kUz1+Z6Vbr4XFaEAcklziIEt9h2mR54pFcDB3mTm
         f0v3FDYNHBfVTG8f8a9O/7DHPqb5G5Mcj1jGFXEZP/pro3dVVY4BZGoIMozLw83wcO
         Za0X9NURqN+Qh9j5DpU7WZ2THKhQ2ZvGS2dK8d40tgdgQ08XRBi68Ymfttm9q2QQZG
         dUJms1YbJvJr/8TBQg18pdtGm5xMyfAzCAFrxzAb5h6va02Ydnssy1NYAt0n6d4rF4
         GlilfJYUzOWp5o8iPDd+b2vAK4L6OS34nEF9zPIp8/5Jg9BOtRu+mdl/P+4fnipYH3
         5O+Jf84AnoH21GIKf7AiGe3jkm1YXLXFudXSIO34SnLCIGCUamEAkVzp23dlq0w0ln
         xKKpwzKz/a5i44x7/2aVuwVcRLXnBo6pTzaQH05nIHlauympFSUM2Gb7NJIdbBx6fL
         rvioo+R6oYVy02j+pzjzECs056cyWwhIC69naADMvnxWB1qTVph
Date:   Fri, 13 Jul 2018 18:47:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
Message-ID: <20180713184732.GC968742@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
 <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 12, 2018 at 08:23:02AM -0700, Junio C Hamano wrote:
> Vitali Lovich <vlovich@gmail.com> writes:
>=20
> > Repro (starting with cwd within git project):
> >> (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> >> git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> > # Stop at some commit for editing
> >> (cd xdiff; git rev-parse --show-toplevel)
> > ... path to git repository
> >> git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git=
 rev-parse --show-toplevel)"
> > ... path to git repository/xdiff !!!
> >
> > This seems like incorrect behaviour to me since it's a weird
> > inconsistency (even with other rebase contexts) & the documentation
> > says "Show the absolute path of the top-level directory." with no
> > caveats.
>=20
> Does it reproduce with older rebase (say from v2.10 days), too?

It appears to work correctly on the CentOS SCL Git 2.9.3.  We print the
top level of the repository there.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltI88MACgkQv1NdgR9S
9oud2w/+OEVd66YuHg9849ZcWFqmwVBRXNw2kKEivsodYO6hG+E8QF616oICQpqq
pbDXm33N8RE7evDHIMLOQ6+NuasY4lgf+Fu1vdunNUGhj4t/Z/gzJVGZmIUmTebF
RHl7xryDh9lU8QovU5RuwqMlrCooM7OjAyYIOkyx5k1YRdWS1S+2rWwe/LMe0vMg
VzSj9dWsGkuC2nNTE3zbtyBy0M/hCIBXt2etvE+vJDIFICWO8AemDCXCQWVug7e2
JgVOhyoysvBHiB23pdPUmBBJyRF9wolnupqtAUy79mwqP82rmkA1QlKLR2He9z8q
lLOyrgf9k9z5MQbOWl3El5T1wvJeZ3K1Wei86bqaVtQrmotKIaHaHfYlrUsl0nAj
IsJYprki3Syk5hwGtqgVU+kGO4toYEva2k+X5m0V+xIlxewmUZYsfbfhmgKk85gU
iD6KwALrvHBUXQU0KSWCWtNg99m9XcbEB+BAw0haM2nMVnK5ggLLZsQVoCqr2Dol
kbdH0K+pFIC8QxaIJ48v6+lpl+B8mGWQq9hjaaSWYugE8ncfuTg23j/ZWJawlL1k
oPv8w5qjND/NCdMTyDcaefhlGg/J1d9eL5lzHniLiZ+yHWYGoSrUx1zkcm38gpA7
MiBR3h6pXIPgme0Z3z30Fcod0xFAg6YTJ2saLUk2MBqZdpnNRp8=
=Ssu1
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
