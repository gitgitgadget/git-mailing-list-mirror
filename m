Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5DF1F42D
	for <e@80x24.org>; Thu, 10 May 2018 07:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeEJHr0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 03:47:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46270 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbeEJHrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 03:47:25 -0400
Received: by mail-pf0-f178.google.com with SMTP id p12-v6so660556pff.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wIc2HsTU6BJyYkcpi44GfkLPVYkz4o9HASxvUYNQDnA=;
        b=u4MSvElobObwUMyIffeCnENk9u6CLfj+gucdCm+ikSTRgWNRqNLCOEb2CQO1/10qgb
         /T+XKbofsryih2zLG4k2MgukNAa9aQdo2euE8Yxzh2+rjIyaHwcRS0nSpp/xWQ5uBTKD
         0/gd86W5AP3ldzPF3RvtxliWpP1xWaa2XLeS6f0aCwl+nlN5VdqLemomc+tOnKasf+rq
         FM2cNehTiVRBAaUmImDMJAk5wClZkZ4tlkhn8iUBAlmWTFNjZHM7dxzvd9hLDpTPhSTf
         bQZEtChO0B9EH1FBcszTBL6d4oe0ez8wSTM7BZzCdamth/h+R/hZJ7FY2nw+xLsqjkO4
         6Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wIc2HsTU6BJyYkcpi44GfkLPVYkz4o9HASxvUYNQDnA=;
        b=JpgHs1jWhRAOi4vNmTWA8/7C7FVKAK3mYz6UH7ci0QkRM+KJ8+dACDeB93M79JrtZH
         HeJxP8NPgQkqlWuKZ/HRLWNAY0S0sSy4E6StfVxaUPn6burCpvQ9+SqK1naDu7V14OyV
         KUXZyRX+LP21qDQhGzUGtJt6lXuPkaC7BLD9BXneKRZLoxQWRBpMwH/psDbDZtWhaWEl
         +URGHn+wCFfxdu6qED895QyfTQkMsLevMJRH4aDsoJxZK/bzzr9E/aqsXxsZRf44IPZt
         1EPvvC06jYuV4poQpdDpygx9b+0gfiC/o+BWhzj1y9jtb8TZ7UlVzUBRlpoYXDgWuyAQ
         Ap9g==
X-Gm-Message-State: ALKqPwdizwRX71bVPl9mLkoO44DYBCia/vBNPGfk3hVbq2+BtWkZ0VKL
        PWth3/jGukQrmpPUyWe+EX24ZsMLfM0vIuPb+dQ=
X-Google-Smtp-Source: AB8JxZqaUvf6Mxips6qkN2Vah417jeMvByEnXFIm+6Q8L1OX54gWp3ZoGsrt63apEfjqDNpzeCVKRUvyJ1WkF9hlERI=
X-Received: by 2002:a65:5c06:: with SMTP id u6-v6mr296770pgr.316.1525938445488;
 Thu, 10 May 2018 00:47:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 00:47:24 -0700 (PDT)
In-Reply-To: <xmqqwowcjbh6.fsf@gitster-ct.c.googlers.com>
References: <20180508182548.GD7210@sigill.intra.peff.net> <cover.1525898125.git.martin.agren@gmail.com>
 <20180510052137.GC27259@sigill.intra.peff.net> <xmqqwowcjbh6.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 09:47:24 +0200
Message-ID: <CAN0heSoM0Vd73o9FmuLcDK+ojEcOwhfZRK24JypBQFz+_18uGA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] getting rid of most "static struct lock_file"s
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 08:01, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I don't think it's worth re-rolling, but one thing to think about for
>> future cleanups: you split the patches by touched area, not by
>> functionality. So the first three patches have a "while we're here..."
>> that has to explain why dropping the "static" is the right thing over
>> and over. If you instead did the error-handling fixes independently
>> first, then you could lump the "static" cleanups together with one
>> explanation (possibly even just as part of the 4th patch).
>
> Thanks Peff for a good pice of advice.  I agree with the assessment
> after reading the series through (includng "not worth rerolling"
> part).

Right. In the first version, the while-at-its were really while-at-its
-- and it turned out it needed some motivation. So, in the reroll, I
focused on expanding the commit messages. Any benefit from making
patches four and five somewhat smaller definitely got lost in the blown
up first three commit messages. Thanks for pointing it out.

Martin
