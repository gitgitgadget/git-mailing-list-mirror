Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD6FC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF6164DDF
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 13:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCSNz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:55:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:55781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCSNy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616162092;
        bh=0MKjRTbvIKqCwSC64qHF4SQL7pyddmrJLj/2JJubalA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T1HVqSETdK2nwHDh075fZabl9YId1lW6034wtYxvte99TO7F/NpJEDGyng9BeyN+A
         ZMwzzwFR5ZIzgSJWs5eP3Llsv03Pd5FClaKLnbmgfyKIXasBjCGuOlZH4EhambxQXh
         GSyOT+aHYQ65JHfi0qnUIPi7j3W8Cl/k7kGzLpDg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1lnXvo18qm-00zqpN; Fri, 19
 Mar 2021 14:54:52 +0100
Date:   Fri, 19 Mar 2021 14:54:47 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: GitGitGadget and `next`, was Re: [PATCH v5 3/3] ls-files.c: add
 --deduplicate option
In-Reply-To: <xmqq8s8kalz3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2103191451460.57@tvgsbejvaqbjf.bet>
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com> <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com> <xmqq7do7fggn.fsf@gitster.c.googlers.com>
 <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com> <xmqq1reec943.fsf@gitster.c.googlers.com> <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com> <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
 <xmqq8s8kalz3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5uR4O/Wr8RrrQJlWfyOjfZ5rTpO3iOW9FsJtecD+XMgJ2cfAe+v
 jqlzOLLm9aUBzgKXNzLJZTkT7GcpYiAweJvdWtpJRKdb0ByQt+vGh52+0lzJ4gFcpil90Jy
 mOwxOS3SRPGcgwgo50+1BwqSnL1m6dQx9FewS0s9dQjZGLkWB6Q6xgbjYpqQJej230QMH5U
 7WOChBsKOWpGFAxwChknQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6nps7KLSoFE=:RSMlXpWd6n9ZcsWtS4Z/oA
 fJ2jtcTIYcqKKaBVxoSoeKQ+Nuqi4HXSGyiXrSr6olETzoQmWiSv/4g3b3YNJiia5HifuecLG
 rOxiA87Rfn5N4YT4cLj0O2SVYSujNYnYgjV8oeK+wFv7I+czCBQSZrK+TmrkgAnjMrRMimQd1
 4gAtXKDgWRdpg9vncybnjAqom4fLCE+O/wAleeqiEI7CmnVtKSKWvDXVkepMOcZV1rkYUgpmq
 9q9S+hdCBDuASa2ikra5hVWEVsBERIpneCLupH7VDq2FbimdzSPwUjp846Z4SVUC4EkUBaabo
 aSX6PKMc1l/RNW6mG949t0xYE3mdXGYcKXvtHM7Y2wmxxKzQAVt4YMnkrDRcAfwG6879g9ivx
 LWKXgbTBQs8Dk3NDGACmCfjBanUbKcs4MoJ1WpMndSGgESEui/zkRBdnwNYi0BAKldPJfkaVr
 WfMTMKoP8yXnEweO0A+PZfNapfbE+1s1ZeX91ZtCjDJYw0UdyA5T/NZX1qzdlOqL1CyHHiSO+
 6WJhGi+snEsVlwFsTCXLfVPlB2zNpruPL/TaQSCIp8slLAbmEJxy2QA4JWKFuB8DqREJHk9mS
 /DSE+9sQBqf995ocMVzGcaIHjrdU8dyxt/NUbv/2MLzQKWDOyTqSpNJoMrkj7UYNDbHi3hzSI
 qTRUAxkdM430drCLMpnywuNKVfFf11G4DOJVNzLufHzbXQfA7OSAQpMZQQYE+qXZiff2jKGaO
 um6H3XaZ5QmY26C07CJoq+ecnFbooHszclfuFIRqjb8XOBsSDwTexlGmdV+WJcLOrQTjoZZrA
 P66z7n7kPxs1+4mhOPBU+aL6/J7jE8S2wY64+VunviTkMNTyfC2M9RTGmmWZE0pif3wYioxXd
 tQzJ558Wy/uuJ3POh0KruqjNJysIhqoZYZ7Ts8Buk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I just noticed that this still waited in my inbox for me to answer it.

On Fri, 22 Jan 2021, Junio C Hamano wrote:

> Just being curious, but when a series hits 'next', would the way in
> which the user interacts with GGG change?

My hunch is that we should probably tell new users (for who GitGitGadget
now uses the "new user" PR label) about the expectations of only adding
patches on top (i.e. in a new PR), unless the branch gets kicked out of
`next`.

> With or without GGG, what is done on the local side is not all that
> different---you build new commits on top without disturbing the commits
> that are in 'next'. Then what?  Push it again (this time there is no
> need to force) and submit the additional ones via `/submit`?

GitGitGadget would send the entire patch series, which is probably not a
good idea.

Ciao,
Dscho
