Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7ABC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 23:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjBAXSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 18:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBAXSS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 18:18:18 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243181D924
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 15:17:47 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 909595A210;
        Wed,  1 Feb 2023 23:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675293415;
        bh=PcKf7DEPzR2Fgg6i5CdqurJsx9czcU8bbArrXMpJ+e8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=VlQdQocK/GJD/8mLW+Zk9heePOn++O1NwMLdIzDLLRJ7okYej/uwWBpgaEDXQzoa5
         CUi9ESn1awapeXnSVXnwnVG+o/oGtpI8PqSD5YPL2XVZs8612jLAcstXrnH5kFQXKu
         pZr4ffTHmpKBLi7ozfHO8uQmHfM4ddEZZD3tHsQEqeNdz36hKlXLa6GuvFPOAuvHew
         vF14X/S+Xt7ddHLUvbCiQYNl8saL3aIyw68GRJq5Dl6RuK8UrXPFzaBaSkvprHucep
         x9m2CcYpjuE655hZC4ku2qNX6wXF/3P0jdOo8vQMii3JVCXmIPOL/DHg3eek7ySV2s
         Xc7xbBlIsVyqg8TScougeDypx+Mf0c8NytPPlX+223y+P+uR03g5GB8zt/CoxarkNO
         y8AGMgca3y5NMNmEi52oheUedw1LL4ACgjNLEEv9NreJHLYw0BVLTIoO4wyRoe9ZkK
         +jJzBIIhcmHbp5ZKHq+3YyG4r3w4+d3Wj+WWjCnkZby91ZeYiem
Date:   Wed, 1 Feb 2023 23:16:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <Y9ry5Wxck4s/X2B+@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RpKHuuwaydCLBUVY"
Content-Disposition: inline
In-Reply-To: <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RpKHuuwaydCLBUVY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-01 at 09:40:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> "A spec" here seems like overkill to me, so far on that front we've been
> shelling out to gzip(1), and the breakage/event that triggered this
> thread is rectified by starting to do that again by default.

Sure, that will fix the immediate problem.

> But so what? We don't need to make promises for all potential git
> implementations, just this one. So we could add a blurb like this to the
> docs:
>=20
> 	As people have come to rely on the exact "deflate"
> 	implementation "git archive" promises to invoke the system's
> 	"gzip" binary by default, under the assumption that its output
> 	is stable. If that's no longer the case you'll need to complain
> 	to whoever maintains your local "gzip".

I don't think a blurb is necessary, but you're basically underscoring
the problem, which is that nobody is willing to promise that compression
is consistent, but yet people want to rely on that fact.  I'm willing to
write and implement a consistent tar spec and to guarantee compatibility
with that, but the tension here is that people also want gzip to never
change its byte format ever, which frankly seems unrealistic without
explicit guarantees.  Maybe the authors will agree to promise that, but
it seems unlikely.

> If we wanted to be even more helpful we could bunde and ship an old
> version of GNU gzip with our sources, and either default to that, or
> offer it as a "--stable" implementation of deflate.

That would probably break things, because gzip is GPLv3, and we'd need
to ship a much older GPLv2 gzip, which would probably differ from the
current behaviour, and might also have some security problems.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--RpKHuuwaydCLBUVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9ry5QAKCRB8DEliiIei
gY4RAP9YumfTxga5Adcx9cQLjn0v921PdMKCNA49HmnbCFy+8gEAlDn81QnUvByW
FMNGhbh7z+g9lvW8ct8uFehDHdArTgw=
=Z19O
-----END PGP SIGNATURE-----

--RpKHuuwaydCLBUVY--
