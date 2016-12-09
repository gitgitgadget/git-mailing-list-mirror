Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D376B1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 22:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbcLIWTv (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 17:19:51 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59860 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750756AbcLIWTu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Dec 2016 17:19:50 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 39DA4282B7;
        Fri,  9 Dec 2016 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1481321988;
        bh=jfcpHgpc7n0nWDn5mJ7XnYGQo3YhY0Ux1Xg2KkGW1VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWVc+QMgm173p1kSY9DoiDG8/aX69H95dQ7NAuNqHkrSk/fZH5uSvH9UrO+AffY/1
         pzZ/diuE8ItUdOMIPXY4XvqS2Sfga4aE50fsKWCjfTNbjbXpW/zDdMpYD2ZdMcgk7C
         tP8dgOjJtaeLoDHWFAg5awdaQC/ky1+4o69PhX8G8ZaiDB4LoAFYG5b1VIlYU4IsCq
         p5vOavCiMNjBuAnLaDOjmBPAhYSi6YM9OtUcV7xUOKHpLk0mO+K2JrMElRpzfbLuLi
         8M4y6YH9FEo9roWLjRlElCdfOBlPy1/JRagxgWsx4p/0hzsN3iHV7merP5wgP531FA
         6EBur1ieLVxZjr7zGmgMuZEe8MMUpq+eoHefwI9gWWrH4SGQ0Kp/dl/Gvl+NPiJd1I
         F/60bS+SQnnSnauZsGkpGGQ92+E0DR7TMsO1ODLTRzD6vQuU/SW8NvCElPdBseYULz
         +0wq8PwfkJxzn2TA0sCZdrWrrOlVJogrjkt1WefADblGavDAf90
Date:   Fri, 9 Dec 2016 22:19:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Turner <novalis@novalis.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
Message-ID: <20161209221854.re6qf3e5225wxvge@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
 <1481231552.20894.20.camel@frank>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2imlqxux2k5jisxb"
Content-Disposition: inline
In-Reply-To: <1481231552.20894.20.camel@frank>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2imlqxux2k5jisxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2016 at 04:12:32PM -0500, David Turner wrote:
> I know of no reason that shouldn't work.  Indeed, it's what we use do
> internally.  So far, nobody has reported problems.  That said, we have
> exactly three sets of git servers that most users talk to (two different
> internal; and occasionally github.com for external stuff).  So our
> coverage is not very broad.
>=20
> If you're going to do it, tho, don't just do it for Windows users -- do
> it for everyone.  Plenty of Unix clients connect to Windows-based auth
> systems.

Let me echo this.  This would make Kerberos (and probably other forms of
SPNEGO) work out of the box, which would reduce a lot of confusion that
people have.

I can confirm enabling http.emptyAuth works properly with Kerberos,
including with fallback to Basic, so I see no reason why we shouldn't do
it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--2imlqxux2k5jisxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.16 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlhLLgAACgkQv1NdgR9S
9ovLIg//aTou3BF21L5S1xnMRDGMElnV64akfBtVSmsfU3ZE8/o8rHt08BRVVaCr
yPeQNS7bxRenSH8hRZIOvDPAG4nkQG4LQpgoQKoEyzU0bpchNc/6/Drm8uLXm0My
lbJzAG7Ph7/5tLq0OWcxZA1nzbwy9uCt3VrS2cYksyXR/kSDIZGhbIdEo5Vc0Dsc
2ZK1+PRl4fE3I9h7IP55G13wr3N7EWNbDdjqG5wah7cSKqeAfEvvlhWJn9Bevz+d
sYFe6uMPHn798whwF9R6iCdSzHm/ZUop2Crc7z8oHC040jAs9w5rS269SIrSKhwD
NUBrWvDZOLShEMEbOwB/ncuIv3fYDOGfjgCQxqiZoWem34aCBkKJDjpdEIqaNbGC
IAd6B5ya4+jps/2qARt0CGmxEM1ShWEKVDQgYNYqAcBFttorLJIsIDOGT+hscMnM
ztYCskPg+m66FCdZ94qM56cehcuwOLZ//pDS2s2BjX0rCqwucxkJ/Noke9GYWyGc
lkT4Ax1BwcU8gtb1jSJJFQkF9HW4IxsADgljC9VlxQ/Wz51IVaICN49rYO7mdej9
uxm5l9/cVIb/1ROnNz10qYMEufwZwnZzLhYcJgRUNQmgnx/CWchyaK0ATjeXlPfa
Z9glgzikfYgN+1TF5cpihEURi3oXqHR9dOyc3g2DUaH0XMFeguM=
=oVwn
-----END PGP SIGNATURE-----

--2imlqxux2k5jisxb--
