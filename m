Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8D6C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966C961BE5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhKPLAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:00:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:40577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234410AbhKPLAI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 06:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637060210;
        bh=omsXeReiZxfTgJeyN/jgRaxtv7h2PZ31rp7Z1wnzYNM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=O8spDD+3xdXVcX+q9ziAIOZeVyjopFes2nbUAOrYRZvNNhKlX7fEuAAZp1fFz1GxH
         qAHhPL7xJCE0/sg0HiZtD6vKGfbI+yABb8W0ttdFtUW5DR3GrlI8Q9DeiTZUuf6flT
         dNZODeQ7/OLHAswl40DUWwnOWtGekadYAH7N3igY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBUmD-1myEPO3SSF-00D3fh; Tue, 16
 Nov 2021 11:56:49 +0100
Date:   Tue, 16 Nov 2021 11:56:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Adam Dinwoodie <adam@dinwoodie.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
In-Reply-To: <CA+kUOa=FBpzy4zNMXY1UZybc+13mwLnXrZRVN5HP+NF3h4PYow@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111161152310.21127@tvgsbejvaqbjf.bet>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com> <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com> <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com> <20211104194619.GA12886@dinwoodie.org>
 <nycvar.QRO.7.76.6.2111090051530.54@tvgsbejvaqbjf.bet> <dca03da9-5684-10c7-2315-2d10affd4f0a@ramsayjones.plus.com> <nycvar.QRO.7.76.6.2111092358240.54@tvgsbejvaqbjf.bet> <xmqqee7ozyx4.fsf@gitster.g> <nycvar.QRO.7.76.6.2111101324020.21127@tvgsbejvaqbjf.bet>
 <CA+kUOanh1m=dkE-gDikg53zOPXx_7v65ggqxPspuZWDbdOrR=g@mail.gmail.com> <xmqqtughtlb9.fsf@gitster.g> <CA+kUOa=FBpzy4zNMXY1UZybc+13mwLnXrZRVN5HP+NF3h4PYow@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hS6G9Y538zWRF6xq/pQLBy9kGrhLUjXpM1eiwwSAOIY3vZsPYgK
 zpIixjxCXAW3fCjX88wcyLDDiopZ4MaRMMzug/SvTV06V3781oyyiWm0U7bFyANUjZ7ke6e
 6Imam06D2FWYDwoOYdo/mtRCmR+ZxTDbiPfMi9npZEy79PWtrhANF6nJ+Wcwxw9GqXHXQD4
 fSGsHCI6JAOZzlUh5GsWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbNFJUR5hgU=:dyvEM/GtbXAFPJtP/d2r99
 NGOdRNpXAac3WWPbFBPCUHVT1bB6jx9W1P5vMwo+aOq2MhSIrpXyOxmCMsfReaX/3aD6yHJUn
 xgxrOBFngNVwAxffeHmRiYmk5mQyRPe2qYnrNXPzlse45kLLZU5bqaI91w/4uRJe4UvpaO566
 rHxAaBMg0VBbbbHs5D+uQQZp9IEtaxQKYyYu1fJC3Ux0ZbDlpw5ckTnh58J0iUA1C/8/3Gtuf
 Z7I95I3umOrdIvOidtGbSWm0t0OJ0c5ipK+Rv5Wm/LMnD6azGIeDFPeGF+70gVdn4Lsz97nDz
 xpimPjvBMhTlW14GjPTjGDFLxbN0G1iLRillc9buG0GVeb2Mw2tuu7kaAyOm6g7dZjXkxXIwi
 jdPQiK6Bs+z2sr08e8HnDrzBWePkrzecr+oreIZr2A/LJt9AtcT9Gd33WB0WUiDnGSiyVadTZ
 3IIYpIg7zOe1qr1+9jd0rWGgJo8wdRnjRgUi2zbUJjTXqgtPhJWyfxqu1VJN9wc7czePRWPET
 7+HWxw7Ek+rdLsZQJajDruhHFp2heKkgg0XHNLk/VnchBbZ++7TH5uB71naVaNaMKVNNVu7fH
 53qbRz/udI6JM/WNW/KKa1kITu9WHs4K12FxwD17DQ4ueyigjZQ058L8GivDdKbDJ5U/Z83bP
 0hX+fery+ikSAv/5M+qVAY793JPi2WICTFsW++Dh+PNpZ/Saw1u/KjMb6GX8U1KqMhzjHHBfx
 3TArGknB1iJ4FFxqoU9ilc2EL+IhqwuZI0UAgNjG8FYYuFLkoE8T/nIh/n06mc4/2iS0YMisW
 vQV8RY84TFT6mGgemj9E3IMB6Vj2yMcEHWyBeUK2okZy1a4dze1KIhKy4d6rjm08rKM62syr+
 b5OEL7e6HmhXhgSuOQu5cWBN0MZORewzfsqMv7DOP4Y69aJ+P3jpNnq5RtXfS3y55FHlUMVLm
 POldcOWaHRys3/raNyVl27a3wcowleazAw9uimuaRJZC7ZeYbGIsceAcGJ3gJbX+LiZ+2zbJ2
 pdYRNcYrN3rNEMQxO7n2FxnH2E8Z7W5D3cl7D/0cu6d3ZJhoDcCU8jdrLCRQamAQPbN1L/gef
 WcqrO6V8fGOkrw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 12 Nov 2021, Adam Dinwoodie wrote:

> On Fri, 12 Nov 2021 at 16:01, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Out of curiosity, are the use cases and user base of Cygwin waning,
> > or are there still viable cases where Cygwin is a more preferred
> > solution over WSL (the question is not limited to use of Git)?
>
> No formal research here, just impressions as someone who has used
> Cygwin for a long time and who hangs out on the Cygwin mailing list:
> for a lot of use cases, WSL is at least as good, if not better, than
> Cygwin. There are a few areas where Cygwin is still a better solution,
> though:
>
> - WSL requires essentially installing an entire operating system. Disk
> space is relatively cheap, so that's not nearly the obstacle it used
> to be, but it is an obstacle. This is more relevant for people who
> want to distribute packaged installers to Windows users: most
> non-technical users won't want to get WSL working, but if you've
> written code for *nix and don't want to port it manually to Windows,
> it's relatively straightforward to compile it using Cygwin and bundle
> the cygwin1.dll file with the installer. That'll mostly get your code
> working with a user experience that doesn't differ too much from a
> fully native Windows application. (This is essentially what Git for
> Windows is doing, albeit with an increasingly distant Cygwin fork.)
>
> - There are some functions that Cygwin offers that WSL doesn't. The
> key one for me is the ability to access Windows network file shares,
> which WSL doesn't support (or at least didn't last time I checked). I
> expect some of these gaps will disappear as WSL gets more features,
> but I expect some of them are fairly fundamental restrictions: Cygwin
> applications can have code specifically to handle the fact that
> there's a Windows OS there, so they can -- with care -- interact with
> the Windows OS directly to (say) use Windows file access APIs or the
> Windows clipboard. WSL applications generally don't have that ability;
> if I install something from apt on my Debian WSL installation, it'll
> pull exactly the same binary as if I'd installed it on a normal Debian
> system. I guess in theory people could write code to detect that
> they're running in WSL and handle that specially, in the same way that
> it's normally possible to detect and handle when you're running in a
> VM versus running on bare metal. I expect that'll be much less common,
> though, just as Git has code for handling Cygwin specially but doesn't
> have code for handling Linux-within-WSL specially, even though both
> could be used to access a Git repository stored in the same Windows
> NTFS directory.

I would like to add two additional scenarios where Cygwin needs to be used
instead of WSL:

- In order to install WSL, you need to switch your machine to Developer
  Mode, which requires administrative privileges (which not evey developer
  enjoys, and given recent and not so recent security news, maybe that's a
  good thing, too). Cygwin does not require administrative privileges.

- There is (finally!) a way to run graphical Linux applications in WSL,
  but it requires Windows 11. That excludes many existing Windows users.

So yeah, I think Cygwin is here to stay. Besides, as long as I don't find
any better way to have a POSIX-compliant shell (Git will continue to
depend on one for a long, long time, I expect), Git for Windows will
indirectly _have_ to depend on Cygwin (Git for Windows bundles a Bash
using the MSYS2 runtime, which is a very close fork of the Cygwin
runtime).

Ciao,
Dscho
