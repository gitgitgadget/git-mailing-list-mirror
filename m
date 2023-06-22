Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C8CEB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjFVVaK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFVVaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:30:09 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F871BD8
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:30:08 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 808035A210;
        Thu, 22 Jun 2023 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687469407;
        bh=uHXAzkUEsiDapvTFAkU85Pbnt6LiRphAeGzb1Ym0Dbw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=HHEh9MgqXStOCPDi1Pew+gdcDY8VovEKZ8dqjllEst0xH+ttPRLsZ2sfUWX8q84Su
         eSbmvNPLGt/AkuDSkoVlA7HGQQXCOSspFVV1kd+I3TcxlTwKuo6ZUNI3t+6XRI2GWN
         tcCOAO6sVzsw/tDmtsDLBFkqrM0AZgH8BrnQREk42w3chWx4mykQgg8pmHwrsCyM6q
         uSiCEeKp9etqbJ4Xv3iSt+6lZZBoStuXZgKsfLjR16q2KIzOc4A3q+dBv1Qtk+zwk5
         ogMmEjMFzgIsMG2C1qC9D7VmMWGgS+TQEItvBSFsWaV3ybCV5+KwUya9qZTcJulEX3
         MJGXLtQS6ebO+GaOg3ajP0/oJ4kDvKiL5RGIehFk3XIdPgmvl1XlR52T4XoSRygKxp
         Zgs+5QOq/iEqSqXLQ979ieGFzQ1r8HoNC3TUCrZhp+/i+U/oT1AWOdYuvz6abPYGZh
         YPlD71DQVlshb/+mKHlQzHeJfTK6ZsC/wdmu3UXICUxjPsNZ7Sp
Date:   Thu, 22 Jun 2023 21:30:06 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
Message-ID: <ZJS9XhlIs4jGBjHE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-3-sandals@crustytoothpaste.net>
 <CAPig+cQ=B7M6nPYx-+gqtsJeSuiqKeQhCfiWmyfjiGXsVnFbTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8ljgS3si8DAs2bcg"
Content-Disposition: inline
In-Reply-To: <CAPig+cQ=B7M6nPYx-+gqtsJeSuiqKeQhCfiWmyfjiGXsVnFbTw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8ljgS3si8DAs2bcg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-22 at 21:18:46, Eric Sunshine wrote:
> The reference to $(pwd) is unnecessary, thus potentially confusing. Simpl=
er:
>=20
>     TRASHDIR=3D"$(test-tool path-utils normalize_path_copy .)" &&

Maybe.  I spent a lot of time fighting with Windows and its path
handling here (as much as writing the initial series).  If that's
possible and produces an acceptable result there, I can consider it for
v2.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8ljgS3si8DAs2bcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJS9XgAKCRB8DEliiIei
gSKVAP9heDrEII50mDPdiQVb8M03bzWHumKEjYvuvirsts6X/wEAtBtpVZ10zs3J
KorbT5LL5fmBbyZ3YJpM/WZaOubEswc=
=0wbz
-----END PGP SIGNATURE-----

--8ljgS3si8DAs2bcg--
