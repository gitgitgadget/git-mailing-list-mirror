Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87601F404
	for <e@80x24.org>; Thu, 22 Feb 2018 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBVVYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 16:24:07 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43955 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeBVVYG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 16:24:06 -0500
Received: by mail-pl0-f65.google.com with SMTP id f23so3618176plr.10
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yNh4/3WnWoDRweeuUE7sFxnn/UzCwlHFaF9k9O53e6U=;
        b=vCYnQpIfsI+PioTZwIkUa39aqySH8gEBRDMOhQaDGODV9uDkT/KySvwfIm2yMKYFaf
         RPUpTJrR8Qw0Al8WPNvZGXT2ZIepfSTI8ZNpT+JlAY3LqOyBO50KOM9Hgsrz/JbaNtfw
         Xyo2SzOlp7b2+BPxdax0MzjpZSjE38GE3I3qoM/eS+0TNtOVSQOQ+J5OZi3le6wnO40Z
         AR6GegkQawXydEsCbfhdG5E9vEXe9VQrQMQ7rdkYnzJul2OTy4SNVcCHyRv+2I9WENVG
         t+rRLZiUXuinXc0X3v02YsUgu+SsBowXlkkH971wbPpts0dVBsd1Q7i5AhuSZDDmUIZk
         +uXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yNh4/3WnWoDRweeuUE7sFxnn/UzCwlHFaF9k9O53e6U=;
        b=Wu7daVxhdohpsd4FGKnDz2iBaPlPRK7XuwiHmTgeD3q2TgHvyu27BEes4S1grJvMEB
         vaFgoSEC/r6YWY3i/JWmzYGMIpnoaB73yTEut1HQlItjhhBgncQPfqcWDYHt27RqmbIs
         si7tug+DtatBj12S6RtndCWdkwPp9zTJBO0qS+o8szXX82qpOTScDtRUctMVdN113Kz4
         XJiHuLc2TKt3NG3lG4YKYD6ckRZ4fMP2VDQRZgxpfF18cKGFISr2KpCnVJAJCiRAsUhb
         RJG5/aVP8qC8GCHSjpgjctuckNbSgd90JdtkfOsLBxLmI7RQL0lERjlR23/fIqwWmKj7
         awLA==
X-Gm-Message-State: APf1xPDQv+9E96tCJLnVMtjKgNQZno0Jun6KRUXHyaFbI194BMF9k07/
        fiVWz+M4r44ano8rs/4sJXo=
X-Google-Smtp-Source: AH8x227gbHmt+n3sxpau/dygsp0RUxTogBJ+ULDK1mcdOggIZEi3ml3uTGNnmkxkGQ5qWFrdSg51fA==
X-Received: by 2002:a17:902:7614:: with SMTP id k20-v6mr7834855pll.343.1519334645416;
        Thu, 22 Feb 2018 13:24:05 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w22sm1131535pge.65.2018.02.22.13.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 13:24:04 -0800 (PST)
Date:   Thu, 22 Feb 2018 13:24:02 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222212402.GB256918@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222201940.GB23561@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Thu, Feb 22, 2018 at 11:38:14AM -0800, Jonathan Nieder wrote:

>> To be clear, which of the following are you (most) worried about?
>>
>>  1. being invoked with --help and spawning a pager
>>  2. receiving and acting on options between 'git' and 'upload-pack'
>>  3. repository discovery
>>  4. pager config
>>  5. alias discovery
>>  6. increased code surface / unknown threats
>
> My immediate concern is (4).

Thanks for clarifying.

>                              But my greater concern is that people who
> work on git.c should not have to worry about accidentally violating this
> principle when they add a new feature or config option.

That sounds like a combination of (6) and insufficient documentation
or tests.  Ideas for how we can help prevent such accidents?

> In other words, it seems like an accident waiting to happen. I'd be more
> amenable to it if there was some compelling reason for it to be a
> builtin, but I don't see one listed in the commit message. I see only
> "let's make it easier to share the code", which AFAICT is equally served
> by just lib-ifying the code and calling it from the standalone
> upload-pack.c.

If we have so little control of the common code used by git commands
that could be invoked by a remote user, I think we're in trouble
already.  I don't think being a builtin vs not makes that
significantly different, since there are plenty of builtins that can
be triggered by remote users.  Further, if we have so little control
over the security properties of git.c, what hope do we have of making
the rest of libgit.a usable in secure code?

In other words, having to pay more attention to the git wrapper from a
security pov actually feels to me like a *good* thing.  The git
wrapper is the entry point to almost all git commands.  If it is an
accident waiting to happen, then anything that calls git commands is
already an accident waiting to happen.  So how can we make it not an
accident waiting to happen? :)

>> Although in most setups the user does not control the config files on
>> a server, item (4) looks like a real issue worth solving.  I think we
>> should introduce a flag to skip looking for pager config.  We could
>> use it for receive-pack, too.
>
> There's not much point for receive-pack. It respects hooks, so any
> security ship has already sailed there.

Yet there are plenty of cases where people who can push are not
supposed to have root privilege.  I am not worried about hooks
specifically (although the changes described at [1] might help and I
still plan to work on those) but I am worried about e.g. commandline
injection issues.  I don't think we can treat receive-pack as out of
scope.

And to be clear, I don't think you were saying receive-pack *is* out
of scope.  But you seem to be trying to draw some boundary, where I
only see something fuzzier (e.g. if a bug only applies to
receive-pack, then that certainly decreases its impact, but it doesn't
make the impact go away).

Thanks,
Jonathan

[1] https://public-inbox.org/git/20171002234517.GV19555@aiede.mtv.corp.google.com/
