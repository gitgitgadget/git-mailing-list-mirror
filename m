Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C281F424
	for <e@80x24.org>; Wed,  9 May 2018 18:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935544AbeEISwy (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:52:54 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53557 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935523AbeEISwx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 14:52:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id a67-v6so176780wmf.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=0jAbZht2b0ASny5fecbODrVCloIOY0xt+wvVBD3P8UE=;
        b=ZYQIH81/w7NOkpNf0SXwV2hsFCmqv/0wexiC0rAVzT1V4EUZuhWC2NusZB+uMbxtgo
         kdHgH24dNrxdjkynqYQxJozgsGVJ69Ncrgx/yqWq6n1Ihp9f4GwytIvDfQc1C7Swoy2e
         oV0ke/85Xy8K8zJmWBHLNC5p/erQr4+7r36OfsdpMjOjrqcXGsfQ0mx83Nh13RfmFfY7
         oHThnv/pbmwRG7sn9lyepKhylV+GztuzoNP3pGXc23IGHJUZwm4a2/LkPEGOMDk9TR04
         0EkoccxILYeExarFWjq2LJhBDRz3KnNDiN0z99fyv6bSMj4UprIhYgVfI9O7HytXhxSu
         qobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=0jAbZht2b0ASny5fecbODrVCloIOY0xt+wvVBD3P8UE=;
        b=VpyLiuvsAn+7OhKqzUIyP6HOeQbtUsyZGqgg/sWBT9gM6VPmidL6DZpS6tsIIrg9IA
         U2rOsRL5KOaUkUxEe//JgqomcmzLrtNT05POZh+59IO6wpwTBsmJdV2qXbppGoYrDo5C
         wbb7Gkt9LUJqKHvPBswBe7jFS7I4DuQ6KlXlh5QZdM40nFRLanUoPV/VKufvMoNDzWY5
         oWrcyZ/Xlslsz3O3C9PeQ9z2nypbLoCsh25MNaRXTAmAuy+QaC1edCQjLmmZQ5CIRhEp
         raeLLqzr5kANwqMNPM9dz1O+NpiZ4mLNGj6lXrA6ZIeALsULn6ik6Y6pJswrb1Xxyjav
         V1XQ==
X-Gm-Message-State: ALQs6tBCMFkzUTJcOHgoSV8d1S5klqlGPCYQuAMIjdAQrQj2YXNvHaym
        tPAN8VYZOd9V/rWwOYGzjBDhtwQl
X-Google-Smtp-Source: AB8JxZoo//DpNkgN8q9r3j/2zR7b5hx2zPTo0sXsBXbQiaeuwZRuHFwBVi+UPSQ9V14XxzQspjhJtQ==
X-Received: by 2002:a50:a845:: with SMTP id j63-v6mr61599917edc.210.1525891972390;
        Wed, 09 May 2018 11:52:52 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id w26-v6sm15696365edq.77.2018.05.09.11.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 11:52:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Implementing reftable in Git
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
        <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kZx=wHKc=2WLz-8pQWv1VhRq+pKVV9=Shq3gEMdkX-Q=A@mail.gmail.com>
Date:   Wed, 09 May 2018 20:52:50 +0200
Message-ID: <874ljgy83h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 09 2018, Stefan Beller wrote:

> Hi Christian,
>
> On Wed, May 9, 2018 at 7:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>>
>> I might start working on implementing reftable in Git soon.
>
> Cool! Everyone is waiting for it as they dream about the
> performance and correctness benefits this brings.
>
> Benefits that I know of:
> * performance in repos with many refs
> * no capitalization issues on case insensitive FS
> * replay-ability of the last fetch ("show the last reflog
>   of any ref under refs/remote/origin") is easier to do
>   in a correct way. (This is one of my motivations to desire reftables)
> * We *might* be able to use reftables in negotiation later
>   ("client: Last I fetched, you said your latest transaction
>   number was '5' with the hash over all refs to be <sha1>;
>   server: ok, here are the refs and the pack, you're welcome").
>
> Why are you (or rather booking.com) interested in this?

We have a lot of refs, which is a longer-term scalability issue (which
I've implemented hacks around (ref archiving)), and we also run into the
capitalization issues you mentioned.
