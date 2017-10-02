Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88302202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 10:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdJBKT5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 06:19:57 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:44309 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdJBKT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 06:19:56 -0400
Received: by mail-pg0-f53.google.com with SMTP id b1so1263317pge.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MFg5ETelK3+5bfJQ9oXjRLSZJkTOaU8KJ/m99Ef9dlE=;
        b=YwSV28Jjfjpps0Jp7C/56ayJsSF9CCv/V/GhWliPEG9k6EWgcygLhpfNH5cHqjKDDg
         XE1NpROU571UliMsp7FTq07ihT/AXQlAVAJwEETSNZy9MJ64sLolU6psr19o7v9cxQcc
         E3IQG803eV1T5xImrhX+7jpzG31gGtADm5OIqsZcLE4vP9xu+xst8NAlqnRa6XbGmrKR
         1gp5s5y927k72hsAS64BEb03T85SS9E8CUpolNCIGqc6xuFikkH1o7w2QKMahy5XL2J3
         r1GcE0LS/olj8vuQgL8uYePc2HSOHpueBT/dxB9P3oj2xKHrB2tMFOYPHecwEc1IGPBv
         s/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MFg5ETelK3+5bfJQ9oXjRLSZJkTOaU8KJ/m99Ef9dlE=;
        b=hy7El+cgFPbBZ+YDA4ZQnnKPdXPIzVx3pAfZ//g+E1QaZ/QqdnJRScd/fEdqj8HD/2
         fiqD27PWVXoTc0NXbzQyQQGgRF6yrovAAqUD2n8A6K/kXzHSecBVn5wOC9EGxu/vZxIW
         jNGR8jdRxajj792ufr7e8AzyIUQUqDdELFd40I1qOb/J7JYgXVI+Hk1CGffNwEiQ9+y1
         kUxgQHcgoRD0Sn3zxBelEkOpAWUxYG6hQd0KURus9I5fbkCXuxb+cDcQNIve9EdZL8si
         sTlNXSPfy/k1275Lxi5phq0EUxS0+P/AB1ZZzei8+6tjacfhbGLZYd3rUA+g0fLsR2El
         VxAg==
X-Gm-Message-State: AHPjjUg+5pfU+95mbhUFq0RNZjWlsNbLHr3ujEdhZAzqRJZEqVs74mWb
        BuNetkF8ZsQl/Q48Mqt2o79Lt7l39pPzVfbZuCw=
X-Google-Smtp-Source: AOwi7QAw4wxyTis8aB1MDyvjBOoMZSrXU8d8/sONJpOCzmsAQWVAha/cEWkn8NgCAoMwtPtMxinySDK7yxmAcv9fA7c=
X-Received: by 10.98.64.212 with SMTP id f81mr14042834pfd.321.1506939595860;
 Mon, 02 Oct 2017 03:19:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Mon, 2 Oct 2017 03:19:55 -0700 (PDT)
In-Reply-To: <xmqqbmlqoydg.fsf@gitster.mtv.corp.google.com>
References: <cover.1506862824.git.martin.agren@gmail.com> <20171002062252.didw7guppl4nvxry@sigill.intra.peff.net>
 <xmqqbmlqoydg.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 2 Oct 2017 12:19:55 +0200
Message-ID: <CAN0heSqsZXoiVs9s7sZ-d_X4ghU4ciG_=8ppY+w0XG535tt2EA@mail.gmail.com>
Subject: Re: [PATCH 00/11] various lockfile-leaks and -fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 October 2017 at 08:30, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I've read through each and with the exception of patches 10 and 11, they
>> all look good to me.
>>
>> For 10 and 11, I think you've convinced me that the current behavior is
>> buggy. I do wonder if the subtleties might be easier to understand as a
>> single patch, but I'm OK either way.
>
> I found it was not too hard to understand what is going on with
> 10/11 as separate patches, and I suspect that it would be also OK if
> they were a single patch (but I cannot easily "unsee" them, so this
> is merely a suspicion).
>
> Thanks, both.  Let's merge this to 'next' soonish.

Thanks both of you for your comments. Based on them, I have made the
following notes:

Patch 1: Make the logic a bit more future-proof/safe.

Patch 9: Instead of the two flags and the `HAS_SINGLE_BIT`-"cuteness",
just drop `CLOSE_LOCK` altogether. That should simplify things a bit
further. It might also help me come up with better explanations for
patches 10-11.

Patches 10-11: I'm sorry that I didn't succeed better in explaining
this. They have a couple of different things going on, but they are
obviously related and even a bit entangled. Let me try and see what I
can do, I'll try squashing them also. Maybe with `CLOSE_LOCK` gone, I'll
do better.

Especially 9-11 make me feel like wanting to re-roll this, for future
readers if nothing else. I expect to be able to do so in the middle of
this week (I don't know how this interferes with Junio's definition of
"soonish").

As fallout that could be taken care of now or later, I've noted this:

Patch 2: A follow-up could teach `update_index_if_able()` to always
commit or roll back.

Patch 5: A follow-up could clean up a similar construct in
`cmd_checkout_index()`.

Thanks again for your input. It's much appreciated.

Martin
