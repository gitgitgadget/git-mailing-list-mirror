Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 870511FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 14:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbdJHOYz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 10:24:55 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:48471 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdJHOYy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 10:24:54 -0400
Received: by mail-pg0-f48.google.com with SMTP id v78so10189003pgb.5
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f7fbkPWQFW4+fFef0Y79DzyOC9e6FQmL0pxi1HYiVT4=;
        b=bcwwlDIRAFkGBd1yLpxq0zrjvCuIM/NUElAab5tvrZmwuqS/q5yLMKuDYnM4yMsGHu
         KSbUqNBzcJfTrMePnQQS1XKo3mnTeFlT2BB6a20/iLCbk2NwARJNgeZOAX/VR5L10ZBv
         b8WaZmMix24lMEZKH/izkp9nursSAYBxHxd9X40xxABDbhOMKxh9Tu1uBjhuCoXTYqXn
         kc3VYkl6+0rLZr0tGRxqnZQpfnX5gtb76VNntmspO3vPobLljdc3lbXibx/nCzgSyxZh
         SDaoDFSwuTw2QlYVkj4sbE/InychT1U096UxsoHV+xceFSFNK4AgdW8qk4RS0KQsg9jk
         wvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f7fbkPWQFW4+fFef0Y79DzyOC9e6FQmL0pxi1HYiVT4=;
        b=Z49hmTS3Tlot57coGLnk6oGNBXoaz8gGTxRs9kJ1yjAY1X6ixKzxl8Secm6n6a5ApN
         FZJFgyuKpLS71zLXr+N4jQX291XVySCwDanKUlWPrt1bp4X+E6z+VKJsPA/fzRIsRun/
         aYE5x6RKcIZ/vPQcdUw6/u9cdpWVjzUuj+Z995ED7xH6Wq5OPkrDF92uZtT9BXvbnbMZ
         4FtwKazmd6La5pbEHs7ENodQdtrBHLQzaUHi/DGLErVDSrlO6Ao782t2u+l/gYiO3WEd
         nN9RbwDuViyK5KRzoYuBNcIqXKgsPjgT6nmavEBjF0byUqQoRMS6HijHpTebjuTxPwvK
         ZO1g==
X-Gm-Message-State: AMCzsaUHnndFxlaS6u4B5D48r0laxoTP7NH0b5jg2YGn50VHu+oYw8UB
        qQnaYHb/qndoD3iGCKyBAOjnIcGD8gD+r4KuMsA=
X-Google-Smtp-Source: AOwi7QDuJ7TaN39i4/nZj8fFLlKT6UpBQiBYYXbtmQX2AGGWz49AX7EQm3A5BGdf/Fq2kKONiJRMVOyuwgq/X8MrC+Q=
X-Received: by 10.159.198.74 with SMTP id y10mr6930803plt.45.1507472693992;
 Sun, 08 Oct 2017 07:24:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 8 Oct 2017 07:24:53 -0700 (PDT)
In-Reply-To: <CAGZ79kYnhxZs0ptpuiSuBhwYBfOm8NiK4a15Zwas6vbjWWZukA@mail.gmail.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com> <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
 <xmqqr2ugv5om.fsf@gitster.mtv.corp.google.com> <CAN0heSo28RYmZKxY4UXq9ewVgYGJCXGf-6KSzkOB-enZppv5qg@mail.gmail.com>
 <CAGZ79kYnhxZs0ptpuiSuBhwYBfOm8NiK4a15Zwas6vbjWWZukA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 8 Oct 2017 16:24:53 +0200
Message-ID: <CAN0heSpgZij9qO7NqoT6JWjDdGcJHJjReB-4Ps1MmOvs=857Lw@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 22:27, Stefan Beller <sbeller@google.com> wrote:
>> I might be naive in thinking that protocol.version could be removed or
>> redefined at our discretion just because it's marked as "experimental".
>
> Well the redefinition might very well occur, when we now say "set to v1
> to test v1 and fallback to v0 otherwise", but long term we want a white
> or black list or some other protocol selection strategy encoded in this
> configuration (we would not want to introduce yet another config to work
> around the initial "failed experiment", would we?)
>
> And hence I would be careful how we define the meaning of
> protocol.version now.

Good points. If we want to go for a more general / future-proof wording
now, then we must already now implement the config-parsing as "does this
string contain the word '1'" instead of "is this string exactly '1'". If
we claim that "34 1 5" is a valid configuration, then the implementation
should accept it. (We'd probably also want to verify that there are only
integers and spaces in the string.)

> For example we could instead now claim "protocol.version is a whitelist
> of protocol versions, order is not specified. The only guarantee we're willing
> to give is that no protocol is used that is not on the list".

If we want to be able to list more than one version, we need to define
how to signal preference from the first day, IMHO. (I know you just gave
an example; I'm simply responding with what I think makes that example
non-ideal.)

The fact that v0 is requested by lack of data and all other protocols
(whether v1 or v34) have to be requested by presence of data, is a bit
unfortunate and it is bound to bleed through into the definitions, at
least until v0 is simply ripped out of git.git. Ok, this definition
suggests that "1 0" will be the preferred variant for checking basic
robustness, while "1" will be how to ensure you have a peer which knows
v1.

> All I was trying to say initially is that "we may try (one of) protocol.version,
> but fall back to whatever (currently v0)" is too broad. We'd need to redefine
> it shortly in the foreseeable future already.

Yes we would. I'll post a suggestion elsewhere in the thread.

Martin
