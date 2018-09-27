Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32E7B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 23:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbeI1Ful (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 01:50:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36091 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeI1Ful (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 01:50:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so6583882edq.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 16:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=qHRBETw7n83hDW7jWHJbQ6wVRDHm0jIT+3fX8sX5LoI=;
        b=aDTchZv/JQA/jw8kh85GeRmhcWHij7/1L/lVJJQjXU1snPxetzRjCtrFQuGDug5RRJ
         ZWB8LFcoMIhU2MAazchxc5+2G95L+jesMuYV9ClqzPgbZZpdhVPxFvMW+FulRS6EFbcG
         BlJrZkuUYkfmwpuwq4pd4Do51HZoSCQQue6fSICOq4iAU3qH9omC3SvSTPAJs4lf3B3v
         mODIYdmiaasISsIG/A0G2iZEPlitdKRt/oUW5+dkrulaEGKpivvvdQpS1S/0NRpmPk4J
         bRVkWJkR9PFC1ml1rhUA9o4oNJHTS0YSq+4W+nbhgRv8wDuXALUPuggHt8G8SmAoHqiW
         OcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=qHRBETw7n83hDW7jWHJbQ6wVRDHm0jIT+3fX8sX5LoI=;
        b=RWd5cu0TjwEIx6uKZXgHNFiA8FYTbQYnF5vobnu8zFjOg3MMOn3bjhboIIxD2myDP/
         jl/rG/UAjIelThI7cRPFoGr4l/cH6J4tByFkj5Si6ZtoRkHJRmAGHuH+uDEJinlxPBue
         ZWzG18KTSu9T+TRdV6felQKswcKvxVY/FzkreWa/IdiB8WFna4UBvgwFjt6f3ml9Ijis
         nIMW8bMskNvt3uM0QJhWfGHBn6M3ajDBhfNu72TmzfC2vBzTNzSQ5bfjtnwO3/Mf32N/
         uIMiXXSwr/Ihko5+PzKY07SA222EiuBrkKqPk28F07nOBTEOhJOp0o45XcpG9MzSHGG1
         rUnA==
X-Gm-Message-State: ABuFfogtNjx+Qzw8B+eNT9KvpaM3lSe9jR0zDy9wvDwgiHUYK9zCR4da
        8msLx4YGh3oeGOWQS8bTa2g=
X-Google-Smtp-Source: ACcGV60IbOnYtT1BLLsGfSbPQq8QmhaeqmhnfFqjvlh+KrIya7cA7TYhYgbbHekBxhfFMoS9X/rItg==
X-Received: by 2002:a05:6402:6d8:: with SMTP id n24mr19895749edy.99.1538090993321;
        Thu, 27 Sep 2018 16:29:53 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id t44-v6sm1832719edd.96.2018.09.27.16.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 16:29:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] negotiator/skipping: parse commit before queueing
References: <20180927231929.180599-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927231929.180599-1-jonathantanmy@google.com>
Date:   Fri, 28 Sep 2018 01:29:51 +0200
Message-ID: <87lg7miknk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Jonathan Tan wrote:

> The skipping negotiator pushes entries onto the priority queue without
> ensuring that the commit is parsed, resulting in the entry ending up in
> the wrong position due to a lack of commit time. Fix this by parsing the
> commit whenever we push an entry onto the priority queue.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Thanks for the prompt fix!

> This was noticed by Aevar in [1]. With this fix, 163 "have" lines are
> produced instead of the 14002 reported in [1].
>
> I have included a test to demonstrate the issue, but I'm not sure if
> it's worth including it in the source tree.

The test fails before the patch, and passes after, and tests that we do
the right thing here. Seems best to include such tests whenever we can.
