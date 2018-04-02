Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE91E1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 06:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeDBGHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 02:07:06 -0400
Received: from mail.javad.com ([54.86.164.124]:33846 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbeDBGHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 02:07:05 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 2CB333E898;
        Mon,  2 Apr 2018 06:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522649224;
        bh=s0VSbtkiWbQZvLiw3LhDmYVNdSC18bFW40wdHLyUgCc=; l=4013;
        h=Received:From:To:Subject;
        b=PJwdJ3sbwKe4DybLPMeC3MBwSzWDSQsgv0lIbTGfDAvcqyt1+sYeUTNOmo+N8nM5N
         NZ0zvHi/gBEulOtOzG5wLjseLx163T1YfJbgj54L7gBC4S6QIpSBPvqQT4FZVsO8Oq
         tmdDZMekXtCmWl694Vu8FlDb8WFs2O4cW8CDSY6Q=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f2scP-0006eZ-OM; Mon, 02 Apr 2018 09:07:01 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
        <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com>
        <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com>
        <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87h8plh2qd.fsf@javad.com>
        <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com>
        <nycvar.QRO.7.76.6.1803261351070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87muyugl60.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271456050.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Mon, 02 Apr 2018 09:07:01 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803271456050.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Mar 2018 15:35:38 +0200
        (DST)")
Message-ID: <87y3i6ta4a.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>

[...]

> In the parlance of your RFC v2, where you start with this history (which I
> translated into the left-to-right notation that is used in pretty much all
> of Git's own documentation about interactive rebases, which you apparently
> either did not read, or chose *not* to imitate, creating yet another
> unnecessary diversion):
>
>
> - B1
>      \
> - B2 - M

First, it should rather be:

- B1
    \
     M
    / 
- B2

as RFC presents essentially symmetric approach and I'd like it to be
explicit. Representation in RFC simply saves some vertical
space: 

  M
 / \
B1  B2

Another reason to use it is that I liked to somehow indicate that this
is about abstract DAG representation of Git history, not to be confused
with some actual practical Git history. So that, for example, the reader
can't be tempted to even try to assume that M has been necessarily
created by "git merge" operation in the first place.

That said, I'm sorry if it upsets you. I'll stick to your preferred
notation below.

>
> You now insert U1 and U2 with trees identical to M:
>
> - B1 - U1
>           \
> - B2 - U2 - M

 - B1 - U1 
          \
           UM
          / 
 - B2 - U2

_YES_. You've slightly screwed RFC as UM is not M anymore, having
different parents, but otherwise it's still right.

> So U1 is essentially B2 cherry-picked on top of B1, and U2 is essentially
> B1 cherry-picked on top of B2.

_NO_. No any cherry-picking has been involved, and I see absolutely no
reason to pretend there has, except to intentionally make otherwise
simple thing look tricky.

U1 tree is still M tree, and U2 tree is still M tree, and UM tree is
still M tree. That's what actually matters from RFC POV.

> These U1/U2 commits are now to be cherry-picked on top of the rebased B1'
> and B2'. I spare you more diagrams, you get the idea.

_YES_. Exactly 2 cherry-picks.

> Now, the changes in U1/U2 *are* the changes of the merge parents, that's
> how they were constructed.

Either _YES_, or _NO_, depending on the exact meaning of the term "the
changes of the merge parents" you've used, but I suspect it's _NO_,
taking into account your further inferences.

The U1/U2 are constructed by simply duplicating the tree of the original
merge commit M and thus they represent the changes _to_ the merge
parents B1/B2 introduced by M, and not the changes "_of_ the merge
parents" B1/B2, provided the latter meant to have some relation to the
changes introduced by the merge parents B1/B2 themselves.

>
> Since they repeat what B1 and B2 are about,

_NO_, they do not repeat what B1 and B2 are about at all. They rather
represent what M is about. In other words, whatever B1 and B2 are about,
the RFC method doesn't care.

And as this is fundamental misinterpretation of the RFC on your side, it
starts to be big _NO_ from now on...

> and since B1'/B2' means they are rebased, and since U1'/U2' are *also*
> rebased, but independently...
>
> 	...  you essentially have to rebase *every parent's changes
> 	twice*.

_NO_. U1' is rebase of U1 (on top of B1'), and U2' is rebase of U2 (on
top of B2'). Each of U1/U2 is rebased only once.

> The answer "No" to this is... astonishing.

It's still _NO_, sorry.

In fact, I could have said _NO_ the first time you started to assign
some arbitrary "meaning" to the commits, as RFC is about somewhat formal
proof of the method, using already well-known operations on the DAG, and
to criticize the RFC, you need to either find and show a _formal_
mistake somewhere in the proof logic, or to show a use-case where it
fails, as you did for RFC v1. Assigning arbitrary "meaning" to the DAG
nodes and operations on them won't do the trick, sorry.

I'd like to reach some agreement on formal correctness of the RFC first,
and then discuss the meanings, the implementations, and other
consequences based on well-established formal base.

-- Sergey
