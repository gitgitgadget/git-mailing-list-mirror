Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1921F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbfAOTi5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:38:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38543 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfAOTi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:38:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so3538965ede.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK5EswDHmkrkFh97wa0CJ4spP5cc/EoH7FDuUjQvfaA=;
        b=i978d4/5SjKfudeM8y6Ll0FyV7y/NiWLE0c/1leHxCx9LFxXyaNtB49+99og9Q0fUP
         ET5IAsK7NFd0CaLaHhnuaJy9stvl/zjmSrB0tDtdNIDaFC4jOGGtoA7JoGF5/y54JQf5
         RFAUq/rK0oMBtYM25C+1lYileJeDKbbPVslAO4mAQMDcY3RYD1/Ckt6x17/jQ2Z8HdQ/
         LOhmhk6Br/ioQymSM81e/h7mRY32kIWuoEkEESn5ho0sxM+Ng6LTLjYHzTGmbM8FdTt4
         uJvjwnhcdFUAN+7T2OeG9VlMxIoHulrQU+7Ni+yNen0jAboGijQgYJEvyippls9hwIgo
         RLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK5EswDHmkrkFh97wa0CJ4spP5cc/EoH7FDuUjQvfaA=;
        b=CjmbT9MwhLNxYrHwSTJGcy4ltXMhBXyQpIE8T7lynzvhxT/MY6RQYbMGW+tUr8hwKt
         yr8J7R4dBRONRGeJjnnrDuEi5Vh/24c+UNTRo8IbVplN4ybRwPZ3AziSDgWBJSl774U1
         7lnBl7cqrNcsaQ7iCructtfJrKvGH2yjDOH7wX1TLg9jCm3iT+io/lIdRM+W7wVqryC+
         o6GTAX5Im7WTWWMOE6y7nlJ1pNo2H2fMsvNmzR57uwabNJpR9iLJYallhTjZHyzNaVj2
         HzbIoJPyf77ugq8kix+1P6xSRMtzP1ll2nHa8tfqNuAFgsiEDBj3GL/ALN4784nxtUei
         UeGw==
X-Gm-Message-State: AJcUukd3abPS+20lOAE6s6vYJxWaCkHUo8iUfZoUgjc1GbXJNier5XtO
        DB3JiuytB8IgjvhwYxXC538YiJyVL1npV0risdOF5A==
X-Google-Smtp-Source: ALg8bN6Cie47iNGWPzEcCrb229GMO4qTaN7YW61zrcNYchM4JrkmbzSQoo/IBoyD/4TtVQMW2ogfb8Sm6KT6ig47kd0=
X-Received: by 2002:a17:906:198b:: with SMTP id g11-v6mr4070700ejd.166.1547581135130;
 Tue, 15 Jan 2019 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20190111221414.GA31335@sigill.intra.peff.net> <87va2u3yeu.fsf@evledraar.gmail.com>
 <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
 <20190115191359.GC4886@sigill.intra.peff.net> <xmqqy37lra1j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy37lra1j.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Jan 2019 11:38:44 -0800
Message-ID: <CAGZ79kbbhdFCPbEEZzwmti0zTDCG429Moa-T77DNmCx07svM2A@mail.gmail.com>
Subject: Re: [PATCH 0/6] getenv() timing fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 11:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Sat, Jan 12, 2019 at 10:51:42AM -0800, Stefan Beller wrote:
> >
> >> > I wonder, and not as "you should do this" feedback on this series, just
> >>
> >> There is a getenv_safe() in environment.c, but I guess a xgetenv() that
> >> takes the same parameters as getenv() is better for ease of use.
> >
> > Yes, but it punts on the memory ownership by stuffing everything into an
> > argv_array. That saves a few lines if you're going to ask for five
> > variables, but for a single variable it's no better than:
> >
> >   char *foo = getenv_safe("FOO");
>
> You meant xstrdup_or_null(getenv("FOO")) here?  And did Stefan mean
>
>         #define xgetenv(e) xstrdup_or_null(getenv(e))
>
> ?

Assume I did. (I thought of it as a function effectively
adding the xstrdup_or_null)

If we go further into assuming the usage patterns of
these xgetenv calls, we might throw in an UNLEAK
as well, but that might be over board.
