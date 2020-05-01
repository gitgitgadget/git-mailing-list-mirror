Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912BCC47254
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA342166E
	for <git@archiver.kernel.org>; Fri,  1 May 2020 23:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ga9/UW+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEAX75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 19:59:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37860 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbgEAX74 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 May 2020 19:59:56 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 057C36048E;
        Fri,  1 May 2020 23:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588377595;
        bh=LvDTlLmo8M4w4FfL23vgC6LZsLZaZpVm5dSK3MneZMY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ga9/UW+uSvEsDpvRRRfin9n7tNXacPUU1jL0+xEYpd5drPGfMEpnE+CLF5mKy/WKq
         jOaG8Gty+E0k4+KQWiS+fRGhe7B7fyD3vyl0L6dNHSaQJ8Kn7R/TNufzgB+MoGJV4L
         EeDzdtSL+e/qtVVFx8g/cA8L5ltN9jtlAM2Ek51ejadH7CsJLJXTGBKBfK9w/2qpiR
         TFAXXvhk33XWKttoeXLpK70I3WVdvp2qAId8yQ1c8WwJ9+47wpQnhdDZa+8jJoWbsb
         9//eDzpcXmFPy0uaOuZV7ca0sFYm7OOPAy4lmBEcVus7c80VpAWdmKTf9uixSN5Bcx
         tiWepsojmoLsU/0RaQ1bB4V4Meq3vgGqt030cdbjU2iFb/2712qca6rdtOUtgKQVDv
         4bMCtDSEr0IO3KQG6qDVA544MHIjIGxFE4XglrGG5d0XayRoWbtxcRzgYvNxEr6DZ8
         BN/NupubUP4K/elh78b1Ft7R2Yf3/BoPza2pBKlZ7HOaen5WVpM
Date:   Fri, 1 May 2020 23:59:48 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200501235948.GD6530@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
 <20200501222723.GF41612@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <20200501222723.GF41612@syl.local>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-trunk-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-01 at 22:27:23, Taylor Blau wrote:
> On Fri, May 01, 2020 at 08:50:48AM -0700, Junio C Hamano wrote:
> > Documenting that "git send-email" can use "git credential" for its
> > password store, if it is not already documented, is of course a good
> > change.
>=20
> I agree completely.

I also concur.

> > But I am not sure why this is "a good alternative".  Having more
> > choices that do not offer anything substantially different is a bad
> > thing.  Is this "new mechanism" better in what way?  Simpler to use?
> > Faster?  Less error prone?  Something else?
>=20
> Ditto. I don't think that an increased surface-area of possibilities to
> specify your password to 'git send-email' is useful. Put another way:
> why *not* use the in-built credential helper, which is already
> supported?
>=20
> Would having it documented eliminate some rationale for invoking a
> separate program?

I think perhaps many folks aren't aware that you can invoke Git with an
arbitrary shell command as "credential.helper", which of course makes
life a lot easier.  So if you want to invoke a separate command, it's
really as easy as this:

  git config credential.smtp://smtp.crustytoothpaste.net.helper \
    '!f() { echo username=3Dmy-username; echo "password=3D$(my-password-com=
mand)"; }; f'

So I think that documenting the use of the credential helper is step 1,
because probably most people _do_ want to use that for their passwords,
and then documenting that credential helpers can be arbitrary shell
commands that speak the protocol is step 2, so that people who don't can
figure out a way to do what they want.

I'll send some patches later which document the latter feature, since I
don't think we mention it anywhere outside of the FAQ.  I actually
didn't know about it until Peff mentioned it to me one time.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXqy38gAKCRB8DEliiIei
gWVpAP99B0eOBp8nYQ+WKHjjPJcosHiV+zxUj79OuikBPYH1ogD7BS1v89cuRBMk
SIjLaCwoIltOlauTRCHwDa27m+jRUQs=
=cY6N
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--
