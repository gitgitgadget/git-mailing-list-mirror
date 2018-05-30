Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85361F42D
	for <e@80x24.org>; Wed, 30 May 2018 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeE3WUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 18:20:19 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58278 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932409AbeE3WUT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 May 2018 18:20:19 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:cc62:bd61:abbd:bc4b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8223660732;
        Wed, 30 May 2018 22:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1527718816;
        bh=ilyik5JGlqIRRsMVsGcIkElQjRaliR47QoXRBl7bWkM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=pbLr5Z2Mz663KxhuUZy6bbL3UFe6hnRLbGHef1rl3LSqa+oOS8zDcKoW/hKigF75T
         L6u1E3qRsSaHaXJwqSQorxGmlVTIkirOtYQjoW8JGFycJ91wJfe4sIpnaYe/hnGVUL
         ZtjzOlgn5uKRe3LH+Fla/uLJwjZcTCH/de4RU8q8OVqhqRLVKXBb4j8gupLXYU4t+c
         RNH/oeE09N/JElXt9Kto2tNAeYOm7c/NMD4UbDvjw0mz5RFucqveRfl9lm1UQngMXm
         ih2BYqZJ9bXX/6fFf5rLGIIEo5CvpKJonBp1i5tk8qsepr+VggJwEsxLqVkAFiKoPH
         7uq+fzMEjgP90Qo8cOBXPQnJl8TDpBEmc1uZIC0TUvgO1zrjGyKmfLqYhAQSkBcpKv
         GKGnhwrpyHybORghPCQFy6wIEUmh6Mti+3reImfeLiQ4y+R3oGD3s9HwHZe+4ugIi9
         ck6l5wRRn++tnLTudons9IlOC3D+//O2CZEZTOCxXobG5EHM2n+
Date:   Wed, 30 May 2018 22:20:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sequencer: ensure labels that are object IDs are
 rewritten
Message-ID: <20180530222011.GC671367@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20180529163236.646275-1-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1805301144470.82@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1805301144470.82@tvgsbejvaqbjf.bet>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 11:54:27AM +0200, Johannes Schindelin wrote:
> > +	git checkout -b third B &&
> > +	test_tick &&
> > +	test_commit I &&
>=20
> The test_tick before test_commit is unnecessary.

You're right, it is.  Will fix.

> > +	third=3D$(git rev-parse HEAD) &&
> > +	git checkout -b labels master &&
> > +	git merge --no-commit third &&
> > +	test_tick &&
> > +	git commit -m "Merge commit '\''$third'\'' into labels" &&
>=20
> Here, the test_tick is required because we commit via `git commit`.
>=20
> BTW another thing that I had been meaning to address but totally forgot is
> this '\'' ugliness. I had been meaning to define SQ=3D"'" before all test
> cases and then use $SQ everywhere. Not your problem, though.
>=20
> > +	cp script-from-scratch-orig script-from-scratch &&
>=20
> There is nothing in that script that you need. Why not simply
>=20
> 	echo noop >script-from-scratch
>=20
> or if you care about the branch,
>=20
> 	echo reset $third >script-from-scratch

That would be simpler.  You read my mind: I needed some script to make
the sequence editor work, but anything would be fine.

> > +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> > +	test_tick &&
> > +	git rebase -i -r A &&
> > +	! grep "^label $third$" .git/ORIGINAL-TODO
>=20
> I would like to verify in addition that /^label $third-/ is present in
> ORIGINAL-TODO, what do you think?

Sure, I can do that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.7 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlsPI5sACgkQv1NdgR9S
9ouo1hAAtv+Hux+ltU0gB9vVnhPNrgc4f9lxCgpyDudI0JhgHm0WmdG7RpWaQTXB
pUyQxnvabbCQeChNjY27nLbwRLK6A1Y4d+IwoInyrHuxKHbw93n8/uyzwNny21YV
xtN+KejHL3G1KamOTpCQhemzQTGpJMIfgH6uN79gvc5xVEmzVsoQXvuXvxwXzcX8
wJLwujV9FmjEFG0quhAoKcOIlVxIoguiLR31vX7vxFG6NdWHCEg2jEvOCxiEuId0
tithxeMnY/SOwKFi7PRZLGfc/Nn7H2OmRsMIwauEbvBotfG04PPzxjcZBSJhgFjA
ocFZGtL5Ibn9NkXi3hG6zm2cebdcrTPuvnBW6Ase+CdfqpMUwGsmAaTMIUVCjACa
FBcQrsBJkSX0/krB8KxjXu4BAJdWEbv6q/OGhDhLpmoBg/l8Pa3N6BuJdN1MW6xP
7DsvtHF2lGKlAR+zBz9ebaVV8LXQ4KPfT5h1VRhv0EQNojPpcIj6CuV8GzqgltTb
7H4D+04CmtmnX980qfqEyAcolFd3EW66/cyrC07SNasxZvbfybpZPRn1r1gHSwMF
KOVR78YmxNYOpxjHGjGuRGDkiwiHjpZMw7pJLIFSJsahrM87lkhJlFtk3UQ7P/eC
6MBHksFT6GU2dYQLf07g1OzlF3e09Xe5zRLXnnSoS7noof0S40k=
=jZhj
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
