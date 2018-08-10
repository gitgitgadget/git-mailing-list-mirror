Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4982C1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeHKA2P (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:28:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46862 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbeHKA2P (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Aug 2018 20:28:15 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1154:872:78d7:2211])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 00B9860739;
        Fri, 10 Aug 2018 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1533938192;
        bh=cbH2X6+8/0zUQLVThXSqCin+xFG86lIwQW7+J9EeLK8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gVtyOm4jNnKXzElh7TmptAC3HRojIZI1LXGQWbcslUecrCNjeLUqnen3oiJ6q7vjp
         aDXYu6k5LniixrHRY4PIhnCAPkKyDHsVAnW7mEbI6XkDpp9soobeXCEEjdpatXEnpF
         aTPQGJ/vtlAv+bhnGi3pZ2nSkU9XyaME90XPLg3eHLTt2MMD5k1swDnWamRG5KrCU3
         UmFTX+sivzi8qz6Kfy5h9vtXg0w6dgdMo5SiQcPoq8QYAKR7nmYlaOiRLynsqxh0w0
         06AjSJItI4n/Pty4XXy0SXyqruzN62aEocVXTPmV6EsQ+o7L09fzHWkkOXudHFYhtO
         MhG6nF6epxDddF/c7/wBSqRXn776OhBdl2knL0F7TAZACWm4ZB+q5fm7sL/ekbQaPs
         OgTnuzXQFvw5VuFVRK0/U9fcYCwOLcvOCNyAMIhTh/8ELLmbUcKJvXX4Bim9K4qqEE
         UC7CsHsPjv5XYhD1tRn+v38JqHtceFgB58B71bzF7epJawI1KNX
Date:   Fri, 10 Aug 2018 21:56:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bartosz Konikiewicz <izdwuut@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's the use case for committing both the freshly created file
 and it's exclusion in .gitignore?
Message-ID: <20180810215626.GC70480@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bartosz Konikiewicz <izdwuut@gmail.com>, git@vger.kernel.org
References: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <CAAdU=LuNn7qdXf81C3-3=0uh7NOSihm3U3dfDcXPiKxfaZMaFQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 01:04:43PM +0200, Bartosz Konikiewicz wrote:
> Steps to reproduce:
>=20
> 1. Create a new file.
> 2. Stage the file.
> 3. Add the file to .gitignore.
> 4. Stage the .gitignore.
> 5. Commit changes.
>=20
> I imagined that the file would now be removed from the stage (because
> it's ignored now and not yet committed) but it isn't. Where this
> behavior would be desirable? I know that a 'git add' command can be
> invoked with an '-f' flag, which would yield the same result, but I
> can't come up with an explanation where can it be applied.

Let me give you one.  If you use pristine-tar to check in the contents
of an upstream tarball, upstream may have included both a .gitignore
file and one or more ignored files in their tarball (say, something
autoconf generated).  Both of those files will be required in order to
reproduce the tarball, so git add -f or multiple stages of add will need
to be used.

If we unstaged the files from the index when the .gitignore was added,
this workflow wouldn't be possible.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.9 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAltuCgoACgkQv1NdgR9S
9osGBxAAu5CsdtQ634H/di7+eCD7laB6aBh/zRZ8cstett3CNClL3ACjs7DQRYyR
jMp0EjVzq23+I3HL8J02GQn/GzhYGdcCuh+3UOy6464kOnNNls+hCzKVqYEAhDJ0
xkuyriltvYDLhqmf2Za+djxHNJwbtQf7deyiNxKBkC2ctEjaK+Gubhl1fBKNLJom
ISFq2JnSINw4YHK7439H8UetO6JCJWoGUeMEfz8c/b0q+up/wm2m6A3uSxo4IOC/
AFz3hn5IoKYoBhaRchsL+D6CjRDFzdXClcy9D4LCZp5YGPsD3cy53Br0Wi9O7kBG
vjNSEUJjBuVNEEoyxymuctvNsHPRXPJeUpu49CmgVIbdRf6Eg6sdoOl2G4wgM2Pa
i9t7x2GziD8aSS0VCQNtOhq4XxYSOSD9X7Y2MFNMvke5H+oQJneJQDyadIoVRGjr
0xeIsKaQcqg2kzncDDepmbL1wKHHKiTNGMRVbCxgqJMbgncp76NkMxETeBIZ1Nta
WgBGSTObTqnpzT/jQe+HO2WBSO/1VNtJtsTEFmmbL8hy0c9z+AzE014mCpVbNFlC
qT7WVi4r/s297Zw/I8ehfqJQ+/UF8Ry04zlAhjswppeIlrPzVxvPF/OAx49hkjB3
hzzXB9ORihYGHhbaq5Nv7leS5dX8p4zhAg80nV37HzGMq+lXaHQ=
=1rkL
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
