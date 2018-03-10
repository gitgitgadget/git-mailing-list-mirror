Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A91151F404
	for <e@80x24.org>; Sat, 10 Mar 2018 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeCJM2f (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 07:28:35 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51713 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeCJM2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 07:28:34 -0500
Received: by mail-wm0-f52.google.com with SMTP id h21so8418618wmd.1
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 04:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=GlXbO/pk2trmtFuRsJrNi0wtfXHIPYdX7xjQmCD8XoE=;
        b=pieSQOioSVpnbgj0235zF3yRYqtNQFHUtiohpZIccdVeFJ8jPS98sHzJPWkX7KcOgO
         bJFJCgPx59udNNV+FeOGEvWHJnrH8weavGqBuzP/S/AKA/Nse6QNoYX21EhMs15kINl4
         8uFTAhn16jr5mwo+lQRlmuplkU2wzJs2vVwD4qCW9U2AGI5qeecW08XbODPtYQ6bdk2l
         tt7XUpOyEyHb6vrMAtOUlHL+RxEtcd4jRgIBuNPVfzJRWvhntRN/NaMbB++9WsJN3bsl
         b6kB9dvCkYltjhMVYrS2TDqM+jNLr5isPJZ41D0qacyrqHsVxQSO9zeYolv1OJQzpoY9
         /FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=GlXbO/pk2trmtFuRsJrNi0wtfXHIPYdX7xjQmCD8XoE=;
        b=j/JtQsM8uaiTDkqnZzbkSf0i+SGcdXgCVPiKtQVA5nt3gST78f6BicVJOFYbnjO46E
         bMi/WnZ1J5YgIL+u/0LwPdgokGCoVm9ATQp8mywc/dEMmjUEU7L9Wld9ej+qVY4NJc5h
         lHBnrLoZ01/FI4CLZ0SphSEOEmKyvEPHfpgtMC5dS83/7xZ+AfWmsQ0+ao6S3KXWiTXY
         VrnU1DGhRPMthruVQFlHs/qx7fJhv0fFJQQ7+oOb88UK0RwZSqP1FoyyGgakI/u9MVmy
         c9VsjAx2/V9Xng/en0m4C7x3pVx4dFudlYJ64gl8DgpXFHmYooUwW1p6GicCB15hHqgh
         /g5Q==
X-Gm-Message-State: AElRT7G0ek1ENGdrBFd/aIyXHFbGx1Bzo8ZshALE6vvtzUkQYpmJw8gk
        OG9SXQkabwI5PE0eA6d9yiU=
X-Google-Smtp-Source: AG47ELtUU1UnkpGfi3gCBrzVMWQDQzvk4XO8+qwaMjJP8sovpKknJHaPJPhq3zUOQcuEoxXGD6J+sA==
X-Received: by 10.80.184.77 with SMTP id k13mr2780529ede.31.1520684913497;
        Sat, 10 Mar 2018 04:28:33 -0800 (PST)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id z17sm3137462edz.35.2018.03.10.04.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 10 Mar 2018 04:28:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: Improve `git log -L` functionality
References: <2051651520351198@web40j.yandex.ru> <3857311520679275@web8j.yandex.ru>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <3857311520679275@web8j.yandex.ru>
Date:   Sat, 10 Mar 2018 13:28:30 +0100
Message-ID: <87fu58qfm9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 10 2018, KES jotted:

> uh... seems nobody is interested in this functionality (

I'm interested in this, and would review a patch to implement this.

Generally speaking when you send a "wouldn't it be neat if..." message
to the Git mailing list a lot of people read it (including myself at the
time), but don't find it useful to add anything to it.

Sure, this feature as described would be neat if it existed, but without
a patch there's not much to discuss.

In particular the trade-offs of teaching the log machinery to somehow
stitch together the worktree state without the user somehow getting the
state into a tree may not be worth it, or it may be. We'd have to have a
working patch to see.

So if you're interested in working on this don't let the seeming lack of
interest discourage you.

> 06.03.2018, 17:46, "KES" <kes-kes@yandex.ru>:
>> Hi.
>> I want to `Trace the evolution of the line range`.
>> And not committed change is sort of evolution and should be taken into account by -L option.
>>
>> Currently I MUST `stash save` change,
>> look actual line number,
>> trace evolution,
>> `stash pop` to bring back current change.
>>
>> EXPECTED:
>> Allow to use those line numbers which I see in my editor
>> without excess `stash save/stash pop` commands
>>
>> If file has not committed change then this change maybe shown by `-L` as commit NOT COMMITTED YET
>> If file staged 'commit STAGED'
>>
>> More description what is comming on:
>> https://stackoverflow.com/q/49130112/4632019
