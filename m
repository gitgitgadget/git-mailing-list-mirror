Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241751F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeB1A3Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:29:24 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36855 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeB1A3X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:29:23 -0500
Received: by mail-wm0-f51.google.com with SMTP id 188so1868104wme.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WpInps/LyX0jDKH9FIEJrAvn+VQcISQNXrmM2Fao+F0=;
        b=AqWaXNI3Pn1w5icbRnmAAEnLFIc7VdYzl4S2Tez+InNCtDsLvbBKsFNnQPYinaNcAi
         HQNXScVWwNKXY3cgaD4vdpxFnbuWV9Jj7uW38s/Muy7Tc8zy/TIATypSPNjE+HC2bdNT
         eOMKRegs3FwvryuS+Xd+1NBTH6xGMZEtE8RrcIxydk2Pp1ign4UzenA7RD1HpTFyuXop
         U6MuIdAjBPluiYFbWLOIiKOsutxqvL7agwNIIsChjePaTaFgSM+qZbpmv+3MABVO6qiy
         0jkFpSYYfCzGAu64Sxwam11gF7TB1KR6E4yAnrKQLYjnoobzK8yFYhTq7+aqtdMCd8qY
         /QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WpInps/LyX0jDKH9FIEJrAvn+VQcISQNXrmM2Fao+F0=;
        b=jLQ11JQDUJKm/oZeuNdm+H5vsfNniYEdyFZa83FTHHzD29r5LbfCPE5IVhARWOh01u
         QJBGnE9TXX+cMvXACFGjM4Hn+4XVnxUrg/0rmcWS13CzYO++YICmQx0iIgZG+RClwctN
         OTQdVrQmUzYjLdsa/He0SWTB7JCZBTKGH6Z1nl0u0fC4mBtn0jmJHRyCv7eX8qMsrNDR
         GjAdEoTXO5fhOaV2v8nR010fpsTHSCgYpZOXslZv/QCNBJ4jdhbmd9pdnK0K5w4YUr0f
         W/qtQIYj4jp0buM3zv01vyV7zt00TTvU3mxFXNOVuAKwPqO1lWyNijlkW7vPKrcfQF9R
         9jPQ==
X-Gm-Message-State: APf1xPD+pkz7JRWqJJ784sF0YchC6DGzl1i+ZEGX+k33Q1d1zmhfWhUv
        feS4e2by8XaF7VpYcODSueQv1SnfrB51cJrVoXw=
X-Google-Smtp-Source: AH8x225GFnoeMpeB7fZz9vLA7sB+cQmHbqCDSm/uFJ5GtNuk54XPSpLHV0ocF2IpU5NpiqMmuFuKZgemvmLM8N2w06Y=
X-Received: by 10.80.139.5 with SMTP id l5mr21065531edl.265.1519777762336;
 Tue, 27 Feb 2018 16:29:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.139.133 with HTTP; Tue, 27 Feb 2018 16:29:01 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com> <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 27 Feb 2018 16:29:01 -0800
Message-ID: <CA+P7+xrXy1wCJ6D=3h_db93wLTzj9HGF6M6ptLXgEnSMW9KAwg@mail.gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 8:21 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake,
>
> On Mon, 26 Feb 2018, Jacob Keller wrote:
>
>> On Mon, Feb 26, 2018 at 4:07 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Tue, 20 Feb 2018, Igor Djordjevic wrote:
>> >
>> >> I`m really interested in this topic, which seems to (try to) address the
>> >> only "bad feeling" I had with rebasing merges - being afraid of silently
>> >> losing amendments by actually trying to "replay" the merge (where
>> >> additional and possibly important context is missing), instead of really
>> >> "rebasing" it (somehow).
>> >
>> > If those amendments are what you are worried about, why not address them
>> > specifically?
>> >
>> > In other words, rather than performing the equivalent of
>> >
>> >         git show <merge>^! | git apply
>> >
>> > (which would of course completely ignore if the rewritten <merge>^2
>> > dropped a patch, amended a patch, or even added a new patch), what you
>> > really want is to figure out what changes the user made when merging, and
>> > what merge strategy was used to begin with.
>> >
>> > To see what I mean, look at the output of `git show 0fd90daba8`: it shows
>> > how conflicts were resolved. By necessity, this is more complicated than a
>> > simple diff: it is *not* as simple as taking a diff between two revisions
>> > and applying that diff to a third revision. There were (at least) three
>> > revisions involved in the original merge commit, and recreating that merge
>> > commit faithfully means to represent the essence of the merge commit
>> > faithfully enough to be able to replay it on a new set of at least three
>> > revisions.  That can be simplified to two-way diffs only in very, very
>> > special circumstances, and in all other cases this simplification will
>> > simply fall on its nose.
>> >
>> > If the proposed solution was to extend `git apply` to process combined
>> > diffs, I would agree that we're on to something. That is not the proposed
>> > solution, though.
>> >
>> > In short: while I am sympathetic to the desire to keep things simple,
>> > the idea to somehow side-step replaying the original merge seems to be
>> > *prone* to be flawed. Any system that cannot accommodate
>> > dropped/changed/added commits on either side of a merge is likely to be
>> > too limited to be useful.
>> >
>>
>>
>> The reason Sergey's solution works is because he cherry picks the
>> merge using each parent first, and then merges the result of those. So
>> each branch of the merge gets one, and then you merge the result of
>> those cherry-picks. This preservers amendments and changes properly,
>> and should result in a good solution.
>
> I saw your patch trying to add a minimal example, and I really want to run
> away screaming.
>
> Do you have any way to describe the idea in a simple, 3-5 lines long
> paragraph?
>
> So far, I just know that it is some sort of confusing criss-cross
> cherry-picking and merging and stuff, but nothing in those steps shouts
> out to me what the *idea* is.
>

Sergey's posted explained it more in detail, at
https://public-inbox.org/git/87y3jtqdyg.fsf@javad.com/

I was mostly just attempting to re-create it in a test case to show
that it could work.

> If it would be something like "recreate the old merge, with merge
> conflicts and all, then generate the diff to the actual tree of the merge
> commit, then apply that to the newly-generated merge", I would understand.
>

It's more or less:

Rebase each parent, then cherry-pick -m<N> the original merge to that
parent, then you merge the result of each cherry-pick, then use the
resulting final merged tree to create the merge pointing at the real
parents instead of the cherry-pick merges.

> I would still suspect that -s ours would be a hard nut for that method,
> but I would understand that idea.
>

The goal of the process isn't to know or understand the "-s ours"
strategy, but simply re-create the contents of the original merge
faithfully, while still preserving the changes done when rebasing the
side branches. Thus it should re-create the contents generated by "-s
ours" the first time, but it doesn't need to do or know anything
special about how the content was created.

> Thanks,
> Dscho
