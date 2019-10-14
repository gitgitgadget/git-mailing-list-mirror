Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9011F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 22:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfJNWO7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 18:14:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:41987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfJNWO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 18:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571091288;
        bh=E4lRbj3omoLX2arWucmsQJ1IIAA0QlT1AMEpdWkpK88=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HPDa2cwAS5Bpw8kT4JmV8UEB6eD89WT4Cdh9TMFzDkIvqLD1DPoGIzAtatgOmi11o
         Zc8OstUxUxjKlYbzOzp2wmMKD5PUXVGaKRSui0qm+Lxml7+Lb+qOgX3jJIUtBHTSAk
         kFd2+iAUpedUd3Yp7wQSiG4xByeVaZq1FpLjjAB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1ie9Mv0tE9-00KCTK; Tue, 15
 Oct 2019 00:14:48 +0200
Date:   Tue, 15 Oct 2019 00:14:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood123@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] sequencer: use run_commit_hook()
In-Reply-To: <7a56faf1-a0e3-98ad-bdfe-e9ba0b97b5c2@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910150013010.46@tvgsbejvaqbjf.bet>
References: <pull.388.git.gitgitgadget@gmail.com> <420ecf442c729878da5219f3c718dd136e4fa2b4.1570732608.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910102314390.46@tvgsbejvaqbjf.bet> <xmqqk19bj4dk.fsf@gitster-ct.c.googlers.com>
 <7a56faf1-a0e3-98ad-bdfe-e9ba0b97b5c2@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aAgaiBvEaVkIDhooaQRz7n/HvI5qFK7pTNkFVitCuk5j6hyB+qe
 xbSWaiiYo7JfDDpYI//6uJWD2dv5l/R++IS32mBIWeUeNHFEjsTuBWaA2kqION6Tmviz8Xx
 +LaAjP8DU5GhFrVC7h5t+cSwoYL8/tBBdpsYFK+sZqTxYDD8aVf+9xtR7R4Z/kF8tt3H3ja
 Ysprq66AHbfaJ4gDHpZ/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BNhBWUFF26I=:UHUdbMFYKZS/+4pk3EBTXQ
 X+aClkG6wi3BGRvbReMaUyr2/mNsj0d5ii+Z/kZnVNNnJ85+Vx483kQfEvfcnyKWaTYxL7/UQ
 FI9MtXYwuYwkb1dIDixSr502NLaE2++wl7u2/Iiw7ZlTbzO83lb4YeJxXLAfSl3QY6J5+n2lM
 m2Ms9v8LFBBlTj3NEJ2rp37PvyqTxTYNdAWA2PtGVrMdHibomDirWfraOmudP18M1SOebCRNX
 cq0pMdaCld4LgQCPJDAMtlnUtt9MSxWgpzQguLmIO7s7OaMKRRpk8U38sjZUHgyt+9mkB7rcc
 ROQg2EQ8PZR5tG7NA50rT/+htE7VaBINQEYrA1SbRnPL4PD3899udQFRVys7ShcRWF0vi6Pwb
 LQ10EjJEF0wuP8yhRdeEhqB8P4LstKTzS9tI3sA+blTRzqK9CNTMooQp2aAmFO4iatrqpFeB/
 x+XP6/gzPr0snzieVfBStWoR2ZRkM08Fr8ZK6iuNbw9eguEk8uE5CbDq2+kykv68QYmiEKCN4
 TogaXHsdqtSeEULJuK91rhidRt0LZsuT8h4CWfut7B9hOYQE4JNCSLnogSZkqk5oBaOyO4k7w
 jtssZ47kFXM2NJrfwoBQUcqVFokSXQZBpQKnQ75E3LqGEcUOIhhl0un6iccxKrloi3efOs62l
 P+XHaCs1tqxOq6mjwnfBAoJzajFKIxih37bydxqzjbZbs/u3Ru7oN1IHE1K+Vn7bnLtyip6B7
 IyHbYxB3ioODcBmKKraTvazkQ9NB9lkj84cX8ZSIpEyRNvFNvG/ZTKtx2MKXd9KUph/o/caOB
 bmUTwFLXmvpQpDx8uUhRfdSBNF1XBt33qsyraQYcAeUIc+R29yig/dNETYc0czO3+OcShIZma
 06te8KdojXvWK5+5pxYk92xNNDajdJCqsfFBA5NuPqyCKyIS+8y3lob8Ks4WFWIjBbAiT0tpA
 XmAEYM7KZnKn03l5Z0WPErkSc/58O167FbaMosSS4Mh/m+N7eb1YEQsMW0s8doHi0Uq1CHUEq
 bwkQLWckmS5otLpszesVNnggq9KdKdKNrrChjnti+0NQ2z33GOo1NWYErSUulL/f1OetqPVCF
 aHfEurV4tYLkOBhHLE0ePLUlR0B20jTnQGCZYOJ3LPyhaQ8GVCbiaL9liaZCbJsUR+UlFc9cz
 JJp5cXjdcAdIy9RdTeyc1aitM01nmXFTpE25+KGzRADUSdLBnSiRPcpVucIbP6ETBhZM/szF1
 AscUzDEx+eKUvCXDKO/uXEr27N3VpzaAq9I2P7hxjoCo+CFT/kLLSbHiBqqo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 14 Oct 2019, Phillip Wood wrote:

> Hi Dscho & Junio
>
> On 11/10/2019 05:24, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>>  builtin/commit.c | 22 ----------------------
> >>>  commit.h         |  3 ---
> >>>  sequencer.c      | 45 ++++++++++++++++++++++++++++++++++-----------
> >>>  sequencer.h      |  2 ++
> >>>  4 files changed, 36 insertions(+), 36 deletions(-)
> >>
> >> Hmm. I would have thought that `commit.c` would be a more logical hom=
e
> >> for that function (and that the declaration could remain in `commit.h=
`)?
> >
> > Good correction.
>
> There are some other public commit related functions in sequencer.c -
> print_commit_summary(), commit_post_rewrite(), rest_is_empty(),
> cleanup_message(), message_is_empty(), template_untouched(),
> update_head_with_reflog() . Would you like to see them moved to commit.c
> (probably as a separate series)?

I don't think that it is necessary to move any of those functions out of
their existing habitat just yet. While I haven't looked more closely
which of these functions are specific to the sequencer and which are
more generic, I would argue that moving any of them is outside of the
goals of your patch series.

Thanks,
Dscho
