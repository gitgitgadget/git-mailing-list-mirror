Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE961F424
	for <e@80x24.org>; Wed,  9 May 2018 18:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935353AbeEISJ0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:09:26 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:39676 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935177AbeEISJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 14:09:25 -0400
Received: by mail-yw0-f169.google.com with SMTP id v132-v6so10970681ywc.6
        for <git@vger.kernel.org>; Wed, 09 May 2018 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7ZGjTox82WipCAlxO9xFH4/uEp85FA+psOa9yJ43u28=;
        b=Sg/99bv6sMpBnCeKcQTQc6sepO5/tF4zvrKfhWGd73yFJbi4kwqGL0m7uajvbvy51q
         Hrs9NIXm5LtNIsXG8xSvALmkyMwDjK/9oByEbz8avGSRKPjKkhZoZmkEGKt3ulphzHTd
         5+CmhHJIJu+aT55V5eai5lEZEiM8f0Or33ftHYugsYgQb7OjQ43jwg/E0/fufZQ8Y9f7
         bR+yQciHMS2yzExKeIZ8x34WPxJlMTEOjeyKjEJ7a+jpYpAKwWzFmg6KSchfyggTO8da
         5+VrTOB4udycfmNfwRq4xo/YTac6ZKkwjsMDFtrQllfl1kaW0bSUA2agvubQzkC0pnlz
         HWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7ZGjTox82WipCAlxO9xFH4/uEp85FA+psOa9yJ43u28=;
        b=LH5fqovYM50g+WfXafUB3O9ApiCF/Nib0R2AFnkW3CnGzzx9w+zRifGxZdnCNHklrv
         RWT7aoPPosDBE+y4tJ0hQSGMKSO1DUDiKX0k1SflSaS98EMTsBeyN2kEERW2Y7JBjXHe
         646QfpK2l5jC1YrUBXXNC8Xhlxh1QL7D/23+yzCFx2lCyb6c2HoKWQE078FSX7wm9drK
         fD2qpS+IevYzzFxu2GL4VqkOP/c0BNXBk+rceO1sfiG1h2cg7KwsUa6WujUxkpVymm5r
         7Z1EEU7cvpM32xmCxRN8aLnxq9LwWrmZeYWUBtg/gtNmX9p4djeZ96ec6hfkc+oJ9U+j
         +tqg==
X-Gm-Message-State: ALQs6tAZtJrsHTA89GSyn7b7Bew+5u3biY6P38/xPDeVm+q7xWauVYF/
        JaS7GREHn2LmcNHSA5u96tm51Y+k8vUFfI5i5FC+Vqar
X-Google-Smtp-Source: AB8JxZpzxjje8ud9z9NFovqx6nDSpzk8nJQ47pqRp8bN1y2SJ9Cgi4t6GDolbI3RcPopwFKSyA7SLGzLL7xInJFjbk0=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr19303299ywg.345.1525889364110;
 Wed, 09 May 2018 11:09:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 11:09:23 -0700 (PDT)
In-Reply-To: <CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com>
References: <20180509170409.13666-1-pclouds@gmail.com> <CAGZ79kbFiULj1NJARm6ObYrqv_Fu+U2sb8h_sNJwdWur+JqrvQ@mail.gmail.com>
 <CACsJy8AdJcQpiGrR3p6xfuqU0=qoP3=StgbWRNCkdfka6di+5w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 11:09:23 -0700
Message-ID: <CAGZ79kZvG4+=Mx24-HWdsaxsiKS_3YynKDnTB1b-a3kLvM16Xw@mail.gmail.com>
Subject: Re: [PATCH] repository: fix free problem with repo_clear(the_repository)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 11:00 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 9, 2018 at 7:50 PM, Stefan Beller <sbeller@google.com> wrote:
>>>  I was trying to test the new parsed_object_pool_clear() and found this.
>>
>> So this would go with the latest sb/object-store-alloc ?
>
> No this should be separate because sb/object-store-alloc did not even
> touch this code. I mistakenly thought you wrote this and sent to you.
> I should have checked and sent to Brandon instead.

Yes, they do not produce merge conflicts and do not semantically
rely on each other. Except as noted below
the object store series complicated things in a non-latest version
of it, such that we'd have to add more special casing. Now everything
is fine.


>> I would rather special case the_repository even more instead
>> of having it allocate all its things on the heap. (However we rather
>> want to profile it and argue with data....)
>
> I'm actually going the opposite direction and trying hard to make
> the_repository normal like everybody else :)

ok, both Brandon and you want to do this, so I guess we'll just
go this route for now.

>
> discard_index(repo->index);
> if (repo->index != &the_index)
>         FREE_AND_NULL(repo->index);
>
>> What is your use case of repo_clear(the_repository)?
>
> No actual use case right now. See [1] for the code that triggered
> this. I do want to free some memory in pack-objects and repo_clear()
> _might_ be the one. I'm not sure yet.

This diff seems good to me. as any repo is cleared and wil have the minimal
amount of memory. the_repository clears its the_index which is also fine
as it has the minimal amount of memory then, too

Thanks,
Stefan
