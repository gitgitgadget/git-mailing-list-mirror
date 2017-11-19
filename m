Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14AE2202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbdKSNQG (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 08:16:06 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:44767 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdKSNQF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 08:16:05 -0500
Received: by mail-ot0-f170.google.com with SMTP id d27so5584830ote.11
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4xs5JWSX/FUFH2TczW4XWSuDrgW/fkBLJkruyezqIzc=;
        b=qCiUgbEjPXDDyTuINLGz9U1sHR+xU2rJwUOPEA15hCUJ6VXhckjHeDQ3w3Vl8v+QGB
         0/eKHJms7xN+/ooePj76+aYhbZYv4epv08hSIPomvYXY66LzTB1ckzDu82S0tXLYoKpt
         o/9JQTVS08lKMXPF/Y8uQqXNTyK7BUymvrXRMC2XWD1Z080QH5rf7YtmrTLdTBiYSF6E
         K4dOug3DrvSVewZhUkm+zl8oNKw9b4KU9yNqWdxpuXuaN9v0C4FTxeK+zSS/RJ4GBRdD
         j7ta6dDiLEu417NFnMFtAxS2lCFnMF/+hm+ScZM/ute6rh22ggTA6t10Xl1KZgKyc985
         g6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4xs5JWSX/FUFH2TczW4XWSuDrgW/fkBLJkruyezqIzc=;
        b=eJPH/aC6gVnJNXEIy6jSD9qUgIuVyPBIQ2P53bJ7yfUrtwLAiD+uFkFrDDkQcp/4np
         18IiP9bushQr5khGnA7Dj1Q7mPqNVIam1Ys17tTzu/IKYXc/KMVLJ7cVfhduNZWHpc4s
         6NVoUR0c7BtBFOP4FdCe+j4WS2DPnvBU4/Q0ra+AbJ2DH3UrZPFB3cgMUHbF19q91NrZ
         WtgwMrHQ9M88a0DeNwaJz0QtJhe2FK6mzAY8jlH1vUGtnc1s/lda3QU/q61tG+JEIfK4
         b3jQjAwxcYk3VaZyZE5oGm9foUK2x5J7sBHkd7iMwv2uio1vQhfKg3w9oy8crJpwT63s
         ixAg==
X-Gm-Message-State: AJaThX4a2SZhYAkhhzCDixsuD0C2G7Z8B8YMvWIH8cuwwTtU4GaXAQPX
        K/ml3ZSjmeEm+uC7TRm8MoDN9f03MPz1WCVRa7XW5g==
X-Google-Smtp-Source: AGs4zMaX5CKQPDat0dpI3Lzja9Ql4mLNbET0so1CpeQiUrd/KJFtknetakNUR/ZxBsLphHOrqUMdUwepYWUDBudBjNw=
X-Received: by 10.157.14.145 with SMTP id 17mr5763923otj.20.1511097364707;
 Sun, 19 Nov 2017 05:16:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.1.137 with HTTP; Sun, 19 Nov 2017 05:16:04 -0800 (PST)
In-Reply-To: <xmqqzi7jnh6a.fsf@gitster.mtv.corp.google.com>
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
 <20171119004247.22792-1-gennady.kupava@gmail.com> <xmqqzi7jnh6a.fsf@gitster.mtv.corp.google.com>
From:   Gennady Kupava <gennady.kupava@gmail.com>
Date:   Sun, 19 Nov 2017 13:16:04 +0000
Message-ID: <CAPu-DQoapb=cgxYEOEVcpZ4nQeh+FuOE6VF=m3NaqRcr2p8Nrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key
 normalization concept
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The usual style comment on the subject applies here.

Oh sure, 50 characters. 'Remove trace key normalization concept' would
be better?

> I cannot quite tell what it is trying to achive to make it a
bulleted list.  It's not like four things at the same conceptual
level is enumerated; instead it just has four sentences that talk
about random things.

With these four sentences I am describing the reasons why we need this
patch. In my previous iteration I had similar  description outside of
git comment and was told to move it into git description. So it is in
comments. Hot sure if I understand what is the problem here. I can
remove bulleted list and make it four sentences. I can remove it
altogether. I can add some text so it will be easier to understand
this without context of previous patch. What would be the best?

I reread relevant parts of
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
and it seems description of the reasons and alternative discarded
solutions fits into description. So could please help me a bit to
understand what is wrong.

> More importantly, I am not sure I understand what these sentences
are trying to say.  "Should be moved to header"---so?  Does that
move something from the source to the header?  It seems to me that
the patch removes a helper function from trace.c but does not add
anything to the header.

I was told to split the patch and do removal for the normalization as
separate commit. As it is separate commit, it needs to do separate
description with the own reasons why etc. Yes it doesn't but it is
needed for the second patch in the series.

So comments explaining that, while implementing trace optimization, I
saw two options:
1. Move normalization function from .c file to .h file
2. Remove it

And why I choose removal - not used, would complicate header without
any benefit, and actually I didn't mention minor benefit of
compilation speed. This trace.h included and used in lots of places so
it will take compiler some time to actually eliminate the code.

> Puzzled.

Does it make more sense now?

Gennady


On 19 November 2017 at 02:19, Junio C Hamano <gitster@pobox.com> wrote:
> gennady.kupava@gmail.com writes:
>
>> Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept
>
> The usual style comment on the subject applies here.
>
>> From: Gennady Kupava <gkupava@bloomberg.net>
>>
>> - to implement efficient traces with normalization, normalization
>>   implementation should be moved to header. as it seems better to not
>>   overload header file with this normalization logic, suggestion is
>>   just to remove it
>> - different macro exist specifically to handle traces with default key
>> - there is no use of normalization in current code
>> - it could be reintroduced if necessary
>
> I cannot quite tell what it is trying to achive to make it a
> bulleted list.  It's not like four things at the same conceptual
> level is enumerated; instead it just has four sentences that talk
> about random things.
>
> More importantly, I am not sure I understand what these sentences
> are trying to say.  "Should be moved to header"---so?  Does that
> move something from the source to the header?  It seems to me that
> the patch removes a helper function from trace.c but does not add
> anything to the header.
>
> Or am I wasting everybody's time by commenting on a stale comment
> that used to describe an ancient iteration of this code?
>
> Puzzled.
