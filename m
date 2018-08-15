Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B281F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHPARL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:17:11 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:35151 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeHPARK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:17:10 -0400
Received: by mail-yw1-f47.google.com with SMTP id s68-v6so1938909ywg.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GeDWtLhAk3Un4XwfhrTZecGhMAOgGmh17MXqXSt53Tc=;
        b=Vm76sJB8qXvQ4wXZ151cWI9HalJNOIW6ekns0pQEwlshLyXar3tZhrXc88Kp7eHt4M
         lgaQe86AS407hjJsnr29A0w1zABjbTH4NEE/z1RItmBrB9129HHU1tTt+mOFq0HUMOT+
         dg7m9rKW60GQ1ib5JaxEjyBODSAgimPOpgT9dfpeNBFf/FKcHk8YgxO1G2KbJauP2IPb
         GNqoo2aXpD8APaLYdhkp5YuwxG+VVBaM5506U/EbuvQJMUWr4AlU5GiLV8LazfV/U2Zf
         u8xM4ExvBuV+bFIxoht6T6P/fwh0y/IsLdr89/Xa6pOTNuVBrE5CP826fGUzPFc4QYm7
         xMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GeDWtLhAk3Un4XwfhrTZecGhMAOgGmh17MXqXSt53Tc=;
        b=fYaHDGqY+D3nNVhoRY9KOtbkcV+i8ZVlN0tp5ZgM66VJeV+YTe/uCMtrXWpbHQ+muB
         YDTzeeTajxdb+/trOk6XInFb0XWbXGW2ihNxLXimHi11pIL7Q1IX7bPPuFWgI9Kj76R/
         bba94ULXUX9Mjkg8nnNUV/elovpXH8C1HcxI7vFsgwH9fQXbLUmIB6KQFsnCSk3oA0Ij
         DIj/DeE8SvR66Nft3oiRJZJ0lV4KVAxwTNlhng4c9QEIhkjiRJSEncqF9RFZicrmDOnv
         ly0uVQ/Z1MHN3Yn/bYyo8eOQOy90O6ftv0SPoiFdXYscVjfOsdBm2rMzY4B++CAzDecH
         mu+Q==
X-Gm-Message-State: AOUpUlFZoqlJAy6X9J7R34tKplu2d3RYQlCeyEfczHPZ+ONh8lLFFMj3
        Evy/hgf0OWjO5DZWc5pGuetlmq1zN6YYXkqN9XZ4F3Fk6To=
X-Google-Smtp-Source: AA+uWPwtUeEqTNjGu+vsWRdkrmeUBZ3kOsDSIKnEIugXeimlE1B6WRz9t93CHXprJLUSKtuuiiITPDMqXRi2HgXKsAE=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr14643876ywj.33.1534368195646;
 Wed, 15 Aug 2018 14:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
In-Reply-To: <CA+55aFzsVt9CJOBPGABcvg464W1THvwYpNhO+9DWUNw4X36Ndg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 14:23:04 -0700
Message-ID: <CAGZ79kaByLdAhf4tN0P+B_S6=bC=s8oKN8NpsX1mgXODR9stAA@mail.gmail.com>
Subject: Re: "less -F" is broken
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 1:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, as of less-530, the behavior of "less -F" is broken enough that
> I think git needs to potentially think about changing the defaults for
> the pager, or people should at least be aware of it.
>
> Older versions of less (at least up to less-487 - March 2017) do not
> have this bug.  There were apparently 520, 527 and 529 releases in
> 2017 too, but I couldn't find their sources to verify if they were
> already broken - but 530 (February 2018) has the problem.

http://www.greenwoodsoftware.com/less/news.527.html
http://www.greenwoodsoftware.com/less/news.520.html
http://www.greenwoodsoftware.com/less/
Release notes for 520 and 527 contains:
 "Don't output terminal init sequence if using -F and file fits on one screen."
