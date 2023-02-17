Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5573BC636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBQWtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBQWtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:49:00 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C2061AF
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:48:58 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6B8EF5A1E1;
        Fri, 17 Feb 2023 22:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1676674137;
        bh=RTg6J3wAfrl7FBH4OI5Lt5I23YwBUpYtlqZH7Kud3M4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tdJxz0ISGiZ50WvbheOOjD5avC7qtKWMAyVnq68ziFv2eAs6DyPWjCqsR3EqfPqFb
         ty/GM42oEXDyFr6mkdMfN69jFOlabBKH6VHHml9TCJVg+GSyyQDsVd0YXAIpjVi9+U
         tx9enNGmNv2q1MdwY7lPca7lEmWjcVeSWeW/2J37IvZZbv1j9TEWthZ68b56et86le
         2aq3cHES0ba1gNlCmRHOw8Dl0PMgOC80/dxqN5QlIMYCR1UY+m6UdGj3rYobiBlEDp
         xcVOSWuRbVljHXOl4c/e8IcrCNrehKDqqPNKhJ5ad0lRixlz5dTKo1IjKYD41xUz0V
         Wz5fZInMqS2Qu1IWxCfKTS0mmBfV8RJVcauf6TSP2hY/bmZn8ODILudwZDtNaur1ZE
         Jv0I3ASC5akCEkFIiHrKJJejNP5HQ4ybfOs5FJfjErLbZTNdWxG5GTianIzq2x9an1
         OvjYZhbUHBE/R2y+q5VE6RPUQosaEIUrErh//NZUsSR8T9M2+XX
Date:   Fri, 17 Feb 2023 22:48:56 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     rsbecker@nexbridge.com
Cc:     'Emily Shaffer' <nasamuffin@google.com>,
        'Git List' <git@vger.kernel.org>,
        'Jonathan Nieder' <jrn@google.com>,
        'Jose Lopes' <jabolopes@google.com>,
        'Aleksandr Mikhailov' <avmikhailov@google.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Message-ID: <Y/AEWHTJtzBArGNv@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com, 'Emily Shaffer' <nasamuffin@google.com>,
        'Git List' <git@vger.kernel.org>,
        'Jonathan Nieder' <jrn@google.com>,
        'Jose Lopes' <jabolopes@google.com>,
        'Aleksandr Mikhailov' <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
 <00b401d9431b$cc3c4460$64b4cd20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DV4cIX/uqr8yvddI"
Content-Disposition: inline
In-Reply-To: <00b401d9431b$cc3c4460$64b4cd20$@nexbridge.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DV4cIX/uqr8yvddI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-17 at 22:04:19, rsbecker@nexbridge.com wrote:
> I am uncertain about this, from a licensing standpoint. Typically,
> when one links in a library from one project, the license from that
> project may inherit into your own project. AFAIK, GPLv3 has this
> implied provision - I do not think it is explicit, but the implication
> seems to be there. Making git libraries has the potential to cause
> git's license rights to be incorporated into other products. I am
> suggesting that we would need to tread carefully in this area. Using
> someone else's DLL is not so bad, as the code is not bound together,
> but may also cause ambiguities depending on whether the licenses are
> conflicting or not. I am not suggesting that this is a bad idea, just
> one that should be handled carefully.

I think it's pretty clear that if software used Git's libraries, that
the result would be GPLv2.  That might be fine for some projects, and
for others, libgit2 would be more appealing.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--DV4cIX/uqr8yvddI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY/AEWAAKCRB8DEliiIei
gWUhAQCqAjq6VWZO0mWLT3UL9GI2goHCFHkG6ZWN+4ipHsRNUgD/TpvAXghRVB72
p7RTAzbs5UXPsN7LQumfGCZUM1HjcA0=
=qdhs
-----END PGP SIGNATURE-----

--DV4cIX/uqr8yvddI--
