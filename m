Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB8E71F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeEVCyt (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:54:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33131 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeEVCys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:54:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12-v6so14225861wmc.0
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=fiRtWAB2Ck5T/mQShvw2V5xrLLEvftWgSvCF6oszm/I=;
        b=YJxcYJaxtThuCmDnBzxyLR7Cr4zVGgN8GpV105inZYKjcMBLBzoZCg7XocUdCzIpSJ
         zQMVrLkfWjpet4z8SfSEKASa36XjwOJolJ8jkeFj/7ssj1DpAYFk9rPusr89V4Nj0eAc
         QnkFqIF8OwqOCZeqC+s5zfhxjaSZCTlT2126A5fl/B0yLw68kE1JXJkjM4LNTH+4P7/i
         TcKBaRAC+uSkVbeBlESI1trWIEIrwUhkpNUQuDwqRo4uFvrX8GedZowY9qa2wN53tYUV
         jXXZGJnzp5ruW8r+1UOrR+Ul2LJoln0tDKCHP6RQHL56i2dMa+Osiek/MegQ0lidWqdr
         +XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=fiRtWAB2Ck5T/mQShvw2V5xrLLEvftWgSvCF6oszm/I=;
        b=iM0OgrvDvDFOe8KU2dAhSe9vGLmiilbphjbPkvcLMX31fd0d9//uXgSGZkhThf+O3I
         ATFQJDhY5n+JiHWJetMfDvMFsXyK2imK1CKz8K0WXX6pyJiYGgKLIbrkv/NB4JJ7E+t2
         //tfaqhNBUQlYhqqMQdNvbIiH8Bkibi9Jma/jcA29DGJnGxgsNSXNQ3/4sBQ89ZCk/VJ
         uPaq4uhFnsqRzux53SmE4K9XzehIqLzRSAZCHcAZmGgxeBspkzt5MBjrw8kB70N9ahIg
         7vP2CUB5ysvFbVsDhCIfpiVTr6BQp27qfRbqvp6vcoayZfrPSi8CbXmfwxs0eQuGwSat
         cMPQ==
X-Gm-Message-State: ALKqPwcfS6cA8JY8wka3g4Ksg2uhq+3HuaagcYcRE4iY29u9BMTqZKcY
        aNI9ru2HByRGEFdPUcNF1u0=
X-Google-Smtp-Source: AB8JxZqx8GJI8zHw+hZkldt7X+t2GKmLK4hKZdMsIQpaP2KgcBQfjyeoWvOWmICDv3DFlZW5cGhRyg==
X-Received: by 2002:a1c:1082:: with SMTP id 124-v6mr645401wmq.46.1526957686641;
        Mon, 21 May 2018 19:54:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d83-v6sm21152366wmh.16.2018.05.21.19.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 19:54:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/4] unpack_trees_options: free messages when done
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
        <cover.1526913784.git.martin.agren@gmail.com>
        <xmqqa7ssz9u1.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 22 May 2018 11:54:45 +0900
In-Reply-To: <xmqqa7ssz9u1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 22 May 2018 11:46:14 +0900")
Message-ID: <xmqq1se4z9fu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Martin Ågren <martin.agren@gmail.com> writes:
>
>> I've taken the six patches that Junio has queued and rebuilt the series
>> to get rid of the new and possibly bug-prone function that no-one uses
>> once the series is over.
>
> Hmph, this unfortunately depends on 'next', which means we cannot
> merge it down to 'maint' later to fix these leaks.  I guess it is
> not a huge deal, though.  We've lived with these message leaks for
> quite some time now and earth still kept rotating ;-)

Oh, what was I thinking.  This, just like its previous rounds, is on
top of bp/merge-rename-config^0 and it is expected *not* to be
mergeable to 'maint' (or 'master', for that matter, at least not
yet).

Will queue.  Thanks.
