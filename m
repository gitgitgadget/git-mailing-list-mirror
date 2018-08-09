Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92A3D1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeHJAT3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:19:29 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:34541 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeHJAT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:19:29 -0400
Received: by mail-yw1-f50.google.com with SMTP id j68-v6so6819495ywg.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79qOwjzrpqIxErircqUtz8eFQZvjS5nk/xr6/2qdCQs=;
        b=R5CqsNoPeZQxE7uFgNnGEh94YUTW8ciBS62PwYjcgHkLyl6vSp2XZ+SXWqRym+4BH6
         yrYdF2V+NDdxOISFzvL5ZBEYf/ew3C7rt4maOp+hGH8VQu8xp8vJTssD4LfBMUwp/i6e
         E9q4JtG8Q8rHlKdbLF04O9qSUALKyqXlGSev6mJpFqcvZ9RZAqpXqUU0qysKaPjxTHcG
         wHUhME6/9s6yNLpeCbKhJoZbjUo1X0YeEgJtIwR2X2/2mvc9Pn1q9+V1DQxFi4dTqm1o
         MCS4fv+SPsogC5LDA5pMJLK7X8i5PXLxe63qMzLfYxpycUSs9G34ej20KPwewsm4xPfh
         v8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79qOwjzrpqIxErircqUtz8eFQZvjS5nk/xr6/2qdCQs=;
        b=i5UZPybdK4TX/itlyZKYAzvBKmTWuYVH7J4HkWP80Dt9ctpuUe4YOeon0pROzeYwoK
         AoKaOWcbfPt2jJe0FJ8+5TpjKoTHPgtTeA1aG6BbweDzXh+84Xyrs4J9qBCaQJZYS8m2
         a9XGNLhb4qoZVwLNeco4lGUHTjR69hH3/Z7O2ugVsm78r20iMNow90RX5V/5eMS0ECNb
         Ieabjc0nbDe/o0o+llwzzhLzROeG52D8Lw9mBbqNDbx3tEyyZLZp9HOjXGIEwKhlVfLA
         twQIaNrAdTEhnZG+UUOAjE8GRnb4wT+7YKvZoMvS6NbiYg6Vu8RwOBVmincq40YSbDa+
         AtsA==
X-Gm-Message-State: AOUpUlHJUjLSl34jCx+uB9EoDvHC9WHmYp7QF2MJP8XKyIEYCDGxNgSr
        yC7zyOpAZCmPewB4O1jC/VXC243DkNh8ksQUdm6M/A==
X-Google-Smtp-Source: AA+uWPyvy3bwGuUcEt/bz/0E3x0+iqjCXb6KKCvDoaR1HWXKECbDbgrI7Wmic4rbBQnV75P5EvZAzwLqBrMRrNTxFR8=
X-Received: by 2002:a81:37c5:: with SMTP id e188-v6mr2237299ywa.340.1533851560882;
 Thu, 09 Aug 2018 14:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-3-sbeller@google.com>
 <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
 <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com> <20180809214148.GD11342@sigill.intra.peff.net>
In-Reply-To: <20180809214148.GD11342@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 14:52:29 -0700
Message-ID: <CAGZ79kZK=5gftetj3XLTbu-n3WKwRUQQDj12yxDBV0WEN8gg9Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] string-list.h: add string_list_pop function.
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 2:41 PM Jeff King <peff@peff.net> wrote:

> >
> >       while (list->nr)
> >               work_on(list_pop(list));
> >
> > which is not so bad.
>
> In many cases you can just do:
>
>   while (list->nr) {
>         work_on(list->items[list->nr - 1]);
>         list_remove(list, list->nr - 1);
>   }
>
> and then all of those memory ownership issues like:

[...]
>
> just go away. :)

The only complication here is the lack of list_remove(index),
we do have list_remove(string), which internally searches the
item and removes it. Hence I did not want to use it.

Another idea I had was to keep the list immutable (except amending,
just like a constitution ;-) and store an index of how far we got in that
list already. That wastes memory for keeping entries around, but is safe
for memory due to its nature.

> Where that falls down is if you really need work_on() to put more items
> on the stack, but only after you've removed the current top. But then
> writing it out may still be nicer, because it makes it clear you have to
> do:
>
>   const char *cur_string = xstrdup(list->items[list->nr-1].string);

Another way would be to use

  string_list_pop(&list, &string_dst, &util_dst);
i.e.
  /* Returns 0 if the dst was filled */
  int (struct string_list *, char **, void**)

as then we do not expose the internals and would not have issues
with reallocs.

> if you want the data to live past the removal.

In the code proposed there are no additions (hence no reallocs)
and the need for the data is short lived.

But I can see how the design was just fitting my purpose and
we could come up with some better API.

Thanks,
Stefan
