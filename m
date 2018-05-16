Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5911F406
	for <e@80x24.org>; Wed, 16 May 2018 21:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeEPVSX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:18:23 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:44884 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeEPVSW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:18:22 -0400
Received: by mail-yw0-f180.google.com with SMTP id l142-v6so692675ywc.11
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cGp8a7qDRZd50X+dCkOROoZhdp2WUi9c5CAceltpYHY=;
        b=vejAn8P2tZNLyLB/G+DKp2ffNux8t176dUlo+pLAbxtPtMrAC208MhtDec3WU732W9
         x3yl5WtdDS1bBP+ewtiXWgsEjl87Pmc2daFu6aDbxGO4koW04tb3SiFnhFyGwRhYp29t
         Aj3/74f3MbWE0ArW0Av+j8tXVyb++nniVPlzfKtYEWGleWbJX8onk/8OjgVHvBZuDEhX
         zaPb/8s/jSpnrndidBJX69CQ2tdKR+7JxJPz8gcWkv4jso5jJW+5i0F5fzOQaNNlahNg
         fG13v3MUfXk07+jytSxQKYhE1tWZFyOIoOTvkz4W00WnUzSgvTw3yBH9VVf8Q15xFW+6
         mirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cGp8a7qDRZd50X+dCkOROoZhdp2WUi9c5CAceltpYHY=;
        b=jK2mV+Vj1mEtY0cFixMzpqroDkpN4HP5P/3lIYBP2pKZbB/3hQMha88mCEWrKHtxJk
         Vwmmc/xVZKK/f/uAzdaLPUgLNxXMgVmlUDsvPw3j3ahlEi80cq8XBiE/UZbg+hEBapsB
         QOAC8L4fyd7lZI0s1loY1B8yN1j8fzbH0cj7F1Uz5mu3CMbNLxrRmzUGHfGoM1ySoowm
         2msRdaSt55/Paox8O5EPfAJ0kOBMeE16m64gWfj99gqj2mbu0l1Av1s6pq+BZOkcYimH
         /urSQYIuAKLVcz16Hu3MrWpidbvYeDqNwcvolOvDY0/FVIe3OGjZTBWWubjzTc+BA/EE
         Ct9A==
X-Gm-Message-State: ALKqPwe9tD5tF9jAy99iSkRHsG7pcLCpCx1PF1ZQxxMLF8kal/C83yvU
        WFRVwi8mwJlA6Xy9+CB0qx5bkQhNHF+QduHuZpkoJQ==
X-Google-Smtp-Source: AB8JxZoxc8pXZFqjgcipEtWpzDnNr07RVHEiX+dPqjsjTt82JUFYoxxdCn7eKM8d4ct2KoVUIGnB5fKnB4kTKMUfjwk=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr1315138ywf.238.1526505500999;
 Wed, 16 May 2018 14:18:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Wed, 16 May 2018 14:18:20
 -0700 (PDT)
In-Reply-To: <20180516191410.GA3417@sigill.intra.peff.net>
References: <A33442B1-B37D-42E1-9C58-8AB583A43BC9@gmail.com>
 <87po1waqyc.fsf@evledraar.gmail.com> <81B00B00-00F4-487A-9D3E-6B7514098B29@gmail.com>
 <87muwzc2kv.fsf@evledraar.gmail.com> <fc2f1fdf-222f-aaee-9d58-aae8692920f5@gmail.com>
 <0f19f9f8-d215-622e-5090-1341c013babc@linuxfoundation.org> <20180516191410.GA3417@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 16 May 2018 14:18:20 -0700
Message-ID: <CAGZ79kaVroLhEu+QmTwLCpv1irst5zbnQBzg7xLkfFy8cC9owA@mail.gmail.com>
Subject: Re: worktrees vs. alternates
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> You can also do periodic maintenance like:
>
>   1. Copy each ref in the forked repositories into the parent repository
>      (e.g., giving each child that borrows from the parent its own
>      hierarchy in refs/remotes/<child>/*).

Can you just copy? I assume the mother repo doesn't know about
all objects, hence by copying the ref, we have a "spotty" history.

And to improve copying could permanent symlinking be used instead?
