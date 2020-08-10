Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE62C433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442A022B4E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Mx49pObH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgHJOqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:46:55 -0400
Received: from mout.gmx.net ([212.227.17.22]:50995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgHJOqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 10:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597070810;
        bh=ueTHsXLibL1hVqtSG4iB8H3GD6OlJU+j9GkLPblUeug=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Mx49pObH/ms+dGBLv2CQ59jh7cBdshHsH7JCI8H8BRv3SySwbJxSEpxqXpJqc+XHO
         GF8CfFowz4sX9htNO/GTLf1lrFaAluci+7sPTZNC4JXNK6aYhBUl4A+EoQ7/IfLxx1
         yhw0n/vF2PbPysqje7vxdExc0J6oEVdFhqjFfblo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([213.196.212.215]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1k7tA02k1a-002qb9; Mon, 10
 Aug 2020 16:46:50 +0200
Date:   Mon, 10 Aug 2020 16:46:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Joel Marshall <joelmdev@gmail.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Possible issue with rebase's --rebase-merges option
In-Reply-To: <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet>
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com> <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com> <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com> <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com>
 <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yNJ0WowO6TrbbDqo/25ItLBW1i7LQyWv6sM70Q9umC805xl8MQA
 uyXQK46gSn3i/Hdrf1DeIR3sLslrdV8QMrPlNHly97qzlY7IoFk08omfXfAJdkQ3AxKDkyM
 GCTc7B1BZMSbWRhHDcSGG+E98F6NUXmCqexqWPzFale2zI0hMdPslaq2Kdi91Uto6F9/x5l
 rjCMnBG284LZjTqaWfk8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EaEdPbt2TZw=:1Qb0OUsJ22RcQO04yf87jb
 vc93KnoRbHxGpf73evBnRUF7RjJMZPypc8ZI9Rd0bfmBKQBXaCr1Rcs+sNYT4geXGg1FwuITC
 fPYaJqojDEvOevd1T/UjOWFpZ4GJqLIfnrtDpOO5i3Pg0Pw1jiBoKRy1Bv0yCNgN/qYpigJP1
 fKU9VIhL8AhvqW07/hqWHBEopZ21iO/x4b2DMMgEar6MwXopVAP9YHklzJH7kUV9ElAbSB7Wa
 nhSLanVAvhSSsYnqz1xyImm7NMhTyXtY+SRRlHzUaoeeLBjS++94UPmicKaE33fLm27axOcpo
 9xgiWhWTeI82aQSnaibl3mP5sdy17cbdktm36Qy43i7+pTZqsV51IrcDE8vzK8ZKH67Ruyr0Q
 vVoi4nqZRO0Rx4bCI3z6QFXBkAtA+D/Vc3BE/Bg7CRx7Nb1uNHE1dkGHVZ+9oycpZr4zZAkyS
 7S/ME5KAlACvXrAA5N1cCFbm+o6tW7aUqSHRnAjwwJVkpZF2jhJFK2zHOl8OloZ0VG32/2Wu8
 ROb6TIPSuHgMIk0uXEZztq6kRvTOTQYChWBk4qcOTeEfZ1CiLhLBsE0pQcnBEcH07JHSlhYPP
 PhmCP4GlTU1HjBWgphtSclAwSOAx7RLp5FkNiwszpvUMS6XEhD173EpuCcHFsPjjBbh0q/4ak
 Jq6rYzOdYA1NAQtoFj9iYbAYy0wJbsFj6V1fGmvz2YDWHnVjfHqeOlAZnGjeomkCjiiNtnb0N
 4JPMqSEicH4l0KvGXQo6yq4gXfx8To8DSbWd/AjW/gLcmqeK1n+/1J2DRtpWGkv7+aWE7M8jv
 7PvVSip0dntmz/2GR7zayd3iGdyXr1lIfustkU8tYGZff2JvuHsLOfuUwZqnHoJ39wsuSY3xN
 oIvqIvaW5XcnIeEF3CIr5KtxO8AGdF/qwpWBAz+jUKh+sN5t7qRI2N8ty9NX/1TGAYwFXWQnK
 TFJiMebrbV9eOMW+K5dlY7FnEIwaOkz7NZ22OHLdt9WfRT8GucR3mRrXjtjHVBCekNII02YU8
 h0CkwHZgsWi2jHtePLiUG3TBPNwrqIy/ftb0gPPshANWK/tvt0JdAcjG589DdEI9ArVG+e9p/
 aDmwWYPM8JIpblm0+nd6CdI098Y0aVf8lMyf2hFzqMIdlooq6Wp9u4tF5AFXoDDWN2G9uYEjo
 gszzxN+5z5VXO+HA1KCNgSOUWsgdCgaQ7d6qkWIUv0+1DfsWt0Bju1sMTjtDBv85mavD5Vo/Q
 DWuOw63l8i/+y5PtMh3uUkjW+4Cjo7/FqBajpCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel,

On Thu, 23 Jul 2020, Joel Marshall wrote:

> I saved the state of the repo in a copy so I could come back to it if
> additional examples were needed but I had to clean up my live copy so
> I could get back to work. I'll get you some additional screenshots in
> the next few days. In the meantime, I'll try to give you some context
> around what I'm doing here. The parent branch is my main dev branch
> which consists of a series of clean branches and merges- the dev
> branch basically looks like what you're seeing in the
> --preserve-merges screenshot. I've also got a long running feature
> branch that branches off of dev, and it also consists of many branches
> and merges, each a subtask of the story related to the feature branch
> as a whole. Occasionally to get the feature branch up to date with the
> newest features I'll rebase the whole thing on top of dev, which
> should result in an unbroken chain of branches and merges as seen in
> the --preserve-merges screenshot. While you can't see it in the
> --rebase-merges screenshot, those merges show no ancestors when viewed
> in reverse chronological order- they just trail off into oblivion.

I could imagine that you might want to try this rebase with
`--rebase-merges=rebase-cousins`.

Otherwise, you might want to export your use case with `git fast-export
--anonymize` so that others (such as myself) have a chance of helping you.

Ciao,
Johannes
