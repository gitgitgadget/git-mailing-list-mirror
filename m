Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1055C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7140761041
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 12:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhDHMUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 08:20:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:34913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHMUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 08:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617884387;
        bh=8cakOw17VNs9EfccEUEtZZuTvYwzO+3H3XVnGVFALo0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=af9JNf8tyGAkEXK5s8YZjnicUathSaxejt7Y0fuEKs9Ndrun52nH+i5OLHfMtPTxe
         HthvkNxHpUa3UFX5o4RJCgHoV67tKwsApswMd8a79aGvKhFRSGD3fsJGPHyhAtyauq
         Qtjy6kKdQmzcKqWvvDeQ+H4GM7NXrz5EKeidlZM8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.233.45] ([213.196.212.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9QC-1lklT50Wsm-00s5Sz; Thu, 08
 Apr 2021 14:19:47 +0200
Date:   Thu, 8 Apr 2021 04:40:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
In-Reply-To: <xmqq7dlk2ug9.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet> <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com> <xmqqa6qg4d0i.fsf@gitster.g> <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com> <xmqq7dlk2ug9.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nc2DbQY20bWXdzx/MXZfu92fJRdsOcmrtrpCafHq1NvXdtP4oEY
 ZxR21wvA6cBIaNkfxq+bzeuXjs1egRkMIi/WHPCerI1JHnLWjTuoI9Yp3aWQV0aMb7te1TV
 I88N8lttW9/3J3MTp1gIKGmzGUOefBmdx+kgBjQwIhT75C71I/2vb1Vt8LlXze1Cv6CCM/1
 AFWN1LJUYu0qPCAv2NOTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YHOygVIRWgM=:Uz4uTJAvK2m4gAn99BO6Q2
 8wANRY9uey0dhiampV/S55jgTUW6tt8LjMHtfiXPTatXdw/MlJ9rczc1WZxMk/Ll4ikAq1ReX
 2o0nmC7ujDOtPoSFtnbPAwG2RJml+BOFRt/r86WuJz2BHIZHFU1g9TJIZmCHv3Gfd1Uebw3g5
 2aJT+nnHYFdbVsjHAfc137CLfJvC+ktJ7K1lJng9M4cwlZc+r+96xII57x2Rh9sMIAapzoZ40
 MVuehxUSlZ0R+IIUEP1olXNf5AUR8IaClHW4OWIAqFsnkhoa7yLaJ7s8bKXdd9b3tBh988/iv
 Q8IPxjAUmvy0nD8H8EinwtS1x2I+6Hir5VGMl3MnvqZDPgkWfqwzycCKyFy6a0bFXUtRYE8fW
 b/rVuvJ/iAXJ2L/nlbkF8lJt0Tbx+KGUQnNhICVjSQjwoEyIqGf2pjQeQh0xJ5OyqKKAKOy8S
 o3uBH7UG+mqztVC6/zbWiQwpXjv2EjJ8jpeZ2Ck28dGGaREAzdrDXI3KidtCdB4U8/h5tAfTL
 xaGAd3IKy9e5KUgX+tSle9ml+9PlAayDy5DOKpNM6C+puYQI5fhfXDM1fpbgK03dd7tVt4gGN
 hC8Bh6AwQr3T+N2t839TnygfA4W2l/Wxw5GjvTtSSlG6cwN+Nan5mcc/UlyUHO/bGTPX6YJFV
 R9+UlzFjVzBKro63UgcNaKBcaT7Yv+KrLZa4XVSoLahrNCzDx1Sj3OLSeBEeNMiNZr2XMG9Zl
 X5XJgEMNFi1YguXF3OKieDhfFbUmRFFLq3OHKT5H55fKtLUZIjmlnRhfUwp9pL0oyoEvvLnvn
 Ehky0ieYaGkNIoKoHT4TioNwKaRSIh/ASKcIukfTa8XWg1qgUe8qJ3SsRiS08vcgD7uQE7ZqN
 MYylhjjxA7ThoaS0sWiZmnDwr1kqeHBK7rY5qVqp9mDwtx1n8B2yTwRKunSJzaTEsxR1FPwF5
 aDXKJ73HG6aeikXWxEQpC5cLC9CnsTh07OYlth44+Vy8BAp1cCMM0DXrEkrxGD3t/Pcz5QWcr
 ly5pTA9tSg5DoPXhopgN1jv/CJUQnWOvKFKmTf87wjOVdnSK3apXj9Rf24wDaiJdowNI7ldBT
 HDyMsLXHQrfbsT2SIiJU4bpN3OLIv2pUAHMdY4nSQM13Rqys/pphMhTSCmpSd1DlPPDr0f/qD
 cUb+ygGazyjqEBQIZPocuuCC8y+5rZ5nTGbZYBfPDP3+pz/w7K0qulXQ1Xq7PbWbw3Ik7TBew
 Q8c++scZGkq+OJsqW
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 2 Apr 2021, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > Even if others now disagree with the above, I know I can get a huge
> > speedup by changing sequencer to stop per-commit wasteful work (stop
> > forking processes like "git commit", don't write control structures if
> > the rebase hasn't ended or hit a conflict, don't update the working
> > copy or index or reflog).  It's enough of a speedup that if backward
> > compatibility won't allow such a method to be used by default, I'd
> > still make yet another backend that could be optionally used.  And I'd
> > have the default rebase and cherry-pick start printing annoying
> > deprecation notices so that users become aware of a faster option.
>
> A faster and less powerful interface is good; I doubt deprecation
> would work well. If a workflow depends on things like post-commit
> hook, the affected users deserve some way to migrate to --exec or
> whatever method to compensate the loss of functionality.

I could imagine that there is opportunity to "persist on disk only when
needed". For example, if no `pre-commit` hook is installed that needs to
be run, there is no need to update the worktree nor HEAD until the rebase
is done.

And this type of `only write to disk when needed` functionality could
probably be abstracted away so much as to make the rest of the code
look elegant again.

Ciao,
Dscho
