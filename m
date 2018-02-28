Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945EB1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 05:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeB1FoS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 00:44:18 -0500
Received: from mail.javad.com ([54.86.164.124]:60547 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeB1FoR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 00:44:17 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4D5F8407C5;
        Wed, 28 Feb 2018 05:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519796656;
        bh=OkjOg4jIJ5rPkf92si0bC/2mse1p9KJRNygbig6d4tw=; l=4826;
        h=Received:From:To:Subject;
        b=C9L4cOGv8h/Bu0cKrYiPM7puk0JqeyPvOZqFRVeO+Wc9KhB9a8gFgyTOeKUqIFHEb
         /kk6EX/CDltnvC+WCpenwDrk1S2iuEtZ2mBVDEoMoVCbV6RdoCeYlC+5zm6CmQOVK0
         HyPETVBzhsIvYPdXc1CMK8T3p5S9Iva+miuIxWwo=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1equXF-0001Qy-PK; Wed, 28 Feb 2018 08:44:13 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
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
        <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 28 Feb 2018 08:44:13 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 28 Feb 2018 00:27:19 +0100
        (STD)")
Message-ID: <87sh9lmzwy.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Buga,
>
> thank you for making this a lot more understandable to this thick
> developer.
>
> On Tue, 27 Feb 2018, Igor Djordjevic wrote:
>
>> On 27/02/2018 19:55, Igor Djordjevic wrote:
>> > 
>> > It would be more along the lines of "(1) rebase old merge commit parents, 
>> > (2) generate separate diff between old merge commit and each of its 
>> > parents, (3) apply each diff to their corresponding newly rebased 
>> > parent respectively (as a temporary commit, one per rebased parent), 
>> > (4) merge these temporary commits to generate 'rebased' merge commit, 
>> > (5) drop temporary commits, recording their parents as parents of 
>> > 'rebased' merge commit (instead of dropped temporary commits)".
>> > 
>> > Implementation wise, steps (2) and (3) could also be done by simply 
>> > copying old merge commit _snapshot_ on top of each of its parents as 
>> > a temporary, non-merge commit, then rebasing (cherry-picking) these 
>> > temporary commits on top of their rebased parent commits to produce 
>> > rebased temporary commits (to be merged for generating 'rebased' 
>> > merge commit in step (4)).
>> 
>> For those still tagging along (and still confused), here are some 
>> diagrams (following what Sergey originally described). Note that 
>> actual implementation might be even simpler, but I believe it`s a bit 
>> easier to understand like this, using some "temporary" commits approach.
>> 
>> Here`s our starting position:
>> 
>> (0) ---X1---o---o---o---o---o---X2 (master)
>>        |\
>>        | A1---A2---A3
>>        |             \
>>        |              M (topic)
>>        |             /
>>        \-B1---B2---B3
>> 
>> 
>> Now, we want to rebase merge commit M from X1 onto X2. First, rebase
>> merge commit parents as usual:
>> 
>> (1) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3           | A1'--A2'--A3'
>>        |             \          |
>>        |              M         |
>>        |             /          |
>>        \-B1---B2---B3           \-B1'--B2'--B3'
>> 
>> 
>> That was commonly understandable part.
>
> Good. Let's assume that I want to do this interactively (because let's
> face it, rebase is boring unless we shake up things a little). And let's
> assume that A1 is my only change to the README, and that I realized that
> it was incorrect and I do not want the world to see it, so I drop A1'.
>
> Let's see how things go from here:
>
>> Now, for "rebasing" the merge commit (keeping possible amendments), we
>> do some extra work. First, we make two temporary commits on top of old
>> merge parents, by using exact tree (snapshot) of commit M:
>> 
>> (2) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'
>>        |             \          |
>>        |              M         |
>>        |             /          |
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'
>
> Okay, everything would still be the same except that I still have dropped
> A1'.
>
>> So here, in terms of _snapshots_ (trees, not diffs), U1 = U2 = M.
>> 
>> Now, we rebase these temporary commits, too:
>> 
>> (3) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>        |             \          |
>>        |              M         |
>>        |             /          |
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>
> I still want to drop A1 in this rebase, so A1' is still missing.
>
> And now it starts to get interesting.
>
> The diff between A3 and U1 does not touch the README, of course, as I said
> that only A1 changed the README.  But the diff between B3 and U2 does
> change the README, thanks to M containing A1 change.
>
> Therefore, the diff between B3' and U2' will also have this change to the
> README. That change that I wanted to drop.
>
>> As a next step, we merge these temporary commits to produce our
>> "rebased" merged commit M:
>> 
>> (4) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>        |             \          |                  \
>>        |              M         |                   M'
>>        |             /          |                  /
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>
> And here, thanks to B3'..U2' changing the README, M' will also have that
> change that I wanted to see dropped.
>
> Note that A1' is still dropped in my example.
>
>> Finally, we drop temporary commits, and record rebased commits A3' 
>> and B3' as our "rebased" merge commit parents instead (merge commit 
>> M' keeps its same tree/snapshot state, just gets parents replaced):
>> 
>> (5) ---X1---o---o---o---o---o---X2
>>        |\                       |\
>>        | A1---A2---A3---U1      | A1'--A2'--A3'
>>        |             \          |             \
>>        |              M         |              M'
>>        |             /          |             /
>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'
>
> Now, thanks to U2' being dropped (and A1' *still* being dropped), the
> change in the README that is still in M' is really only in M'. No other
> rebased commit has it. That makes it look as if M' introduced this change
> in addition to the changes that were merged between the merge parents.

Except that original proposal suggests to cosider this a conflict and
to stop for amendment, as U1' and U2' now differ.

-- Sergey
