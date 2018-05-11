Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 774E51F406
	for <e@80x24.org>; Fri, 11 May 2018 17:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeEKRaJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 13:30:09 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33620 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeEKRaH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 13:30:07 -0400
Received: by mail-pg0-f46.google.com with SMTP id i194-v6so2713573pgd.0
        for <git@vger.kernel.org>; Fri, 11 May 2018 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=czKfKkpoHaKUDwGZfkkopjzrmxQhh6pnEXkfMO+i4xw=;
        b=ks5NVquzUuYW/+E84MjA12jA1Oao/fXn+xRLT5E72HFlIMahrckVcPffAki3arINQk
         DgQG0rFZb8ZkMxc6lf/cy+iS0mIegEmDRMqkulsr/qyUo5ScevKoWbI7HKcWkO9g7AEs
         nv2txPeol6YgP3gnzwX9HzHZAYCJu9r21HP+fJiZ1JeQWhUxwdxrskuiVygUbBInL4Qw
         H27AEvBdl/Os6BUiZgdMQK42C1GDp88PiILBpANenPCoqsoAQnpeHgg9SvpGv+gIVZe2
         9UnRJOTBQbezlZyYOi/XNsZJndqsWI/BRtBvcZQbtPgLMpWrLrygA2rRWffXFZbMF5s7
         gC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=czKfKkpoHaKUDwGZfkkopjzrmxQhh6pnEXkfMO+i4xw=;
        b=gxSgQ9c5YEwkEdx9CSF85CjDLsiGimAXRclw6XhAXSjnT0IDHCa8u9QyQ/X1GbNnjQ
         plgXtPAv+iEfLf2/h1KK9/gA65g2VrhpTHODcJTFOTQzM77kzXtgTy3PXPRJK3utJSKp
         RwW1EC4RI5PNcWTvTCOexYVqA1j6jVuS98FtLp0Nw5/jchXCa6IqRX4Mo2gIILmvmB3H
         IFoR7OOkSClqY/O3waxjjWJLEA5mi3M874a7HioFEzZdDd7l/M0uFhdMTOQ0Mi1n6glf
         51n8Gt7kkUk9zoi5PyjOUPNG5/xl8Fn+HEg8rCYT4Z/m3f/P4ZeARI1yGuyr96ThKMNz
         Hv5w==
X-Gm-Message-State: ALKqPwcVskPvRIDB34z0gSR3EY5/3fxXVzK3d1xtK5o9o8b5wcmVIsi8
        MfBArvCxQENrBgp+64ibnffesAJVjOGLrmPXK0M=
X-Google-Smtp-Source: AB8JxZoScsp2+oOsmVla9XynmO9xjTIO59OQDmjXUlJJJFSgJqsZxP3QaiBdT5VbzKL7PQUzyhs0N0IYn1KBxo4ZCeQ=
X-Received: by 2002:a65:488c:: with SMTP id n12-v6mr5145633pgs.155.1526059807259;
 Fri, 11 May 2018 10:30:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Fri, 11 May 2018 10:30:06 -0700 (PDT)
In-Reply-To: <eb3de182-c939-022f-92ed-3449e220af59@gmail.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com> <CAN0heSo-1+BvE0SiZMKT1zHZ4o+-mK0W9S+xxDA4Pyw3iTvpDQ@mail.gmail.com>
 <CAGZ79kY1m_6AdUoRx1L2=HzX7hG_uUUcYnLsb=VNdxPcvnpOEg@mail.gmail.com> <eb3de182-c939-022f-92ed-3449e220af59@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 11 May 2018 19:30:06 +0200
Message-ID: <CAN0heSqr+UZrdRW4MqEGK927iwg+6JNrWxebF8UJYcVt9V2aqw@mail.gmail.com>
Subject: Re: [PATCH 00/12] Integrate commit-graph into fsck, gc, and fetch
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 19:23, Derrick Stolee <stolee@gmail.com> wrote:

> Martin's initial test cases are wonderful. I've adapted them to test the
> other conditions in the verify_commit_graph() method and caught some
> interesting behavior in the process. I'm preparing v2 so we can investigate
> the direction of the tests.

Cool, I'm glad you found them useful. One thought I had was that you
could possibly write the tests such that you introduce errors from the
back of the file. That might enable you to do less of the "backup
commit-graph file and restore it"-dance. Just a thought.

Martin
