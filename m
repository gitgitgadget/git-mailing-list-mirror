Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1B11F453
	for <e@80x24.org>; Thu, 27 Sep 2018 23:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeI1FdW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:33:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:48054 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbeI1FdV (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Sep 2018 01:33:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:596e:6738:f59:e0e0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69B8561B73
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1538089958;
        bh=7T4slD7ZU8RAXNzS0317BdDzBZpTixnHtKsYVUxUvAA=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=r9TvlItCyhu7wi+wB2ZpfXnnHjJEWY59WpBPX5LKzEgKowNQQg1eEK0m6bh2vkHSl
         bZe6gijuEwD1OymX55AsWv571zfk12PbjiCMimNQMyMpKZhykteioX1NShdWXB0fcg
         y6UFVHuzcjTpFU3FsDdwWG1YuHChzDR5nJ1P8oCwDyXy3xbatmiAdSm1hSKXDEp1qM
         F5ea3TdDp1oUXo6yff30VvIIQHY51OyMH1emP6eB39tmktttpGd0XI+JprRPSTqzKG
         Ao8F55pxx8tqeczyDVqH/yxrcYrHP3wR3Ygko2t6t7AfFLZ3ItGKVPPK9QXGl82I10
         YSzqiAdxq+m5aPSil+WOXC5XfTjBX0ElbzKSkIG+codhDQpTa3X9idDqKYTjwm09Q9
         5FrA3m+2DUZvQtZ5wTzlvOJhczpR3uGCNB8K4m0MKXaOkvIYsgpnhBWjEvaO+3T480
         bS6IRBeWvbokOLhVigX6NI8J6Aj9S5iKEsb5CJd0jGDIfl0rPhz
Date:   Thu, 27 Sep 2018 23:12:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: Fixing constant preference prompts during tests
Message-ID: <20180927231232.GI432229@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180926162638.GA28077@SDF.ORG>
 <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
 <20180926213703.GA22278@SDF.ORG>
 <xmqqa7o4j5fi.fsf@gitster-ct.c.googlers.com>
 <20180927004248.GA4550@SDF.ORG>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2AcQh+/kfs26T/w"
Content-Disposition: inline
In-Reply-To: <20180927004248.GA4550@SDF.ORG>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.17.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--I2AcQh+/kfs26T/w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2018 at 12:42:48AM +0000, Tacitus Aedifex wrote:
> On Wed, Sep 26, 2018 at 02:48:49PM -0700, Junio C Hamano wrote:
> > We do not want your choice of gpg.program or what kind of
> > trust you have personally recorded in your ~/.gnupg/ affect how gpg
> > invoked inside our tests work.
>=20
> This makes sense to me now. I get what you are saying. The gpg binary
> installed on my system is fairly new:
>=20
> gpg --version
> gpg (GnuPG) 2.2.8
> libgcrypt 1.8.3
> Copyright (C) 2018 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.=
html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
>=20
> Home: /home/user/.gnupg
> Supported algorithms:
> Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
> Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
>        CAMELLIA128, CAMELLIA192, CAMELLIA256
> Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
> Compression: Uncompressed

I'm using GnuPG 2.2.10 from Debian unstable on my system and I don't see
this issue.

> I'm not sure if that has anything to do with it. I'm going to have to
> investigate further to figure out what is being executed and with what
> parameters that leads to the prerefences prompt. While working with GPG on
> another project I noticed that GPG doesn't like to work with keyrings oth=
er
> than the default ones. I tried a bunch of different combinations of
> --no-default-keyrings, --homedir, --default-key, etc to try to get GPG to
> never touch ~/.gnupg and I couldn't figure it out. It would always re-cre=
ate
> ~/.gnupg and default keyrings and even read gpg.conf when explicitly told
> not to. I suspect that is what is going on here.

It might be worth checking to see if you have a gpg binary or script in
your PATH that isn't the one you expect.  That's broken things for me in
the past.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--I2AcQh+/kfs26T/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlutY+AACgkQv1NdgR9S
9os42A/+NJIP4DuNS/wQd0xO61Ym0GMVF1yEU3OVRqOAO2nv1+uSTArN5DyBKBMU
JbOg2nusCTL+jNTjtTwAOLqKm8AsCGYEf401YmRHtjJzFxTq6JWwmQUuuNx+22M1
oovPEPTbiVropVT/AWhAOfBv0uPuAeK4icwmpWwAdzSsRDE1et46ZtOoHLm2wcN0
HXlgjHbDdPq8Fwia8sB+6hqn0uVPaDa47gDq3zgi26bMzdLFvzUnEMt5s3LSedEj
3ebsMYau8QzHbd4nVXBkIDSbGcomzj9RtJrna2gCtuYmeBREtx0AUyNXPmHFWWXs
JMgBDxuRTr92PWMGIW8C98kQouIHL/aNBLsw+3wlEPUcf1MFcHJXxcB16l/Pj2/4
AtwP0fL1VPxIZDv3NaUfGt1S+UEgS/BfokkQrqAG14i5b0zioXToMksPAgrnJJHN
mNUx0w5QQ9AHLJkIvbc8oblLUE7+5u7vtE84zmXitDhsM9v1A5TlWhiz6nBBu2Va
qsR/JlshQ035RO8m1xOSRU4HcVmXoOU/HRF01ytsq33M/HbbV/R8xQmkI3JxfDPB
CALLH8Uk6SSJyB0eR8qzwcGLbqhA4j99rX/y3IJfHUMWbLyV24l41hqHBj+D88uC
biz5CGu7/adO9JnoUNke6xAnAO1UD84it2GB0WNxbxVPZeoZvA8=
=s+T9
-----END PGP SIGNATURE-----

--I2AcQh+/kfs26T/w--
