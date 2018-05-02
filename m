Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C1E021847
	for <e@80x24.org>; Wed,  2 May 2018 18:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751004AbeEBSXR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 14:23:17 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41201 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBSXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 14:23:16 -0400
Received: by mail-ot0-f195.google.com with SMTP id t1-v6so17710626oth.8
        for <git@vger.kernel.org>; Wed, 02 May 2018 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ImIEr8waZLYbicd5KZIvRgA5nSXyA2A5+AT+7LBapIM=;
        b=OW+qHX6ONRdgy9blkxHavzod0VA/+ZUUfhQt2tceQx/1faCsGh5gi2YgveAdVKHg9n
         FYGApl+n4g/KjNFytQ1q/YWR7rTW+FGMZZYglkvo6MrMFIR1EFky/pr2IESBur6+kzXJ
         LLMyecxrb9s1Zutujt45TcLz/tcN2zHYQgkors+Vd/aBrinxHCqfuzUdg4j/LoLeyBRh
         JdAW8QK29x4pMgzByBVP/8bnFruEgXsAecOcgN5O8s+xfsHS7t8QVCjzPo9683ZuLvLs
         b953Vzf3JfO/c2gW4NSq/0dyaQLr4V0T7b/mK9702JsiDmOnVWwKPFa4xQLEiJJZHp6y
         t1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ImIEr8waZLYbicd5KZIvRgA5nSXyA2A5+AT+7LBapIM=;
        b=lP8qPrYbh352PX0OIRCYNJvvzixcPKSy72K1qg8Pn4pacRAw4/MTjqM6Du0DTdsLn0
         O8Weh3Dd+jSpiK6O4IB2yCJB9toDyjwkc8VqmUS699xWAyBO7XeiSLfvS/kwZL3IsUO/
         Bg9kv1rmKusVJHz97wxahZqNA92QFLQMqodWJ69WF9B3K5g8KkO0prodyiLpgc/jXjw2
         /WK1ZpyAMyfiskV5PQUu/VGZRlsMie3jaq+q+3ZWNozyVIS0h0Ta84poiZk0eS3tcmcZ
         5UOsC5DR6+S7/Sa92puLq5GclUIuQnONV+NRH0BywmcKoo+9MSlMyps96hLpohGslaCE
         Xa2A==
X-Gm-Message-State: ALQs6tDAIYWXMMR0keI4NihfdZ2Vqf3bscFcy1DirqlijXo5mvIB3sjz
        3hrIDkk5YnJmkzypRFes6egAH+kUCI9Yc1Nfrx4=
X-Google-Smtp-Source: AB8JxZqPjKleyXchP5kEKcJae6+yW/Ui/PZUqshjJzwtPa8iOYbk8cgvYJsRxxeJ/IfDlVo3PKMY/OlwvipiprApEBQ=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr15417189otb.152.1525285395922;
 Wed, 02 May 2018 11:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 11:22:44 -0700 (PDT)
In-Reply-To: <BL0PR2101MB1106C07DEE184F8DA2C7CA62CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
References: <20180501213403.14643-1-sbeller@google.com> <CACsJy8DKnBRDZC=oBd8nTOAVzQf3UtoLCeoGKjcMHgUmXf-KqQ@mail.gmail.com>
 <BL0PR2101MB1106C07DEE184F8DA2C7CA62CE800@BL0PR2101MB1106.namprd21.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 20:22:44 +0200
Message-ID: <CACsJy8CR1RYYdsc5=8hz2Sx9_bOY9eb_-vwEqDo62Hex1FxBmw@mail.gmail.com>
Subject: Re: [PATCH 00/13] object store: alloc
To:     Jameson Miller <jamill@microsoft.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 8:07 PM, Jameson Miller <jamill@microsoft.com> wrote:
>
>
>> -----Original Message-----
>> From: Duy Nguyen <pclouds@gmail.com>
>> Sent: Wednesday, May 2, 2018 1:02 PM
>> To: Stefan Beller <sbeller@google.com>
>> Cc: Git Mailing List <git@vger.kernel.org>; Jameson Miller
>> <jamill@microsoft.com>
>> Subject: Re: [PATCH 00/13] object store: alloc
>>
>> On Tue, May 1, 2018 at 11:33 PM, Stefan Beller <sbeller@google.com> wrote:
>> > I also debated if it is worth converting alloc.c via this patch series
>> > or if it might make more sense to use the new mem-pool by Jameson[1].
>> >
>> > I vaguely wonder about the performance impact, as the object
>> > allocation code seemed to be relevant in the past.
>>
>> If I remember correctly, alloc.c was added because malloc() has too high
>> overhead per allocation (and we create like millions of them). As long as you
>> keep allocation overhead low, it should be ok. Note that we allocate a lot more
>> than the mem-pool's main target (cache entries if I remember correctly). We
>> may have a couple thousands cache entries.  We already deal with a couple
>> million of struct object.
>
> The work to move cache entry allocation onto a memory pool was motivated by
> the fact that we are looking at indexes with millions of entries. If there is scaling
> concern with the current version of mem-pool, we would like to address it there
> as well. Or if there is improvements that can be shared, that would be nice as well.

I think the two have quite different characteristics. alloc.c code is
driven by overhead. struct blob is only 24 bytes each and about 1/3
the repo is blobs, and each malloc has 16 bytes overhead or so if I
remember correctly. struct cache_entry at minimum in 88 bytes so
relative overhead is not that a big deal (but sure reducing it is
still very nice).

mem-pool is about allocation speed, but I think that's not a concern
for alloc.c because when we do full rev walk, I think I/O is always
the bottleneck (maybe object lookup as well). I don't see a good way
to have the one memory allocator that satisfyies both to be honest. If
you could allocate fixed-size cache entries most of the time (e.g.
larger entries will be allocated using malloc or something, and should
be a small number), then perhaps we can unify. Or if mem-pool can have
an option to allocated fixed size pieces with no overhead, that would
be great (sorry I still have not read that mem-pool series yet)
-- 
Duy
