Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CE820986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbcJDUop (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:44:45 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34496 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbcJDUoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:44:44 -0400
Received: by mail-yw0-f169.google.com with SMTP id g192so142655497ywh.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MdMlpgtO1DQeWENqW6KdSadyjpmMKOL8D3UdeIruq3k=;
        b=A0vT38IGf/SLzcussfodZsNc+YqDQH5TA8LdCF5xCze4hrY2IwMu5ZD0qWOool2r23
         ES6Vu56TuZhi+mm26pe2shYqcW8zSiLoOWdH/2Hp6Ae4L8OC+qM8mntne+x4yDYxRp4K
         5GG7SuWu39YmryfoafUFhVncKuotKC0Yez5CCF+QzU4+twVLUCIwi0WhKABFu4uRmWxv
         yXDkC5V9i7gjjDCfKAdIAiZtsUWjGKdHruSa38BRYK7EOZqNZAl6yBsUnn+5VUGszPU1
         MilkecDTsfBcJylWQ12BUlPrSBKfc7dgf2+1cM/8Xxb6CHliTi+QS2tQ8pKCcDfb5iiE
         4uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MdMlpgtO1DQeWENqW6KdSadyjpmMKOL8D3UdeIruq3k=;
        b=jv/Iu57G615LnD6rC/HpLbCavDJSICtTKjmV3N3qQJIRVmwwmFLebhJ5uSKW5tQHYb
         90oQ+JM0ihHj9Szmi84j5JOvUVNnJw1RpEL4O5e2FT/Qo21y3NgYH3bpdZ7dItOJ4zYb
         +aBQtrhPYgyYWKYyPVTYsuVV1OVpGk501w2zBCQCmWiFX4IpbBVRfN58OBeIehpcgutB
         RWBLNPBwKTmcPGBaRsxhuF1EO12mh/GRfPbR63AyhQ6gWonPwaXIFmIOs+YC1JqhNjZH
         T0yS8ky62Yk0NfXIU0SKxSt8spDGhnl1F9NqOwP+2/80vXTbJZEwgp5AumZg/ireJi8G
         Klhg==
X-Gm-Message-State: AA6/9RmDi76fWto3vtUy6RF8GWT2ETInXfCcI4XutP2Ojd5nCmO8ybRm5flfXspC1B4xAjETJhjh9d2ivhcdQA==
X-Received: by 10.13.209.131 with SMTP id t125mr4518317ywd.204.1475613883481;
 Tue, 04 Oct 2016 13:44:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 13:44:23 -0700 (PDT)
In-Reply-To: <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net> <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 13:44:23 -0700
Message-ID: <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 6:48 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 03, 2016 at 10:57:48PM -0700, Jacob Keller wrote:
>
>> > diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
>> > index 7bc1c3c..b393613 100755
>> > --- a/t/t5613-info-alternate.sh
>> > +++ b/t/t5613-info-alternate.sh
>> > @@ -39,6 +39,18 @@ test_expect_success 'preparing third repository' '
>> >         )
>> >  '
>> >
>> > +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>> > +# the depth at 0 and count links, not repositories, so in a chain like:
>> > +#
>> > +#   A -> B -> C -> D -> E -> F -> G -> H
>> > +#      0    1    2    3    4    5    6
>> > +#
>>
>> Ok so we count links, but wouldn't we have 5 links when we hit F, and
>> not G? Or am I missing something here?
>
> This is what I was trying to get at with the "start the depth at 0". We
> disallow a depth greater than 5, but because we start at 0-counting,
> it's really six links. I guess saying "5 as too deep" is really the
> misleading part. It should be "5 as the maximum depth".
>
> -Peff

Right, but if A is 0, then:

B = 1
C = 2
D = 3
E = 4
F = 5
G = 6  (UhOh??)
H = 7

So do you mean that *B* = 0, and C = 1??? That is not clear from this commment.

So either way it still feels like "6" links is what is allowed? Or the
first link has to not count? That's really confusing.

Basically I G is the 7th letter, not the 6th, so even if we're
subtractnig 1 it's still 6 which is 1 too deep? That means we not only
discard 0 (the first repository) but we discount the 2nd one as well?

Thanks,
Jake
