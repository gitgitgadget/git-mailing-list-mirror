Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D584B202D7
	for <e@80x24.org>; Mon,  6 Mar 2017 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdCFA1B (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 19:27:01 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42984 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752445AbdCFA1A (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2017 19:27:00 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B70F4280AD;
        Mon,  6 Mar 2017 00:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488760006;
        bh=N4QXL5ZwRzR9niHKM5TeRFF0gUwu/1nweQ1WSf8Q1sE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1u1IQCZ059i5JVHks8Ozn+oVp2JtZG8zsE/quaESotB7/3e6cvp3nM8wIcLeymWe
         OJQYAfMina3stdj9xXtDX/W6cI9C0xs9H5JOKrleBjKEHtFs9oK/KoXjwIzQQ7uzGZ
         oEkuPXumoh2oVEHR+qRfEQJVnaeY/72oaRQcRmJNAcm6wAa+pugv5RyDGeaYj6b9u0
         8/4kh67lrXj2wupZzcpgqY0JHRIlVRk+8PB4m0JLDqt056w9mj6PHtATEgD6yC2dY8
         1dm8kMS67EwAdH7d61Pc0z71cpOn3aSinBQiH6hn1Ahpn1/WvdWhGMQBd8keYf0LY7
         AEPuTCeNR9RGNxpy9hPeevjCFX1EYQU50LJ9Csit0/lcFFg1xaSOyH+YIf+yAUvooC
         kKRCd8G+c0lK4VbOZo7Ep7VQtNq05DHbotsh3suVZP2yCZVy2EFn51eoHK1nWTMiAr
         RapFrIlsWPoD7ggiGygnwpCV09YkDhXq2cIxTZGyzXvLsFPVQaS
Date:   Mon, 6 Mar 2017 00:26:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nv7foc2pqucr2aq2"
Content-Disposition: inline
In-Reply-To: <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nv7foc2pqucr2aq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2017 at 06:35:38PM -0800, Linus Torvalds wrote:
> On Fri, Mar 3, 2017 at 5:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> >
> > This document is still in flux but I thought it best to send it out
> > early to start getting feedback.
>=20
> This actually looks very reasonable if you can implement it cleanly
> enough. In many ways the "convert entirely to a new 256-bit hash" is
> the cleanest model, and interoperability was at least my personal
> concern. Maybe your model solves it (devil in the details), in which
> case I really like it.

If you think you can do it, I'm all for it.

> Btw, I do think the particular choice of hash should still be on the
> table. sha-256 may be the obvious first choice, but there are
> definitely a few reasons to consider alternatives, especially if it's
> a complete switch-over like this.
>=20
> One is large-file behavior - a parallel (or tree) mode could improve
> on that noticeably. BLAKE2 does have special support for that, for
> example. And SHA-256 does have known attacks compared to SHA-3-256 or
> BLAKE2 - whether that is due to age or due to more effort, I can't
> really judge. But if we're switching away from SHA1 due to known
> attacks, it does feel like we should be careful.

I agree with Linus on this.  SHA-256 is the slowest option, and it's the
one with the most advanced cryptanalysis.  SHA-3-256 is faster on 64-bit
machines (which, as we've seen on the list, is the overwhelming majority
of machines using Git), and even BLAKE2b-256 is stronger.

Doing this all over again in another couple years should also be a
non-goal.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--nv7foc2pqucr2aq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli8rMIACgkQv1NdgR9S
9ov92A/9HN8Ugkdts4bU3+0xMK+FFiUqGWIYPdfHTt2RcD+CL/Rdtg23Vaviraao
GeBXqOkOL0dJ19oDIeqPzFDSLP4Kj4Hhh6PjJjj4x8G32rYCmrOyAckhMMX9GctT
ABLyjkLaNHGa+pIY+SG0x9ukWK+ThZA/vRaIodRIH4B/OvXSK4IcOzv1oJSVMInn
2KvRu82xveA/WGWsDIunPmeG4sInrhq99YnS2g85UFOLHIueqr+8WHE8aM4CaHFV
g459slJRMxdlnIwhtmo6TxuxuwXh+Gyn0r7NWmCGVIlRneDnCvNnbacUl8nMyDwb
k6FaKgJjAiGX5fEAlG82en2BrvABm8Ux5taZR1F0ylD50kJrelg9NSOvC5nLBkjV
BKUa11UnM4EOGw4s0YeKZV2hgmoEyQ2ho0wTbwmFgyZ8zUufKZLm2I0L2oe0rXGo
4TmXt3/UQZgBQhqr08v8g/rqjnbNIz8svgWtjwxmgU0mJZWgTmXq1n5UiBXNlr25
oFIgBxyNMBqzPxtnve0u2TLRHWuIzp6WIcGOrD2AKELdV3jOq5wM4eonYfig9Pdx
p/BJ6wS3Qqvlc0ghyEsG+zl3jDtOj7xa5xPo5T5DT6kd1nYfrCjH2bPXUi5jTi/Q
PSvMsIu0TNG6/yT3z3rNVTGlfQFIG2bqQlxUSrGOMCpwzHl4DLY=
=/Rkd
-----END PGP SIGNATURE-----

--nv7foc2pqucr2aq2--
