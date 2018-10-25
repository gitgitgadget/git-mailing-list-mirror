Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC1B1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeJYMsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 08:48:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35625 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJYMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 08:48:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id w5-v6so7738084wrt.2
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=45YQf1c3petik5CdiZ862JuP0B3Ka3HIl005AV4Bs0s=;
        b=oGZpeUNZarmnn7iZig8P1lVDHTeB5QK3PPgrJoOlM2F2uIufpsDO5pWEtHp+7gEY9t
         9L831TXfP6bjieWUz7z9pxwxY4YXnFpXejUsSL+mYQ/c/yb9PKLrpQQZ1k/WTMzzKbaC
         ROiSHPRfyLBnv71SvFH4UfP4kHpaG+0xQe3MRsBx6/xWJ4rohK73QylCNjdo4YPvVvve
         d6B/I9uLMBjTfqEDEDmJVfx6lmqaSSiHjxDVQnKRuaWtmH1tMs0/WU4nHwa2iwf+1pW3
         gfV2ytW/wpu16gEtpq1lWDG1MuirW6f8nxQOZ7v8sNTv2nEQkfqTlx1GRyPOOSz4B0T+
         vMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=45YQf1c3petik5CdiZ862JuP0B3Ka3HIl005AV4Bs0s=;
        b=bpHCcArZr2jIl3Hg12u58WDCopPUw/vMhaKQ8r6B7K+3LMHocrBUyVU271P1exZaZC
         HboNhQaFJGSRsqlHNsthQLdUH8dZoeDQKFvuoMAR4zea+4Td7T/lKE9g+rBdtw8zKDPJ
         hJ1JwS5WKKKclw9cZRJ82CRrRXj2WrEga/Baj+udQ8yx+hRQ0sDKq7w4nyi0S82RoKmX
         6Qa4xbXFF4y3twUliviTilTV0F0GFgS1dAmIPbXuPVHapkZ8EifNamqrsRWS1XEm4ZiL
         SQ3uZPZ2+AqK7v6MOJYVL51uQxzOWf81Jxrdujg7PHgfn2vsgiHKJD6FnKC/9Hub5yFw
         RhTg==
X-Gm-Message-State: AGRZ1gLbaqj3PgJcKiPkCYabH7aRqAQhBZOQTkIvzILNSF2RlXurRAL5
        aW0XODZMf33Pf9LiB+yIs5Kp1naK2ys=
X-Google-Smtp-Source: AJdET5egPypFPxTeXfojifNBHRnAcQvoG/v0HTzl+0euQv8k+2gAXzVjDLLNwmUpnnCKk6CoMIXHgg==
X-Received: by 2002:adf:e74c:: with SMTP id c12-v6mr2288841wrn.182.1540441033960;
        Wed, 24 Oct 2018 21:17:13 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t17sm1968573wrx.9.2018.10.24.21.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:17:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Slavica <slavicadj.ip2018@gmail.com>, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
References: <20181023162941.3840-1-slawica92@hotmail.com>
        <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810240938310.4546@tvgsbejvaqbjf.bet>
        <xmqqmur3mzsm.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810241717240.4546@tvgsbejvaqbjf.bet>
Date:   Thu, 25 Oct 2018 13:17:12 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810241717240.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 24 Oct 2018 17:18:39 +0200
        (DST)")
Message-ID: <xmqq4ldalkxj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> HOME is set to TRASH_DIRECTORY in t/test-lib.sh already, and we do
>> so to avoid getting affected by the real $HOME/.gitconfig of the
>> user who happens to be running the test suite.
>
> My bad. I should have checked. I was under the impression that we set
> `HOME` to the `t/` directory and initialized it. But you are right, of
> course, and that subshell as well as the override of `HOME` are absolutely
> unnecessary.

I was afraid that I may be missing some future plans to update
$TRASH_DIRECTORY/.gitconfig with "git config --global user.name Foo"
etc. in an earlier part of the test script, which would have made
the subshell and moving HOME elsewhere perfectly good ways to future
proof the new test being added (in which case, in-code comment to
say that near the assignment to HOME would have been a good
improvement).

Not that having them breaks the logic, but they distract the
readers by making them wonder what is going on, so I think we can do
without the subshell and assignment to HOME.

Thanks.
