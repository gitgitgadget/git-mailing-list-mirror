Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEBC6369E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6AC0221EB
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 23:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgLBXzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:55:12 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:52518 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgLBXzL (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Dec 2020 18:55:11 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 334B06042E;
        Wed,  2 Dec 2020 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1606953270;
        bh=UfCEDD5OH4bS2GljtpQhylf3Q7qsLDeGKfwiDXFh268=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qxV1I7Npgl0KXdX8J6amMF9rhsNSJjfFR6WEaGPre/iV5uyg1MMmYqSQyuHHOqDaZ
         ztvzbRsNKClhyaahnMRIXaxM+DuxHt/zCIay6Ir9Xdpt939BgzYNouxzozzrsrAtOr
         9VURTjvScofbBPgJ3+CiMAuinQK11g/M11r4z2TPzS3wLeqo0oncehVMisvHF0eyHC
         oaV7hRinR6XY/btKADrRBfmCS/uSx8CD6yfxAe93m6YXYqEvRnmMGukoBLOPE1vmRk
         0uhPdsEfkJwpccY1S5E2GzIN2nFtUyF2fBlhQcSu0XWXLY3/ufkyaWgUaaSJVn+Yzw
         Fla0Be4Aa1mcnbH1BI5P2obJzEny6k1RpKwJ+bqOY5KvaUeFXs7UK9UaIrHUwbBAeF
         Rkr8KjOMvOX5BYzr4kVGad5oF/jha08IIHQ1ZQUz6KSJW0lFLpRCO+YodtWS15fYjV
         qSRqlXEK+OMnsLHtF8mseVyT04yEyLlskiCdwG/V/ZY6pRJAn0u
Date:   Wed, 2 Dec 2020 23:54:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/2] abspath: add a function to resolve paths with
 missing components
Message-ID: <X8gpMUtAHsQ/NfTl@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
References: <20201127231916.609852-1-sandals@crustytoothpaste.net>
 <20201127231916.609852-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2012021406020.25979@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v8vIiJw4myzwXqJQ"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2012021406020.25979@tvgsbejvaqbjf.bet>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v8vIiJw4myzwXqJQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-02 at 13:09:49, Johannes Schindelin wrote:
> I am having a hard time with the name `missing_components`. Taking a step
> back, I think that we are interested in essentially two modes: allow one
> missing component, or an arbitrary amount of missing components.
>=20
> If this assumption is correct, we may not even need to count components at
> all. We only need a flag indicating whether we allow only the last
> component to be missing, or any number of components. Maybe something like
> `error_on_missing_parent_directory` or some such?

That's certainly easier.  I hope to get a reroll out this week, and I'll
simplify when I do that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--v8vIiJw4myzwXqJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX8gpMQAKCRB8DEliiIei
gZZuAP9wGgy5qaLmy9hA0pl4OK75diN0933MSsQoMDRpEZ2GCgD/ZD8QWJpJzT73
cKDiRdYWt7KuOLMNbD5tnoJAKIY4rgQ=
=vmu5
-----END PGP SIGNATURE-----

--v8vIiJw4myzwXqJQ--
