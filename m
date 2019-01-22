Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1E001F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfAVSOG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:14:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50352 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:14:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so15183843wmd.0
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1hfCl1C7a9WUq8hB6m9BFw157TxDvBLhKygemCvqh5g=;
        b=bABLuDRPJhvZGK/xeTbDtnKYXkLHXHBb32JQtpUHwcHO4uGU+cU8Ri2cLlVamIAUGy
         SgwW6CqyOLT80iAfA6xHtPROmHSfF1fxPaXVBT7faXshj62AQbFcMQCSt4U40J92UUUe
         UMUsFmfKYakm2XmiyKX5Z1vOy0/XzWdtg0oSemvCnAILhAz8Tg99Ap7+zfGT5A7BXJL3
         Fd9XJpeWzJh+FOc1Yct4zsltlxlxWTRafxTU7x/kC2EMpQq2UxTA019W1Kz75G9vLgma
         GPwJxkSQWRbaX2bnUfyUttWWd+lBJ/k65xEqtqzGBi6ICyJP/MTaLYZv0O30hLb2aVdI
         maPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1hfCl1C7a9WUq8hB6m9BFw157TxDvBLhKygemCvqh5g=;
        b=B5SXdAb353fYOJ8cdDdX4dB/UVEymHzj7nBi/30vwI8UpaOvz/4t+gXiL4GHJ1axZB
         IonXR9FNqz9DbMGDZWS8V+COu8Ii/P/JC33iexyntQM8wGJ0LSd5LwUIuGvXfAMbqJjx
         3J60iSqbn6z63zyuFJqn1P5nCkATGOxCb5a/AsIM6pKKR7THTQpZ9L0lKltGFWJrLv3B
         PL5sc+MjxlQPiMuYlpcs+0o6J/mN98Pmxdn6eAh6hwho8Gjtv7ei4fnob+XlhjTc/UA4
         UeIkiQ5+3eST0E7qHflM9BDZAIFycTjmq4xWierOtDbO7hYuAIvuXiqRfiajGjg8Wwz9
         DGGg==
X-Gm-Message-State: AJcUukcbINdQHnEzFqytxQ7nULLZwm12SBH5C4excJrriPeUgC8ku2yX
        qimKQTbsMlLb/pGbr3biNLw=
X-Google-Smtp-Source: ALg8bN7bCnRUBTzyRyems/+edqs1LYbpluXq89YiAzcCKDxKWOaiITW1+RIbmpPZJZbiUz1x971g+A==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr4557785wmm.116.1548180843491;
        Tue, 22 Jan 2019 10:14:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t12sm95333364wrr.65.2019.01.22.10.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:14:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Barret Rhoden <brho@google.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and their changes
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
Date:   Tue, 22 Jan 2019 10:14:02 -0800
In-Reply-To: <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 20 Jan 2019 19:19:32 +0100")
Message-ID: <xmqqlg3ch85x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 17.01.2019 um 21:29 schrieb Barret Rhoden:
>> The blame_entry will get passed up the tree until we find a commit that
>> has a diff chunk that affects those lines.  If an ignored commit added
>> more lines than it removed, the blame will fall on a commit that made a
>> change nearby.  There is no general solution here, just a best-effort
>> approach.  For a trivial example, consider ignoring this commit:
>>
>> Z: "Adding Lines"
>>  foo
>> +No commit
>> +ever touched
>> +these lines
>>  bar
>
> Wouldn't it make more sense to assign such lines to unknown, perhaps
> represented by an all-zero commit ID, instead of blaming a semi-random
> bystander?

I share the sentiment.

Isn't it, however, showing a bigger problem in the "feature"?

Your "a change that adds lines without removing any" is an obvious
case where these added lines have no corresponding lines in the
preimage, but most of the time it is unclear what line corresponds
to what previous line.  If a commit being "ignored" brought a change
like this:

     1
    -four
    -three
    +3
    +4
     5

did "+3" come from "-three"?

Or did "+4" (read: "added '4'") come from "-three" (read: "removed
'three'")?  Did it come from "-four"?  Or was it genuinely added by
that ignored commit?  Your suggestion deals with the case where we
decide that "+4" had no corresponding lines in the preimage (and
paint it as "no blame can be assigned").  But when we decide that
"+4" came from "-four" or "-three", we continue drilling down from
that ignored commit and assign the blame to either the commit that
introduced "four" or the commit that introduced "three", which would
obviously give us different result.  Worse yet, if a reader expected
us to consider "+4" came from "-four" at that ignored commit, but
the algorithm decided that "+4" corresponded to "-three", when we
show the commit that eventually gets blamed for that line that has
"4" has no "four" (it has "three"), which I suspect would confuse
the reader of the output.

So... I dunno.


