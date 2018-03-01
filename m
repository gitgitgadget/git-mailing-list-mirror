Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210941F404
	for <e@80x24.org>; Thu,  1 Mar 2018 05:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966062AbeCAFji (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 00:39:38 -0500
Received: from mail.javad.com ([54.86.164.124]:38259 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966023AbeCAFjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 00:39:37 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D9F863E898;
        Thu,  1 Mar 2018 05:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882777;
        bh=hEd2FUOnwlta/N23ERAyun/zBk2sKvEZHBC1yptnKRY=; l=2191;
        h=Received:From:To:Subject;
        b=a5lUOfA6mIZoZgqZBAcUEcmvhXP4CCjycQUIUTYLtVPuLg8jrxHDrFzvchKfN+npc
         ofHuUHZMNvM0X7M9DIq48e78ySHo/0GEvVhg40zWd1Mh0oE8/WjYKzrn81tp0gwlBt
         BuEszBUncLca6SBKqqP10OpwgB88upzCHuIbztXY=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1erGwI-0007QN-Qd; Thu, 01 Mar 2018 08:39:34 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
Date:   Thu, 01 Mar 2018 08:39:34 +0300
In-Reply-To: <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 21:25:07 +0100")
Message-ID: <87a7vss6ax.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Sergey,
>
> On 28/02/2018 06:19, Sergey Organov wrote:
>> 
>> > > (3) ---X1---o---o---o---o---o---X2
>> > >        |\                       |\
>> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>> > >        |             \          |
>> > >        |              M         |
>> > >        |             /          |
>> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>> > >
>> >
>> > Meh, I hope I`m rushing it now, but for example, if we had decided to 
>> > drop commit A2 during an interactive rebase (so losing A2' from 
>> > diagram above), wouldn`t U2' still introduce those changes back, once 
>> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>> 
>> I think the method will handle this nicely.
>
> That`s what I thought as well. And then I made a test. And then the 
> test broke... Now, might be the test was flawed in the first place, 
> but thinking about it a bit more, it does seem to make sense not to 
> handle this case nicely :/

Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
this more carefully in the first place.

[...]

> So while your original proposal currently seems like it could be 
> working nicely for non-interactive rebase (and might be some simpler 
> interactive ones), now hitting/acknowledging its first real use 
> limit, my additional quick attempt[1] just tries to aid pretty 
> interesting case of complicated interactive rebase, too, where we 
> might be able to do better as well, still using you original proposal 
> as a base idea :)

Yes, thank you for pushing me back to reality! :-) The work and thoughts
you are putting into solving the puzzle are greatly appreciated!

Thinking about it overnight, I now suspect that original proposal had a
mistake in the final merge step. I think that what you did is a way to
fix it, and I want to try to figure what exactly was wrong in the
original proposal and to find simpler way of doing it right.

The likely solution is to use original UM as a merge-base for final
3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
though, as that's exactly UM from which both U1' and U2' have diverged
due to rebasing and other history editing.

-- Sergey
