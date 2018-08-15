Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D346E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeHOSfo (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 14:35:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44257 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeHOSfo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 14:35:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so1490255wrt.11
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BCO9YJ8Ra8UJmc3cOHzJhn6dcbdgmFbNVwc5MuBBk48=;
        b=pshhcokEGnxWtNc2LeK4qHov/k/FWbXEY8VpWu1/ef7F6ocFdNjm+eJQjCG5Kg4sb7
         Q4DXS+Ymn/afcUBVSqZB2MPbyqhVem6QxhdCncJyHYCBPql492C7cT9Eua1QqxCEU7QK
         2c0g0FF9kdh3g4QCnQeuVTAlIq3aCM45AGjcTTi104mE1asLwqVSkV0BYHcqbz7+l8zj
         DW1wurWU7mno/xAQa7TaCIg9mMEqg5VyUO+v02AzYcRzFuB084MxukOHnrJdl5ZtM/Rx
         WfgTHyPitB/6SFj9T2vrq6eU2rAHTeWTYqk8u0gknQ1im+tN2f6pJKBZ8oyraJ3NoDv4
         2plA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BCO9YJ8Ra8UJmc3cOHzJhn6dcbdgmFbNVwc5MuBBk48=;
        b=dMUUhjPKO/4PKM9OU7uAZZpZYRG5t1Y7Fv1rwGg/dkiV8TLXlvbw3OJ1+VmViWsvo9
         Rf5TmXgXrYnpj7fXU0yyGOuD3SCxaeauKhxaN31+6zws/XZIUozzitqckGFkfBi0zXt7
         EDJdzFUC52bMxmnJe5GPIOOZweQBTIiyjQTCnJ+8+x2Ft+dKAT3EO9vmpkGxZDgZDrjX
         FYx7Kmr2L5YA9WRIe3pU1ERFWLJd1nihsuQl6Px+iEwFgMkP7XkSfJFNnnG1coQvi2dS
         XYSWL6Z88HSJZ/Da8zV9W7iFqSE4LY66UawKBUpx9o/7/cZ+6V+glW4scripYbv5cJRY
         RkGQ==
X-Gm-Message-State: AOUpUlGm32hpbVfmEBRWKVH24hivWT1PRbXOD5Dyye0UrEf7PXy1CiaJ
        n06ds3DltgiUOqqgDojOj5k=
X-Google-Smtp-Source: AA+uWPxZKj4GQC8w2yo/jRbNSxzF/Q6wZ4eJ9NrrZ5CVK6oOPj0sHkfdv46T+2fDp7gfdGD46FHtyA==
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr16552268wrh.267.1534347783429;
        Wed, 15 Aug 2018 08:43:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p11-v6sm16265066wrs.51.2018.08.15.08.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 08:43:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
References: <20180811043218.31456-1-newren@gmail.com>
        <87mutts3sz.fsf@evledraar.gmail.com>
        <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
        <20180811173406.GA9119@sigill.intra.peff.net>
        <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHZoWn-mZjop+n9PJ0+A4tZFrU6vJE+A7iSeHDXcDc=Yg@mail.gmail.com>
        <xmqqftzgxjww.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGtuxmeLTFTmsRvaK6J0jA9Sa3wx3rR0Ov8nJkxL4aqqA@mail.gmail.com>
Date:   Wed, 15 Aug 2018 08:43:01 -0700
In-Reply-To: <CABPp-BGtuxmeLTFTmsRvaK6J0jA9Sa3wx3rR0Ov8nJkxL4aqqA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 14 Aug 2018 22:57:13 -0700")
Message-ID: <xmqqzhxnmy9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Aug 14, 2018 at 10:45 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Mon, Aug 13, 2018 at 11:24 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >> Jeff King <peff@peff.net> writes:
>> >
>> >> As things are slowly moving out of the so-far kitchen-sink "cache.h"
>> >> into more specific subsystem headers (like object-store.h), we may
>> >> actually want to tighten the "header that includes it first" part a
>> >> bit in the future, so that 'git grep cache.h' would give us a more
>> >> explicit and a better picture of what really depends on knowing what
>> >> the lowest level plumbing API are built around.
>> >>
>> >> > So I think the better test is a two-line .c file with:
>> >> >
>> >> >   #include "git-compat-util.h"
>> >> >   #include $header_to_check
>> >>
>> >> But until that tightening happens, I do not actually mind the
>> >> two-line .c file started with inclusion of cache.h instead of
>> >> git-compat-util.h.  That would limit the scope of this series
>> >> further.
>> >
>> > Yes, this removes about 2/3 of patch #1.
>>
>> Sorry for making a misleading comment.  I should have phrased "I
>> would not have minded if the series were looser by assuming
>> cache.h", implying that "but now the actual patch went extra mile to
>> be more complete, what we have is even better ;-)".
>
> Ah, gotcha.  Thanks for the clarification.

But please remind me not to merge this round down to 'next', for the
"enum" forward decl gotcha.

