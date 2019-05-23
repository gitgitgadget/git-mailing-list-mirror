Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA1C1F462
	for <e@80x24.org>; Thu, 23 May 2019 00:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfEWAXt (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:23:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32922 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfEWAXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:23:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so5858838wme.0
        for <git@vger.kernel.org>; Wed, 22 May 2019 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8Z3Eml8upLbrxr94pKfGZW7ehGnLyEha3uoenvgcKQo=;
        b=hdEsbtvyWSZZRlu7dEV3qD2ectb57PVGOWBCdp/9vfI0oVqYL0wrVqJ/fd7MQe8h4R
         J4ASouMHLhytFiVKFTedMv/5HKN/HaJfoGPRE57KSg0AUBAEWqMxguz66pKhpLuZVMmA
         uNjx6ju684135cXjZXYFnb8xozLKj9tweVQ2mehCUGF8Nm4TXbPmFoLRxVKFM6ybqPBj
         +Dt+sxFIsNuMojN3CwrM62376mUAmcDJdUxRMZK5uajmY8x7tXwD5zZPaxjzlJLShX8K
         bOQUbMK0W+ocUn9a2yA8SUSgkDgdmJuyX36XRFbo9QU2J0pyQTFOIk2qTNLSiHaLjeqo
         OSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8Z3Eml8upLbrxr94pKfGZW7ehGnLyEha3uoenvgcKQo=;
        b=SNU3KeK8ll8EG+MrzdISTIrWpmXvao95wN1XKJ4nTl9l0eXrXgJqRaHMtFIKKnILFf
         l3bYll89e+32dEq9rxGKpC0dDcJSJlgW+wVLe7cseAeupftvdHE1gYmwesD1h7pXbHma
         3HByaFq9NtsfD2a3FvH9IFEpy7bN2UmBqe4BnFiGXzojF9+tCuI6G0peuBlAr9RgIXOm
         jhPY2opy8u2xopmJQjCbtZLBxrO7iPN72VOiFlV4VhdulBiN0F59XMgFqlb9xUuQaWzT
         oABXZmXiQRen+5VVbdftVU37osiCrDf49eY14p5wev6lm8RRDecSHYbnZhKdwwu4RyY6
         tH+w==
X-Gm-Message-State: APjAAAW9N7Wzx8jmtzH6ovrm/n6VeiGbinXEwbWC2Znm/p8vfkjc8kzE
        wY5ZTbHmAtcefXtN0pRtFfY=
X-Google-Smtp-Source: APXvYqxYGWTiVUkmMgWQx0DzVQij4Cb7KAr7DzC8NJsInLWFoafVTo9LuHRPF8whIiTmYM2LlPyz+Q==
X-Received: by 2002:a1c:a7cc:: with SMTP id q195mr9668217wme.53.1558571027018;
        Wed, 22 May 2019 17:23:47 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x6sm39052836wru.36.2019.05.22.17.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 17:23:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Maksim Odnoletkov <odnoletkov@mail.ru>
Cc:     gitster@pobox.com, git@vger.kernel.org, keithbsmiley@gmail.com
Subject: Re: [PATCH] Make stashing nothing exit 1
References: <xmqqh8bsphny.fsf@gitster-ct.c.googlers.com> <20190522235705.68452-1-odnoletkov@mail.ru>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190522235705.68452-1-odnoletkov@mail.ru>
Date:   Thu, 23 May 2019 02:23:44 +0200
Message-ID: <871s0quigf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 23 2019, Maksim Odnoletkov wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Keith Smiley <keithbsmiley@gmail.com> writes:
>>
>> > In the case there are no files to stash, but the user asked to stash, we
>> > should exit 1 since the stashing failed.
>> > ---
>>
>> Sorry, but I fail to see why this is a good change.  Did you have
>> some script that wanted the exit code from "git stash" to indicate
>> if it had anything to stash and change the behaviour based on it?
>>
>> Is it a big enough hassle to figure out if the "stash" command did
>> something yourself that justifies forcing existing scripts that rely
>> on "no-op is merely a normal exit" behaviour other people have
>> written in the past several years?
>
> The problem with current behaviour is it makes it hard to use stash in
> scripts. A natural stash use case is: wrap some operation requiring a
> clean working tree with a stash push-pop pair. But that doesn't work
> properly when working tree is already clean - push silently does nothing
> and following pop becomes unbalanced. You have to keep that in mind and
> work around with something like:
>
> if ! git diff-index --exit-code --quiet HEAD
> then
> 	git stash push
> 	trap 'git stash pop' EXIT
> fi
>
> With this change this can be simplified to:
>
> git stash push && trap 'git stash pop' EXIT
>
> I don't mind keeping this new behaviour behind an option for
> compatibility. Or alternatively resolve this use case by supporting
> --allow-empty in stash-push. But my feeling is it is natural for 'git
> stash push' to report error for no-op case because the command is
> explicitly about creating new stash entries. A close analogy is 'git
> commit' which errors on no-op. Contrary all commands treating no-op as a
> success I'm aware of are not about creating new objects but about
> querying or syncing.

I view "stash push" more like just "push", or even a special case for
"reset --hard", in both of those cases we don't exit non-zero if there's
nothing to do, i.e. if there's nothing to push, or if "reset --hard"
ends up needing to do nothing.

On the other hand as you point out it can also be viewed as "create new
stash entry", just like "create new commit", and we error out on that.

In practice I bet there's very few scripters of "git commit" that don't
want to actually create a commit, whereas "stash push" is more likely to
be used like "reset --hard", i.e. just "wipe/save-wipe changes if
needed".

I don't mind an --exit-code for it, or even a change in the default
behavior, just pointing out that it's a bit more nuanced than just a
missing exit code, given "push", "reset" etc. prior art.
