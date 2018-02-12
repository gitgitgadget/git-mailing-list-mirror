Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5538E1FAE2
	for <e@80x24.org>; Mon, 12 Feb 2018 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964888AbeBLQV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 11:21:26 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:45733 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964875AbeBLQVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 11:21:25 -0500
Received: by mail-io0-f177.google.com with SMTP id p188so17824235ioe.12
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 08:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l4NolcW8NOx3m73I0tCMOdDAeJacv35lrBX/D3u6tiU=;
        b=Y9YOT5cwoz+cc67rR0cYf8ioyVNBzGlAYr9g1J4lEli7TvMiDWO545XUMHJVBaFr7P
         x7ctK5UasMVS1LK7Sw5Fnqwp/UG7MrUDRXT8saHqxnD8NwJ6ws64rHz1lr1jZn3a4ic2
         joXnjOp/whjrzCspDxMbpjZWRNu03K66386YkBdugQ1/OmHVKNgPIOabCGlJV/uPAjhx
         /RR6owTGupoRInPw2SK7xykAT3CSiDOjkSt2StcDv8GRfaJ6vBoBBJS62kb7m/yIBww7
         /Wgul0eLJvv3G8hl8EKUaan9di2hbemZ9eg7AOTSz3uPSAMpfXmKGKBnTziq6XLGKMC4
         NOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l4NolcW8NOx3m73I0tCMOdDAeJacv35lrBX/D3u6tiU=;
        b=iBfYkwdjCJxFjRc1/HsVPbO2Ke+K362/Twqf161p0EFGnK80QBTPLb6qI9gkn71nKO
         sT9GWWHmYVMy1KwR1P0lHJbrl2NIqnA0TokdJUT7GlqB0ATycK6/N19QTD0Rx+FpwZY0
         XoNjFQdv3J1VRQzCmF7q86p8leZGQ/1UM9uJSb/X+THMpPtOFiUR628gFGkYT8QDGpAf
         kgg3KxIZNjWqiJAOWJXEccACV0Amqv/aiRdfZg+/MqyniUA60t4cmGjK0j0p8BQKF9cv
         U7hrz7uCPvQ2HAeqRjcI3KNozd6lJ+ct4GFoGWJKZlKZlll+yw10A7fjHzZAGn3Us5cs
         ZBew==
X-Gm-Message-State: APf1xPCr9QOjLoF77z0MsooeuiijiZ7f8dZhvIS+Dl972O5rSoYxlyFs
        3e/YEVl5k0ByrFSL/+5/uWDnF+7/kCTKGAIbG8Q=
X-Google-Smtp-Source: AH8x226IVxBN5CjJ5hZyTS74aeXECQ4gI0Mx2hLXAtEYMqt8autS6UdKsJFIDmDP/RrH++eTKZQ9aHWrNY9S449fuTc=
X-Received: by 10.107.168.232 with SMTP id e101mr2359804ioj.180.1518452484127;
 Mon, 12 Feb 2018 08:21:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.150.155 with HTTP; Mon, 12 Feb 2018 08:21:23 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802120522580.17810@localhost.localdomain>
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain>
 <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1802120522580.17810@localhost.localdomain>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 12 Feb 2018 17:21:23 +0100
Message-ID: <CAP8UFD03TDGBU3t3+m2OmhyJt6sNcPhMZ2ejzufX3x-_1EEDHA@mail.gmail.com>
Subject: Re: totally confused as to what "git bisect skip" is supposed to do
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 11:44 AM, Robert P. J. Day
<rpjday@crashcourse.ca> wrote:
> On Fri, 9 Feb 2018, Junio C Hamano wrote:
>
>> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>>
>> >   i'm confused ... why, after skipping a good chunk in the interval
>> > [v4.13,v4.14], do i still have exactly 7300 revisions to bisect? what
>> > am i so hopelessly misunderstanding here?
>>
>> Are you really "skipping" a chunk in the interval?
>>
>> I thought that "git bisect skip" is a way for you to respond, when
>> "git bisect" gave you a commit to test, saying "sorry, I cannot test
>> that exact version, please offer me something else to test".  And
>> each time you say that, you are not narrowing the search space in
>> any way, so it is understandable that the numver of candidate bad
>> commits will not decrease.
>
>   this might be an issue of terminology, then, as "man git-bisect"
> clearly suggests you can skip a range:
>
>     You can also skip a range of commits, instead of just one
>     commit, using range notation. For example:
>
>            $ git bisect skip v2.5..v2.6
>
>     This tells the bisect process that no commit after v2.5, up to
>     and including v2.6, should be tested.

Yeah, I think this is kind of a terminology related.

First when git bisect says "Bisecting: XXX revisions left to test
after this" it doesn't mean that all those revisions left will
actually be tested, as git bisect's purpose is to avoid testing as
many revisions as possible.

So the XXX revisions are actually the revisions that possibly contain
the first bad commit.

And, as Junio wrote, when you tell git bisect that you cannot test
some revisions, it doesn't mean that those revisions cannot contain
the first bad commit.

> my issue (if this is indeed an issue) is that if i select to skip a
> sizable range of commits to test, should that not result in git bisect
> telling me it now has far fewer revisions to test? if i, in fact,
> manage to "disqualify" a number of commits from testing, is there no
> visual confirmation that i now have fewer commits to test?

I hope that the above clarification I gave is enough, but maybe the
following will help you.

If you cannot test let's say 20 commits because there is build problem
in those commits, and in the end Git tells you that the first bad
commit could be any of 3 commits, 2 of them that were previously
marked with skip, then you could still, if you wanted, fix those
commits, so that they can be built and test them.

So yeah if we only talk about the current bisection, the skipped
commits will not be tested, but if we talk about completely finishing
the bisection and finding the first bad commit, then those commits
could still be tested.
