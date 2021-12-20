Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16398C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhLTWys (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 17:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbhLTWys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 17:54:48 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB781C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 14:54:47 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9FC6D5B214;
        Mon, 20 Dec 2021 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1640040886;
        bh=gBjxcAQ27kGeNhktxfDIpOur94XLgLiAqj4sv3Ijk1Y=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=QJZHyoX8QzoluCoaOvyEYJSpxKqzWwhsmo8IgcKfJ9PUxp3LL2F0nTnaFZ1ZqVnRY
         qvRBJndMpFCrOm7JnFYuu/7wmTytqrAm7uLcRI8Tq8nsDdnZwqxnDTI/aMrHs2MXbE
         zZ6FKm1FT0XpxMJTe7fHLqf8KBjXw0dG63xCnfiPGxbMrCN55GGfoaT0bwTWh+Wcn6
         nWk0+RId5rae84D3n2hpMaps1ODSedgqf2O45/3H+gNbUsdG68P12cDs/Jqn9IBaX9
         2r9ErniTumIPl2yM7RQs7/lksKejJofMBtaEvDObaQkUGWvjsYVPfeHvd3bb73AQdr
         ICgBQCBdcX5qaihqXciC5+lCFKCrassSom9FpCPgNuvEXG2XkrStuej1Oa+g+SmP5s
         LQdALEgHMddj5IyyBvbIMe6EQ2lrN8CLEjLzs9DorcEqUnXR2Lt29EhNUqzWdJY7dk
         8G+aqGS3CZDTsW5TzTQqJu92B96t+HjRU3pbTCS03uJD4XJxhun
Date:   Mon, 20 Dec 2021 22:54:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Message-ID: <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Erik Cervin Edin <erik@cervined.in>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sean Allred <allred.sean@gmail.com>, git@vger.kernel.org
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
 <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
 <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i6bhSr3gvWf0g2IW"
Content-Disposition: inline
In-Reply-To: <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i6bhSr3gvWf0g2IW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-20 at 12:37:26, Erik Cervin Edin wrote:
> It looks like any git cmd --help is transformed into
> "git help --exclude-guides cmd"
> This is used to differentiate "git cmd --help" and "git help cmd".
>=20
> It's used with aliases to print the alias as well as execute "git help cm=
d"
> Maybe something similar can be done for non built-ins that are missing
> man-pages / html-docs

I don't know that you can effectively distinguish whether there's
documentation for man.  It isn't guaranteed that it will exit
differently if the page is missing versus if it encountered an error.

One thought I have is that on some Unix systems, you can use MANPATH to
set a list of directories in which to search for manual pages.  Maybe
there's a standard environment variable that I'm not aware of that would
provide a similar functionality.

I should point out that in most cases on Unix, it _is_ expected that you
install your manual pages into the same place as everyone else, so in
this case, installing the HTML documentation alongside Git's may be the
best solution.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--i6bhSr3gvWf0g2IW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYcEJswAKCRB8DEliiIei
gZsxAP0YBZFRtIFeN4wkn3esfv+qauEN+Kk5Rz0IV+nrOro3LAEAk3vi2JgGrCuY
3x7i8UyeTIimlaFuaAwc1uDnRLDjVQI=
=OpgU
-----END PGP SIGNATURE-----

--i6bhSr3gvWf0g2IW--
