Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109CE1F51C
	for <e@80x24.org>; Tue, 22 May 2018 01:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeEVBmi (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 21:42:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34600 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeEVBmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 21:42:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id a137-v6so14079122wme.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 18:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=N6J3Rm/tKfC/TqOTQ3ywZ7DgVR3a0OKeEqhkOgDc9dE=;
        b=BNJrOu54Y5uFPYj0Oa+rOz1y7GBhiraDWT7OfqcQOOo1Tg8xZw6qoqJpp7dPg0nQ1y
         RLq/ji7a30C2IthZUKmSbZEh6YGCd/dEivIpBpD3zpyle2HFafjKWE4oKgNTlrGYYW/o
         2Mu8i3KI8ZV2TH8miuNpGKDV0le9tWCzMqGhkxX1R8BaYIEGs0zmlEQzsNC7n0NOA9R7
         dnlWKoIOkqeqEAX9Hc4x81KHkYbv5wAO1LfBp/Wua+6NHUbbZynm5brwi397maqUxyJ+
         5Tg0C1XgzZeAx5uk51Bxxs1GmjCfUvXTnVjQT1TDm8YMpPUobrHrqBkQaprYY0XSg1Pc
         3uTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=N6J3Rm/tKfC/TqOTQ3ywZ7DgVR3a0OKeEqhkOgDc9dE=;
        b=hs8YRicLIl2l9+ptAWGNGfY48OfbjQ0RvWPrrqVRgrsPDWK85/UF2IWNvXz3koDcyz
         ywf5+uXN8yke1eW5JFESSr/RVt6lSvSYNobi2lR1fQWkCtH4dfC9rVRMxTILe/CndCx8
         2qd3udp+L2/JYDB5tmaR4W0AxdsXa2Z9T3HCzOl9pQjqibt9zP561dVM8WymCvXNw22J
         YEAe07SE4PUHomuK6YpwmCtXTvWZaI39URh8id9ZHv1wgP2pVoiKululPcuPhYCF5pFi
         61wXjP7NZIhpguOTnuGrsVt+97gBjyOHBV4GECQrdNRHeTV+IPHP83Dh9Zgs4i3T+Yb3
         aHWA==
X-Gm-Message-State: ALKqPwfuDJNpFXoxhOtFZYIJ4fNT8SM9o6/qynzrqPNMX0FXuLz/GBWW
        pNMm3kwEYPCLARqw0bYTfcUkiVpZ
X-Google-Smtp-Source: AB8JxZo/RSyI2SyRsI3uue8/rruVzzgQvImWc+qw2gjP3uxFenJpOIy7e1rVaZfiHNzxYxJ5xrsxCQ==
X-Received: by 2002:a1c:17c9:: with SMTP id 192-v6mr569015wmx.95.1526953356636;
        Mon, 21 May 2018 18:42:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 136-v6sm1577773wmo.12.2018.05.21.18.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 18:42:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 00/18] Add `branch-diff`, a `tbdiff` lookalike
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <xmqqvabh1ung.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805211144340.77@tvgsbejvaqbjf.bet>
Date:   Tue, 22 May 2018 10:42:35 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805211144340.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 21 May 2018 11:51:48 +0200 (DST)")
Message-ID: <xmqqmuwszcs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> In the picture, the three pre-context lines that are all indented by
>> a HT are prefixed by a SP, and that is prefixed by a '+' sign of the
>> outer diff.
>
> Yep, that's exactly it.
>
> The way tbdiff did it was to parse the diff and re-roll the coloring on
> its own. I am not really keen on doing that in `branch --diff`, too.

Are you saying that these are "whitespace errors" getting painted?
It is somewhat odd because my whitespace errors are configured to be
painted in "reverse blue".  Perhaps you are forcing the internal
diff not to pay attention to the end-user configuration---which
actually does make sense, as reusing of "git diff" to take "diff of
diff" is a mere implementation detail.

In any case, the "whitespace errors" in "diff of diff" are mostly
distracting.

> I was wondering from the get-go whether it would make sense to make
> --dual-color the default.
>
> But now I wonder whether there is actually *any* use in `--color` without
> `--dual-color`.
>
> What do you think? Should I make the dual color mode the *only* color
> mode?

Sorry but you are asking a good question to a wrong person.

I normally do not seek much useful information in colored output, so
my reaction would not be very useful.  Non dual-color mode irritates
me due to the false whitespace errors, and dual-color mode irritates
me because it looks sufficiently different from tbdiff output that I
am used to see.

