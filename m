Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDCDA1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 09:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbeKGSck (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 13:32:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40932 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeKGScj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 13:32:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so16501244wre.7
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 01:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=am06lZXdjoXPxcsc8a4Iy0CpAi+u0bTR+OMObvVD4sU=;
        b=PljQMpnn4KUbid0ZRvGf3AVkNe3s55doiUVbunfzvBb9MqaeIhhcEBWPwkvN+zMBfw
         r+N88Y8CpJsIbNWaPgQLIyCeJzLSmAmuFXAloEdkg64aJgifdEk7lO7xkVQBxDI7zChH
         6Yil4L8XToxwDf9568KgIg0o7rwBxCFKJn0xcJyjmjqrkaJlX1j+siDuAatfoiTk9p2/
         ijWhV4VVePiG0CZQ7bIwnRnGfP+ev1Ah6jSYww+Qo5TKzAbLGn8qhPUerB3EL8lnTyNG
         GvHKraRm28C217ck7tB/XVUYwxwJ+ZBQVsu1NEJ9MDXenweMawTvytXXgUYnp/gwPR7S
         AvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=am06lZXdjoXPxcsc8a4Iy0CpAi+u0bTR+OMObvVD4sU=;
        b=pIMLS8/x1qgaVQiEUiqXkaf4+oNjZJ9Gfmcsu1aE4JbyMoziqPgqnj+F9CE7U+QXsM
         4CbhRg73RB7JKGh1jRA53NOWznhLGyXEBSBvlINCvfNG08lzd1nHt3+NypBYnaG77Whi
         LQ1imcl98nP1K3jWGs5MGkTQrtrnUMQvcp2ioQOyFRKMziJJgLVZWB8Ce6wRz1UxeDty
         JVE+hY86Kv6my0fO8FoFj6B1Yxx87yk8jEq77xs4qrHo6QCv2yVmMJDjRTiq3vPyUnzj
         XSt2QtZHjVmP0Qf0ePv3/Ny2mrE8KeApRqH8zajQFru4GObgv+RlTarIJu6t2LD6VZ9/
         3pVg==
X-Gm-Message-State: AGRZ1gIF43R72ArXG3FBbRaKNDAdhHpPhFqVKAqkSr4j2uQqMq7iJp3e
        2xej7Yi1u1bWKOg8MEEx5TR8HmcIibc=
X-Google-Smtp-Source: AJdET5dhNkvaSBnrGOWVM6JjRypbrfJAppunJpaaou+EiymC2lAdpd+qNKvYD7O/YhmImVVW94yzUw==
X-Received: by 2002:adf:8521:: with SMTP id 30-v6mr1000727wrh.284.1541581392279;
        Wed, 07 Nov 2018 01:03:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 82-v6sm672768wms.17.2018.11.07.01.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 01:03:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Windows: force-recompile git.res for differing architectures
References: <pull.67.git.gitgitgadget@gmail.com>
        <87794514ef3a83f95d81f89287b81aeed5c92296.1541516148.git.gitgitgadget@gmail.com>
        <c4e3790e-4c41-0d15-38d9-79fa288fb9b3@kdbg.org>
        <xmqqk1lpd65h.fsf@gitster-ct.c.googlers.com>
        <ad98ab16-c6bf-7294-f498-d0e7295105fc@kdbg.org>
Date:   Wed, 07 Nov 2018 18:03:10 +0900
In-Reply-To: <ad98ab16-c6bf-7294-f498-d0e7295105fc@kdbg.org> (Johannes Sixt's
        message of "Wed, 7 Nov 2018 07:55:38 +0100")
Message-ID: <xmqq36sdcl9t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 07.11.18 um 02:32 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> On Linux, when I recompile for a different architecture, CFLAGS would
>>> change, so I would have thought that GIT-CFLAGS were the natural
>>> choice for a dependency. Don't they change in this case on Windows,
>>> too?
>>
>> Depending on GIT-CFLAGS would have a better chance of being safe, I
>> guess, even though it can at times be overly safe, than GIT-PREFIX,
>> I suspect.  As a single user target in Makefile, which is only used
>> by Dscho, who intends to stick to /mingw(32|64)/ convention til the
>> end of time, I think the posted patch is OK, though.
>
> I think that it's not only Dscho who uses the target (my build
> environment, for example, is different from Dscho's and compiles
> git.res, too). But since the patch helps him most and doesn't hurt
> others, it is good to go. No objection from my side.

Yeah, that was phrased poorly.  What I meant was by "only by Dscho"
was "only by those who share the convention that GIT-PREFIX is
changed if and only if targetting a different arch".

Anyway, I just wanted to say that GIT-PREFIX may not be precise
enough but would give sufficient signal; GIT-CFLAGS may be a more
cautious choice, but it may change a bit too often ;-).
