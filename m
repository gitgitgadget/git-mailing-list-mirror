Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53ED41F404
	for <e@80x24.org>; Thu, 16 Aug 2018 06:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbeHPJAs (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 05:00:48 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36549 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbeHPJAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 05:00:48 -0400
Received: by mail-it0-f68.google.com with SMTP id p81-v6so5205105itp.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eQDexXKJBb3J8RLI1PPVHrgZPSpYvZamvN2C0Wi1GoQ=;
        b=GDly5lsxzvVAi6rPFjekj9UQWvLS0cJEP+OG70+V7gnNH4pAQleCr0F1VJSOtejWcF
         khkjpHZz4Y5arntD9+Wa4ysSIHU3Go3eaSDLOhuGRm+xliX2F4GvcciSVxEEvVM1loyj
         decc4rrELUx2Eoxd6/7Agre2bJmsJjmFDt0xwJT4kM1WiTai/PtLaVt5ohU6ct8I+h2S
         ErPkN70/WhO1OyT+UZvKQsEghWlXA+Xeinvp14K9tIXgMUCcF0O0wDGsa/kWIPRe8Oyd
         /Z3TND793E+i+8PPBAePNuuChOdt3UtmIzfRh/Wsdg2skW5mCjfacXuceQD5A75dcAmv
         uXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eQDexXKJBb3J8RLI1PPVHrgZPSpYvZamvN2C0Wi1GoQ=;
        b=oAATokXUzJFW7XG5/po76nytFcBLj3JEeTHjjoerQnMai0gxOZ6AzUN0g1Nz9NfDGk
         +BJ6tc1wyI08qyjP6OORFwTA0VPqdM5MQ5qkGsqWWKH0iy9P3OugDMxBrEOVIWxsLQLP
         J6joAMwF2Q9DlRHZJbdFjoJqlTAvS+dwkjWhTFFfjOhwfumYbF88aG6XW0ZyjbIoSZBi
         rjm3am+m5lUMU0BrCvN8z/bpT8PP10+iV8q/l5FxLOZ7TSX/SUj/F+ekcGsUievTPxAx
         lAnEy1Eqa6je5oXEpXwwT0tna4bWevBnJBeV9mvtn7GoByP11OSzSaZFWF0k9DtpeD+I
         xA0Q==
X-Gm-Message-State: AOUpUlE0QAKabs/ByYK8/LglNXt85gOYDe6szWo/dqbyiBRHdJQpn5E+
        4QFdeQ+evXPd1w5dKre6aMyktTyMW2W/4btWJac=
X-Google-Smtp-Source: AA+uWPyHixc2ivsqHRQn+Kb3S5gr1htEN8RJm0i2qau6vFD5hPVL6Ylc0WfWEdv4KXnWxjXgWX3BTTsl5GZ137K0268=
X-Received: by 2002:a24:69c6:: with SMTP id e189-v6mr19323701itc.21.1534399483615;
 Wed, 15 Aug 2018 23:04:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 23:04:42
 -0700 (PDT)
In-Reply-To: <20180813190005.GB10013@sigill.intra.peff.net>
References: <20180812051151.6425-1-chriscool@tuxfamily.org>
 <20180812051151.6425-2-chriscool@tuxfamily.org> <2113c74c-b230-6ea1-a980-d6d008bac759@ramsayjones.plus.com>
 <CAP8UFD1tX+rAxQc47o-50Kzo6hnX9mTWH2BPSq9HiO_OgBzYTw@mail.gmail.com> <20180813190005.GB10013@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Aug 2018 08:04:42 +0200
Message-ID: <CAP8UFD0Rm6t+uiE7s=HtA1MpW7YuK_G24wadkk7AgJUpPhkrrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] Add delta-islands.{c,h}
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        SZEDER Gabor <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 9:00 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 13, 2018 at 05:33:59AM +0200, Christian Couder wrote:
>
>> >> +     memcpy(&sha_core, oid->hash, sizeof(uint64_t));
>> >> +     rl->hash += sha_core;
>> >
>> > Hmm, so the first 64-bits of the oid of each ref that is part of
>> > this island is added together as a 'hash' for the island. And this
>> > is used to de-duplicate the islands? Any false positives? (does it
>> > matter - it would only affect performance, not correctness, right?)
>>
>> I would think that a false positive from pure chance is very unlikely.
>> We would need to approach billions of delta islands (as 2 to the power
>> 64/2 is in the order of billions) for the probability to be
>> significant. GitHub has less than 50 millions users and it is very
>> unlikely that a significant proportion of these users will fork the
>> same repo.
>>
>> Now if there is a false positive because two forks have exactly the
>> same refs, then it is not a problem if they are considered the same,
>> because they are actually the same.
>
> Right, the idea is to find such same-ref setups to avoid spending a
> pointless bit in the per-object bitmap. In the GitHub setup, it would be
> an indication that two people forked at exactly the same time, so they
> have the same refs and the same delta requirements. If one of them later
> updates, that relationship would change at the next repack.
>
> I don't know that we ever collected numbers for how often this happens.
> So let me see if I can dig some up.
>
> On our git/git repository network, it looks like we have ~14k forks, and
> ~4k are unique by this hashing scheme. So it really is saving us
> 10k-bits per bitmap. That's over 1k-byte per object in the worst case.
> There are ~24M objects (many times what is in git.git, but people push
> lots of random things to their forks), so that's saving us up to 24GB in
> RAM. Of course it almost certainly isn't that helpful in practice, since
> we copy-on-write the bitmaps to avoid the full cost per object. But I
> think it's fair to say it is helping (more numbers below).

[...]

> So all in all (and I'd emphasize this is extremely rough) I think it
> probably costs about 2GB for the feature in this particular case. But
> you need much more to repack at this size sanely anyway.

Thanks for the interesting numbers!
