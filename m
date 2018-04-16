Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5A901F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbeDPPTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:19:49 -0400
Received: from mail.javad.com ([54.86.164.124]:40226 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751110AbeDPPTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:19:47 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A62F53FEB6;
        Mon, 16 Apr 2018 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891986;
        bh=E0Bz1MyQgnFLBeWrMuHD4d8tnXxPevsJQcmTPitrG14=; l=1425;
        h=Received:From:To:Subject;
        b=WStaJHdCWKjb7jHTKPR1GovdAXHrOTjaLG07i5H6SAXIEAL3jjj8FsXmDDVB1LMtd
         80PzMU6OyASFgN+k7nBJ53BF3dejUYJulZdOn+0F3YvPqRGgPkJTVWRHAhgPaK2mRO
         +KsQfuGSYUgY5YTQhCjys87IY2hg1sI5RGRQVMYs=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f85ux-0000iA-2y; Mon, 16 Apr 2018 18:19:43 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Draft of Git Rev News edition 38
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
        <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
        <87in8rz65t.fsf@javad.com>
        <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
        <87sh7v6vn4.fsf@javad.com>
        <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
Date:   Mon, 16 Apr 2018 18:19:43 +0300
In-Reply-To: <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 16 Apr 2018 20:37:16 +0530")
Message-ID: <87efjf6uwg.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi,
>
> On Monday 16 April 2018 08:33 PM, Sergey Organov wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>> Here "the above article" means the Jake's "branch -l: print useful
>>> info whilst rebasing a non-local branch" article above the current
>>> article.
>
> Just a little correction. I suppose Chris actually meant the "rebase -i:
> offer to recreate merge commits" article written by Jake and not the
> "branch -l: print useful info whilst rebasing a non-local branch" article.
>
> That said, I read the draft and found it good except for two minor issues,
>
> 1. I see the following sentence in the "Rebasing merges: a jorney to the
> ultimate solution (Road Clear) (written by Jacob Keller)" article
>
> 	"A few examples were tried, but it was proven that the original
> 	concept did not work, as dropped commits could end up being
> 	replaid into the merge commits, turning them into "evil"
> 	merges."
>
> I'm not sure if 'replaid' is proper English assuming the past tense of
> replay was intended there (which I think is 'replayed').

It could have meant, say, "reapplied", -- we need to ask the author.

While we are at it, please also consider to replace "original concept"
by "original algorithm", as it didn't work due to a mistake in the
algorithm as opposed to failure of the concept itself.

-- Sergey
