Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 811F81F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754081AbeFLS6l (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:58:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37386 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeFLS6k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:58:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so36980wro.4
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=MBG5BKY6wDhpoWy7apxujT0XR8V9cce47wMh3qsbdM0=;
        b=cmuwUN2KluiZIqW9Y43va0FCV0gIGyDPdEDGlyZ9PwzLUmdzmHI495JPsp+vbiaTgD
         lb8iagTpuIqzUT9CdReVKnhDgrGCHma1iJmzMV9sZhZHXyg0kW+oYsSweAwkhv7x075K
         EAzW2Ko6bbmEeXdJ7Ko/HrHBwqlLEKcoDfsYNg/btpWwwKHuTXpNZKWbPNsazBJLkjA0
         dSIWDOm2S9mGlYNnmDh5mK4FQKqvSoGY5jwc/I11AR8FXvVDlGaCBUv7RTEr3vxw0eCo
         8d7nAQC9MBFeoWDCIzBummqmj/gQyZ1zDSnj1juKRYoSjSjH6rYl0faj5GzgnE6vV6dD
         VdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=MBG5BKY6wDhpoWy7apxujT0XR8V9cce47wMh3qsbdM0=;
        b=lfk3kb4vU9Nq3rDkKEgYuv7AvRWX+qoz+4QsbZsjRS81Gf1EJyURKpHhda3m1DpXi4
         1wxz/nXWlyZPNVIe4xDh6s496bOMMbrWqiGxUqApyYDDCKMZYoJ5XhQxcjGoAgRd0GBT
         3YGWT/tz+Qffy3PoCatE4ndXEGzfJl8D39c9ojFkMynYq0RVinpX1Yq3ImSD+fyMS66S
         hggsuOTlXVQSBKMilNXIHbcqiHwDrIFcQN7OELRX+3HwzqN/KEmNCp6jRC5CF1LAdR0y
         riw1rNvknZZJC5DFhxa6Pr9kF6XrAKzbA2hz4PDO21d/2zCTqolhnH+6lUNy/bEKFLLm
         RLVg==
X-Gm-Message-State: APt69E05uweRM2Kj//P6T8WDAO7BcDjUr9MR2oKrcqeIcnrRgmcRbhdz
        rW31lNYC49G2Z4zWwBs9RdE=
X-Google-Smtp-Source: ADUXVKILYTtpqJMDcVSEvB3HHWRXlnN9jDzF0ulH98Q8XUoLFZ7xdx3HJLc2wSY/65jPDrMUNthj+w==
X-Received: by 2002:adf:8e30:: with SMTP id n45-v6mr1383255wrb.27.1528829918804;
        Tue, 12 Jun 2018 11:58:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v138-v6sm1709600wmd.47.2018.06.12.11.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:58:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 20/20] abbrev: add a core.validateAbbrev setting
References: <20180608224136.20220-1-avarab@gmail.com>
        <20180608224136.20220-21-avarab@gmail.com>
        <CAN0heSqo1WSVkYNiFAv4A7x8hG0wEx-iSz7ssLmYYVuen7b-LQ@mail.gmail.com>
Date:   Tue, 12 Jun 2018 11:58:37 -0700
In-Reply-To: <CAN0heSqo1WSVkYNiFAv4A7x8hG0wEx-iSz7ssLmYYVuen7b-LQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 9 Jun 2018 17:47:18
 +0200")
Message-ID: <xmqqzhzz96hu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

>> +This is especially useful in combination with the
>> +`core.validateAbbrev` setting, or to get more future-proof hashes to
>> +reference in the future in a repository whose number of objects is
>> +expected to grow.
>
> Maybe s/validateAbbrev/validateAbbrev = false/?

Perhaps, but even with =true it would equally be useful, as the
point of this setting is to future-proofing.

>> ++
>> +When printing abbreviated object names Git needs to look through the
>> +local object store. This is an `O(log N)` operation assuming all the
>> +objects are in a single pack file, but `X * O(log N)` given `X` pack
>> +files, which can get expensive on some larger repositories.
>
> This might be very close to too much information.

Not very close, but just too much information without crucial detail
(i.e. log N times what constant???).  I'd drop it.

>> ++
>> +This setting changes that to `O(1)`, but with the trade-off that
>> +depending on the value of `core.abbrev` we may be printing abbreviated
>> +hashes that collide.

It may not be technically wrong to say "This changes it to O(1)",
but I think to most people it is more understandable to say "This
changes it to zero" ;-)

    Setting this variable to false makes Git not to validate the
    abbreviation it produces uniquely identifies an object among the
    current set of objects in the repository.  Depending on the
    value of `core.abbrev`, we may be printing abbreviated hashes
    that collide.  Note that setting this variable to true (or
    leaving it unset) does not guarantee that an abbreviated hash
    will never collide with future objects in the repository (you
    need to set core.abbrevLength to a larger value for that).

would be sufficient to clarify, and also nuke the following
overly-detailed paragraph.

>> ... Too see how likely this is, try running:
>> ++
>> +-----------------------------------------------------------------------------------------------------------
>> +git log --all --pretty=format:%h --abbrev=4 | perl -nE 'chomp; say length' | sort | uniq -c | sort -nr
>> +-----------------------------------------------------------------------------------------------------------
>> ++
>> +This shows how many commits were found at each abbreviation length. On
>> +linux.git in June 2018 this shows a bit more than 750,000 commits,
>> +with just 4 needing 11 characters to be fully abbreviated, and the
>> +default heuristic picks a length of 12.
>
> These last few paragraphs seem like too much to me.

Yeah, it goes to too low level a detail, especially with the "try
running" part.  I'd remove everything but "On linux.git in June ..."
if I were writing it from the above.

>> ++
>> +Even without `core.validateAbbrev=false` the results abbreviation
>> +already a bit of a probability game. They're guaranteed at the moment
>> +of generation, but as more objects are added, ambiguities may be
>> +introduced. Likewise, what's unambiguous for you may not be for
>> +somebody else you're communicating with, if they have their own clone.
>
> This seems more useful.

Yes, but still overly verbose; I think rolling it in the single
paragraph description like I showed above would be sufficient.

>> ++
>> +Therefore the default of `core.validateAbbrev=true` may not save you
>> +in practice if you're sharing the SHA-1 or noting it now to use after
>> +a `git fetch`. You may be better off setting `core.abbrev` to
>> +e.g. `+2` to add 2 extra characters to the SHA-1, and possibly combine
>> +that with `core.validateAbbrev=false` to get a reasonable trade-off
>> +between safety and performance.
>
> Makes sense. As before, I'd suggest s/SHA-1/object ID/.

Likewise.  If we were to keep it, then s/object ID/object name/.
