Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C531D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 10:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeGJKrf (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 06:47:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:40889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeGJKre (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 06:47:34 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOCSm-1fg9ZM30Tc-005YGZ; Tue, 10
 Jul 2018 12:47:28 +0200
Date:   Tue, 10 Jul 2018 12:47:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: refs/notes/amlog woes, was Re: [PATCH v3 01/20] linear-assignment:
 a function to solve least-cost assignment problems
In-Reply-To: <xmqq601oaw00.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807101241010.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
 <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet> <xmqq601oaw00.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vKJxmhfw+FbzqjoYvxxS8sfSeJyVVUEMs7hCLydM5J61vuraHAI
 e9qnrazXI6IvV90XFQbv5XgBDwK8kfC+kXpP2PGUMaqEMziDlglyRmKAEd8tB6avvZoLkXJ
 jLBikOj9IZ0RziN1aGzviH2SSb3JUvFYRZ5PD/COM38ni8Byd5qkKsvJtBgLnteqND0f7af
 9Qk5CABrzeUUIlnJMdL3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xPFGGTW71Jo=:gN+pz4V8jXLgZ3a4R5oE9y
 amN1ruyDB0EtPkud0sQjHpIPR5SW+X4gghdfvVFaXgQcVRQuQIBYMsBXNndQKWsLKOnjkMb2p
 KNPMwukabDMzaDsxUe9v2syY/LEoEH5ranvs/4gSTDS5Pkt0TfjY0CSFCCcoAAqiq6SJ5ySv5
 7QbrT5mKUoNzk96KOegyvkuBBlMbtjq76cCYxb5neEj7m7KR+rMPawvJHoMu896a2FcHUMdTK
 TE1151jUJVBFd9gbVHKDnksPajl5yTYh94ecrOA4BtLlAxTmgMZpO1nXRXbEFkzTi8Su4tF28
 4UHc0A9mJ4dr+4k5NHRUVQKkyzZuu8UX6lAEur48tAB+/lI8ETwgSjJ/CwviknveQ+IUTiin1
 6DtLhQlaGUAD7rUlRfJX4NN3pQA0LeYTVuC0dtVuMHQJnROgd+FjsNpbJoO+zbG8613fXLHV6
 B4jW14mzdcO8dSR6fO1P+n9ARJHo/wdslt2KpeOkP9MqD4tisywVy4MXb8bELo22ueA4qOQFS
 Ib5J4SVbjOkBGX7BMdoeDfwAWeIq6105nmbKu1jWgT7KZXKbX6sFTXZmz6TuHmf7XefcWW6ea
 JL2RFfH3YrIwMoc4965WQuyTru3Dk6EffnhKmmwVu96Vp8Fc/gdJ+RT7jtInJlFrI/z+05Jl0
 oh+3ak836TpdrwkNOdxFivUhiS5yixMaLvU8Xki0q6WbAlQDMTtFgZj2BVndLtsRXjZxnCo1U
 EVB7FvvEIl5RmoxBJFG3DRNu75wk241xsh601184lFZRyDL7xkweTUI3+JmX6BHjfu8QX95gR
 i5fRdvf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Jul 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Speaking of GitGitGadget: I just encoutered a problem with your
> > `refs/notes/amlog` and I hope you can help me with that.
> > ...
> > When I ask `git notes --ref=refs/notes/gitster-amlog show
> > 4cec3986f017d84c8d6a2c4233d2eba4a3ffa60d` (the SHA-1 is the one
> > corresponding to `Message-Id: <...>` for that mail), it insists on
> > outputting
> >
> > 	5902152ab02291af4454f24a8ccaf2adddefc306
> 
> It is not uncommon for me to have to do "am" the same patch twice
> when attempting to find the right branch/commit to base a change on,

But then the `post-applypatch` hook just kicks in twice, leaving the
correct mapping in place, no?

> so the reverse direction that abuses the notes mechanism to map
> message id to resulting commits would be unreliable, especially
> given that they may need to further go through "rebase -i" or manual
> "cherry-pick <range>" depending on the situation.

We already have a mechanism in place that rewrites notes in `rebase -i`'s
case. Not so sure about `cherry-pick`, but if it is missing, then that is
definitely something we will want to address.

In other words, let's not let shortcomings of our own software dictate
what we record and what we don't record.

This is highly important information that we willfully lose by using the
patch contribution process we are going with. And we *can* at least record
that information.

> I am kind of surprised that the message-to-commit mapping still
> records any data that is remotely useful (these days, I only use it
> to run "show --notes=amlog" for commit-to-message mapping).

Please do understand that this information is the only remotely sane way
to work around the limitations of the mailing list-based approach we use
here.

It costs me a ton of time to figure out these mappings manually, and I
think that others simply are not as tenacious as I am and simply drop the
ball, which is not good for the project.

> I do not think I have anything special when amending the commit, but
> amlog notes should be updated in both diretions for its entries to stay
> correct across amending, I would think.

Indeed. See my other mail about the `post-rewrite` hook I suggest you to
install (I did not test this code, of course, but you will probably be
able to validate/fix it without much trouble).

Ciao,
Dscho
