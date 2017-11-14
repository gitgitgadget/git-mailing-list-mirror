Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 681A41F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756385AbdKNU3a (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:29:30 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:54679 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdKNU33 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:29:29 -0500
Received: by mail-qt0-f172.google.com with SMTP id h42so7071908qtk.11
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=0K1b+xGa8UB0/9+pcnz7ctCVajDk6WdRCigsoiVyHJs=;
        b=hgCFZYfvC3Bdl0DG9LnKL/ZtRyEP55fEHz4VcdYuSQkDSlkzinHfvtPkwD7y7D9Kva
         KCx/S+VEsiQ0wtnXKu02+n2qj6Nf1ZieU2t1sX+QKpLhYLenQVJtWa28EU044D219xoF
         lTUgWlUlEPEDRaknztjx0xKEiUhmZFWXX74FmSWCiTYI0oh1tZbKXeUb5nDXwCUot5Si
         D+Dt+oXFt2fCQTWxiSLrmFgl1/Dw/L7Xj7KQssaNs9bTHce0JE+o6GSMKNneH+vvuQrf
         pj2r6lI2Ep8i68qldxvzrWMPv1gn3Lq2DSKjq9C0h1QS50kJHyzIJlYylcG0SFiSj5Z/
         y9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=0K1b+xGa8UB0/9+pcnz7ctCVajDk6WdRCigsoiVyHJs=;
        b=uYInjbGmNo8o4Puhwaiu+sW4X8KBR9J/P7C4ouCJeqoQEG+Sw+a7DMB4ZCMoczUTVA
         T3JzPDjPcO/safOoNtK7tdpiQAAhGEE9zcpWOpZKFR3eW4zQn3Kyl0gJTUeRII+dAKWh
         uoOf433xHt43q4OU1W08Rs1n+uieE4M8rnh4SZaSUDJ8b3TRNkiFl4B/7va2+GFsMkRQ
         x9IeqF510Rayrip+Umlob83X7Jozl8BDwvIV1uhjBOhCdM5isqtTGBXOPsooX3uu4uy7
         ZSI529+dT8nY1O9PAQyzjK1T4w4IZf4TDpfi3wxQFYe+9kLD7vHtZeyHxhVkVBla1fm0
         tmfA==
X-Gm-Message-State: AJaThX4mbq8/p4R5A/7Q0VH6GhIYtwZYgZ6bWmEo4C0db8UrERCB5pZh
        donpjqyaRbGykVOEe8KemXVH5xCdLendWTsrQ2A=
X-Google-Smtp-Source: AGs4zMYa1Re+lx4bojhYCmcCjqio958TLoUx9mVoWq97bTrr7sSjaiJFl57X9VCS1JB8UY+MTEbUcJRxR9tLmG9XQPQ=
X-Received: by 10.55.181.4 with SMTP id e4mr20775553qkf.296.1510691368419;
 Tue, 14 Nov 2017 12:29:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Tue, 14 Nov 2017 12:29:27 -0800 (PST)
In-Reply-To: <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
References: <20171112134305.3949-1-t.gummerer@gmail.com> <20171112134305.3949-2-t.gummerer@gmail.com>
 <xmqq1sl2c21g.fsf@gitster.mtv.corp.google.com> <20171114084517.GA12097@hank> <CAPig+cTYC01Y9-EvyNo9hxQRbT60iqp8MqXEB_zWBi14kPV1Ng@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Nov 2017 15:29:27 -0500
X-Google-Sender-Auth: _WgosZoZ8TwHGwZnTGjklS0uyZo
Message-ID: <CAPig+cTDMvOWW2xLYfvQsOsfBuCOGDJwH_zRDQyxx1vpfkX4tA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] worktree: make add dwim
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 14, 2017 at 3:14 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> For my own edification...
> [...]
> git worktree add ../topic
>
> * Correctly errors out, refusing to create a new branch named "topic",
> if "topic" is already a branch.

By the way, there's an additional DWIM that could be done here instead
of erroring out. Specifically, for "git worktree add ../topic":

* If branch "topic" exists, check it out (rather than refusing to
create a new branch named "topic").

* If origin/topic exists, DWIM local "topic" branch into existence.

* Otherwise, create new local branch "topic".

> * Creates a new branch named "topic" if no such local branch exists.
>
> The desired new DWIMing would change the second bullet point to:
>
> * If no local branch named "topic" exists, DWIM it from "origin/topic"
> if possible, else create a new local branch named "topic".
