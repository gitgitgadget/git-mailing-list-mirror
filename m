Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E53A1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 23:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJPXnM (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 19:43:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45316 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfJPXnM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 19:43:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5C80060424;
        Wed, 16 Oct 2019 23:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571269390;
        bh=0g8AQ6cnEC6GKizulL2UuAlKhvBHrbyLo/TrMMp1h9w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mN5lpGivUzDQND6bRTqAlg6KnADrzh5EYiPvyU9ukoVczb7jFyiE2Vb+4m9/KUJQW
         HUr+XdodC+Am5ZW+6853+RiqEEIfa2MQA8Xa6/NNR4gG5VDE1dSVY4KJ2jaMartxcO
         haVnwoqV1UWvngoCYz+0oFwepdF0y3mBwy33VPQwh9SdDkwtpi0Jl7CJts8wZcvyBH
         LXA1UuI5d/9xX6A2YNcF46JGV3rIRpnfpyE7LuJik3GJ+jQAuHpmI7afrjyDyRytpt
         tUBs3uM5dQ7YRZMPXUv/ZXuzTHXKhCt4mPf+nwLlmAaLHQC4ERlD7zJEFpYbTwsOA8
         zJ3Avi07E7ZIDVSYbIxIPII6K4Im39D/SXS7UMZP5kvBVMaNDkAfgCUsEDFdTMBkXz
         G27D1aneBSU/zhDs6m3wC5IanrJLXfXePK876SZlgV+qP77H8uCD6eEISNoqtR4sjK
         nPjijoMT59SxW06MEfFk0OYSmIt/jWIlftUs/An1abMDj3U631+
Date:   Wed, 16 Oct 2019 23:43:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: pass on atomic capability to remote side
Message-ID: <20191016234306.tqaszjc2sfxqg3zr@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20191015010759.2259-1-sandals@crustytoothpaste.net>
 <20191015164028.GA4710@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwtfdwcwzrh6j2kc"
Content-Disposition: inline
In-Reply-To: <20191015164028.GA4710@sigill.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cwtfdwcwzrh6j2kc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-15 at 16:40:29, Jeff King wrote:
> On Tue, Oct 15, 2019 at 01:07:59AM +0000, brian m. carlson wrote:
> > diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
> > index a5c3c04371..670d72c174 100644
> > --- a/Documentation/gitremote-helpers.txt
> > +++ b/Documentation/gitremote-helpers.txt
> > @@ -509,6 +509,11 @@ set by Git if the remote helper has the 'option' c=
apability.
> >  	Indicate that only the objects wanted need to be fetched, not
> >  	their dependents.
> > =20
> > +'option atomic' {'true'|'false'}::
> > +  When pushing, request the remote server to update refs in a single a=
tomic
> > +  transaction.  If successful, all refs will be updated, or none will.=
  If the
> > +  remote side does not support this capability, the push will fail.
> > +
>=20
> This is implemented with a single space, but the rest of the option
> bodies are indented with a tab. Asciidoc seems to format it identically
> either way, though.

Yeah, my default editor configuration for AsciiDoc is two spaces.  I
noticed that Junio's already picked it up for next, but I'll send a v2
with this fixed in case he wants to merge the fixed version to master
instead.

If it's more convenient, I can send a follow-up patch fixing the whitespace.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cwtfdwcwzrh6j2kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2nqwoACgkQv1NdgR9S
9ovlrg//cB9mFUZXS119y3uIImBpLkakxyziBfa3MBkKtMFpFoGXLzkEvBskXBh/
Hlt/8Oz4NLvryccj88bIjLDmXsOOgwK054pkBf9WhEc9YIzi5BtvlsyTLm/6X0Aa
1rq0F76OOvUrR+Hy+UcXn+y4RQzLr4TtSXvLWYCb7/18qAmAY0Dg9zgukQSU9lIx
sDJASgalGOVtzrjajDhtyagYNvmifEGnKGWHA01F2tBBAKOXxjHJ1mmZafO6IHL8
OEYZLOaN5IsGElwgxhn5s81s9Vxz/k1Lq+ZyVyMRxngz+C/VE49p68XVIqhwSQal
EcufU38PG58ocucOEyY1p6iFPWb7HVDfEQ6bmqtlqLrnMpOqTu5njabsRE4vqCcI
pgWZKeVOOQ7yS7N+f6C6m8Umpqzxy1ewNGIzEzhOER9oNvLzucmblD1aClkbHdxL
WcWQiaS6rGcNXNt2G86SFDO4FSHiGWXLfEHPm7qyXQqB1X+okwP8iFSHk6jQjjVb
dv777QElVzCVuYbcGV4GCo9VIlK+Pmr7MpqAJOfNqVAtZLIE3anTVFEUj90VEe2M
njFA60N/nJtfP9xk1KbE9RN06ZSYbx4e3sMIeKr1qlb7zXKuwzY4qP3JGdfwG2FD
jqmVXpVIcc0/XgYNzU5D4DIUrzWWoWyvwakibnOKDBqfQDkX7fY=
=Hu5F
-----END PGP SIGNATURE-----

--cwtfdwcwzrh6j2kc--
