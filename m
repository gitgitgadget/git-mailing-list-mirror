Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DC21F406
	for <e@80x24.org>; Sat,  6 Jan 2018 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeAFPCh (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 10:02:37 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:36395 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeAFPCg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 10:02:36 -0500
Received: by mail-pl0-f44.google.com with SMTP id b12so4911850plm.3
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 07:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TRDy0q3pbY8ftO9FSHSksAxAnFRc85dg+Cw5+bdhA70=;
        b=XiRnV9o8P+PJeYLaKPbuNkZp4yPuNcg35pntDYWbhAbVvxKrZo36vgvuQOq4tFjIaY
         c/C7ip5qnjEYdSjoZbEt9a/U0Xc2KcnJLcCycRnv+marYXRFxJ5NGOJ7lxJcicQfKddh
         H9X/wEF8o52U793YkO5kvBzB7QfMTG4OgKG4gCIoksczrll72ErOLWWm1y6SuuSEt4l0
         rKbGeVhm4MRTa6aTz4AGxIeRimZx27BTx1AVcaiw8de00vEv2T8MBZhBmCbDhhFa6nBt
         /ErGNPiIc3h1ba9azVfjPyn9NKqk/nRu/3ErA1cSDOVnJ7psTnCkaDNvmd4k6PAzBswd
         XmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TRDy0q3pbY8ftO9FSHSksAxAnFRc85dg+Cw5+bdhA70=;
        b=gm1L+aW4wPII00GUeedjQS8Kw6p2tYCw7wP4IOQml+G5Sc+aqCF4KbnI+M/DfYQQcK
         sYc1o8tmhhVhke79E7OR3/CfMaPdGW4wlbocVJT/83e00N1MEXO7QxP734DfKbRTTj6N
         EA1IGrI/jhTifRwTjy41AJ6KdGU28XpNasJmaRJQg0KUC7+/uw7KuxEgmlrgaFeV82td
         eKfvGxpuhBs8w4HRoEk4isIYPxV+FFjQaCz7CsDjGVDq5eIQUFWbKj46Bs2yCOEQSUIn
         5m5irUBMU8a4jvA7iDIVJryGacuB7G15YdROfIUbf3kM7FChlue+PDNv3QDgZfD4lNqp
         hPFg==
X-Gm-Message-State: AKGB3mKpg7cIVgKMISa+hNKdT+s8DbVg4bVVU577709mL8TQRilHd4tT
        3UjiRr7UAPZAMOZM8NIIWgeuUVArOldf3nODKIs=
X-Google-Smtp-Source: ACJfBotUYEonSjz9uWg7a/OZ24PttrppFOo+0DoVlTjlZ0EAHUhsCIxpwd7oJ0wJZPM7v0S2uXvd3IBYOBKdBDGSP98=
X-Received: by 10.84.235.140 with SMTP id p12mr6526916plk.179.1515250955519;
 Sat, 06 Jan 2018 07:02:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.179.136 with HTTP; Sat, 6 Jan 2018 07:02:34 -0800 (PST)
In-Reply-To: <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com> <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 6 Jan 2018 16:02:34 +0100
Message-ID: <CAN0heSosr2xgVrfDNLi3XFY=TXuHGaJMXHLG=i=Hf7doD1vP1Q@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 January 2018 at 15:27, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote:
> best_bisection_sorted() seems to do
>
>  - get the commit list along with the number of elements in the list
>  - walk the list one by one to check whether a element have TREESAME or n=
ot
>  - if TREESAME, skip
>  - if not, add it to array
>  - sort the array by distance
>  - put elements back to the list
>
> so, if you find TREESAME, you get less elements than given, right?

All of this matches my understanding.

> Also, if you sort, the last commit, which has NULL in the ->next,
> might get in the middle of the array??

This is a bit tricky. The elements of the linked list are not sorted.
Instead, the items of the linked list are copied into an array and
sorted. The result is then put into a linked list.

Or actually, into the *same* list. That's an optimization to avoid
deallocating all objects in the list, then allocate (roughly) the same
number of objects again. It means all the `next`-pointers are already
set up, and we just need to set the final one to NULL. (It will already
be NULL if and only if the new list has the same length as the old,
i.e., if we didn't skip any TREESAME-commit.)

> # BTW, is it really fast to use QSORT even if you have to convert to
> # an array from list?

You'll find some QSORT/qsort-stuff in git-compat-util.h. We may or may
not end up doing an actual "quick sort". That would depend on, e.g., how
the C-library implements `qsort()`. Also, I'd guess that even if we have
room for an improvement, those cases (small `cnt`!) are already fast
enough that no-one really cares. That is, maybe we could measure a
speed-up, but would anyone really *notice* it?

>> Thank you for providing a script for reproducing this. It helped me come
>> up with the attached patch. The patch is based on ma/bisect-leakfix,
>> which includes =C3=86var's patch.
>>
>> I think this patch could be useful, either as a final "let's test
>> something previously non-tested; this would have caught the segfault",
>> or simply squashed into =C3=86var's patch as a "let's add a test that wo=
uld
>> have caught this, and which also tests a previously non-tested code
>> path."
>
> Do we really need that?  What is a practical use of a commit having
> both good and bad?

There is not much practical use for *having* it. But there might be some
use in *detecting* it. Linus wrote in 670f5fe34f: "Also, add a safety
net: if somebody marks as good something that includes the known-bad
point, we now notice and complain, instead of writing an empty revision
to the new bisection branch."

So there might be some value in verifying that the safety-net works and
tells the user something useful (as opposed to Git segfaulting ;-) ).

Regards,
Martin
