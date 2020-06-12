Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98899C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 02:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703AC20835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 02:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="B8yMqRB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFLCYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 22:24:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39272 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgFLCYN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jun 2020 22:24:13 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 84F2A6048A
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 02:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591928652;
        bh=Wx1o2PaOOnXwfHHaAQ/RvZnlMlVKCS5Nj7M4uU+zy+c=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B8yMqRB30Le9Zak93RMCW1Y3ofnbt8m+5v3qa5ELBMxeCds3o355xYx5S2RAB+KoK
         TcrNBlDkWEBC4zfeMrdbtyAqHmT2MedVEfyiU4TiWcoN3vllHp9N1XIU1eLCxseVBA
         Z41gssfyUvBuh3tNRy6EZJo1eAK3vEgJ9ZZlJw8uFzGzxx9tM0d/PM63PT0CoIFFz6
         riLxGXvZSrW/1tlWm9tcI5BRUGfvRSNA7bSmVlf4ecL2Ff5RwDM8ShDe7ua/W8qFjY
         a26M8X0avyDS5T1dmjJDJuAVnr3ZUYIulxSND2XG0LPZ4UypO6t50Fv+crQcEpeVas
         wO0djXc1N9c8l2uZHeJ+NqXrHX0jk5/WpLbX636VXAiC6AosJujEXbx0QChKbZWM0S
         IbFHKnVgrNmGkXnrlxlnixtrvzAxgNp3GRNMaqtFam3SEyv9pgxXGtxIgL8pSbJgHu
         OUyzPimvmNXzpBgzMowbULOR60kET8zjlgXdnpylpnD+d6EjYRc
Date:   Fri, 12 Jun 2020 02:24:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: GPG Commit Signing Project
Message-ID: <20200612022407.GC6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <E7E8DC8B-BB7D-42E1-BD0E-EF59775B9E75@rams.colostate.edu>
 <xmqq1rmmg1ds.fsf@gitster.c.googlers.com>
 <20200612015556.4kvsfcwabuaxuiuc@dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hNrJFWHEm0TKGkuH"
Content-Disposition: inline
In-Reply-To: <20200612015556.4kvsfcwabuaxuiuc@dev>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hNrJFWHEm0TKGkuH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-12 at 01:55:56, dwh@linuxprogrammer.org wrote:
> I now think even that proposal is overly complicated. I think the
> easiest solution is to simply standardize the existing pipe-fork
> interface as the way GPG talks to all signing tools. For signing tools
> that have different command line interfaces than GPG, we can create
> adapter scripts. Tools that want to be compatible can adapt.

This becomes pretty tricky because Git parses OpenPGP headers in a
variety of places (e.g., at the end of tags).  If your proposal is to
wrap new formats in a fake OpenPGP format, like some existing tools do,
then that would be viable, but otherwise you're going to require either
Git to know about your signing format specifically (which is not a
sustainable approach) or some sort of configuration framework like has
been previously discussed.

If you're going to wrap things in a fake OpenPGP format, then you don't
actually need to send any patches to Git at all; you can simply set
gpg.program and continue.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hNrJFWHEm0TKGkuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXuLnRwAKCRB8DEliiIei
ga13AP9GI56gUvjjcuWtz3A0LJs57Hc6zKaIzAyFgePqCqz98gD/X6Cgtwkwf457
Ks+CLwFcN3lMCQ3Rd/wYo3fymkYRnwE=
=G+Yk
-----END PGP SIGNATURE-----

--hNrJFWHEm0TKGkuH--
