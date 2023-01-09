Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB0AC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjAIHsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 02:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjAIHsR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 02:48:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211013D05
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 23:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673250487; bh=MyBiTe9FAUTFH/zSyxg5Adb9BDUwpvyE/aGFFT1GpXM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NRz1O2EQnvCkJGyISe7cdaOGEE3InZnjJlcPtuleQO51lKe9jzil/CIWPFW4bGknK
         /BEXWDx9hKBgw0b0ByX/SB1xlwnqXqCv8Yf8rZ4tFqSInn5XLQAS82iQHvJ3HDa9w2
         50LT+SLHEM9r8Uj31/TDkiAoQCu778PslUuYDSDBMiZmqOZWwjzRqxql0TrcY2bzPk
         OYw8eXMsQfLSKOnzSku4ymQObGLw7mZeeOM7eSyv/lmsyw3NK/SI5ghaVLoOIqKCtg
         S37cpKc4XHV3gsiCk8CrWK9Wy0VN/Dp4TNMmIFdEyiXsWTiXJsNj1q48ksdkBaI4N7
         76Kb4+fskJ7Jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.31.64.27] ([89.1.212.243]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6UZl-1p7wKM1W6j-006yyE; Mon, 09
 Jan 2023 08:48:07 +0100
Date:   Mon, 9 Jan 2023 08:48:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Harshil-Jani via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Harshil Jani <harshiljani2002@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/2] mingw: remove msysGit/MSYS1 support
In-Reply-To: <xmqq4jttxt0u.fsf@gitster.g>
Message-ID: <4a2ce224-85e4-5903-44bc-664aa5a59f91@gmx.de>
References: <pull.1433.git.1670274213.gitgitgadget@gmail.com> <e6d3d280a4f9216aa6e9c3c83a38b0fb8ba3a8a1.1670274213.git.gitgitgadget@gmail.com> <xmqqsfhdxxyj.fsf@gitster.g> <xmqq4jttxt0u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c9nPmSG1+mFYs2Sf3gMDvWJshcuvCJJpwZWZaQH5W8r69vJpwVH
 bvqXmb9/55WCXsBP3qjQPC7H/w6xTx7H7Cy/wN2Ggrl/eKhcNPQa/vkNl5GKsEQNfF0g0uu
 Jp5yyjF0mYNct79pGHWKnhc2N/Gbid4wMHeWOo+V6MYYDsAR/86lugjeRP2UcJbRFQcOzUF
 iyHRC4mbxff9FBbSGSf4g==
UI-OutboundReport: notjunk:1;M01:P0:ZfaommnXDNY=;SqnBJwuhkReJsQtHhHHb6iX4aRR
 zdFdzobM0HMZNi+3v42VvWKIQZx/TkvJUbnXVGwIT/hue8VR1ouzE8z6lQLs1nEge7DzfcW3z
 OkWV3P0Tu4EjGXJIzXggeZuvIxm2Ps2aplAu4Brk+xf3690ukcG3zSGpGcMLCY/Rer0y9gIO2
 4ihjmTFYctz8/vtvuJrhUH2jd0L8j/AVDP9i4YiuIrwUu18XlDyGxA2VoHplzky+DZuoDOUeM
 AK8tkqVIKINat8AxoqqchWvaL56vHRVD45uBljYj2WVC7YkM0TnAbNycqPpkLVJwDOLlUdG2F
 qyPci58zvNorW7DaaG155DOJcvENjW3dbmF47ZwheP+N+A6PP8VjrKxv9tKEHilP74V6eDrE5
 2fcd4v3rJaPZIaXHkvw87siCQ77mkcjweZSI1jj7wNIdhWIHBWFAOHK+ULKUFh9RcGQC/VsXE
 1YDXlHxpCBoOSZR8eM/XWkQNBllpKcxPltqp7pAzAvGqyBIQq+3j5SQLW/+2X4JIhRhooN1zV
 Jfgn2qZD5URltbWCApjehIUjnT6QbO9jzjcSB563Up9kAZVBg+gWHPAKmEu/iTdO76OjVpnKQ
 NXYC0wPUGt3ObJclo/YnkVWqXH0l9n7+NEpaDyt7TPYLzsrfVTqlj/QxIh9S+JuiIvuQNtjx6
 C2WnrhPa4L9EULzmlC+kWGQ9W2hNx5xON+/9WthCKPts710ktJ/KvKQsoFXQ4ndn2ndWkqKmh
 3R0ypBFUkHdSZQTi4kwBUYMi6HqCUPIvFwA5mP0CsOd+yV0L1QvmIvkjSOkjyHNWNQNB1HnKG
 1FHrNsci5QM7kTQFtUOLKRNMoh0YWHw2kgglXqAQmTqJ/4+tz8JIeOW4sWFrvUbYbUsy91Upq
 Y71T3gMbihnh82s5vq4tv4i0qKzznTQKS1VKc04d10YoLcj+CcFLiK1ZouUTwIkDauFlMO5AU
 QJXlQtbu8fLh/3tFFj130xunYBs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 18 Dec 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Harshil-Jani via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> From: Harshil-Jani <harshiljani2002@gmail.com>
> >>
> >> The msysGit (i.e. Git for Windows 1.x' SDK) is no longer used and the
> >> last known user for MSys1 + MinGW has switched to MSys2.
> >
> > It is curious that we can speak with such a certainty of the lack of
> > users of such a popular project.  References?
>
> I see J6t mentioning about such a switch,
>
>   https://lore.kernel.org/git/c9aec5b6-0a78-a580-3658-5189bd2075a6@kdbg.=
org/
>
> but I do not know if it is sensible to claim that this was the last
> known user switching away.  Perhaps
>
>     Last time the code around here was modified, which eventually
>     led to 49d279f8 (windows: include the Python bits when building
>     Git for Windows, 2022-07-29), the change was carefully written
>     to keep things unchanged for Msys1, as at least one user
>     (Johannes Sixt) who did crucial work to support Git on Windows
>     and we did not want to break Msys1 (yet).  In the discussion J6t
>     confirmed that he no longer is on Msys1 (cf. [*1*]).

It would be good to avoid over-indexing on individual person's
preferences. While it seems to be quite common in the Git project, it is
obvious how this harms the Git project more than e.g. focusing on users'
needs would.

A more productive line of thought would therefore be:

	MSys has long fallen behind MSYS2 in features like Unicode or
	x86_64 support or even security bug fixes, and is therefore no
	longer used by anyone in the Git developer community. The Git for
	Windows project itself started switching from MSys to MSYS2 early
	in 2015, i.e. about eight years ago. Let's drop supporting MSys as
	a development platform.

Ciao,
Johannes

>
> to replace the paragraph, with this at the end
>
>     [References]
>     *1* https://lore.kernel.org/git/c9aec5b6-0a78-a580-3658-5189bd2075a6=
@kdbg.org/)
>
> explain the change (be sure to explain ../THIS_IS_MSYSGIT bit, too,
> not just the $(uname_R) bit), and then throw in something like
>
>     There may be users other than J6t who needs a working Msys1, but
>     we can revert this patch if it becomes necessary (i.e. when they
>     complain).
>
> somewhere?
>
> Thanks.
>
