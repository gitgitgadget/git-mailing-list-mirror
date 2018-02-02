Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1631F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeBBX3w (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:29:52 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41100 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeBBX3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:29:45 -0500
Received: by mail-wr0-f195.google.com with SMTP id v15so24054188wrb.8
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LhqfN+GinkuI5fnBbJdJZT5cDCBaoGPjQ0ZlbxnlQb8=;
        b=Cy7Xmew5qPxpb1modpo59DoAFB1iqvUco7Z3oGvyZfnfz9nKT2rjorMgfONwYs5e8t
         w89u7YXGc1ctb2USo453Yi1xwsiIiZPLwP94WTXh70wPOlLlVStxyhGqZDcq/RL4Ri5M
         Xkud7wSRppuaQNKI57izHtaMg5D8rSBaS4Xt7zM0QlhQxNffygxacinPOGY0by7Rk/3I
         5tg3VCsw5cHeDD8NJbqFB+JOTt04wcljcNKPi+RsIUyPQp1EtvCwKgxsJGjlVPQWh+uw
         Cul+kPciHpwFuaupZBtY4DK6/IXjbP4XuqLhVr2h2OYvF31GTfKGbmTr/4+CLiEekv1q
         C72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LhqfN+GinkuI5fnBbJdJZT5cDCBaoGPjQ0ZlbxnlQb8=;
        b=dKDkhUm/2BrBSJZy9386sNs5EQ/MAuZb5MA0etyRncTzYEKzQidSHmFpfYXMTc6wup
         5vO9ufQQyiwqnFcHju88zv7Kr8BZu8EmK21gD+95w4mBVD+Bn3pEQq/9QYnMmDSCJS7U
         heUgH09XOB4xx5ua5I/Fv36RgV4efAtFfTIfhp+c/42AuIrrWzGJJ4mNH/bcU1f0dRDK
         60CRRd/yPAwG+ERHg1sAElAMNUbF6zikqgA37Zfo8J8WW2hVKjDzgn9lf4tWtqdSmDkk
         4qyecSi5bRwbEEYfW9EHt4tjpbOFM1Wyj++guxXF7Wohw7bh4+MNAw3/zGnShbEelSPU
         8YxA==
X-Gm-Message-State: AKwxytf5KC5TE1vGkbtXj/7zRL8Dji94pdE7EzgPOoLuq23AWBj33qEf
        vWBrqNIjh2wFFJAQOQ5Mu6s=
X-Google-Smtp-Source: AH8x2248p9pgmoGVqoRUZ3jcfwMs+8NMdjlcP+OxX2dIivAL0eeAa+BDJvE0J/RdLBOY5d9mIpE5UA==
X-Received: by 10.223.135.209 with SMTP id c17mr26706133wrc.7.1517614183820;
        Fri, 02 Feb 2018 15:29:43 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y90sm6472240wrc.24.2018.02.02.15.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 15:29:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Genki Sky <sky@genki.is>
Cc:     git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] rebase: add --allow-empty-message option
References: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
Date:   Fri, 02 Feb 2018 15:29:42 -0800
In-Reply-To: <9d0414b869f21f38b81f92ee0619fd76410cbcfc.1517552392.git.sky@genki.is>
        (Genki Sky's message of "Fri, 02 Feb 2018 01:20:49 -0500")
Message-ID: <xmqqy3kbas2h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Genki Sky <sky@genki.is> writes:

> --> Motivation
>
> commit 4bee95847 ("cherry-pick: add --allow-empty-message option", 2012-08-02)
> started doing this work, but it was never completed. For more discussion
> on why this approach was chosen, see the thread beginning here:
>
>   https://public-inbox.org/git/20120801111658.GA21272@arachsys.com/
>
> https://stackoverflow.com/q/8542304 also shows this as a desirable
> feature, and that the workaround is non-trivial to get right.
>
> --> Implementation
>
> Add a new --allow-empty-message flag. Propagate it to all calls of 'git
> commit', 'git cherry-pick', and 'git rebase--helper' within the rebase
> scripts.
>
> Signed-off-by: Genki Sky <sky@genki.is>
> ---

Do you have our project history so that you can try running "git
log" to realize that the above does not quite match how people write
their log messages?  If not, please obtain one and do so ;-)

 - We discourage log messages from not explaining what *it* needs to
   explain itself and only referring to external resources.  The
   first part of the above is a typical anti-pattern.  The only
   thing readers can gather from "Motivation" part without refering
   to outside resources is it is a moral follow-up of 4bee95847
   whatever "this work" is doing, without being told what approach
   "this approach" means, etc.  URLs are good as supporting info,
   but there must be something they are meant to support readable in
   the log message itself.

 - Also we do not organize our log messages as "-->" bulletted
   chapters.  For this particular commit, once the first part
   becomes self-sufficient, I think it is sufficient to drop these
   bulletted headlines and have two paragraphs (first describing the
   problem being solved, then describing how the patch realizes that
   solution).

I think the changes to the code are sensible.  As Dscho said, I
found the new test script somewhat iffy.  Does it have to be a
completely new test script (as opposed to an additional test or two
to an existing tests for rebase that checks a similar feature like
keep-empty)?  Would it make it simpler to piggy back on an existing
one?

