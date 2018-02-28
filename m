Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5471F404
	for <e@80x24.org>; Wed, 28 Feb 2018 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934962AbeB1QSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 11:18:45 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35296 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932702AbeB1QSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 11:18:42 -0500
Received: by mail-wm0-f44.google.com with SMTP id x7so6152265wmc.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tfUSM7tFil6Ug4+2ARcgqR/qQLBRFPwk0rMb3hUBpSg=;
        b=mtSPBdEd2kvVsC/JGuUW5nwUs5dHxs2BzfARg0Qm3IpIn0ANTYDr/BUD0QdSoPq0Or
         ozBVP3lIXY1ZZR1qzFhMB3Q2YkdMJIA7ZiYIw2lxh41JbtZ+9x6IrzFYkfe5GtqkykkV
         ALtYTz6gArSnwX3xdqo7+/P31zBQsqd4Vp8QS0/0Rjp6yqN/DOs/5twg3cdqCC0WANvm
         vSfalMdzo29QDpoP9c/afG1U8sWY0cj9E1SWNP2OjPJtyNlqXsUowUjGn11WMx9OtHIk
         rK7mPVB5F/D/2rYmcNJ7c3PHYwViAh1CPJuDr4mhoafFZTyvUw9kOYyxaHFCX39aKmKU
         Hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tfUSM7tFil6Ug4+2ARcgqR/qQLBRFPwk0rMb3hUBpSg=;
        b=rQO2uf4oHp21dodAhXtkB7aVTjK8h1LpcjC7geYaIR3kNH1InjTFArUe0JP3vZB4an
         tIp1eYDE0kaKa3cRq4c3JH/GoqpV13444wyTK0cr2Do5g/oHjnyxmqRPpJ5gyW8qeleg
         qWBWnOMg9a9MazrdxrLEmRfIxGt8VgLx9t0r8F0iZ9qQXTurjxQWLS2E3WFCY3cEuavC
         T4ror3wNXfkyu4Vry7laB+DA/w3nczS5JeyjGNAKzzbGpOM1fvpFm90Lp//cmtPFaOY/
         4oreDxwu5A6fmiEOYLEGhj7q1LsvpVTiquF2OcgNQ3hW003jw5tB91/gjWMeSwn6jyrx
         Vl2w==
X-Gm-Message-State: AElRT7HmuBfXFpz7GpYTD3yknLtwD9URpZginKcM3feyNLf8Tz8Ia/x/
        LwcHgvHbKXdfEk37UgNlOCU=
X-Google-Smtp-Source: AG47ELs+CVIT1qHZANAcl8dwvMqSQpc2bNVxjmLyELsKQZ+pPhqMR846pi7KNGA33bNMWYlBGV2hnw==
X-Received: by 10.28.12.79 with SMTP id 76mr1670143wmm.116.1519834720213;
        Wed, 28 Feb 2018 08:18:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h50sm4083136wrf.65.2018.02.28.08.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 08:18:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t5556: replace test_i18ngrep with a simple grep
References: <d0e6c6cf-7166-bef6-f179-c4e6acf7b0ac@ramsayjones.plus.com>
        <xmqq3726t11d.fsf@gitster-ct.c.googlers.com>
        <69c7dc21-fb52-5982-f7d8-04518d06db6c@ramsayjones.plus.com>
        <xmqqvaf1qqcx.fsf@gitster-ct.c.googlers.com>
        <20180213100437.15685-1-szeder.dev@gmail.com>
        <xmqqr2porf4z.fsf@gitster-ct.c.googlers.com>
        <20180213172603.GA10062@sigill.intra.peff.net>
        <xmqqeflorc9m.fsf@gitster-ct.c.googlers.com>
        <xmqq371mqjce.fsf@gitster-ct.c.googlers.com>
        <xmqq4lm2ozq3.fsf@gitster-ct.c.googlers.com>
        <192d4ee4-dbdd-3e47-b45c-8d1f7b69b9af@ramsayjones.plus.com>
        <CAM0VKj=hbT_m21ssF+nedVDrfNiYHu8wd9mUD55mAdNgmnZSgA@mail.gmail.com>
        <ffc3d3dc-6d21-4273-5362-cbf32e7e4e59@ramsayjones.plus.com>
Date:   Wed, 28 Feb 2018 08:18:37 -0800
In-Reply-To: <ffc3d3dc-6d21-4273-5362-cbf32e7e4e59@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 28 Feb 2018 15:33:51 +0000")
Message-ID: <xmqqo9k9m6jm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> However, I'm not sure about the authorship and taking credit for the
>> patch.  We ended up taking my patch, sure, but I think Ramsay did all
>> the real hard work, i.e. writing the commit message and, most
>> importantly, realizing that something is wrong with that '...| sort' at
>> the end of the line.
>
> No, the patch and the credit are yours, I was just trying to
> help out and get the patches moving forward. At most, I would
> think a 'Helped-by:' would be sufficient to note my input.

OK.


> [BTW, my 'Signed-off-by:' on that patch was in the spirit of
> the dco section b. - again I wasn't quite sure ...]

I take your "wasn't" to imply that by now you are a bit more sure?
It was a perfectly fine "I am passing it along" sign-off.

Thanks, both.
