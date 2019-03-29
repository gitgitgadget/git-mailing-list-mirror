Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A7F20248
	for <e@80x24.org>; Fri, 29 Mar 2019 23:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfC2X0C (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 19:26:02 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40852 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbfC2X0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 19:26:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id f22so2287847vso.7
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/RApIPS6iy5lPLvnSrRklc22lW2JrJE6t/h7wrx2Xs=;
        b=fL9moHd88AxR0Y6niLudwsiy00QKnpVh5vodAlbOrMsGZVhTtUB1jOp7WRcf76qWlW
         ov90CFArX1KgQ9mMEE3l2lj3PxGmFENhTAWhP21kvnQDgWAXOH7IP/kd+AmFeZ3DyCJA
         L6ZOOlJuRszbB3cmTFDCWGtsFN6cOjhMT30jKQ1BsyZX0DOZGz6wAQc2Obgt/038Z3KV
         m2J3SiTe9vPrqThk8UsP/dx6pjQk6dv150/PuAH/NsnuuJ3x3UJg3dG+y08MChwaZE1J
         ZAJq5cptE9093hX+xiz7/Hok4sZCTAxxAJky94zstu/ex12SEmH9fIz0wEg9rERenILw
         tUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/RApIPS6iy5lPLvnSrRklc22lW2JrJE6t/h7wrx2Xs=;
        b=IO7YMbnLEpkE/PHw7vwmI+KIyD4skOwWYfdDJNIzCjU8r2Jkkv6b/ePZFm6gJCinqV
         /QU28AJBZ9kcRrQbsvwq0FIU+3ttlMqNYh4P1DhyGngLeDstsLa/1ZbZM0Yh/YwiPste
         e7N0z42RsLDyAmeFFs4KbHgal96l9V8bgl7UUQYo6qGS+ae3+E6Bw2+xS0XXKFMvavSt
         ZJA6NMv4jFjXyxApg/Uom2MRX7cgSiwZst0A7GvsHqrCd9GkP/UblkyHcYVTXHlJe5hE
         MpGxI75Ne+/J167qCr6lM+/utl8Ff+5KYrC2DLR57Rahq2V8Ao9ATxY+T/dYJlt7FKwd
         nfTg==
X-Gm-Message-State: APjAAAXjNs7lE4pzxovOJAwjPAfVcZtGmugppkOY04zgokRo0Re/ndrc
        WjqZxEkRcwborNwRXZxsfP15M0otZOBuq4Ir1vidGrJ4
X-Google-Smtp-Source: APXvYqwJKvjjeJYv4rBiu8QkveNDh4q+Aeh4DF/i1bGo1PvVPmhgecqBeyMQ+bYnPOT6Gd/w4g3RFNLLambOQf/CqEw=
X-Received: by 2002:a67:ad0a:: with SMTP id t10mr31986651vsl.117.1553901960701;
 Fri, 29 Mar 2019 16:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190329223228.4924-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190329223228.4924-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Mar 2019 16:25:49 -0700
Message-ID: <CABPp-BETuwt96jeBMMhzT84-=-MqEA3D7uhLb2uxW3fijx7p7Q@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        artagnon@gmail.com, Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>, rafa.almas@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Fri, Mar 29, 2019 at 3:33 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hiya
>
> This is the v2 of the draft proposal[1]. I've added some details to the proposal,
> it talks more about what to implement instead of how. It is still incomplete.
>
> I'm currently adding more to the overview section, where I'll document the work
> done by Dscho and Alban. After that I'll find files that will be changed while
> implementing rest of the flags, finally add the basic control and/or data flow
> of the 'how' part.

Overall this looks pretty good to me, just one question...

> 3. Now that I'm familiar with the code, I'll start picking the pace now. And
> start implementing the meat of the project. The flags. I'll start implementing
> the flags in the following order as [Elijah suggested][12]:
>     1. --ignore-whitespace
>     2. --committer-date-is-author-date
>     3. --ignore-date
>     4. --whitespace=...
>     5. `[Bonus]` --signoff

--signoff is new and surprises me.  What's the plan with that one?
