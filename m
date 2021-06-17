Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F0C49361
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D742B6128B
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 23:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhFQXzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 19:55:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51010 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230484AbhFQXzW (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Jun 2021 19:55:22 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5EA0560459;
        Thu, 17 Jun 2021 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1623973963;
        bh=DfeIu6FFrsAvh0Hw+pQng0O6lOCCbpMEKJqTlDXP1I0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=e6Acf3cf0qtIgFsYMkbxmTP7f5nfqRyiADapgDw4Fk8ep0hOtvg56dyShhc9UPuiA
         2RooFZQ1QP85ovuWJ911M+VDhPR3C2oBBJYpWxAs5gQmeFHVzYqtFmoo9VSIvIJYY2
         He8J/Rnm0ZfjafMtQDQX6oOrfT1Qgau/RY473vwqtv+sVBNSn7XecWX9Fe4/nbvVXd
         XQ0TdJNgF2hIYC6gavaPSDiEJyivgfqAAK4VT1Mmy5KSZFipeY0j8nYrLKdThsHurn
         sRXH4HWYzRMIGW5FoI6Q1xPv9ECHEZ8wLxEjvAmrKkIznt/XfHvrjJLgj/rEnGbsG4
         vQWq/O2kk8Q5jcs5w7IvltEX3gHtatVMOHKBMeoo0nl9l2jC/1Qr4jASnQRaZPYjRm
         qIFFN88GkGXVDLJcXqKy2fT4tcDfUS2iU72ats0t+/bmQ3ovJTRTsVMSvmwPfyjxMv
         uoUiZedUZQF3+12JdxuSpJm/iftx2a4t6wRUK8l+MOA13DlW8B2
Date:   Thu, 17 Jun 2021 23:52:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [BUG] `git reset --hard` fails with `update = none` submodules
Message-ID: <YMvgRjwyrwyLz4SC@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rose Kunkel <rose@rosekunkel.me>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <CAKjYmsELpf9r3bAJj_JUHgVegw_7z2KzyuR_6FYYngpC1XmNeg@mail.gmail.com>
 <YMlLGwScowX8eXeJ@camp.crustytoothpaste.net>
 <CAKjYmsHD2MuTE+drebKichz_0wquPN8ZTLbiPkUCZJyLsSFh8Q@mail.gmail.com>
 <CAKjYmsEHWShuKEOFWnCyU1x5rM7kFrcaN78D7KhhUay8kCvA2g@mail.gmail.com>
 <YMlS+1F9IND7vxNI@camp.crustytoothpaste.net>
 <xmqqeed2sdwc.fsf@gitster.g>
 <3b53846d-7611-521a-274c-473e00266529@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F4P9ZEMq28mjsXfl"
Content-Disposition: inline
In-Reply-To: <3b53846d-7611-521a-274c-473e00266529@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F4P9ZEMq28mjsXfl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-16 at 13:20:44, Philippe Blain wrote:
> Hi all,
>=20
> Le 2021-06-15 =C3=A0 23:10, Junio C Hamano a =C3=A9crit=C2=A0:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >=20
> > > My gut tells me that we should probably mark submodules with update=
=3Dnone
> > > set on a clone as inactive.  Of course, this is a tricky area that I'm
> > > not super familiar with, so opinions or thoughts are welcome.
> > >=20
> > > If folks think this is a good way forward, I'll look into writing a
> > > patch, probably tomorrow evening since it's starting to get late here.
>=20
> This is probably a good fix. 'git clone --recurse-submodules' is really
> too eager to write the 'submodule.active=3D.' config but it should be mor=
e careful;
> the above is an example and [1] is another one.
>=20
> I think it is a good way forward that having 'submodule.$name.update=3Dno=
ne' in
> '.gitmodules' means that 'git clone' would write 'submodule.$name.active=
=3Dfalse'
> to the local config. This way it would still be the case that 'submodule.=
$name.update'
> itself only ever applies to 'git submodule update', which is what is docu=
mented [2].

I have a patch along this line and am looking into some test failures,
so it's not that I've forgotten about it, but that it is, as usual, not
as trivial as I'd hoped.  It may take me until the weekend to come up
with something nice.

Our problem seems to be that once we mark it as inactive, we never end
up initializing the repository even if something like --checkout is
passed (at least in the tests), so I'm trying to come up with an elegant
way to deal with that.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--F4P9ZEMq28mjsXfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYMvgRQAKCRB8DEliiIei
gYqcAP9UmBPlR4fzvUUrgfGJw7PPPzXuJSCWys39CI4ocll5uAD7Bdz9OwuhLBeQ
qC0nSDEdRHvMXa7BoC+aPbL0UZFirwM=
=bj14
-----END PGP SIGNATURE-----

--F4P9ZEMq28mjsXfl--
