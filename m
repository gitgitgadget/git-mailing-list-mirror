Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0443C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2B0206DF
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 12:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UMkNGU+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLCMFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:05:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:45637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfLCMFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 07:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575374701;
        bh=9gGtNK/c1O/CpKCLp3AAoH5mxjOXHgVJEg1j4X5Y1L8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UMkNGU+y8MaZZRjv40GH4yyFgDlgQ+4s/DH3Az93Nr5Xx6tDLWjL3eEX2XvYgScoQ
         UEedJft1MOfPk8s2y7EYSN47ZBxHqP0AEW4pWgAuOC0lVuMj9210xJZqeAQ7DTl0MI
         ezE9WQIWiUQcLes5p/enxSMFGrfbVXVDjRjFIdEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1hvNAn0AIe-00lSAR; Tue, 03
 Dec 2019 13:05:01 +0100
Date:   Tue, 3 Dec 2019 13:04:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Brown-bag fix on top of
 js/mingw-inherit-only-std-handles
In-Reply-To: <a4ac4530-9b5c-3eb6-ada2-067c6ef73868@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1912031303250.31080@tvgsbejvaqbjf.bet>
References: <pull.480.v2.git.1575110200.gitgitgadget@gmail.com> <pull.480.v3.git.1575286409.gitgitgadget@gmail.com> <a4ac4530-9b5c-3eb6-ada2-067c6ef73868@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S7ktqUNpMHVk5Ebmvy+gtGt2RGlKd27jXhafDVVn2FIkINgPp5J
 1UmsE4uTVKyMFTVRE4Mng/XSCKr1DnDERiZQ5gpnoq4wOl60EuFQhxRMeNuuiBuYx+wpIkh
 XB7HXLwH4/ENJITZpnovb+DFcbHDcUVERBJV4QLl9NaCz7eBrBaGr5fLdi/RzHhS1O9Msl4
 dW1RkGAJYPX4ywnFcLsAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EW67TU/7m8o=:+tnXlkPxyDxHEE8jOD3B8w
 wswWzIiDDt+rTTTVFdNk2ZesMmNk87Rk1In47eGfLSkdkbVKAKYO6OpCHA485zG8AZYNMa6Xj
 25W1/SZxq64JPMppAPMYsX/J0tjh1rFt4KTvL05i6hcYKa8DGQa6qsR+V9sF6CH+YTlSOEolq
 LkaNqbD7N80VxBmvv2cxr+M9172Dv8Jj+v9y1OscT3cMgn4KpxAXO13SwGZ8ZEEs5vXW4p+HF
 djl+Mo8nGkyeVPLcJJxWfS3DOvN8UlXcRKuXoeaRlZv0ExOB4Gey1wfj1s7kfWZpII5m3sVTA
 ePpGcC88U+kPcDknDodYvg8gDqoOQz8oAUqlXOeGMWvO+J68CgmXsLjBpPNl35twgmk40sPjp
 AswRnqE/EZRPTwD2ZYOBBf9C0tfyxGngmtNJUXMskLtqhS/qHef7IqlhzabEmtNn2L2Gz/mQw
 /g/gARit+Uc0d+yk/+iDk9KRMgo39YQYJrXK+UruNGigzbdcIoV/P/dHGgXVWZiTMHOiVYH/T
 wLYhmvZwE4m6lHYMWgDet6jO3kajXmViYGNcedZRK5zWY19USp7T2/2tASZ26c2Hr7GshlvQt
 rUeBoaAx0nF7ogAamdmwRdeclJ4yTsH0H3GothwpMAkP0uZ71g6zPTAJXIylNv8up+M4uH/rF
 dbLi8Azy5W0Scizt/2Si/+reZi4njni0+eA+S8j4FvUukgrkf1KPwGiC5fVFRwWZWFBFAnuoD
 xXtow3c8+BQHcYbinnNq58w4ZB9yeOYADVmvRVvm7FEB0P7ZPaOxI9TI/CJFgGtIjPp2zP4o7
 fSQ65NrxWm3Z9ARd3QdX9mz6OnWXe/guF5y5SIbsekhga5daQxu6H6mPfeSTFBJ8Dl2WpWxNX
 dOAy3oy149WBfwhCSpAJTS9LC06O/aJloaEUUwrLSSt3SlLbiQs2ymM40JlAQue6v7ns5qH2o
 dkCFZUJWa/A29pjOckR3X3qOzAlgh496i8r9KNJkYyzxUYkT0CD5AWNv5W1v/TjkMuY2UMuM3
 P/RZ8if8KwOP1fA7GD5tVLulAbu3GAW0p6Fy5cnjX8t/WV4RUTeE/X9zOw9fH6z9Ygss8+aFe
 UWSHBYAsRyW/nnYr7iHH9r0nMI4omsElJEGQLaUAerg6oLM7RjX3ZnlwoGcGD8b3cHm/Bi8LO
 UyW4V4WOIj/P4NdO4hwn+GIS2c8rIif7aE+zrKmYj1AueujsgJnns1vQ9mpOYRpDkRCEJ9Mni
 HnxSFGKyStdY4B08Em45O1uzgxLxvG15nVzkd7HQzUxEDUF7Yn9r28pjhM8g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Mon, 2 Dec 2019, Johannes Sixt wrote:

> Am 02.12.19 um 12:33 schrieb Johannes Schindelin via GitGitGadget:
> > Range-diff vs v2:
> >
> >  1:  280b6d08a4 =3D 1:  280b6d08a4 mingw: do set `errno` correctly whe=
n trying to restrict handle inheritance
> >  2:  c3dea00fb1 ! 2:  e04e1269b3 mingw: translate ERROR_SUCCESS to err=
no =3D 0
> >      @@ -3,12 +3,15 @@
> >           mingw: translate ERROR_SUCCESS to errno =3D 0
>
> The subject line would have to be adjusted as well.
>
> 	mingw: forbid translating ERROR_SUCCESS to an errno value
>
> or something.

Oy. Thank you for catching this! (It is always amazing to me how much I
miss when I have stared at the same commits for a while.)

For good measure, I force-pushed the branch of the PR to match what Junio
has in `pu`, but if there are no other changes I need to make, I will
refrain from submitting another iteration.

Thanks,
Dscho

>
> >
> >           Johannes Sixt pointed out that the `err_win_to_posix()` func=
tion
> >      -    mishandles `ERROR_SUCCESS`. This commit fixes that.
> >      +    mishandles `ERROR_SUCCESS`: it maps it to `ENOSYS`.
> >
> >      -    Technically, we try to only assign `errno` to the correspond=
ing value of
> >      -    `GetLastError()` (which translation is performed by that fun=
ction) when
> >      -    a Win32 API call failed, so this change is purely defensive =
and is not
> >      -    expected to fix an existing bug in our code base.
> >      +    The only purpose of this function is to map Win32 API errors=
 to `errno`
> >      +    ones, and there is actually no equivalent to `ERROR_SUCCESS`=
: the idea
> >      +    of `errno` is that it will only be set in case of an error, =
and left
> >      +    alone in case of success.
> >      +
> >      +    Therefore, as pointed out by Junio Hamano, it is a bug to ca=
ll this
> >      +    function when there was not even any error to map.
> >
> >           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.=
de>
> >
> >      @@ -19,7 +22,7 @@
> >        	case ERROR_SHARING_BUFFER_EXCEEDED: error =3D ENFILE; break;
> >        	case ERROR_SHARING_VIOLATION: error =3D EACCES; break;
> >        	case ERROR_STACK_OVERFLOW: error =3D ENOMEM; break;
> >      -+	case ERROR_SUCCESS: error =3D 0; break;
> >      ++	case ERROR_SUCCESS: BUG("err_win_to_posix() called without an =
error!");
> >        	case ERROR_SWAPERROR: error =3D ENOENT; break;
> >        	case ERROR_TOO_MANY_MODULES: error =3D EMFILE; break;
> >        	case ERROR_TOO_MANY_OPEN_FILES: error =3D EMFILE; break;
> >
>
> -- Hannes
>
