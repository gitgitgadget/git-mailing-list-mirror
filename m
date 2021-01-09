Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA2C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ECE23AC0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAIWAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:00:14 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49726 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbhAIWAN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jan 2021 17:00:13 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E8DB360781;
        Sat,  9 Jan 2021 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1610229572;
        bh=xc+aTZ0u4F9JPTLiKKptfrhJtosZ+9pt7ELNaLyWZEE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=tWDbsebutCmpkDESEv2JZDDekGs2qUmzGF1FtNGpjBiwZCc+4A7auuU7HbENG1RHR
         PvnIjYAUl5Dp8SDo5EXVDEVDtyQb2hlD7QLIkLgg9k6kNEePuxeV11jzbIjYJlnkKF
         DjW1uswq/FqVAdGumwpF6gfk6uIUOeZMS2CKrWQRJcYuTkzIm+YUp+wydvPYF2Vljp
         /eeFLBSn7o8KUKXta4oPD2UfTjpGcYkdAxdD/fWkHGzvGKK5YYQcyN/acqxHKavSJ5
         d4qNyAAHojeitQR5mKbSshNLxEDDRBVNTLMNkw/08yw77O5+hTmBL5PFAOt7OnI88A
         9x5osmNymTytGfWdoYYq2Emq44SQxjtcM9I7RTyG+08HlAdIb0qc/LgB4RwVjkFDi6
         egkUx/SurSVM4TL45k/wA1/lQfxbXsKTuPnVuh7f+TnRCpbr5JBQVr0DOfNYWxwMBd
         0MaFjm2Ik/q88eV9rYgcPYLW0wvvfn5rtgylZ3ECy3xmmQe6jyj
Date:   Sat, 9 Jan 2021 21:59:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fixup! mergetool: add automerge configuration
Message-ID: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
References: <20210109214922.33972-1-davvid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G5lza6BDyoli0Zdo"
Content-Disposition: inline
In-Reply-To: <20210109214922.33972-1-davvid@gmail.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G5lza6BDyoli0Zdo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-01-09 at 21:49:22, David Aguilar wrote:
> The use of "\r\?" in sed is not portable to macOS and possibly
> other unix flavors.
>=20
> Replace "\r" with a substituted variable that contains "\r".
> Replace "\?" with "\{0,1\}".

Ah, yes, this is true.  The statement about "\r" is also true for Linux
with POSIXLY_CORRECT, IIRC.

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is based on top of fc/mergetool-automerge and can be squashed in
> (with the addition of my sign-off) if desired.
>=20
> Let me know if you'd prefer a separate patch. I figured we'd want
> a squash to preserve bisectability.
>=20
>  git-mergetool.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index a44afd3822..12c3e83aa7 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -243,9 +243,16 @@ auto_merge () {
>  	git merge-file --diff3 --marker-size=3D7 -q -p "$LOCAL" "$BASE" "$REMOT=
E" >"$DIFF3"
>  	if test -s "$DIFF3"
>  	then
> -		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=3D=3D=3D=3D=3D=3D=3D\r\?$/,/^=
>>>>>>> /d' "$DIFF3" >"$BASE"
> -		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> -		sed -e '/^<<<<<<< /,/^=3D=3D=3D=3D=3D=3D=3D\r\?$/d' -e '/^>>>>>>> /d' =
"$DIFF3" >"$REMOTE"
> +		cr=3D$(printf '\x0d')

Unfortunately, printf is not specified by POSIX to take hex escapes, so
this, too is nonportable.  We are unfortunately allowed to use only
octal escapes (yuck).  However, we can write this:

  cr=3D$(printf '\r')

or

  cr=3D$(printf '\015')

I think the former is clearer, since that's what we were writing before.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--G5lza6BDyoli0Zdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX/onPwAKCRB8DEliiIei
gcolAPkBtZ1Srp0UhzIU2DmaalM5iO/0+j6ZKRZGjG31DKHZdgD8CJFhICrFZhfT
e6s+atuGG2qWlN8zgI1sLeQoz5jgWgU=
=qtjH
-----END PGP SIGNATURE-----

--G5lza6BDyoli0Zdo--
