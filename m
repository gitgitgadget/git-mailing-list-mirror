Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE87A1F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbeCXHFC (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:05:02 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33282 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeCXHFC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:05:02 -0400
Received: by mail-it0-f45.google.com with SMTP id z143-v6so7338373itc.0
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KZMOrP43gqV9/VLaxUXtTz4YmKWPiPtkQOkCdxyl91k=;
        b=qP2DdH6TPACsMgItcpOPL4YGBL82umM7I77RWw+p58VuuZ1fweuCojrugd1xCfbVpw
         9IJhyci0tinhDllajssBGquSdY27XXffqImcOtVLD/w9Z74F3QiiPI3mPdKlzvDaGoEn
         9qN6lS3TrDDk1XnfAlve7P5zBy3dvU95hHFiaAPfwxuIHbykfcdg3FzAk81dqm9fH2ED
         ol/DCbwXADdvFa/+FuixVAUgKn5iZdlORBwBv5i5YO1XWNt1+/JiBsfBdODOPXuu6Ton
         amqQNev8GQefvO2gyYz7BJjS9Y4fszJQQNy5wFczh48XOHUWY+i8Fo2Oud5uFBXnK1nZ
         jVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KZMOrP43gqV9/VLaxUXtTz4YmKWPiPtkQOkCdxyl91k=;
        b=tevEgBsFM1wVLF/rdYGBEvpsDANtW1WZPpNZ/9o5YCdQIT2AwXdzhqSr+5VN6Sufk8
         ohLXfn1pSQBkFI9MLcVFjK6ImX+0pdI9LByPZZ3s8jV3GWsgQjNhlQIM0KPrV5hzR9N4
         S9NnBoNvTP2dq6zzsNATkwmBxQzbr7qZ5PwMOt6CpX+QE98hDklBmDro/2L/LpuI7K+f
         Uhy6DWMZ+ZoY6aKpYcyEZRFGfXmkdS+OsBwa7GTAWyvCCmX4AbsLJaT1bd73vOTkOKxr
         +FJXhF7LTIaO2W/7dj0BXz0NNZ11RlrrqLgNbUWRTLE1LtyHsCXD3BI79QXCOLRoGTr5
         TA8A==
X-Gm-Message-State: AElRT7FrUc9o//2Zm3d1uZMzbkKfSieYpYS1AJVjgGLIOuvXN4zXxmGa
        WCu1tLiOSE87lRXZj+W+/nC2CRcIEfbv6c0vhqU=
X-Google-Smtp-Source: AG47ELsRy3sLHc2UTVjdbeCUO+eO8F1INfgLu45Rf14Ikzjretta2EI6onCgaquu17S0ty6Ai8o34YOQEDfncxtkL4Q=
X-Received: by 2002:a24:eec5:: with SMTP id b188-v6mr15333538iti.96.1521875101194;
 Sat, 24 Mar 2018 00:05:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sat, 24 Mar 2018 00:05:00 -0700 (PDT)
In-Reply-To: <xmqq7eq2ijc6.fsf@gitster-ct.c.googlers.com>
References: <20180323140007.12096-1-chriscool@tuxfamily.org> <xmqq7eq2ijc6.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 24 Mar 2018 08:05:00 +0100
Message-ID: <CAP8UFD0-GnYtSwNSxM5YQdD+0qAS6R9yW0kFa_88-0Drs2N1ng@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] perf/aggregate: sort result by regression
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 10:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> This small patch series makes it easy to spot big performance
>> regressions, so that they can later be investigated.
>>
>> For example:
>>
>> $ ./aggregate.perl --sortbyregression --subsection "without libpcre" v2.14.3 v2.15.1 v2.16.2 p4220-log-grep-engines.sh
>
> Are we comfortable with the idea that other kinds of sorting, when
> invented in the future, would have to say
>
>     $ ./aggregate.perl --sortbysomethingelse --subsection "without libpcre" \
>         A B C p4220-log-grep-engines.sh
>
> or will we regret that and wish if we could write it as
>
>     $ ./aggregate.perl --sort-by=somethingelse --subsection "without libpcre" \
>         A B C p4220-log-grep-engines.sh
>
> If the latter, perhaps we should use --soft-by=regression from day one.

Yeah, I think it is probably better to use --sort-by=regression (not
--soft-by ;-), so I will use that in the next version.

> Do we expect that "taking a lot more more rtime than the previous"
> will stay to be the only kind of "regression" we care about in the
> context of t/perf?  If so, there is no need for further suggestion,
> but if not, perhaps we should plan if/how we could also parameterize
> the "rtime" part from the command line.  E.g.
>
>     $ ./aggregate.perl --sort-by=regression:stime
>
> might be a way to say "we only care about the stime part" in the
> future, even though --sort-by=regression may be a short-hand to say
> "we care about rtime regression" i.e. "--sort-by=regression:rtime".

Yeah, I think we can have the short form "--sort-by=regression" mean
"--sort-by=regression:rtime" and skip implementing the long form. I
will talk about the long form in the commit message.
