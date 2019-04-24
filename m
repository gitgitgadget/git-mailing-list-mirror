Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CAB1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 23:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfDXXHx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 19:07:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:35696 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfDXXHx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Apr 2019 19:07:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:ace5:84c6:6a15:3d32])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2955F60FF7;
        Wed, 24 Apr 2019 23:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1556147270;
        bh=REdr+egHsZQcCZOOlmKSGzqFZ4K37RL1ydZvmz/Ze5s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A/FBx0reg+Yn3bLcNwsRZXACQByR2UVbq+ZMCOnnRFr/gxHkMgl33QPt5wLDRwDj6
         LyzHIRxFmbibs79Sex9pCYsS4spXJsvLCX7+hDMf6fbsQjLlxp4Wp0tx3TndSYhjbE
         WZ7T0IrFcvu5sk1Iwk5d04fqjvTQLxr00gdaTsYf/P1GFjjWbYM3Iaz+zuPAFkMtKd
         Ea4GpuSyYbbSYV9O2mGzny+15TgxvV2C9dNry2yqWKu3hmVi/x5f0rmYUjj7o9xl/f
         tnRFLcvqhTbWpmbcfrfXbiee+katpq0+SGWArYBdmoCwwTR+5Y4IWB1fgQuAkq25xs
         BKhRkcVg3wt7qeqs+malYgvCgEKo7feSAyFxDIT2OYz3JvyY/kEf7DQKSm/EyLX9TO
         TqqTCb9cSqxImADOMc3GUrfuremmI8VIgBwdFC131YbujLlxi5Afyfej2S9wyKcFYz
         2sY1MIMcOUBaGpIWdmCcybS+O9ZaIkm+UNInf8LjF9+67VT5CiM
Date:   Wed, 24 Apr 2019 23:07:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190424230744.GL6316@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gw4vLALk08fVJy3V"
Content-Disposition: inline
In-Reply-To: <20190424023438.GE98980@google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gw4vLALk08fVJy3V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 07:34:38PM -0700, Jonathan Nieder wrote:
> Hi,
>=20
> brian m. carlson wrote:
>=20
> > I've talked with some people about this approach, and they've indicated
> > they would prefer a configuration-based approach.
>=20
> I would, too, mostly because that reduces the problem of securing
> hooks to securing configuration.  See
> https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google=
=2Ecom/
> for more on this subject.

I know this is a common issue, but fixing it is a non-goal for this
series. Anything we do here is going to have to be backwards compatible,
so we can't make any changes to the security model.

> Solving (1) without (2) feels like a bit of a missed opportunity to
> me.  Ideally, what I would like is
>=20
>    i. A central registry of trustworthy Git hooks that can be upgraded
>       using the system package manager to address (2).  Perhaps just
>       git-hook-* commands on the $PATH.
>=20
>   ii. Instead of putting hooks in .git/hooks, put a list of hooks to
>       run for each event in .git/config.

The problem I had with this when discussing it was that our
configuration system lacks a good way to control inheritance from outer
files. I recently was working with a system-wide gitconfig file that
referred to files I didn't have, and my Git installation was subtly
broken in a variety of ways.

If I have a system-wide hook to run for company code, but I have a
checkout for my personal dotfiles on my machine where I don't want to
run that hook, our configuration lacks a way for me to disable that
system-wide configuration. However, using our current system, I can
override core.hooksPath in this case and everything works fine.

I mentioned this for completeness, and because I hope that some of those
people will get some time to chime in here, but I think without that
feature, we end up with a worse experience than we have now.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--gw4vLALk08fVJy3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzA7D8ACgkQv1NdgR9S
9osXPRAAqSc4C1P8b9/FEp5DB9WBNeAZDoU2vQpsNlFnG7jnfKAxdd7LWe6/YDhp
qfr8dRBahRWniTlK3s42Ke818CXzE1m99c1LkGBRMUAxOI0zP1pruWzyEhPGXHUG
zwhlJg2ZlIsr9ANc04+dHdLXBGtr+2pSJJGapjx3MVmoXqM9OQS9/XhAi8wWQflY
Ft5pcEGSFQdDoSpuAC7pwNzDV3kuMdTZgjdDRDIVsOVnB2MdYw1jaf33VAi1HYch
4qqtCxp4tpsdxovR+ukggJgcpFBBQu2bCJ/sVnye8zDKVia/Xg6p23SCTWYvLr8p
kFqvHQNk1NRXrJrKfvMkKVQeCIzfURRy6tFqrIBsozn3oYWLBueMSKJIY3y0IMDL
wLuHHavf6ahhHNtbzIF9RnaYG8IaumS8xl9EGs2Sgut+5Gqq4AIiJiZYG2Tc2r6A
AO/sPy0vOqowqYOe2htfWLunSuWpY45NfUcHgt8CB8raaSBvO8e5aU2W80Osy488
YlWON3lHAUj0H0pvv8Gx+3r8530FOhTnfBcuIR4KKzi4cUuma+XlYKDTc9Lzcm9A
p0NvF0k4tr8nihEw6waR4GXYmS2Qfla1k2Jj6B+VMvjIYzS/rTEUIv8SvouzPFdn
t7X7JppBXLV7/4+EgCdCtscWAivt9aHWxkTyzAPuL1b51E9ogY0=
=JVmR
-----END PGP SIGNATURE-----

--gw4vLALk08fVJy3V--
