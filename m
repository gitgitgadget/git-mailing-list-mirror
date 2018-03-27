Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072061F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeC0FcP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:32:15 -0400
Received: from mail.javad.com ([54.86.164.124]:58584 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbeC0FcM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:32:12 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 1790A3EA25;
        Tue, 27 Mar 2018 05:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128731;
        bh=ltb67j70w9WLcUeMYPEmtd10cOZakZeZxgU5vB0o9Y8=; l=2361;
        h=Received:From:To:Subject;
        b=VYIFXnn0Uqs+xU3DFnAKomrXw6yym+cokLfI/hoTAUj29HN6tGEiWXfqSBwCeYty+
         egoFLTddi7mICwIF2QaDyCHD8JTqXU4ANpql2d3kb5gaPzvkdzjirAddsoPfD2/C88
         I2hlpMMWTpuV6Gv38Fgl/keCJJp8ZQdQHHLPSVJo=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f0hDN-0000CI-Da; Tue, 27 Mar 2018 08:32:09 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
        <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
        <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
        <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
        <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
        <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874lllh09b.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:32:09 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 26 Mar 2018 14:44:40 +0200
        (DST)")
Message-ID: <87bmfagk2u.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Mon, 12 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > [...]
>> >
>> > Where "easy" meant that I had to spend 1h still to figure out why
>> > using the unrebased merge parents as merge bases.
>> 
>> That's because you try to figure out something that is not there in the
>> [RFC v2]. I suggest to forget everything you've already imagined and
>> just read the [RFC v2] proposal afresh. It should take about 10 minutes
>> or less to get it. Really.
>> 
>> > The same amount of time did not allow me to wrap my head around
>> > Sergey's verbose explanations.
>> 
>> Honestly, I don't believe it, sorry, but I'm willing to explain anything
>> you wish to be explained in _[RFC v2]_.
>
> No, really. If you cannot bring yourself to believe my words, then I hate
> to break it to you: I am not lying.
>
> As to "I'm willing to explain anything you wish to be explained in RFC
> v2": I was asking, and asking, and asking again, for a simple summary of
> the idea behind your proposal. Nothing. That was the answer.

No. The answer rather was this simple explanation that I gave you
multiple times already "rebase each side of the merge, then merge the
results back using original merge commit as the merge base". Yet you say
there was none. I'm confused.

Well, as it seems you grok Phillip's notation just fine, here is RFC
algorithm in this notation [1]:

git checkout --detach A'
git merge-recursive A -- A' M
tree_U1'=$(git write-tree)
git checkout --detach B'
git merge-recursive B -- B' M
tree_U2'=$(git write-tree)
git merge-recursive M -- $tree_U1' $tree_U2'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')

> I had to figure it out myself: the idea is to *create* fake commits,
> non-merge ones, for every single merge commit parent. Those fake commits
> combine the changes of *all* merge commit parents *but one*. And then
> those commits are rebased, individually, with tons of opportunities for
> merge conflicts. Repeated ones. And then that result is merged.

Wrong. See above.

Anyway, it doesn't matter anymore, see [1].

References:

[1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com

-- Sergey
