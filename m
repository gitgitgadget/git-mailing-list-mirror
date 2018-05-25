Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25861F51C
	for <e@80x24.org>; Fri, 25 May 2018 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936009AbeEYIMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 04:12:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38869 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935866AbeEYIMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 04:12:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so12136757wmb.3
        for <git@vger.kernel.org>; Fri, 25 May 2018 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Nmz6nAJvMfvkv6MIaLrUx5GCCpkhyk9wZ3Wavegk8Xs=;
        b=JNTyBwRV/i3qvUzGC76s/2OuJRqQfHzB8IcdwKH1C8K5WsJmtTe48CXF3kVmNYdOEb
         YZJo1tbqOIKXFlVWXHdjf0Ithn4PXaXS6KDfTDwu/yOyTWSObQ7CuYmoazqB06/MgNOT
         6uAUlN6U1Uq1ZpTV6BDP3rLKV6XKgGBg+b3Pcl+ct7B+GGGQA4hoph/w+F8/OW+nGipn
         6hvIMrUPq2w/0uE3ycsdy03HoMya8tp9QvrciEFuQzDCJ45jntv7rETwVDAbMIOEuk4Q
         l9A8zqZ4ThHPQDqJj1xzh4mqlwsRtoS0xgJOzTcblEjuN627kCkav0GofhlowPWymqSR
         /RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Nmz6nAJvMfvkv6MIaLrUx5GCCpkhyk9wZ3Wavegk8Xs=;
        b=SCzd6aI5cORKgO/juX61FYJLEmywJu0riNsV2p9Dw4BhQ/2Mm8B17fUowgOxFoQOuu
         o3x3PZADvw2LzWfG22AVdjgjtyiZpcY1F1BfCTniMtNM9hVLzFr2opjwIoeLMBvEwgqY
         q6XonBJHhlZJ0k/4w5x8b/1TsOuT+KhPwE298n6vo/CIvfiZavXOLDyf5Li7tObwdjOh
         sfEiqadTUahf0UugqzCx1e+vWykwqo2GJo/QV1ED3LFZ/Rwc7FReLEbNBmhUpsOsZbGp
         M9BUoVWTmneliIP10dEAUQbhqzaBfnsIQRcjfhVQC0xh+W9ZlMbZaW9bC/rLtv9uCpIx
         0eXg==
X-Gm-Message-State: ALKqPwd/GVHGk6a/WWA6zzZFOqztDdfg0HNlOkykO5XWy/y3Pm5h2wVs
        SVdmprG78L3HRfY4q0ppWSo=
X-Google-Smtp-Source: ADUXVKJWaG0exlwcjgh+r/8oAEVjiSN2+vYfdaYCVsbKOsOAffE4QuQB4+D5YAgSR3cUPdP0z/A3zQ==
X-Received: by 2002:a1c:459a:: with SMTP id l26-v6mr1083930wmi.95.1527235969120;
        Fri, 25 May 2018 01:12:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i26-v6sm5309568wmb.19.2018.05.25.01.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 01:12:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
        <20180524194704.936-1-avarab@gmail.com>
Date:   Fri, 25 May 2018 17:12:47 +0900
In-Reply-To: <20180524194704.936-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 May 2018 19:47:04 +0000")
Message-ID: <xmqqpo1knog0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +checkout.implicitRemote::
> +	When you run 'git checkout <something>' and only have one
> +	remote, it may implicitly fall back on checking out and
> +	tracking e.g. 'origin/<something>'.

Yup, that is quite implicit.  It works without configuring anything,
only as long as you have a single remote.  That is quite implicit.


> This stops working as soon
> +	as you have more than one remote with a '<something>'
> +	reference. This setting allows for setting the name of a
> +	preferred remote that should always win when it comes to
> +	disambiguation. The typical use-case is to set this to
> +	`origin`.

So this feature and configuration feels more like an explicit one,
to be used to affect how Git works when the implicit one does not
work well.  I would have called it checkout.defaultRemote, as it
would be a nonsense name to call it checkout.explicitRemote ;-).

> +Currently this is used by linkgit:git-checkout[1] when 'git checkout
> +<something>' will checkout the '<something>' branch on another remote,
> +and by linkgit:git-worktree[1] when 'git worktree add' refers to a
> +remote branch. This setting might be used for other checkout-like
> +commands or functionality in the future.

Hmph, that is an interesting direction.  You foresee that you'll
have a single repository with multiple remotes to grab and share
objects from different people working on the same project, and use
multiple worktrees to work on different branches, yet you are happy
to declare that each worktree is to work with one particular remote?

We'd need a per-worktree config file to make it work, I guess, or
a three-level checkout.$worktree_id.defaultRemote configuration
variable, perhaps?

In any case I can see how this will help those with multiple remotes
(including me ;-).  Thanks for moving this topic forward.

