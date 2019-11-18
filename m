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
	by dcvr.yhbt.net (Postfix) with ESMTP id 031DE1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 19:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKRTXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 14:23:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:33225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfKRTXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 14:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574104989;
        bh=kc7NV1SVPZgN8sODD3XJnY6CCSWev27P1gINFfh8acU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fbgJ/Y7VimTxCC2yHmYkko5YGxilBKbl0o13B2moCjt0jGW19CHgdt8JGIO08tWG0
         uDn0fFith1WdKmHxB/rSz2m3CUxgE50H4GZntXZX70SQgUolQhNcb3CqrFoFzrkwXt
         5a1zjUir/jEuSHCg8Kng6tJJtiswLYBb2IysmJmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1iMmkD0NLA-00Y78D; Mon, 18
 Nov 2019 20:23:09 +0100
Date:   Mon, 18 Nov 2019 20:22:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main
 loop
In-Reply-To: <xmqqpnhp3oum.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911181958190.46@tvgsbejvaqbjf.bet>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com> <xmqqwoby2ais.fsf@gitster-ct.c.googlers.com> <xmqqpnhp3oum.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l+MdUYryVc2dm+r0yvEuFZfaBGzgFQCz9lgPi0vLnOAMq6eripx
 xADTU8ojvoOvCO934NeR9zqmXaggRK99rfIkYi1NjTChAW5mhHmMUI3vPxlWzuKsHrY6Pda
 ltKEsPRP+ZSdWDT0h5W/3dIX9QUu8VDnOL7DMsjTkbr+fIdjTPzaAn0GC9UTjBFKiHhma/0
 FoEMpVoZOWP7CERNwuxmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2RyjuG83nFA=:fNbE7xDXkZ93oigqpnzPZC
 eFMXVvgyT/guKXjmKPlKXQeqQW5JjLA6iJanesdQP7BcPSLdgIypFmugO+LMpOlWFG+kdtnmM
 /hbI5MzJs7QBS3Uuxtdb717/5n2/UFJxw4/K/vXMZPCAfQN5py7XbjapNJ/3PRq4qC9d17Qu0
 yqiG9NeCOViarLO4eKWN92mXX9rQt5TesiM/yItT4QSSJmFJkzzW/UaMwBDJa8TNnD7/DXE6J
 MGK8qpk2nbtJ8kArKE9pT09kvoLXIv6FZw3266ULkKecBdYp73us8ttQRijqZ+uTJFxgU+dAX
 YQg1DUjzMFEOHafZ50TdvVqPT/qfrXHprOW1KFiogXHmCo8porYJ0QUM0/9ohgKjqdRSxfEd6
 6D7vOaWXJr1JWwPnQQn8sid6SDrwvkAG+JMpJSQcFkOqGQ0Y2ajm48ubT6uZRCJCALSPY9ctD
 LQGFSXpm/S2Hhc2zhU4qyOb/GtIUB1JSBfpX0tHBS8RRgwg/ROPIokIwSBQ+FtqpN5MYutn15
 3u3azcJ/arRQAm9dPe5GgG1StgGazwvTGEO8Yce8oFoq9CkcbhLYsx4+MQpLllB/F446q12wJ
 zNV1p50mNhER/Psm2IzEuS1+Dtc8ioz1WZKiiEzyIiHqFRr3SuA+28qYc3RZTFMb0z8sB19/P
 o0cMwCIkMUZPkPqsadaSlm97ObmrHfW2d0pBt/5DTectIbUoIJdDa7J1TE8L5dmfFqtSO7S1G
 9yMhwOFa8j7O136A1nsMcyLUDY+9qzz6O84Oz+w+V4PDHEQnBiiap+GsLOmo2uSiEzeB1Ycj6
 R/BcMQNlqWAOMzXfd1iw4v0NfmqifBGoSEKF3IAGxXVRAMiVsCCLM2wMqZdrPmlct2fvjXEj6
 zRxwTd8ksLfxQEWxkjKoK7Htwqv2fg6wgsICjKBm0kdDPCb97qLPovouYeIraJwZwxg/8ivTv
 QC9WhfURwZJksilwJHRWCMzOP/ijvuBlLONQAgrFy81DmC71Sm3IWPxpClbZqyboJbP80zJqa
 xBZS1ykHK19Cs31CUJL2a1rmv03I16zZQQxuZgb/bc7HtRX5UVfDjEQS/82cccJ8IeipCrNRH
 Aidk/RRcyukAsRtZBWYvgTB24M+50Q352yx07jin2Wgi5NwbSSRaXKGty+zEfloPpaF6HqI3Z
 Vr0OgzqlDAuifIeG9VpErDYQOvraSjXEx8FctGhLphj4d8p8xi9V5Ycdbw82g7o2CtNAXT49k
 LJsDEe8fQ0kp+NKgdY7kxVwjR3hVicIvDbOehf5FLYKoVOXksObc/il6au9A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 18 Nov 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> >> Based on the js/builtin-add-i branch, this patch series implements th=
e rest
> >> of the commands in git add -i's main loop: update, revert, add_untrac=
ked,
> >> patch, diff, and quit. Apart from quit, these commands are all very s=
imilar
> >> in that they first build a list of files, display it, let the user ch=
oose
> >> which ones to act on, and then perform the action.
> >
> > So, this obviously depends on the previous "let's start the main
> > loop" series, in which I recall you found at least one remaining bug
> > after sending the latest round.
> >
> > I'd prefer to queue this on top of the iteration of that series,
> > which would hopefully become the final one, which would let me avoid
> > one rebase of this series ;-)
> >
> > Thanks.
>
> I found the v7 on the list, which is what I wanted to queue this on
> top of.  So my wait is over ;-)

Yes, sorry, I did not think that I was opaque but I was.

So to clarify: I will always rebase the built-in add -i/-p patch series
on top of what you put on gitster/git. That is, this here patch series
will always be rebased on top of js/builtin-add-i, the next patch series
will always be rebased on top of js/builtin-add-i-cmds, etc

Ciao,
Dscho
