Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF65620A04
	for <e@80x24.org>; Fri, 26 May 2017 19:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbdEZTaI (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 15:30:08 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35861 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbdEZTaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 15:30:07 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so19672222pfg.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w6UnpDLEyWSvbi9qmTpK0ispYAMHefvcqDKqGLd56ig=;
        b=Mx/zWtV8QaZxY3Ts4t/v+bYdD1U2tY5qGjwwvS1QRz8MkBWsh271XWaYWu1KREKvmO
         UoeMVfbf5URDk7t1dSe2tYLVdeIQmWsFpyTA+faIr47bVH1xy48OZGxqiEApm40sWkQH
         pkQYwzHVA9/Z6fk2Qi+FAcSzC5PMUj9n/Tkt3Ji7PePqgY+hpNW2CpfXTofo7bp5E1Nx
         1kic5guum0kJk1moYgdS2W5mxxrN+y72B1mxYjezH9tf/hZcS8OMRqsXrEl02P0zpdEI
         acRlTBZ7eqnCbhAdwkUvUyfZh45RqRdzU0NLNuudzYStLeUYyoOYFnzjQH1tB8Ac3VlJ
         zFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w6UnpDLEyWSvbi9qmTpK0ispYAMHefvcqDKqGLd56ig=;
        b=jFlZQiKjg2wHMQoHdB/QhNyXT19V5XB2C3ultjL3+pnaE4jeFoLlJjORrg7IJzsSbN
         S1zoEf1g6S37xFJKKIM9vplagOY11YGsX2TfvoFj0Aa/LHXjqi0P4/FpXMj+mooWz8Ae
         zPAQPZWzh8YHdnoW9wqHdbFnQwaWMJOvCR3+WncjAXWeeaNMKpSg7tDpA2edp71ab6H+
         NK5dx8XG9NJpzPQOWgiFz/2iNoPq5+YJT33/46NhQoqvDcsGVzWHbFkULpqy6GLOuLmA
         i4C4RWY7Y2V4YBMQEgGmuu98dCRerI1s9gFPUmEfsgF1k1O8L7J27YGXWZCKhxhogUqN
         P/hQ==
X-Gm-Message-State: AODbwcDSEdFRo/QeZLRwHxV55zWm8d3iy6fCTHr6283ImPw6IV3pf1O7
        m3XPbGPRnmWOWL9a5vqa8N5aDIq83302
X-Received: by 10.98.236.150 with SMTP id e22mr4248439pfm.48.1495827006178;
 Fri, 26 May 2017 12:30:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Fri, 26 May 2017 12:30:05 -0700 (PDT)
In-Reply-To: <xmqq8tlkct27.fsf@gitster.mtv.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <xmqq7f15e8pu.fsf@gitster.mtv.corp.google.com> <CAGZ79kYO8DoTDCXCk1uSFSAJA5JusD-t4BZoQfGy5n9DF34EvA@mail.gmail.com>
 <xmqq8tlkct27.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 May 2017 12:30:05 -0700
Message-ID: <CAGZ79kbD6QggYH9+M8FM0Khg7Cs0egJR6Jm+kMJkscaANV6UXA@mail.gmail.com>
Subject: Re: [PATCHv5 00/17] Diff machine: highlight moved lines.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> As you turn on/off normal coloring via "color.diff" and this only extends
>> the coloring scheme, I have the impression "color" is the right section.
>> Maybe color.diffStyle=[normal/enhanced] and "enhanced" means this
>> feature for now?
>
> Hmph, I thought the intent of color.diff is "is the diff command
> itself is colored?"  In other words, color.diff=false should give
> you monochrome if you say "diff --word-diff", etc.

Yes, but in my understanding the "diff" doesn't apply to
the command, but the part of the output. I arrived at that
understanding as other commands (show/log/..) also respect
that setting, so the "diff" in color.diff is not the command, but
referring to something else, the output being the closest match. :)

And by that understanding color.diffStyle is just natural?

But I think that setting would be a bad idea as we'd rather have
multiple uncorrelated settings for coloring, which a style argument
would not.

>> The only option in the "diff" section related to color is diff.wsErrorHighlight
>> which has a very similar purpose, so "diff.colorMoved" would fit in that
>> scheme.

With the above reasoning, this may be missnamed and should rather be
color.wsErrorHighlight as it applies to more than just the diff command.

Note: The average user may not aware that diff/show/log are tiny wrappers
around the same backend for the heavy lifting.

> I didn't have "should diff output highlight whitespace errors?" in
> mind when I wrote the message you are responding to, but yes, that
> is quite similar to "should diff output show lines moved and lines
> deleted/added differently?".
>
>> So with these questions, I wonder if we want to color moved lines
>> as "color.diff.context" (i.e. plain white text in the normal coloring scheme)
>> This would serve the intended purpose of
>> dimming the attention to moved lines.
>
> Yes, but two points.
>
>  (1) We want to do so while making it obvious where the boundary
>      between two moved blocks of text whose destination (for
>      moved-deleted lines) or source (for moved-added lines) is.

Yes, that is what the boundary color would accomplish.
Any two adjacent blocks with the same sign would have
their boundary line colored this way.

>  (2) My message was an impression from using the code to review a
>      patch that is meant to be "move without changing other things".

Ok, glad you found it somewhat useful already.

>      For other purposes, there may be cases where moved ones may
>      want to be highlighted, not dimmed.

I wonder what these use cases would be?
(barring a --find-copies harder extension that would not just search the
current diff, but the whole tree)

That hints at just having an extra slot for the moved block, but the default
color could be the same as color.diff.context for dimming.

By now I also think we may not need different colors for additions
or removals, but keeping two colors is easy enough.

>> Regarding the last point of marking up adjacent blocks (which would
>> indicate that there is a coherency issue or just moving from different
>> places), we could highlight the last line of the previous block
>> and first line of the next block in their "normal" colors (i.e.
>> color.diff.old and color.diff.new).
>
> Hmm.  That is an interesting thought.

I'll try the implementation for that and see if it looks good.

Thanks,
Stefan
