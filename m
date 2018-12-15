Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871B71F405
	for <e@80x24.org>; Sat, 15 Dec 2018 19:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeLOTxk (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 14:53:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46311 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeLOTxk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 14:53:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so7592776edt.13
        for <git@vger.kernel.org>; Sat, 15 Dec 2018 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=syvnEJjzMYX5a99uKrjVYLJDki9vJCKGYd5ip9o0cGA=;
        b=YF4/Ldem9V8BUq5+/QsFyu5eyEE5lCH/N2K5FSZniHPD1ZXlQdcPWhj+iG7G4Oaf40
         KZVrN4qYyGDbOCtxymYrUcqW468zagbdvV3pWjqryybNeiTLmcREO/iovcvv/iyyWf5i
         vWpWrKi6R/981ZupxTromOb38Q2FE9yYQ3BlS1WXGlGinIVMwKo0sQeqyfpiSmMVAFXb
         6EVuaDXn/D9kyvhdrCXu0MbpfL8v1V4WsacnF6/tzucXzWuJu7MioebqLp5hOSdD/P0g
         5hB/PowyKgSXiB/uZz/yC94LueHzXkmzgvK/vz7TZF+QFPceAWn8S8uW0k/1bfS0aGeo
         U2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=syvnEJjzMYX5a99uKrjVYLJDki9vJCKGYd5ip9o0cGA=;
        b=bETf7QVw+hM9uXYnOkXLS5hk7HtagF5nwnnAK1o7nuXVNzEOzLLfTQffKdgu/S3VQa
         wl9i00CaGZYGSKz3xBvNDzeawCDeTYlVcDyRRklhMKU9wOds6XLJuQpBpArPLcumr+am
         mmcpGawSYXQUPfFm8Xo/sRQFpYt71jdoKsWK7D8t/NJoMoP9nxCuNizs2sz6Ln7CnL1E
         rVL7Gg81LXAYh4NQe/bcvM97m1Jy7uy15FGHXpFoM4KdHNIY4jAMm9TccM4dPmigPbF6
         0HR7UCcnDWpAsEyXVotPA0Pz7Dqq/RWXdO0Hxf6N6cXN+MdIrv0yLIYw4nAM07M5Hxai
         T9yw==
X-Gm-Message-State: AA+aEWYBKrtqiOUhQzc96sSN+eU7P+n2UCoir3QmmSW3KBzETZiLCA1/
        zhocPhmV7ktaIExcg2EShl2T02/Q
X-Google-Smtp-Source: AFSGD/Xi/3P0AffZQadGIdz3TkdaXpmQouT/1XLoFx30xDc6uWWJKRp27widipl9Q9sFnW0Esvofqw==
X-Received: by 2002:a50:e3cb:: with SMTP id c11mr7575644edm.80.1544903617473;
        Sat, 15 Dec 2018 11:53:37 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id t18-v6sm1274264ejz.9.2018.12.15.11.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 11:53:36 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        bwilliamseng@gmail.com
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
References: <20181211104236.GA6899@sigill.intra.peff.net> <20181213195305.249059-1-jonathantanmy@google.com> <20181214083507.GB11777@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181214083507.GB11777@sigill.intra.peff.net>
Date:   Sat, 15 Dec 2018 20:53:35 +0100
Message-ID: <87d0q21s8w.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Jeff King wrote:

> On Thu, Dec 13, 2018 at 11:53:05AM -0800, Jonathan Tan wrote:
>
>> >     I don't know if there's a good solution. I tried running the whole
>> >     test suite with v2 as the default. It does find this bug, but it has
>> >     a bunch of other problems (notably fetch-pack won't run as v2, but
>> >     some other tests I think also depend on v0's reachability rules,
>> >     which v2 is documented not to enforce).
>>
>> I think Aevar's patches (sent after you wrote this) is a good start, and
>> I have started looking at it too.
>
> Yeah, I'm excited to see it working with fetch-pack, as the current
> behavior is to complain if you've tried to enable v2 config:
>
>   $ git config protocol.version 2
>   $ git fetch-pack git://github.com/git/git
>   fatal: support for protocol v2 not implemented yet
>
> I haven't actually run into it in the real world, but somebody might if
> they have scripted around fetch-pack and are experimenting with v2. A
> much friendlier behavior would be falling back to v1, but actually
> supporting v2 is better still. :)
>
>> >   - The "serve" command is funky, because it has no concept of whether
>> >     the "ls-refs" is for fetching or pushing. Is git-serve even a thing
>> >     that we want to support going forward?  I know part of the original
>> >     v2 conception was that one would be able to just connect to
>> >     "git-serve" and do a number of operations. But in practice the v2
>> >     probing requires saying "I'd like to git-upload-pack, and v2 if you
>> >     please". So no client ever calls git-serve.
>> >
>> >     Is this something we plan to eventually move to? Or can it be
>> >     considered a funny vestige of the development? In the latter case, I
>> >     think we should consider removing it.
>>
>> Personally, I lean towards removing it, but there are arguments on both
>> sides. In particular, removing "serve" means that both developers and
>> users of Git need not be concerned with a 3rd endpoint, but preserving
>> "serve" (and planning to migrate away from "upload-pack" and
>> "receive-pack") means that we will only have one endpoint, eliminating
>> confusion about which endpoint to use when making certain requests (when
>> we add requests other than "fetch" and "push").
>
> Yeah, at first glance I like the simplicity of a unified model. But the
> separate fetch/push endpoints have been useful in the past. Separate
> uploadpack/receive.hiderefs that I dealt with here are one form. Another
> is that many people do HTTP access control using the endpoints. For
> example, if I have a repo which is public-read and private-write, the
> config we recommend in git-http-backend(1) is to lock down the
> receive-pack access using webserver config.
>
> If all the webserver sees is "somebody wants to connect to git-serve",
> it doesn't know if it should be challenging them for authentication or
> not. It would have to start peeking into the git-serve conversation to
> see what the client actually wants to do. That's _possible_ to do, but
> it gets pretty awkward with existing webserver tools (whereas matching
> the URI endpoint is pretty easy).
>
> Ditto for locked down ssh sessions like git-shell (or custom solutions
> like gitolite). Right now we can "git-upload-pack is OK on this repo,
> git-receive-pack is not". But blindly running "git serve" would be
> dangerous. In this case I think we have a few more options, because the
> user has always already authenticated. So we can just tell "git serve"
> via the environment whether the user is authorized for push. It's harder
> with HTTP because most setups avoid even challenging for auth unless
> it's necessary.
>
> So I'm a bit worried that the unified endpoint model is going to be a
> dead end, at which point carrying around git-serve just makes things
> more complicated.

This is from wetware memory of something discussed at a previous Git
Merge, so I may have (inadvertently) made it up, but wasn't part of the
idea of "git-serve" to have an extensible next-gen protocol where we
could add new actions & verbs unrelated to sending or receiving packs?

E.g. client<->server optimistic cooperation like offloading a
long-running "git-grep", "git log -G" etc. to a more powerful workhorse
server, which would use "git-serve" as a routing layer.

Of course that's not in itself an argument for having a general "serve"
command, actually the opposite for the reasons you mention with locking
down things. E.g. maybe I want to support server-side git-grep on my
server, but not git-log, and if it's one command it becomes a hassle to
do that via SSH config or HTTPD config for the reasons you mention.

The upside would be that once a host understands "git serve" I'm more
likely to be able to get past whatever middle layer there is between my
client and the "git" binary on the other side. E.g. if I have a newly
compiled "git" client/server binary, but something like GitLab's
"gitaly" sitting between the two of us.
