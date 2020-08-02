Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15694C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FC32076A
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 01:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XfeV6a/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHBB2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Aug 2020 21:28:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41294 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgHBB2L (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Aug 2020 21:28:11 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3680160799;
        Sun,  2 Aug 2020 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596331690;
        bh=mcJSo8xUrR6/3Js9+43TMnOfTKxCmk9pWnR1ZYcvNI0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XfeV6a/Wn2rD/sA/ZBeF8IoqS0bmGd7Xj4+mluDXDz3WjrfPbx7uEgzfxE9m73jOw
         8E7g+0W/EbWoxDqT+sphKLZTqHd2a0OlIGR4iDzo+7eUWsPLZuJMgmc9w14dY3ISyO
         ifStShWTBOSDFZUdZ752MMFB948HXNNBSAAgqG8ADG/zsoP82ZqDYF5USnWUcBjluy
         MQi9AlGUVQcLnnvOS++eecLczMhOfrwOdph6ZqW5luBth+v/z3NkzsNmwy07pTTjwN
         u+qqoigAu7yJ/OwNcsgb0M70bxkJzg33XSmhY2g4sNal/dBZY5nx6CqW3jKsmh/3Ev
         dyNt0NjUN8CJdkbU8D5KjwZ6dsaQH9x+CV21yskJ+0uQ8d6mWViVcqf2YMs4wIt+bF
         SnQp2eua3RalIT7HDGAG5SFnEvkiAnUTNbpsUIeChlCO1Vg54/eX79dR45qPmhKhWZ
         fkoNUo/yk2xQkIcWNAbF9VM5AB4uQ4Q09gXy4I8j5PPp5DvNa3U
Date:   Sun, 2 Aug 2020 01:28:02 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Nicholas Hsiang <xianghongai@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Chinese characters are garbled, setting utf-8 is also garbled
Message-ID: <20200802012802.GK6540@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Nicholas Hsiang <xianghongai@gmail.com>, git@vger.kernel.org
References: <CAEcaDL=BrqFf7bwJ0cVWK-+vUKLmuihhKr8m0_w2CCSNfA9LEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline
In-Reply-To: <CAEcaDL=BrqFf7bwJ0cVWK-+vUKLmuihhKr8m0_w2CCSNfA9LEw@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-01 at 04:36:50, Nicholas Hsiang wrote:
> Hi,
>=20
> There are some problems here.
>=20
> I have configured the character encoding in .gitconfig:
>=20
> ```yaml
> [core]
>   quotepath =3D false
> [gui]
>   encoding =3D utf-8
> [i18n]
>   commitencoding =3D utf-8
>   logoutputencoding =3D utf-8
> ```
>=20
> and Git Bash configed: Options > Text > Locale: zh_CN, Character set: UTF=
-8
>=20
> However, when executing `git pull/reset/status`, Chinese characters
> still appeared garbled.
>=20
> ```bash
> Xiang@Xiang MINGW64 /c/me/front-end-note (master)
> $ git reset --hard df576e2
> HEAD is now at df576e2 doc: =E7=90=9B=E3=83=A5=E5=8E=96 ES5 =E7=BC=81=D1=
=84=E5=A3=99
> ```

Since this is a Windows issue, you'd be better off reporting this at the
Git for Windows issue tracker at
https://github.com/git-for-windows/git/issues/.  As far as what I've
seen in your email, the characters do appear to be in Chinese, although
since I don't speak or read that language, I don't know whether they
make any sense or are garbled.
--=20
brian m. carlson: Houston, Texas, US

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyYWogAKCRB8DEliiIei
gVYpAP9ExzSyi1LyFEW1/2wJimzKfc7rTrm602eAeMoKuKc3zwEAsH5ANf5adEeW
8C1XuKFfoYvGl9iCqDBq6+Lj83GlCwY=
=Hwrv
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--
