Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8081F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeI1Hti (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:49:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeI1Hti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:49:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id s14-v6so4563621wrw.6
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 18:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6oFi3thdG+xJFgTIYsmOUnuvv+hm5dwjFPcZJgkR3qo=;
        b=ugr0z1qZ6EBcBl361MRfxsfeb80TjOcEq5uzokCXV7+Ak0UntwzNZ7G/ZUzR3mqxis
         wc3+TMM/kmpnC4oSGX8DC9VgyZ5tLbkEdxUl6AWQhbuQqhFFCybWsjGi7+yMt0/UpV99
         SN/yKg0unfBArFjxqx/nZMsdv/79IeahyFCtVkatzMXVBbjb5eXmsM4tcta7YutSkzhk
         tW6SY1oqKfeHBNqS+KQ7a9Vq3MCPQV6D3ylaa8Pd4LkDai00TjFWjdOxxQGUARzBp2nE
         JgCX4PsWs9PegfsglZ+cVOQgixE3V6lPrIkxrjgN2ZGIkjP4/DkYJkg1tgp9me8GOZXx
         X75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6oFi3thdG+xJFgTIYsmOUnuvv+hm5dwjFPcZJgkR3qo=;
        b=jUnvLJpBNakKok2/izbxrISsa7mp58j3nRap9MYDum17qBIQF7aN5T9qzB8vvA5m5r
         SaT0FMr8uyiBcP7iUfBkFn5DFRaeBGFXszk4qdzsuleu9Mx7hmYs4oEkspVjDzwkKn+K
         qUvJADXWwTe32oXsT5+J/+RJaF20znmIq9kRtyShwUCmhItK2/qS8S71o7k+xvuW4LXF
         FOAKhy8Xz+wYedIoOchSAp4OGuL1y4YcxC8hHtz4uGg3DF14wLSIW6obpVqHDR1FZy2g
         B4NO5RCNJ6E1Lrh5mjT+U5CZoEM9INWOe2Y/wMXY1l3PIvjXSfPzQO1FzvmJrl+yoqb5
         2n4A==
X-Gm-Message-State: ABuFfojwG6ufujmAeXWTIdn0wcxrpVDUz3jkYA1S+4jci4EpWHZBSLUX
        WOZRx5zAZoaQiawSmG4cead2v02E
X-Google-Smtp-Source: ACcGV62KmDqPIrUyeyyDiqe8+2TqjZZg+BPANEZyTt5CE3m268b1Yg2F8r5+8lq3YyoBW7l9vT4f4w==
X-Received: by 2002:adf:bd10:: with SMTP id j16-v6mr10109350wrh.267.1538098107924;
        Thu, 27 Sep 2018 18:28:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d4-v6sm210201wrv.15.2018.09.27.18.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:28:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Nickolai Belakovski <nbelakovski@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked working tree the same way as the current branch is colorized
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20180927181708.GA2468@sigill.intra.peff.net>
        <20180927192804.GA27163@rigel>
        <20180927193559.GB6950@sigill.intra.peff.net>
        <20180927194150.GA7452@sigill.intra.peff.net>
        <xmqqo9cifxee.fsf@gitster-ct.c.googlers.com>
        <20180928010514.GB11281@sigill.intra.peff.net>
Date:   Thu, 27 Sep 2018 18:28:26 -0700
In-Reply-To: <20180928010514.GB11281@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 21:05:14 -0400")
Message-ID: <xmqqsh1ue7gl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Alternatively, %(HEAD) could return "*" or "+" depending on whether it's
> the current worktree head. That would mildly break an existing format
> like:
>
>   %(if)%(HEAD)%(then) *%(color:green)%(end)%(refname)
>
> since it would start coloring worktree HEADs the same way. It would be
> rewritten as:
>
>   %(if:equals=*)%(HEAD)%(then)...real HEAD...
>   %(else)%(if:equals=+)%(HEAD)%(then)...worktree HEAD...
>   %(else)...regular ref...
>   %(end)%(end)
>
> I think that's perhaps nicer, but I'm not sure we want even such a minor
> regression.

I tend to think it is not worth having to worry about it by changing
the meaning of %(HEAD) marking to save the effort to find a new
token to fill that placeholder.  Your %(worktreeHEAD) is good
enough, I would think.
