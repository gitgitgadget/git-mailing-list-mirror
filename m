Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3752022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdBWS5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:57:43 -0500
Received: from kitenet.net ([66.228.36.95]:43752 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbdBWS5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:57:43 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487874713; bh=gZI6CwjxMMyXkR2UYK+gROhIEbR1ABnlPzGQLe0/Kv8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=LNLMQ5iaDPSRH504+O3L4NJbQjQgXSZaeyKib8itDYxOPkUDkKkC8eGT7ESLqQHBz
         5zVwWkmp6od/r3/YLlDU18qfMIOy/WfcWFg98GG0Odb5rYvRCGnwyfQJnh1V+CjOMY
         QZASBHeiYrK+HKvwI9KDvUiMAEXxHAVDNDpg1XI8=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487874666; bh=gZI6CwjxMMyXkR2UYK+gROhIEbR1ABnlPzGQLe0/Kv8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=BqvXUX4OwNFGdoy/YRwPIqT3Pjrl6AkDNPCQ2nQAAglPz7Q/+Q0fBKEQm64u7I1i5
         EE9b4BVHlWodojyDtpwLbSgEZBhKw2W9IGFUON1m9bNyCqOAKXaIOurSSq3gvEq1i/
         SoW+eaYeWxsBDnnlISda/CCiJ4I+0tP6oEVIFAwQ=
Date:   Thu, 23 Feb 2017 14:31:05 -0400
From:   Joey Hess <id@joeyh.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223183105.joxtpbut4wcqfbtu@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pnkrlpqwfykgz2dp"
Content-Disposition: inline
In-Reply-To: <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pnkrlpqwfykgz2dp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joey Hess wrote:
> Linus Torvalds wrote:
> > What you describe pretty much already requires a pre-image attack,
> > which the new attack is _not_.
> >=20
> > It's not clear that the "good" object can be anything sane.
>=20
> Generate a regular commit object; use the entire commit object + NUL as t=
he
> chosen prefix, and use the identical-prefix collision attack to generate
> the colliding good/bad objects.
>=20
> (The size in git's object header is a minor complication. Set the size
> field to something sufficiently large, and then pad out the colliding
> objects to that size once they're generated.)

Sorry! While that would work, it's a useless attack because the good and bad
commit objects still point to the same tree.

It would be interesting to have such colliding objects, to see what beaks,
but probably not worth $75k to generate them.

--=20
see shy jo

--pnkrlpqwfykgz2dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivKmkACgkQyRDZIiUS
48fTpQ/8DwlaoNtHG6ECYSNTUX6th1F87Nr4C3NrUvV2YHmF4b36dPNWIb2t/5GB
wR6jqGGRXdqnb4imBki130ym+iOsN3ooalTi5gP+qEdvxMRQJ0jc8JXlo+gF5zRJ
Ihu9tMPn0SEsWaGjLNseItsk8YgGx0kgk5GNBfRvfkJ0N1YVrDtRYAUyxLKwG17P
C6XsAkLuxwLZ7ZmxqSs6uCC2zpFE5WD9awYQ15bHxzU+RXOiIrdncxBjjceBAtKJ
wEsvO1Fsygf98IR8rrrCC2XeQr0vwZDxUmBGdemM90jAOrZRSHXcxIY89aC9OpNk
FaEEq550EJJiesLX/1Fe6AWH9EHIRfuC18NO1hYJLsjZwc0m4772+HP7rDkbwdak
CfQr8eKklRM+1kkLZbcMab3ha7x5hnslTu35BTHfTwJKE+74J+5TmMu1QS5Er3b0
szPFUXmqTWczBvNkjuzJU5/m7MUWqL/jkqwNSRVUoF9hlf8hRDJkNQuU2uOJfFjw
ilm1Co2KjyjnYDRX4ENEr6dAMWQwJSW6wpFS6VXP6K5zY+iKGMni6/gGjCKyRZDr
DiayARO1UokUZ5QVENK3/jVh741ImW367J0EB7C/zlwWpaq/tg2UpoIkwi8IdFdn
zYpGJSsoft0Uss1Na8tg3oo24cL2wPNALXouGBZQMxhtll1Yq2U=
=/rSM
-----END PGP SIGNATURE-----

--pnkrlpqwfykgz2dp--
