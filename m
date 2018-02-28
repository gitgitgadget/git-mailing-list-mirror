Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266801F404
	for <e@80x24.org>; Wed, 28 Feb 2018 22:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935524AbeB1Wcc (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 17:32:32 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43258 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935479AbeB1Wca (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 17:32:30 -0500
Received: by mail-wr0-f171.google.com with SMTP id u49so4083271wrc.10
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 14:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QftVMcQMa7p306xO7DZ45AJsO3IB5lAmlrnWENcPBA4=;
        b=Jh99iX7xgFPGn8ChuteTeQLz2hdHutaM1DpCdwk+qSbe8RGHOAMv6l9RpxErvThkDy
         QdmxF4kviM/GIPnfMwH7lkp1EpbzPzFUfzvjNwgi0H6dBTC8V4U4JZbOk/9QMw/FO6Nh
         h3vT9JS3UQnOjMQUCqqy+XOHljs/V1nui5f/ekCBRLtipzuvz1rr4FIiNArcHmfF6LLA
         v4YbaTonFqbjU/ZWrzc2Tub7oVNapONBW0RbyjXJd4yyo3KzWDvH47jOxQQDhDsMjWs6
         tbIa5SJMmDkYHth3QRjt48j63uzL/NJaGoNOXaNg2C0vBW+vtJ/JYLY5k7RtmfGqYbOF
         MKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QftVMcQMa7p306xO7DZ45AJsO3IB5lAmlrnWENcPBA4=;
        b=YVJ0uzDOXcyF9LxQ2qKmOCbuU+nIa7IonrBIy3mFIKkiTXrOLu4uh7w7ydAyLZ48Rc
         EKjAvtAm/2ADRpfjnVCuEKgSm+LcYKsmSBtSCk1PmiKmqiEUya/TYZK2Zj6JlqQt/SuZ
         bn5LUnWzChoGRH7hN3TiH32bpTZAi8Z0XMNvuKITIZJg5ZmPxmL/Gi7lClvW+7M/ovus
         F06S6tnhvujqEa+zrVHFWMsRpSX1Slj1W3zE2UcasHPqZBqTGIQ70cnw/VSsWX1sM0Pi
         +Xp02ckiVGlKoB/EH7uT5VUzMentBVtbAp3DKxqhrrrsbeTm9UgoADf5HF8Ms9eylhzH
         029Q==
X-Gm-Message-State: APf1xPBP4kPA/IcfwSmHshD4kcy0Uy9qz0udnG7xgF/IHJgQ9TP1XHm/
        7klTwGOB1IL2KdBly1Px35Y=
X-Google-Smtp-Source: AG47ELshAfjwuuiU2/3o4wUjiei1MyNAQspI2PViiAdUlISxGFr5ss+1lvbLT0TPKffpYrjB9j/NqA==
X-Received: by 10.223.164.215 with SMTP id h23mr15037885wrb.38.1519857148647;
        Wed, 28 Feb 2018 14:32:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 42sm2643777wrx.92.2018.02.28.14.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 14:32:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH] userdiff: add built-in pattern for golang
References: <20180228172906.30582-1-alban.gruin@gmail.com>
        <CAPig+cTOv+jAQHA8p76MHcbbvv4SAs4y_1BxeRpexWwTT4+8hA@mail.gmail.com>
        <763c5ee4-0bee-7f76-1e2a-4ad07a813e29@gmail.com>
        <CAPig+cQ6awH8KfX3C+=OwE3qJLJPQyAt_dmQvMw1NLNnCT73RQ@mail.gmail.com>
        <b9aa0939-8b20-0f35-84f4-5b519080ca34@gmail.com>
        <CAPig+cQ3MuFhMHKGyejE2o0WnVZGvLwcLVgVLpshU_j01MkcaA@mail.gmail.com>
Date:   Wed, 28 Feb 2018 14:32:27 -0800
In-Reply-To: <CAPig+cQ3MuFhMHKGyejE2o0WnVZGvLwcLVgVLpshU_j01MkcaA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 28 Feb 2018 17:22:27 -0500")
Message-ID: <xmqqvaegiw3o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Feb 28, 2018 at 5:17 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>> Yes, but I can split the line like that:
>>
>>     % cat >baz.go<<\EOF
>>     package baz
>>     func baz(arg1 int64,
>>         arg2 int64) {
>>     }
>>     EOF
>>     % go build baz.go
>>
>> This complies to the standard formatting (at least, gofmt doesn't change
>> it), but making the regex strict about the brace would cause it to
>> ignore those funcs, although I don't know how common they are.
>
> Makes sense. Thanks for the clarifying example. I wouldn't be at all
> surprised it such formatting exists in the wild, so keeping the regex
> as-is seems a good idea.

Does input like that appear in the tests the patch adds?  If not, it
probably is a good idea to have it somewhere in the commit (even if
there is no test addition, having it in the log message to explain
why the regex is done like so would be a good idea).

Thanks.
