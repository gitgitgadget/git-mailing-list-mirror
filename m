Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF11C1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 23:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438471AbfJPXd3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 19:33:29 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45312 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732849AbfJPXd0 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 19:33:26 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A2DA460424;
        Wed, 16 Oct 2019 23:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571268804;
        bh=p3btqwTcVB8BNVwaDKh/KTjTxbZAUJ8Wc+jE6huHCY0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wjRxCSAbV1uFHgbOzmrG3ThK9EyrF6mp2Sz7ykUZDZC0Q5UueZ23VNsCLcw+JU1V9
         imCJ/MAGlYT+59mPzzWAhSoUT9rD4EJYQGdvYhZXaxIRR6mLOOXYaz2Wa8F0utXXdN
         dkdhz7Lvp8X/SatNvscwFZYabuQ/9utOzSjWQQCeKTCBKrI/uDiL7UjKlRqRiEIS4T
         yU7paCOsEGC45W4j6+CIGObxRO8P5w8AmJpWiVqv8HWeHZgMw4YktUh/9q8yl1Z2lS
         vsoHv4tyF9tjeEyTXXrBgbimM2WyO4wfDUm3ADRFawjAP/zc7wYg4R6vGdMCqIJ5XB
         iZOjpPfADdsIZ+7j0y/JmWm6erhljV+o33w0xF+IOn0nlUXyHZoGwO06cHfFbWYy3Q
         40wv6ymHrEZKHr3at1aUyLmk1E6+uFJVI0nIHqbdhAxS6MB2zIs9SySr7NPue4auJQ
         RzDdCS2BcLvhU+8oQFN8qmVu0IhC5CTroM+/MkGyZt/7Wuy0bq7
Date:   Wed, 16 Oct 2019 23:33:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ralph Ewig <ralph.phd@protonmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git smart http + apache mod_auth_openidc
Message-ID: <20191016233319.3rhmekasi5csytyl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ralph Ewig <ralph.phd@protonmail.com>, git@vger.kernel.org
References: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tm2wfspqv26ts5ol"
Content-Disposition: inline
In-Reply-To: <4eb22ffc-77a1-4cd7-2277-bdc57d31186b@protonmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-trunk-amd64)
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tm2wfspqv26ts5ol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-15 at 15:59:03, Ralph Ewig wrote:
> Hi Everyone, hoping you might have a solution for=20
> this problem:
>=20
> CONTEXT
>=20
>  =C2=A0* I'm serving git repos using "smart https" via=20
> apache and basic authentication; everything works=20
> fine.
>  =C2=A0* We're moving to SSO via Azure AD and apache=20
> mod_auth_openidc; this works fine for gitweb (on=20
> the same server as git).
>=20
> PROBLEM
>=20
> When trying to clone a repo with the OIDC setup,=20
> git breaks on the redirect for user authentication=20
> with the following error message (replaced server=20
> ids etc with xxx):
>=20
>  =C2=A0=C2=A0=C2=A0 C:\Users\void>git clone --progress -v=20
> "https://git.xxx.xxx/WebApps.git"
>  =C2=A0=C2=A0=C2=A0 Cloning into 'WebApps'...
>  =C2=A0=C2=A0=C2=A0 fatal: unable to update url base from=20
> redirection:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asked for:=20
> https://git.xxx.xxx/WebApps.git/info/refs?service=3Dgit-upload-pack
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 redirect:=20
> https://login.microsoftonline.com/xxx/oauth2/authorize?response_type=3Dco=
de&scope=3Dopenid&client_id=3Dxxx&state=3Dxxx&redirect_uri=3Dhttps%3A%2F%2F=
git.xxx.xxx%2Fredirect&nonce=3Dxxx
>=20
>=20
> Can the git client just not handle a web based=20
> redirect for login, or is this a configuration=20
> issue? Any ideas would be greatly appreciated. Thanks!

The Git client doesn't handle any sort of web-based login.  In general,
in order to do web-based login, you have to provide a fully functional
graphical web browser, and Git operates in many environments that don't
have one (such as servers, containers, and headless systems).

You should treat your Git server like you would treat any API you may
access, since essentially it is one.  That means that you would need to
provide a way to use some sort of external credential.

I know next to nothing about Azure AD, but it claims to support
Kerberos, so you may be able to use that in conjunction with libcurl's
GSS-Negotiate support and Apache's mod_auth_kerb (which is shipped in
Debian).  I use Kerberos-based authentication for my personal server
(which is Linux, not AD) and it does work, so it is possible to set up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--tm2wfspqv26ts5ol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAEBCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl2nqL8ACgkQv1NdgR9S
9ovhqg//X9DrTANYVhL/iAksZopHr4h9ji7hZfU32MZaIJ58bLoPD0m2gXOp89My
j2gSZomi3RU2m21rV9ot86rUOutjv1Tbqco0uMGfJsDv5OhYAqjHOQNOrDhXKSqz
VSSW0tQgcK0Gz1bbwGQo815S5zkRT8sdOEw2/rYUa7r0Xd1SQfDrJZQ0inAoObZk
/UozFPj2CxbW9+1jx5cxxMDFl0AIb7AQDKEUru6aQwI/8Fr0IJaDAYsV+leidtsS
86Jpwie398vinkrCVigOfsIPJbDja1d4hg8myaHM3hppwFTPujhNigaEYvU+DEqe
kCBI/wzOIrek/Vk2MvxrhFUMclfPq7zmK1wqCxC6o7dsH7v5EGqyM3LGFfKjSGf7
YOH050RMV33Gpf22WAkWNL1tKIEE4W22ea8qrZ12RxPA4BoQ3Hpz5otcCjC2UOcZ
wQzlbRr/EIrYZ0L1G/hXpGaeunBbKLDZYW5/wvvmnh+NpoRPCkbchLxhINk84fSG
y5hHAMRhkuyZTxlR0pKpimKSV1OVC2erO4MC1fyfbjn263v0xTqTwvJwYTZFOUrP
7LfcKb6NftBtNldtLaatZawHKUXMpl2l+ItX3kie+v7XeMMDho9kzpWSsA88XL6O
WhG2fdKcQlVu+ZpDQeUWYSX/YafzQDFyDiwLjUjMe/9t/F21hUU=
=gCpK
-----END PGP SIGNATURE-----

--tm2wfspqv26ts5ol--
