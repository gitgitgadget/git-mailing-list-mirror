Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6A31F461
	for <e@80x24.org>; Tue, 27 Aug 2019 22:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfH0Wm0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 18:42:26 -0400
Received: from knopi.disroot.org ([178.21.23.139]:34764 "EHLO
        knopi.disroot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfH0Wm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 18:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by disroot.org (Postfix) with ESMTP id 7851323DCD;
        Wed, 28 Aug 2019 00:42:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
        by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FKHgU0S9VHYy; Wed, 28 Aug 2019 00:42:23 +0200 (CEST)
To:     Jeff King <peff@peff.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
        t=1566945743; bh=/OAPVOZpU/6bWCJ2aC0Y3dwvAAD9ibERoJDsb5LqnAU=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To;
        b=fpiq+UKEfQLuqp1JqQvUmLv2rGXvXVyzs9SsFwuMo0/pJFD5/ZKBts9QV9+L7d5az
         +epmzxpTpmaqjwFfT72CgVj1ursoG9oA7Te9qNR0NLKyxPlWmPDdVkHB4/s1n1B5Ki
         jAJ5hmK0eV3ToYBAQ62BJd7VfeXHpZ9mvVM3SdiUJojp7k0hV+nz2zv9UYbtMiG5ms
         ziPP4rag/ucUF0WGzTD5oUpsj/cVScNVXQKPEFyTR9NN93i8YDSV+P6IMcj+zsewUl
         OtTAfNISDRUCtQhlDfll8Hq0rE8+cJ3bKVQ5yw+5BK+yK3tDZA1sl6uklKOi8Rbhop
         U/G8sm4uNVC1g==
Cc:     git@vger.kernel.org
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
 <20190827190509.GB3150@sigill.intra.peff.net>
From:   Vipul <finn02@disroot.org>
Openpgp: preference=signencrypt
Autocrypt: addr=finn02@disroot.org; keydata=
 mDMEXRx7cxYJKwYBBAHaRw8BAQdAKciEXPQkIdtaWRhCIHoSIiBY4g5ZfIP1axIJDFNi5Yu0
 IFZpcHVsIEt1bWFyIDxmaW5uMDJAZGlzcm9vdC5vcmc+iJYEExYKAD4WIQS5z8d4HtK3bcaz
 H3/qgPyoFmeTQQUCXRx7cwIbAQUJA8JnAAULCQgHAwUVCgkICwUWAwIBAAIeAQIXgAAKCRDq
 gPyoFmeTQXjCAP42jD3kQc7BCyR4Ay6I4BhIGYpyPiw9rJInGFtwaZsI5wD/bisWiN14ZuVA
 cop7o/DYqX2K6pRpEap3XqYUEoJKrgS4OARdHHxWEgorBgEEAZdVAQUBAQdAZ2pWXE/s6AfF
 APSNgAU1H4PgVASh/X9N0adLq1YJplwDAQgHiH4EGBYKACYWIQS5z8d4HtK3bcazH3/qgPyo
 FmeTQQUCXRx8VgIbDAUJAeEzgAAKCRDqgPyoFmeTQUGRAP0RlzrFUA0ZAnMJY6asTOd09mxl
 HaiVCjmalM/QY4gNggD/VDcEs9q6eDRAJi4q/VgGwAKEG37pnN2VGfNXFkweYwC4MwRdHHx4
 FgkrBgEEAdpHDwEBB0AE+sNCB2H528wQwT+JBOVcizDtuVzX573iqlwlrximWoj1BBgWCgAm
 FiEEuc/HeB7St23Gsx9/6oD8qBZnk0EFAl0cfHgCGwIFCQHhM4AAgQkQ6oD8qBZnk0F2IAQZ
 FgoAHRYhBC+P1j3RPqH/yxnKNPUjW5+MjneUBQJdHHx4AAoJEPUjW5+MjneUMxgBANyMa1h8
 k7K+S5ozyIkKAGEzPkbpvbmzJXDgkdjvJ/76AQDRfbuR+tGOfhJtYsZKJa6jmGr7WYRrmuJS
 V+PChHe7DAHyAQDMLXZgSTGQooEb50BRM4zllFM6Sbx6ld4izSDWnt87LQEA2S/YbiM57y0v
 HbW6ULT6+Un4KxzFBvl9iZyFMBVRbAw=
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
Message-ID: <664344cb-f9e4-d4fc-fd14-620e3e10157a@disroot.org>
Date:   Tue, 27 Aug 2019 22:42:03 +0000
Mime-Version: 1.0
In-Reply-To: <20190827190509.GB3150@sigill.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wpbEBLjGPEZxcDxaYpjDauJR6uN0lO7CL"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wpbEBLjGPEZxcDxaYpjDauJR6uN0lO7CL
Content-Type: multipart/mixed; boundary="P1k4CPltmUkJMJ27rLhjPTjNm7IobA9NO";
 protected-headers="v1"
From: Vipul <finn02@disroot.org>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <664344cb-f9e4-d4fc-fd14-620e3e10157a@disroot.org>
Subject: Re: Support for an interactive confirmation prompt when users can
 possibly lose their work like some UNIX commands
References: <c1136131-0a9e-9dbb-3ad7-495ac96c1ef0@disroot.org>
 <20190827190509.GB3150@sigill.intra.peff.net>
In-Reply-To: <20190827190509.GB3150@sigill.intra.peff.net>

--P1k4CPltmUkJMJ27rLhjPTjNm7IobA9NO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> The usual philosophy in Git is not to bother the user with
> confirmations, but to allow recovery after a mistake.
>=20

Well, always prompting for confirmation will be annoying for some people
specially who are mastered in git but, may be very useful feature for
beginner's to avoid them from making mistakes. May be, this feature will
be disabled by default and users have to set some config variable (like
other git-config variable for example help.autocorrect etc) in global
gitconfig file.

> If you've moved a branch pointer around (e.g., via "git branch -f" or
> "git reset"), you can recover it from the reflog.
>=20

Recovery is not a problem, asking for help on #git IRC people will tell
you whether data is recoverable. If recoverable, they will even guide
you step-by-step. But, I think it would be good idea to not make these
kind of mistakes at first place. Ultimately, we as a developer want to
make software more user-friendly and usable for normal users.

> Note that there _are_ some commands which are not reversible: mostly
> things that drop content from the working tree. So "git reset --hard" i=
s
> one, and "git clean" is another. There have been discussions and even
> some patches about storing the lost in an "undo log", but nothing has
> been merged.
>
Seems like a good idea. Are they ever gonna merge? If no, why? Or, it
will merge in next feature release.


--P1k4CPltmUkJMJ27rLhjPTjNm7IobA9NO--

--wpbEBLjGPEZxcDxaYpjDauJR6uN0lO7CL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQvj9Y90T6h/8sZyjT1I1ufjI53lAUCXWWxuwAKCRD1I1ufjI53
lEYHAQCf3BKFB5m8FcqIdHlTlD7juPCH/UM+zxVZpGCnxleLBwD9EqYWB+N9rj7U
4tbn9DKUHZfutE2uz8a3CnWeJYuuhQ8=
=doPc
-----END PGP SIGNATURE-----

--wpbEBLjGPEZxcDxaYpjDauJR6uN0lO7CL--
