Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC3C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 22:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjFBWwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFBWwF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 18:52:05 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E9A3
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 15:52:03 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D29455A1A8;
        Fri,  2 Jun 2023 22:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1685746322;
        bh=iV52zJDNeytKSLlmiSnlOuC8luzdYutq55iYPEGdOrI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=w3SVf0eXIGnaHHp2mD1ilvAmUSpmb6QyfMqpKpZvGFZlz3JUR5A2r3ZNvpaVNr4KV
         Dws49tGk4HTi7WJIzVap7YHvBwpeObZH2K8yFCDaQmcvOz6ikzizUDncqu4v1/K4GN
         6PDMLA/nGk4SCa+t1r/u7Z7oDXEeGEEoX19z7rio4yevcwg0/22RcQmcIQo7a1Vd5V
         JI8+gntIX4YZobOvlIOhHSPi/mF6pErYss8vo4SqvDSJG78Pk3Rmuqp0wQGPMjE5Pt
         f2chvNvWdheeS1OM9gWqbJeP03TSQ2kgirPXf0rDTtR/DtMvUhl+E0/2/jFWjlLtnF
         8LRsXlNBu4tDztZ6J9xfxBddfuof5R6Dww5kBdG0OPFmiIscrr0XgdasIvQqyGVaBg
         oNSIfGy11V8WEMWS/YND9rbRq+e/ZxVCvPs6LLWMQTEC+Y0n3e8Z10cRn/plBmcT4K
         vOqAY2O7g5kyq+OdwS2iQgG8tooMlM445XKGKoH94K1dvSsbjwv
Date:   Fri, 2 Jun 2023 22:52:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Duffey, Blake" <Blake.Duffey@noblis.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: CTRL-C in ssh included with git kills the pipe
Message-ID: <ZHpykC3Cm+TzpSSa@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Duffey, Blake" <Blake.Duffey@noblis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <45dd0347ff2646e8a9770644728afb07@BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G5yF+GGJaZx17ILB"
Content-Disposition: inline
In-Reply-To: <45dd0347ff2646e8a9770644728afb07@BN2P110MB1224.NAMP110.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G5yF+GGJaZx17ILB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-02 at 21:55:21, Duffey, Blake wrote:
> The version of OpenSSH included with git 2.41 reports as:
> OpenSSH_9.3p1, OpenSSL 1.1.1u 30 May 2023
>=20
> The version of OpenSSH available from=C2=A0https://github.com/PowerShell/=
Win32-OpenSSH/releases=C2=A0reports as:
> OpenSSH_for_Windows_9.2p1, LibreSSL 3.7.2
>=20
> If I connect to server X with the first client, run top, and issue CTRL-C=
 - I get
> client_loop: send disconnect: Broken pipe
>=20
> If I connect to server X with the second client, run top, and issue CTRL-=
C...
> it ends top and the connection remains

The Git project does not ship anything but source code.  It sounds like
you're using Git for Windows, which does ship a variety of software,
including OpenSSH.  Assuming that's the case, you may want to go to
their issue tracker, at https://github.com/git-for-windows/git/issues/,
to report this, after verifying that there's not already an issue for
this.  That being said, it looks like
https://github.com/git-for-windows/git/issues/3848 may be the issue
you're reporting.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--G5yF+GGJaZx17ILB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZHpyjwAKCRB8DEliiIei
gf0GAP4s/vMccC3rQkfQqamUcqdJB95I09mmKGcyxeP2Zj6jcAD/a/l2MBxLEniY
gDF/cKp5BCqJThljEML1Nefsp7numw0=
=F2Ln
-----END PGP SIGNATURE-----

--G5yF+GGJaZx17ILB--
