Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9151F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeG3Vys (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:54:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35918 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3Vys (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:54:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so717086wmc.1
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9PKKEU6xMNH8RUhR8rbhGSeKPiDik232yEnyevuH/MQ=;
        b=JngzayKwb2SHQB+cPGvE/mnexHTSh1tcJPz8wArV4+1hQoAkr60+LAdliG9SNXakwC
         AONxMsYGb5NPbWTz2IX9LbGOosAHN2mIglglDmg8dkkCeCm4JYBiEoQxEAkEJXdwKbLF
         zZANDr3PztU84q1UzmV1CBq2zxiZ2l8bBuZS+BTnx/mTxKsHODwQQfdoHy3go8kHomoH
         IhNjtcpnuXE9T2xQ3iRXmbqZ7JPQN8ZEtibG1GRRSBnRMX3mLa3TgAii8sNclBYsO9y+
         tWNETy6rl5ZNKGk/QGrKPe7LVhXZyhxjxIkjFC2lA0Hlv/LCydRwTlgCUoaKBk0PGyDL
         u6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9PKKEU6xMNH8RUhR8rbhGSeKPiDik232yEnyevuH/MQ=;
        b=KnjLxcwN3EzXDleMXnImdo2KtvUroheL81poq/a7Hv7aULOy/4BHyoGEmsdudtj+uZ
         lJSA8uikjFTB8FcfIxKI6tkfLhav0ZfoCzJOChHr8J2/7jjXDc86+HWv9s5LITxA6/MI
         bxvSanMW+kE25DteqvsLEOmAT0grQFVlIghdsbaydoK6gSy3IDWWvtViDWTkW+jZVW5W
         88tvIWDCFyritWrLb6vCPlmvwIFDFTE0MJ97ZZLJymwgUzXH6FYV7uc3W5/xtj82Qi26
         yCHeidCIExfrtEqz+j9LgYxiuouRe7gWq/zjZCHa+JQTp7ChQ0ubkXJFmWAfQqlzm8hP
         ERqA==
X-Gm-Message-State: AOUpUlGpUlPXNUDwQRkwYSA7jsFuajJpVM5bRqEWQNLOj1W71sKG0RLQ
        nx1rh735eXzaE4Jv/P3kJ4resoSM
X-Google-Smtp-Source: AAOMgpf4ga3LxJUhe631UFHAI/YSBYeMqs8TIqI/B/635ViuNgogTNK750ydNGm6cO1FEj/M7QhaCw==
X-Received: by 2002:a1c:30d2:: with SMTP id w201-v6mr422218wmw.47.1532981887612;
        Mon, 30 Jul 2018 13:18:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u18-v6sm27040842wrm.80.2018.07.30.13.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:18:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v4 11/21] range-diff: add tests
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
        <2b8d09020fff0ac220c1878c65b47290c5245cb9.1532210683.git.gitgitgadget@gmail.com>
        <CAPig+cRd2V_hN0BVCcevXhu1v_QpL76mhqTGQmWPLK7sAD4Ytw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1807301830330.10478@tvgsbejvaqbjf.bet>
Date:   Mon, 30 Jul 2018 13:18:06 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807301830330.10478@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 30 Jul 2018 18:30:55 +0200
        (DST)")
Message-ID: <xmqq600wfpfl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 22 Jul 2018, Eric Sunshine wrote:
>
>> On Sat, Jul 21, 2018 at 6:05 PM Thomas Rast via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>> > These are essentially lifted from https://github.com/trast/tbdiff, with
>> > light touch-ups to account for the command now being names `git
>> 
>> s/names/named/
>
> Thanks.
>
> I already pushed an update to https://github.com/gitgitgadget/git/pull/1.

Should I take "pushed to ... GGG" to mean "do not merge what you
have to 'next' yet, as there will be an updated series (not
incremental) being prepared"?
