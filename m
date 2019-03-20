Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF3420248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCTBTY (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:19:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36135 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTBTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:19:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id y13so897739wrd.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zptyPYarflFTlIbls2QCeUmWbA08j3Mwrg6Sh3IKaTY=;
        b=sBxg/cnjAnkL1iunifzMeBBjWqM6SODrC9twEfpQka8PEPBaJTQqePHHbcoL9q5Ocv
         rDv33/B+oPhORadFjGRK6cRh+nW846F6RVOuiAp9E5pfDVhRKi4336+Ds41PmyC/ZerE
         WxyMDCiULC8naefiMQLpocok4tJL6PFEG0QELQmNBZllIJs3FY7fKZTIbi7GJRWoGHil
         cU19tjlTUxDafxh0zay/cOO7eWqGG0vlzwzAwIiVde9aBhBJNTBBFT7evBW+dze+iuUL
         VFOpp9ja/3Yx1dLYnV3O1/twUmtcTnVwfg+OeS+rJGvk/dJpOtQu015fc++HQkL/XNAU
         j5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zptyPYarflFTlIbls2QCeUmWbA08j3Mwrg6Sh3IKaTY=;
        b=LOwomZqYFPE+20jmlcxElgX6Kg7oPTpcHGg7IZJBev6V0vWDIrjNf3ycA4bNFpS1bN
         omGiIyVTRGcArmkW80zzEWOl015f1/+KWdTLBBk0+Rj6Kvt7QkU3oafWYBW/8bPnJ1pF
         U8adjCDa0k+9Bqk0xfnGrKzTJO9hBKOBW7RYFBsr99+aHHlXYIemAGgi7uqysa/C1k2x
         rksGSx7fZ43lEM41d/gknJp0ScfMbwGZlGfYixcpNSl5eAUh21hXtzwcNI7EKadOW/IR
         8tx2O6ZJE0gpJ42MOeH3eFUdbLlhlfuVJ/qVO9PGbsnibw+yo6RUm/xE3yypWAKLQsGd
         H9CQ==
X-Gm-Message-State: APjAAAWRDVLaNrzxKQLRA1Km2qWnFAMYuzwbYQGdGhKxKZrG5ZbpkYWc
        s0o5xLLFFVkXttqc6ZU/GVxhVQyxyxw=
X-Google-Smtp-Source: APXvYqz5Tkz1wU1TImxsusV+pEFDjYiZilZDRuQFjfaHbBivkCsBSY5VzaNM1DSa+bK3sFOU5ZqOtA==
X-Received: by 2002:adf:cf05:: with SMTP id o5mr18206797wrj.8.1553044762634;
        Tue, 19 Mar 2019 18:19:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b9sm857115wmc.9.2019.03.19.18.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:19:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
        <20190319093910.20229-1-pclouds@gmail.com>
        <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
Date:   Wed, 20 Mar 2019 10:19:21 +0900
In-Reply-To: <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 20 Mar 2019 07:40:54 +0700")
Message-ID: <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> I think "checkout -m <otherbranch>" with a dirty index should refuse
>> to run; there is nothing to "continue" after such a failure, so I am
>> not sure what you mean by "an option to continue" (iow, I do not see
>> a need for such an option, and if that option makes the whole notion
>> strange, we can just decide not to have it, can't we?).
>
> We have --force to continue even when we have local changes, which
> will be overwritten. I was thinking a similar option which gives us
> permission to destroy staged changes.

Ah, then that is not "checkout --continue", but "checkout --force
-m"?  That sounds sensible, and should behave as if "checkout -f
HEAD && checkout -m <otherbranch>" was done, with respect to local
changes, I would think.
