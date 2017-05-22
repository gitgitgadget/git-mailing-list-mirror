Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491211FF30
	for <e@80x24.org>; Mon, 22 May 2017 02:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756970AbdEVCfY (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 22:35:24 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33039 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756494AbdEVCfX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 22:35:23 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so67445955pfh.0
        for <git@vger.kernel.org>; Sun, 21 May 2017 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SZ9n+XiqzGu58ICwiY7jn0ucTA9KnorZdr9Hh2VwoUs=;
        b=WgCJ9DIDGHkPdTFH6eWEWUohlYSxmd9Ik8dWfL9Robtht+hKJOOvm9ruTuCR/HqqiN
         hiwqpbwqEPgCs1PniuLqgU7YZ+bZyT/6ubWwTSE+CW7lGtjo6oInM9fHPJt2rzoVH1Mo
         y6hFSSmeR0DHrOGc704cKJpBcg4W9CsFH1qthecUvrZEq4HVCRNIaTbb+8oMtvcKnaEB
         vYWxHmGcGi9GDpP1yjfVUK3f5FWuYe9m+MQWfE+9UJg2MEG1aUCL37VSewCoRzIIeIcx
         dbrsVbYXE5pf8PPXMFjEb23zx0kgN8P3Y1m/WdjeetqgXkRBHE+lSaXkXTb2KDTvEeWZ
         lnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SZ9n+XiqzGu58ICwiY7jn0ucTA9KnorZdr9Hh2VwoUs=;
        b=uTFxj3f1GLCMmq4ZRyqAc2HP27JVonvMbqcKokImeGvhLOkVfiigc3uwybHEPlJ+iN
         1KLjCYW/TWsSabNgsGdocJFDk9gagYxXNhuXc3YBF6V6rVfxGuuwLOC3hRjM4t63VHOp
         yJTbuQlowdXByDUjcokgHnyrTADuQGzrpuAmR9e4VBHi32cb+RNd2n+5n6mRe1qnegqw
         8pVKHE8t7t2N2dBSqGku/hvLTz5fsPk4KY5bsB4i2YTqdnaXMZRyJRC/nTEllR//EH4R
         OltHy8kLAXsNfs/Fw4QI/w1VXaaYXB9KUPUmfYAC1ukyON/TjH+5oTYZ2Qqy7j2G/yzN
         3XSg==
X-Gm-Message-State: AODbwcBGaB4yaRB1MYfmFvoYVfKSEUXq+54d2fE67VUhfwkOGwvgX5b2
        ihlDi5vlMa2Tgw==
X-Received: by 10.99.186.21 with SMTP id k21mr22992390pgf.165.1495420522624;
        Sun, 21 May 2017 19:35:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id m123sm9647213pfc.51.2017.05.21.19.35.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 19:35:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
        <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
        <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
Date:   Mon, 22 May 2017 11:35:21 +0900
In-Reply-To: <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 22 May 2017 03:13:34 +0100")
Message-ID: <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> So, I don't know. Wait let me try your specific version:
>
> $ ~/sparse/sparse --version
> v0.5.0-207-g14964df
> $ ~/sparse/sparse usage.c
> usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type (originally declared at git-compat-util.h:1074) - different modifiers
> $ 
>
> Er, dunno. (This is on Linux Mint 18.1).

Oh, I don't question your expertise or competence.  There must be
something I am doing wrong, and the version of sparse I happened to
have run was the easiest thing to point a finger at, but that does
not seem to be it.

Thanks for helping.  I'll find time to dig deeper to find what's
breaking it for me.



