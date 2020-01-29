Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3639C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFFB206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 15:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V/y21zDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2Pan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:30:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:46925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgA2Pan (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580311837;
        bh=T+KR5U8swJnnLvb8tlX2XgGP0AhxxvN8mFYLH3ZFycs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V/y21zDqsJlgNc7NLuBJXGTF5/abMU6oCaAqnzGAAX28pMWLyOjSJeFRD7fMJ/FXC
         iiS8VznkzLUcyUbsqwtmXW4MS+Ov9WhBUYtR/6YI0eKgl8fHofHNn9i9Pa640d9lBF
         1h3R9LkhE8/t2AxwD5vPdpuoPKP/egNhswjzFlk8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1iqTeI0VB5-00Bu76; Wed, 29
 Jan 2020 16:30:37 +0100
Date:   Wed, 29 Jan 2020 16:30:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Sparse Checkout Trouble (2.5.0)
In-Reply-To: <e4bb20e9-ad90-3e9b-7ed2-c7793cb8cb22@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001291626550.46@tvgsbejvaqbjf.bet>
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com> <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com> <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com> <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com> <de300697-baba-62a6-ea4c-c5bd472954c2@gmail.com>
 <CABPp-BHRAA71LmfYb61N+qAgwhtii7TSEVJksiAGnnO-4bk2dQ@mail.gmail.com> <e4bb20e9-ad90-3e9b-7ed2-c7793cb8cb22@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+5tpF19aknCsiM5tXVBftJh0qEsGk1Jd0T9Kc01fseT/fC+3ao9
 7q6yyI5cKuMtWBj3gD8a3/75ZuShc7dAFAg96JP2nQhmyG50whQOu4X9UiuIzZOE/lR3FA/
 mWz75bdz5uYvDSGvLS69YlTnP58W2k6+Daw9tO2XZYd1jd6F60TnYYLM3uqo8JqZAvGfzdq
 VbOIgu/ss4yMmaeRMosug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2KX2p0QbAZY=:0JXs6v0voGmsC/I/vejHQz
 KEKuHaYBmnkBYv3ZUEQ+V2wI6NFZWUBoflcb2Ui7TxPu4+8ytNRBbpP29Wv+ywdsMcHx/aKH2
 xpRssQOkkltacjpfOXx3ZTwOWjity2ID3/aTSv9I81dtqYhbuk+oy8pWpex5IRTk7vA21a3Uk
 YC/Tp9xQiRBXo5lfLyFb/YI9nlEQ7vULo1PUC16rnpoG6ExXjPJ1lj2onQy0xGxkWEcBc1ZF2
 J1hFdCNg/udIzDlxBZBgT7f0hZmxktBj7n1JEadOdlpBZd9/y+nL8upG1AXw8/bUPXRa5bWs5
 e39yMZGT16X1NH7PpHuoisekzmtc3JWyIZ9JO16EAARBSL6U3F1AI/E6K9d31l7H5SWVmyyOG
 u8K+pr0oh1SLHHOEsck57voM3re9Ak7/imOIuLC/c6LllaNpXl85rh+onZikFMG/oUlSwmWpV
 Z/h7Ii+PxJ9Dufjb0YD4cfiQrcdGjqcc2j2tUgm5rb1LSKeVZ4KMgsHZiPWXAofHnFx2gCwbQ
 t4+x53R33YpWh/KbnYuHmHCLzI8q2wSvcMC+ED49+f4TLHCRAPuSw0ZcAj8hZXpovyD3OtgLZ
 xSf/s/YkBiG9ghxgptr0cV9fsbwBOhEa1lldfqNDlqRdAPoK/w7KwljsT2WmfFZmyB/SRUH+G
 Wh/vsWy8xp4RUGDP5aB6Y7auHQhui5tYGCYpp+kDquzASWVLTtpqeLZPWAup89gBYyYIXx8XI
 JbVUGwy905H4CuJYA4iAsloK2Zkegd+rOxdf34VIQCnaS0VVBbbeZwm4bvFefDkayCqI0bH0H
 6t54Nc9+9o5xgfnTlmNyHi5D87hnapFrkyOYbnLpNVx5JzpLudZQqcizZfMS8NIPo9mmg7L69
 Xd7X8C0TTDHKdfHBkwz1uWSsZqv9olXvz+7Fh81wzTHPrbAUpsu3QtEIOBra9r2ppVtecbeYn
 ySJwhbUlrknVenGxUyc7B1yEI7esyKIzrdOIghTBZ7iFcGM6A+jb9vW4gstSpDjzJa0jFOE9K
 roVhEPTOKcLiAi5EjJR5lN95SyuGUCFKAMOrxGu836xUS+hvyff6TQRVMuxSMbKGjdM/GyXz/
 AUfMnHBNeU3yyHxN1B71RLV/aLDuratykJBDNwaZnrfQXNS3g6DfffSHjwPaisWr1smYsPZbl
 smDYuXL0P+vZOw7V12nJjIG+lFSpXN3JFwUM764boI/H5YMG0OKsW2ATEDWxTKjjBwEFRbcj6
 rjOmO9wDMx4vzWSSO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Jan 2020, Derrick Stolee wrote:

> On 1/28/2020 12:21 AM, Elijah Newren wrote:
> > On Sun, Jan 26, 2020 at 6:09 AM Derrick Stolee <stolee@gmail.com> wrot=
e:
> >>
> >> On 1/25/2020 3:59 PM, Elijah Newren wrote:
> >>> On Fri, Jan 24, 2020 at 7:41 AM Derrick Stolee <stolee@gmail.com> wr=
ote:
> >>>> I'm CC'ing Elijah because he also made changes to dir.c, and
> >>>> perhaps he has some idea of what's going on.
> >>>
> >>> If you think it might be related to the dir.c changes, I can take a
> >>> look.  I don't have any immediate ideas off the top of my head.
> >>
> >> The only thing I can think of is that these paths are already
> >> marked as sparse, but something is requiring us to test if the
> >> path can be created with the filesystem. I'll try to debug
> >> more into exactly where that is. It's telling that this happens
> >> both in cone mode and without.
> >
> > Yeah, I'll take a look.  The exponentially slow 'status --ignored'
> > report is forcing me to look at dir.c again anyway, though it's also
> > delaying me from getting a chance to look at this particular report.
>
> I made some progress, at least, in root-causing the issue.
> The problem bisects down to 4dc42c6c1 (mingw: refuse paths
> containing reserved names, 2019-12-21) [1]. CC'ing Dscho.
>
> That commit updates is_valid_win32_path() to fail on these
> paths. We were _already_ calling this method even for paths
> outside the sparse cone, but the method didn't fail for these
> examples.
>
> This means the fix is probably even more complicated: we need
> to not call this method when traversing paths that have the
> skip-worktree bit enabled. This may lead to some tiny
> performance gains when hydrating a very small fraction of a
> very large index.

Hmm. I am actually not sure that this would be a fix. It is all too easy
for a skip-worktree entry to become checked out (think e.g. a merge
conflict in a cherry-pick, during a three-way merge of a file that is not
in the cone but still needs to be handled).

My preferred solution for this issue would be for the files/directories to
be renamed using `git -c core.protectntfs=3Dfalse mv <reserved-name>
<non-reserved-name>`.

I think if we try to play extra games with the skip-worktree bit, we risk
opening a vulnerability again.

Ciao,
Dscho

>
> Thanks,
> -Stolee
>
> [1] http://github.com/git/git/commit/4dc42c6c1867a52e22f1f04a1a247b5a753=
8b8af
>
