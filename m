Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86C81F453
	for <e@80x24.org>; Sun, 28 Oct 2018 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeJ2AhO (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Oct 2018 20:37:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727637AbeJ2AhO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Oct 2018 20:37:14 -0400
Received: from genre.crustytoothpaste.net (ip-64-134-145-243.public.wayport.net [64.134.145.243])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9DA1961B73;
        Sun, 28 Oct 2018 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1540741934;
        bh=X5wvPNz/ZmcC1X08/JqqIebrao/aoR4dydzNPtsNpbo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NAly/qVjFy7Gqx4tieE49ZjkWnYxv7QJQsMbtGoAmf6Q9s+BX3cvh52iTK48ZXPHQ
         t12a1jFules7K9ZmsDeNwmRvu7M6g5uz/kt5P2bj0zpW/nr3e8j8/xJ+aq1DpaxcD9
         SGQRYCA+zhYuMvYS0+e3mAgABvyvkGokVkIvne3WcR6ExhJywAGX8rlePK4KfvKWHM
         WtR38I6wmzer0gTmBiVmqeaqAYC6f6kEnGJYSVJ5bATYE+eRezC0KT8Jq6EfV9J/8v
         P14GXroMO87yNbqz0Sp8zygGHGjzhxHVZdJnJkunDkaFq7uHV9e7q3jsylyetoNEaJ
         OzDCFaJirszmeAKWD4n8R36FepDxH8aCoVJBAP62ox3FqeTWnhnYGIBBGnS2SfXL7C
         6xhKWkaeLXi1kX29XPkhwgkxdQs6gZult367uTGUZsubsuBQPbMnTWsE62Kqtgvset
         lrwJI1DqybOYVZeEg6Rhm2fZdSeGT2h6a8K2flxe38hLvd66t9J
Date:   Sun, 28 Oct 2018 15:52:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        pclouds@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 10/12] Add a base implementation of SHA-256 support
Message-ID: <20181028155206.GI6119@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        stolee@gmail.com, avarab@gmail.com, pclouds@gmail.com,
        szeder.dev@gmail.com
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181025024005.154208-11-sandals@crustytoothpaste.net>
 <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <CAPUEspjCjFiwCO8TCM23f2jqFSpy2z05+Ea_zGATy0jh1L83iQ@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 08:02:55PM -0700, Carlo Arenas wrote:
> On Wed, Oct 24, 2018 at 7:41 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > diff --git a/sha256/block/sha256.h b/sha256/block/sha256.h
> > new file mode 100644
> > index 0000000000..38f02f7e6c
> > --- /dev/null
> > +++ b/sha256/block/sha256.h
> > @@ -0,0 +1,26 @@
> > +#ifndef SHA256_BLOCK_SHA256_H
> > +#define SHA256_BLOCK_SHA256_H
> > +
> > +#include "git-compat-util.h"
>=20
> this shouldn't be needed and might be discouraged as per the
> instructions in Documentation/CodingGuidelines

This may not strictly be needed, but removing it makes the header no
longer self-contained, which blows up my (and others') in-editor
linting.  I think it's okay to add this extra header here to keep it
self-contained, even if we know that it's not going to be absolutely
required.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvV2yYACgkQv1NdgR9S
9otBVA/+Ns3T5+q+C2OSBFnkc5lxZ5ogAlFSF1h/Vli0IFXazFFacziAkkql8npX
q9JfH7avQiS6brJMUx2rSo5RL1WSUB8nJHNUgoERnoQZwG4/r66R6hZPyF1WBQ1T
WYRDIyrzI3125n6LU2AhFfRfNHqHeSl2gImLs2Mi9owZG1YdZ6oy5OhXfESqDyyi
Xo8X+FN7271QiMsT69MJwzepN5OOr8LSK7lmUOjr79pi+44oMuoeGhnhI+kp3Ua3
55xJFaodazjEc4vXUZJCMrphU7s5jBp8QLUCQRmFkBlkNqQBcVv1Cbl7OgTczS2y
3jDSpM/6rx0SaLaJDhtBRmCAYZdPk0iNuw9sZ7FoeNiS16q5NmmDoSdOFfyAV+wa
Zu32z+Lr+cWGGUyEC/YdYe6V9n/8T0+UzM+/B0dtgeLdpEpYbOHiVBPjVXrSckDf
PhM+HaZ8F11u1na9+p3darJHrBOn3KNGcNXRdPJ1OPACZcFkUzYjLEA1gdCE5WhR
rmCEErFL4Ml6tRm3U4ZAFemQtz9EC64OvPk3pBskhBmNLyO9l6SIeoLqVLb6IFnk
szk8CmmnqTPigrw2e7r1706SFejlfnHs3xk0Wsncd5w+Zkm5KKlIlqghjsaD7yOF
NhiZkQpCfNeKP5zSBsXeNF1ziyMd6pavDuNaSnEKYWl2lTR7M6o=
=wqfM
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
