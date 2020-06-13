Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3022C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7607D20739
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=schrab.com header.i=@schrab.com header.b="yDzAVNoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFMAZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFMAZR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 20:25:17 -0400
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Jun 2020 17:25:16 PDT
Received: from pug.qqx.org (pug.qqx.org [IPv6:2600:3c02:e000:5::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6067C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 17:25:16 -0700 (PDT)
Received: by pug.qqx.org (Postfix, from userid 1000)
        id D24861E8B5; Fri, 12 Jun 2020 20:16:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schrab.com; s=mail;
        t=1592007414; bh=m7v4Cja9fCTGdQakcX/Guk+xeGl38sgr9hhO5ROhY8I=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=yDzAVNoXYNmaOk7MnpzPlslZ1soaeAYx2yTtG442rrHK99PCyE02hnNe1Rdv596Be
         OIE9wmILFzhL4aK5mUjWxRXy5KH2OQX5+sO7mhpWAu3U1baDItjwdBqqfKMY1kmPXg
         a58HEm16A89R6LCE7e+AymsOmXcrxpDH1YEhKfpq/QTIJzcLk+kzLAD3ugiHU/bdcj
         6AupwIv05KNn+tx4SngZbOD6xEECxlJNeSz9bM0n/sqlUKSHbnBqUD3xCIaUf92Bmt
         l6wMPPkXEBM8sFP0UtSyUtBxeBu/jenQX9HoVzEN/g2mtO2wMOB0kOmC21zSQfvrV3
         ffkafJZeEvkjw==
Date:   Fri, 12 Jun 2020 20:16:54 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shreya Malviya <shreya.malviya@gmail.com>, git@vger.kernel.org
Subject: Re: Question: Setting the Email Address in ~/.gitconfig
Message-ID: <20200613001654.GA190001@pug.qqx.org>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shreya Malviya <shreya.malviya@gmail.com>, git@vger.kernel.org
References: <CAEqpqjGNANrCX0wMDUP+dZ+_PdMveSJf6XFyiCpJdUH5t6jXvw@mail.gmail.com>
 <20200611225216.GZ6569@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200611225216.GZ6569@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 22:52 +0000 11 Jun 2020, "brian m. carlson" <sandals@crustytoothpaste.ne=
t> wrote:
>On 2020-06-11 at 21:25:45, Shreya Malviya wrote:
>> My question:
>> It would be much easier if git didn't allow changing the email address
>> so easily. Why hasn't git implemented OAuth, or something of that
>> sort, for every time that the email address is changed in
>> ~/.gitconfig, yet?
>
>This is a local configuration file, so asking someone to implement OAuth
>to change a local configuration file wouldn't be helpful.  Many Git
>servers are, for example, SSH only, and so OAuth isn't even a
>possibility.

Beyond that, even if git *did* somehow provide strong authentication of=20
the configured email address for commits, it's open source software so=20
people could still quite easily disable that authentication to spoof=20
commits as other people. They could also use some other software=20
(possibly that they write themselves) that manipulates a repository=20
without doing that authentication.

While the data is entirely on an untrusted system (however you want to=20
define trusted), the operator of that system will always be able to=20
manipulate that data.

The alternative to this would be to require all commits to be=20
cryptographically signed. But, most projects consider that to be too=20
much of a burden. After all that only covers who made the changes, while=20
for many things the content of the changes is much more important.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAABCgBMFiEE/uA+7ZsNcEQXIOCzxrrvXm21xyUFAl7kGu4uFIAAAAAAFQAQ
cGthLWFkZHJlc3NAZ251cGcub3JnYWFyb25Ac2NocmFiLmNvbQAKCRDGuu9ebbXH
JWO3D/0cy+/blRTY8Bfk+BKhTlOI5wRYlQi9TyJbx5s7a5FwXvvSiqHFLtPhAg4B
Y0xRS5vGyg5oWg8YnJGdrea7b5eVIb+YhVB4JYNC6NpsqJJP2Km91ZlNbB9OMt6w
fhRzMC2DGWJeK4mpotkLTo6p1D7rVVOxf2lgkG7TI4gylo59Kb0F6VJN/NsnS4Vz
XGKu3jMnLiRLbvrWRgmJ81YZp5B5yQY4xvaLe3stQKpamEeC812nGBv0+0T+Cnb+
8Auv7Zk8910wQzIHZuw1xbO2Y73XMST5oOBDp0zZywfhM7pgGSrJ9Dqjsr617UJq
3ROJ6Dmfvwuih68HXI1sPH/Z0Z+ZPL8gmm0gDQX540rBQm/ZD3iVBGYN9inlB95k
NhVLs0oegA2VMbqd2ulTB4xeTdYDn9gYZ5mES6fXS8oyUlQlCMtyST9BzK3MFPmV
C595+CLamWhMx/2HuWTNro/XXIOJfpuEeeeA5xM/a1XB4lOk482goTTs1tukLHD/
tkmKp/dHDugfeWBKCAi4fTWUYj76RiOEn3l8OyZ0cnLFBwt3McuAPuhHh+RmZG82
CoRf4mUmLeQZOsg1C9XMhe+0y/Vvp1OsON1GrDCq0kjuTGWYMhtsagnZtXhGiegI
XBds57Idw7YgKVH6iB1fdMmS/w+QcVtGhZ/TcKaxA5HXuHE4iw==
=IO4t
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
