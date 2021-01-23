Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC4C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 01:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B904623A7D
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 01:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbhAWBGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 20:06:02 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58792 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbhAWBFu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 22 Jan 2021 20:05:50 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2633D60D01;
        Sat, 23 Jan 2021 01:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1611363905;
        bh=xi38pNCn+NOC294rbOdZYQpDLj1NvsbOIzFhWgZclX8=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=yuKAJAY8O+rzJAtPE09NGXSYjVnpV7omuJ+7qRP3vPn2DxoyxBBvPxks+GwN3p6v5
         L1mfEO2y+kwz2SWt45qSlffl+IOTqpNQEj3hRZ8qjPxFi1KruPQzElQ7I2GD0i7yhH
         m7iK384eO7kWz5KcROo50saLcQpvlhCJ+DuVqqQEOJHTrSWCuEeHcg6lTFHcUCLl6p
         /VoJzNAC7VXRYoJMB2Vz/I8kDExSSgwtiYrLWLk8LKB8wEowIYJ1EkMrVoAuVLw+yZ
         CEz5TlzzSScPdJjx++N9FGMV7MO2by+kkM9x43rNjeSXJ0KBpBIp8+QVXBX8SoRqys
         FggvGzeB6addBNq22uJ71QG8XvnqwRTSG+iKbJwc9x3Z1wH2pBb1AzlHgurC6eEdIz
         vVHNAbgu9BSRhfX4srcYOoIL8Jdy9vvXTw9Fvc6qAuL0RGP2RrWRZ0DPlXrLF9b7AS
         tXtOvy6TncHghYBKWohBpYraVvaJkyVVXV9ptEvVsO+ZfkS15f6
Date:   Sat, 23 Jan 2021 01:05:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Subject: Re: git archive setting user and group
Message-ID: <YAt2PPM4HRcKva9a@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <043f01d6f0fe$d6ad7660$84086320$@pdinc.us>
 <cef51cd3-c6b5-ed24-f695-83be3a6743b4@web.de>
 <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D297qylnd61cfrSJ"
Content-Disposition: inline
In-Reply-To: <20210122213954.7dlnnpngjoay3oia@chatter.i7.local>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--D297qylnd61cfrSJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-22 at 21:39:54, Konstantin Ryabitsev wrote:
> On Fri, Jan 22, 2021 at 10:00:04PM +0100, Ren=C3=A9 Scharfe wrote:
> > Adding support for using a custom user and group should be easy.  Is
> > this just a cosmetic thing?  Regular users would ignore the user info in
> > the archive, and root should not be used for extracting, and on systems
> > that don't have a logwatch user this wouldn't make a difference anyway,
> > right?
>=20
> Right now, "git archive" operations are bit-for-bit identical across all
> versions going back at least 8+ years. In fact, we've been relying on thi=
s to
> support bundling tarball signatures with git tags themselves (via git not=
es).
> E.g. you can see this in action here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tag/?h=
=3Dv5.10.9
>=20
> If you click on "(sig)", you will download a signature that can be used to
> verify the tarball generated using "git archive".

Please do not rely on this behavior.  I want to state in the strongest
possible terms that this is not guaranteed behavior and it may change at
any time.  We have explicitly said so on the list multiple times.  If
you need reproducible archives, you need to add a tool to canonicalize
them in a suitable format and not rely on Git to never change things.

If you are relying on this behavior right now, I urge you to change that
at your earliest possible convenience.  I don't want to break
kernel.org's infrastructure again, but I'm also not going to tiptoe
around sending patches in fear of that, nor feel bad if it happens again
for this reason.

> I would argue that adding user/group support to "git archive" operation is
> not really solving any problems other than "it's different from when I ru=
n it
> as a regular user" -- and can introduce potential compatibility problems =
if
> implemented.

I agree that this feature isn't really something we want.  Git produces
tar archives for software interchange, in which case producing an
intentionally anonymous tarball is the desired behavior.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--D297qylnd61cfrSJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYAt2PAAKCRB8DEliiIei
gY/0AQDckhAS1Lp6zl/XCMpLnBBeiEgLuj+FjTYtDM3mAXqoSwEAzJPAWTW9S05s
TLMJQK83On2IV0icuT/u929+giRgjgE=
=SZcv
-----END PGP SIGNATURE-----

--D297qylnd61cfrSJ--
