Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC321F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeHWBRK (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 21:17:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeHWBRK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 21:17:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so2832225wre.2
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 14:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4qwNaVwmXZoJLzTHINVsMRQqEO3bPKcLCC3S4XAYxEg=;
        b=Zhu3x6n2wTO98AlNNjc6I18HUykQtKfwPZghcoGvRmadkbxMKwZTysjff2j/Y0EvGE
         GqDst6qBWuClvd/4Tn7y/IvdDQHAAdqOFbNL9Ds8fFZMgvHxhKxv+0w7RhKT8xAAZ2RA
         tlHZBGvU3U3vCOC2a2oVfeDsRMgZ2/BiHJe/1sZxt2UvXIu+QbwMXN0O6Lqw/ECxDFyY
         BkjFOQbxYUjiLAUpzYgiJwjeO5Vl+hnCTRE5onOVqW1wuVlTOUbJSuv/0YQXWsq+CPh+
         wWPYpWfGZ27IEqVwFjF3exYNDW43uUAIrUSNdUKw7/ovnqmwrA5gUR/Xxwe2eyQIZPZ4
         1tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4qwNaVwmXZoJLzTHINVsMRQqEO3bPKcLCC3S4XAYxEg=;
        b=ao4GilHO4JCLWpm/SWCWgDpudkqW5IJQbqg//3EuxopzbIJXX/JmN1nwwNxjrAqWZA
         XuKGd7+wZ2htQiZo0rwFImm0lXx6HVB+JdCNIY5JpvQGIX9BI+MMamdaJfaLVNi8knGw
         3bH5BaP+t3m8dUvxwVS7gksbdeRDy8J1rzsUSbRJFq02WrIf8kU+nueW+ScwJfsFDrRw
         PDHgMMVB4zIZCNj8aXkiGFVIBFIAy/0OvvzpDLa/EuBq5ywuzJOfuRKlv3fIKsMBgN87
         N/jjgZmkrAoV0pUOviE+GM1clvQjbdb4W8J8RKggEvZ/rNDekNY3kYniilXWt+iAEQ6P
         drbg==
X-Gm-Message-State: APzg51B5hjYnqEwrXUAGtBVyCKiyhylfh/F4hRXlE8DuZkyQc8vnry0Q
        ysLlLUy2pgINprcceO4YVc4=
X-Google-Smtp-Source: ANB0VdY4OHxI+Bjc6tbznKbyNiGK49FiR1sjBT33Wst6duEIKixSQF0UBnp6+Gbm3v7LrQUxYffy3A==
X-Received: by 2002:adf:fc4a:: with SMTP id e10-v6mr2588833wrs.157.1534974630990;
        Wed, 22 Aug 2018 14:50:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2075557wmh.29.2018.08.22.14.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 14:50:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Teach the builtin rebase about the builtin interactive rebase
References: <pull.23.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Aug 2018 14:50:29 -0700
In-Reply-To: <pull.23.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 22 Aug 2018 14:35:22 -0700 (PDT)")
Message-ID: <xmqqmutekr4q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch fixes that.
>
> Note: while this patch targets pk/rebase-in-c-6-final, it will not work
> correctly without ag/rebase-i-in-c. So my suggestion is to rewrite the 
> pk/rebas-in-c-6-final branch by first merging ag/rebase-i-in-c, then
> applying this here patch, and only then cherry-pick "rebase: default to
> using the builtin rebase".

Yup, that sounds like a very sensible structure.
