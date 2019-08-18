Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295051F461
	for <e@80x24.org>; Sun, 18 Aug 2019 17:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHRRBN (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 13:01:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57698 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbfHRRBN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 13:01:13 -0400
Received: from genre.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 537206047B;
        Sun, 18 Aug 2019 17:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566147670;
        bh=aPBHJVb+CYRAkMiZSD3kaVhIdMUO8Cta6sVxBy5LeFk=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=OjT8e+0lHFNrZTgXPJh+KrBVoggui5T43YlIlnNNZEdH1wv8WT0NGBp2rzzC0u3Zx
         yqgNm8DOmW0bKySbd3LiqzF9h3+wEJWysOKtlrZPCUBej7ntm9FylYbSrwyALMzvsh
         MsEqgxphrARc6bCKX4Hd2vBioQHikFzV4h9C3dO4tgY1+Taye98IE3xN1rYcVyXyor
         FGwhovUl0aONZLkykjVDNrym4IoDqHmQwAyhe4Z8VsrebGrVZ0s4ovXqygNueGtarv
         vb4p2QSZ8By6D96uo4omDIyk19rRqBkoiji5fBc9pwZsCq7mtQnDLYd8BLTJwsdQQL
         sJ7cziajHfL3cZlPTqLkwH8TuH3DEuwcjpgMl2Hcvq3pYMzBmcK2EJ4WJQPq9jmA3g
         TUNvygnmLpZzqDt3WPBJ34xOms7sGkRkGbhqSc4LLxOapRqlGc9bYJWZu344fc/SK3
         ZIY2LEBDeTclE77AtEU40xhaCJ7xFSCfSAbAU/vTDrSWGuIgiEH
Date:   Sun, 18 Aug 2019 17:00:49 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Gaeseric Vandal <gaiseric.vandal@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Updates on centos7 break git access via  git-http-backend
Message-ID: <20190818170032.GF365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Gaeseric Vandal <gaiseric.vandal@gmail.com>, git@vger.kernel.org
References: <009e01d555cb$6c8ed640$45ac82c0$@gmail.com>
 <009f01d555cc$50564ca0$f102e5e0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <009f01d555cc$50564ca0$f102e5e0$@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-18 at 13:53:28, Gaeseric Vandal wrote:
>=20
> This a is a clarification of an earlier post.     I thought gitweb was th=
e problem.
>=20
>=20
> The actual problem appears to be with /usr/libexec/git-core/git-http-back=
end.
>=20
> Gitweb provides a list to unauthenticated users of available repositories=
=2E  I don't need that function so I have removed that package to avoid une=
xpected conflicts.
>=20
> I recently applied the latest patches on centos7, including git-1.8.3.1-2=
0.      When I try to access git repos (either via web  browser or git comm=
and line.) Repos are configured to require LDAP  authentication.
>
> The httpd ssl-error.log shows
> #
> [Sun Aug 18 09:22:48.113435 2019] [authz_core:debug] [pid 30167] mod_auth=
z_core.c(809): [client x.x.x.x:35876] AH01626: authorization result of <Req=
uireAny>: granted [Sun Aug 18 09:22:48.119012 2019] [cgi:error] [pid 30167]=
 [client x.x.x.x:x] AH01215: Request not supported: '/export/gitrepos/ABC [=
Sun Aug 18 09:22:48.119069 2019] [headers:debug] [pid 30167] mod_headers.c(=
823): AH01502: headers: ap_headers_output_filter() [Sun Aug 18 09:22:53.124=
599 2019] [ssl:info] [pid 30167] (70007)The timeout specified has expired: =
[client x.x.x.x:35876] AH01991: SSL input filter read failed.
> [Sun Aug 18 09:22:53.124723 2019] [ssl:debug] [pid 30167] ssl_engine_io.c=
(993): [client x.x.x.x:35876] AH02001: Connection closed to child 1 with st=
andard shutdown (#
>=20

If this only breaks on upgrade from an older version of Git on CentOS,
I'd file a bug with the CentOS (or Red Hat) folks.  I expect that this
is due to a patch that Red Hat applied, and not really a limitation in
Git.

As you might be aware, Git 1.8.3.1 is rather old; we've just released
2.23.0.  You could try using a version of Git from Software Collections
(2.18 is available) and see if that works better for you, but I suspect
most folks on the list don't pay much attention to versions before 2.0.

Be aware that it may be Apache that's the problem here and not Git if it
was also upgraded.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1ZhDAACgkQv1NdgR9S
9ov7JBAAuBAsQh6mDgrAQPoCeflmKl0n1d1onfGn1jBRjDAsnErO/zh8G6mJoV02
ivaWd35mLZQHi2QJazSuv3V6rACzDMNGMvL1vrbIUI1ulDz0n77xTHGKdC1gbdr8
YngbMDqQgnWnxGHx2p6l1XT9JAnBXRxE+w4YZs+YAvonsgSARlThxNHVknXoPUU0
KK0x0CvQ6Dau52nQd1lXF9EO0NDFSzmg+wjlKVZUtQo92STtu3MZ6PipPt2DFvqN
eMgx6vfI0ZKX3ZMxhgVC7p1cVgxD1qYWOezt1VFnRfCwRCEcW8syDvuLlrcoyBWY
jHlgtYgPdDjCt6UPmxiYjnwa7PpmkgxMGf0OjCBCnWJHOW2S4UiKpzgR5kD5NTM8
Hvop7RhxKk6Ouvc1cfaB+r6LMBVHu2RU+dfi8S2bJsqOQqtJWylzgyOEMIMCLc7C
ICDe8mRQDNeOKvu3xSD4zOl0+4Ds05zLVpqyhgAQN2Ht9fub5dCFmvmu5Qki0RH4
osnMzAwdK4q2MZ8NpHhoKl4gMwTBxfShDUQjLGU36U73tLEOJ4aknaBfb+EHQl1F
1J9+TnvxjHr9oi1PY59AznniyVy+pZ2Hp7SU4a5Fk6HAhdHl+SsH1n6fISWM5RNm
BIxdzn5DuYko2hGdilfDd92EIIRnELxOmwmmRKzU4pjYwvCHYvQ=
=tdtz
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
