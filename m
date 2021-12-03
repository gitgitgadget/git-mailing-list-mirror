Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B526C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 00:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377783AbhLCAnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 19:43:40 -0500
Received: from sonic317-21.consmr.mail.gq1.yahoo.com ([98.137.66.147]:35567
        "EHLO sonic317-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349629AbhLCAnk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Dec 2021 19:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1638492016; bh=CFKcRFQBMStQHeXCZSXfc30vBjxRa1QnUAdDKfMXkpQ=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=bkq/pib+QFxkKcztLulV2T0JoM3ztkPDN1eI0U8zJeONi0B6Al9zmnTJXV5Gph36iia86l/AVpATcYEBGTkBaYle01U/iWDa9qaSXMfgS1yNLBSli+cZ/UyNZl/M1nLYxCql4OlCqT7CtFfO30akeeat4PbXNJePdvYe+EXSyt2yeJJitsWsLUEB8xwEV62Yo5RdnC8jeaozvvhoJtfNgnTihQwCFJ3TbicNG16qMnL5MDQ40wPYZ6RgGZnmxsSlKgPK45UAOqZD7EhpJLkjuiJnirkS0alzHK+Vtsx1bjmXSrCe9Ennqw60NEQfPGVF02V9UFjVTErKCL9Gx2VyrQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638492016; bh=LYiHERSig5hVNijA8JFkV1AFrNbrgREMxJuD4GqbnsQ=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=RGQP/LkSMtUISZ+Z3OocI1FJyG9x4wc2fda3QG4iMm/Uy7VUfgnan71CEDoG9x87M/YJzkS8VlTDAnMLPgKRA2lkBMw+9v2JeJ7phKSDCFouVTw2lNep1sIAA5nDo+eHJubJTgZvNbX2xE2N55q385B4LMH8odP7nMo+B8aFCR44GRw0SQd5gIhIcK/dlX/P7wCqpq25PzVnUY4/p3BSzo1luM4tWjEeAXBX90vT6tVsKTxda2grR+Thv68u6fSe8ALIC9edpVXIgx17dxjZ+aJH8TfjbcoLHr2he5IjLaoyNqHgeomLkaNRMRbETc1Lwd084mNyzJSvJnCgp8PulQ==
X-YMail-OSG: YUKqvh0VM1k3pvZMPFjtaDayBxLTjf5CFqfZm.wmf30mQIx7cfcbDhmR5KfOrr0
 1ep6N4APpA.lfbAtLFeSyR4uSP8CGTqiKJfY_HJ1WIGft6GSKeDShWh1DFekrCz.PINMdKQiTugG
 _OyK9dMAdq1rWtFxZiQRQ8RaOoH_Qf_zugZlAvFJiRkWPPBV_MJ1R1AzPv6vMk3T6M50Uq9PDiE7
 ZBnCjfDnJ7qt6PySnhAVkGrhvOkQUOSklCuYYyP2sxUDpf5pg2q8J6t52jcK9PrYXC3cMb1xSLia
 IZtyihdMuKlG9qX5KwK7TmWqD2sB7Ni3WWnTDHFVtG3pBcI4hyv0xnZHBs4AxLA2mH4JcPRGYTWk
 ydeFtqV2XEuM4ZxyM7q37ozrkPS_A_IFB0Aw3ZOoc96i9AoS94uE7I.1qo7VJ_83kI4opRrH.yQo
 nni2BGfRK5X7ZVDCB7gTVVoW96z9sVGTN4qwc6FYnptkUicJPru5YryDtea_K0xhs2uwPiTLL8Bi
 9RPstqUFDBaE4wCyVt7EzWCAPQjWDvonHVg_9eEA2LUVGHWFLBctu.FXMQEgNNNeDvjfhu.gvFaK
 pZtTTcbLi4jwLpb9NSh3aO_Ay440nq2dVfkdsyFqAXtYs0mHgkICBWFlyku1.o813v3WDkr5o9de
 uJv83SVEaIXh.nIXhPU5rUok9RHu0oGuFi3TjudL5xYL2KTHPug4hqXZ1CfPLQMWkj4DDGRCgArn
 ynVsFbAulfS5D_zCm141OV4Gl5Ti7devpGojeaTIFovs3wd8y.4FyK3u8Rvn_NmwS7cHNiDeH7bc
 h0ro0D_0Noy7G9w5x_F5KgzWEEMbInwfm0zM.WekjtlCNYSnX0T8Ksf9vcb4rtKButPPhnVErzT.
 V.ctkUAg5MkwYh7LzsB0ilmXufGS3puC7Fx78ESc7W.amL854Ve7Y4u_Kr9Pal0PRsR617jff_7p
 ls4pdhaFusS1O3PMFaDtFHYd31MCUKIK3.5WtAFLy3wa1WcY4Ee93FVv5dHXD0IHDFZ8_DPekLMK
 2Sq89MijKDdK7548EGAeLoKId9kIRlXbG9uXW6nxzuNmWcuN9rdgQCGMxkBTDXjPi8JiNebKPRoS
 S6grb5gvXV.oJiZAS0WuosUTg1oAICeTl96F15GOivTUtd0qg1uBPml_Sn81fOrQdr7qkLXkgkZl
 SA1CubyLvvZOrlk9kHSJfwp9yya2wZ3qpWLmtvPYNgiKx8.JNUyv3PyN1qcmKUlxH3dWiDEKP4JH
 QGZB5b6qqltNN.DTe39hYKWYsAxrnPI2wdRrdL6ONGbUw5wdZAxQQn2So09nI4jksV_oTafYEb39
 nqaMnxv0SLA7dBWbDiuo.2w.ilIH_6nFS7TEzAgtB45yC8QRN72yGriOd.ITm94ufiQq4nQKjq5L
 w8B5jo6JJFop3.HBbrVaTx1MMgHMa31hc0ZIMCKO1cL4lyvlnEMiyQW7yDgSXb.h8NqKULL7UdhM
 CoLvXzxxt.0vF1.N29VGTUJGsvTszu7x8646N2wyo0GYLEy62ZB2UIboJuHc8UaSVP.CcxTxsDki
 SJEgZ55_Rt_2rsg9rKbMwPgQIlpjSpQV0psycIOS5TwOlAPyS1SGxzb6ZRj7JNvlNGfhzm2zZ1Te
 1qD8Qyv9Ak2mqWrV1UYu5E93BO09PhrcNAmpyr7gIFrcxxZE.rK9l6UuwTN4JVf3N4iWIPo6v_eb
 nmc6_2OTITBI4wuI2rNyx0c8vAYOI88T3r8x_DUm5Bh_3Z8cjnFnT4JKfYzyet0NGoIZrK5745v9
 2e25VE7dS.jANs0PQGOwuf4hKZGN8O0gm6HcOScBM1AZ5LTtHUgd5IDge3XN0sAR_ryOrUu4hdrp
 4xZWUqi7NC8FJnoBKBPxM9DTRtR.QtaTr0R0..PR_vLfyGRF4pGg_ZgeETxhQrusvpn7.DxMn7H8
 P0JdgKZXw1XGiOi9IaDjZfYwRA_bb1XLaT95FGFkxqoB7RRyLGseLqnR2vZXI63rwzpUkjxfn57f
 LiZS8q_Ip_C4Z0LQxMGL7_RhXnnedi6OYLW4kz7ImA55UQvK7KeS0yQDgWRGhnZt83ZqxygcMOP0
 8KQ5M5_OCf1QCz2fOqaN7KvFrcd15V2BycuzFBrZK3QJtLmreGGFpGERpYGEgaKXvbHhCBx6aHQu
 r3G3TQur9I3NyidPdP.NgfJ3g7EMs5b6Oy.ps18hY.driEHYsnZ6tASAqvd_l_xxPSDlxhYIMP3S
 HgOn7f19jYU2KqG2lolleqDfX16ZgLblIPL0G9Usl4FDw4q248nAiru6gF.KQYQ395w--
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Fri, 3 Dec 2021 00:40:16 +0000
Received: by kubenode512.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID f5a24c40069725080ddb9e10cb290d32;
          Fri, 03 Dec 2021 00:40:13 +0000 (UTC)
Date:   Thu, 02 Dec 2021 19:40:10 -0500
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: Confusing (maybe wrong?) conflict output with ort
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <1638470726.ql5i6zljva.none.ref@localhost>
        <1638470726.ql5i6zljva.none@localhost>
        <CABPp-BEyy97x-9od+9E9DxCDHHq-m8hyZJWqxFutkRy3G7Hu9g@mail.gmail.com>
In-Reply-To: <CABPp-BEyy97x-9od+9E9DxCDHHq-m8hyZJWqxFutkRy3G7Hu9g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1638491699.9sjos0rkh4.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Excerpts from Elijah Newren's message of December 2, 2021 6:58 pm:
> Hi,
>=20
> On Thu, Dec 2, 2021 at 11:08 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wr=
ote:
>>
>> Hi all,
>>
>> After upgrading to git 2.34.1, I tried to rebase [0] onto [1], but
>> encountered "strange" conflict results.
>>
>> git rebase -s recursive main produces [[RECURSIVE]]. It is roughly what
>> I expected to be output. If I take all the changes from the upper
>> section of the conflict, my changes will be effectively undone. If I
>> take all the changes from the lower section, then the upstream changes
>> will be undone.
>=20
> In general, this does not work.  The only time it can work is if every
> region of the code considered by the three-way content merge ended up
> with conflicts.  (If any of those regions had automatically resolvable
> changes, then after taking just the upper section(s) or just the lower
> section(s) of each conflict would still result in a file that is a
> mixture of changes from both sides due to the automatically resolvable
> chunks that the merge already handled.)
>=20
>> On the other hand, running git rebase -s ort main produces [[ORT]]. I am
>> unsure if it is wrong, strictly speaking, but it is certainly unexpected
>> and difficult for me to resolve. Selecting the upper section of the
>> conflict does erase my changes, as before, but selecting the lower
>> section results in syntactically incorrect code (foreach is ended by
>> endif). The diff3 output makes even less sense to me.
>=20
> The output from using ort is identical to that obtained by
>=20
>    git rebase -s recursive -Xdiff-algorithm=3Dhistogram ...
>=20
> on your testcase; i.e. this is due to a difference between the
> histogram and myers diff algorithms.
> (recursive defaults to using myers diff; ort uses histogram diff.)

[ ... ]

> Does that help explain things?

Hm, I did try both default and patience and it didn't make a difference.=20
git rebase -s recursive -Xdiff-algorithm=3Dhistogram master does produce=20
the same result as ort though. I probably should have tried that first.=20
Thanks for the explanation though, that's very helpful!

Cheers,
Alex.
