Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612FB1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 15:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbeCGPQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 10:16:48 -0500
Received: from mail.javad.com ([54.86.164.124]:43440 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932448AbeCGPQq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 10:16:46 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6FC6F3E8AB;
        Wed,  7 Mar 2018 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520435805;
        bh=JJD9nVoJPb3nZJMXIoJD4LegV4+AT4l4VWb4ZPi7ZsU=; l=4429;
        h=Received:From:To:Subject;
        b=h4Ci3t4Kzptpb9cbWpzE9SGtDusGPtwXfmijIQyD6elQee/wDtRGclfbjr+EJmGpM
         iPMWb852y9Z9p+jcOYqqyQ9aQTILif2rD47BHasaD3z4FHsGAx+t+SFe8dYn4oXPAe
         Yq3kj4kbNGhNh6yNkj24eb/k5zb2Rem/9Miy/Nhg=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1etao7-0001LG-Bw; Wed, 07 Mar 2018 18:16:43 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 07 Mar 2018 18:16:43 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 7 Mar 2018 15:08:41 +0100
        (STD)")
Message-ID: <87vae7ykys.fsf@javad.com>
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
> On Wed, 7 Mar 2018, Sergey Organov wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Tue, 6 Mar 2018, Sergey Organov wrote:
>> >
>> >> This is v2 of my "Rebasing merges" proposal.
>> >
>> > Didn't we settle on Phillip's "perform successive three-way merges
>> > between the original merge commit and the new tips with the old tips
>> > as base" strategy?
>> 
>> It seems you did, dunno exactly why.
>
> That is not true. You make it sound like I was the only one who liked
> this, and not Phillip and Buga, too.
>
> Are you interested in the best solution, or in your solution :-)

I'm interested in any that works, and only you say that those suggested
by Phillip is somehow superior. I still believe it's mine that superior,
even if slightly.

>
>> The main problem with this decision is that we still don't see how and
>> when to stop for user amendment using this method. OTOH, the original
>> has this issue carefully discussed.
>
> Why would we want to stop, unless there are merge conflicts?

There is somewhat lengthy discussion about it that you probably missed.
Not to repeat it, just see how 'rerere' works when it fires during
rebase, even with no conflicts.

>
>> > It has the following advantages:
>> >
>> > - it is *very simple* to describe
>> 
>> The original is as simple if not simpler:
>> 
>> "rebase sides of the merge commit and then three-way merge them back
>> using original merge commit as base"
>
> And that is also wrong, as I had proved already! Only Buga's addition made
> it robust against dropping/modifying commits, and that addition also makes
> it more complicated.

No. Get your facts straight. The [RFC v2] already fixed that original
mistake. Could you please finally read it?

> And it still has no satisfactory simple explanation why it works.

It has. It's there in the [RFC v2]. You seem to be the only one who
doesn't get it. I suppose you just didn't bother to read.

>> No problems with octopuses, and no virtual merge bases of recursive
>> merges to reason about.
>
> But those are no problems for Phillip's strategy, either!

I thought it was you who started to discuss virtual merge bases and
related problems, as well as how it's difficult to support octopus
merges, but it's fine with me if there are none of these problems.

>
> So your point is...?

Still the same -- use what's better, the [RFC v2].

>
>> > - it is *very easy* to reason about, once it is pointed out that
>> > rebases and merges result in the same trees.
>> 
>> The original is as easy to reason about, if not easier, especially as
>> recursive merge strategy is not being used there in new ways.
>
> So do it. I still have to hear a single-sentence, clear and obvious
> explanation why it works.
>
> And please do not describe why your original version works, because it
> does not work.

Original [RFC] didn't work because of rather simple mistake that I've
already admitted and fixed. [RFC v2] has got the fix. Read [RFC v2] and
get your facts straight.

> Describe why the one amended with Buga's hack works.

It doesn't matter as these hacks are not needed anymore.

>
>> I honestly don't see any advantages of Phillip's method over the
>> original, except personal preferences. At the same time, I have no
>> objection of using it either, provided consistency check problem is
>> solved there as well.
>
> Okay, let me reiterate then, because I do not want this point to be
> missed:
>
> Phillip's method is essentially merging the new tips into the original
> merge, pretending that the new tips were not rebased but merged into
> upstream.
>
> So it exploits the duality of the rebase and merge operation, which both
> result in identical trees (potentially after resolving merge
> conflicts).
>
> I cannot think of any such interpretation for your proposal augmented by
> Buga's fix-ups. And I haven't heard any such interpretation from your
> side, either.

No fix-ups or augmentations are needed. It was a mistake that has been
fixed in [RFC v2]. You've missed essential part of the discussion.

Read the [RFC v2], please:

Significant changes are:

1. Fixed mistake in the final merge step in the original proposal: wrong
   merge base was used.

-- Sergey
