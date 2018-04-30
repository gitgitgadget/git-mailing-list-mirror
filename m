Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A52681F428
	for <e@80x24.org>; Mon, 30 Apr 2018 02:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbeD3CJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 22:09:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36342 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750779AbeD3CJi (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 29 Apr 2018 22:09:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8BE5560400;
        Mon, 30 Apr 2018 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1525054177;
        bh=eI0v5slvSBYJHq2R5s+BH1ZifD8HFr7eeEBGl0t0oBk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=geYDOVUH2PssMTh77evYZxhgWzdnjd83625C8A5QWcmryQ1ZfMMB+OrieiOGtgg5Y
         SDJtwYFHNGAyrW9jesR8t5X1vdAbugT9dbZMKQAcZoi8qQMYYzd0vY6MvcviOTaPgi
         +NU6BN4U7q6vaym0bGITOQqK861ghEaQ0+8GVplRrSwxUmGiVlxvcOMpOzhNhbuU8y
         GVqFBC7u+SD+csH18LdTqHYdDiEzq63LFCtAiKHmgk9t2V+yJ4krl1M7t6hpJIZ5VD
         5p/RoeonYG7zXsLGU5rU5RQajxUoLc3EIOr5iQZU0iKbyfIGJqVkMOWGk6CXb03+Re
         /lcnMV0End50JVCdbzGvageYA7QDlFVAHa6BhbXIEPHYGMR0vTQqHXC0J0xNilODd7
         v9b1PR6RDmXrRLmiGIJXYuWOsrjz4YIqPL+DChqtEgB2MxV7STtLYmpkFQE6fc7jGW
         /Rs8GBSrEgp8rlr/8wa/Mba0wqMej0TEUQl65Arz6kqqo/nvW86
Date:   Mon, 30 Apr 2018 02:09:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Patrick Hemmer <git@stormcloud9.net>
Cc:     git@vger.kernel.org
Subject: Re: Bug: format-patch MIME boundary not added to cover letter when
 attach enabled
Message-ID: <20180430020930.GA13217@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Hemmer <git@stormcloud9.net>, git@vger.kernel.org
References: <5e409069-835f-3c85-f55e-c27f534dc9e2@stormcloud9.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <5e409069-835f-3c85-f55e-c27f534dc9e2@stormcloud9.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.15.0-3-amd64)
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2018 at 09:40:13PM -0400, Patrick Hemmer wrote:
> When you use `git format-patch --cover-letter --attach`, the cover
> letter does not have the trailing MIME boundary. RFC2046 states that the
> last part must be followed by a closing boundary. This causes some email
> clients (Thunderbird in my case) to discard the message body.
> This is experienced with git 2.16.3.

Thanks for reporting this.  I can confirm this with a reasonably recent
next.  Let me see if I can come up with a patch.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.5 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlrmetoACgkQv1NdgR9S
9oth5w/9GMxkrNjuF+Vw/CKgLWaU7IqadBtDvvGop/14Pq9vR+FA2QsMDJL5NYbh
kyaLD7pdkLqnPEIhfwqiXR937j4/anY6w9WdSx3lr5s5IvPLAZFGzuclGGWtXYGV
8regLSaL6tkSfytB6rzKBrObbVvADdZ0/RJiyyGi/SsAaWKKhL32IWHfpv1iw3Fi
Mp7jkzE1xXGiMaUbpGlQ/8ElUNH4wZAIme4AtLujRvBAtlX7yhdTqysPaeKAn3wb
e6sgYxYDjHBVafR2RjFS1ThlcZ8qx3P5PkYiBC3tdt/tDGemRTOYBDUk2mFb/4Xr
gpkye0NXiambk/8pBLS7FaMAAwPmQXr6Reng+HGuQy6Py4AHF1A1IXYFlXu4BjFO
O2wilcnbYXTZIoDkqaXM5vgzRPhzoScD7jBBQjt+mXuuRW39S52TxZ35YYWLSk/F
3AE7owVVDfSQ5e94O6a1Iqziky9s2b00Yh8GyxWeXLy4q0JRgJRZEd1qff6ilW+9
/ZVKiJcHpRQfuRJg7zQL+73tabwP56HolQCmSdTgwO9eHMEiaaW5PmfSh8xJN0Ax
MR3A+aJYXzY1enqZru3T0ppvIWVikfSpICQKAAKwQbOzLlFuO0wr69vYptwFgMAZ
bwNWKEtB3jahcVL1TEXD0N8xxIT8JCxRzM2WX45tp23LUbPikUU=
=vfr4
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
