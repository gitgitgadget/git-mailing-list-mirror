Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD4C201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 01:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdBUBLH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 20:11:07 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:39010 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751195AbdBUBLG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Feb 2017 20:11:06 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D14E2280AD;
        Tue, 21 Feb 2017 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1487639464;
        bh=Y5MYmTXM+5r+1nYd6VDREAbSHSDrARp8vE1cbXZRCh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbXkVo7z5onyPjaQf/T+XYXuCYDeLk9Go+wtPfiIO2Gaoc/GXcjzFBXO31tnP+30T
         PHglugL3azbdUQ1QdSSWVYUl2xRVCYxTc/PhDkQYU/su1jXXRM0CPn3dHJUFwpi+qO
         yddKJyn4jz7exMDkEeqi8yMl5gnVLhoXO0kgXQf+Co9CsbF8hynSpP3zjxIZh4D6hw
         ycbaphZ9FnwASpUZWAkkxS9rdnydH0taAEhMjt56Vkheb0cibKy3OnCngxpgwsx4OM
         wvabuNExk156Ik1cWR2MLZLTtKJTN7u2qRevECc4ES5+eMJ0Kq3VlTKyom3rS2wtgo
         D1UTJQ207+lREKjjBPFAZTCBdQBa/NDeGIlfvfgeryLW+8JNMfARfslKATtJIzoaX/
         hYEYLfrD77U4jOWemH+yFA3q1tph+DJm1BbiBuR/UjOAWa3eNL5jd5SNbnyC1GphvD
         ikDTiyK+YGGLPkwf5vShzyB1Sjy3CNqgaFHvTfx1zf4+k/IPkPh
Date:   Tue, 21 Feb 2017 01:10:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 03/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170221011058.cpx7uio6ibkvrtbv@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20170220001031.559931-1-sandals@crustytoothpaste.net>
 <20170220001031.559931-4-sandals@crustytoothpaste.net>
 <20170220080902.vkexezd5solnhrhb@sigill.intra.peff.net>
 <20170221002519.55d4mlljia3mposi@genre.crustytoothpaste.net>
 <20170221010836.nuv6uvyzatql2yyu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yz5mcdhxyvud5rp5"
Content-Disposition: inline
In-Reply-To: <20170221010836.nuv6uvyzatql2yyu@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yz5mcdhxyvud5rp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 08:08:36PM -0500, Jeff King wrote:
> On Tue, Feb 21, 2017 at 12:25:19AM +0000, brian m. carlson wrote:
>=20
> > On Mon, Feb 20, 2017 at 03:09:02AM -0500, Jeff King wrote:
> > > It's a little disturbing that we do not seem to have even a basic test
> > > of:
> > >=20
> > >   git rev-list --parents HEAD | git diff-tree --stdin
> > >=20
> > > which would exercise this code.
> >=20
> > I'm unsure, so I'll add a test.  The only way to know if it works is to
> > test it.
>=20
> Not to spoil the ending, but I did test and it does not work. :)

Well, then I suppose I'll also end up sending out a new patch series. :)
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--yz5mcdhxyvud5rp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlirk6IACgkQv1NdgR9S
9osu9w/+L8tv8lWqNWlNCEsmcIsCIVcNqHn5B4EVWk4Zqj6nLj4z6iXHTtPspG9v
Fn9NF4lxJWfMRqPVaL/1FL+gddCjK+8XPbQeaBOlmzXcocKlKgRs1qXWAXgbbJPG
uUvVFBCfgTDZNi+tC+i/c+exJ0Bv+zHOupwtB/jsgrq1u3JI1TJGh7d1RxDF5QMo
r8ttkvtLzPPZF+eUY8B8XstN3QC9RWbepB+QnCPnAfbvkeOgfhVGaZSotBhk+dwL
VUBCbRU4rXFdI59LbAMA+MxAsqN9mNkJYfYO7PRYU/gDxhdpf2rYFvTW83ryVqy1
4n8h7TSbJqPWE3EAu6FWGsiB8y03J2njt4Th2hwh8iDs9hFsvGIMBOsTHZbWNH94
unmbyj7xVv2Du8lWcwGdNCa8eCRWgT4e2t/C9CtIViqNOWZIr0oVuGu2O1oUMGMH
BQaP6FP28qQJVfrMj7kbRTSol4ccFeQqDQEWpByHaiVyq+S6Wo33SZtGjP+yQaNy
9zr1GPzkIeF64W6yL81kXTOA0YnhHFxz/yCzTJIWVjUjWYeneAALlbzDzI+y4BIV
fWomc1qpIzipfHeReWps2bYTccdC8iFN8uaX01WcT6wE6UPwZcQudBCT968Oo0kJ
WLuighQGtnPzTYdgD/IS4vy4TT9YZqMLZpwUgcKhh+Fw2RgLljI=
=7Plb
-----END PGP SIGNATURE-----

--yz5mcdhxyvud5rp5--
