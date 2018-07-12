Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B913D1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 16:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeGLRKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:10:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38709 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGLRKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:10:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id m1-v6so9699413wrg.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WLmjDLq1/pLmAgwE6aI2BxOEmCfK6kBAI/EG9zqRflg=;
        b=D1eSqRADsC2HTVGxZ5QNaI16yC7LRl6CNJJWtQsCL9CKjdQ9rksAtBCHzAYfeQUavW
         GK4GhigU0TqDq91SCTpuIiSjYnsdYWy530olaXhdjyr6CXqxLGKQqmoDnKvHRYvBIM+A
         2II7DuRqP+/pklL176X6Os1Qhxw8Gy25QNjEAvphCOZmbArUW/4CDHxehlSFyyhu6KjX
         b1/9kR5ksPXXbIDBozpMmWwiB0KeaTnMplPTY0kqb1K5TYKaYtfenkijX1RRABDWG6tA
         I0HG/Do204HzJ9zGBJRSo2+63cEhoHXt0rnxM8CEoWsx0ZqSy5bcK52JT4oiicMxwkfY
         V2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WLmjDLq1/pLmAgwE6aI2BxOEmCfK6kBAI/EG9zqRflg=;
        b=AzLQTPPZijemwDAHt7U5IlwMYxY70e33A2Nydz1hLf6nAEcQwQcdo3ATHX/kMUbkZu
         kbKgwL4WP4qXzi+B0ic/QXD7I6J3/uIjsSePs+UQqiPg8luW3IgKQ5oxv8s+okslZAzW
         jsI5MtF+coLCKvDQ1t7RsfebGPw840JK6yWVZNb6hToO9HxWmooD4rlzGw5nyny2NO5g
         ITbqstEvLyG2agATxVBHfEHGPJaeWb2BFXlqlngKDRpylljAjryZM+nPGTQnT382QVeB
         Q1sI5/xOchN0o4WZvaxY/JKTY8PLZWs1qKt8vBF5LqDXd/vN9TCqbvS9d4JS1hVSelMF
         KXmQ==
X-Gm-Message-State: AOUpUlE7PBTF4hUmO8ONFrVZKKaey7zlJ0ed4jzHh9iPMg36YD240GXW
        mStw81nedsqL3/7MkEZtUnbF/Wda
X-Google-Smtp-Source: AAOMgpf8OsypUiNJiqn6j78+rWwnUL0XFyi3IAC8EGqlGby+tn7GR5ap/e5aYVZSnKyyDFnyjPPl3g==
X-Received: by 2002:adf:90e9:: with SMTP id i96-v6mr2561405wri.146.1531414777516;
        Thu, 12 Jul 2018 09:59:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i21-v6sm2816400wmf.26.2018.07.12.09.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 09:59:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: refs/notes/amlog problems, was Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost assignment problems
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com>
        <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
        <xmqq7em7gg3j.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807072116570.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807080017160.75@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1807092342490.75@tvgsbejvaqbjf.bet>
        <xmqqefg94uq1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Jul 2018 09:59:36 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807121720340.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Jul 2018 17:23:24 +0200 (DST)")
Message-ID: <xmqq8t6gz8xz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would like to ask you to reinstate the post-rewrite hook, as it still
> improves the situation over the current one.

Without post-rewrite I seem to be getting correct amlog entries for
commits created by "git rebase"; do our rebase--am backend still
trigger post-applypatch hook in its "am" phase to apply the patches
created with "format-patch"?

