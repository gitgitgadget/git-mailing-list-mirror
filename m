Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D79920374
	for <e@80x24.org>; Mon, 15 Apr 2019 04:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfDOETK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 00:19:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34363 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOETK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 00:19:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so5218847wmf.1
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 21:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59vAEFUwq72cixHl+vR0czgX3rcaMTpEvQEUIlyjib4=;
        b=CSDuF4w+CUPRDbxAay06K2nGZcVZEuNRy5JbNPqzZUBj6dgREyEgxjzFFIK5UuExE1
         zwjFznnXYF+K2q/hEsMAuEy8YCyfXGq0qyjtIg0LiQordtxt7lvY0zJrhtX/aAXSu6Pu
         7wW2mMFnvKxgjLJkxl3w5KjvlKT0IPX6RrzWSwci/vvXD/tOQk9aJJf9rgSPiy42NVx/
         2tesK6U2H9eD1qNa5VbSngjZzID5eS876YMKueDNkWZ+ryhnSlwUxjTokCDbhRBtsTzk
         NhDtzv1HSMl5sGEhmBDQXlmjXorSiNeCVEt8iGkWOGqgyvotZSTfx5R6uq6z31mJQwsF
         w51A==
X-Gm-Message-State: APjAAAV41BByDajBueWxx9Q+BYU3KEOyIsZuOkLQXzGqrkjglPtMHjnc
        qPCwBT1eubkQO+2C9/Ra/OigWlqKxsToD3n4PeQ=
X-Google-Smtp-Source: APXvYqwioJNyoqy5WFrgmAEbg4H9srYtC7kr1rK91jw4FSZCBLlxlo1Nw+zGGTXULyQyVpo1uWMGEB94MA1Op6ZrPy8=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr19868366wmd.124.1555301948756;
 Sun, 14 Apr 2019 21:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.168.git.gitgitgadget@gmail.com> <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
 <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
 <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com> <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
In-Reply-To: <CAPig+cQ3drZ+iE=SkSXTdHVfTxLkPTi=VTJCMJn7LKLxcpC-pQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Apr 2019 00:18:58 -0400
Message-ID: <CAPig+cSHJ_g=KGBL2qoJK7Ddv6QhoC2Fq=2dyRF1qexAv63RiA@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have
 been excluded
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 12:16 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> When composing that email, I originally wrote $(wildcard
> config.mak.autogen) as the suggestion but changed it to the looser
> $(wildcard config.mak*) when I realized that the developer's own
> config.mak probably ought to be a dependency, as well. Taking your
> objection into consideration, we could mention both explicitly:
>
>     Documentation/GIT-EXCLUDED-PROGRAMS: Makefile \
>         $(wildcard config.mak) $(wildcard config.mak.autogen)

Bleh, I forgot config.mak.uname from Dscho's original patch.

    Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname \
        $(wildcard config.mak) $(wildcard config.mak.autogen)
