Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C63A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeKMIqE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:46:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54308 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbeKMIqE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Nov 2018 03:46:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 57FC06045B;
        Mon, 12 Nov 2018 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542063048;
        bh=LMKitLI1EKHEzSNox4sqRlLq+lB4Oe9148aanQD8qZ8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=t4dF8320Jiux1SoFWPc5n1ihEQjdYSEd/ZMJEDm3/QrHmJ7c15ejt62/9nZFhF4zW
         Dg9A2/GRZ5spYzwhXEb0/SOFJoQVrlKBv4D08r1PPaWB26/NMYQmogjAww3RqBtG2T
         THkJitu+LAwgFxIknME9yDX3hl42M56piphu2UOKNJjwMpok5GR/U5MoA9F8hMXyfX
         7o3ynmLVF76Q3FYLerr6Id67J8of451oSj/znBmZiOMhxRhF7u5v1I4a/nyx5DA7B0
         bOCX1qW4FBG9Q9x/wJZ7tiB2BKRe3QHvIhqJjzSI50IYB+pj5ktQiDnTAjWy2im1Fd
         5tKxatbyY0Qe+A7gmm0VHDrRNtm5iNCIzMWP3ArArTNZ2c0J+4nqd7SRxI7nP2b4Ro
         jqlGUTwu6B0b+j/27kUQBqYeufXCKXOvRmwwCv16eE67Gn8UMVi0Hqcjg2rglRpIYr
         EIZ5uFSGXcxINIr01jSQgDj3Xw0vE/Z0TnPvxcJ+IZDYMKpDmtE
Date:   Mon, 12 Nov 2018 22:50:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        larsxschneider@gmail.com, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 04/10] fast-export: avoid dying when filtering by paths
 and old tags exist
Message-ID: <20181112225043.GJ890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        git@vger.kernel.org, larsxschneider@gmail.com, me@ttaylorr.com,
        jrnieder@gmail.com
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-5-newren@gmail.com>
 <20181111064442.GD30850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hk6Zb6cduJ+I0Tmj"
Content-Disposition: inline
In-Reply-To: <20181111064442.GD30850@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hk6Zb6cduJ+I0Tmj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2018 at 01:44:43AM -0500, Jeff King wrote:
> > +		git fast-export --tag-of-filtered-object=3Drewrite --all -- bar >out=
put &&
> > +		grep -A 1 refs/tags/v0.0.0.0.0.0.1 output | grep -E ^from.0{40}
>=20
> I don't think "grep -A" is portable (and we don't seem to otherwise use
> it). You can probably do something similar with sed.
>=20
> Use $ZERO_OID instead of hard-coding 40, which future-proofs for the
> hash transition (though I suppose the hash is not likely to get
> _shorter_ ;) ).

It would indeed be nice if we used $ZERO_OID.  Also, we prefer to write
"egrep", since some less capable systems don't have a grep with -E.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hk6Zb6cduJ+I0Tmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvqA8MACgkQv1NdgR9S
9ouOhA//fhAF5rj7klxQOY7ZWyqNhq1LtPpHdAA3gZ22deho4YMx/66uYnAVGCuB
bfJSv+JkV+jvG6E9REx//AhLnDoeC46uNmPcGRKvN44yfYzmygWEXsEg5Dhd+7jG
wqf1qhek9QYfsXmeEIfxt1kvMWIZJYAtYSqIyFjU1aCCIotQLwrhBuPHo3wZil8z
rAyR/Yex4wcNlDuk+sLR+cyOaY33ECozaJ9A+CspjxXxsBBCOt0F17hEnY19Qu53
rqKTOkrRklrBQfAsOx2BaSUixPpY4yejPbRbfqtDSQhBO1ovedR+7a7rz5foEDh+
UaV/uNcTgC4wT7O9w01galzrqWNC3KRY7jt6EHeQS4JHkpJPD2Dh0XgDIttU6Nlr
wInN1bBO+oMVxY8j9vv+JcZQl1vg2d8XKCKbXB2KDqcee8tCW023MxrlyHz2Ddub
+ALwXKsq+ivAUhjN+3SyStG3qRrcxRoH08TWK8Y/4iUFeLB4QZLwGrwwrFP8jmF6
Nc2dwPjGjHhv4i/sFG9kBABgAoKOvhVpZlS+dDoL4lcV7FVvq45VMvhZv8PdUe6V
0dATXBw1iytrVNv8jcuObgPCgHGARytRBNN8gxHSQ57dtKWhUjEowIhuf6pLYjFb
SSHepe02bjFdcI9ecQioBRZIiZZHG41OkkLF8CefutMQzD+kFZM=
=6m8m
-----END PGP SIGNATURE-----

--hk6Zb6cduJ+I0Tmj--
