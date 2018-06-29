Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6C11F516
	for <e@80x24.org>; Fri, 29 Jun 2018 11:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755298AbeF2LV2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 07:21:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:46057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755062AbeF2LVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 07:21:24 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK0bZ-1fY27L328b-001T8N; Fri, 29
 Jun 2018 13:21:14 +0200
Date:   Fri, 29 Jun 2018 13:20:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Tiago Botelho <tiagonbotelho@gmail.com>,
        git <git@vger.kernel.org>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list
 --bisect
In-Reply-To: <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet>
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com> <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com> <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com> <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
 <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com> <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet> <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
 <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zi2b+qqHSDn260j10x3KG3rQgeTMjAXabbjGXVfyKQvyQGnOvdM
 LnDL7C0wmwmhYGOmugrNnQLX2ESOxxbSWR/EtmyjdPkwvMob+JRCctuwfRM9ZbEX13Pc9ZH
 9gm6idi9+s+QKmJKoHMPGXl6otD28ur9DDZKyog0xDpipvSzvj2Tlz/2yEMbXIUtA8wB5UC
 DXI67ZRE7hAHO+/3e1bFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S1AWbueLxMo=:k8+WKwwaZpGfbjQHKZGJlG
 lfEiJo3sqwCjcn53R+gr42FhY6ozhIVF9vsyXgeEIZzzALx2Lsyym3ckE4n96XimAJlw1yp7M
 h49ptReZpuNw/hHev1mScbANHi0+Dy5GRy6rhnthgcG6ZbO0rPX3f4BQ0bUeZ7TFSzCG+qlCZ
 Fqtgxb8UkueLfOp8bbXDceBQU5T4P2TMoEva9yxOGKcXEOozIOoFp6OXYNViGqxuT5PrMBUFO
 NkMFBE6qb4VY0Bn+4+Y7kypPcjks+GuPFQT7IZM8CycZECPsK5lnVs+nFczNKlN3qfXFNqWyg
 31M3ydIUGrduk3ZPK0XjPieyjt4A1ZAdCbHQa6nSP4AORDRCRClMIkHCE2SI3hETfJzQnOe8V
 gf7toMM9SiR4gxyWTw5muhgEA0DNBiBBfMZObyHYA+/Zqr6mmZqe1nsK5XBK9pU77ms1Ba2h6
 nfjc+KXd1PPB2xtgtVMCMgld+cNCO7dywXAQVwsPHfQ8lQXa3YuH6jLUy8koBxfsc/DDcr9Qi
 u2cOTInjYUTyW9Agc3YGGErXBmZgI/Gk4iAx62pR4thnNryTotgDrM7MY6aBcZiOHTFAnDhEj
 ukTI597GyQDhw95CGCiBTby2d/bfTDF2f1VdRkC0Lh2jVFVhAy7OTm3cbDxQzJ3BYL3izsMD7
 8QYtVrGFvw9bbJfr/3irhMwIdnnBAUfhigX1XmmijHJL3AlT0EF/CdswFkvw9WTQHOMzebtup
 73yUmflSEKV/8NGS5lxFdBk60sZnf+AmlYqgSxrGg1JXjhPF1tnpMzj8sLPB/45mfeYn57nL7
 DENNdBU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> What I meant by "many separte grep calls" was to contrast these two
> approaches:
> 
>  * Have one typical output spelled out as "expect", take an output
>    from an actual run into "actual", make them comparable and then
>    do a compare (which does not use grep; it uses sort in the
>    "making comparable" phase)
> 
>  * Not have any typical output, take an output from an actual run,
>    and have _code_ that inspects the output encode the rule over the
>    output (e.g. "these must exist" is inspected with many grep
>    invocations)
> 
> Two things the "output must have 9 entries, and these 9 must be
> mentioned" we see at the beginning of this message does not verify
> are (1) exact dist value given to each of these entries and (2) the
> order in which these entries appear in the output.  The latter is
> something we document, and the test should cover.  The former does
> not have to be cast in stone (i.e. I do not think it does not make a
> difference to label the edge commits with dist=1 or dist=0 as long
> as everything is consistent), but if there is no strong reason to
> keep it possible for us to later change how the numbers are assigned,
> I am OK if the test cast it in stone.
> 
> Another reason (other than "many separate invocation of grep") to
> favor the former approach (i.e. use real-looking expected output,
> munge it and the real output into comparable forms and then compare)
> is that it is easier to see what aspect of the output we care (and
> we do not care) about.
> 
> It is harder to see the omission of exact dist value and ordering of
> entries in the outpu in the latter approach, and more importantly,
> know if the omission was deliberate (e.g. it was merely an example)
> or a mere mistake.
> 
> With "using a real-looking expected output, make it and the actual
> output comparable and then compare" approach, the aspects in the
> output we choose not to care about will show in the "make them
> comparable" munging.  If we do not care the exact dist values, there
> would be something like s/dist=[0-9]*/dist=X/ to mask the exact
> value before making the two comparable to see that the expect and
> the actual files have the same entries.  If we still do care about
> the entries are ordered by the dist values, there would be something
> that sorts the entries with the actual dist values before doing that
> masking to ensure if the order is correct.

The problem here is of course that you *cannot* set the exact output
in stone, because of sorting instabilities.

So you have to play tricks to sort (twice, with different keys) the
expected output and the actual output, to verify that all the expected
commits are listed (and only those) and to verify that they are ordered by
the distance, in descending order.

And this trick, while it still makes the test correct and stable and yadda
yadda, *also* makes this trick a lot less readable than my version. And
therefore makes it more difficult to verify that your test actually does
what it is supposed to do.

Ciao,
Dscho
