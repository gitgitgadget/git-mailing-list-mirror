Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCAC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3F5C60E76
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 19:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJ2THF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 15:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ2THE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 15:07:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE8C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 12:04:35 -0700 (PDT)
Message-ID: <3c3cc160-fe7a-30c1-d65e-209dcc07d76e@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635534274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zx91Cj8oimoygmC/+n97X61ebr+LI37UIq+yy73pO8w=;
        b=eQRPWLioxaPjp7+heO8iawdjyFHMfdA2ZXrmh4UKAobJYHkKCeZuYvL11YjTAm4XFVaj2p
        U0/5y482TSkWxGDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635534274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zx91Cj8oimoygmC/+n97X61ebr+LI37UIq+yy73pO8w=;
        b=vw2fqIH8/pGFWG+ur4igXJxcrRCdVrHCHL6MKi+aSLhQIJPvvihSdn7dvNf4sBgUjNWRKE
        00JVjo90KsuYwniK/ou0UfGsTjxw0+x8zs1sOwUSuls+VlDpI/toONfX3Bm4OWjW4BV1cY
        XDgr4LxDwHszKIJhltlFavy3sPsJcW2Ee6ireEvmDjGr9Cz8VotvRtOn6vv34okqqUgWlF
        BXSIRGB5yjTpz0FmhBcRV85nlUG6P8QF4WRiXGQzkAsCyjo9Atogg8I8eM1D2tLmYgs35l
        Ovx+0GAf0p+yTXuL27XmwHAO22KXdZBej4YMAfS4KetxzvHSDFj1Z3YOQnvM2PLZ11hsen
        WNB0zzKdinyvBVyDjusDihZfL9WX0IBLByQ9AXikanC2Y72JB+AuVQF/vqsxJx0WKoGvIA
        WiesO0UvG15oLDpZYPyGsZUim6fEBrXwR9g1pvxVxphfObs6h6B2w89Dc5mpDpTOZxISNU
        CaRyiYjWiQ2ESEnJadZlaOHFD+7NaZZGdQyre3tuOSDi3w0DwVriPJtRotFK6deFBJ1JN2
        TQZgM6jFbC0acUs6dfKryRHTlrIuV6E5o1C7M7fjKgUWh+oyH8UNA97XNEqfDw/o+g7h7d
        QDPKRUBKoI4E0TWEc6nGxYCTQJNe1K3GC7VNtgVmeYRv8ysCgE5a8=
Date:   Fri, 29 Oct 2021 15:04:30 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] pretty: add abbrev option to %(describe)
Content-Language: en-US-large
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-4-eschwartz@archlinux.org>
 <CAPig+cSvecU9XSVobxSO-72rFgAMh5D39UcS6SJ2=xFVvnGJBA@mail.gmail.com>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <CAPig+cSvecU9XSVobxSO-72rFgAMh5D39UcS6SJ2=xFVvnGJBA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3lR81bejziWpJmOgEi0Fu1eX"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3lR81bejziWpJmOgEi0Fu1eX
Content-Type: multipart/mixed; boundary="------------gcxaXswjQ0LO7oIdxQ6wwwug";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Git List <git@vger.kernel.org>
Message-ID: <3c3cc160-fe7a-30c1-d65e-209dcc07d76e@archlinux.org>
Subject: Re: [PATCH v3 3/3] pretty: add abbrev option to %(describe)
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-4-eschwartz@archlinux.org>
 <CAPig+cSvecU9XSVobxSO-72rFgAMh5D39UcS6SJ2=xFVvnGJBA@mail.gmail.com>
In-Reply-To: <CAPig+cSvecU9XSVobxSO-72rFgAMh5D39UcS6SJ2=xFVvnGJBA@mail.gmail.com>

--------------gcxaXswjQ0LO7oIdxQ6wwwug
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/29/21 2:51 PM, Eric Sunshine wrote:
> On Fri, Oct 29, 2021 at 2:45 PM Eli Schwartz <eschwartz@archlinux.org> =
wrote:
>> The %(describe) placeholder by default, like `git describe`, uses a
>> seven-character abbreviated commit object name. This may not be
>> sufficient to fully describe all commits in a given repository,
>> resulting in a placeholder replacement changing its length because the=

>> repository grew in size.  This could cause the output of git-archive t=
o
>> change.
>>
>> Add the --abbrev option to `git describe` to the placeholder interface=

>> in order to provide tools to the user for fine-tuning project defaults=

>> and ensure reproducible archives.
>> [...]
>> Signed-off-by: Eli Schwartz <eschwartz@archlinux.org>
>> ---
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-f=
ormats.txt
>> @@ -222,6 +222,10 @@ The placeholders are:
>> +** 'abbrev=3D<N>': Instead of using the default number of hexadecimal=
 digits
>> +   (which will vary according to the number of objects in the reposit=
ory with a
>> +   default of 7) of the abbreviated object name, use <n> digits, or a=
s many digits
>> +   as needed to form a unique object name.
>=20
> There's still an inconsistent mix of `<N>` and `<n>` here (mentioned
> in my earlier review). Is that intentional or just a simple oversight?


Ah, sorry... I overlooked that. It was originally copied from the
git-describe man page which uses lowercase and I overlooked that part of
your review.

It should be consistently uppercase here for consistency with
pretty-formats.


--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------gcxaXswjQ0LO7oIdxQ6wwwug--

--------------3lR81bejziWpJmOgEi0Fu1eX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF8Rb8ACgkQzrFn77Vy
K9aXfRAA1Tsxy5xHDq/IbYrTV/2eVosus61z//83Zy/kBzTCOG8/3C2q2yheCwIg
8unLL5MFkWniz/54Iw9LxyiH6awv3yUmEEBDw3DuEReZO7bJb07A64u7Jfsl/ePh
iX0Ji2K5uvyeTsYfrkYgnyCJQKek8ztIUR2PTDMYJ0xBrJck9N8tF9AjoxezE59M
HbHmcMxsT4hS/NbXZrwT5APrsX8vCj4M9pAA+86fMFSfr9a248enrKT1UZLYKcwW
wkfLV2uk4FAWjuawtorQ3yJcBZitUYIYRKvEIDYCKJxSKQewDzVOIn6yGhHOEATE
NKzzLO3Ck4Kaa2SBg8EwRE6E2yxV6m4AeHIX6dcrMC9ftHpOnWIGOKMvqmQiuA7T
GSMj1ZFFV3voDuGqBz6Q75ChhT3y1dI+/VoLKc5wHJ1U450hXj2Js5GstZooGuQS
dFX60azjACbxIsUFyw7vpIJX/u+ffQ5t0lDOFoOpeqYGKXg+dJ4P7wikSbxYSzre
Ji2kqPnP1y4JA/ibfq99OB2sMV28hIvlDjeGSfRysDZ22jdVmiN/f3jPSFPqeab0
aLPVxJEj0ZWh58nr4ULZqabrgLKR1yfggZOP0YcucHCpIW1n+s5r9FJFzGLvTEOQ
TJxZBnCJI+eFzIIueeWK9k+U0o1lPZAqy12kDNbvSiio0qYraP0=
=Ya7T
-----END PGP SIGNATURE-----

--------------3lR81bejziWpJmOgEi0Fu1eX--
