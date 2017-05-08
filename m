Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D8720196
	for <e@80x24.org>; Mon,  8 May 2017 22:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbdEHWG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 18:06:57 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36365 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdEHWG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 18:06:56 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so10112487pfg.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/IHVQG/P69+vUmoSYEHXtpC5WBReH15FOD4+IJQx5Ig=;
        b=uyjJgLdc5ZKzVXB3kM6OiSYagFPHjT2zkjMxYhY2zCx9qAGuj4sy584hlvxkdZ6fhq
         q8zp39qY8wODILWyynQwAmf69xp9wX4qO9rFmikBJFWe0WE3Z+3pvqciHeoSp8ftiXdh
         kUg29DiXqT5QRF1aE+opVHuu0Ceaf/2YFqigk6SHURUAGt9V5DrrAY5AOUci4JCOAm1C
         eluaC2QtKRzNH+CP7wLG3hvYPnJi3sZc2cuFeQ6BLbFlFU3i5O/b/xHbdXG21J+U4RQQ
         ZGfaZKTEVRjdkrza1d8ft7AQyXkODGLmrB2IEA2TFypzlJhn9xOC9+Yz0v61xYjVIQYh
         LVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/IHVQG/P69+vUmoSYEHXtpC5WBReH15FOD4+IJQx5Ig=;
        b=o5JeF3JNG7JxD+Fo9ZoZbYSW62aKySrxlj6v9+T+lj3YKq9X+lpUZThq7nsluPunXI
         pYp35NKLeVU3sGCIbrUrcdVyUJY6ojHDydhc3KXYuPvlGI73niDY3jcSblotyGIlgEjz
         8dM+nEPIKnfaaQPR2Tv0IyPvJe94ez+4nsao3def/GnQoql+qH2myIeHyOCbGtMizYSk
         FcmOtcF1th2oKr74oE82O7SyKYaVHvKT3xW3psJeFpL9zoE1F4U4h56p6W+D65sqXqhm
         zPPZcJB9VYkLzQJVluqUTrtW/maeiz3SCozioC8wKpPr15nQoGPJi5PcxPU37Uj7lSXY
         9YVw==
X-Gm-Message-State: AN3rC/6/aIITJ7ryJ1reNgoGZSXKrdY83DK2N1JJpA9aAxtO9RfS+xGl
        cf1QDnadC7XOj4ITnJ74g9MvO1YKEmZk
X-Received: by 10.99.56.66 with SMTP id h2mr21266516pgn.40.1494281215169; Mon,
 08 May 2017 15:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 15:06:54 -0700 (PDT)
In-Reply-To: <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170505052729.7576-3-whydoubt@gmail.com>
 <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com> <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
 <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com> <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 15:06:54 -0700
Message-ID: <CAGZ79kbKERn5CbD9mVdq6huqLS0TrpH=-Tbk229fD8P8598CbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Smith <whydoubt@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, May 08, 2017 at 10:02:58AM +0900, Junio C Hamano wrote:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> > I guess it is ok for now and in this series, but we may want
>> > to split up diff.[ch] in the future into multiple finer grained files.
>>
>> For what end?  Such a split would require more symbols internal to
>> diff.[ch] to become external, which is a big downside, so we need to
>> have a large reward to compensate it if we were to go there.
>
> I think there are two sides to that coin. Let's say you have a file with
> five functions (and you can replace function with structs, global
> variables, etc; any unit of complexity that might or might not be
> externally visible):
>
>   /* called by both a() and b() */
>   static void a_and_b_helper();
>
>   /* called by a() */
>   static void a_helper();
>   void a();
>
>   /* called by b() */
>   static void b_helper();
>   void b();
>
> When they are in the same file, b() and b_helper() can see a_helper(),
> even though they don't need it. And that means increased complexity in
> dealing with a_helper(), because its visibility is larger than
> necessary. We have to worry about what a change to it might do to b()
> (or more realistically, c(), d(), etc).
>
> If we split this apart, we end up with three files:
>
>    common.c:
>      void a_and_b_helper();
>
>    a.c:
>      static void a_helper();
>      void a();
>
>    b.c:
>      static void b_helper();
>      void b();
>
> The specific helpers have less visibility, which is good. The public
> functions a() and b() were already public, so no change. But now the
> common helper is public, too, even though nobody except a() and b() care
> about it.
>
> So it's a tradeoff. And the important question is: is the bleed-over
> between a() and b() worse than the common bits being made public?  That
> can't be answered without looking at how many distinct "a" and "b"-like
> chunks there are in the file, and what the common bits look like. I'm
> not sure of the answer for diff.c. Without digging, both ends of the
> spectrum seem equally plausible to me: that it is mostly a set of N
> distinct units which could be split apart, or that it really is a few
> public functions calling the same common core over and over.
>
> And a follow-on question is what we can do to mitigate the cost of
> making the common code public. We could advertise a_and_b_helper() only
> in diff-internal.h, and then makes it only semi-public (anybody can
> include that, of course, but including diff-internal.h seems like it
> ought to be a red flag). That only helps the programmer, though; we'd
> still be losing out on compiler optimizations and static analysis that
> only looks at one translation unit at a time.
>
> Phew. That ended up a little long-winded. All of it is to say that I
> don't think it makes sense to reject a split out-of-hand, but nor is it
> always a good thing. It depends on what's in the file.

I agree on this sentiment. It really depends on the content under
discussion whether it makes sense to split.

Having had some exposure recently for diff.[ch] (and I just picked up
that series again, but did not send it out yet), I have the impression that
we do have a lot of code in diff.c, which is quite unrelated to each
other, i.e. a lot of [a,b]_helper()s, and few a_and_b_helper() for the
already public functions.

May first mail was based on perceived unneeded complexity, which
slows down in achieving a goal.

Thanks,
Stefan
