Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73671F404
	for <e@80x24.org>; Wed, 21 Mar 2018 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeCUS65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 14:58:57 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:41712 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752909AbeCUS6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 14:58:55 -0400
Received: by mail-qk0-f182.google.com with SMTP id s78so6587210qkl.8
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=kVT5hFvp5MaHYswePCBfJFvNipfT5IJL77DQPspOJkg=;
        b=dNsKzoqt3DxvSJuAAbk6euuqFOAdEy4mJbNoTg0oq9CrTsKU5gEWAQjUqnXVAIkEdB
         vnzt3Qy5OXsEjQ1jrG8UfTIcb7HvkbQb89pAlEgi+WJhv/GCiYZQHEY64CS3NRr2rZ5J
         WrCNi9gWTNjGKy65/on4p7q6HUoCfZaSngPvlX06p/uIy4EZJKn3YCOcJmVQhkG3CMtQ
         AmSm8+wjmz6ePb/X3dW3W9b4W/IvP/A5ezYzeznnT+qtRAB5B4u2pT5eGqksUtdPQf4X
         zVYn0gulnPUtP89LJWV23xijlLOzzJfA9HPRewn/snDCaQh9U2hEuNsn/+AEX3uAWUBh
         6v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=kVT5hFvp5MaHYswePCBfJFvNipfT5IJL77DQPspOJkg=;
        b=m2xCgEbE04bFoT2zG6aF5tMckpY7CvERA4FNAT01nh0XuhKriR1XVBSXYA4rDiyKLm
         UgZCH5ChUOmmJOCkU8cVb17ofM6r04FR26a0kTAxBy1o8mIbaF06PHudFQfwpaLgzSfA
         N8tuKvfmAs9/LbPAN72n+ksKj3Dqwm2B1edJijp9b5IciDpHC0NxNz48uGVw0ezc9CeR
         qyqC1numTdNaazYBE8yp4q/3FKNtc8TdPyrBtJU1GK3plxnkSILrV6wi9Yj0YgFmSVHv
         afRioNvKuK6Bi8GlIbcD8UZHv2Groue3HzK/+ouP1lCA0x5JR39twoAQnXOYDRxycC6i
         eNdg==
X-Gm-Message-State: AElRT7FmkLdVNbJ0DzMlSqSRxOm5BCIoX7viotTVzt2c26rij6PcMKgi
        RxB5oaQLaro2xLDoysBY05r4z7OoDK1Pv06bNFVO9g==
X-Google-Smtp-Source: AG47ELvsWlcl6KFAYAfUO2R1sGbfN6oIoseeZ4ARXZ7UYQtuFai+0W0vrPeFtR147CT3qyh8bGHnOFmQ//hWYERm2B0=
X-Received: by 10.55.74.2 with SMTP id x2mr10937802qka.314.1521658734441; Wed,
 21 Mar 2018 11:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 21 Mar 2018 11:58:54 -0700 (PDT)
In-Reply-To: <xmqqo9jhpadh.fsf@gitster-ct.c.googlers.com>
References: <CAPig+cTKkp6kpFcJfVV8W1ejCrCWQH33mHtgFUn+MpMgw5i1pA@mail.gmail.com>
 <20180321152356.10754-1-predatoramigo@gmail.com> <xmqqo9jhpadh.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 21 Mar 2018 14:58:54 -0400
X-Google-Sender-Auth: fd2nkc71wsCYqtvIkK5U21NKiqs
Message-ID: <CAPig+cRnO6e5B=mYAfkt7bdgit2uOJk1a+CAahQ2+uRRbPAObQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] test: avoid pipes in git related commands for test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 21, 2018 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pratik Karki <predatoramigo@gmail.com> writes:
>>  Avoid using pipes downstream of Git commands since the exit
>>  codes of commands upstream of pipes get swallowed, thus potentially hiding
>>  failure of those commands. Instead, capture Git command output to a file and
>>  apply the downstream command(s) to that file.
>
> Please do not indent the body of the log message by one space.

One other issue I forgot to mention is that the commit message in v3
started getting too wide again[1]; it was fine in v2. Pratik, try to
keep the commit message wrapped to about 70-72 characters or so.

[1]: https://public-inbox.org/git/CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com/
