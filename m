Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26BF1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 09:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeJWSBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 14:01:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40761 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbeJWSBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 14:01:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id b203-v6so1030408wme.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uCBnf5eyXftc2WiakmEXiHGe189K5NcowEnjBtIWUww=;
        b=ahbaiePncRi9CiDurAOjkJkuMu/CR3lJSH2Bht/14GmfCOCw53a7x0gq6WmlTJ8rci
         a8b2vst3YGIfXtIclC3NLVa5hJYlvanOjjVNVdNLyruUHRvf5SEjjZwzVXZ4oJnmxp13
         gmOv3aXdu0wLhVL6k6fvZ+3CeNmDlR7lYMbd/llyeK8INk9FTChlG7Moonz5jehjQhUt
         8AwC011XzfTgxiE5Wyj8fA1+kfqg8RoF8VCG0WLni40CMsYjY9AeETVKRe56znvm0PzS
         c5pXfymEa768WJ4sOjE2HUbbkjOmc1+IrKZ30RQi+lsT/6azvFIaXFNTDZw/GWQaiv+C
         uGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uCBnf5eyXftc2WiakmEXiHGe189K5NcowEnjBtIWUww=;
        b=Kf4iAJGXSgVuwjR9JNZ7isqmikGX8Na4eiDysb+qE62IcFUAUM95SuOHFenC2foI8K
         ZKMe4FWOoY8APNfPFcCnbO22ew0UyStlMv4fMDcxDLw2LAnCcaQvysJrV/NgEOlwrDWx
         874c4ki8FFRE6ggjBY4du5RkBhzDsYMFT+IY/2ewqFWs2qODdqrsuaexT4wYnCk0zlSq
         7cCXeViDZNhdBiRSjCz0wAg5FS0xMcAV0MqfAyjW9MjIxjZgOJPXBeYeHbLzNG5mpQcj
         5qx31boGE+OhP55nEeHYf29wINIZp51U6jRoNHUccxNDWtJFz/irAf3jMVdxoyX+W9qd
         Wiqg==
X-Gm-Message-State: ABuFfoihlgUE+0wuNKRc9BaylpSgynrFA7ydoqfrak2UoAeZn7fYU/WY
        lyzZ7J9ekaInJ5QFDudyYlA=
X-Google-Smtp-Source: ACcGV620SRB82/45mjOj0Xzi0twz8iQr6WDtTCTCDengUVu/Py/9jF+8t8Nb7Ag1l+2xStjLxnAgfw==
X-Received: by 2002:a1c:7fc5:: with SMTP id a188-v6mr4694646wmd.91.1540287505250;
        Tue, 23 Oct 2018 02:38:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l70-v6sm1374708wma.0.2018.10.23.02.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 02:38:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19] Bring more repository handles into our code base]
References: <20181016233550.251311-1-sbeller@google.com>
        <20181022173935.GG30222@szeder.dev>
        <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 23 Oct 2018 18:38:23 +0900
In-Reply-To: <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 23 Oct 2018 07:49:45 +0900")
Message-ID: <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I actually think this round does a far nicer job playing well with
> other topics than any earlier series.  The pain you are observing I
> think come primarily from my not making the best use of these
> patches.
>
> Steppng back a bit, I'd imagine in an ideal world where "make
> coccicheck" can be done instantaneously _and_ the spatch machinery
> is just as reliable as C compilers....
>
> What I _could_ do (and what I did do only for one round of pushing
> out 'pu') is to queue a coccinelle transformation at the tip of
> integration branches.  If "make coccicheck" ran in subsecond, I
> could even automate it in the script that is used to rebuild 'pu'
> every day, ...

Anyway, even though "make coccicheck" does not run in subsecond,
I've updated my machinery to rebuild the integration branches so
that I can optionally queue generated coccicheck patches, and what I
pushed out tonight has one at the tip of 'pu' and also another at
the tip of 'next'.  The latter seems to be passing all archs and
executing Windows run.

The tip of 'pu' has trouble with -Wunused on Apple around the
delta-islands series.


next: https://travis-ci.org/git/git/builds/444969406
pu:   https://travis-ci.org/git/git/builds/444969342


