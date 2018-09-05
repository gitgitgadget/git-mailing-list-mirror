Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAFF1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIEUKb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 16:10:31 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51364 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEUKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 16:10:30 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so10509833itf.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=el7w/0m3AeR9oM/4wtWN90HgE19AHJatH3cdoWGMZWU=;
        b=FIU2AdyXjMK+5ZeM2G93Jnv+j81G7XKuDYANMh1vyMJz/Y+O6qOipeR8kh1A38emLP
         4hvhEU5KJcOC7ZxJco34QRp49BBeoosS1UjvKHQGrzChTS23gnVPHJ1Gy26JN0BeAFi9
         S+/VHi3TIIjOzYUDbGmwY1DP1ikxtkKst7qloKejkaqIL9dYo2yr07jOEL/PMKTZZ7UB
         TfuRWdcCsN3bglgB28ZD+/+S2aE6Ck5gzXNw4y4y6Cv0q3j83kfweCElVPRxZPIGsgoD
         qGkG0aubCbRcb9sVAOvr3j1tusmsWArLtZjwH1nk0y+7jdchE9ACSjh7ULUIHgs+xn65
         HKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=el7w/0m3AeR9oM/4wtWN90HgE19AHJatH3cdoWGMZWU=;
        b=YsDxsvNH1NoNRNBi3RwUqTdkLBWixyGzq+NDtx4VwF62VsMu1mpeZwyP+acCyECpvM
         LO5FhIX4wt8bxyV3U16t6xwTOFvrbAVQ0OGkZbD4iXNdaN127f1fTqEOH0OTnXqGcMap
         Qllj58QCdjH+TMHrSeQ4LWJ8IPTCvmObiRjOM4t9vlbC89qXgfFcQIpLXc6xXQODo8s1
         lJzwO/MCW48thoIXfTdCfO/icQ3tCNeoxt0eu7WdjD75Xmp2KN+F4kIU1gbMUc49uGAP
         WPe9R/BD9jeiCi0uhcGlFxx2MMzinM9gMtkO3TD6EG/AsIx/fXbFQoWDEfkZpnBdtdpx
         0wLA==
X-Gm-Message-State: APzg51C/J+VaqrT01plSkWVaCYgdqf2TW4hk4xHGv6c2v9crvNsX9si9
        VnYrtdoaFdUgl0eppa6mZehDoWFpuj7lB2oshxY=
X-Google-Smtp-Source: ANB0VdYFyiMvtI62euEpQtqmfQUiKAMKzZcr4MLcwF1ztR3cbwbTdUdYpyClj1JR9aHzU5l0zPeiX7icPnEzNuY5Xp0=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr873440ita.5.1536161986467;
 Wed, 05 Sep 2018 08:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local> <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net> <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net> <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net> <20180904233643.GA9156@sigill.intra.peff.net>
 <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com> <20180905153551.GB24660@sigill.intra.peff.net>
In-Reply-To: <20180905153551.GB24660@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Sep 2018 17:39:19 +0200
Message-ID: <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 5, 2018 at 5:35 PM Jeff King <peff@peff.net> wrote:
> > > +       after=$(wc -c <.git/index) &&
> > > +
> > > +       # double check that the index shrank
> > > +       test $before -gt $after &&
> > > +
> > > +       # and that our index was not corrupted
> > > +       git fsck
> >
> > If the index is not shrunk, we parse remaining rubbish as extensions.
> > If by chance the rubbish extension name is in uppercase, then we
> > ignore (and not flag it as error). But then the chances of the next 4
> > bytes being the "right" extension size is so small that we would end
> > up flagging it as bad extension anyway. So it's good. But if you want
> > to be even stricter (not necessary in my opinion), make sure that
> > stderr is empty.
>
> In this case, the size difference is only a few bytes, so the rubbish
> actually ends up in the trailing sha1. The reason I use git-fsck here is
> that it actually verifies the whole sha1 (since normal index reads no
> longer do). In fact, a normal index read won't show any problem for this
> case (since it is _only_ the trailing sha1 which is junk, and we no
> longer verify it on every read).
>
> In the original sparse-dev case, the size of the rubbish is much larger
> (because we deleted a lot more entries), and we do interpret it as a
> bogus extension. But it also triggers here, because the trailing sha1 is
> _also_ wrong.
>
> So AFAIK this fsck catches everything and yields a non-zero exit in the
> error case. And it should work for even a single byte of rubbish.

Yes you're right. I forgot about the trailing hash.
-- 
Duy
