Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340BC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 00:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A694561960
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 00:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhC1Aqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 20:46:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49640 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbhC1AqR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Mar 2021 20:46:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F3F576046C;
        Sun, 28 Mar 2021 00:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1616892347;
        bh=Ccrzj3ne5LkvQ3Jx66hwoXY95/QMmXUmyNV6dfYF4yo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=t69x6g+HvM7xTC4P8wGl9TtBVvS/Toi6iFAZwcH4wFdszOtC91mRJbmc/2yzd21bi
         jaPFSgOWgM3L4t7rrgagUU17/qGDUyUJgNlvIVej8yhxZEwn+gDNtS+zxi8r24i2Ka
         OXW6wuzMYKpevS1bI3bHWAO8aQTfrrtenKRbTLIB7U4opgwBS8vky4wc2UWrXpEM2q
         a/1fCITBPmis+TQVoknHKKQBxMoU7TmhF21u/hSpGqrdkBTbt8x7rwB4pMZlSbKKNL
         M/plyKH0F0d7vOtXOuf21O5SRABOMUObN6gyTxwbPr8ID48uotzxNl94rrSsTyPRCK
         saIKdzGLYx+lHPtXUVn5DuhFeR1gvgD7U46hF4BEO2pJLnPQg97+S0TnJhlmJi8JMm
         g0pFpPmSaiIIDHmOlzf1QOyTipuwtx3CguyF4C1SA6edsohFphmH/3/g6Rc3vZntH7
         3AgXfQIO70WBBdObuZZkHuHx2kCPBSc5FImIslk9HNP6QaEKn3y
Date:   Sun, 28 Mar 2021 00:45:40 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.31.1, Solaris and error: conflicting types for 'inet_ntop'
Message-ID: <YF/RtL+TS6+DNCTk@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T0et+h+qlZl/Et1v"
Content-Disposition: inline
In-Reply-To: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--T0et+h+qlZl/Et1v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-28 at 00:18:37, Jeffrey Walton wrote:
> Hi Everyone,
>=20
> I'm building the latest Git on Solaris 11.3. I use this patch for
> Solaris: https://github.com/noloader/Build-Scripts/blob/master/patch/git.=
patch.
> It ensures -lresolv -lsocket -lnsl (in that order).
>=20
> The build is having some trouble:
>=20
> /bin/gcc -o kwset.o -c -MF ./.depend/kwset.o.d -MQ kwset.o -MMD -MP
> -I/usr/local/include -DNDEBUG -DNO_UNALIGNED_LOADS=3D1 -g2 -O2 -m64
> -march=3Dnative -fPIC -pthread -I. -D__EXTENSIONS__ -D__sun__
> -DGIT_HOST_CPU=3D"\"i86pc\"" -DUSE_LIBPCRE2 -I/usr/local/include
> -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
> -I/usr/local/include -I/usr/local/include -I/usr/local/include
> -I/usr/local/include -DNO_D_TYPE_IN_DIRENT -DNO_INET_NTOP

So you're defining NO_INET_NTOP.

> -DNO_INET_PTON -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES
> -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0
> -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\""
> -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\""
> -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H
> -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC
> -DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -Icompat/regex
> -DSHELL_PATH=3D'"/bin/bash"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"'  kwset.c
> In file included from cache.h:4:0,
>                  from json-writer.c:1:
> git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
>  const char *inet_ntop(int af, const void *src, char *dst, size_t size);

So we're defining one here.

> In file included from cache.h:4:0,
>                  from ident.c:8:
> git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
>  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>              ^
> In file included from git-compat-util.h:226:0,
>                  from cache.h:4,
>                  from ident.c:8:
> /usr/include/arpa/inet.h:43:20: note: previous declaration of
> 'inet_ntop' was here
>  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,

And then so are your system headers.  You probably want to avoid setting
that option, and then things will probably work better.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--T0et+h+qlZl/Et1v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYF/RswAKCRB8DEliiIei
gbV4AP4mej+HcIU8i1/Ir4ikbEzru/mhVynVMPZeGa6pvkk63wD/ZN0e/RvKEsMY
xaGvAeLunjIiWphJgmBe1YQq9aO/+wQ=
=kgb8
-----END PGP SIGNATURE-----

--T0et+h+qlZl/Et1v--
