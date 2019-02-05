Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C841F453
	for <e@80x24.org>; Tue,  5 Feb 2019 15:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfBEPQ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 10:16:28 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37325 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbfBEPQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 10:16:28 -0500
Received: by mail-ed1-f49.google.com with SMTP id h15so3144974edb.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QsRtIOP94ssqU4ku5/SISjzdQHTPSFgcEesWDJHg3Yo=;
        b=MjDPq6M6Tm+xf64K2yQT+YqjYttYP2Ku9YEs6FcIVJMxKL+5ks58w6RTnqEs/qzywj
         v+JXfEMtSyyKWYWNBMIgEBKajZ04Iyz+KJCHYBXJ7XU5R4PsScD3BaEbd3Qvpoxhy53G
         Udo01P7r5k50HeWlMfj8o3DG08u/BlKVZXRMY7KJowI7Bc0+aymL/Wvq3hLMmB/icDIu
         Z33aaX435JtLuVJ3fQGmErKcTjqw9v2tpW+lNtfOTwpF6aBoNSJ1lOgEXTwaEoH/TcDQ
         B/hV5yFxNJPakIx60tXGLXuSzVjWPGvB5lhkaB0LMPUKk7NvFIxTx8o9qEHMfwYnjHto
         ZqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QsRtIOP94ssqU4ku5/SISjzdQHTPSFgcEesWDJHg3Yo=;
        b=SQBcleGNWFryTCY3VKpfeYfj8Wiwmu4g4IBdYRfNGRIKLJr4SG+3vIjIhR6B8UUH5U
         qrN5X9y645A/yF4gjZPP9ubDWZnhSD971154eBzbKBRENPhp6f5xu/u+LG3xqxmxzB7d
         2ariW7QWLQKOiM48dU2/mdH6mmk6XFsALn5l21zWAgn3vUB3+ojs3bG35zviMvIN/kVc
         m2p/e/z+7QT6JHsyDAmt9wdlf3s8fI6dZw5RwjJL2/XpS/sHEr1tkiFLvwBD42Rnyd9L
         P6+O4o1eCHToSMftIwVzGZXgpJwLf4G/KqRjQfuDrhHk8RuDvAvS2n0UZGXNv8ON/X83
         nOOA==
X-Gm-Message-State: AHQUAuaEKdHWsBptbtuyHHV3826Ent9qPwFG3j0xnDSN0ZBwbGbatuiQ
        1wsZNZETWoG5fYUnCv9t/j78Q4hNl80=
X-Google-Smtp-Source: AHgI3Iaxtmk1LSxvEBONqyH7lhLpVp+NkC4LPKMNEbwqEbI8+eU4PJdbwu2FJXukku3hcxMRQ39lig==
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr4286660eds.266.1549379786681;
        Tue, 05 Feb 2019 07:16:26 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n13sm2176151eju.30.2019.02.05.07.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 07:16:25 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dani Koretsky <Dani@cybereason.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG]: git checkout on a new tag with current HEAD shows "head detached" at previous tag
References: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CANcfovV3Pq3pubtNq4HCSZOJ5OC9dVSm+19VkOiQimAH+fttYw@mail.gmail.com>
Date:   Tue, 05 Feb 2019 16:16:24 +0100
Message-ID: <87munal0zb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 05 2019, Dani Koretsky wrote:

> I have 2 tags such as release-17.6.230 and release-17.6.220:
> If I'm changing commits, all works as expected.
>
> If however both are pointing to the same commit, the output is as follows:
>
> git checkout release-17.6.220
> git status
> HEAD detached at release-17.6.220
>
> now if I run:
> git checkout release-17.6.230
> git status
> HEAD detached at release-17.6.220
>
> Which is theoretically correct, but I'd expect after checking out a
> certain tag I'd be see that specific tag...
>
> Sorry if this is intended behavior, I couldn't find clear mention of
> this behavior on the git checkout documentation online..
>
> Let me know if I can help in anyway.

You're right about this issue. I haven't dug deep into this, but just
enough to see why this is. When we "git checkout" something we write to
the reflog that we moved to such-and-such a ref, we then consult the
reflog when you run "git status" to see what we detached the HEAD from.

As you can see if you run "git reflog" after you check out the first and
second tag, that entry doesn't change, and we still note just the first
tag you checked out.

This is going to be because of a short-circuit behavior where we see "oh
we already checked this out".

Maybe that needs to be fixed as a bug, but would have more implications,
i.e. are there cases where you can flip-flop and end up spamming the
reflog, should the post-checkout hook run or not in those cases, etc.
