Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85B91F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932229AbeCMU3R (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:29:17 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41807 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeCMU3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:29:16 -0400
Received: by mail-wr0-f172.google.com with SMTP id f14so2226359wre.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ucCyAPKRXNm5ESQtdHOds5BC+BImIi5DUWeI1aHP47M=;
        b=SlWXUooEdAfUEdUToIfx/J35WwX2jg0/y0tzLr/1MRQgEAexcjzeOqfUC3GhuuzI1w
         H0ZRKuvrerT7UWnnOuR8PttXVR/GCUR4mGA7WrWwy5pb6BCdJ/8Q6RBhrOhhNrUkc2JN
         HvkM5H/6NkEPRfxiu5FHb686KMvCmNa/1SwDXzwEV1aZT+GUq3muHSaoS9zE27wlECHn
         opLgXE4VijRB9iqpEqXMPsBljoS08K4dfnqL1lYOKHBsxTaK4zQaUtSrVviLIvY+p426
         nIE8aEnfrbQBlEw1nOVBdaoW+fzfkzwmTYdPXmKK+mHUyiTIkZOhonq2qXtr6NY7M0wU
         vwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ucCyAPKRXNm5ESQtdHOds5BC+BImIi5DUWeI1aHP47M=;
        b=Ie3DZQCTLRo3bWgYItWDRhIqhNdWrnHKZ0EvRx7OaHPdJj1RPKGVYM9AqkmS/wOtNw
         ONLg+n+fhLEIs2oLxiWQlS1PITprNINHbn/kDssaaGK4Uv696U/TCzL6sYBIZfBuwio+
         tkCrQfSQKFetMT6XQuDd2rlOMip1aPCWLhjn2mAUUvbZLRy05/vhKeXfebswEu38TQgD
         rbM1tUd1grHtKuHXx+TxuQmnVj04b64xQdN1rKXMG55nXoAumWjFXmbje+2LxvZngLLU
         DvVVprJknGoR2gQrNNrnb++sa5z8LCr1mDPXQCTveGVWw988ZZI7sp7QsRz5UpiftjQ7
         rF9Q==
X-Gm-Message-State: AElRT7ETexdpOw9/egBu06xAgX9VM+wzRhqECmwzHYKwSPv+znhZnUAu
        w9Ujr9aZIDUC/ya62uyzpVEDLWTi
X-Google-Smtp-Source: AG47ELss9nvu0AcG32AISWTZQfNJuDxJ4u3tzFNI95yBFwR8rHKox5WA+gTkdrBc6ib8nWIux3R9Bw==
X-Received: by 10.223.170.152 with SMTP id h24mr1661258wrc.102.1520972954925;
        Tue, 13 Mar 2018 13:29:14 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id q14sm651749wre.83.2018.03.13.13.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 13:29:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stan Hu <stanhu@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, luke@diamand.org,
        pclouds@gmail.com
Subject: Re: Bug in "revision.c: --all adds HEAD from all worktrees" ?
References: <C62FA8BB-FDCA-4BD0-A029-74C7AB89441F@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <C62FA8BB-FDCA-4BD0-A029-74C7AB89441F@gmail.com>
Date:   Tue, 13 Mar 2018 21:29:11 +0100
Message-ID: <874lljg1ns.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Stan Hu jotted:

> To be clear, this is how I think we got into this state:
>
> We have worktrees that are created to squash and rebase a branch. They were left around inadvertently for one reason or another.
>
> Since we were using git v2.14.3, a git gc would prune dangling objects because it never saw that a worktree still had a reference to it. Now, in git v2.15+, worktrees are examined, and a git gc won't garbage collect any objects referenced by a worktree.
>
> Another words, the failure of git v2.14 to preserve these objects caused problems with these stale worktrees with the upgrade to v2.15+.

Thanks, I hadn't dug into the root cause. Good to know it's not some
failure mode we're still producing, just the result of past bugs.
