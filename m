Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24EEC32771
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 00:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiI0A0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 20:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiI0A0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 20:26:41 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD460528
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 17:26:39 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 4D3B45A1DF;
        Tue, 27 Sep 2022 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1664238398;
        bh=uYYM6E8/lQ+IylHrenP+INHmJCWN4AXIO9rCFTgpZ3c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CLJJFqmXNS0xgYitSlrGl2o46gINsT430ENfVIAIjEpSa4yloWsZAOrtUQ+dkLKfV
         BVIgCeDspEqluxvSXTFN2y1OYzLri3MkjaF97XahOKDlpTFGKd/n1YLKX70rYbM8XT
         OQjkZYUcZI3r0kYe1Z7TrJBUnMvAFp5Lxju/H+/YbuKc6S35QUG7nbsOYRnNLSm8Bp
         X7FHSjfxL8PVSvNY9X82AtgApfypl7nUnl63G7zW0PtU43SI5QnoBaQDc9jGbxxHsa
         PfvS1bUNl1ONwMAcohlALt3GefFaN6Tw1R0i3i1tXaJzaJRXxOzuWdNZjLcixzuHFf
         FKmWFnjIVkOy3mqSU1/NnWb5iSCR1Df3IE2CAAbIEGXA1XzSfgGW+2m6DHpM50HPJw
         AvoJSqH1qtWm6dgFHXdmVJsKjDeDqCTXE9BeuUI63h+3XbALD+Eab6AVcays4xTHpq
         0XtSRmJzCp+gI+pHztNJEjWXzlpX4xGEIQAVn4gT7hl5Fh97lB1
Date:   Tue, 27 Sep 2022 00:26:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git daemon inetd mode: need traffic statistics
Message-ID: <YzJDPNvi5rpN54E6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
References: <robbat2-20220926T041714-401286569Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cn/xdOIDX3ZSa2aS"
Content-Disposition: inline
In-Reply-To: <robbat2-20220926T041714-401286569Z@orbis-terrarum.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cn/xdOIDX3ZSa2aS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-09-26 at 04:21:46, Robin H. Johnson wrote:
> Has anybody got patchsets that let git-daemon send traffic data (to
> syslog) at the end of each request, about the peer, and how many bytes
> in each direction?
>=20
> Hoping somebody has something useful to share that isn't coming up in my
> research.

I don't, sorry.  At work we use a custom proxy which provides this,
which I can't share and probably wouldn't be of much use to you even if
I could since it's very specific to our setup.

My impression is that typically most hosters are moving away from port
9418 because it isn't encrypted or secured and anonymous HTTPS is just
as easy to use.  As a consequence, git-daemon isn't typically seeing a
lot of development since it is seeing less and less use.  Having said
that, I'm sure a patch to git-daemon implementing this feature would be
welcome, whether from you or from someone else.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--cn/xdOIDX3ZSa2aS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYzJDPAAKCRB8DEliiIei
gcZzAP45nFgDHaCp5wOQh3Zz23+GPHdY7d3a2AMaYPO3u1+MOgD/f917L99Z5G1X
493eox71WupeUa5zaXgmRaQ3yqV+dAI=
=4lQK
-----END PGP SIGNATURE-----

--cn/xdOIDX3ZSa2aS--
