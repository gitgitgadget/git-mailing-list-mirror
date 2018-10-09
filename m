Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CBB31F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 21:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJJE37 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 00:29:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37731 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJE37 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 00:29:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id c22-v6so3024225edc.4
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lgSLWG7AO1LIgt42Mp65PUxoo49qUFQwHVxcbU6xx0=;
        b=Dkw3JsjLiKNd7S31cer6SAW0VsYRvB4gFVe/QPr5/+ecqdfJy0+lec9Z9coh37WYl/
         90kWmCHt2LH/bNYkgbngW6Iyg0OR3qP9whcoIsvNuMTsTKHm+yw2o49bO/eglP1ucAL3
         Vbzp5KYGP2FxSrDQbXssC373ellRaoTwnM9M7Bv/DQq2dehCneER6Jqp+uTdqPxyjDTn
         gn77u1KUoSqgf2HUBNNv/84Fj76raeZhfSr++4l0923fR3ES6ESAwacAt83bssVe3WBD
         Z3IUuKTkV8Cr/iXieWIHXlW2aAzjGv+D9O688iNzizivxtMYFvNWs5jV+LcyUIdbjMCO
         dAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lgSLWG7AO1LIgt42Mp65PUxoo49qUFQwHVxcbU6xx0=;
        b=Dw+gszpFusJzbKUFHCJc2NpjUvnrDH6eoWV7fL+He8blS0RZ/uSD9YrYV6XTQIzQ7u
         o4HtuJINYzXaSeOdKd3XMzDDWo191JGZZzXuV8HWZ3nk23Ah/v4EvhbfuelChctjkuYo
         6wt+fSyqQq3QwPNbT5GacoQJtU//hGWYJUhFdQ/Raj9l36mtHFERSlVsa2NishM5w4w6
         4VXUgs2N8MQ+mD2q0iCY8Ld9Ir/1CUFXqp2xbddsMYQC1jVMDuT04zbnfZUqvpkvq51v
         m8sYdk/vJD1+5vn9IqDrdkqG90FccEcTaWkOtoGBJtfrwTf/Wx6UHGCD5oav3VncpNjU
         xGbQ==
X-Gm-Message-State: ABuFfohsH3TEkzSc169etfruFvYN6gPglZjsZ76C3BTZvFMhNmN8osQT
        GO6UQEvBxuWtkJ7LFZslq/QgmdRrQbdjlQiQuBvoow==
X-Google-Smtp-Source: ACcGV621dQFs3hruWpIX+w6eR7+dUIaalQ1TqmeEJb244GdLAlrbZ2fA85EUM4116Nd0xmQ1SdsB4WpX+r15MGa7K4M=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr37200592eds.25.1539119467656;
 Tue, 09 Oct 2018 14:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20180924100604.32208-4-phillip.wood@talktalk.net> <CAGZ79kZjAaLE7G=q9sBeEL_+Q2ufYBTn6p9TDCF8cYFd3k+0oQ@mail.gmail.com>
 <b3d29d34-616d-5d12-bb86-19ea488a766d@talktalk.net>
In-Reply-To: <b3d29d34-616d-5d12-bb86-19ea488a766d@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 14:10:56 -0700
Message-ID: <CAGZ79kYjeqME-tt89Fp=Wt0hAW0FVAyZ00ftN5XTOkFSn7Kq9A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] diff: add --color-moved-ws=allow-mixed-indentation-change
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As I said above I've more or less come to the view that the correctness
> of pythonic indentation is orthogonal to move detection as it affects
> all additions, not just those that correspond to moved lines.

Makes sense.

> > What is your use case, what kind of content do you process that
> > this patch would help you?
>
> I wrote this because I was re-factoring some shell code than was using a
> indentation step of four spaces but with tabs in the leading indentation
> which the current mode does not handle.

Ah that is good to know.

I was thinking whether we want to generalize the move detection into a more
generic "detect and fade out uninteresting things" and not just focus on white
spaces (but these are most often the uninteresting things).

Over the last year we had quite a couple of large refactorings, that
would have helped by that:
* For example the hash transition plan had a lot of patches that
  were basically s/char *sha1/struct object oid/ or some variation thereof.
* Introducing struct repository

I used the word diff to look at those patches, which helped a lot, but
maybe a mode that would allow me to mark this specific replacement
uninteresting would be even better.
Maybe this can be done as a piggyback on top of the move detection as
a "move in place, but with uninteresting pattern". The problem of this
is that the pattern needs to be accounted for when hashing the entries
into the hashmaps, which is easy when doing white spaces only.


> >> +       if (a->s == DIFF_SYMBOL_PLUS)
> >> +               *delta = la - lb;
> >> +       else
> >> +               *delta = lb - la;
> >
> > When writing the original feature I had reasons
> > not to rely on the symbol, as you could have
> > moved things from + to - (or the other way round)
> > and added or removed indentation. That is what the
> > `current_longer` is used for. But given that you only
> > count here, we can have negative numbers, so it
> > would work either way for adding or removing indentation.
> >
> > But then, why do we need to have a different sign
> > depending on the sign of the line?
>
> The check means that we get the same delta whichever way round the lines
> are compared. I think I added this because without it the highlighting
> gets broken if there is increase in indentation followed by an identical
> decrease on the next line.

But wouldn't we want to get that highlighted?
I do not quite understand the scenario, yet. Are both indented
and dedented part of the same block?


> >
> >> +       } else {
> >> +               BUG("no color_moved_ws_allow_indentation_change set");
> >
> > Instead of the BUG here could we have a switch/case (or if/else)
> > covering the complete space of delta->have_string instead?
> > Then we would not leave a lingering bug in the code base.
>
> I'm not sure what you mean, we cover all the existing
> color_moved_ws_handling values, I added the BUG() call to pick up future
> omissions if another mode is added. (If we go for a single mode none of
> this matters)

Ah, makes sense!
