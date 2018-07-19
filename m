Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1811F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbeGSWcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:32:47 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:45423 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeGSWcr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:32:47 -0400
Received: by mail-yb0-f180.google.com with SMTP id h127-v6so3869476ybg.12
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTqYyhF3jRrQyhAnMfqcfnQ2KJ7fW6RPVAHugOowryE=;
        b=NG6AyBruX2/DRIv5EO9fZi0GyQtQuyX9TdO66OkMQ9FHrS3WafvP0192dUDREXP1/z
         v+SdwoP4DZUv+k38c4sirvirvKEhhfKrxDdMU+U68U22fg6qh4AMUZKDyWOHzbzDTg1w
         hCh54gwlpizxMGnm+MkTZoXvHgAQ7xHbEJ8YR8IimAU2+M39LQ1FyK7oP1ZLcS8ZmYUg
         7Y2+FQwpkU5CENCCyuJeIfKEYC7t54Ct/QT89TuHOMN0LH4wQN1wmzb8axtLPVF13zta
         o5UQt7oUyMaJE6YbRzxFLlMJgOittQEMnUDqkcHSCT5RdK9msKnDgVBuB1fERXDb0yPq
         OYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTqYyhF3jRrQyhAnMfqcfnQ2KJ7fW6RPVAHugOowryE=;
        b=XBfuhlPPS5gO97zHQ69MsOeNYnr6v8OoiESX2xjy/hZYZcdjBWtnRFDD/v7GCup4uX
         O8D816SqCbfgmLYGlgfqgqL168vzdzJNqRVHij5QFMTQ4/IONuQQCzwg/ONFMGV6FdTR
         6JNedcpgwdiWMCtNLrNCx59KEjXZC2CjhcI+5oA7aUZ087KhU0Rm9chiojNR69A5IP+E
         misVj5PGweTpx6p3FzdlxxSnQQFYfeZHbtEQZHInGWngrUL1+ZP3y3ZqDVYQ1kF2HoJP
         UOpfR7FiZa2RJmUQx7moSO3BeOIcnIRXPrHfgwtXHaYwqQ525XLGwtlI2fOFLp+MiYYj
         d2kg==
X-Gm-Message-State: AOUpUlEjb3WrNP3OlnN8DSxa5Hb93OJz1Qd4ntwfJQBr7iKeIbeMykW4
        fUoLtcnyW/3w5HlezlePzkuzeMSXHwaO2fHK+1KYxA==
X-Google-Smtp-Source: AAOMgpeaWkFEhGMT43gNytz4w2Cp/QosaXNc0FbZ1yqN2RH1BrxMIDUlkTakEVI6TrZCohMkROLrDLVR9moR3INWxQ0=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr6638072ybi.247.1532036866205;
 Thu, 19 Jul 2018 14:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
 <CAGZ79ka1yHb-485xc-sAK5iVkeyWJq4Q2g-7jzEgHuVUWLBXKg@mail.gmail.com> <20180719213222.GB13151@sigill.intra.peff.net>
In-Reply-To: <20180719213222.GB13151@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 14:47:35 -0700
Message-ID: <CAGZ79kaqgF5zNC0X5+EnuPhYiaav9JiSsgeXF=deryS3sKYq2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 2:32 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 19, 2018 at 02:15:54PM -0700, Stefan Beller wrote:
>
> > >  Documentation/CodingGuidelines |  3 +++
> >
> > I'd prefer to not add more text to our documentation
> > (It is already long and in case you run into this problem
> > the error message is clear enough IMHO)
>
> I'm fine with that too. I just wondered if somebody would complain in
> the opposite way: your patch enforces this, but we never made it an
> "official" guideline.
>
> But that may be overly paranoid.  Once upon a time there was some rules
> lawyering around CodingGuidelines, but I think that was successfully
> shut down and hasn't reared its head for several years.

Heh; My preference would be to keep docs as short and concise as
possible (and lawyering sounds like "verbosity is a feature" :-P) but
still giving advice on controversial (i.e. not enforced by a machine in
a deterministic fashion) things such as having braces around one
statement for example or leaving them out.

> > Regarding the introduction of the functions to this list,
> > I would imagine people would find the commit that introduced
> > a function to the ban list to look for a reason why.
> > Can we include a link[1] to explain why we discourage
> > strcpy and sprintf in this commit?
>
> I hoped that it was mostly common knowledge, but that's probably not a
> good assumption. I agree if there's a good reference, we should link to
> it.

In this case I am just an advocate for a better history. Countless
times I wanted
to know *why* something is the way it is and mailing list and history are not
very good at that, as my specific question was not addressed there.

Either it was obvious to all people involved at the time or not written down
why that solution (which -- in hindsight -- sucks), was superior to the other
solution (which may or may not have been known at the time).

So maybe I would have rather asked, why we start out with these two
functions. And you seem to call them "obviously bad", and you take both
of them because they need to be handled differently due to the variadic macros.
(And those two are "obviously worse" than strcat, as they are used more often.
But strcat, being on MS ban list[1], would do just as fine)

(I agree that) Any other function can be added on top with its own
commit message on *why* that function. Over time I would expect that the
reason is that we got bitten by it, or some other project got famously bitten
by it or that some smart people came up with a list[1]. The exception is
this one, which basically says: "Here is the mechanism how to do it and
$X is the obvious thing to put in first", which I agree with the mechanism
as well as that $X seems bad.

[1] https://msdn.microsoft.com/en-us/library/bb288454.aspx

Now that I am deep down the rathole of discussing a tangent, I just found
[2], when searching for "how much common knowledge is wrong", do you
know if there is such a list for (CS) security related things?

[2] http://www.marcandangel.com/2008/06/12/60-popular-pieces-of-false-knowledge/

>
> > [1] https://www.thegeekstuff.com/2013/06/buffer-overflow/?utm_source=feedly
> >   This is the best I found. So not sure if it worth it.
>
> Yeah, this one is so-so, because it goes into a lot more detail. I think
> we can assume that people know that overflowing a buffer is bad. Maybe
> just a short paragraph like:
>
>   We'll include strcpy() and sprintf() in the initial list of banned
>   functions. While these _can_ be used carefully by surrounding them
>   with extra code, there's no inherent check that the size of the
>   destination buffer is big enough, it's very easy to overflow the
>   buffer.

Sounds good to me, maybe even add "We've had problems with that
in the past, see 'git log -S strcpy'", but that may be too much again.

Thanks,
Stefan
