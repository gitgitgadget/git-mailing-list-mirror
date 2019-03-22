Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F3320248
	for <e@80x24.org>; Fri, 22 Mar 2019 10:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfCVKXp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 06:23:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:40271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfCVKXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553250219;
        bh=1GKbokx0KEYBT8GT8E6VA3lQIHR9ogKO5FSyJSbO2nU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TJSCYpTlIu1NgHD9xF7waNUD+QSkEzXSkoHt9YjP7jJBolNkSzPNVPOioqWP2Q0rf
         nraQWKsdbZ2dg2bgoj55haVbrAYXMu92S2qkyKWzvi42ET5mSvpKGTfhWsjZTDZnhz
         ULibHxk9Yik+vTSGFq4cWkCNGPhyO1JnxWTXbtKk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lh7M3-1gc0aK2hjr-00oYDj; Fri, 22
 Mar 2019 11:23:39 +0100
Date:   Fri, 22 Mar 2019 11:23:23 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        "C.J. Jameson" <cjcjameson@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
In-Reply-To: <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1903221116530.41@tvgsbejvaqbjf.bet>
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>        <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com>        <871s31vjo7.fsf@javad.com>        <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com>
 <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iCa0GqSo1wCIrMRZWbi61TKn28tVouT/5Rfm1Yj1RT7dQMcCbft
 CBJ0UyWN2CgGOkZRtanAsY9jtJMQxHxBFkfizonb4hH4TxXdS9ejspmerZ/atFuiVtoZLln
 ymxtmskenzzQI9pLBUd3NPIiD4gEpuLV57VZ+zlWYaqCJbrZWMhdafCup295Rj9qsYW2H7h
 VQ9EvAAg9YWM2JaQ6gqjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VX8I0rCaWC8=:757zy6ZR/wl/B2Zt0Ze8bq
 XEPDxUziMT5nGc5AlGr7iyhz9/z4G//VpBk7zMtR+N6iTXsenQh/teJXJQyGFYfdxzzxzpbvy
 DF/BxkmnRCiCc+L+6tLWn4D3vp0VLp93PWr6qMhY8yzmmLj55IKCIzKBFabc5tX0YlyYuRNqG
 ckoV1STqsD8TPc0uaNUOnhbh/cpsnV+PIn6vRXVpxWYVOtDcCYbdyUImFOmP1YXuRVTKR0yOJ
 Cy/b3q9CHccBVDPFE0kU6NtfsjQ41Om5vb+S9A6ONuLTKs3LVf+RfH+vq4ohzIzb+bT1L5kPh
 PgPXp37byaVUavUOPYrpHwShOLyxtIxz1ZcMkKJnu28iPdbL4FlS+xpaWoE1Pf20/dXXDWmEs
 sSUjIbBTMwz7z/CQep7IazeEveD1wGsqGaN6rksGTfHJodhZ5xUSjryO7JN0CiwDBx/NMCj2m
 8nqKGXL0rc/TmhNEYA/ZuFXIZbHIlkTGJQJl8A/z8IRvbzlCFtSiH6+97ZuJTcvoAEOmusmyu
 TXUPh8tAn+nEpKcqWSl0jpHFYiDY4oZ0qsdZhs7Mym1F60AYqlIxAAgf368fTDAL+EV8y5Fmp
 36mFev7PUXe60RypoE3nLXE9ow32C+o3J4MK5+gJcQR07+thwUAd7/7aRu0S0Em3zBf7Kvaj1
 8dVcM/h4HHvjl/tE0Dy4BjkexrWjv1l+NuxBzFE+5EeblW8dIDIe8/YLdFosE28FExjFokFix
 SzzUnAIrlhdIP1y8/IsoOP7ONoMcyNLUQA6mVLNLMn7p8bmRFSUjHlduuHgeMjSZ69D9XMtyR
 3zzfhper6eRM9T/Z0GGwpDs4PFU03S/6yiKaWKlSPnrSJSxWhlGrd6WhG43xKmAaFpw9JIjfu
 tU4YSkEnwnlgabwtN460sd/xPzRJHGVggjkigBdzJZwQf8d5Qfycn8c3/uGjmVe6P6YKHEk05
 Xd1m8wi8dHQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Mar 2019, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
>
> > This worries me that it'll lead to bad surprises.  Perhaps some folks
> > cherry-pick merges around intentionally, but I would want that to be a
> > rare occurrence at most.  There are lots of folks at $DAYJOB that
> > cherry-pick things, not all of them are expert git-users, and I am
> > certain several have erroneously attempted to cherry-pick merges
> > before.
>
> It was a lot simpler back when "git cherry-pick" did not accept
> ranges.  You are either knowingly cherry-picking a merge, or doing
> so by mistake, and because the command rejected cherry-picking a
> merge without being told with "-m $n" which parent the mainline is
> by default, we are assured that the user knew that s/he was picking
> a merge commit when we saw "-m $n".

Indeed.

> It's not so simple in the world after we started allowing picks of a
> range.  "cherry-pick -m1 A..B" did not work when the range A..B is a
> mixture of merges and non-merges (which is the case 100% of the
> time), as the command used to error out when given the -m option for
> a single-parent commit.  Earlier we said that "as long as the $n
> does not exceed the number of actual parents, let's allow '-m $n'
> even for non-merge commits." to fix it.
>
> We can just reject this RFC patch and we'd be in a slightly safer
> place.  You still need to tell us with "-m 1" on the command line
> that you are picking a range with merges in it.  But then I am sure
> that clueless people blindly would alias "pick =3D cherry-pick -m1" and
> use "git pick" and blindly pick ranges here and there, so I am not
> sure such a slightly-more safety buys us very much.

It gets even better.

Recently, I found myself wishing for the equivalent of `--rebase-merges`
in `git cherry-pick`. In other words, I wanted to transplant some commits
(including merge commits) from a different branch onto the current branch.

Currently, I work around this by this kind of dance:

	$ git checkout B^0
	$ git rebase -ir --onto HEAD@{1} A
	$ git checkout @{-1}
	$ git merge --ff-only HEAD@{1}

which does work, but it changes the worktree quite a bit (often causing
complete rebuilds due to "changed" header files, when those rebuilds were
not actually necessary).

It also has the rather real downside of not mixing well with an
already-running rebase...

And with that use case in mind, I think that making the `-m 1` option the
default is even less desirable than I thought before.

Ciao,
Dscho
