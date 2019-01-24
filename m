Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06171F453
	for <e@80x24.org>; Thu, 24 Jan 2019 17:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfAXRFx (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 12:05:53 -0500
Received: from kitenet.net ([66.228.36.95]:52766 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfAXRFx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 12:05:53 -0500
X-Question: 42
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1548349544; bh=jr96149Vkp5jFcvYMJYxMIXZjZvOmBpShloLD0BY6pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XK74dp8+3zGN6AftZj8T7GFAzHc9DLqpVwK5vVM6n3BBZf+JoEAxK1x1eF78zPJOl
         43RbAnW12+Dhlh9Ybf0cS62S5LtZt0DERIKOIhd4a6wZQjsRtNUZi4QGdXdYawu3Cr
         aOCSEZXBpYU2UL7DE1wPgpePJoLgdA4k0//LDIso=
Date:   Thu, 24 Jan 2019 13:05:44 -0400
From:   Joey Hess <id@joeyh.name>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Subject: Re: git status OOM on mmap of large file
Message-ID: <20190124170544.GB29200@kitenet.net>
References: <20190122220714.GA6176@kitenet.net>
 <20190124003948.GS423984@genre.crustytoothpaste.net>
 <20190124121427.GB4949@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <20190124121427.GB4949@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> I didn't experiment with the smudge side, but I think it uses the same
> apply_filter() code. Which means that yes, it would try to store the
> 11GB in memory before writing it out. And I agree writing it out to a
> file and moving it directly into place is the sanest option there. If
> that doesn't work, spooling to a tempfile and then streaming it into
> place would also work.

I have seen that buffering on the smudge side, yes. In git-annex=20
I happen to use the smudge filter in an unusual way that avoids
that being a problem but I think it would affect git-lfs.

--=20
see shy jo

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAlxJ8GcACgkQ2xLbD/Bf
jziWbRAAs3Z8H2vtDyt8tdOXNI9eh9dNRDZ4ohJI1bKWdrxcNKip4Q0CiLwvcBdj
xAcGKdnpTxNbXS7FxOt3eQ3rbXr2DLv+d6Z7y6B+CX1cj2ok6hSdNa/VMyq6y7ao
T5L72co6jeGLmFPr0lZEtZzEtmgwnpLzCZwqx1wTjBLUnirLVnQ5+KburFDM0Dkv
JuGZoq2tFsJiW7PQsBTgibl9LHV2ydKliW7g6UFyL3I79eG4O5FXWnUxj4tG2a/M
uYBcRtCTdV/KanEdOS2T5pH/nDgU6EUe/mIvdsUpox8fHw+y2lm/6104qzh3/KF6
SJxz5EzftPUI8Z9vUtZDafMLR4zsjmZKuVBPiXHkhIRlwpl7UXSwG3MhqItEj3u/
rCoKAIWu3HcWFhKGyK/Dsdt5IKtJp9wTqUHO+o2x8IaRpDU0FYg4lgh32kQpDYVU
ogWkiZ701pcDJSzlcJNxkOjARI1HNhFvfVeXc6M8/BCuIxs7kpq8DXZHV0NHa3SP
di8Yl33M1IwpoG06jPdmwHKSnC/GbbX9FIonOl7rvR1sXZAj1PVdHe94uS6Doqoq
AKUXeFouHO2VhknlY3vamJqme7HgSXjHZaRkytJKJBngwhCj95fR/DitJqnmgpeW
RPFEIqK36Rb2NZBdOEU/yveEF6gVwp1PNiUW+Bc0tvsMD5kg5Yg=
=mMtJ
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
