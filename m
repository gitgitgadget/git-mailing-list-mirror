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
	by dcvr.yhbt.net (Postfix) with ESMTP id 776B41F463
	for <e@80x24.org>; Wed, 18 Sep 2019 17:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfIRRXw (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 13:23:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41543 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728872AbfIRRXw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 13:23:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id p10so239285qkg.8
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOH7802mfI2burxCXgTdcsEk9jSf/rCWbk8xB/8o+lY=;
        b=De2jfJxTUf2L00S6FkTqeFCcBoTIgL6IX3eCLOympd/enU9EEwrEUJg0yzwuOuOUiM
         Csj3gCkyPxAw0ZsaD6ip4Slyf6T5VXjfImt6+KtPsh8+SzEAvXL9kNHJM4Py0mVF3Fl3
         TSDCfJWljFWBYgbJxLNDjIJa/QpLeNyxRji7bhMRtELpowFC3IwpK/lRp8SdCucEJ4Zz
         kbw5jQJigkApuEHZHsXQq0cyxEZC4Pz35IfNu7+MTm2Q50ZGYRxEPfrX0P6EPslRxbRe
         IkrjZixR/sYsf7IEam7GZL96GJZB2kQLpOzBnjs5x62a4+2nsO6VUXsk1kKXtugRwiln
         bgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOH7802mfI2burxCXgTdcsEk9jSf/rCWbk8xB/8o+lY=;
        b=hoZJGQsZI9U/r41aSt3cXlEJoaf8m9//4dzG8FKgoQV5kM2l7DBMIq88Ori7BRenv5
         Tt9e5ARKIN5f1il45kC0lzftuSk1RiO4HFQaaLlKgVXw9phmdLfaCCv51ZbR1arQDSEB
         8ialRSiejeu4iFb/Izn7qE5fTZ8u/9937nsI1zYJI1zfzZ64yejifIhCmuc9DTWgdhOt
         CLjikBiskSn1HiHidOz7wRZTkN679NuORjIu6+u85P14hvJ1GPdNisGuKFI5bbtGzOKK
         5nGcn1Hbov5flUGlFJPWZ5pE/qBEi0Q775ZXvXhTMfjqJ5d0I8u4YtnwN9lFaajsW27N
         +9Vg==
X-Gm-Message-State: APjAAAUCM7fxhGwXlJDCMlKH7phzju9DxeoETvNzLXjSrXa6OI4kz9TP
        O5m0PQSE4lcTiiuqWViw34c=
X-Google-Smtp-Source: APXvYqy86fqQnv2mRHZDdb/YQ/ChJ2tuHZkPQBw96GQG8HLyHcMFvxgEAzqzFzJy+Htv0qGrZH0jcQ==
X-Received: by 2002:a37:2e01:: with SMTP id u1mr5214469qkh.455.1568827431323;
        Wed, 18 Sep 2019 10:23:51 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id w11sm3683292qtj.10.2019.09.18.10.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:23:50 -0700 (PDT)
Subject: Re: [PATCH 4/9] sparse-checkout: 'add' subcommand
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BEhc00g3CwKg13wDrtFHM-sw9tSy75UEbTvugKkdwTyeA@mail.gmail.com>
 <52c5b7cc-eab1-a74d-2abb-be8f125df9bf@gmail.com>
 <CABPp-BGcPkbLfDQDBMrG+5PK9o67kq62c1TPiEwLpwZQXcZTCg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d0bb29ef-6702-06b6-2369-a49817a0faa1@gmail.com>
Date:   Wed, 18 Sep 2019 13:23:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGcPkbLfDQDBMrG+5PK9o67kq62c1TPiEwLpwZQXcZTCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2019 10:56 AM, Elijah Newren wrote:
> On Wed, Sep 18, 2019 at 6:55 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 8/23/2019 7:30 PM, Elijah Newren wrote:
>>> On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
> ...
>>>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>>>> index b7d5f15830..499bd8d6d0 100755
>>>> --- a/t/t1091-sparse-checkout-builtin.sh
>>>> +++ b/t/t1091-sparse-checkout-builtin.sh
>>>> @@ -100,4 +100,24 @@ test_expect_success 'clone --sparse' '
>>>>         test_cmp expect dir
>>>>  '
>>>>
>>>> +test_expect_success 'add to existing sparse-checkout' '
>>>> +       echo "/folder2/*" | git -C repo sparse-checkout add &&
>>>
>>> I've always been using '/folder2/' in sparse-checkout, without the
>>> trailing asterisk.  That seems more friendly for cone mode too.  Are
>>> there benefits to keeping the trailing asterisk?
>>
>> I think I've been seeing issues with pattern matching on Windows without
>> the trailing asterisk. I'm currently double-checking to make sure this
>> is important or not.
> 
> Can you try with the en/clean-nested-with-ignored topic in pu to see
> if that fixes those issues?

Merging with that branch was very difficult. There is a lot of unshared
history between our branches.

Instead, I tried once more to dig into the strange issue on Windows, and
it appears it is an issue with how the Git for Windows SDK modifies shell
arguments with a "/".

When I ran `git sparse-checkout set "/folder1/*"` it worked.

When I run `git sparse-checkout set "/folder1/"`, the SDK completes that
argument to "C:/git-sdk-64/folder1/" on my machine (something more
complicated on the build machine). It's not actually a bug in the Git
code, but something in the build and test environment.

I can get around it by testing the builtin without using these cone-like
patterns. When using `git sparse-checkout set folder1 folder2` in cone
mode, Git does the right thing.

Sorry for the noise here.

-Stolee

