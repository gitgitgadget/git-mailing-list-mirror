Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF54C433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 01:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376392AbiEMBtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 21:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiEMBtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 21:49:07 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F75C85D
        for <git@vger.kernel.org>; Thu, 12 May 2022 18:49:05 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B35AE5A236;
        Fri, 13 May 2022 01:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1652406544;
        bh=fQCQ9uU0D6ZsPG9j0iKl0Zy06pszbgmOvFQN1bwNjNE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=eQuKv0VHAZy1jQSX01PkxRPoGAfSUx4VfskKksOkd9tuY9JeWy8KtMrVnYfgByhJL
         fvuKXH6hsEwz/trBuIW2Kyjlb/yk9AQeA1pkC/KojLeZDAaf1HH0GoP+E3mE6G2/HT
         FdHP/3hyNTn7rDQTn9n2OLGTSJFs6DNPMuszt2PpmxFjTPMzl1NTJgBszUMNuXw7MQ
         7229+MSLD8BT7rs30zVgwwmPkskP6nI8N1TVST77gRo82HrmoXjM+FSwPhWEmhas6G
         ZN7qwE9oieCg40gn3oUjKbjN/7Iw/zAGMQuNWUIh1zYl1P22D513sdYZKnMFZNd9ED
         e9Pv/VuzOoF6BHVeLO9pUYgHsjj55EotUo9BK3pskdsUkwXsCJ8X0Ja4OmPr3x6FMg
         WDWoMggDxOTOLAvUXOyC0ehUHXbAx1XZlHv6YqZLxuW6N/ZKjHobQmywj+6ff1X+/z
         hzIxNjE5FIUxaZt07AL/DzpWK8cMxw3+5r7rHZcDgD696yKG+6K
Date:   Fri, 13 May 2022 01:49:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Robert Brown <RBrown@esri.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git issue clone issue with .gdb , .loz, & .las files
Message-ID: <Yn23d9UWONDFzH7n@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Brown <RBrown@esri.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <SA1PR05MB8454906260C1851A39813916ACCB9@SA1PR05MB8454.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yqf4+/R4++A0hx3+"
Content-Disposition: inline
In-Reply-To: <SA1PR05MB8454906260C1851A39813916ACCB9@SA1PR05MB8454.namprd05.prod.outlook.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Yqf4+/R4++A0hx3+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-12 at 15:36:25, Robert Brown wrote:
> Hi team,

Hey,

> I started a thread in GitHub, but they pointed me to you. We're having a =
binary comparison problems when cloning a repo in Git on Windows (git versi=
on 2.36.1.windows.1), LFS is installed but is not tracking files.=20
>=20
> So far we have noticed =C2=A0.gdb, .las, and .loz files are not even clos=
e to the same size and don't open after cloning the repo. Everything else s=
eems to clone fine at the moment, confidence to moving to Git is a problem =
because of this on the team. I'm looking to figure out a way to make sure w=
e are getting binary matched clones when doing so. We sure would appreciate=
 any help you can give us. =C2=A0

As I mentioned, I think Git LFS is a red herring here.  There are no
patterns in .gitattributes, so the fact that it's installed is
irrelevant, since it's not being used.

To summarize what I said on the Git LFS issue tracker, I think you've
seeing a problem with Git on Windows where it doesn't always handle
files larger than 4 GiB properly.  My guess is that if you created the
repository in WSL or on a Linux box, things would work, provided you
used a 64-bit binary.  Can you try doing that and seeing if cloning to
another Linux-based directory works properly for you in that case?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Yqf4+/R4++A0hx3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYn25DgAKCRB8DEliiIei
gUplAQDq2igetjtxVcq3Dq8I/NFG8FyWYK8f8A88JAy3nu1KgwEAi38AKjsOt4Q1
jRJsDh0/yJegi4sFftU35Z2IyuoCcgo=
=pJe0
-----END PGP SIGNATURE-----

--Yqf4+/R4++A0hx3+--
