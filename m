Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E66D1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 21:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbeKEGqh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 01:46:37 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:53192 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729162AbeKEGqh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Nov 2018 01:46:37 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5930:2634:17a1:2ef9])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 58ECE6077B;
        Sun,  4 Nov 2018 21:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1541367012;
        bh=rMWFN+9ahzKCwV7Y0hpLH7jpL7Qo1G8u+qgY9D7E9+w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=iOG7EhHaaiuGZkm8lR8dJHS3IqIQKqtboeVSKxlO1H4IfJ+x5Vxa04pFBBRasf+Kr
         uWREuVjloBnjrTzNxV737CWEmwGBoklaNPGMoP2bW/ofvaKwghRQcmvu8isB87RARW
         oqwp2d4hsUJF4re+ZRe2Z+KnJ/W/OzLxJasM7z2XBc4vBKopTM8rv6pyQ6ZuICISJB
         aMIHCZnObpGLtwYZ4poBlM9Kb0REb3QpqIS5mwH8sXk/eIQoHGHwC9DtVvhTwZBOmC
         lUvCbZ3I+DdYlY1v6YuAr6252FTyFol4zc169cXZ7LY84Gvm6E8Ftkr0VNKZnsZG5+
         d0U2o4B2wdPumwj9MLLkmGjP8hyj4ielNXkik7u+wyTy+Xc/TK6EOqQmf3ehlz/iSX
         DI9XbqnvFl+bgSsC8QdezvKfYZOm2PJp4kzRvvLT59xrqQPd+bnEPCyRNoMWgM/8tr
         GGI0oCf/C1TPO4leH6JFrvEuihPglwj3bLWFp0glkxta8xf2HEY
Date:   Sun, 4 Nov 2018 21:30:07 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH/RFC v2] sequencer.c: record revert/cherry-pick commit
 with trailer lines
Message-ID: <20181104213007.GL731755@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20181104072253.12357-1-pclouds@gmail.com>
 <20181104181026.8451-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline
In-Reply-To: <20181104181026.8451-1-pclouds@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 04, 2018 at 07:10:26PM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> When a commit is reverted (or cherry-picked with -x) we add an English
> sentence recording that commit id in the new commit message. Make
> these real trailer lines instead so that they are more friendly to
> parsers (especially "git interpret-trailers").
>=20
> A reverted commit will have a new trailer
>=20
>     Revert: <commit-id>
>=20
> Similarly a cherry-picked commit with -x will have
>=20
>     Cherry-picked-from: <commit-id>
>=20
> When reverting or cherry picking a merge, the reverted/cherry-picked
> branch will be shown using extended SHA-1 syntax, e.g.
>=20
>     Revert: <commit-id>~2
>=20
> Since we're not producing the old lines "This reverts commit ..." and
> "(cherry picked from commit .." anymore, scripts that look for these
> lines will need to be updated to handle both. Fresh new history could
> just rely on git-interpret-trailers instead.

Overall, I like the idea of this series.  This is a much cleaner way to
handle things and much better for machine-readability.  I foresee git
cherry potentially learning how to parse this, for example, for cases
where the patch-id doesn't match due to context changes.

However, I do have concerns about breaking compatibility with existing
scripts.  I wonder if we could add a long alias for git cherry-pick -x,
say "--notate" and have "--notate=3Dtext" mean "-x" and "--notate=3Dtrailer"
mean this new format.  Similarly, git revert could learn such an option
as well.

One final thought: since our trailers seem to act as if we wrote "this
commit" (has been), I wonder if we should say "Reverts" instead of
"Revert" for consistency.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvfZN8ACgkQv1NdgR9S
9otD8BAAxBFG5uIbPyTL5UFWQB203ik6r1moqloimEzXHi/zU9eVtr7M1brnb8/R
YruTtxN65nLWgiio+13yJNyRZunYdQVBPCECfmUEbPigxz4cpkSnLdejsd2nEjlz
k3OiZw7wNoz3wlgvgIOuNI8ZYxfkG7s3VYDFSfQx01XQXrSlFosqGghzpkz0DTP6
7Omq3fZ2GN6zhb6CTgOYII+rbN9VsiehT/uRwYJTrJWg+4pYyz1GlwiU3PpmSwc4
rsDf1CR9bQ8uqYqwQxp5jr2Bd82zBfl0BulGRM9Gvu6rlJ6QW458IM7z9NTbXyXF
L+LPWvchlMCIOKrWlbooVi03kygfO3pooWqUZ1if8yn1ykKlZr84msPkreRgB2EK
0Fyg5KOlqqscHC71Y43495hIAWx+OvxafAlLBDiJZ2+VFEn3ZQuW3qZxr7g2+mmA
GJewktJHzzj2dnDphP7YNpqphJej8s96aMPV9+B8Dp42pvQn+YTnWvi7TXoMu7Aq
ryHAgVv0MI5ZJJTJS7UGjsGHo3LB6s+VDUy1PLmHB1FdeAX23lY7VudFnnGCkRs9
sKdCcvl9wniuKzmyMz6uyAUPpCJJhJVGNn9YpAUTAg8aFhRwSo7CNOJ9dN4MmoBM
yh4n50YhNqlCz9B8g/cPOEe8JXLIeLx6mJdysOWcr87FPaMxkME=
=IhS9
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--
