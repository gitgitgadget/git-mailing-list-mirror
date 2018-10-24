Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617FC1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 09:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJXS0D (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 14:26:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38253 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 14:26:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id b14-v6so2096229wmj.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8LQfNcq687c0w3GQVsMKYpqk45UujdGR7v0fOVpwCZA=;
        b=os8wx3HOBuHpLhEa017dUiirCqETdM/o/Qouk9PHQlwIH1/0IppyF7drznuiYCCf0u
         beAqL9y9urXM83XShgYdYz9e5fUHqoyYwKLnX+coarsG6Hbj3ghkMgMr8v2o6hY2IeTO
         ADagtAFeJHhsN+nDE7r2zy2HsoJdnQO+EzZIZ//1MNTLVysgd+6JWmz3pFm8YX3AYYqU
         ZqKfp2IeqsXmX5l5/g6LagTjHqqChMevpx9c43e+DYoF1E+K4KeLry2mpQfFZ06SZqGb
         K96xrVL4+n5/mc3UIhffKxNcXf31oomCq5JtFOf8RFhPDFymkRGIEYNJRZljR+9sZjIY
         Mwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8LQfNcq687c0w3GQVsMKYpqk45UujdGR7v0fOVpwCZA=;
        b=EWU+ZuvTwzSs33bkqRwRH7guKeSmFcoG38+QXGHY4gOfVTkL0RDVO6yRDNNqv2xOD1
         Ze0Gnvz5Ag6YryzErwVUtfFnhNps8aRdvlgQFmTZ6d3tOO/e6Z+qTjt4w4zGUlDm/e61
         TEArf9tG87VlVaemHLUBFnBsFRrdNKNQMqXNiZJLdhvowJ+v78crXp1+SU8uGtc65z1e
         UhWAlCE4n1ERhs3ABT7BYzRD0ua8qwoldz9qPZ5Bwd3cra72rxTlY/X9QZlsOsEhtnck
         M6AJkOBtm8LJaUKE7COWjAzyqeDu6fSuXPE7+i68jH0uQHf5DqxUsfo8WEkq9v/RJONV
         G3Gg==
X-Gm-Message-State: AGRZ1gIb7f80un8zK4PlA34gKC/K+718MkjHwvu9lhHZf8nZ+RGjsD70
        dEGcI7ZgVYXtZI9oIPwqXjA=
X-Google-Smtp-Source: AJdET5edxb+qUyCG7KaBl4WQlPsK0d1N0Yayb9QgbhZrDE7lbiyeC5pe5np+FdcEJMzOAX2E/OAXjA==
X-Received: by 2002:a1c:3403:: with SMTP id b3-v6mr1929700wma.108.1540375114975;
        Wed, 24 Oct 2018 02:58:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c8-v6sm6428987wrb.6.2018.10.24.02.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 02:58:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Slavica <slavicadj.ip2018@gmail.com>, git@vger.kernel.org,
        Slavica <slawica92@hotmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
References: <20181023162941.3840-1-slawica92@hotmail.com>
        <xmqqd0s0qcuv.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810240938310.4546@tvgsbejvaqbjf.bet>
Date:   Wed, 24 Oct 2018 18:58:33 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810240938310.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 24 Oct 2018 09:39:11 +0200
        (DST)")
Message-ID: <xmqqmur3mzsm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 24 Oct 2018, Junio C Hamano wrote:
>
>> Slavica <slavicadj.ip2018@gmail.com> writes:
>> 
>> > +test_expect_failure 'stash with HOME as non-existing directory' '
>> > +    test_commit 1 &&
>> > +    test_config user.useconfigonly true &&
>> > +    test_config stash.usebuiltin true &&
>> > +    (
>> > +        HOME=$(pwd)/none &&
>> > +        export HOME &&
>> 
>> What is the reason why this test needs to move HOME away from
>> TRASH_DIRECTORY (set in t/test-lib.sh)?
>
> This is to make sure that no user.name nor user.email is configured. That
> was my idea, hence I answer your question.

HOME is set to TRASH_DIRECTORY in t/test-lib.sh already, and we do
so to avoid getting affected by the real $HOME/.gitconfig of the
user who happens to be running the test suite.

With that in place for ages, this test still moves HOME away from
TRASH_DIRECTORY, and that is totally unnecessary if it is only done
to avoid getting affected by the real $HOME/.gitconfig of the user.
After all, this single test is not unique in its need to avoid
reading from user's $HOME/.gitconfig---so I expected there may be
other reasons.

That is why I asked, and your response is not quite answering that
question.
