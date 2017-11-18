Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B662036D
	for <e@80x24.org>; Sat, 18 Nov 2017 21:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760236AbdKRV2l (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 16:28:41 -0500
Received: from mail.zeus.flokli.de ([88.198.15.28]:60154 "EHLO zeus.flokli.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1760191AbdKRV2k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 16:28:40 -0500
Received: from localhost (unknown [185.104.140.104])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: flokli@flokli.de)
        by zeus.flokli.de (Postfix) with ESMTPSA id EBCDF37E52F;
        Sat, 18 Nov 2017 21:28:38 +0000 (UTC)
Date:   Sat, 18 Nov 2017 22:28:33 +0100
From:   Florian Klink <flokli@flokli.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: honor $PATH
Message-ID: <20171118212833.qwcvt2divpi4smtl@tp.flokli.de>
References: <20171118124249.26479-1-flokli@flokli.de>
 <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjtqmvk66ozdbpwa"
Content-Disposition: inline
In-Reply-To: <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
User-Agent: NeoMutt/20171027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hjtqmvk66ozdbpwa
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

>This patch adds support for PATH, but it also removes the fixed paths.
>On many systems, unprivileged users don't have /usr/sbin in their PATH,
>and I know of no systems which provide /usr/lib as a PATH value.
>Therefore, it's possible that this change will break automatic detection
>of sendmail for many users.
>
>I think what you probably want to do is use entries in PATH first, and
>leave the two old values as backups at the end.

You're perfectly right - forgot about /usr/sbin not in PATH for unprivileged
users. Will send a new patch which appends to the original list.

--hjtqmvk66ozdbpwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEdQpT8aoDC+ls4wqU86BgVS9TAioFAloQpfoACgkQ86BgVS9T
Aip/hAgAlejx6A5jH0jehHqtl2SJ79UkfNo80Tdl8s82WdbQDOOnRvu4WWbI++Pi
Dlj/P2Ce7qfr/MDdQ/GBSFPhYMHzvSwMOd0zQr25AkRzsD0K9ZwIXF13rN+Fu0vu
bfFpcU+VgLX5EmkdO2T8JFPSTzxBXQtTG3hCrtEvnN26wTnF1gueTzlhe7UWe6At
0f8cu67pryWh6s4grOBiVNMmhe++gFDXudPMUNB5hhutUqFVS3FJBqHK8B3NE0zK
qDq/DOoha6gMABrvBZfHRQClaJ+37/P2I6mEWK9E/pjl5HzzGEHWaXze1n9J5Kum
hNgdBnlMCS4NEW78u/X/KneLpR5a8g==
=H+06
-----END PGP SIGNATURE-----

--hjtqmvk66ozdbpwa--
