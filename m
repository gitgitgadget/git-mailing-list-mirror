Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4281F405
	for <e@80x24.org>; Thu,  9 Aug 2018 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeHJAhZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:37:25 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34776 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeHJAhY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:37:24 -0400
Received: by mail-yw1-f66.google.com with SMTP id j68-v6so6889101ywg.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsH/kSrTnUfwk1mAp1WD3UEymx55DgXbIiEvNjxHpt4=;
        b=KY05r0oytw6nEf84MQGn/4gcYmx1iOQjzMEh3QdOJYEROMxyTteQAsw79ghngAMsCn
         shgngM0AgOj5DPuYg3Lhf59ZwfWF538Y4fsS9NDu/pFvnpJI1uX25eZM+aE00Mbi2TT0
         CFlvoHYofb3I1iQ3prk0iUmJypX28C/W65b+PQ6aYUgaCmN00dqe2e/RaqGPlEZlN4SQ
         Ss2+8gG6dw/H7J4zEFLs17aht2x9t7w19NClJzky/GvoimiIGQCe/cV4kO0hZZ0Eavlj
         stasvHt1bNb33+Pt4O+DWOVYXwWanHHsQi8TOG/7vU2uFGfczs6lCymMQZBZKQOtA4u9
         nlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsH/kSrTnUfwk1mAp1WD3UEymx55DgXbIiEvNjxHpt4=;
        b=d1Ae6vurhFkblQptyl1GcDgDUUK53bHgjfOIIaXozOPoMrsu8x+UvUGupvoZ5RVgdR
         WJxCgvVCI7gFlEzN07yBVgV0sM8JSHY/uzZeBTx6MFvKKWMIAqhhCkGcXImbCho2aJKB
         2jDZv8IHJ2rYECVAl5ISz85BwMHHFzS/nyHXxnKXtaDN2TtmbxfhPRjT61V5p9+9a3jP
         elQyY/61L9JgDZYLa8o+kQ6QPOlbzyi7FLvr6lCzeMgWIeGtkRqczA9xNRpDTYY1hAQy
         xXdHc8lYY8UYRgME0ffAdCTSjfIvyuAzvK4ClbsMz1BvjfPB+jCntBmCtUbBbF3IM5iB
         gkWQ==
X-Gm-Message-State: AOUpUlEihQVD31RkE1cTPJNk+Udh4/nj+DkxtiPQ8sB5xGbvwdS9/yey
        csZDAyCS7zpr6BKffRjOi57lI0CVPjIUI0i87BIaDA==
X-Google-Smtp-Source: AA+uWPy50leFLrF5mTANYjzyg4dcFDfSYG56gx/QP0jBd+NYgOlHte6qRKvJccbo4tcYNe7Q49fHIr+qoiYsE79nZTY=
X-Received: by 2002:a81:ae41:: with SMTP id g1-v6mr2149043ywk.345.1533852632863;
 Thu, 09 Aug 2018 15:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-3-sbeller@google.com>
 <CAN0heSqjazimYu4de=xCQ9epSxezVyKPQQ16amZZvoaBh_SKdQ@mail.gmail.com>
 <xmqqzhxv9qkj.fsf@gitster-ct.c.googlers.com> <20180809214148.GD11342@sigill.intra.peff.net>
 <CAGZ79kZK=5gftetj3XLTbu-n3WKwRUQQDj12yxDBV0WEN8gg9Q@mail.gmail.com> <20180809215637.GA12441@sigill.intra.peff.net>
In-Reply-To: <20180809215637.GA12441@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Aug 2018 15:10:21 -0700
Message-ID: <CAGZ79kaDSkwUqfbtRGtfuLKMQs+JcfA75T2cHNxK52hYP+cF-w@mail.gmail.com>
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

On Thu, Aug 9, 2018 at 2:56 PM Jeff King <peff@peff.net> wrote:

>
> I think you could have helpers to spell the two lines above even more
> nicely:
>
>   while (list->nr) {
>         work_on(list_top(list));
>         list_pop(list); /* note this doesn't return anything! */
>   }
>
> But yes, it's not possible with the current functions.

I like this one most, and as we manage our own memory via the
alloc variable we also would not see a lot of memory churn for constant
push/pop traffic.

> You can also use a list.h linked-list. Then removal from the list and
> freeing are two separate operations (but it exercises your malloc a lot
> more if you're constantly pushing and popping).

For that I'd have to define my own type derived from list.h to carry
the string and the util pointer, which looks very similar to the string_list
we already have from a users POV.

> > > Where that falls down is if you really need work_on() to put more items
> > > on the stack, but only after you've removed the current top. But then
> > > writing it out may still be nicer, because it makes it clear you have to
> > > do:
> > >
> > >   const char *cur_string = xstrdup(list->items[list->nr-1].string);
> >
> > Another way would be to use
> >
> >   string_list_pop(&list, &string_dst, &util_dst);
> > i.e.
> >   /* Returns 0 if the dst was filled */
> >   int (struct string_list *, char **, void**)
> >
> > as then we do not expose the internals and would not have issues
> > with reallocs.
>
> Yes, I almost suggested that, but there's the question of memory
> ownership of string_dst. Does it need freed or not? Is that answer
> dependent on the strdup_strings flag?

Sure. But as the caller, you should know?
You constructed that string_list.
