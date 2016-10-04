Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AFA420986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbcJDVnq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:43:46 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35860 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcJDVnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:43:45 -0400
Received: by mail-yw0-f177.google.com with SMTP id u124so51539194ywg.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HPVy15KZEncOJMIaODH2ogvWY3l/GirnqR8JLKiw8b0=;
        b=uq26zH+c+l22Dtb5PLqqqGrBT6Q93WFXS15D/XtTSqm1Xlul5QFF80qs+RTzZC1nq0
         VnxCBItK8uUKuFuOp3/brc0ovTqzDHT0Umqozs734CbrIXgj6XkWyYdyF/YuayyFNzy4
         2eXWaKN8aGA10Euaa5AwMYNRFhZZYd2JZ+m1pA0MYiSJUNl/V+XBAmqY48sM0P8u+pqX
         QaMlpqR4cIHiuU4sM00L6ODl//hcn7xvYBD8AZzGRN4c+J5fgUdOJJA9STIxoqZWAaOM
         T3fy+hWRSAtOFexz8H8/9/ExVrWnRc2WaJNMvK0lPNXaxD0h/7eUMRuTDWAW8NwDMidC
         SR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HPVy15KZEncOJMIaODH2ogvWY3l/GirnqR8JLKiw8b0=;
        b=gO4ClX0nN/YTBdHyuoNcbKRcGZUh+wt97jp7poclcyR/YiN9AnTsWwj5PF2ZUnN7cc
         k7LztjP11HJNUpQGwZmEGCz1wcLT3vW+7iWeilaehTkWwBQPfY1gx65iLtCrUGmIwcS8
         brKuEPv1vR6Y3JJV9DxWTbpYTayJRQ00PW9Q5fB8O5F8KY299GJLzQSMBDnbHl2BCeBN
         i0lefWPJO3BxGYyycWWiOHsjCNVaAWaRI3HKtHsYlPMiRW6M9dKtwzzyhSWHIw9I4Fnh
         tEOvZzmaWggQAYLNgqViDnrGcYy8zA18DSFBjSsPl61f5PUUK4UnjyeAiR5yAKZXOpNE
         ZgSQ==
X-Gm-Message-State: AA6/9RkPbd/mbgomVJ2/xJ32a+SwISJkw5SwCrKz02O5tXv4IX24PsbStrCgSWdyj9tAMULFkncfBc0NtGYasw==
X-Received: by 10.37.174.8 with SMTP id a8mr4181320ybj.153.1475617425009; Tue,
 04 Oct 2016 14:43:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 14:43:24 -0700 (PDT)
In-Reply-To: <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net> <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net> <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 14:43:24 -0700
Message-ID: <CA+P7+xoDz2sOPrDrJhAhrqDQsRR8NVU-8kh6+G=8FJeXEJ1dtg@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 1:55 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 01:52:19PM -0700, Jacob Keller wrote:
>
>> >> >> > +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>> >> >> > +# the depth at 0 and count links, not repositories, so in a chain like:
>> >> >> > +#
>> >> >> > +#   A -> B -> C -> D -> E -> F -> G -> H
>> >> >> > +#      0    1    2    3    4    5    6
>> >> >> > +#
>> [...]
>> > No, we count links, not repositories. So the "A->B" link is "0", "B->C"
>> > is "1", and so on.
>>
>> If you need to re-roll for some other reason I would add some spaces
>> around the numbers so they line up better with the links so that this
>> becomes more clear.
>
> Hmm. Now I am puzzled, because I _did_ line up them specifically to make
> this clear. I put the numbers under the ">" of the arrow. Did I screw up
> the spacing somehow so that isn't how they look to you? Or are you just
> saying you would prefer them under the "-" of the arrow?
>
> -Peff

I bet they line up in a monospace font and I just happened to be
viewing this from GMail which isn't showing it in monospace and so it
doesn't line up. Ignore me and carry on

Thanks,
Jake
