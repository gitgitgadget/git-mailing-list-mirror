Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D305C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 22:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLNWXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 17:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLNWXH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 17:23:07 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9389D25D9
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671056584; bh=llEigiom55fO9Pv/H1RYx2UIy4FhHZo3xlLv+ZAYC3E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mVc72BQcuCzqCZHdozIHNkasKBkaTvo6HRy3iphp8kujxSyWPigl0QGOeA4p8oMEr
         f+CPFAL4korYaCESBrNYxrGepEjkkZaw3JRMdXLd29OMwHckt7HXQ82TGlHWvHotxL
         5/R7HAwj3tJ2J8aSpMC1H0MEHcetZCno9qgl0PN443lRT79t1n6FGoG1O1TRq3pDyA
         jhabZS6vs79jdrjAjkI2KSkbPZswfDRN/iGlPGGJOU3QoQArNe0XhTRabYTE9bUxfF
         PGbpqUvkmEx+EWR1WU+aRq/tLBwvU6iEw1y0F1N3dQb4R15uajtXtigPgTVDKkzdAz
         sPmfgXZf9lUxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1ocsJX1ffX-00kpgm; Wed, 14
 Dec 2022 23:23:04 +0100
Message-ID: <7054faf0-0f5b-e4a8-3166-bf715ed45a32@web.de>
Date:   Wed, 14 Dec 2022 23:23:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: Issue with git > 2.36.1 and pre-commit hook on macOS M1
To:     Piotrek <piotrekkr@o2.pl>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
 <30f80aa4-d5c1-4fce-f1c9-710eabeaa022@web.de>
 <c07a5ac4-3da6-6fb4-4586-a83373bc05d4@o2.pl>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <c07a5ac4-3da6-6fb4-4586-a83373bc05d4@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I0Krp6/YwMMPMzbgAkupHmJUaBxP0TeOgJpGl6ufvTquzXiVG2F
 81TxXP/WlMbo8qiGUOGWiIqNyS2IGoFdwed/+J44t2BXDl2v/uNgJrkljY9T3lLAP1fcftk
 Sh3Ah9/CBXxW+Gx01+8e5gEw/hphiaDHbN69Qg4QQLCCI7Jjxnh0Wl8o5G6cYZ6KJqfmYkh
 fd+qCeH2mlQVY+XqXROlQ==
UI-OutboundReport: notjunk:1;M01:P0:ojm9gsT/8GA=;DtFdvaQxoOwiRllAv8ZYaG8dlxy
 0BkDy9PARX8Wg/YdvtjN8Too/aJtcfwQ1zWuzB9qfuEwtDLJiMFnPfl58JGkTCuNogQSXXYcB
 0y7M56j5jrWUgYzg9sF6sP2SDSArRpWATUjkgVcU6LP1RbF6IwwqCYDAW9IOG/yfXyz/ybaY1
 IP3WPF04e+o1ELgvCT4dONs63w66g9qB/Yb4DfqbOtBlUAllD5f3sqYM66snY1tCjIHj6Zqx/
 hwgEh8Ei4IL8QLk5n/mATUHuRRaB20RgmXgqU7vk04klNBsrRz1yInosoNK+o4CH4IhVJIu+W
 I6J/16IZZoMj69Hw4839KaeubygpZ8wkEx/HIrlSZyPa/D18nn8qeCZXYr653g9XmwCwwWrlL
 KzuQXqusBeEOg+oo6pcF9HzsHuUqoPpD4XCBW25RRiir511vvaPRK+YYaEjEt326f5MofbZSP
 Svh8abcjTvwEp4bLpo/9b4LaJy3g8QRaPgtjTxXLv+uAbO3o9ICeadCkn79vd/OJJbTcRA3fR
 gueaSF3xmuLXS7W74XdK6g6HZgyOCObR53ySWxpveQlLcgYhm6zod+DdM565CwgjZxLSEen2k
 0EL3339D2Cn9S/G9UJ56gA5GKI6v4iUM/NuayGpQIfTIBW4Jq196yOSN9G7XaGGktE7SPqNLX
 zO5bW0A+7zgba0KmyUN2BuH1WJ5JsoGYZCET2mbgzsLt1ssLuAt4cDmPIYMy8XfWnm7UliFNI
 GaDYiKhxSvXCUKL5VWdm0ba++fe364QsTSEeTXV1e8NRYdlNnQCpuG5EMCBQT4A50ZYvRM6Si
 1Irmxc1hBWFfuE3YOXcERzsoxhazdCdcEJZNSXHEQ85Psz3ykoHNCVZsEQx+vhH3gJmkWTDlW
 5cpc6pCEmBsncXXlrzyUV4ZHLE5aNUmADU6Tio855aqzO9CgDxpoRoaznMRoHong03rVuGpCc
 ZQFf0g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.12.2022 um 22:02 schrieb Piotrek:
> On 12.12.2022 14:29, Ren=C3=A9 Scharfe wrote:
>
>> While "docker compose" is right in that stdin is not a TTY, it
>> never was.  Redirecting the output its seems to help.  So I guess
>> it checks if stdout is connected to a terminal and then expects
>> stdin to be a TTY as well.  Try appending " | cat" to the command
>> in the pre-commit hook, which breaks the connection for stdout.
>>
>> Ren=C3=A9
>
> Just to be sure if I understand this correctly. It is probably a bug
> in docker compose expecting stdin to be a TTY, right? I'll write some
> bug report to them, maybe they will take care of this since it is
> only on MacOS and all works fine with Linux.

I don't know "docker compose" well enough to say whether it's a bug,
but it seems it turns on some kind of terminal mode that needs both
stdin and stdout to be connected to a TTY after only checking that one
of them actually is.  Why not check both?

Curious that only macOS should be affected.  Is stdin of a hook script a
TTY on that platform?  Or can "docker compose" handle stdin not being a
TTY and stdout being one there?

Ren=C3=A9
