Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1513E1F516
	for <e@80x24.org>; Sun,  1 Jul 2018 18:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965356AbeGASP5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 14:15:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49700 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932434AbeGASPw (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jul 2018 14:15:52 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7872:b1da:4747:5087])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 31D9E60102;
        Sun,  1 Jul 2018 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1530468951;
        bh=A0WIAovm6lWWZsB0IqcHP5/Hdeu0SEtnlnpcGxu9iao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=i6X08UiqkffQmanaZ3Sygc5bznoWIkAePu7V08/njX07XjzDavfA8khvknLr+nEUq
         9huhRt4w7m0HnTt5Tc/PFNyfUJjJMgHb2IJoZM9m91tD2C540AY9uUm01XC2NrN7gb
         BUfO2kI2680P42siLJrWdb60J1yJ0soW5AmdDS7jHWNibmrhP3/2birW6QPPNRLf0Q
         TZY5k0u+fCuKKjTD37T5qyaJbEm/kS+dgQXP+1205aBzRag5/rQEkty4sv0FkZ/KD2
         mHXY9siwCnR0EvmMjcFQBmQJJEYtJtworgc+ooL83qu6LF/KIwQ+hlRQ55c1P6aGnM
         0J2uvDA2F4ggeSHYxjOkg2tBf8ZsbTVhFMrSKEp89bXPhCvkLq0vuCF1A1lnMOuY9o
         wwQMeAyz1dKbsU68KOsFhQR8qQ3Z3gJNKTGIIDdDqzi4ISslnmQTU3yAjmFPcJHfQ8
         +LgxNhj7tBX9IQSaNeJUo+z+pOcbXr/kuiWmsgr1EgA5wRlk8Ao
Date:   Sun, 1 Jul 2018 18:15:46 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, contact@emersion.fr
Subject: Re: send-email: change the default value of sendmail.validate
Message-ID: <20180701181546.GD7965@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org,
        contact@emersion.fr
References: <20180629190751.GA2559@miku>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <20180629190751.GA2559@miku>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 03:07:51PM -0400, Drew DeVault wrote:
> The purpose of this configuration option is to prevent your emails from
> blowing up on SMTP servers (rather than Extended SMTP servers). However,
> I find it often confuses people whose patches are otherwise correct, and
> they don't know how to solve the issue.
>=20
> I haven't seen an SMTP server in a very long time which doesn't support
> extended SMTP. The default behavior should probably change. If not, the
> error message should be more clear about action items to address the
> issue.
>=20
> I'll send a patch around to change this shortly.

Can you say a bit more about the exact error message you're seeing?

Are you suggesting that we not limit lines to 998 octets?  I've seen
lots of mail servers that do reject mail over 998 octets.  I've
configured Postfix to do so because being strict on mail standards is a
great way to stop spam.

If that's the issue you're seeing, it might be better to either
automatically encode those patches as binary patches or teach git
send-email and git am how to automatically handle quoted-printable.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAls5GlIACgkQv1NdgR9S
9os6KA//XyDF2FYBEMepW18wSXP35ZnY+YliHdcTt9IJfrGuUbXHzBxwgipMXMVN
qAdF1/c7re46qKbpfkAtnSCwlULh3zxIq90jhKW0+YfcbZFB9Ghdl6/1N6aIoAa9
gjx3yfAANK8wjdw3Ry1TpaWiN1vDn3H8EYagaJU9TlWhZzTjWAMaVdbDzE1Bc+8l
FGmIdWMc/UZ6tN37MEoG0JC5khYUtwf3g3nNgwA6eLtKNd8gmoenpsFJcH8xs1Kz
r626zwQ9BiC9RJbGyuwqL6HHAkxIMW4EeA8MpHBMjBNJhXsBlTL60k+dMY7sBhXp
M++DNt+0M4PLhsFkWvK0Ewbx1qWvmUTXWP/ptu03KGOxkm8EARuRES8Wqj0DqnTj
RuMo5AZlvQxdLi6q4dW0e8CwUZzlkpo/2mn8DTCB+CNcalAg5C595m+9+4AyE1CT
XWYJFgkSqV4LTvkyefAwabJloe49BonYpdtOIddLKZ0eTYy1IDSzaH/8V6/134ob
zaE1+fvbsdCSguAiWPUiBXm2+ow36lV0B4zVSCSryDc+t8D/Q+/c3ruv0+GtzvFu
Llj6aw5y0XIj5hR+SZTEwXkQB1GPY7ApFLZ5MHf6c7v4lNvgAbYmkB6AvbfGRwm2
jbx7U35faOK7n54KtjGEcKiyl0gDI7lQ1Em0d0DO8bLwQNqZpDM=
=zcZb
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
