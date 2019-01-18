Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525CC1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfARVVu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:21:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42472 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbfARVVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:21:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so16717568wrx.9
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 13:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sy2dDQD2NLiIHsgScrbxKocfWVSlRHhPy6ivn2gaSPc=;
        b=X4DthA7AJQ6YTSdDL+02UgRRs+V5W9GmHMMuZOQMAbcseJFBXSRltvzL4eCivUaKPC
         MFt8uGlA6ye2v9SrvjRo7AJOx+Si7AlUTPC3JiKuls8OahjuuAjrPDwFrte8qiscatZd
         BlLM82z2fUrSxWn4qbqwWPv8T6aQXAaZ0uBSLIKZ/Whks2NDHxGmw/urcTlR7H5gatkB
         8BnPmADUqWN8DqYVOMEEwevyRhJjzgZguydhH2Edkbx8RP57c/K3gBOaBQZcCi5YRdHR
         vmNo6RFAto8q6H3CCTrou7YpkhXjTd9/bCnI1oKyPCGw0txH9CR82f/zt5pFOALypWlC
         UhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sy2dDQD2NLiIHsgScrbxKocfWVSlRHhPy6ivn2gaSPc=;
        b=syu9YgKzNzGkubhgdRenR3stpzP5O/TYZIQ9/WsgMnfqi+55coBvo+8MASPZ3A3KN2
         BN/FG1yh9kZtmBR6Jcu4OPRbqCxX/C27ZOfLHIMXzR9f5UlP6vKqbSviwa1cKA4WwTwZ
         6m1/Ajh/CTM9bQb1QQz4wU2Gqs47F79Y242tNDFgbk6eoD/IoQQjFmLtrlFaigq170/8
         6gGWhfFPoBMNn2QXGsG0imqtxPJ/y2pCOWfjap6NzKwXsDqw6By3s9jYM79dPHImeWxX
         3M9ctL0UXyLnzY9HCHFS8dD9rnu6ZWfsOWZox8+3tNojcBR5dW7ugSuwzZxvzH79SXQ3
         Dh+Q==
X-Gm-Message-State: AJcUukcjFQ9BKAw+x4nOjeXUKbhvii3nWZfN2QuH/TDB9ahtLAonZYJS
        C4vdlHTJ3OzdOISsplFSE20=
X-Google-Smtp-Source: ALg8bN5GIEktuPyVGElpSGkswUQy40l795EWF6sJAtTPL/yWle9I/FugrZdcgruI+2o9v39jJDi/3g==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr17396271wrn.157.1547846507717;
        Fri, 18 Jan 2019 13:21:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c1sm35481493wmb.14.2019.01.18.13.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 13:21:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 0/8] Reimplement rebase --merge via interactive machinery
References: <20181122044841.20993-1-newren@gmail.com>
        <20181211161139.31686-1-newren@gmail.com>
        <CABPp-BE83Oe15U4yrkcV_-qzWocMS4UcVeG1VEoac-jXgw9Peg@mail.gmail.com>
        <xmqq4lak8d4g.fsf@gitster-ct.c.googlers.com>
        <xmqqzhsc6xdk.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.1901181434520.41@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1901181519230.41@tvgsbejvaqbjf.bet>
        <xmqqmunxluj8.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901182203350.41@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Jan 2019 13:21:46 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901182203350.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 18 Jan 2019 22:03:58 +0100 (STD)")
Message-ID: <xmqqtvi5irv9.fsf@gitster-ct.c.googlers.com>
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
> On Fri, 18 Jan 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > I am about to submit a new iteration of my patch series, would it be too
>> > much trouble for you to rebase on top? If it would be, let me know, then I
>> > will rebase on top of yours.
>> 
>> Or both of you keep the topics as-is and self-consistent, and let
>> the rerere machinery to squash it in when the two topics gets
>> merged.
>
> With all the experience I have with rerere, I don't trust it.

FWIW, I trust it once I got right resolution better than randomly
rebased resubmission that needs to be re-reviewed afresh.
