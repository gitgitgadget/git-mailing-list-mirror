Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94B81F461
	for <e@80x24.org>; Thu,  4 Jul 2019 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfGDWrv (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 18:47:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54144 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGDWrv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 18:47:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so6992810wmj.3
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EUqkWP6VlQfhrBmJ/Uhyl8BEZQnH/1uQC/QHx+D+JiU=;
        b=kNOSbfnLOruI7rNXC1IInveD9+D1OMdaJ5S804SvvEKC6plbZ2LU483cJrztSmLtko
         40RlQXVO4J/r7fI0HW9i2h1XnFHRV5DUkweHj1HbgSmHGd3Y5VndE16yvrYJ6IHUWfmL
         WjyX/YA/O/V15IdOs+ErqSxjF2/Tg1YejjJcvRosByDEwHLUQPSGbkHoKS+KShl7iFyk
         YQyFYsek3BsfIB6rWVoy+Vu93Q2nMT176NTTRmv9weP6g1h0ZCvCMgKH/wCotnCPxK5z
         L+D+rQmmZw4ib4kkaIiCVYVlrLG2u5lQpqBz7JvAZdbELu3yJHy8DoDKS2fr5lOMMJ+y
         cHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=EUqkWP6VlQfhrBmJ/Uhyl8BEZQnH/1uQC/QHx+D+JiU=;
        b=kaTrKnSRODd3Q8bDa0T/sQJ379e85YnQ3MxnYC5ujBnmOhVtrgo91z/qIuMzEtKzjd
         R1eTiv0XbyDZQtTxEizwR0HtsnBz/X7hA8TF+YfoYFg/bWXyDsEYXGoFZwDvpugggA/5
         xcvFdCID7vS+eMTlhzzbzv+VhAThieBWJTPNu9jWRZlkkEhFvl9wrV99scqmdMm5B7dS
         kXkdp3YTIYl41DnNsgd/CYTiM4VO8brHwpjmuyXLX/rIHkfkSaGc31uWbyErhXNCPcsJ
         IZjWA5Ge3tXoAZcezb5pH+vTzryHZlctQKOy1zti1pyIg2bpmR/vRZxXyVWkuulDUGpI
         Mc0w==
X-Gm-Message-State: APjAAAU+t8v7Q6x94PY6bk7es5xLLrWXbNLHkHaRvc+4jHlqydMjoUxT
        nuGQhMVHVltpXNtm6xGYVQQ=
X-Google-Smtp-Source: APXvYqx1+E2swfrFk8NOH/p97Yf7Czugs+lSGAYlkTlgiEKAGL5gNpDRhc9xJnQ2qIdDW+APZFxKPg==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr235053wmj.44.1562280468926;
        Thu, 04 Jul 2019 15:47:48 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (enb96.neoplus.adsl.tpnet.pl. [83.21.247.96])
        by smtp.gmail.com with ESMTPSA id m16sm6169993wrv.89.2019.07.04.15.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 15:47:48 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.v2.git.gitgitgadget@gmail.com>
        <pull.254.v3.git.gitgitgadget@gmail.com>
        <13b9e71b383485885c4823baa466c32511fd20bc.1561991348.git.gitgitgadget@gmail.com>
        <CACsJy8Cwxov9VWq_MpeWstGtMB-rTy6LYyFj_PF9oSP0kqcDXQ@mail.gmail.com>
Date:   Fri, 05 Jul 2019 00:47:46 +0200
In-Reply-To: <CACsJy8Cwxov9VWq_MpeWstGtMB-rTy6LYyFj_PF9oSP0kqcDXQ@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 2 Jul 2019 16:20:21 +0700")
Message-ID: <86ftnl1kod.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:
> On Mon, Jul 1, 2019 at 10:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> @@ -601,3 +602,22 @@ core.abbrev::
>>         in your repository, which hopefully is enough for
>>         abbreviated object names to stay unique for some time.
>>         The minimum length is 4.
>> +
>> +core.featureAdoptionRate::
>> +       Set an integer value on a scale from 0 to 10 describing your
>> +       desire to adopt new performance features. Defaults to 0. As
>> +       the value increases, features are enabled by changing the
>> +       default values of other config settings. If a config variable
>> +       is specified explicitly, the explicit value will override these
>> +       defaults:
>
> This is because I'd like to keep core.* from growing too big (it's
> already big), hard to read, search and maintain. Perhaps this should
> belong to a separate group? Something like tuning.something or
> defaults.something.

I'm not sure if I consider core.* too big.  Well, there are 55 or more
entries in this namespace.

>> +If the value is at least 3, then the following defaults are modified.
>> +These represent relatively new features that have existed for multiple
>> +major releases, and may present performance benefits. These benefits
>> +depend on the amount and kind of data in your repo and how you use it.
>
> Then instead of numeric values, maybe the user should write some sort
> description about the repo and we optimize for that, similar to gcc
> -Os optimized for size, -Ofast for compiler speed (-O<n> is all about
> execution speed).

I also do not like those magic numbers.

>
> We could write, for example, tuning.commitHistory =3D {small, medium,
> large} and tuning.worktree =3D {small, large, medium} and maybe
> tuning.refSize and use that to optimize. We can still have different
> optimization levels (probably just "none", "recommended" vs
> "aggressive" where agressive enables most new stuff),

I think we have three different things that are currently conflated in
one config variable and one value.

First is what we want to optimize for; is it on-disk repository size,
command performance / execution speed, or maybe convenient information.

Second is what type of repository we are dealing with.  Is there a
problem with long history, large number of files in checkout, large
and/or binary files, or all together?  The original `core.size=3Dlarge`
(or proposed core.repositorySize) was all about this issue.  Another
issue that might be important is that if it is leaf developer
repository, or is it maintainer repository, etc. (which affects for
example how the push looks like).

Third is what tradeoffs we are willing to accept to get required
performance.  Are we willing to use additional stable optional features;
are we willing to use new experimental optional features; are we
willing; are we willing to sacrifice convenience (ahead/behind
information in status, information bout forced updates in push output,
etc.) for performance?  This what current proposal is about.

It may not nnned to be a separate confi variable for a separate aspect;
it may be enough to have value that is space-separated list, or
something like that.

Best,
--
Jakub Nar=EAbski
