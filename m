Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572911F576
	for <e@80x24.org>; Tue,  6 Mar 2018 07:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbeCFHOO (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 02:14:14 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41843 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCFHON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 02:14:13 -0500
Received: by mail-qt0-f196.google.com with SMTP id j4so23454715qth.8
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 23:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JiclFs4fjqgUVIQBEjNHiDdVNFBGRofOVPRZWE9xIO4=;
        b=aPSsHTsPFh+ma8+9RmRWrQtvcX02F0d6D8zXjb0NU9gq/E7rOtWLxd3Jwu7pFLuDUH
         FSbxxTneHxtwKUMe/7SGdE+PrAKMvHEpg1YQdUAHacLWK5tgpC/7p8UxzWK/vCUuzXR5
         1RFdYV7caikQIVfCylyUxuyo1tn5LHIYRk+9CFOWzd8mA1gGqUEYh4VbrT2LLip30roX
         krl0s+ON1cxzL8pu6rUH5MhyNB/mYNUKcM6hTzZ+MXj+uOO/NFZlDZap4sN4IEqOhkmb
         z7fvlIFtQOhjB9jSdw5kOq8NK0iIMyNEHbUl+ZPHs66DIMtk4xUHJbkJmr7pKoDmRHj9
         atkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JiclFs4fjqgUVIQBEjNHiDdVNFBGRofOVPRZWE9xIO4=;
        b=BVREQZxk9S0cIv225KYf9LAPBYFiO3SgQum091KoWaRIn/6SHLpf2gsVLdjj7GGOJL
         Tdv0klvyzl5DtO1vZfZPG904xCYNJs0HXE7FzvAX+gLVgzTTXH52nn62Ug7BNWK3JMji
         mDvRNTCrOLiA/aNqk4Gupu14LEY/TeYcS6jxIaeISnx8qZoGLnLuJv9cIN6UKGUGpUys
         PTNzn/V4XWP1PZAzVM76rlLjayRa9IMFu6/cE1qFwcpu1ELIoDzPXksHD0/BYGQRseIV
         1jFOru43MWjW0taLSoNAaDSES2KvvNBmvlyfm6G1SSO0daH8j5XjKtS3MMcuDkDs6lbb
         aIHA==
X-Gm-Message-State: AElRT7Fw+GlwX3iazbo7Xl/LwoDQ2pte6jSiNlpKB8HVPkHPZS/Flx3u
        VSj7BOvL2aymuVJz1CaUMx7FQ9COpWeBfz9idnY=
X-Google-Smtp-Source: AG47ELsddBb/yZcSIUGifbKswHIMgZ1iZHtG8zknZ+eapX/DM1mIGQg9R9eCHPNiG5UQRCbBIqhzAonjqceOioQ+Alg=
X-Received: by 10.237.62.233 with SMTP id o38mr25798922qtf.3.1520320452538;
 Mon, 05 Mar 2018 23:14:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 5 Mar 2018 23:14:12 -0800 (PST)
In-Reply-To: <20180306065208.GB3522@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com> <20180306021729.45813-2-me@ttaylorr.com>
 <20180306065208.GB3522@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Mar 2018 02:14:12 -0500
X-Google-Sender-Auth: qeTAIPhnVISNCu8bXm6vO_ax6ko
Message-ID: <CAPig+cSMx8oSWvT2dGgz-DwfLJkGDUFP-Gs19c=izK-=3422JA@mail.gmail.com>
Subject: Re: [PATCH 1/4] builtin/config: introduce `--default`
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 6, 2018 at 1:52 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 05, 2018 at 06:17:26PM -0800, Taylor Blau wrote:
>> In an aim to replace:
>>   $ git config --get-color slot [default] [...]
>> with:
>>   $ git config --default default --color slot [...]
>> introduce `--defualt` to behave as if the given default were present and
>> assigned to slot in the case that that slot does not exist.
>
> I think this motivation skips over the beginning part of the story,
> which is why we want "--color --default". :)
>
> IMHO, the reason we want --default is two-fold:
>
>   1. Callers have to handle parsing defaults themselves, like:
>
>        foo=$(git config core.foo || echo 1234)
>
>      For an integer, that's not too bad, since you can write "1048576"
>      instead of "1M". For colors, it's abominable, which is why we added
>      "--get-color". But as we add more types that are hard to parse
>      (like --expiry-date), it would be nice for them to get the same
>      defaulting feature without adding --get-expiry-date, etc.
>
>   2. --get-color is a one-off unlike all of the other types. That's bad
>      interface design, but the inconsistency also makes it harder to add
>      features which treat the types uniformly (like, say, a --stdin
>      query mode).
>
> And perhaps minor, but it's also easier to correctly error-check
> --default, since the "foo" example above would do the wrong thing if
> git-config encountered a fatal error.

Thanks. For someone (me) who didn't follow the earlier discussion
closely, this motivating explanation really helps; especially since
the commit message mentions only color, which seems to already allow
for a default value, so it wasn't clear what benefit the new --default
provides.

>> +test_expect_success 'marshals default value as bool-or-int' '
>> +     echo "1
>> +true" >expect &&
>> +     git config --default 1 --bool-or-int core.foo >actual &&
>> +     git config --default true --bool-or-int core.foo >>actual &&
>> +     test_cmp expect actual
>> +'
>
> Funny indentation. Use:
>
>   {
>         echo 1 &&
>         echo true
>   } >expect &&
>
> or
>
>   cat >expect <<-\EOF
>   1
>   true
>   EOF

Or, simpler:

    test_write_lines 1 true >expect
