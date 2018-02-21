Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3BC1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeBUXWE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:22:04 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:43280 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUXWD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:22:03 -0500
Received: by mail-yw0-f180.google.com with SMTP id p70so1093901ywg.10
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MHly8Wn23G56wZPN5igdwET9H6D0/8Qpw1zPWwwWrow=;
        b=GdyBoJJWct4ugsHD6Z2yIOm7qh9J+oTPRtCQk56NE/+78fqi7a/BJxbi+oeE3JMWHN
         2OrI3yn1M6LvtCJl2Ufsy4vGxxdNnY67wBrc7i+p1FNMhaI+9j2PS3mpbYEfCcmt9VQh
         jaz8N7/9y+l1bkax0Z1AcNBUAWrOEJGbtgQ/OIHIPs1UeSDV5lcGPPxh26aTbr9YZV/p
         3IILDQBCHl/cDzLNxOaMEB1A/Irp2JESeik/FHwc8xpCCn5+CZccQ+kMchMvOHrG1Gmd
         2e9305sV7lgqmXP6dXthWkSXHoPW+6fj0Bq80BKVfh7KtvCu5H3rCHOWu1tS4UOxRGLj
         B/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MHly8Wn23G56wZPN5igdwET9H6D0/8Qpw1zPWwwWrow=;
        b=DUumezqsBuQsnpH/8ZxCUTnZ3H631yR4mbwtv8uoa/uKlTJZOM6uYZ0VbKP7R2zLHJ
         TI3mwvqSIlgktApJhB8lSOIx7kBmI9+85XzysxgGTHzDG7omG2BKXnVf7J+M5JtAFQp0
         sIpfbMyc6awpbwuUl+C89R9Q8QeivXB6dTciKn5PNAyCC7CGthKO7Oj7pPAtbpz3n20m
         ZGHUBtqJbhNSLuP/gQvvn4uGsK+0hWFfW10Fe2QD/IJ0QeXr5xdHnUeXDrBw1gAe1YBz
         bApqpGzDxHH2gCR5qEZD4oaWqtGUr4ASuCM2dx7YTX4psDbaqaXOsrpXq371AGzIPVm3
         WGBg==
X-Gm-Message-State: APf1xPD5mC/7M6h48Ye+yMJA2ro4LN5KZtReRPXi8LUC6DNASoW+PAQh
        iN/HOhtjec7FFPrZvBmPgM5RztOwdyxzrrRjoam/4g==
X-Google-Smtp-Source: AH8x227Y7juycPQmh0QMmwuaYhWkoXRBk3Ut1qK2dIrS0E5I/hIM1EPU/C1E/kyV5KKIvcTjtXiZNr9z7IWLq4lKhsI=
X-Received: by 10.129.196.74 with SMTP id s10mr3477744ywj.33.1519255322736;
 Wed, 21 Feb 2018 15:22:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 15:22:02
 -0800 (PST)
In-Reply-To: <20180221231338.GC7944@sigill.intra.peff.net>
References: <20180221185204.GA8476@sigill.intra.peff.net> <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
 <20180221231338.GC7944@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 15:22:02 -0800
Message-ID: <CAGZ79kZz+hC+eXxa2A-NpnCZa-LikWDaegfijUjHp5CCenwQvA@mail.gmail.com>
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [PATCH] commit: drop uses of get_cached_commit_buffer()
> ---
>  builtin/rev-list.c | 2 +-
>  log-tree.c         | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)

Now if we'd get around to rewrite pretty.c as well, we could make it static,
giving a stronger reason of not using that function. But it looks a bit
complicated to me, who is not familiar in that area of the code.

Thanks for making less use of this suboptimal API,
Stefan
