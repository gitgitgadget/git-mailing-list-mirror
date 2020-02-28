Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061EC3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE93222C4
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 22:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mZisVYM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgB1W1R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 17:27:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43510 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbgB1W1R (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Feb 2020 17:27:17 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4F3CD60797;
        Fri, 28 Feb 2020 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582928835;
        bh=I49+Uue+gBV9PkPBmRLmuFKyVNzNiNUm3z9NXu5xAQA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=mZisVYM6e+yT2jyGbgSVhuu3/DHLpggjY93/vz+6TnQQVS37v5ti3rTak+G2yJ3DR
         R8Usgi8SVwbeDwOl5Vq4JBy5oeVfJ09qQeykg+P/E8w567yCe+KH5J/WqtssjBMuxZ
         pP/eXKToVAfmr4408EOLKb9VdJ6T7zE1O9NXL1byMaReinwZnfBANxOXrHHvd8y+Dn
         GTJRviT++TttJvDLRv+akac2WGD2wZBaB2fjD4OTSWDwQQUP7tIlVFsFMIyBxDgAi6
         eR0cqeuL3g/xM0jp+7KgOuTbet35zNzJlzPPUjuK/pVSyUJAYp3rc37w9qeVvf59cT
         7mywmPJ7HIN9KTzWS2u7MnDJQr7jRq8YhycEMypC9G5l9+IjCSmrb+cmD1ccWY8Lrx
         UNXmJQH+6YLFSEzWoR9il7MKPfl93Lkl+Q3uVzc+w26pIaX23m9zCm5/aoJW/2gS8f
         N+CqimfuzlLnI2/OU6565K5p32yVCYMKIUQ2utl/2/7ocHVayEe
Date:   Fri, 28 Feb 2020 22:27:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Signed commit regression?
Message-ID: <20200228222711.GA9290@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
References: <CAHk-=wgg8ctNmHbKjy-yYnz07L3m8=1et_q2FJHKM9mZKXzGAA@mail.gmail.com>
 <CAHk-=whg3uip_N1EjLEzaZNMvS8v+5u2GGueE9Wm2xnY87D+-A@mail.gmail.com>
 <xmqqpndyeim1.fsf@gitster-ct.c.googlers.com>
 <xmqqlfomefj2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <xmqqlfomefj2.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-28 at 18:24:33, Junio C Hamano wrote:
> I've prepared a topic to revert that commit and it is now in the
> middle of 'pu'; it will get merged down to 'next', 'master' and
> 'maint' in due course as other topics.
>=20
> Brian's SHA-256 (1/4) topic had a couple of changes that depended on
> the GPG interface API from 72b006f4 ("gpg-interface: prefer
> check_signature() for GPG verification", 2019-11-27), so I ejected
> them out of the topic for now:
>=20
>     - tag: store SHA-256 signatures in a header
>     - gpg-interface: improve interface for parsing tags

That's fine.  I'll rebase my series on top of that patch.  Thanks for
letting me know.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXlmTvgAKCRB8DEliiIei
gWMzAQDbVI+1H1G56winnGTgt1fqtwG7VLkVyi35XXZNBKtYkgD/ZPILHHLZUO8A
6pejk7nZ5ChLyEWMtPcalNV804yXfgw=
=zJO1
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
