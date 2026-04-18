Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC53290B7
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776539868; cv=none; b=hIYud8k2vuh3KdxaOfadLyBr/udcQs5dtHGaABeriihfyrCXKTKxkBd4Z01lyTMjpUvx1Bw29GU8ajuMojpD0LMEUkcxbyZ6EbcWlqDCNWYiWmX5x3XNhsLkgy0gLt/WLo/6Xv8S5CdC7PzaNXh1bjJTiAcN6THetfq+hYOCpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776539868; c=relaxed/simple;
	bh=MdWG5j0aXIecyoTrzRHW1viEwCB7Z//5JHUlHImnfnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUhZZArWzHZEVxQ4139WgrnNAVfTdE0F/oyPMDnOE7c5UbP71peFcP40NVV8q3vDAuj+aE+W02f/m56aA7vlrhdsa/GMO3OpBJcG9DfjJUTAKIbUjqhICB1dx65UxOCk4awNhH4IaO6LdvjV7krGKKiM0uaIOUfH01qSCDq/cgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JugQkQxU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JugQkQxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1776539864;
	bh=MdWG5j0aXIecyoTrzRHW1viEwCB7Z//5JHUlHImnfnU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JugQkQxUqmFbvjvCEdYa5DiCOEldhZOtkD+/x7d9Luw8mEvs1+4K/kKl7lHk6WvVr
	 Vzdf82ZotaLAcs0B4zfSpeExE4MbY92MbyXXS2uZGc/ZHIEjTgSKlAwNWUmNkIpetl
	 PqjhjcI3KMIQJ5macCDBOJum7twv3f67X1JliStUstOWpmE69exCC2lmdA8g+rvYD2
	 oZHusUVOCgib7gaYU364ILTdKB20f1SZpnwduPqqIPtURR0lg43sxV6Q3Zkd9MHdIf
	 3fIUKnqOL6FY5zQANvQNz8gdIkb32DnrS38ERQuiQnrNKaydFnHUdJYf+7/f1+Zi8S
	 9igfTsRO/onAOccs4Di5eC4iklp0RRH1Ey3GWrgH3ws3royanimXXz/q9PiZDYBE2p
	 ku6B/UzDQVk8tWJo2WJUXziYqyZiJ7eNt2moKFhy69qPrf+Ov93+QvrzxOHCBpoKo7
	 wRRvEUYtLKP8vXdeQNl25L98BWgJWsFyBhr06BIby06lGdZosTw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:595b:551b:bb54:42ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D7BB8200FF;
	Sat, 18 Apr 2026 19:17:44 +0000 (UTC)
Date: Sat, 18 Apr 2026 19:17:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <aePY1x9uO39p6WDI@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9T3w53/RoDbdqnxu"
Content-Disposition: inline
In-Reply-To: <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--9T3w53/RoDbdqnxu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-18 at 12:17:10, Ben Knoble wrote:
>=20
> > Le 18 avr. 2026 =C3=A0 02:50, Jeff King <peff@peff.net> a =C3=A9crit :
> > Thinking on this a little more, it is a shame we cannot easily enable
> > this for dash. That would hit most CI jobs, but also the local builds of
> > most developers. And finding problems early and locally often saves a
> > lot of time versus finding them in CI.
> >=20
> > Unfortunately I could not find a way to detect whether we are running
> > dash at all, let alone a recent version. But what if we let the user
> > tell us? Something like:
>=20
> I was just wishing for similar! I imagine it would be useful for folks
> who occasionally test Zsh=E2=80=99s POSIX mode and want to see how it han=
dles
> -e

I hard-coded this on with a bunch of shells in Debian unstable using the
below script.  zsh, busybox, and dash passed, while mksh, lksh, and posh
failed.  (The latter are all pdksh variants, I believe, so they are an
important set of shells to consider.)

Note that the script symlinks the shell to `sh` so that everyone will be
on their best POSIX behaviour.

----
#!/bin/sh

dir=3D$(mktemp -d)
trap 'rm -fr "$dir"' EXIT

sh=3D"$1"
ln -sf "$sh" "$dir/sh"

make -j12 all && (cd t && GIT_PROVE_OPTS=3D-j12 GIT_TEST_DEFAULT_HASH=3Dsha=
256 PATH=3D"$dir:$PATH" SHELL_PATH=3D"$dir/sh" make prove)
----

Having said that, I actually think that mksh may be right in at least
one case.  For instance, this diff seems required for mksh to pass t1410
and I believe this is actually the right thing to do:

----
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..f289fc11e9 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -23,7 +23,7 @@ check_have () {
 }
=20
 check_fsck () {
-	git fsck --full >fsck.output
+	git fsck --full >fsck.output || true
 	case "$1" in
 	'')
 		test_must_be_empty fsck.output ;;
----

I haven't checked the other cases under mksh, but I think it may be a
fruitful source of things to look at.  And if you find a bug, I'm sure
the maintainer would happily accept a bug report in the Debian BTS.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--9T3w53/RoDbdqnxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmnj2NcJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3Q5oSj2QmbgfHmh+uj8l4EhZ8RZ2EhAod38DUUaN3Rq
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJ+xAP99S1vF5kSybE8pQVLPkyDx+EZn
1leBJWAvfDP3MPof2wEAxoFPyahX42Ctzl4RcGwG4lBJ5rYOQY9mJCm0BDpRDgI=
=eKEP
-----END PGP SIGNATURE-----

--9T3w53/RoDbdqnxu--
