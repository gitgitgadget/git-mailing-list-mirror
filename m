Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0072FC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 11:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCILCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 06:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjCILAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 06:00:18 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F176055537
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:58:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so839659wmq.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359482;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3j6+UZBzxozF/PLSTquRQ+EbUF+QhtQ/Bk8WEX+LRPA=;
        b=KIwxQW2rZVE7kfNYh5ACBNEQRLOnOIP2D5Mizdw+BEhMDmbS/CDrloHV7gLn8sL5PX
         fEtyxjD2hEhDgzSd3tXKAwozDYEcKr77z2Bc2ESM1BJuBgBo4BXpXPcF7gL1XyM3Y5I2
         Q7/pckxX/KMJBJPRsnFTzGcyxX8fun07PZasXY99OyxavTQWC+mpH5bBxQDkUuS/bUR0
         pVSTIV2SoL7S6eZPjQwf/SyTZdfIyviMqHKKfC8PCQGOF4tXgzB7qgs9ViIsLYi2El0f
         j8l25M1dcf+ND8ElraQGcYohDmnnk4SUzkiq6BB8REWU8An9eEE44FfT6ACD/nFmU5Dv
         vlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359482;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3j6+UZBzxozF/PLSTquRQ+EbUF+QhtQ/Bk8WEX+LRPA=;
        b=wAeL/A1gQZAs3PUp/HMj1TDB/To0uIdl5fAfb1QBrh3UKHc9pG8S+w65+m2Rp0u91c
         1u1x+6BZN8ezUPCfvKYan8czbhxUpd284hiwFYJFxAxAssv/1Mom+igcgLwSWIgcGl2Q
         QIprv5hu+DAegYWFcDG9i9UR4RyLE5PiIqU0gEr6DZqmEVTqewRzLXDtarQgfxMJFwdE
         E/hsofK4MjnqjJzRIQDYPdUeEZjQW8qY0xtF5HBBHFz7eVGixSorBCdMFjF+g2knzQez
         9RJS+H16RXUWZXlJO0BJI2lj2kJa+woVJwLxUA6LO9H3xh/MQRKQ/fMSh7J8nXsSi9rM
         amKQ==
X-Gm-Message-State: AO0yUKXUtqOBWtyUNez3AnIej+FQmYpxPOO08jTaWEOCx/YFGI1Zczvq
        rgTWJYvJYjs2HYReYX1v1b4=
X-Google-Smtp-Source: AK7set9dw6rKhWRJmcj3W82mBYzJy5MEsRDTe/dMronvqaGp8W5URv9WnGR23/nEwPGc3s7B99mIQA==
X-Received: by 2002:a05:600c:474c:b0:3eb:2de8:b74e with SMTP id w12-20020a05600c474c00b003eb2de8b74emr20027583wmo.27.1678359482282;
        Thu, 09 Mar 2023 02:58:02 -0800 (PST)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003e71a6be279sm2168963wmi.37.2023.03.09.02.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:58:01 -0800 (PST)
Message-ID: <82d78a22-76d5-28fd-e87e-e90e9ddc36e1@gmail.com>
Date:   Thu, 9 Mar 2023 11:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Better suggestions when git-am(1) fails
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
 <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------avBAv6Qv2TH04ueHLxX2Ilql"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------avBAv6Qv2TH04ueHLxX2Ilql
Content-Type: multipart/mixed; boundary="------------VrqQSCJMhvMBKciEjulr1iWY";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <82d78a22-76d5-28fd-e87e-e90e9ddc36e1@gmail.com>
Subject: Re: Better suggestions when git-am(1) fails
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
 <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
 <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>

--------------VrqQSCJMhvMBKciEjulr1iWY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On 3/9/23 07:06, Jeff King wrote:
> On Wed, Mar 08, 2023 at 10:17:11PM -0500, Jeff King wrote:
>=20
>> On Wed, Mar 08, 2023 at 09:15:53PM +0100, Alejandro Colomar wrote:
>>
>>> I had the following error already a few times, when some contributors=
,
>>> for some reason unknown to me, remove the leading path components fro=
m
>>> the patch.
>>
>> The reason is probably that they have set diff.noprefix in their confi=
g,
>> and git-format-patch respects that. Which is arguably a bug. There's a=

>> little discussion in this message, along with references to some
>> previous discussions:
>>
>>   https://lore.kernel.org/git/ZAWnDUkgO5clf6qu@coredump.intra.peff.net=
/
>=20
> So here's a patch series which I think should help with the sending
> side. Most of it is just filling in gaps in the code and tests for
> current features. Patch 4 is the actual change. Patch 5 adds an
> equivalent option just for format-patch. I'm not convinced anybody
> really wants it (which is why I split it out), but it's probably worth
> doing just in case.

Thanks for the rapid patch set :)

>=20
>   [1/5]: diff: factor out src/dst prefix setup
>   [2/5]: t4013: add tests for diff prefix options
>   [3/5]: diff: add --default-prefix option
>   [4/5]: format-patch: do not respect diff.noprefix
>   [5/5]: format-patch: add format.noprefix option

1, 3, and 4 LGTM.  I'm not used to your tests, so can't really check
what 2 does without further reading, and I'm not sure 5 is useful.

BTW, I'll probably report a few more things I don't like from
git-am(1)'s error reports, whenever I find them again.  ;)

Cheers,

Alex

>=20
>  Documentation/config/format.txt |  7 ++++++
>  Documentation/diff-options.txt  |  5 ++++
>  builtin/log.c                   | 17 +++++++++++++
>  diff.c                          | 33 ++++++++++++++++++++++----
>  diff.h                          |  2 ++
>  t/t4013-diff-various.sh         | 42 +++++++++++++++++++++++++++++++++=

>  t/t4014-format-patch.sh         | 16 +++++++++++++
>  7 files changed, 117 insertions(+), 5 deletions(-)
>=20
> -Peff

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------VrqQSCJMhvMBKciEjulr1iWY--

--------------avBAv6Qv2TH04ueHLxX2Ilql
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQJu7kACgkQnowa+77/
2zIwgA/3XtEFIJUXO/nHsMiDOOb3zZIvEYiXVnP5fWiZhtZs0XQZ1cM4Nl5Vq99T
ldgPMSlTvfwihixI46DXbpYCgZQ9EBbTX4CCrlxe0lq1GT36btujhqsQSARGnVJ2
Ap0+R2mvBlSoLnmAsLLYOCyQ9jyKv1M+QFQwGBzmrwCpQ0GO/0ccy/0WtdsMl8pS
r8qFW5zisJ+NHLysVW8IrYeL7g8nYJLfiT2IH8Da08gyYuRDo6PWxHjZsFJCNar8
7rRCPEqJ09tEZGoj1q8b3RNMP74yTZlQG0v8mPhiIheVZWMLHjyD9oTxI95ZsjW0
8Vz+SPx94tyK9/Bn7RZWR9L6/jXCe0H1vQfHOFzsn/jG7c4jHHBhqCc9Op0VoUxp
ehYJfFpDBwjrIUq1epUnZIVHBUvOjP9OmwUOEmTtB6xlCqLPe8N73V6VBpxyQAkq
u5DiYPzK1VPFCVR2BTJU2HNvW15Ts9SD/Zg0UOLNH8JeTFa0Sm8Rym8JzK+MN9oA
APKUQTl7P+CNrzqCHxoTvaxnVylNCKtQfClj6BfGek8dBu0AtMP2cpsUdtXhf/V/
nJAAtEGOu5A4z+c/B+SytbiH/+/cgfEFM04OKEgAFgDCvPBM/Wt1JVNAJTwHBEqn
Mf2tdUpBv4Tj8FrwBzJgR54phPc/FpvcO3HYlRNZje4U69liSw==
=6Osn
-----END PGP SIGNATURE-----

--------------avBAv6Qv2TH04ueHLxX2Ilql--
