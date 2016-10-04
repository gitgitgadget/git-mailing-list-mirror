Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA0420986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754320AbcJDU65 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:58:57 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35732 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754313AbcJDU64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:58:56 -0400
Received: by mail-qk0-f182.google.com with SMTP id t7so202952969qkh.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dVTCbL7K7IaZ7X+F6kJ7srct6kNH9K2nkXAiYfa17lw=;
        b=PSpMkzZ31sF2GilaCbmZeveO8U15tJEqJCpwhtm9smJ0YZHVF98b55CYMSriUXWVJp
         VcYxI24ubVb7agqsRZEnGNq24uN4ILayz7nV55aKvDVfiSFcCdwKfvpvXV71+OK79Ggs
         jff8YE6W49f0aHQfEVaranUMJWSS8u6j5Pog0tXlAd5uroEcxs6wPSOw5al8ZMgkN75X
         AcLHd8gtSUHdNj4/YKkH7h4O58v99A0ZELB8lOdUZLQ7OfajXpsZ7ijLlWO1dYOKF549
         3TuxMena32fWzCbso5xPPNiqTkIc9m34i/mgPsZB/Zn3Jn8Q9+va8RRD8NaPIepT8ha+
         UMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dVTCbL7K7IaZ7X+F6kJ7srct6kNH9K2nkXAiYfa17lw=;
        b=CJ8kVAjmtUWjrd2go66lM6/PUB57mPcZLGObvhLIVdatJG5MZkvMG3cxI9DxPWRO70
         1XoeX3EXBTKL9MY3sSDNcPWrube5fvMHvukyOusk3QRZf1uDek7PFmHZclZ4FBodvsBg
         hQtgFCOEANRfQrlbtIRxEur85mqQzh8peVUr1u1xw1Tc0v+hZyqqQdqjF+VvgvZb8toi
         W+Nkf3AXot9AU6jILMz3Wn1vfZUJl4dj3MSQrGAaNW3b2gKbTMiynEgVBrpNmcy/S5iZ
         zsJizzs2k+bI8g8uWub7SFtEOrf/l5r0Aiss+xMNiqpKTDBpgYdCe9sUSplJTIQKnaYr
         x87A==
X-Gm-Message-State: AA6/9RkT09/5i61/2RlMKlrWaWsdrobbFe9psQhdxeKgfKkNpMa3P0s6Xzt7opp3yz36DHD3Qsiw6zxaoDbSxkT+
X-Received: by 10.55.36.131 with SMTP id k3mr5460976qkk.86.1475614735309; Tue,
 04 Oct 2016 13:58:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 13:58:54 -0700 (PDT)
In-Reply-To: <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net> <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net> <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 13:58:54 -0700
Message-ID: <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
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

Input from a self-claimed design expert for ASCII art. ;)
What about this?

#   A  -0->  B  -1->  C  -2->  ...

(Double space between letter and arrow, number included in the arrow)
