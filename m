Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EAC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 06:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDGca (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 02:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDGc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 02:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44828E36
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667543491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=3x9nff0BRaqXRq8iLIIvP9i7nHSTHA/r4kQI5PgRhJk=;
        b=XyyEZdKtHZBEqMsV1AIdq2gdoWH7yJO1ptgfvA+SPFkBY31aByJmlnMeLtpsvZu40mziCf
        uzIJKP+lG6uxBsSrf8cCh6LpiI7S7BkzhXVrjCPNOd84d6DtubVWPLQe24TBjtWCSRVlxp
        j2qTzD9q9+IhXYnhYyy+jAsKVd7VLcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-xX98ztQfOdW1lrRaT6mqdw-1; Fri, 04 Nov 2022 02:31:28 -0400
X-MC-Unique: xX98ztQfOdW1lrRaT6mqdw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1EC4185A78B
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:31:27 +0000 (UTC)
Received: from [10.40.192.111] (ovpn-192-111.brq.redhat.com [10.40.192.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53949492B25
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:31:27 +0000 (UTC)
Message-ID: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
Date:   Fri, 4 Nov 2022 07:31:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; keydata=
 xsBNBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAHNK0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT7CwJUEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AmAzSoUFCQzmojUACgkQJrNi5H/PIsGM4Qf+OmO8PqPg28arBfxGSjdxb4744E1bnLESNudf
 8VY5/UEca0X65KW9L5vd6XUjusy2T4iyUcbZhCxYcHQLqP6y3AIyVfgJz91HEAt2thMFPfbj
 IhqVlyP0xEyvCNLk83M4PLN9IhugvSLce6R6cliETevP/m7RQSiP1o0fKu0uAUrEKWD9DZMF
 99BaI635YZOPHQwQlkWnFBEKpKLjkuKpn/QSkW34mkaByn6zLhF5QeIp/9FQVUZCeOy/zR0G
 s8ggfDyr4vJuDU4gI9NGZs6zycTflmFpA46P03LgmdRL/C6U7vbUB6B+v0YddYJoaarLUKpa
 L4dG8h/m8RdXNA33YM7ATQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABwsB8BBgBCAAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmAz
 So0FCQzmojUACgkQJrNi5H/PIsFS9Qf/WZ31JQQnQQSbmtm7IOAHYC7kvlQy8mejWlgeDrPW
 h3zQIXxiarBpAnYGsHNVOWJ+sjdELYc9bvOcGwXSRRxURArOYfkUOk4KmNmqd6eIrOvnFfap
 Lh0xRNx+9y0gYqB9TH/JaCLMPnH+jRGM0ZisNEHyXhemEXlXPy4vniEvajr4VnvFzD6gExzD
 jUqIel42BOOyHuXjZQDMEWf2eULSTGHTWXGdV2XErdS1v4YI/DGvQQPB29UHmb2RsZhKtntq
 0yoxFD60HzSHlVeiLmG/hAHLDY3dBs/GW3RJAbOVttS31llstDtdMEHLn+P81M4dVYzt5mEE
 NPy43Lf+YxM9FQ==
Subject: "git bisect run" strips "--log" from the list of arguments
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------k801C3LvacYOBKmVkE830KVy"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------k801C3LvacYOBKmVkE830KVy
Content-Type: multipart/mixed; boundary="------------7ivuIPHlPX7TL2Z11TiTuNqI";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: git@vger.kernel.org
Message-ID: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
Subject: "git bisect run" strips "--log" from the list of arguments

--------------7ivuIPHlPX7TL2Z11TiTuNqI
Content-Type: multipart/mixed; boundary="------------YKrdinJ0yqwLXIC8Letk3ntM"

--------------YKrdinJ0yqwLXIC8Letk3ntM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello folks,

recently I noticed a change of behavior in "git bisect run" and since git=
-2.34.1-1.fc35.x86_64 it's stripping "--log" arguments of my to-be-execut=
ed script.

Steps to Reproduce:

1. git bisect start BAD GOOD
2. git bisect run ./myscript arg1 --log arg2 --log -- arg3 --log arg4

Results with 2.34.1:

    running  './myscript' 'arg1' 'arg2' '--' 'arg3' '--log' 'arg4'

Results with 2.33.0:

    running ./myscript arg1 --log arg2 --log -- arg3 --log arg4

Is this expected? In https://bugzilla.redhat.com/show_bug.cgi?id=3D213988=
3 Todd suggested it might be related to

    d1bbbe45df (bisect--helper: reimplement `bisect_run` shell function i=
n C, 2021-09-13)=20

but I haven't tried it myself.

Regards,
Luk=C3=A1=C5=A1
--------------YKrdinJ0yqwLXIC8Letk3ntM
Content-Type: application/pgp-keys; name="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0x26B362E47FCF22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdP
hUDvFS32V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CL
mwStbe6Cw1oR4LYQHBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv95
4FsgCGtoVvl4CoxaR3u2VNOshXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pS
diKrtQKWIUji3Z8x41MbZybmJxHkpOVzJl3jnNE3CbiEq77Is9LMI4yTF2CESs3V
4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEBAAHNK0x1a2FzIERva3RvciAo
UmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT7CwJUEEwEIAD8CGwMGCwkIBwMC
BhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmAzSoUF
CQzmojUACgkQJrNi5H/PIsGM4Qf+OmO8PqPg28arBfxGSjdxb4744E1bnLESNudf
8VY5/UEca0X65KW9L5vd6XUjusy2T4iyUcbZhCxYcHQLqP6y3AIyVfgJz91HEAt2
thMFPfbjIhqVlyP0xEyvCNLk83M4PLN9IhugvSLce6R6cliETevP/m7RQSiP1o0f
Ku0uAUrEKWD9DZMF99BaI635YZOPHQwQlkWnFBEKpKLjkuKpn/QSkW34mkaByn6z
LhF5QeIp/9FQVUZCeOy/zR0Gs8ggfDyr4vJuDU4gI9NGZs6zycTflmFpA46P03Lg
mdRL/C6U7vbUB6B+v0YddYJoaarLUKpaL4dG8h/m8RdXNA33YMLAfgQTAQIAKAUC
VxXq+wIbAwUJA8JnAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQJrNi5H/P
IsHTywf+Nw03Y2XAryQ/CbTGa1BhsVtEo8Vwao+3/G4GwfOp93PNB24s7GDbiOZQ
jtwm7nZ45u0eQtx3AasN5/Z2ZSGRXsHv6AgM6qbcAR8SAiY1lodAdThBL7nVJgMp
JbVtfBHSTa8q5+ubeEoLLmktXljoME6l2ueAQcZvYDCfrqXbukTvxecVg07Hg+V+
rRwuGKxeUN+SvOp1NiJTj4HzzAUiFJWXmrsDrhaMqkahopAyhq86zsvmh1UBjNKS
y3w/aQb9QvTJ/qEWIG2D/iHjgujei/aTXsB5qIOlCk5Tdsj1ZjGHg+zaDaVo+MOc
KYfDpyQxYGQ4eFW0ijdWgZfbTG8fKcLAlQQTAQIAPwIbAwYLCQgHAwIGFQgCCQoL
BBYCAwECHgECF4AWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCWpWOrQUJB0IKsgAK
CRAms2Lkf88iwUXVB/4rbeQHmI6+xt7+zBB1r2cllKAqRtcsIXcoJ3CMJjep2d4f
Oujr3qqixGFaf62ktDoynyyCde4mT3qpqm1e3HRHUKLagcWjTVZ9xItnV/33/Sp1
YZYmFO3ZM80/oDmuvD/8VmVA5g1Ngb2+ft64sTR6XfZlCn/QcI7tekuK6MRfjx9Z
2Vo+YM6dqUkSnPMkk27xaccgbZ4tLyUas12c9uTEfJ4RHE+5YMCYeZbJlJoMy0x3
jRdUp8t+TJjzePP66ry4zE8zOrXXpi8XKCxeok+BYZhff0F1qwSyyv8YAEeqApjn
h21N0ycVlkVWjCSgJKHYCX9f85KTnCnJhmsRh4o0wsCUBBMBCAA/AhsDBgsJCAcD
AgYVCAIJCgsEFgIDAQIeAQIXgBYhBKQKTEXEA03gKlrUgyazYuR/zyLBBQJeHGos
BQkLBW61AAoJECazYuR/zyLBK1gH9jnk79ikqObpIpHUgP4jSLQ16qjIYKzdCWzG
nW/NlWCighT/jV0MtujUKnCo2iZZr9UOK2A3y78/tYL54q+pfYIOO4PxDwubNlMR
jpRs/H84B3B53tNjxRFCgjUpUmUyVvAwsBSjeFZDxqrp4Cbw3fYvIAvQf0wdxx+C
B6/NpgNwZ0N8JpfShyl0aBCVUdeXHepClOeTERtJqulc2J1uVsMsX9GQuvkdrUIM
8bL8UVT70F0m3Br95FqD4EaOWvCFszAdfeLVlWDWqoTFDymbIAVBhdyXc68IAwQL
gtepioMjA68x919GWd01x/pkAV7v6ceS/ATM/1gIm5Iz1U3qntHPAc7/ARAAAQEA
AAAAAAAAAAAAAAD/2P/gABBKRklGAAEBAAABAAEAAP/bAEMACAYGBwYFCAcHBwkJ
CAoMFA0MCwsMGRITDxQdGh8eHRocHCAkLicgIiwjHBwoNyksMDE0NDQfJzk9ODI8
LjM0Mv/bAEMBCQkJDAsMGA0NGDIhHCEyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMv/AABEIAJIAewMBIgACEQEDEQH/xAAf
AAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAA
AX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUm
JygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaH
iImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna
4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUG
BwgJCgv/xAC1EQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgU
QpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVW
V1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqy
s7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAM
AwEAAhEDEQA/APSipJ/xpMHPJ4qQke9M+UHof1roMxNvPBoKEjtS5G7PzU8MvqwN
IZWaL5u/4CoXgUHeScVfOw9CRXKeJPFMGnu9vbsslyOCR0T/AOvUTqKCuyowcnZG
rNLDCCXcqo6+1R/25pNnAWN3AGOTjeK8k1XWbi9kJuZ5G9E3H/IrFM7b/T6GuZ1p
S2N1R5d2evz6/pNzZFBfR71+6N2OaqWmpQiGVFulZz0CvmvK1mfkqW9yTgCoPPkD
s/nMWHTbUaj5Ue+RXJMMLDPKAGni4wWJPJFeRaL4zv8ATkVHkM8KjLRyc4Hseor0
fQ9Utdes2ni3xOuAyMQcd+vetYu+hk1Yp3Ux/tG4PrJSRSgM2Over0ugNJKztdkl
zkYUVGNBkV+JhsJ5OcH+VP2bDmQ3z8qMnk1AZSDjJq//AGPHnAn3Y9DUL6QNxwrn
3zS9m2HOjrSM9qb5ZPJA/KpDz0BFNKgnpk11mIDAHIIpCw7UuwnoKrX9yLGwnuGG
fLQtj1NJuyuNK7sYfirxImlWxt4XH2px2P3B615PdXwdmcvudjnJPema7fT3VzK0
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
5mEENPy43Lf+YxM9FQ=3D=3D
=3DPgBW
-----END PGP PUBLIC KEY BLOCK-----

--------------YKrdinJ0yqwLXIC8Letk3ntM--

--------------7ivuIPHlPX7TL2Z11TiTuNqI--

--------------k801C3LvacYOBKmVkE830KVy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAmNksb4FAwAAAAAACgkQJrNi5H/PIsHv
3wgAwDjBabdIv0sdFLKIQt35FPqO7bGYCfXoQWih/WEoCgVleqkwmbtMSxm3GX+vkeKW4lWDBMDs
Vo2O31udQlyaVg6m/OpiUmsBXQa9tcDbqaHugf3aOvJ+nFOFi+vQkCJAmKBblp4Lo6YYVuiLbMst
ib5cNbpcejR1GG5L8XY4h8YGBya7Wl0EAU01xEsba6B15hhhivtZVc36L3Dn0+3trNuOPStUgHCf
f1HaFOrll5jGrqyg1gYVkwqEfN1qNDDHmpQ85ctHXi5C+EX8C0iRYrww636lPztuIKch5UYAkVQZ
yYjz8xtvb9wWb1qz9+n1yTs1iFSSznsUJkihEFM6bw==
=22xm
-----END PGP SIGNATURE-----

--------------k801C3LvacYOBKmVkE830KVy--

