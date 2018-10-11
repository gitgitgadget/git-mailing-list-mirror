Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5111F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbeJKJFC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:05:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50697 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJFC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:05:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id i8-v6so7259749wmg.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fqd0G5c3meuQjfMyHlko63KaRK3xPjlAtCXxUflTNEk=;
        b=CF6ajB9jK8yiT3SGh7VvKs3jZskPL9GFWCw2OTMG515uI08JBR3ikSAWNc7d08BMA1
         AhZKEOuQM+4Z5Xte8pqIqh+YPZqo98z23EC/7G9SZP8jVZfXSZB58ho5iPSzBq2YFNTz
         CuDvFL13aMi8x735ip//wh2MnJNMDbhroTpJmqjDsqeICEfRvkyWk3I0prWeDOm6lzuL
         VNellUWhaQdXMLxl6gDJjsNBv3SZURT88tvz8xFEAwD2hfrjyvLlXHAxcEfXVgyP70XW
         9GCD96LFJ2pWTcD0jFlH6LEZdPedAZL2Q4hzlwchchUeQurHRe4cHiIi2DL7ivdvOjg5
         a0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fqd0G5c3meuQjfMyHlko63KaRK3xPjlAtCXxUflTNEk=;
        b=aW2WRW8zdWWjPBwdRDQ9N6NUP3x6GONI3y1wpVeZOzyjxH1JtajmkkNx168947wF/s
         T44INiAGxV1gkLgcE+6jKLG/XkryhUFgg0iSQE/BFcNi/rNPoJvy8xJAsZZRy4xPf7zp
         RZ6Suf08F2Hvhxl0SSY+ruM7lYIupA1NxcOJ5OjQ986tJVaMw919RVi8bTJ/UJoQVVEW
         sZU2JNcl2fOUhysxaDZwaQiDcuoYEZIqXerPwpSAKHhY48npn/OmV+qSRLIu5KbAppWh
         l9Q9gO6fYJIWuNMn+ObZ+SN0NM8yZOBpNlvpjYke6UVJgzDHbZ3WWBjDx9ZyacGEOEN8
         QU8w==
X-Gm-Message-State: ABuFfoh0+2ZgXU0NZnD2Ku7MzxducO4CUYsKpuAhfGnb8tooEahX7nI0
        CFZx7Y/1mdoJW62sfPEODLE=
X-Google-Smtp-Source: ACcGV61ZZaZ4iaEcEbvzuTfCcwu8j6+7VKeLn6bzjCAA0JnSHHrp3TUnaaaM43t5+hPneTCDkndC+w==
X-Received: by 2002:a1c:80d4:: with SMTP id b203-v6mr2793157wmd.100.1539222007284;
        Wed, 10 Oct 2018 18:40:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 204-v6sm18761727wmh.25.2018.10.10.18.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:40:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <20181010141841.GA17445@hank.intra.tgummerer.com>
Date:   Thu, 11 Oct 2018 10:40:05 +0900
In-Reply-To: <20181010141841.GA17445@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 10 Oct 2018 15:18:41 +0100")
Message-ID: <xmqqpnwhi7m2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> There was a v9 of this series [*1*], which hasn't been picked up yet.
> Was that intentional, or an oversight?

;-) Yes, I often miss patches that are buried in other discussions,
but this time, it was quite deliberate.  I saw comments that pointed
out at least one thing that needs to be fixed before the series can
move forward, so I skipped that iteration, anticipating another
round of update.

Also, I was waiting for [*3*] to be answered.

> I left some comments on that iteration.  Some were just style nits,
> but I think at least [*2*] should be addressed before we merge this
> down to master, not sure if any of my other comments apply to v8 as
> well.  I'm happy to send fixup patches, or a patches on top of
> this series for that and my other comments, should they apply to v8,
> or wait for Paul-Sebastian to send a re-roll.  What do you prefer?

The ideal from my point of view is to see responses to your comments
in the original thread (which is about 1300 messages ago in the list
archive by now) by Paul-Sebastian, possibly responded by you and/or
others, resulting in a concensus on what the right update for the
patches should be, finally followed by v10, which hopefully would be
the final one.

> [*1*]: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
> [*2*]: <20180930174848.GE2253@hank.intra.tgummerer.com>

[*3*] <xmqq8t3oksve.fsf@gitster-ct.c.googlers.com>
