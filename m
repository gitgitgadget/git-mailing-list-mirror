Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C811F462
	for <e@80x24.org>; Mon, 17 Jun 2019 09:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfFQJLB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 05:11:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37581 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfFQJLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 05:11:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so5714755wme.2
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sOsCZaElHZ3j8lTRGdbkpyfpi1vHaOLNyekII4V2p28=;
        b=lOBPaRzOP24zGIa+NnnJrFyhQIQqrkxN8bCSkq9LaSIC+UNUV+3spwAGiO76TxoB1b
         JgMTYhF/5Xrz53vO+1BJX7K3/xScMWLNGKXsIcAiwigo4UoW1pZOsj0ZS7lLSnMq5U+w
         ioqnY20V19AFZKObJUOXQotSiwmpURbWStSsIW4GAob5Ir9zCryrHvw4cvefQlsE5ezp
         plLNU+wNvv9L5AEe2x7S2081pJIk7ZSyM8t5XF5J56/1FijZ0BFej0oySVfVFWcppybo
         oKVbVtOqIvtJw1t/VoNVVFZQcEx7LodvNWAobOUZGNe2iAvCnv+hYgOA8vC0YAf00+6Q
         OoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sOsCZaElHZ3j8lTRGdbkpyfpi1vHaOLNyekII4V2p28=;
        b=Hx0GCpYB9QEKhU4dOPq4qko4kspexHXEpgL7n/N55QS/zxuf6p7fG0zsJOInPcHpI9
         iaxF4ggnQpKLcPb8kRSdGu4kUm/KucrorU6vd5kt7AERDbRh0Rd7uEUXse2krl3rr93u
         C5bJcmpcVZa/1X88iYEh8q+bLWKrcX86kjy2QllwexaI2WJo1hVN+Z8oQwC8WY67AZf4
         aambne9MKpRZaZaMAGkh97LUFm+3ZkqHz0oDq98jVkCVoTHywteEEgGl0l7Jw/QSGplz
         ahBlMFb0xLg1ctiVlAXlzwD7Io1Ta4DlnQOHCOMdWJqofAuI4xORwvy0ZUXdoF+7YgHh
         zZgw==
X-Gm-Message-State: APjAAAW4qAVF1qzXKXdx+SbHSDrEjUsQ3uIdpVNpjsBxeEeoqjnsNJzn
        XDWwa8Evnm06PWvajHHnsehyiuoy
X-Google-Smtp-Source: APXvYqwCAv6v8lX/eVKF868gezm4xv3ngcaCj31ny5/MwzGLXixUL9fj0LVo4AoqHHcsxRZfBXvBnQ==
X-Received: by 2002:a1c:a5c3:: with SMTP id o186mr17955072wme.15.1560762658281;
        Mon, 17 Jun 2019 02:10:58 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id o185sm12049257wmo.45.2019.06.17.02.10.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 02:10:57 -0700 (PDT)
Subject: Re: [PATCH] show --continue/skip etc. consistently in synopsis
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190616132457.19413-1-phillip.wood123@gmail.com>
 <CABPp-BFAJtY2Bzow6T6kYoFqYifKzMinmjF0_EJa-fepcWcppQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1a005f73-f620-19ea-d0d7-88621597bcae@gmail.com>
Date:   Mon, 17 Jun 2019 10:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFAJtY2Bzow6T6kYoFqYifKzMinmjF0_EJa-fepcWcppQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/06/2019 03:02, Elijah Newren wrote:
> On Sun, Jun 16, 2019 at 6:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The synopsis for am shows the command mode options as
>>     (--continue | --skip | --abort | --quit)
>> They are on a single line and in parenthesis as they are not
>> optional. Fix the merge and rebase docs to match this style.
> 
> Thanks for working to make this more consistent.  One minor issue...
> 
>> ---
>> This patch is based on top of nd/merge-quit.
>> The docs for cherry-pick/revert are updated to this style by
>> https://public-inbox.org/git/20190616082040.9440-1-rohit.ashiwal265@gmail.com/T/#u
>>
>> Documentation/git-merge.txt  | 3 +--
>>  Documentation/git-rebase.txt | 2 +-
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>> index b7d581fc76..07ca9fb78c 100644
>> --- a/Documentation/git-merge.txt
>> +++ b/Documentation/git-merge.txt
>> @@ -13,8 +13,7 @@ SYNOPSIS
>>         [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
>>         [--[no-]allow-unrelated-histories]
>>         [--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
>> -'git merge' --abort
>> -'git merge' --continue
>> +'git merge' (--continue | --skip | --abort | --quit)
> 
> merge --skip?  I think you meant to just add --quit here, but copied
> from elsewhere and accidentally inserted --skip?

Thanks, you're right I got a bit carried away with copying and pasting.

Best Wishes

Phillip
