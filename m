Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F28C1FF6D
	for <e@80x24.org>; Sat, 17 Dec 2016 07:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbcLQHvV (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 02:51:21 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35834 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbcLQHvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 02:51:20 -0500
Received: by mail-it0-f54.google.com with SMTP id c20so32031691itb.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 23:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+bYlvN6tJLk9dorf3VhwqinXyLc3Hiy9+YxEC6uJVrY=;
        b=MP/eN/QIYcemBTkVj1enjierpSSxd912O8i+BiSAQbnjZHe0ZE8JXMPCJYBedjG3QU
         UemeokQv7XFs7ScfEAP/Lzi75XndAe029qV9R7tlDIrWMInV+Pe38T9VdhbW5RuZpv77
         SaaadMRyrvWs9WJaHQbqBygEwBjsXtEPVnTKuVlP23TjLb2H0z9+izXnaka/4aOP6vkH
         Ac3vdFcXa2Wpq/6/BqjRylEIR4Etcr2V5laqPUClh4HCzzD08juL3Hn0G4LoWb4jYdyp
         euEor+9QlT+5q1v4G/zYDiR0SYb8ROIo+Z80JAqNUZEV+szvlqjd9JyqKHEHNmiGD/1e
         vdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+bYlvN6tJLk9dorf3VhwqinXyLc3Hiy9+YxEC6uJVrY=;
        b=FlY+ls4EMbP/9sYoPJ7/tcJrB5vXSQKDISEcQUoh+oxcSe++WAtvQtuf4iM+eNsHxQ
         Vr75JaNpezT1/igNpDcMqT0BhzM41M1t04WH/62XhUZ2NNX1tELDhZmOhX1Eof32GO70
         fYUKrDEhhCN6hs6SaEFezvw2rfKpZWKMZn/0mTAukRkFWMFeAOQWD7Goykqn6OVKeEKj
         UHANU58fGRdIBIaI+b8+mH7StrqlLsJi9IJcEs5l0lRdIYbCOqfVF/qDWgkVa/pIMIvD
         3zleEuK8tm/D8C4YW8XNDmOLx94cD5vx51rj1gVcFk9H9Z9MjrLcQqdhRH+KDVv6O9WE
         F72w==
X-Gm-Message-State: AKaTC02rFlOxCBjg32BcTpIpipMB6Uw5sSOq9aIWgrqwBi18N0/jJySEXWOshQ1tYS1UO7yKcMWRQmVJoHW8qQ==
X-Received: by 10.36.184.194 with SMTP id m185mr6582164ite.3.1481961079440;
 Fri, 16 Dec 2016 23:51:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 16 Dec 2016 23:50:48 -0800 (PST)
In-Reply-To: <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
References: <1481922331.28176.11.camel@frank> <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 17 Dec 2016 14:50:48 +0700
Message-ID: <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
Subject: Re: "disabling bitmap writing, as some objects are not being packed"?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2016 at 4:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <novalis@novalis.org> writes:
>
>> I'm a bit confused by the message "disabling bitmap writing, as some
>> objects are not being packed".  I see it the my gc.log file on my git
>> server.
>
>> 1. Its presence in the gc.log file prevents future automatic garbage
>> collection.  This seems bad.  I understand the desire to avoid making
>> things worse if a past gc has run into issues.  But this warning is
>> non-fatal; the only consequence is that many operations get slower.  But
>> a lack of gc when there are too many packs causes that consequence too
>> (often a much worse slowdown than would be caused by the missing
>> bitmap).
>>
>> So I wonder if it would be better for auto gc to grep gc.log for fatal
>> errors (as opposed to warnings) and only skip running if any are found.
>> Alternately, we could simply put warnings into gc.log.warning and
>> reserve gc.log for fatal errors. I'm not sure which would be simpler.
>
> I am not sure if string matching is really a good idea, as I'd
> assume that these messages are eligible for i18n.

And we can't grep for fatal errors anyway. The problem that led to
329e6e8794 was this line

    warning: There are too many unreachable loose objects; run 'git
prune' to remove them.

which is not fatal.

> 329e6e8794 ("gc: save log from daemonized gc --auto and print it
> next time", 2015-09-19) wanted to notice that auto-gc is not
> making progress and used the presense of error messages as a cue.
> In your case, I think the auto-gc _is_ making progress, reducing
> number of loose objects in the repository or consolidating many
> packfiles into one

Yeah the key point is making progress, and to reliably detect that we
need some way for all the commands that git-gc executes to tell it
about that, git-repack in this particular case but...

> and the message is only about the fact that
> packing is punting and not producing a bitmap as you asked, which
> is different from not making any progress.  I do not think log vs
> warn is a good criteria to tell them apart, either.
>
> In any case, as the error message asks the user to do, the user
> eventually wants to correct the root cause before removing the
> gc.log; I am not sure report_last_gc_error() is the place to correct
> this in the first place.
>
>> 2. I don't understand what would cause that message.  That is, what bad
>> thing am I doing that I should stop doing?  I've briefly skimmed the
>> code and commit message, but the answer isn't leaping out at me.
>
> Enabling bitmap generation for incremental packing that does not
> cram everything into a single pack is triggering it, I would
> presume.  Perhaps we should ignore -b option in most of the cases
> and enable it only for "repack -a -d -f" codepath?  Or detect that
> we are being run from "gc --auto" and automatically disable -b?

... since we have to change down in git-repack for that, perhaps doing
this is better. We can pass --auto (or something) to repack to tell it
about this special caller, so it only prints something to stderr in
serious cases.

Or we detect cases where background gc'ing won't work well and always
do it in foreground (e.g. when bitmap generation is enabled).

> I have a feeling that an approach along that line is closer to the
> real solution than tweaking report_last_gc_error() and trying to
> deduce if we are making any progress.
-- 
Duy
