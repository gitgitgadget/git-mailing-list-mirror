Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3AC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B618E64F8F
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 21:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhCLVOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 16:14:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39268 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235148AbhCLVON (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 12 Mar 2021 16:14:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2F9FB6046C;
        Fri, 12 Mar 2021 21:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615583652;
        bh=oezTvvZTjWvgwfpYDj6vPfLykO1RS/HvAeJ6jpSSdrc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=whioCRLPqLkYMuudBYsDsfvIEkQlR5wCzpNdCQJidm6LaxDC5jpfTCFKbpmFJowpw
         o1LvKl0K4De7ubHbLWfQ1TYfkW+KlyGF9TzU7ihUagYgogAouk0GkspMcOmEg1Fiws
         mnMZLartXwKpCpCLB/1OmjrlNW6jwbQ3H3eMqqdmdXRiAq8D07wzCzZURggM6ZgHDv
         86Iyb84xYyuqDnKBuPJ9WkKu7u9HZ1GSrw8pUZCnxgRQDj6czsW6J0/GLsoI1PTI4x
         f47+U5gsczMqLgYlRAA4mQPpjwzRBG6MUH9vAWJx8OkHjp5hxBwPDW2iw3Xp85xLOy
         saXm1Mi1hneaTtMow1UqH813/kDjysGjk0YrArd6lrjHPb6mb0lj9jqoXtN/mdXJOS
         Rmm1fd/9G6XBeAwZVBr5J5/k5sJjdcnVhIf2tp5h3/hvRQVDF72I9l2avUn6wktBFc
         2vMEolEaREbOks/b9xMZxseGY1JUMTPgxzuXYtZEdKPTP6HHtuf
Date:   Fri, 12 Mar 2021 21:14:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Steven Kelly <stevek@metacase.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: [BUG] Error adding 2+ files after init --shared on Windows with
 fscache
Message-ID: <YEvZnm1z7nm6ctHA@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Steven Kelly <stevek@metacase.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
References: <AM7P194MB0900C227791B8B7AA1D34DBEA66F9@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DoWEJWXY79Gs9SK2"
Content-Disposition: inline
In-Reply-To: <AM7P194MB0900C227791B8B7AA1D34DBEA66F9@AM7P194MB0900.EURP194.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DoWEJWXY79Gs9SK2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-12 at 15:52:43, Steven Kelly wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> Clean install of Git on Windows 10 using default options
> git init --shared
> echo x>x
> echo y>y
> git add -A
>=20
> What did you expect to happen? (Expected behavior)
> The two files are added with no errors
>=20
> What happened instead? (Actual behavior)
> error: unable to create temporary file: No such file or directory
> error: y: failed to insert into database
> error: unable to index file 'y'
> fatal: adding files failed
>=20
> What's different between what you expected and what actually happened?
> The add command fails with an error 'unable to create temporary file'
>=20
> Anything else you want to add:
> If I omit --shared, there is no error
> If there is only one file, there is no error
> If the echo commands do not have characters, just adding a blank line, th=
ere is no error
> If I turn off fscache, there is no error (git config --global core.fscach=
e false)

Seeing this definitely makes me think this should be reported to the Git
for Windows project (https://github.com/git-for-windows/git) because
that's a nonstandard option that's specific to Windows.  I don't think
anyone here (other, of course, than the Git for Windows folks) is
familiar with how that option works and since it isn't part of core Git
we wouldn't be able to fix it.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--DoWEJWXY79Gs9SK2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYEvZnQAKCRB8DEliiIei
gZHtAQCOd2vPpN1r8D9kMeRaipSAN62fJWDJ5ZHZGhME0ZboLAEAtXcY2w9RD85L
+RD5ro8mGl3C4j0bOJ5sPaV9gBNHkQw=
=/dOm
-----END PGP SIGNATURE-----

--DoWEJWXY79Gs9SK2--
