Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2021F461
	for <e@80x24.org>; Thu, 11 Jul 2019 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfGKPTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 11:19:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56564 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728194AbfGKPTI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 11:19:08 -0400
Received: from genre.crustytoothpaste.net (rrcs-50-84-77-156.sw.biz.rr.com [50.84.77.156])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 08BB260436;
        Thu, 11 Jul 2019 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1562858345;
        bh=FNzLYzhJ1NweAZOxAlZAXYsvpSmuWinzfkyoMkAFwQI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sHn0kZMH8jrObCULNVMXQBStc+I5zIWFgDcUcsGu3heElqxwO/WzWs3dMud8mZi5q
         zG4rergIGKpmZUBP+f2eVvP/Jfw3QEDYyX3kAUrq83/0TQLkXXLyW9wic27u3hrb16
         JFQMxInUFibIUXd5K39B0UgPSkSQXfTsZcdl04908XxSUYffhRJdbkSVGKHACNLvkF
         pc/Zl23ipT1VwgdABWPTd5iumdXj0ng5kNKosO7kQ2V+xltMPjkdFWR/CQi7eqYxTe
         7e0HnfmWdHb82H57tuEz6LpZ/iHQ3VuUt3ZdjmGcWq8rLMEROow0OgrEnA5QbPJTL/
         D1DO526rvIYtocCWrp+IaBF/cMSoZ/iyeAzwvADi+l/w44fLsqo6Y78ftCX1I8EG71
         7IRioKc+juEhyInFX1oY/ILy6bmcnxLiGP28DC9exMEJGwfyCL08o5nYGft+cSuINH
         VYtYwxFdIowb21d+ERIsF4ldVyWrAMbkz7pp1UJOmaPCHBPmvlU
Date:   Thu, 11 Jul 2019 15:19:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] log: use mailmap by default
Message-ID: <20190711151900.GI9224@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ariadne Conill <ariadne@dereferenced.org>, git@vger.kernel.org
References: <20190711081958.2201-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Content-Disposition: inline
In-Reply-To: <20190711081958.2201-1-ariadne@dereferenced.org>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-11 at 08:19:58, Ariadne Conill wrote:
> The `git log` command shows the author and committer name recorded in
> the git repository itself, while other commands respect `.mailmap`
> by default.  I believe this is a bad design: it causes log entries to
> reflect inaccurate information: anyone who changes their name or
> e-mail address will not have that change (recorded in mailmap file)
> reflected when using `git log` by default.
>=20
> Anyone who explicitly wants the current behaviour can clearly request
> it by setting the `log.mailmap` setting to `false` in their
> `.gitconfig` file.

While I'm in favor of using the mailmap by default, typically we want a
way people can override a default setting from the command line.

So in this case, we have "--use-mailmap", but we don't have a
"--no-use-mailmap" (at least, it's not documented in the manpage). I
think we'd want to add such an option so that people can set it if they
need non-default behavior.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl0nU2MACgkQv1NdgR9S
9otr3Q/9FumN+Gq0OL1Gp+ywM1XfJP/sJt7Zviz/+RloREVTuMblMwOxA+DH04pp
z2YvYmOK+7EzPZVE9JBJaX3rfS5p2DI39Pn05gPdWvMZ2GwtDpx49JuDkjW7Pr98
7uHqVProW/wOpsJX0yA5auquHMvfPooIDQXpccUHdCJh3WPJ7IbZe9itj7FPWgxU
EgAPTiqCamdujdqL2CxhsZUb9Eljf1M+G93z6MGEHsLYasMAlGiXF/6o8sYpZplR
3k/xVF0OI1Cnx+7oaiZgzbN1Gg2GRnZPyx908qvya/XTBXDzfe/rFlHpbYR0GSu7
uhyrK3zGJz8FKoYnHfuGcH17JZEcCCACy4hBb/C7Gok66DGTewpHORK+nubrzGYN
nEkuYhp5YwB0lV2IS3VlPUhl/lcC52vZDewEA0V2qupCt4rcthKhsLPOlpTBC0W9
2PAYgp3V9fyGFTjmU2sPxpPMNqy5STRanSeoerhJQlGND/oyZL/tWZUHCyIt2VOX
BVPlr+Kcw7muwe9tuVZDM47vN5jBUe/bhvpTW/GuRFVhIDW63UdAVo5/SVuC77Cj
rISdn4iY7XMlQQT3e8ASEWkY9DbYT/9WvqequKjFN3SSv0aL4STn31M7zJAXLpRI
u8gbVh3jHcQbHAlf2xLoZRKChB9PwctYi6WEeUkIFR5UEPgSq1Y=
=Ic3l
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--
