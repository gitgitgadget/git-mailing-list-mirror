Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2AB1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754841AbeFNTIW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 15:08:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45932 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbeFNTIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 15:08:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so7515741wrm.12
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 12:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=regZSTV9lFbq1KTv5iKF0EWCHh1LG618G4hQFOd848I=;
        b=Fnod5oF9spz6jE5Ij2/j+1EyMhR87/zZyQXDZcy935F1k6Mqf+kH4+oTDz5VXRMx9W
         dlzFuS77pBldipnqkbXGfedoZ76NeC7GolbIS0PY2f6rF7d+0ouvJJtn3yNlmMUVHy8m
         pQ834ll3ugZ0iCc1r9/+EG3i0Rqu81Lp3ep5lW9noFNrjDKwc4iUhKf7nU5ZKMWDqj13
         T0wwKPN9VLDRcLxXpa3yDelo/zGtmz1fzKy0BRYcUbcRUOLnGKYvYaGAE3EuU2RKQXkm
         etY8PuIDKUoIjikGjNCjq6E8O/8wxy4mkUss1mTZh9rPVkwBiecHov47QWkGd9CgoNeY
         /pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=regZSTV9lFbq1KTv5iKF0EWCHh1LG618G4hQFOd848I=;
        b=Z9RrZR2k4GKjei8cWJHgUN1x0Lffm1imDew1QAEeUhkydwF3cuFjD6JyUxreHi/PvA
         mBF2h6z8XpYKlME3VOkf1yuvHL1gQa+KQhFCmRRvzO5JNEygoffOFHoipd6AvGrDxyal
         djneCGVsbvjuYLoznlYk4DSM1e24TDCSL6d+Uxt6qid2zOjyLupstbw0Ofleo0dUQBB0
         MWk/YSQvJprKAF7YEyK4rFiwHcmYwL0RDrX7NOffDStrN2HqX6WUDF7zCfcTftlsUEGs
         LPPtwM9pwuJEVwNsZe5dQvtE3xZHEz/dt6x7kxI5hESh5Ia9aActMdkqfmm/qbiIhsAW
         Oy6w==
X-Gm-Message-State: APt69E3HvepcuhIKY1i8zCbPMJnV1I8rKJQkW/WuxMtY1cCWU6/fsGKJ
        6yQlL0uXUg+w4eG6JW31ky0=
X-Google-Smtp-Source: ADUXVKJEUovQN0K1UvLF6nxoh521cFsp0er3DISi2cyXZMz16TPTgQI07QGMh9j4e93qWuvkzlSPNw==
X-Received: by 2002:adf:a581:: with SMTP id g1-v6mr3576975wrc.233.1529003299354;
        Thu, 14 Jun 2018 12:08:19 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h77-v6sm9054692wmd.9.2018.06.14.12.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 12:08:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 19/20] abbrev: support relative abbrev values
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-20-avarab@gmail.com>
        <xmqqvaan95os.fsf@gitster-ct.c.googlers.com>
        <871sdawcmh.fsf@evledraar.gmail.com>
        <xmqqa7ry5n9h.fsf@gitster-ct.c.googlers.com>
        <87zhzxvmyv.fsf@evledraar.gmail.com>
        <xmqq602l5pvs.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqq602l5pvs.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 14 Jun 2018 21:07:53 +0200
Message-ID: <87y3fhuqye.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 14 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Jun 13 2018, Junio C Hamano wrote:
>>
>>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>>
>>>> E.g. here's a breakdown of my dotfiles repo:
>>>>
>>>>     $ git -c core.abbrev=4 log  --pretty=format:%h|perl -nE 'chomp;say length'|sort|uniq -c|sort -nr
>>>>         784 4
>>>>          59 5
>>>>           7 6
>>>>
>>>> I don't have a single commit that needs 7 characters, yet that's our
>>>> default. This is a sane trade-off for the kernel, but for something
>>>> that's just a toy or something you're playing around with something
>>>> shorter can make sense.
>>>>
>>>> SHA-1s aren't just written down, but also e.g. remembered in wetware
>>>> short-term memory.
>>>
>>> That's a fine example of what I called "supporting absurdly small
>>> absolute values like 4"; I still do not see why you want "negative
>>> relative values" from that example.
>>
>> Because hardcoding -2 is very different than setting it to 5, because
>> the -2 will scale to the size of the repository, but 5 is just 7-2 where
>> 7 is our default value.
>>
>> So, in general if you want less future proof hashes by some
>> probabilistic metric (whether you use core.validateAbbrev or not) you'd
>> use -2 or -3, just like you might use +2 or +3 if you'd like to have
>> more future-proof hashes (especially with core.validateAbbrev=true).
>
> That still does not make much sense to me at all.
>
> I do agree that something shorter than the default 7 may be more
> appropriate for our wetware short-term memory, and it would make
> sense to grow the "riskier to collide than the default heuristics
> but more memorable" variant as the project grows, _ONLY_ _IF_ our
> wetware short-term memory scales with the project we happen to be
> working on.  But our wetware does not scale with the project we work
> on; at least mine does not.

Yes, it's a trade-off, but just because something is a trade-off doesn't
make it useless.

Aside from the feature I'm proposing, the same thing applies to the
short SHA-1 currently. My ~1k commit dotfiles has 7 characters, but
linux.git has 12. Does that make printing the short SHA-1 at all useless
and we should just fall back to 40 characters if it's say >= 12? No.

12 is still better than 40, but if we could get away with it 10 would be
better than 12. Right now the "get away with it" calculation is a
hardcoded constant, this makes it configurable.

The reason to make it configurable is because you may want more future
proof *or* less future-proof SHA-1s depending on the use-case. Printing
a longer SHA-1 has a cost, including but not limited to:

 * Remembering it for a short time
 * Seeing it on one screen and typing it into another computer manually
 * `git log --oneline` output in a terminal where horizontal space is at
   a premium
