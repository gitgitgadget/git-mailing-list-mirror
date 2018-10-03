Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED1B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJDDZ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 23:25:27 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:40577 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDDZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 23:25:26 -0400
Received: by mail-ed1-f48.google.com with SMTP id j62-v6so6573737edd.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=s/MxVj/LyqUx8dULmbbh3cr+arY568NtDKgc449zFw8=;
        b=XLwbv6Q88Jc+8DIkjKFz7RaVaeAKPPeRQW+UG/Q0An/8+PGAyQtG/ulbuxwlhbmkh3
         C3ftgUYmXoo3LBcWR1nvXRkGn+ac+bycJJpU0cRRlNS/txD5Wqdi8Lx0JBAiZshsPx00
         ZO9ZAcferjdC/Y7J3qsY+zCm9nnagl4C4ZCehGXtWXwZ4hOBn4txtoRAmjQSqlNVrvkO
         klS8iKsmA7q3rgPWVQiRXbG12FOIbQlNRpauCdWSG7a0sSboxX7zOHi3bJ7Gn4mI/l8X
         9ApxV6uZntyYPpy1gNTGqQCY6cFq8Wt+AXl3ahGOMllLpga4T+OxfNZP+TTmYt9/IMiS
         Mn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=s/MxVj/LyqUx8dULmbbh3cr+arY568NtDKgc449zFw8=;
        b=WRzfOoH1NmUFyGac5gSzg03MewbkVzrJjO7+d7ERZzZ10zI98jNu6pvyvkp/l/iZtW
         ZOYG0tfYGjXLVFgcysHJJ0i0wvZADeySu5vINFt+MKKjFnZC4oZbtVl4xD9r219CRyYb
         5onh+d0miPKx5DUDSx56zhxj34VPPjM9QEt0xwwAG3ppka0DFpsiL/s4T/Lfy04EDbd5
         h1bj07DCwda45asbAxHmnnonmvkP008Vxj+nptULuU6W2I4O63vHuZfU4PrMoiA5vGmC
         BkpH6ygNANZnDgMuMI4RX0HbiycBg+LvtDGUMZ87+LbtrTD5PqL8/7Qm8AGWJ5B3lSFv
         goNw==
X-Gm-Message-State: ABuFfohLcoj+Z59oeFw4S0oug8P4gnL3SC7yA5PeCtuUW9s16++Dnhgb
        Uu+1IdN45OhTs8GBxM/u8gw=
X-Google-Smtp-Source: ACcGV62k0xBROWrOXilQ32xj/oLTZCAWkfdvINrGtxoAmRpOaSKK4IEg1tRFOqpVMz8VPM52kE6O7Q==
X-Received: by 2002:a17:906:548:: with SMTP id k8-v6mr3539792eja.11.1538598927387;
        Wed, 03 Oct 2018 13:35:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id d2-v6sm797810edd.55.2018.10.03.13.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 13:35:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
        <87o9cbglez.fsf@evledraar.gmail.com>
        <20181003145308.GP23446@localhost>
        <CAGZ79kbyCZcMuj=_Od+C+tHg=PzzDd8QV+9RqS7iFcZS+Ht+Bg@mail.gmail.com>
        <20181003192127.GC16666@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181003192127.GC16666@sigill.intra.peff.net>
Date:   Wed, 03 Oct 2018 22:35:25 +0200
Message-ID: <87k1myhipe.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, Jeff King wrote:

> On Wed, Oct 03, 2018 at 12:08:15PM -0700, Stefan Beller wrote:
>
>> I share these concerns in a slightly more abstract way, as
>> I would bucket the actions into two separate bins:
>>
>> One bin that throws away information.
>> this would include removing expired reflog entries (which
>> I do not think are garbage, or collection thereof), but their
>> usefulness is questionable.
>>
>> The other bin would be actions that optimize but
>> do not throw away any information, repacking (without
>> dropping files) would be part of it, or the new
>> "write additional files".
>>
>> Maybe we can move all actions of the second bin into a new
>> "git optimize" command, and git gc would do first the "throw away
>> things" and then the optimize action, whereas clone would only
>> go for the second optimizing part?
>
> One problem with that world-view is that some of the operations do
> _both_, for efficiency. E.g., repacking will drop unreachable objects in
> too-old packs. We could actually be more aggressive in combining things
> here. For instance, a full object graph walk in linux.git takes 30-60
> seconds, depending on your CPU. But we do it at least twice during a gc:
> once to repack, and then again to determine reachability for pruning.
>
> If you generate bitmaps during the repack step, you can use them during
> the prune step. But by itself, the cost of generating the bitmaps
> generally outweighs the extra walk. So it's not worth generating them
> _just_ for this (but is an obvious optimization for a server which would
> be generating them anyway).

I don't mean to fan the flames of this obviously controversial "git gc
does optimization" topic (which I didn't suspect there would be a debate
about...), but a related thing I was wondering about the other day is
whether we could have a gc.fsck option, and in the background do fsck
while we were at it, and report this back via some facility like
gc.log[1].

That would also fall into this category of more work we could do while
we're doing a full walk anyway, but as with what you're suggesting would
require some refactoring.

1. Well, one that doesn't suck, see
   https://public-inbox.org/git/87inc89j38.fsf@evledraar.gmail.com/ /
   https://public-inbox.org/git/87d0vmck55.fsf@evledraar.gmail.com/ etc.
