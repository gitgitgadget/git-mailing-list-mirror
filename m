Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8D971F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGZSP0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:15:26 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44125 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732155AbeGZSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:15:26 -0400
Received: by mail-wr1-f54.google.com with SMTP id r16-v6so2390530wrt.11
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=el9CyyJ1oCw744xQdEAAF9kenrZsDc/UJCKxJwd2Ddg=;
        b=I1wGgL7azfOk5Fd84N5a1sBEvZDQ2R+kcZoI6vGiPVGvalBVnzBzYCfHP+pGCrU218
         +GSgCY3Wj+w0pz99kU+B+etOMvQia+Zj706fCt1r506iZd1TzeLoNBbLmKOdmpRwFUaH
         SA1/02o1PidtENNMZtkmRV/wYYjzIIeKwXvIi4lwjBchTTw7UTbYisj9S1V5R0AuOgm/
         So97P40Vo88tA/ZAKjevsD9JOGJ+yA2QApC+RtsZ2WbhGYXl1DSHhc/0Fm4bXOyLSxZ0
         A58AvNchyk0OupD9bDxNlNX0T2GzrixWc4O+TYA9o/KWxzFeG+Fh/UJtFHZk7mLKKyVJ
         WopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=el9CyyJ1oCw744xQdEAAF9kenrZsDc/UJCKxJwd2Ddg=;
        b=fW1QjJJr8kF+/CQrYoJnHl44eh4ipyedJzV0YG60wDJaic89r9etQAXL8T6DvnGSr1
         WLj/2x50MGOvnBHAzaiowqe4haLz7FVpLSs43YGlMFi9rdgoQxvUS5FU67p/Vjzqf3SR
         dP46kLiLDcSjH3U7ihytPuCWAnKlkxCvUeimfd8UnJWK5QRYIlZVOWEWJNycRU8truzA
         kF0bqKBr7o0eSLq2Pfm9SkCZlXRDfTVfeBKKScPzxMXOxKNJMyBd23W5holEfUtERnaF
         Ff3pAQfUGS7PJUM0flMZxD80YPTskpS2fWGvYb/xLWa3sPSye4Gzdk6VK+6h9r8pbgWv
         Erkg==
X-Gm-Message-State: AOUpUlGCCNB4NuphIxqXuysWZLqUDHQhZkrReeJ1wQN/v57ey7oEH4zk
        ROkfvIBfQatZlFqlmBIoGvw4kvuW
X-Google-Smtp-Source: AAOMgpdggG5OO+K6uT72DpjFh+9lWE9zZRtgGOge1/meEKRV3uPzpMbleVtuNbNcRG/7zJnKmk8kIA==
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr2321154wri.139.1532624263689;
        Thu, 26 Jul 2018 09:57:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k3-v6sm2593393wme.44.2018.07.26.09.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:57:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <20180726072429.GA7625@sigill.intra.peff.net>
Date:   Thu, 26 Jul 2018 09:57:42 -0700
In-Reply-To: <20180726072429.GA7625@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 26 Jul 2018 03:24:29 -0400")
Message-ID: <xmqqlg9yq6ih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 25, 2018 at 03:13:37PM -0700, Junio C Hamano wrote:
>
>> * jk/banned-function (2018-07-24) 5 commits
>>  - banned.h: mark strncpy() as banned
>>  - banned.h: mark sprintf() as banned
>>  - banned.h: mark strcat() as banned
>>  - automatically ban strcpy()
>>  - Merge branch 'sb/blame-color' into jk/banned-function
>> 
>>  It is too easy to misuse system API functions such as strcat();
>>  these selected functions are now forbidden in this codebase and
>>  will cause a compilation failure.
>> 
>>  Will merge to 'next'.
>
> Eric nudged me over the fence to use a slightly different mechanism to
> generate the error. See:
>
>   https://public-inbox.org/git/20180726072105.GA6057@sigill.intra.peff.net/
>
> It looks like sb/blame-color graduated, so this could also just be
> applied directly on master now to avoid the funky merge.

OK.  Is it that "you cannot call a variable" thing?
