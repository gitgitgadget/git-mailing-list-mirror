Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3FA1F462
	for <e@80x24.org>; Mon, 20 May 2019 22:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfETW1X (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 18:27:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37375 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfETW1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 18:27:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id w37so26136299edw.4;
        Mon, 20 May 2019 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=uXf03ubmTcfI0eT3gMSdVF3rfDP/ceSBVPh5QTAx1DQ=;
        b=e7MVjWec7GQw3w2k9lvFzirVq2tq/HIjKWCqbw8Rni9lUQ9jGjussUrzeAsl7Ib2jG
         0snkUptiGx3SZh14M9GSA8uY49tKqgVf02iYSWYpNDFBBi4gDEWzpi+5kUM/Xr7l54aw
         sz6PoRqr+7fY/dwVvMps3nrlZUtupZDfh+9LEwxe4ZCLg6E3dWoa+yENoeK0QOzW/HS4
         G2wyuX8DivG07NCWQmbfOtXkWKu5inMTT+i9RRVLoP9OF8lfs1lf0MXNhcttX7PVvUP+
         aZu1G4DO+wRxM544gMI/HGawJJ41gJG6DVugX9f4nS9mtOyYh31XyIa3T5itOHVTWDZ2
         yK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=uXf03ubmTcfI0eT3gMSdVF3rfDP/ceSBVPh5QTAx1DQ=;
        b=hn/Rwa11WliLAJFOXLvTVhq7zM1ILAG5HZk0g4pi06mvCILrnhMyyxrxJ7U+Hgi2Nu
         O29zt/SLYgDSS//m8U66iFjJTqaSpPjcRWlJtRg7wPJafXR3N6BSKuvLeUVqZtl1A+Th
         muLrBdA/CuCB4RYSeYoI6cSBLpEDPTpkOhmKkVkJb6p0ctb/uRQkebn3gKPUyIpBdvO7
         PD5Ev0YPIGygEXyz4H7/qYyE6bDLl/PaR9pm5djB3EbOxuMv2/PmeapdYTDYefd/SM/M
         gEkXDqBLhqThY4t0FKVQybh3CdmyMGaBkRv6wpdZjQhtSCV1JbI6rwsnGhUDHOd2mcQb
         QxGA==
X-Gm-Message-State: APjAAAUWsKOaocUK+xXvgsQmzAdnnAjnvm3KSDa+xztd6vKKj82M6Arg
        9DqTScZkfRCyyjqiOax/Ht8=
X-Google-Smtp-Source: APXvYqxE5kQa5f85xphHorZ7AZrJ3JYn74K3s3Pd5eGU89k0m+jz+/6e1CTbfdrtRC9XKKO+BVfi6g==
X-Received: by 2002:a50:a535:: with SMTP id y50mr78577263edb.249.1558391241195;
        Mon, 20 May 2019 15:27:21 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g11sm5835232eda.42.2019.05.20.15.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 15:27:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.22.0-rc1
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com> <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAGyf7-F-d-n39fJmjYc_2rjqQa4d7PFCx63LwW3m7PFetEgzEw@mail.gmail.com>
Date:   Tue, 21 May 2019 00:27:19 +0200
Message-ID: <87ef4svk1k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 20 2019, Bryan Turner wrote:

> On Sun, May 19, 2019 at 10:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * The diff machinery, one of the oldest parts of the system, which
>>    long predates the parse-options API, uses fairly long and complex
>>    handcrafted option parser.  This is being rewritten to use the
>>    parse-options API.
>
> It looks like with these changes it's no longer possible to use "-U"
> (or, I'd assume, "--unified") without adding an explicit number for
> context lines.
>
> Was it not intended that a user could pass "-U" to explicitly say "I
> want a unified diff with the default number of context lines"? Because
> it's always worked that way, as far as I can tell (certainly since
> early 1.7.x releases). Is it possible, with the new parse-options
> code, to restore that behavior? Removing that is likely to be a pretty
> big disruption for Bitbucket Server, which has always explicitly
> passed "-U" to "git diff". If the community wants to move forward with
> the change, I understand. I'm not trying to roadblock it; I'm just
> listing an explicit example of something that will be significantly
> affected by the change. Perhaps Git 2.22 could emit a warning about
> the change in behavior and then a subsequent version could turn it
> into an error, to give us (and anyone else relying on this behavior)
> more time to make adjustments?
>
> I'm aware a unified diff is the default output, but many commands have
> flags that essentially tell Git to do what it would do by default.
> That can help counter changes in the default, as well as safeguarding
> against new config options that allow specifying a different default
> (as it were). For example, "git diff" has "--no-color", which could
> override configuration and essentially applied the default
> behavior--until the default configuration was changed in 1.8.4 from
> "never" to "auto". By using "--no-color", even though we didn't "need"
> to, we were protected against that change in the default.

I don't know if argument-less -U was ever intended, but I think in light
of what you're saying we should consider it a regression to fix before
2.22.0 is out. CC-ing Duy who wrote d473e2e0e8 ("diff.c: convert
-U|--unified", 2019-01-27).

The bug there is that the old opt_arg() code would be torelant to empty
values. I noticed a similar change the other day with the --abbrev
option, but didn't think it was worth noting. Maybe it's a more general
problem, in both cases we had a blindspot in our tests.
