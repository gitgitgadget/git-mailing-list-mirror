Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4686C1F576
	for <e@80x24.org>; Tue,  6 Feb 2018 11:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbeBFLNQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 06:13:16 -0500
Received: from eight.schwarz.eu ([78.47.62.209]:40200 "EHLO eight.schwarz.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752248AbeBFLNO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 06:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=schwarz-online.org; s=x; h=To:References:Message-Id:Cc:Date:In-Reply-To:
        From:Subject:Mime-Version:Content-Type:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fTjftyrwnzGbpWEgCYJupYPIE6jz0SNSoT3hip85OE0=; b=j69PjjPlI5raJD08Y1XVJCPMU
        UI76PvrN1REEMpM2x7Kyi9nMSvw1fpeqvfvgGDM4zdPpR39zyAyLBUufPxAybi5PLNrbph4nQ47bc
        0K3SnaJaegK5aQwHRwL5wuPNO+BoF383vU9BkhOx4Fhg/S5F8P1Rp4xqmkCActn4v+xUxnBJO6ttO
        EG/w86fK87Av5X/bkTsemMxF/f8oU4YHC2Cy9ttFukHJHjVs67Inc+GkbRdpq4z0U6qcikT4OBVnm
        E5LwdjErziASaOYyYF8+Gk9fQi6tuvkKrYB8DMFtiKQ/6FbISdlbEYJP2wy5EC2fz1mv9ZBe7CuCr
        muVX9Uetg==;
Content-Type: multipart/signed;
        boundary="Apple-Mail=_185916C1-7FA6-4AB2-93CB-6B72651282A9";
        protocol="application/pgp-signature";
        micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: Missing git options
From:   =?utf-8?Q?Martin_H=C3=A4cker?= <mhaecker@schwarz-online.org>
In-Reply-To: <20180206004313.GC7904@genre.crustytoothpaste.net>
Date:   Tue, 6 Feb 2018 12:13:12 +0100
Cc:     git@vger.kernel.org
X-Mao-Original-Outgoing-Id: 539608392.457639-4ef20576b383f2d85ebacb61f5e359dc
Message-Id: <C6AF93BC-048F-4944-AB87-36AC2A5C5466@schwarz-online.org>
References: <AD196D8E-04DB-4274-ADEB-D914A79628B3@schwarz-online.org>
 <20180206004313.GC7904@genre.crustytoothpaste.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: Apple Mail (2.3445.5.20)
X-Received: by eight.schwarz.eu with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mhaecker@schwarz-online.org>)
        id 1ej1BZ-0000qz-HR; Tue, 06 Feb 2018 12:13:13 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_185916C1-7FA6-4AB2-93CB-6B72651282A9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi all,

> Am 06.02.2018 um 01:43 schrieb brian m. carlson =
<sandals@crustytoothpaste.net>:
>=20
> I think this is likely to cause problems.  Many people use git log =
with
> --pretty to format commit hashes or messages into other programs.  I'm
> aware of multiple tools that will simply break if --graph or --patch
> become the default.  Requiring people to retrofit their tools to use
> --no-graph or --no-patch is likely to be a burden.

While I share your concern, this is something that will completely =
freeze development of the git tui which I cannot imagine is wanted.

If this where my tool, I would much rather advertise an output format =
specifically for scripting.

An interim solution could be something like an `=E2=80=94ignore-configurat=
ion` option that allows script writers to get predictable output. This =
however still freezes the default output of git forever.

So you will need something like =
=E2=80=94output-for=3Dscripting|json|xml|whatever sooner or later. =
Mixing up the TUI for humans and for scripts is not going to be fun to =
evolve.

Best Regards,
Martin H=C3=A4cker


--Apple-Mail=_185916C1-7FA6-4AB2-93CB-6B72651282A9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF0EARECAB0WIQRyALCMEeyeJp2h5aqZEm8JhZOQPgUCWnmNyAAKCRCZEm8JhZOQ
PqCrAKDJD0o/IZ0lcy70exiJcWrFmZ5mwwCfcB3WEt/2D6XXQkP9ng4pMEXTmTQ=
=ymgM
-----END PGP SIGNATURE-----

--Apple-Mail=_185916C1-7FA6-4AB2-93CB-6B72651282A9--
