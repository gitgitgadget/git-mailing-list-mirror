Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81588211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 12:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeK2X7i (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 18:59:38 -0500
Received: from mout.gmx.net ([212.227.15.15]:37017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbeK2X7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 18:59:38 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LuxG5-1fSEqv4AaX-0106Sp; Thu, 29
 Nov 2018 13:54:17 +0100
Date:   Thu, 29 Nov 2018 13:54:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v11 00/22] Convert "git stash" to C builtin
In-Reply-To: <xmqq8t1gwano.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811291352480.41@tvgsbejvaqbjf.bet>
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>        <cover.1542925164.git.ungureanupaulsebastian@gmail.com>        <20181125215504.GJ4883@hank.intra.tgummerer.com>        <xmqqa7lwz8xm.fsf@gitster-ct.c.googlers.com>
 <xmqq8t1gwano.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mP5m5QfaHSfbAWmR/q4aL4zDEGnQJswngio8An1uJZAf9g6wQt1
 Fz8Kf3784CL0c00bWxpQOqB6hobkDRdlh1oO5dhNp/lW337MtNRNDab6zLMU6SWhUHB8Wh9
 a1deQUYDogcAI0NTosh+T3Ypj5Ur0p4XKqyP8dEnLOgOW2eQUlPfcQ0Wb1IXjid9YGPCSIL
 ZPBJsffVYUWirO8u5qi2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DWCZ1wctW1c=:oNkr4JNlzOwX5z26ubfZTl
 Sr/kvcB253KiWLq9PyqTr+4dVrBCx9ahmNBZYPgCKdSen60jUsWjt2QzY72HtJqL2zfrzvYmo
 YJFiU5b73jeSzcjCsMmDffZEj2LpAjGT1oAdyri+ucyWZS/FMZMsYrvXo9SfrtnAEtxnRN5RI
 UgLXzrs1my8m9tuD6um5TlfegWoffCFZ/IMMnc3kvO6vasY7WWFskcdk5AxeCVISx6HhmIarw
 T5pzLWZguurZZtSEZPCxQIRpCXfJL6bkrSQjhwdklL9LkVB0fHO7xJbEOrD+Zh0LiSf0vFtAT
 RkFixsr+I8qJYO6evOYGPntoxfWg65ZcPUi6/2VaP/LuQooeEMD01QYJGSagS7l9h0wOLrFge
 uBM8awSjuD15SoJFnDwHGT4xUI8N142g76MtikWtVubUV7rMkEq4Z/tuuCU3CDHEqMkwwgsmH
 yFN2a9HY7WV+6sh3uR6b3C7J806vnHDopNUoMNBJp7AvZh0APBpiEN6OlELw/Y2JyE097ZfwL
 lAQpzzxVMWAHVzly19u6QeFhZ5qeB39WFz3S/FVSo0W21B5Aa9/ZHOqKQfAohSAQ0cbsbBB3Q
 vhYuDWCPUAocZFeoMnpt7nQKtJN31eEUy2nUR8y8q0Z5mZIA7heLGzMOsoKqs3Lw/nWakXQ1P
 DNvLO/9llEgJMSa8lPqoXC7xL+s+A17jeiXIdPv39D+hIogIz02Ik3sCvBHERUNVteHHkNzae
 d2XPl+X1NaLpM4n71WT42NRtlG7KQQ8D7NGSwqq87tsZnFElkJKYbLMXsdyZwdn0Ri8TPIQEr
 ZEqL1IzEzkxZ74PA52t/5MHF5JUUmYgc0513BTD0VjuBtfQctJxdABY1a9uLDqlDhd7puK3dY
 Hp6uKidZBuhRFFFE6Qsob5Scru7hsl+LZuAfyIPmLy/3XjQlNEUOnIg9JR5PfMGMrAMKVCFYE
 SpkmSrUV/EA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 26 Nov 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Gummerer <t.gummerer@gmail.com> writes:
> >
> >> Thanks for your work on this!  I have read through the range-diff and
> >> the new patch of this last round, and this addresses all the comments
> >> I had on v10 (and some more :)).  I consider it
> >> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
> >
> > Thanks.
> >
> > One thing that bothers me is that this seems to have been rebased on
> > 'master', but as long as we are rebasing, the updated series must
> > also take into account of the sd/stash-wo-user-name topic, i.e. if
> > we are rebasing it, it should be rebased on top of the result of
> >
> > 	git checkout -B ps/rebase-in-c master
> > 	git merge --no-ff sd/stash-wo-user-name
> >
> > I think.
> 
> https://travis-ci.org/git/git/builds/459619672 would show that this
> C reimplementation now regresses from the scripted version due to
> lack of such rebasing (i.e. porting a correction from scripted one).

Oh, you know, at first I *mis-read* your mail to mean "don't you rebase
all the time!", but in this case (in contrast to earlier statements about
rebasing between iterations of patch series), you *do* want Paul to
rebase.

Let me see what I can come up with in my `git-stash` branch on
https://github.com/dscho/git

Ciao,
Dscho
