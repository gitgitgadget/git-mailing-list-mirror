Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471AC433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5875D22D57
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhAVNzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:55:42 -0500
Received: from mout.gmx.net ([212.227.17.22]:59089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbhAVNzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 08:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611323640;
        bh=NXnRGZci8TDADEiOmFkUM7PLDvS9eViz/p07jM642U4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R/d8Z+fDBtv8IcHe0lKy3cDBeHc7DxqwWlYafmJJ/GDA+4HEos/tXeYYUsJeS/cdX
         5YFHH8Wtcl4fKWs3a0+CApn+q8hysfYK1/Si+urR00PF6AdZ0B8dbP0PwSC+R3xSft
         rNBL67jnblQXzE4EnGWYrjsG9Yul+gBuxthHGB4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1lox8l20mZ-00nRqf; Fri, 22
 Jan 2021 14:54:00 +0100
Date:   Fri, 22 Jan 2021 14:54:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Mail <mail@dragonsoul.com>, git@vger.kernel.org
Subject: Re: Incorrect $HOME value when using runas on Windows
In-Reply-To: <YAoraIvKWWRj4cLJ@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2101221432460.52@tvgsbejvaqbjf.bet>
References: <b2b0fd42-14a8-fbb6-8817-4e53efb9e730@dragonsoul.com> <YAoraIvKWWRj4cLJ@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:no3Lwx5WtoJArvtylrHdbFIhNuZWl012QOQNYcvSWvZvu0rSEze
 N1WrL/LhayBXBRS51pbHlfSZe7qbpbf2MxMurMDZOzoOsamN59mFN69kiPSZNCNV49oZaZe
 9gyMoLjYhbHeFlPy5IKvn5+LbJZ0oUcFyGmvzRXXxdLO2W0bXfrrMCEOzCooQEJdU110ga7
 /JpuQNfwFEfSmAhv3/CVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J2DgIY35xCU=:kB99v/caH83XpI1VehfxXV
 px9dcr+WYMw+LZu9YpBFN5tunlwRQRpjKZbs28937XpWo6IQMVeqPIP4GdB8qxLrzi1r1ZEsl
 9XLF9KcF4yZitHf4sUzVCgIFp90cJJ6LuCCKBHS2pz9vT+iVgvuZjiWEat6I5FmVUX/xBrk6e
 eqmXzyi8SY/L8mnArEofshzdDMlUbCcMW8XjrvhtnRESg78LqmiAT5Kr/+mpXKGjAjiMLtgBQ
 ojCl0z17QnTonGAgzrfDRAr+nB3xUzdGH6ywzMyJIXmMP1Jy1faUZHBuIK081ehXrjSEWBzp1
 csUbYT5d7Hv9FTkFin0jnpcFoInM76N2+gz8To1eEs6fYI5h0y5EozvRmSMbFUR/X7ue5ZhbI
 DYmQBLqlSZam/rZbyc9gPdrootoTf4PREhHEQI2K9wdlStHNwYN1hneB1eh8latFFMtt9GmZS
 aTr9nXQhFJRHPnIKyn939d8NdLaDfZW/+ri/cJr0Vp/wVpDHe0LtngUR+uYazIPaKleGN3/+U
 6Co0f7XQnZFDfv3/1r0FQX5Z20mVApxVive6QuAQkFmOTXDpa90f4TKGfuvPi5Gwdww8gr3Pi
 D2QrbDq3LFgffL5eJP+xvdUhNRfK/eoNnbVtPMn9QZeJPTeRICUqR1ZSZEbTpaD6Bf8cu0QgI
 xbWlLRiQv6QTFAQu0e/0enedvyyadQVkpoeKjrp2YzxHWbo+KIfBsIdBwy5oU7ZpREs6gFvlc
 9tOZXSYovXBKGS/s7fGsUIHjtaxgmqbFdes1nWW/GmuZ/xSBaDSr8hQQ0uEVzkzc93wJk4x/f
 9HZmcNYpoAvF/W7y4f9fRIamYpOTtZdgpz/fvRkO5rr4cw8BSQXOkuij6UkLW/M9xSNV1mPVo
 hfe5IETHTXC1NAjbLuyR+0uOPT2E7+JWgkftV8mQU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 22 Jan 2021, brian m. carlson wrote:

> On 2021-01-20 at 10:12:57, Mail wrote:
> > To reproduce the issue:
> > 1. Install git-windows x32 or x64 for all users.
> > 2. Install Total Commader or any other file manager that support syste=
m
> > context menu
> > 3. Add user in Windows via msc or settings app and set password. Don't
> > forget to disable "User must change password on first login" in case u=
ser
> > created via msc
> > 4. In current user session execute runas.exe /user:NewlyCreatedUser "P=
ath To
> > File Manager"
> > 5. Right click on empty space in file list and choose Git bash here
> > 6. Type `echo $HOME` in bash console and press enter
> > 7. The $HOME is `/c/Windows/System32`. Expected `/c/Users/NewlyCreated=
User`
> > It seems git for windows uses HOMEPATH that points to system32 in case=
 of
> > runas command. Might be using USERPROFILE variable is better.
>
> I'd recommend reporting this to the Git for Windows project[0].  The
> setting of $HOME is normally a feature provided automatically by
> Unix-like operating systems, and its behavior in the MSYS environment is
> controlled by Git for Windows.
>
> [0] https://github.com/git-for-windows/git

There is actually already a ticket about this:
https://github.com/git-for-windows/git/issues/2709

I integrated a patch that fixes this from `git.exe`'s side, but had
forgotten the `git-bash.exe` side. Here is a PullRequest to address this:

	https://github.com/git-for-windows/MINGW-packages/pull/45

Mail (if this is your real name, if not, please substitute your real name
in your mind), feel free to test that PR's code and report back whether it
solves your problem or not.

Ciao,
Johannes
