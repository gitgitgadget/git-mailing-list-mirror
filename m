Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74597202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 19:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdJWTc4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 15:32:56 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:49311 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdJWTcz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 15:32:55 -0400
Received: by mail-qt0-f180.google.com with SMTP id k31so27647483qta.6
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yyq5gNW7GWvY9M+0/mQK2Su5rZEWiMF5R/gIGPaIdpg=;
        b=Z9xjc+slwc2gAtBULWQthN4c9e6WSqpPlYVsMVMdvMd8qwC8rPKRHafJnOJ8gWM3Xc
         5DnkYd38f2noMFgzZh1EJrQJ5Dv1wyu6egKN4lyT/ItXDwiCGQKPK/AkA5v3bzAyRCe6
         M6I4o20ZBGHcKfofmfZEHYZbYeewffFcvrxGx2dLvd3n14+V1xOdX70dZCFrHfdEbxAH
         sjPhEV+uLoPBheB4QixvvSR8UYG03kwqyp2TCg++IP4Q/EcxIjGujszRgqjTrtVuMlpU
         qb+wEgylp6QfZK3IbkKggAuAJEnzuFX2s8xBQkk75y+8Kqcc7OPbZv7A8NH0d6Ma1bdo
         8Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yyq5gNW7GWvY9M+0/mQK2Su5rZEWiMF5R/gIGPaIdpg=;
        b=rdaGlxJgJkxGWeA9ratfxew62YmsBdDFDCQHYk97NQfTD9+2aZazysifrUlVQV0itX
         xUKvmcOsTvShZRzUMjdOjtE6JLZdKwYpUw2KNfmfk1RJMfRKDQY5Pa3stZ0+gIgq/g9B
         DyGpi8s6VXRfTBxUSobVihldqamf1Nzbn/p7qdD6P4kb4T4G3yBZ5DZb/WVEHXTMLNtg
         waXSEkitZbHic+QC7ISaq4AhK6as86V8yR6C6WQA5MqZ+/hyhwaFZXcqGSU5YgMoKMEy
         8FK0kryxDF08lpA1/CjbyAl+WXxnRUwoOp9Vg95lG0dkKNaHQJftsmjFlrLoQRPAWgBe
         H35A==
X-Gm-Message-State: AMCzsaUKyBe5yuJJijmxXfgVsNV6QkAVbEESJFL2MXnpN3fdCvTQOGnc
        +yxQgALRTfm43rheAw8IPje1HkUwwFggrWLjhfFxbQ==
X-Google-Smtp-Source: ABhQp+SY94IFl5Se8i7jCpYhw8yy4fQD0tSUId/4qCmF2VYbNkKUF92Nu+ZWIaGlvkWwWCbJv/ZJohewXl0qhDYJDMg=
X-Received: by 10.237.34.201 with SMTP id q9mr21439065qtc.198.1508787174148;
 Mon, 23 Oct 2017 12:32:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 12:32:53 -0700 (PDT)
In-Reply-To: <1508554594.2516.7.camel@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <20170925082024.2691-3-kaarticsivaraam91196@gmail.com>
 <CAGZ79kYLX+mXaWA-ZGnCWE7UBoZ2N76_MHQ6tB7+yGYDBRXUCA@mail.gmail.com> <1508554594.2516.7.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 12:32:53 -0700
Message-ID: <CAGZ79kbmqfW+Z1hWUhiOPKQzd0_bDzZrkKrFt=YbvCcKCfd7YA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] branch: re-order function arguments to group
 related arguments
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 7:56 PM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On Fri, 2017-10-20 at 14:50 -0700, Stefan Beller wrote:
>> On Mon, Sep 25, 2017 at 1:20 AM, Kaartic Sivaraam
>> <kaartic.sivaraam@gmail.com> wrote:
>> > The ad-hoc patches to add new arguments to a function when needed
>> > resulted in the related arguments not being close to each other.
>> > This misleads the person reading the code to believe that there isn't
>> > much relation between those arguments while it's not the case.
>> >
>> > So, re-order the arguments to keep the related arguments close to each
>> > other.
>>
>> Thanks for taking a lot at the code quality in detail.
>>
>> In my currently checked out version of Git, there are two occurrences
>> of create_branch in builtin/branch.c, this patch converts only one occurrence.
>>
>> (So you'd need to convert that second one, too. Oh wait; it is converted
>> implicitly as the arguments are both '0':
>>     create_branch(branch->name, new_upstream, 0, 0, 0, \
>>         quiet, BRANCH_TRACK_OVERRIDE);
>> )
>>
>> This leads to the generic problem of this patch: Assume there are other
>> contributors that write patches. They may introduce new calls to
>> `create_branch`, but using the order of parameters as they may
>> be unaware of this patch and they'd test without this patch.
>>
>> As the signature of the function call doesn't change the compiler
>> doesn't assist us in finding such a potential race between patches.
>>
>> I am not aware of any other patches in flight, so we *might* be fine
>> with this patch. But hope is rarely a good strategy.
>>
>> Can we change the function signature (the name or another order
>> of arguments that also makes sense, or making one of the
>> parameters an enum) such that a potential race can be detected
>> easier?
>>
>
> I don't have a great interest in keeping this patch in case it might
> conflict with other patches. Anyways, I guess we could avoid the issue
> by making the last 'enum' parameter as the third parameter. It pretty
> well changes the order by moving the flag-like parameters to the last
> but it doesn't change the signature very strongly as you can pass
> integers in the place of enums. (I guess that also obviates the
> suggestion of making one parameter an enum)
>
> So, the only way around is to rename the function which is something I
> wouldn't like to do myself unless other people like the idea. So,
> should I drop this patch or should I rename the function?

Well let's keep the patch and closely watch next/pu to see if there might
topics that conflict, then. I do really like these small fixes to make the
code more readable. e.g.

  $ git log --oneline origin/master..origin/pu  -G create_branch
