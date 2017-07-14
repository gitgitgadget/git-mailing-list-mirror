Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6F420357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbdGNRNw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:13:52 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35772 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdGNRNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:13:52 -0400
Received: by mail-pf0-f171.google.com with SMTP id c73so48343664pfk.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCgKCnOBQCD13KZbiAny4iATNsv558jICzvdL5XiQIs=;
        b=jBxsB8cgbgy1nnNVpgVz8TkuJUWktC9y4Agj099eOtkkDsf6xICLPk6qydx79AI6gC
         YrPo4ok6RmjVRnWmlCmLL7nwbZxRqApCImf+fCp7aXw0lh1bZEWyHyijeh9Bs6yXAEXO
         M8ns/mJQSLMY+Yql9XFScWgt3kOgnBQzimzf4on95HoGI+M4mXfzHWExKoBadKo+kJKv
         VhQon6Jv16GyAOD58qu1sHY3lMaTTXI/E9BKyW0QhgaBVWiTqhp06K5737+DqP+TsSJy
         XanCPoJeuD7E5MuoACfhJFXFXUx2mJWXlkkbq1h39dYca4G4I4KzYpZtbid9pV0hYXhD
         BVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCgKCnOBQCD13KZbiAny4iATNsv558jICzvdL5XiQIs=;
        b=XDYlcXBGejTYrf5VAxq/dCBEyQGPbtMZulDcDBT/lhFh9UwngGRvttloQCJ5WKhqkl
         WMsMCs4QeqfBVQp/+JtLhRT6a2GJnPdi2cT0KNIzfRMlF5mSAn7tU/VajdeFNzwh6Sds
         9MOYmma8iT3SCeCbaT/EUdX2Z7TORNKXyUCBSMeih15h+SZE93Tv+Tw54I7MRn4eQ6ln
         rFnBYSGU5eSPDe4ovyj+HeO9AJTVa0v3ytjVrNltGm1leVKlo0MGmOYOgGKysRGyztER
         qMiTZ4iUTYIS5xIq5SXgvlN1aiiBGk4NS6dEXqK2RYrO0NwcFxDrggRhyD2Qs8j2YsFl
         5eEA==
X-Gm-Message-State: AIVw1116NDHIl49K3xbsTxiHh7pgyH51gLjPRo2PNJFyTy8o2lZS+zu/
        Iwqf3MsM3xHBsZk0XO67pggnuzP01wXg7KRXvQ==
X-Received: by 10.98.139.137 with SMTP id e9mr6441036pfl.66.1500052431025;
 Fri, 14 Jul 2017 10:13:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Fri, 14 Jul 2017 10:13:50 -0700 (PDT)
In-Reply-To: <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org> <xmqq4luk58ot.fsf@gitster.mtv.corp.google.com>
 <962da692-8874-191c-59d4-65b9562cf87f@kdbg.org> <xmqqy3rw3rc8.fsf@gitster.mtv.corp.google.com>
 <xmqqlgnrq9qi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 14 Jul 2017 10:13:50 -0700
Message-ID: <CAGZ79kaFH5BXEsTEz55NbfhrJoWfutTVQi-bv3NpomCoK9OzWw@mail.gmail.com>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 9:11 AM, Junio C Hamano <gitster@pobox.com> wrote:

>  - I prefer to keep decl-after-statement out of our codebase.  I
>    view it as a big plus in code-readability to be able to see a
>    complete list of variables that will be used in a block upfront
>    before starting to read the code that uses them.

sounds good to me.

>  - Corollary to the above, I do not mind to have a variable
>    declaration in the initialization clause of a for() statement
>    (e.g. "for (int i = 0; i < 4; i++) { ... }"), as the scoping rule
>    is very sensible.  Some of our "for()" statements use the value
>    of the variable after iteration, for which this new construct
>    cannot be used, though.

I might send a test balloon for this.

>    . // comments

I would think these are useful for two reasons:
(a) these seem to be used widely outside of these old-style project
  (git, gcc, kernel), such that most new contributors need to be told
  to avoid these which adds to the entry burden.
(b) recursive nesting of comments is possible. We may not need this
  in the final patch, but I sure use that in development. To comment out
  a whole function containing multiple comments I have to select all
  lines and prefix them with // currently. If all comments were //, I could
  put /* .. */ around the function, which seems easier. I just realize
  I can use #if 0 .. #endif though.

  (a) may be a concern, (b) not so much from the projects point of view.

>    . restricted pointers

That sounds like the ultimate micro optimization, but may be hard
to reason about after a years of churn, so it may become hard to
maintain.

>    . static and type qualifiers in parameter array declarators

That sounds equally arcane.

> -- >8 --
> Subject: [PATCH] clean.c: use designated initializer
>
> This is another test balloon to see if we get complaints from people
> whose compilers do not support designated initializer for arrays.

This sounds as if it is applied on top of Jeffs test balloon patch, such
that we do not need to re-iterate the criteria why to do it here, e.g.
this code is always compiled and did not change a lot over the last
couple month, so potentially easy to revert.

Thanks,
Stefan
