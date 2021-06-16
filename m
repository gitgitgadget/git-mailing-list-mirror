Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FD2C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 22:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755CD613C2
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 22:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhFPXAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:00:09 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50158 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbhFPXAI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Jun 2021 19:00:08 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C7D1B60424;
        Wed, 16 Jun 2021 22:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623884251;
        bh=Lhj3f8laYpRF3UCdiUjvQLKZK6UsH7wK3zX+LaAdSdE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=s4YMRJu/dUA6zG8rzfrNj+m3S6FgoiOSjUmdlevpzD6OGloc8LRkj9b8XJ78rJrzk
         6vvu7x2ZcE2CsBE/u2Qoh98XxjRpnYP+t2p06XW8q9Tb/ZeerdQTV3w3NZg2JmvSIQ
         t0qXaelc/U9Z32tNuR33SUrW7NTSr7xmyWCOqRnvyubHjmfbKTmf+DPnbKRT4x6+D5
         rr4S5P5M/66avnTekreUh6+l+wi4hC4Ip39aJRcLkygP0z7DcS2FAdtAnVhfr6wK3z
         P9+snNU6iYFj/dW/ESbie6I2YuzK3dMx838o5Ro6S9+h17vAW71Y2966PYiQk2JWli
         7GjxoivSicIdnztnzbGJXHaj8pS2FPTCC2A2gcE7lB7aMM0zCKI10rY07MEi1NOTsk
         zSZp5WBJoredgmgdiyRJx9pjRo9jHJVtcjZyWKf7INDZfQ0BJ8JJr5Wkafjw13RauP
         1OPnJq1bN/gIbTteEqfR+YQdwrrXuQLCPYjAc9jUrKFL4+qEy4B
Date:   Wed, 16 Jun 2021 22:57:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Simulating network throttling
Message-ID: <YMqB1mT9yeRCuA/N@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bryan Turner <bturner@atlassian.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <65b4040c-2a9c-7d49-43ce-dad7d5a9c62d@gmail.com>
 <CAGyf7-HyUHJacvpwx6R+_hCVsK_t3F1mQ++2_4-NeJWB9uUjdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fy9yIs4owB/Fvrqh"
Content-Disposition: inline
In-Reply-To: <CAGyf7-HyUHJacvpwx6R+_hCVsK_t3F1mQ++2_4-NeJWB9uUjdA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Fy9yIs4owB/Fvrqh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-16 at 04:59:00, Bryan Turner wrote:
> On Tue, Jun 15, 2021 at 9:56 PM Bagas Sanjaya <bagasdotme@gmail.com> wrot=
e:
> >
> > Hi,
> >
> > I would like to test my Git repository in case the network is throttled
> > (that is the network speed is reduced from its full speed). For example,
> > I would like to test git clone under maximum download speed of 9.6 KB/s
> > (GPRS speed).
> >
> > I know how to test for throttling in browser, but since Git is
> > command-line application, is there any way to simulate network throttli=
ng?
>=20
> I've had some luck using toxiproxy[1] to MITM the connection, at least
> over plain HTTP. It's worth noting a warning brian m. carlson has
> given others in the past about this sort of thing, though, which is
> that many MITM solutions are not fully transparent, which can result
> in protocol errors and other abnormal behaviors from Git. Your mileage
> may vary.

That is a warning I frequently give, both here and on Stack Overflow,
but I think if you're using a controlled environment and proxying data
just for yourself, the only person you're hurting is you, so I'm not
going to complain about it very much.  It may nevertheless result in
false failures that you'd otherwise want to avoid, though.

On Linux, you can also use the tc command to do traffic shaping and
policing to allow only a certain amount of bandwidth, and you can use it
in conjunction with iptables or nftables to do it only on certain ports
or IPs.  It's very powerful and doesn't suffer from the limitations of
proxies, but it also is rather complicated to set up, so you may want to
try a proxy first to see if it meets your needs with less work.

OpenBSD's (and FreeBSD's, Darwin's, etc.) pf supports the same
functionality but with a much nicer and easier to use interface (and I
say this as a Linux user).
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Fy9yIs4owB/Fvrqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMqB1AAKCRB8DEliiIei
gUhxAPwNOtf4Tps6mlpnfAX2dpKCS+6+RF5il2hKMj9NgHnL9wD+IHGuqsM6oDb4
NpVwFEUsOF2inu7JxOyK2uJe5m1yOgg=
=iUBN
-----END PGP SIGNATURE-----

--Fy9yIs4owB/Fvrqh--
