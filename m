Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E824C00144
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 01:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239604AbiG3Bqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 21:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3Bqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 21:46:50 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66024D83E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 18:46:48 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 357155A1A8;
        Sat, 30 Jul 2022 01:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1659145608;
        bh=eJL9Xr0vwZUtXkA2ETGqvhDDsgC3gC3Vbbomn4iGtVU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oQ1CpYC36ii3vOrXaQ5Hh+TXkunrzF5JOufWbKBCLXXjbhXGdYWi95WAaqe3FkprF
         /Gw5toRfBxOaIUXIk8FIi9FfFCPKIgGSj5g+N7wuICQhhKuZblt5cBleLVw0mgwGsy
         m5cucXt1iklScCOHz9Fj/t1+9H9OtjYvu8zw7Ljw2/wIM3lLtVnAM9J6OVEQ0kU/fn
         268DhslXiJlXHT8RBmUsl6ydI9EhMRY2JvnjQoMyKzsvl1jgHRTblOp6F0CPEJKAn6
         4zoYL+CtIAaj8nAuZmkRuZ/zoCvyg/TAikoxcSx8far7bCpBtWuO+C1CZXlDpwQyOW
         uAg6/TIo/NgtjnoliD2ft+tqCnWIDD9uaAPwlCo9FRAlVXNBPIFJ9USnP5CDK7iLJL
         QgTxRePuEiBl9H2N6jfbeR9VLiovQvDanReLM0kar6Os6jM1ypPcCZAEL7bKz6FWXI
         NPrj5XjDLbaUN9DDKy3Is/V81kKefCuL2kYZc7et0O0wmeYvw3b
Date:   Sat, 30 Jul 2022 01:46:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] merge-file: fix build warning with gcc 4.8.5
Message-ID: <YuSNhhRVpg2oT6ry@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <365e01e93dce582e9d926e83bdc6891310d22699.1659084832.git.congdanhqx@gmail.com>
 <xmqqbkt7api9.fsf@gitster.g>
 <YuQ60ZUPBHAVETD7@coredump.intra.peff.net>
 <YuR5Jado2LrtZUjP@danh.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x6sP7h9SoBns1fGJ"
Content-Disposition: inline
In-Reply-To: <YuR5Jado2LrtZUjP@danh.dev>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x6sP7h9SoBns1fGJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-30 at 00:19:49, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2022-07-29 15:53:53-0400, Jeff King <peff@peff.net> wrote:
> > Tested on a debian jessie chroot using gcc-4.8 and 4.9. Though note that
> > you also need to manually specify -std=3Dgnu99 to get it to work at all
> > with those compilers these days! So I kind of wonder if it's even worth
> > catering to their warnings automatically.
>=20
> Well, config.mak.uname automatically adds -std=3Dc99 for RHEL 7 and
> CentOS7. Can we add the same things for Debian? Or should we just
> remove both?

I don't think we can do that, since Debian kernels don't include a
distinguishing pattern like that[0].  Also, Debian jessie doesn't have a
full set of security support, unlike CentOS 7, and thus I would argue we
probably wouldn't want to support it anyway.

My guess is that Peff used jessie because he uses Debian and it's easier
for him to set up than CentOS 7, not because we should use it as an
intentional target.

Personally, although I don't use RHEL and company in either my personal
or professional life anymore, I think it's probably worth providing a
modicum of support to because they're very common, at least as long as
there are freely available clones with security support (e.g., CentOS
and Rocky Linux) that we can test against.

All that to say that I think we don't need to change config.mak.uname
and can rely on folks just setting -std=3Dc99 if need be.

[0] Okay, there is a pattern, but it doesn't include a fixed string and
neither shell nor make are ideal for pattern matching on it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--x6sP7h9SoBns1fGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYuSNhgAKCRB8DEliiIei
gRV1AQCjpBoiob0D70eAL5U9WelbaD+NwDCEF7IO+zaIebosOQEA4ABKqrb34R2g
4WwDxn40VURM1rNRcExt4Mt2k16Z0Qw=
=oL5o
-----END PGP SIGNATURE-----

--x6sP7h9SoBns1fGJ--
