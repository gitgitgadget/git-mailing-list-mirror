Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0084EC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA1520732
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ndckDTz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgFVUWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:22:00 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40088 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbgFVUV7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Jun 2020 16:21:59 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0A06460436;
        Mon, 22 Jun 2020 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592857288;
        bh=BoNtL/WQmhsos2RnG1eeUjhH0J9QkZUcM7GY6dYw9z4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ndckDTz5bYYy8P37bMMwik8pGxlcodjGgJe/nVrlM41OL+fmVdlPnFon5Ano5IbdM
         PaXaxtxgrj2hFfDlN+HZkWoPXEfTgr8nlL1FMaHJ65HvqjU01AO2cYUAQ2ZEFOgsca
         iBueNmTcg7S79j3Y7FjOHkFNz8tvWXJ7mZX8FRJfkfLJquYnqTiXfmycWwhPs886qk
         eCzZdhrJk8kzB8PWRcoR91V7bB0F/WJtQOu3ws5t0giBBEIxH2reOk5K2T0/7Xgd4M
         6NOQn/Kag5a0FpzzV+y4HyKbYPUdrvbsDvZPinCJn+uNkM1BomiGDcKPTmtsR50sWn
         4QMRgTAAGA6B98Xg5+DFLuURW68w+/9fKiw/COPs443NzVa/qyBzHSJafVakmfxHgx
         Iw8icR/6ZsFrS1FQMCQPRvydixjcS2g4/jD77jEn+QG6TjGZu/4JuOICDWGfuKpHKS
         /ftCAfJXL+9/bdC7gcco4R1dmCNDfUldqja/KAA7PneOpzSVrQU
Date:   Mon, 22 Jun 2020 20:21:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Michael Ward <mward@smartsoftwareinc.com>
Cc:     git@vger.kernel.org
Subject: Re: Git 2 force commits but Git 1 doesn't
Message-ID: <20200622202122.GO6531@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Ward <mward@smartsoftwareinc.com>, git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5PFZVUeDPxlnBcQp"
Content-Disposition: inline
In-Reply-To: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5PFZVUeDPxlnBcQp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-22 at 19:40:15, Michael Ward wrote:
> We have some repositories we are hosting here using Apache's DAV module to
> handle remote connections.
>=20
> The repositories are created using the following:
>=20
> mkdir [reponame].git
> cd [reponame].git
> git --bare init
> git update-server-info
>=20
> Our Apache location directive is as follows:
>=20
> <Location /[reponame].git>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DAV on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AuthType Basic
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 AuthName "Git"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AuthBasicProvider ldap
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AuthLDAPUrl [ldap server info]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <RequireAny>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 require [ldap filter]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 </RequireAny>
> </Location>
>=20
> The repository config generates with the values in the core section below,
> and we add the receive and advice sections:
>=20
> [core]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repositoryformatversion =3D 0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 filemode =3D true
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bare =3D true
> [receive]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 denyNonFastForwards =3D true
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 denyDeletes =3D true
> [advice]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pushFetchFirst =3D true
>=20
> The odd behavior comes when we have git 1 vs git 2 clients attempting to
> push in changes on the same branch. Git 1 clients will prompt the user th=
at
> they are out of date and need to pull. Git 2 clients don't and will force
> push and overwrite the head revision. This occurs with either Git 1 or Gi=
t 2
> on the server.

Are you seeing this behavior when users are doing a force push, or just
a regular push?  I see that there exists code for the DAV-based protocol
to fail if a user attempts a regular push and is out of date, but I
haven't verified it works.

If you're seeing this when users are doing a force push, then that's
expected.  The receive.* options have no effect here, since those
require an appropriate git process to run on the server, and you're
using the dumb (DAV-based) protocol, not the smart protocol.  Therefore,
no git process runs on the server, so all the checking is done on the
client side and the client side allows force pushes with an appropriate
option.

If you want to have more control over what's pushed, you'll need to use
the smart protocol instead, which is outlined in the git-http-backend
documentation.

As a note, there are a lot of differences between Git 2.0.0 and the
latest version, Git 2.27.0, so it's probably best if you mention the
full version when reporting issues.  You haven't mentioned the specific
versions you're using, but it's possible if you're using the CentOS 6 or
7 versions that they simply didn't support force pushing in this way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5PFZVUeDPxlnBcQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXvESwgAKCRB8DEliiIei
gSHmAP4hbEHRiqd5XLaozyvZZxnTkpNIMSOtDMIHzh0tdEYjVwD9FA33z31hG0T3
Sv1rvELAnNi6loek/0ghVMGUkwAkXQs=
=JJ1w
-----END PGP SIGNATURE-----

--5PFZVUeDPxlnBcQp--
