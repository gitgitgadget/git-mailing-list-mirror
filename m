Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305491FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 11:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1038108AbdDULFW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 07:05:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36476 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1037967AbdDULFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 07:05:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id a3so13844777oii.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+BPycGZn7pUu/pqArRIbe38p9y6S56JUxdmddB7RTh8=;
        b=kCu+LGE2pLmejCh4GivPGhvFeUuw21+rK48oT+qou8tkYBVBV/s50tL67sw+36bYEg
         HLltZCCJ7W2ePYIGcs8nbG8uDnuT8gamVoV3y9ecFQ++E3a155aWN9YOAMLFBDYJZ5e/
         Fr3PQ77b3vJOdUUsuf12GWIDJjb3b3hPKcNwRFDVjZ8Hd8qXEouBAIuHPUEsZ8ROrVcw
         JTojFnnfoD8d31m/4cQw2IL/1IOKD2nAm8V+7Ua1mA2rwwSPERzE58kwmlaIYlWmO1f/
         0c/Xx7mGejfp9kPmmoyAxywIGYMIZolr5KbetKW9VmYPZm29LQrDidZajfGDkaibIFP3
         rnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+BPycGZn7pUu/pqArRIbe38p9y6S56JUxdmddB7RTh8=;
        b=mtJduJUUIUqMBok1PUyWuvB2ogKrNNkSqFj4qY7EAADEIw9rAVoL66gHOWotsSyLwU
         jXvGr3nwqlXRiOScY+m/Nn84bpB+C6lBJbsNUyjg7ZtR67UJ2t7gEuBkNmR6Wh/Fk3AT
         bbxAdjSZkyxM3QXH8hQk7/iUhOUtYnroO7mDGF1Ao1/OrM6juVsMybpBQTgHJxIwuThj
         m07HeRXWCl+DDFx/uQ6PrN6rTzSuTeQGSznNjAaJXj6VkFzC5oI7VjRw8/ydlC1tMhMM
         nZyKHZsB/kP0FUiR7PkM9FPlNE27umzzMv+me86Pnzskb1IC1U0B0oNnSBqTd8kLrJbu
         rr3g==
X-Gm-Message-State: AN3rC/7zFeM7vABHX0x4FXEzepqC2tJ9oxVM5cX7HIvY+xbes+3ojBUr
        KZugYUZNdc06DSUb4BoDbd1dP2CKPw==
X-Received: by 10.202.80.150 with SMTP id e144mr7232808oib.65.1492772720212;
 Fri, 21 Apr 2017 04:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 21 Apr 2017 04:04:49 -0700 (PDT)
In-Reply-To: <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
References: <20170420112609.26089-1-pclouds@gmail.com> <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
 <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com> <20170421062915.he5tlgjqq7kj5h32@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Apr 2017 18:04:49 +0700
Message-ID: <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>
Subject: Re: [PATCH 00/15] Handle fopen() errors
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 1:29 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 20, 2017 at 08:41:32PM -0700, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > I wonder if it is OK to only special case ENOENT for !fp cases,
>> > where existing code silently returns.  Perhaps it is trying to read
>> > an optional file, and it returns silently because lack of it is
>> > perfectly OK for the purpose of the code.  Are there cases where
>> > this optional file is inside an optional directory, leading to
>> > ENOTDIR, instead of ENOENT, observed and reported by your check?
>>
>> "git grep -B1 warn_on_inaccessible" is enlightening.  I wonder if we
>> want to wrap the two lines into a hard to misuse helper function,
>> something along this line.  Would having this patch as a preparatory
>> step shrink your series?  The patch count would be the same, but you
>> wouldn't be writing "if (errno != ENOENT)" lines yourself.
>
> I had a similar thought while reading through it. I think it would be
> shorter still with:
>
>   FILE *fopen_or_warn(const char *path, const char *mode)
>   {
>         FILE *fh = fopen(path, mode);
>         if (!fh)
>                 warn_failure_to_read_open_optional_path(path);
>         return fh;
>   }
>
> And then quite a few of the patches could just be
> s/fopen/fopen_or_warn/.

Jeff.. oh Jeff.. you have made it _way_ too convenient that after a
quick grep at fopen( again, I found a couple more places that I would
have just ignored last time (too much work), but now all I need to do
is Alt-f to the end of fopen and Alt-/ a few times. Too tempting.. :)
-- 
Duy
