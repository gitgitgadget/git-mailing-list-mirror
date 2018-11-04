Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB561F453
	for <e@80x24.org>; Sun,  4 Nov 2018 19:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbeKEEpU (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 23:45:20 -0500
Received: from mail.smurf.noris.de ([213.95.149.21]:39266 "EHLO
        netz.smurf.noris.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728970AbeKEEpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 23:45:20 -0500
X-Greylist: delayed 960 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Nov 2018 23:45:17 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=urlichs.de;
         s=20160512; h=Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zdlnJogdRLwJOKwmc2wZxzpogoyaEB09j5Jp5VA0Ol0=; b=gLQYT72rQjNOymn0zFTJxeQg+8
        qAH9jQHbJ2XvYyQ4eDtq/S/+ypJaf9teV116Y5uEsWFFR/+UQWztEB1wQAdqtmYPeiHpAPa/u2gyK
        pddOFXG1F8WgXzqOJzLY+zcDCVYQOyY1KQg307GdY7Q+pXsRwVqLY8Z0a4pXhCWzxf/LOoKwCuNIE
        b8JQgF8fsvhnq3qGcYjkXao192FudZhi3PiemL4uATm4avQb+BxzNTko8fV4K2BqLSTSe0jtW/O2F
        kJf1NnmeTyVrw/KhsVn3t1J/0NMOqolisp8bZOz9MFBEe35vgR34NwQXH8BgwpdnVOWmAW1eSr1Bl
        fYMqQzr7pLARzC1NxgBVLy0+Fv2rF512adozYb34lUUvYk1aiCXFLU9RAtah7hrCbjR2hGDpaiul+
        gAbrFXlOF1iRGhaSLbJXkwZAabSpiasHQRgKbGaRfV/MjEpw1wMknkXjilvcIKa7TD0xYyiAL7ESS
        RyzVlsqolOWc47NyANF34xKeof+HhQL6ngxQrlFs9n5c0v7+c4ldtr0t3YWFJZ1j2KtbEk8b1rgHd
        b6/N64EY6pJfL4uqecKCc/mTU4SiPoW0FbV+dgmkObFOGR7SewsH2LQemwFtIck0/bKrKd9crTsa6
        zRt668FVgs+bxvp6d7uM4CsPVDlPZ9qgkgYXi57Nk=;
Received: from [2001:780:107:0:1278:d2ff:fea3:d4a6]
        by mail.vm.smurf.noris.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <matthias@urlichs.de>)
        id 1gJNpZ-000OKU-Ia
        for git@vger.kernel.org; Sun, 04 Nov 2018 20:13:06 +0100
To:     git@vger.kernel.org
From:   Matthias Urlichs <matthias@urlichs.de>
Subject: "git checkout" safety feature
Openpgp: id=AFD79782F3BAEC020B28A19F72CF8E5E25B4C293
Autocrypt: addr=matthias@urlichs.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de>
Date:   Sun, 4 Nov 2018 20:12:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9b9m7eZCkTh2oj9Etu6DveS9k7kgS3J4u"
X-Smurf-Spam-Score: 0.0 (/)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9b9m7eZCkTh2oj9Etu6DveS9k7kgS3J4u
Content-Type: multipart/mixed; boundary="p6BQkFE0fA5UTNKiD1zKUbnL6iXPegHT8";
 protected-headers="v1"
From: Matthias Urlichs <matthias@urlichs.de>
To: git@vger.kernel.org
Message-ID: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de>
Subject: "git checkout" safety feature

--p6BQkFE0fA5UTNKiD1zKUbnL6iXPegHT8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE

Hi,

A recent discussion on LWN https://lwn.net/Articles/770642/ noted that
"git checkout <release> <file=E2=80=A6>" does not warn if one if the file=
s has
been modified locally, nor is there an option to do so.

IMHO that should be fixed, preferably by somebody who knows git's
internals well enough to do so in half an hour ;-)

--=20
-- Matthias Urlichs



--p6BQkFE0fA5UTNKiD1zKUbnL6iXPegHT8--

--9b9m7eZCkTh2oj9Etu6DveS9k7kgS3J4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEr9eXgvO67AILKKGfcs+OXiW0wpMFAlvfRLYACgkQcs+OXiW0
wpP+2w//V1rav7P5GTRf+hROuJ3e5hO3Crh+xUoCA6eVt4WZlB4WX4MVXKMY58O3
KAUrbzWNtPyPVE0If/NljynMhA/WbkJ1Q1rZBSYFsLsH4mLxhzfeG5utAbCB3UQP
w1TNHXkjFrExTnt7UYG4xfAnlAEDkCO9VKmmBM8bOolYB2hfX1Zpbw52mr2UWvPR
RwOYNPs1R3UOwxly5qljFzbNvAdykv77REXozFsfkcfyB5LG0gOrwCufu3ZuOsy4
xAmkm8vYTT/PTqXdPXAOu5Iahv5ChPhdN1ekyeyi645lZpx9JzAA8sMmtPceXe5c
B6Son2ZownI2UJ5dqItsKxmHWSZzdRnUJ1f7YkXMyXG1bH4XI02vEwFM+UwG4+s/
zKwAu7kUtk/ABUeR0dztNOHAo8Ir35fSTZok03OwE/nGoKBjaDGvtdXv8s8bTIW4
nQcy9/CKIcIICGrbzTtRdkBKg0HMcUxL7iRmhIMwpAp4aWTGfM8GuiwDaxUsaHgX
uSPXc7My6RRsgjc6FeciORtYTDOLbzYRscF1MoEUbzHfQL+2Pge5eU/fFf4uA4pi
sOyqVGVum6R3l6afJhuzZ8oXKUBm9p9jhZ3bNOmhmo/e3ak5YFcNJjuFCFPkA4Gc
J1bFaydHEMjT9IYD3UduHlPmEhp3KAXU6z/YZ0bMuI4TdgEhQTs=
=eUWg
-----END PGP SIGNATURE-----

--9b9m7eZCkTh2oj9Etu6DveS9k7kgS3J4u--
