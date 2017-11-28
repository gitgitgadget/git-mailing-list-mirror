Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85E3F20C11
	for <e@80x24.org>; Tue, 28 Nov 2017 03:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdK1DZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 22:25:43 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39695 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdK1DZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 22:25:42 -0500
Received: by mail-qt0-f195.google.com with SMTP id p44so41982499qtj.6
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 19:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QgkYHdZItwIq7Km8r/3PSh6Yqs2K7mJAylwTjPtVwfw=;
        b=o7AQi2k2XDmh3OH/k2DPSYDghIl4Z8KcJ3IT8EFrykLLhyJ+uwY70a790x9ZPWefdr
         PMIP5WcykJB5juqfhTiN00OKZuUoSb6vPvU1tuHxsFaggwsfhnDO9/D2W1bpHTZtv0TX
         cOLjxDhI+PYwx38HiQ49PtLflXO6lmT5gRTLNUehqlgSJkmTGdmSqJl1ZtgDap5x/zhw
         Z0f6xUIVr8RMDSurLCuGyAdNogI+ZXJwtU9XWa+r3sDYZRQ9qluZnvWa/0s9M8x4QY6k
         PETb7yZ2qYg2mA9yhoc1vSrMzQnYFiPeIyZAt1PMa5VjV1RqiAdu4p0FnQ37I1a8PhDJ
         uzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QgkYHdZItwIq7Km8r/3PSh6Yqs2K7mJAylwTjPtVwfw=;
        b=MeXYFsmX7n0QrR2ouRoKILcgx0IMGX31RG5jZmNFYEudahWDtp8zh4JKCVSk5QdNaW
         FTeUtOs79Z4iuxDtxGNeNDkTIJyWCEJ4f7esurxAlHBbvEj3BJi09A7ye4FkIjeK3sVe
         wqZQmJlKXtpZbfdU6c66GTquIgcaUtck9Y2MF2eaPNFIvsqeTyKptWoaWcGKX50Z3EFb
         AHjxc/7VmQUzqFBmJDh6VywTL8kTW4/t6h6PmAlXcbCNcY1lo8fSUZNTXVwAJJiWAFZd
         QfyXqYOoxpZvzz5JG9thFm3/NR+SYPgvYMLoCG/qwd2g2gBbgVqaIIz3v3UttK293iyO
         9YKw==
X-Gm-Message-State: AJaThX50kFLtF+8mmQ81KqI7QBD9SqJe9ECqkAPBYdvWqUrkLORLt9/e
        ZKQmy8aR4rOXlaQ+n5MGbL0VSA==
X-Google-Smtp-Source: AGs4zMYqCpdh6ijWqbADoz9NxX3C8FdVlsHsIwz1YruvOdLHYARxMQvnsd/yIWY4ZX9u96N+0Pazvg==
X-Received: by 10.237.63.59 with SMTP id p56mr33059599qtf.322.1511839541226;
        Mon, 27 Nov 2017 19:25:41 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id u21sm20556046qku.8.2017.11.27.19.25.40
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 19:25:40 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     johannes.schindelin@gmx.de
Cc:     avarab@gmail.com, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v3 4/4] exec_cmd: RUNTIME_PREFIX on some POSIX systems
Date:   Mon, 27 Nov 2017 22:25:38 -0500
Message-Id: <20171128032538.98071-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox>
References: <alpine.DEB.2.21.1.1711280039010.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In Git for Windows, we have an almost identical patch:
>
> https://github.com/git-for-windows/git/commit/bdd739bb2b0b
>
> We just guard the call to system_path() behind a test whether podir is
> already absolute, but these days, system_path() does that itself.
>
> I am too little of a Perl expert to be helpful with the other patches, but
> I would gladly runa build & test on Windows if you direct me to an
> easily-pullable branch.

Oh interesting - I've only peripherally looked at Git-for-Windows code,
since Chromium uses its packages verbatim (thanks, BTW!). I think you're
correct though - this patch set seems to be doing the same thing.

I've been force-pushing my changes to the "runtime-prefix" branch of my Git
fork for travis.ci testing. The latest commit on that branch adds a
"config.mak" for testing, so one commit from the branch head will contain
the sum set of this patch series applied at (or near) Git's master branch:

https://github.com/danjacques/git/tree/runtime-prefix~1

Let me know if this is what you are looking for, and if I can offer any
help with Windows testing. Thanks!
