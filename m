Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816EF20986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbcJDUwl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:52:41 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34306 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbcJDUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:52:40 -0400
Received: by mail-yw0-f174.google.com with SMTP id g192so142855395ywh.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oYYQrudfVZqVtPD4z63KCBDP+Q+CfhfcrsVCgtpL4jY=;
        b=aP0QjpI55vWyehb9EonDAhD5w/cGelADcr3/huqq/xP58HInl1bcTh9mpyajJ6+RZY
         zC2U8i3lORbYLI6TpAaMOFX/SREVxXdV1uXoJ1+tcajbwfFR5xFPnykRcVbNJmDAZzQ5
         /bae+5CL6dodipqCo5GGX+PUCZoKLftbkK813qHJjh8Lx8CcnOE2UDJaxP0bNS9y7lh0
         04Q8G2AJ5UtFYuxV3Boryprq26jgqDeKR7bOASGUpn1ZR99aftUrBU8xxCd54DGruTig
         VqIxcR2Z0YVX3i2za7R8YFETBbpxaYoJLk+588guXnMmgGNFQ9E1Tz1aPFEsdgzEbPjX
         ZG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oYYQrudfVZqVtPD4z63KCBDP+Q+CfhfcrsVCgtpL4jY=;
        b=mcfBGNRQJP/als8xon1fLpN3zZnXUCPHqa8lTS/aplyn38FD7PMNeTa2XY5WqE47p7
         NLIpEsFiRooYSGfUbSDoKY7Bp6zEmdF7wnZnorx6nRhykRbobAyGGQmZmQaTFuLBARTl
         O1coRwHTRohqFgk9r+WuGl+a7obpRM58fTLiPdUgTiqGKZ8afpoNRGs5LJDC9qYF4ZDT
         sRhJMYRgE7TzHlhuMpM5ubZT5ISFnDv0lTgQmbUaObTAxyO5zGE73aLFmkwrGW70stZR
         /lskJHxQ/rFdIWlQfveM5tjsyGaxjyq6T+B2cQU+a6v7oCdGz1NztMd0Wgus6QusVFpJ
         LKPQ==
X-Gm-Message-State: AA6/9RkysYHj9Yh9JnZtelSiWLnCYR8Dd/ZDNzmbjsHAHDiOL/DEImLnVfGiC+Gm4T1uv4ufXPw41DlhCSg9Cw==
X-Received: by 10.129.74.2 with SMTP id x2mr4265493ywa.59.1475614359975; Tue,
 04 Oct 2016 13:52:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 13:52:19 -0700 (PDT)
In-Reply-To: <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net> <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 13:52:19 -0700
Message-ID: <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 1:49 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 01:44:23PM -0700, Jacob Keller wrote:
>
>> On Tue, Oct 4, 2016 at 6:48 AM, Jeff King <peff@peff.net> wrote:
>> > On Mon, Oct 03, 2016 at 10:57:48PM -0700, Jacob Keller wrote:
>> >
>> >> > diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
>> >> > index 7bc1c3c..b393613 100755
>> >> > --- a/t/t5613-info-alternate.sh
>> >> > +++ b/t/t5613-info-alternate.sh
>> >> > @@ -39,6 +39,18 @@ test_expect_success 'preparing third repository' '
>> >> >         )
>> >> >  '
>> >> >
>> >> > +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>> >> > +# the depth at 0 and count links, not repositories, so in a chain like:
>> >> > +#
>> >> > +#   A -> B -> C -> D -> E -> F -> G -> H
>> >> > +#      0    1    2    3    4    5    6
>> >> > +#
>> >>
>> >> Ok so we count links, but wouldn't we have 5 links when we hit F, and
>> >> not G? Or am I missing something here?
>> >
>> > This is what I was trying to get at with the "start the depth at 0". We
>> > disallow a depth greater than 5, but because we start at 0-counting,
>> > it's really six links. I guess saying "5 as too deep" is really the
>> > misleading part. It should be "5 as the maximum depth".
>> >
>> > -Peff
>>
>> Right, but if A is 0, then:
>>
>> B = 1
>> C = 2
>> D = 3
>> E = 4
>> F = 5
>> G = 6  (UhOh??)
>> H = 7
>>
>> So do you mean that *B* = 0, and C = 1??? That is not clear from this commment.
>
> No, we count links, not repositories. So the "A->B" link is "0", "B->C"
> is "1", and so on.
>

If you need to re-roll for some other reason I would add some spaces
around the numbers so they line up better with the links so that this
becomes more clear.

>> So either way it still feels like "6" links is what is allowed? Or the
>> first link has to not count? That's really confusing.
>
> Right, 6 links _are_ allowed. Because we count links, and because we
> start the link-counting at "0" and allow through "5". The link labeled
> "6" (which is really the seventh link!) is the one that is forbidden.

Right. Ok this makes more sense now.

>
>> Basically I G is the 7th letter, not the 6th, so even if we're
>> subtractnig 1 it's still 6 which is 1 too deep? That means we not only
>> discard 0 (the first repository) but we discount the 2nd one as well?
>
> It's basically two off-by-ones from what you might think is correct.  I
> agree it's unintuitive, but I'm just documenting what's there. We could
> change it; it's not like anybody cares about the exact value except
> "deep enough", but _since_ nobody cares, I preferred not to modify the
> code.
>

I agree I don't think changing code is necessary, I was just confused
by the comment that tried to make it clear.

Thanks,
Jake

> -Peff
