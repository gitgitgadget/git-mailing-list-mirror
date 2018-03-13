Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C671F404
	for <e@80x24.org>; Tue, 13 Mar 2018 17:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751757AbeCMRWp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 13:22:45 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:44098 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCMRWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 13:22:44 -0400
Received: by mail-ua0-f172.google.com with SMTP id s92so244822uas.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mujJKPTb7rZ11Tby1tA3/LHdkSRnWfn1R2sVm+eOiJo=;
        b=lx+HcaUIwpZSqo/HeSO9V8TOYCIOQVynNT4iQR1jz1f0dZZG9OYHD/TmQB9Jwzxdhv
         Hc127Z7ItsmPzRO13nHfNdYImkORVQqmPrQv6MLPT4PJ4XWKh1sNp8GsCyKHtZRdFTKG
         YE2YdTXmrWVAAbmGFKzL03xeFMPM3GfbGKF2LvoOkS0kPXVdyIo4vESGDotx70+RF7N/
         dcTd6iwdIzdbb32OOGB0OYWu40aQYOaL7sezhESxjAJuP7Mh9X2PNDueRM/42N348tdY
         Hje7BLsePI9kwr81nP1vyvCBsbG0XPKaN3kagjDe1+0lIUSUFMD74Nwe9LewwKw0nwAi
         w/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mujJKPTb7rZ11Tby1tA3/LHdkSRnWfn1R2sVm+eOiJo=;
        b=XyZCrdZayAslmUgw1KGcm8BckGBnPZy8B8Zk1PyU51XxJl2P6toelOdUBp5Q1suJVh
         6bsPaGzZvlpWziRdZsanE3iw+6EhzucgnGrRujGcoskZRJCJbEs2Q/yAYNOsvAhfwXK1
         YvbDy3FPLQICgYaiG8AYKn15wnvcEaJyEY1n7ev6KozzfPDjJdoxC/uzjUVQ1j5galqi
         FLa52E2pZI39G7tDvc2u0mrF7hXBssPY/YUl7gtMmen8Zds7Di+/T4Y6Mb40YohBaV4y
         wZZBhGWWJZysKzj7sJse03glP4Cdeklzb2lrf54uqTN/1x+npqs2uONec12ZKPU/x0Fc
         4xFw==
X-Gm-Message-State: AElRT7FkRqrWMxCyGzHezWF/j/IJfkNwErWx3jWUJFUDg1gBcN2xXnOM
        hOyYCSZeC7VJ/5CBkAKLc0AjhohqeHMvNSXbDNY=
X-Google-Smtp-Source: AG47ELvc/gMXn3AZ1X0VRb3SD+ZEvdths2V9nfPONvMXrqgULuGBGtFmD4pV8Fn3fUQg07QyucWBED3kVrkzirOal0A=
X-Received: by 10.159.63.11 with SMTP id h11mr1207001uaj.94.1520961763661;
 Tue, 13 Mar 2018 10:22:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 10:22:42 -0700 (PDT)
In-Reply-To: <CABPp-BE653uMpwN4zfCCP8teRGmZ6v5NEyASCR1PTvHhoMKE1w@mail.gmail.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <20180312213521.GB58506@aiede.svl.corp.google.com> <CABPp-BE653uMpwN4zfCCP8teRGmZ6v5NEyASCR1PTvHhoMKE1w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 10:22:42 -0700
Message-ID: <CABPp-BHDVqq4atmCw=WX4KkV1C-kGh0MubowevJBw6n=qF56nA@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 5:38 PM, Elijah Newren <newren@gmail.com> wrote:
> I feel the analogy to merging binary files breaks down here in more
> than one way:

Actually, after mulling this over, I'm going to retract the "more
than" piece of this sentence.  I'm trying to figure out how to retract
more, but have only figured out one piece.  In particular...

> 1)
>
> Merging binary files is more complex than you suggest here.  In
> particular, when creating a virtual merge base, the resolution chosen
> is not the version of the file from HEAD, but the version of the file
> from the merge base.  Nasty problems would result otherwise for the
> recursive case.
>
> If we tried to match how merging binary files behaved, we run into the
> problem that the colliding file conflict case has no common version of
> the file from a merge base.  So the same strategy just doesn't apply.
> The closest would be outright deleting both versions of the file for
> the virtual merge base and punting to the outer merge to deal with it.
> That might be okay, but seems really odd to me.  I feel like it'd
> unnecessarily increase the number of conflicts users will see, though
> maybe it wouldn't be horrible if this was only done when the files
> were considered dissimilar anyway.

Thinking about this more, it really isn't that weird at all.  The code
is already set up to use null_oid as the "original" version when
creating a virtual merge base, going back to the content from a
recursive merge base is a strategy used in multiple places in
recursive cases, and null is precisely the version from the recursive
merge base.  If two added files differ wildly, I don't think using
null would increase the number of conflicts appreciably, if at all.
So, the analogy to merging binary files holds just fine from this
angle.

So, if we could figure out how to handle the higher numbers of paths
for e.g. the rename/rename cases, then perhaps this is a strategy that
could work.

>> Interesting.  I would be tempted to resolve this inconsistency the
>> other way: by doing a half-hearted two-way merge (e.g. by picking one
>> of the two versions of the colliding file) and marking the path as
>> conflicted in the index.  That way it's more similar to edit/edit,
>> too.
>
> Your proposal is underspecified; there are more complicated cases
> where your wording could have different meanings.
>
<snip>
> My question for your counter-proposal:
> Do you record C1 or C2 as C?  Or do you record the version of C from
> HEAD as C?  And what do you pick when creating a virtual merge base?
>
> Problems I see regardless of the choice in your counter-proposal:
>   * If you choose C from HEAD, you are ignoring 3 other versions of
> "C" (as opposed to just one other version when merging a binary file);
> will the user recognize that and know how to look at all four
> versions?
>   * If you choose C1 or C2, the user will see conflict markers; will
> the user recognize that this is only a _subset_ of the conflicts, and
> that there's a lot of content that was completely ignored?

>   * There is no "merge base of C1 and C2" to use for the virtual merge
> base.  What will you use?

For this last question, the answer is "null", and it works just fine.
I don't yet have good answers to the other questions, though.  If
someone else does, I'd love to hear it.


Oh, and by the way Jonathan, thanks very much for your feedback and
alternative ideas for consideration.  You gave me more angles to try
to think about this problem from.
