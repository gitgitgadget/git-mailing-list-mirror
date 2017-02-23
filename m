Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160652022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbdBWSVz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:21:55 -0500
Received: from kitenet.net ([66.228.36.95]:40602 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdBWSVy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:21:54 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487874113; bh=Us5/JrGpQ3b/oyHt1K0WI0QgStPeTA4tI7xzsUY6gZM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=V6I+XYfkqJsq4SJCovRohwnjcqrGTOJBwhLnLk0adY2EO+XCYI+rWxMiwkacSP0UP
         Qeo3+jP+UEQ8jOXDX/FfIEPpBZJ3lRUioRMRel+mI+3Q7MIG3UkarIriuaApbxdmRo
         uiZu6EjvsEuoQS7y+coddPd5qYsDot6QVH4bVajc=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1487874107; bh=Us5/JrGpQ3b/oyHt1K0WI0QgStPeTA4tI7xzsUY6gZM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=l0O9SLuaq+nWggkn6dKKmkojB8xC13tROOJq28WT7Kpo1i6EdT0ZfpDVEspMm3NBT
         pdsITL6UeieWFGBNTvqj5xeMTQn4EYln37OnpNd1LkBPFozChu7RBJ/wWgE4go0ztw
         8vHLCpU+GMfmi77gsli5iMCPn2iRrVTbu47A7fkQ=
Date:   Thu, 23 Feb 2017 14:21:47 -0400
From:   Joey Hess <id@joeyh.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrhl65e2acxt24b3"
Content-Disposition: inline
In-Reply-To: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nrhl65e2acxt24b3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> What you describe pretty much already requires a pre-image attack,
> which the new attack is _not_.
>=20
> It's not clear that the "good" object can be anything sane.

Generate a regular commit object; use the entire commit object + NUL as the
chosen prefix, and use the identical-prefix collision attack to generate
the colliding good/bad objects.

(The size in git's object header is a minor complication. Set the size
field to something sufficiently large, and then pad out the colliding
objects to that size once they're generated.)

--=20
see shy jo

--nrhl65e2acxt24b3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6FpfY7MdJMHr8NgcyRDZIiUS48cFAlivKDoACgkQyRDZIiUS
48dV8w/+O7qnEgADqwNT9MGwKRflFuz26XDpbczjL+EOERCjEMAmvEbaZrFw7eEP
E7QD2hDCIXRLkw/6zpMEDWuqZTnvelgnKY+ZtZignPt36aT27VDheJBT8FyFZAZo
hsvcsCtFeRKfvniTj6O7kYYOBLWIZCayC2sloARxkLIDkzNFhwUbz0lYoOo5wIyT
FL86p3jqysqR8GZs5Mr6alEaxD0PolVYxeWZi2hYCB5qXmq/fka/Gfw+rfR4ujKr
35GlDgtv+1S2+bdqjlVGct6/DwWBVr+IsUFA+H4Q8X5GQFFLp+bWy/g1RhLPn5my
QMpLbe7U6MP3IEM+2clFBnV0U9okgJRlWZTvn6UAPslSOt+dUgWHNN9ddTPBHpMW
MBhFtBSVPFYkXn6O2bpiBo9q3FaDE7igbdHNcOsGhmG7T0xYDb0lJ6waaz+vDU/D
3GKe5M64c0lMXZgYUPuwiy6fdWM+MNSLi6qJrzNg/HzTYow8ICxxZC9MntxXxaUl
o0uOmAuszw2cI7ZaOWetPTFLirQviMifnSYp+jw2QMTDdSpyNHzgLyFSHWgXvxJd
yAFVJbf2UGfje/21PlS9T6+DsoDVsSfkOOLhRmpWh2xgLjO8qkf+U0DlNZRa0jCu
KyZYcDFlA5e+r7dl+pd1NX/PqemuWg+qIgRHS6SLQGRSHa2SKyU=
=gIE9
-----END PGP SIGNATURE-----

--nrhl65e2acxt24b3--
