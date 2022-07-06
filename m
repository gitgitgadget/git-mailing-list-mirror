Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1AFC433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 01:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiGFBIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 21:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFBIp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 21:08:45 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A986474
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 18:08:44 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 1DAE05A1A8;
        Wed,  6 Jul 2022 01:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1657069724;
        bh=D08zwTIlCX59c+P/Gi0oxt47huTFepX+YA4TqsPIyu4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XWhv4+mrzGJ0c9M3A6LQwf9tVoT4RhGTkqwMW22j4yKJkdYi9xA3MnkdJuCU/m5iA
         QSY0zt/IoCzZK/TIR5GtF8ijs/33WaoDUGdkhYpgFgXASYo9hSyNpU+6McoQiyTG4+
         /GfqtxX88LzST9ISHEobtDj4lKn6al0cS3uTQGgC0Qmcc/4/HEnkeiL6GkKCe+5oCE
         xJAveHp+PfX1DRmxZEjuHGBWBn+s8FRZsE/HNUdT+NlPNzECrzO+Xr0YbuGEMvQpZ0
         S4NIV3Pzg+3sNke3YdYBeJdFqtFs9bgTfp+FrJBBNbZqe03hnb6NGu5e9x6h6ufNyT
         SnljQ59jJlTkSezC23UeZwScvRG/IiMCZX/1cKgM8vDYm7Ooab3oqXzstMSQ6W0Csg
         JTbRz/k5NPkcfrQlwKDHeh6E9knxPT8HLykpKwaNWhx3NT9BOxXrL1MlWfz2kcccfR
         QAkrunB62YS/hmPvFnev0BiTkiEGz5Vt3FyfV1txhrIS5vJuX+x
Date:   Wed, 6 Jul 2022 01:08:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] sha256: add support for Nettle
Message-ID: <YsTgmv+h2SFFFMga@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <YsTerevSOG9Q76qt@satellite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HuNvb3U4TseDXHU2"
Content-Disposition: inline
In-Reply-To: <YsTerevSOG9Q76qt@satellite>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HuNvb3U4TseDXHU2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-06 at 01:00:29, Ramsay Jones wrote:
> On Tue, Jul 05, 2022 at 11:05:18PM +0000, brian m. carlson wrote:
>=20
> [snip]
>=20
> > diff --git a/sha256/nettle.h b/sha256/nettle.h
> > new file mode 100644
> > index 0000000000..9b2845babc
> > --- /dev/null
> > +++ b/sha256/nettle.h
> > @@ -0,0 +1,28 @@
> > +#ifndef SHA256_GCRYPT_H
> > +#define SHA256_GCRYPT_H
>=20
> I'm guessing you had intended: s/GCRYPT/NETTLE/ here. :)

Ah, yes.  I'll see if anyone has other comments and then send out a v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--HuNvb3U4TseDXHU2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYsTgmgAKCRB8DEliiIei
gTQPAQD/aZvp6bUzBLEP9mmyYGVbvV4Be6YiYeIqfoLKg60XiAD/fU26O0iiP55Q
FiDsfbTFh1qOQ9Ik5m4qQUD2VFTVZgs=
=C1Lj
-----END PGP SIGNATURE-----

--HuNvb3U4TseDXHU2--
