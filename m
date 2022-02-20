Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F2BC433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 15:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiBTP0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 10:26:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237861AbiBTP0J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 10:26:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20CB4D60F
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645370741;
        bh=FYoM/mE1kr2+lwgG/1yhxy4/NTrXLGZ2dXvJf8G1xoM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EVf8UVUk/aeaU+42ONmLrTdkfMmXfJl58ZyBqdHVCgK8+lXsVy3ayvRfQJT0mIJJ7
         XIOvGE65JR39Duxm+nbX61xMJib/Co5YQ8Y0LO6WS5KOxeuC4oqKDtw7oQ479LbYS1
         3R/uwVCVmv92cWsQdG9OSW6IAKeE7e/viG/s2xe8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1oKxU71HRS-010Ppt; Sun, 20
 Feb 2022 16:25:41 +0100
Date:   Sun, 20 Feb 2022 16:25:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqtucuw93i.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202201623500.26495@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <xmqqtucuw93i.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5FEimhmo28590Og6xVPR19jWiaSkS2g6tZf4jtozcBgRvNgMyfK
 E4ELgwzYXzTbb8EfynK6ukAqqhuXwCa9ierZX504kcneUTLOGWwViD1QiXT5WXduvEdcjCr
 cVNmExzUTKSlM9yEs5BhCWCXgm4tO3OIO32ZDvaqWxjhlRju/C4wQ+RGC9o4XDWH5WL5QvD
 75Vw/DoIqnQ4cKwLZKbUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hWnjH/vPmrs=:eNpu4NXdi2Up7c4JGgu6Q2
 y9SdSmD51XzVWA/aOThHWWBuE5AiTMVVWwvFuP0cwOb1A+gfz8RJVw7ntrYjBK9RixEAF/RT+
 7FcUqcRyQV7M+Yk09dWFNBI3qYdTUsL2kJB8oz/Hme9yN0Z85HY88NOQBdrSfUP6ai+nF+D+L
 1oqcH9lJerlI2ANu8AGtdoVdE/gJ7PFklwGmXeLjBtbZYNUFK0gtIFJ5BqybK76HK5Ks4qlBa
 b6LVpbnGxEEsUGnfwLXCJuRHHBbFfKfJ9ifFHPw+II0Middg9TA3hpZOruyQeWyIuONqSRRQA
 Z6cxyC+P6cHi3PM0o969h+q0phs7z/FY8fBACzbblbB6A3hHCcbMTWAFS6CAcNTKzvH2WY63P
 GYhDdaKs9F2Ih++qwKYJrbY5uo5x4Pe3I6GKvnSL/hzsPs7f96jSOx+qorEzuol9/S2eeuxc1
 tTbU0dMq61cQNz0dg1eQ3Lxl4r1jEQXycB4SxyzEJx/hS87bKh9wixsX+NUllRv93UHLstgtk
 ekuJL6/tcrQ229Q+YftvUALdzmqzlWEE4M53I010MXvxYzF+/zEIdgnyZS4Hy3mFpkaIGJ5vI
 giEmbLh/DDrXGwfitGGZMqhx5qpRk5T+Yhma99ZcP1JuMW6jdUB6mvw0GHQ46jcUGQn+Jx257
 MMVwzYNkgv6g2G4en/rsuoBwJ+gKAgfJX38n4s1zc8792cV/R4j6hQ5Mj0qrIzbgmPsm2e/lx
 47jjC4HMCTcsfwOaEaeL7j/A+G0oU8VB2odWOQzBut23Oq2pNV7H9jTURCcKmGSWyY8zo0tP4
 LR1jakSmLZkKjUPLX5mz00vgCZx8ryA5JMam5N2aXourUAwUcYfxLwTsmroY7hHCBenGehf1l
 Xx6c/VvRy67Qq/b1IQYWauVn3yF3l5ShUfLU3Ar9Wl5XD6G1fBYJ5cw4+VUhHExLp39kRf+yr
 eSIw0XXpfGFY+eNR8asAUrU0U3J6fFu1OFpYnWDU915r+oJY/jAo/FcpHq279XdBT+g4AYlXi
 T838BGx52niCsuTsWXhzHvVhbl/MsjSqJyYb2Wpx4gTxTvdp4WuZNmqth52MB08U3/VSpqSK7
 Um54emrUN1l/Jw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 19 Feb 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I notice that you did not take this into `seen` yet. I find that a lit=
tle
> > sad because it would potentially have helped others to figure out the
> > failure in the latest `seen`:
> > https://github.com/git/git/runs/5255378056?check_suite_focus=3Dtrue#st=
ep:5:162
> >
> > Essentially, a recent patch introduces hard-coded SHA-1 hashes in t300=
7.3.
>
> I saw the thread, I saw a few patches were commented on, and a few
> were left unanswered, but one was replied by the original submitter
> with a "Good catch!", making me expect the topic to be discussed or
> rerolled to become ready relatively soon.

Yes, I have local changes, but I had really hoped that this patch series
would get a chance to prove its point by example, i.e. by offering the
improved output for the failures in `seen`. I hoped that because I think
that those improvements speak for themselves when you see them.

Ciao,
Dscho
