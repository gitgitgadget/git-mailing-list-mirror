Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB2D1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 14:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405166AbfIIOFt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 10:05:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405119AbfIIOFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 10:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D76F309276B;
        Mon,  9 Sep 2019 14:05:48 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7E326012A;
        Mon,  9 Sep 2019 14:05:46 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>,
        qemu-devel@nongnu.org, git@vger.kernel.org
Cc:     berrange@redhat.com, stefanha@gmail.com,
        Greg Kurz <groug@kaod.org>, dgilbert@redhat.com,
        antonios.motakis@huawei.com
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com> <4642438.ai5u8AxThJ@silver>
 <1897173.eDCz7oYxVq@silver>
From:   Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <305577c2-709a-b632-4056-6582771176ac@redhat.com>
Date:   Mon, 9 Sep 2019 09:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1897173.eDCz7oYxVq@silver>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wvWU7xN1BqAkLvUvjk9gvXi0xIYinyJLI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 09 Sep 2019 14:05:48 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvWU7xN1BqAkLvUvjk9gvXi0xIYinyJLI
Content-Type: multipart/mixed; boundary="cYyG1Jpt5qBg3s28Mfvxz3Obv4rkwvX4C";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 git@vger.kernel.org
Cc: berrange@redhat.com, stefanha@gmail.com, Greg Kurz <groug@kaod.org>,
 dgilbert@redhat.com, antonios.motakis@huawei.com
Message-ID: <305577c2-709a-b632-4056-6582771176ac@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com> <4642438.ai5u8AxThJ@silver>
 <1897173.eDCz7oYxVq@silver>
In-Reply-To: <1897173.eDCz7oYxVq@silver>

--cYyG1Jpt5qBg3s28Mfvxz3Obv4rkwvX4C
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[adding git list]

On 9/5/19 7:25 AM, Christian Schoenebeck wrote:

>>>>> How are you sending patches ? With git send-email ? If so, maybe yo=
u
>>>>> can
>>>>> pass something like --from=3D'"Christian Schoenebeck"
>>>>> <qemu_oss@crudebyte.com>'. Since this is a different string, git wi=
ll
>>>>> assume you're sending someone else's patch : it will automatically =
add
>>>>> an
>>>>> extra From: made out of the commit Author as recorded in the git tr=
ee.
>>>
>>> I think it is probably as simple as a 'git config' command to tell gi=
t
>>> to always put a 'From:' in the body of self-authored patches when usi=
ng
>>> git format-patch; however, as I don't suffer from munged emails, I
>>> haven't actually tested what that setting would be.
>=20
> Well, I tried that Eric. The expected solution would be enabling this g=
it=20
> setting:
>=20
> git config [--global] format.from true
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-format=
from
>=20
> But as you can already read from the manual, the overall behaviour of g=
it=20
> regarding a separate "From:" line in the email body was intended solely=
 for=20
> the use case sender !=3D author. So in practice (at least in my git ver=
sion) git=20
> always makes a raw string comparison between sender (name and email) st=
ring=20
> and author string and only adds the separate From: line to the body if =
they=20
> differ.
>=20
> Hence also "git format-patch --from=3D" only works here if you use a di=
fferent=20
> author string (name and email) there, otherwise on a perfect string mat=
ch it=20
> is simply ignored and you end up with only one "From:" in the email hea=
der.

git folks:

How hard would it be to improve 'git format-patch'/'git send-email' to
have an option to ALWAYS output a From: line in the body, even when the
sender is the author, for the case of a mailing list that munges the
mail headers due to DMARC/DKIM reasons?

>=20
> So eventually I added one extra character in my name for now and remove=
d it=20
> manually in the dumped emails subsequently (see today's
> "[PATCH v7 0/3] 9p: Fix file ID collisions").
>=20
> Besides that direct string comparison restriction; git also seems to ha=
ve a=20
> bug here. Because even if you have sender !=3D author, then git falsely=
 uses=20
> author as sender of the cover letter, whereas the emails of the individ=
ual=20
> patches are encoded correctly.

At any rate, I'm glad that you have figured out a workaround, even if
painful, while we wait for git to provide what we really need.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cYyG1Jpt5qBg3s28Mfvxz3Obv4rkwvX4C--

--wvWU7xN1BqAkLvUvjk9gvXi0xIYinyJLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl12XDkACgkQp6FrSiUn
Q2q+XAf/SLPHaKyItKzebFFgN27LBaNaMsQnMU6KP+MJe0Ql+5wh4MfUy2ptof5z
UtO5Kk+N16hsvnWt1TVE3jqhuu3R3A03rR2TdRVX4wMzoa/ZQfiqf8WuhRrcabFB
FYpGmrKnEBHI9Gj846dGWoCLllMLKNr3f8+zuj3svlQ3ZYPO5RFnxhcJt0NNhszX
mdQNGZknfFBZQsM2ZDSTxqM6Q+knlLl9n9EfLvYhlzQNiSQc0XoA8Yi4E20fjsYy
Z4+Lpo/3kWlYZ1trJ4qzOzyggMaMY3OfKZzoyNJA3qnQZHTY4bjo8KnXDcZHLiFN
48RcKLeWLXGeaH9xfDVpyXwd3J0ndA==
=8FdN
-----END PGP SIGNATURE-----

--wvWU7xN1BqAkLvUvjk9gvXi0xIYinyJLI--
