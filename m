Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B0720248
	for <e@80x24.org>; Thu, 21 Mar 2019 00:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCUAiJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 20:38:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33379 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUAiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 20:38:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so4780382wrp.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 17:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k1r3wk4zv2ugINsrHAcKHhhiisOiDZsQoHkqJAHscjI=;
        b=iKCKHsD93kRs4nBi/8g+kxtG2geCbmlrIBWufdl73gYYsDyh4oEzhV4IFZ0sydvx9l
         LLf7rI2QOoNV1WNg4S3v0ZQDQwAYcaBm1Iu2cNjaHRK3yp/138rf2DJhj+6zEbX9xMrd
         Z7YFJHmiiQ2PC5zZHe9sfzVM+RiR8sfpp2ygkF8QRnRU3/+8uniTcm1QWZvWMqvPiPI3
         BcN+FIPY74cd1Nqqgw7oFtGQpBHn15gi7AGaBsooL7rG9lHZXkW7eQMVIGMkIn6mCjcP
         wh417eRDNwsXtdSFq9w1E2lfrvy7lZdPVIjAPY35Ycwjslc69mBMIhNts1XkwHhw7xG7
         NB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k1r3wk4zv2ugINsrHAcKHhhiisOiDZsQoHkqJAHscjI=;
        b=Hjt1fc7JjG+TdAvubgB7QkhKoxVzSX+x6EqGWrUHsGsrqpgIGw56kojIKkQbTFh7Da
         3IW5wdS+x1XiUA6V7TvbHGV1i6GF/cuPhsVQRvPudN2OZOGxWP9SeJDUgv9Y8W52S+OI
         rEIb2nR1gBk1/IH+3ik3qo+5+yi52Tff8z7siZpiDN+zZNlhEmqUVzr/7r5Qddok20ld
         0hN8ScCbKV0V2VtAn2+dspRQlvsAn+cfT0pnVFkYRmxmuWAa6xgE8vvH1UM1rx5nQd2E
         TJ/J0uieYorVjzSyObzs/npTWQFp585oZgViweYNTbICo97sYhCLF3yxsA7T2JHRHy8a
         zncQ==
X-Gm-Message-State: APjAAAVeky1wpIUSvKvJKGljgfzm56rOx2+qo0a13rP9O4esJp1Vlw6P
        y8EzEU1V0fuoPFxFlL8XQ0dofcDS6vM=
X-Google-Smtp-Source: APXvYqy8G+H0EKuQvtXZ5+YlxIsoao3vmqHuPZZ/d1KqwsQHi9dGdKNvlUCYW9RoT7pAPdzyL4a7BA==
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr602968wro.274.1553128687296;
        Wed, 20 Mar 2019 17:38:07 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w18sm5971050wru.24.2019.03.20.17.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 17:38:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
        <20190319093910.20229-1-pclouds@gmail.com>
        <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
        <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
        <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
Date:   Thu, 21 Mar 2019 09:38:06 +0900
In-Reply-To: <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 20 Mar 2019 07:53:01 -0600")
Message-ID: <xmqqimwduknl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Tue, Mar 19, 2019 at 7:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > Kinda. But "--force --merge" makes no sense. --force discards all
>> > local changes by definition, which means you can't have conflicts and
>> > will not need --merge. I think this is the reason why we die() out
>> > when both are specified. So we need something like
>> > --discard-staged-changes-only...
>>
>> At that point, I would have to say that we do not need anything.
>> The use case is already covered with "git reset && git checkout -m",
>> isn't it?
>
> I guess the problem is just that 'git checkout -m' has not refused to
> run with either a dirty index or a dirty working tree, and if both are
> dirty (making us require more of a four-way merge), then our three-way
> merge has to ...

I didn't actually mean "nothing to do here" relative to the current
code; instead, I meant "nothing more than just stop when the index
has updates" (which is hard to read from the above quoted part, as
"Kinda." is a response in a discussion started with my "checkout -m
should probably refuse to do anything when the index is dirty").

> So, I think we do need something (eventually at least).  Would you
> prefer we dropped this patch from Duy and instead made 'checkout -m'
> abort when the index is dirty?

Let's go with the doc update first, as the patch has already
written.  I think in the longer term, just aborting when the index
is dirty would be a vast improvement over the status quo + a doc
update and is a good place to stop.

Thanks.
