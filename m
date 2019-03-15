Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F19A20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfCOQ7q (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:59:46 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37125 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbfCOQ7q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:59:46 -0400
Received: by mail-lf1-f53.google.com with SMTP id u2so7345689lfd.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dH4soigj2q9JajvLMWPPxJA4p2qk5N5YiP5F51OHXgk=;
        b=DFODHdFZpjb6XmuPmYiDwd5dXIEZYlU9V+EcR8rxMPc50j+lGygJRClsqZ1T6k6MWh
         dZb+rqEwZP1JIySrEhhMakgycibOFJC89eY42FvSLgR3lnRdR1/V+gwwDMxPVlCMzyO4
         OILKkYNdQ622E0Ht4EBKS8IHAqDvFy8x9GG0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH4soigj2q9JajvLMWPPxJA4p2qk5N5YiP5F51OHXgk=;
        b=Z0pbNeMQYC7r9PArQkFdCFYLmnZRV5O1LIYahDbZQdtoQqJdbvmVBXSz9TqRCbhvDX
         7doTqNC60RVljdizH0DG8c+d6N5e0V5lRQVTYBl0B4Y8VgTLT7HfSxockXxokJcYYGkm
         EhwoP0fIuhSZ/sQqwfX0732ZfB7mhMaAHPgeASe3PWh0RxGhAutgScPH6Bu0FOlGXtAc
         biXTue1U5+MueGuHwcQLvCoSA0ZjuwvT5VL9/aaeMbosbdwrONN+P0d3em9u7xDlFKnf
         DyTpeY1iWwFURdCriLSBaL7qd2r5CxEFe8CjhB3GB4Q9p+bSaGrhF8hf93BR36XHqVM2
         PF7w==
X-Gm-Message-State: APjAAAU3MIOpjsBgoM1leYEqAeHVvTYx29V6Nj/oPkHskUXL+o9lPlSg
        T68YpTyrAqUOvlmwTUqagduVTYbqoXs=
X-Google-Smtp-Source: APXvYqzQet05l8RH98D6J2m2MF0k1nCV6P+JEAulzW5XbhoctNFexbWl879ioi7/MgHHiszjQlUTQQ==
X-Received: by 2002:a19:4f44:: with SMTP id a4mr2726266lfk.72.1552669183410;
        Fri, 15 Mar 2019 09:59:43 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j7sm510714ljb.1.2019.03.15.09.59.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:59:42 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id t13so8574288lji.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:59:42 -0700 (PDT)
X-Received: by 2002:a2e:8585:: with SMTP id b5mr2767458lji.125.1552669181745;
 Fri, 15 Mar 2019 09:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
 <xmqqk1h09224.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1h09224.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Mar 2019 09:59:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whe+R7fkTi0eBnhrBY=_k_du3e5dkNsVe=HgKXLoXekdg@mail.gmail.com>
Message-ID: <CAHk-=whe+R7fkTi0eBnhrBY=_k_du3e5dkNsVe=HgKXLoXekdg@mail.gmail.com>
Subject: Re: "Problems" with git format-patch --thread email header ordering
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 9:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > While it's true that header ordering isn't specified, there's a common
> > "canonical" order that the headers are listed in. To quote rfc822:
> > ...
> >             body must occur AFTER  the  headers.   It  is  recommended
> >             that,  if  present,  headers be sent in the order "Return-
> >             Path", "Received", "Date",  "From",  "Subject",  "Sender",
> >             "To", "cc", etc.
>
> I obviously won't do the last one myself, but if the issue is only
> to swap from and date, then this may be sufficient, perhaps?

I'm not actually sure _what_ the order requirements for gmail are,
since gmail itself doesn't seem to honor them. Does the order of the
Message-ID header line matter, for example?

I don't think it's the order of the From/Date lines, actually, because
google itself doesn't do that.

What Thomas Found out was that the exact same email with

    Message-Id/From/Date/Subject/To

(in that order) does not work, but

    Date/From/Subject/To/Message-Id

does work. Weird and "wonderful". But there might be a lot of other
orderings that work or don't.

Having looked through some other emails, I know that

    From/To/Subject/Date/Message-Id
    Subject/To/References/From/Message-ID/Date

also works.  Which makes me suspect that it's the Message-ID line that matters.

But it might be something _really_ odd, and maybe not just ordering at
all (ie it might be something where gmail wants to see the "From"
line, but only in certain circumstances, and only *then* does it
matter if the From line comes before some other line or not.

All we know is

 (a) gmail complains about the normal git format-patch ordering with a
"no From line" bounce

 (b) the same email with just headers re-ordered goes through

I *suspect* it's that Message-ID line, but .... It's very annoying.

               Linus
