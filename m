Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763DEB64DD
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 21:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjF2VRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 17:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjF2VRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 17:17:32 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A13D35BF
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 14:17:20 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9448B5A210;
        Thu, 29 Jun 2023 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1688073439;
        bh=c7VdcChFLZ0lsAIcZ38tMFQDU9KfYYSslaxHai3bXuU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qgTuVhjapkUuoiTJQkv+ce2b30UGgl3D3GlWuBsV8+H2qMBdYKEkRl8bk29dLySjO
         rLXd+dZasn+PSRu5j6rlqlWhLw/sTdevmCxmpb9mJ9v4m5Qeb2M/sh9dmebCygHGW8
         zzgHF54tAygIpYITPJJmStW+9u5l214d0vCVG0iRn1In0FoGzE5uBhtRFMAEiI5okY
         pvOGKU3zh7sqFZOXOc0StKohymFndYk/CIGkjMFFFaXTnVCjFYHjVwe3GNZ9NRlQCU
         HuBZHasvCjzBiFbF9XCwxtwvg/P5tolKd4nKlXN9ULHO63/ha5qO7a+uZHutTFntFz
         7y0SGkK0dx/7UlpXhZG/c7SH9Su/OsHPlNaRRUkwpZFKxypc0Gy8++JFp5KOGBBfZb
         WWxLdp4CE99TarrN6hJQWzCWE0L8bENfsVHEFCikrSnknSg4uJp8kmhad3d9LraI5x
         rIIE7axrd2nYi1/9YGPufsIQCxKwX45+o+qfMQoqm8zOpfIgfHX
Date:   Thu, 29 Jun 2023 21:17:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Adam Majer <adamm@zombino.com>,
        git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XnaUrSmtPnmH9+BY"
Content-Disposition: inline
In-Reply-To: <xmqqmt0iajww.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XnaUrSmtPnmH9+BY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-29 at 05:59:11, Junio C Hamano wrote:
> Adam Majer <adamm@zombino.com> writes:
>=20
> > Is sha256 still considered experimental or can it be assumed to be stab=
le?
>=20
> I do not think we would officially label SHA-256 support as "stable"
> until we have good interoperability with SHA-1 repositories, but the
> expectation is that we will make reasonable effort to keep migration
> path for the current SHA-256 repositories, even if it turns out that
> its on-disk format need to be updated, to keep the end-user data safe.

I don't think that's a good position to have.  I'm not working on
interop more than incidentally at the moment, and to my knowledge,
nobody else is, either.  Absent me having substantially more free time
or having my employer pay me to work on it, it is probably not
happening.

We desperately do want people to move away from SHA-1 to SHA-256, and as
soon as there's tooling and forges to do so, we should encourage them to
do so.  Just because people can't interop existing SHA-1 repositories
doesn't mean people can't or shouldn't build new SHA-256 repositories.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XnaUrSmtPnmH9+BY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJ303QAKCRB8DEliiIei
gdEuAQDVYx9/t6Nui0mLPfkXRBApfAR1lruECJHuYBD9K8sZqQD8DVo9WAUqbitS
bhxE7Rk3dF7MrATfNziboJsRGLNyCgk=
=dUWw
-----END PGP SIGNATURE-----

--XnaUrSmtPnmH9+BY--
