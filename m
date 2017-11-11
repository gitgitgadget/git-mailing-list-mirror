Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0489F1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 16:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdKKQjO (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 11:39:14 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:51637 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdKKQjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 11:39:13 -0500
Received: by mail-ua0-f169.google.com with SMTP id l25so562473uag.8
        for <git@vger.kernel.org>; Sat, 11 Nov 2017 08:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=jggvIPrK+XpgfUKJ/GvvZAKnTyCgD1hrnUcvucddTnI=;
        b=Lq8pUjovaxhlQU6A5qXnnQu+fSb3p3fqKtyIiWaXp+gIPuGrqMOyVAQqxZf+whEruG
         kr2J+V5yY/M3AIXdmGR8Jz1CQsayh/zjS73mhDmu/IhSEg/HlC42aRfjqvJWnrPhFGSY
         Walt5auT9GwNy5cLnDYN6VeEhRQ+T6c2+26eQvV/fgVWyJ9qNhLfj329VdylgiANSdSr
         Yst5NyMZB2n1m1FJrW/tnupeMgX2bX6lSVGw3pRmQfJs/fCR5fk4zjoMPT/GxJy1KQhw
         gIN5DIED9DpUT/eSzsxgZ8BEvg04V0y1cSZCuX1u0JQFeeydTiGNtvgFzkR0Pm29SwiB
         G/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=jggvIPrK+XpgfUKJ/GvvZAKnTyCgD1hrnUcvucddTnI=;
        b=pBxv28Sppe0b0faxpjGdFCtQ4ntm1bV/KVZRiWTb7Zgc1y9U0YAUG+6ikY7+MH7Woo
         0Qz+jXydZWHTsewloyhXq6TsRl8hj5tJHz3TZQucuYn/2aRrq41HDgcISj6206RItcek
         LBIMHyTLGaB7+Gi7BLt1OhiZGYiXBGO72m4BP2NbDi4XKWUolRo7XL6rk0jyIfDoJoRY
         +JWyVstFJGTSjzkRhwc+sXuW9wCB3aaXC/Pyt+no3qDvkBMgtrf3NMXmqJv6Q7gaeoY7
         wEHMpqif2E+3HiD3SiqGakeJ3o56PNhx6Ta+4DhxNN3ydG1FU3LzCWVZixaGSnpku6iq
         2H8g==
X-Gm-Message-State: AJaThX5+2/ZwctUoC+QwuwFGkoxsIk84Xf2F7q+nI/7g1gwBb3GAzOun
        ODmeERJS0K21mN2RV83ir+C4tWqLkO9ElGYeunQ=
X-Google-Smtp-Source: AGs4zMYl9WIyG54HiRHy0/ipWKTyQ9iSDsTOaIqeJOeyQYtoxs2nseze3qaD5lVn2bYCmDq4J8vfAkppGdyCgbx6oc0=
X-Received: by 10.159.61.90 with SMTP id m26mr3389635uai.40.1510418352334;
 Sat, 11 Nov 2017 08:39:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Sat, 11 Nov 2017 08:39:11 -0800 (PST)
In-Reply-To: <20171110234210.lojdat5zofhrdlgi@genre.crustytoothpaste.net>
References: <20171110173956.25105-1-newren@gmail.com> <20171110173956.25105-3-newren@gmail.com>
 <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
 <CABPp-BGwoduH_T7U4uN5A-h43wREfXdQgV8YCVWf8w5N09cYSw@mail.gmail.com> <20171110234210.lojdat5zofhrdlgi@genre.crustytoothpaste.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Nov 2017 08:39:11 -0800
Message-ID: <CABPp-BHvveKW+UzTZqLq5h0bVUJLPqYpGu0CWQpYjHzzDbEWww@mail.gmail.com>
Subject: Re: [PATCH 2/4] Remove silent clamp of renameLimit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Nov 10, 2017 at 3:42 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Fri, Nov 10, 2017 at 10:36:17AM -0800, Elijah Newren wrote:
<snip>
>> Further, the later patch used uint64_t instead of double.  While
>> double works, perhaps I should change the double here to uint64_t for
>> consistency?
>
> I'm wondering if maybe you want to use size_t.  If you end up using an
> unsigned type, you might be able to leverage unsigned_mult_overflows to
> avoid having to write this by hand.

Thanks for pointing out unsigned_mult_overflows; I was unaware of it.
I think I'd prefer to not use it though; the fact that I had a case
that genuinely needed a value greater than 2^31 (at least before my
performance patches) meant that a slightly bigger repo is going to
eventually need a value over 2^32, so I think we should just cast to a
type that can hold it.

I'm curious why you suggest size_t, though.  I have always associated
that with an amount of memory that will be used, and there's no
allocation based on this result.  Was I wrong to make that
association, or is there another good reason here?
