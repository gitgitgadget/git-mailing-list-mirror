Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C8C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbiADTZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiADTZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:25:00 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4522C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 11:24:59 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y70so45513222iof.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BxcrYWi2/zE468jtMoNVRd3yXKcF+nb28PtV3FLssFM=;
        b=WGhSGYLEK7lVx1IsFd56i7JJRUIZpFyO5z0uaOfI8brZlXoZAkHAxPA0eA2K4VtdbF
         /6cMctLmMas9f7LEJKCDdtboIUsSOk0+693AXPifBrp4dKPZhaThlxQGqJJV3L5kXgV6
         pyCBtE7bMM9CNJF517pMvM83ZGgNsEDI3iKPV5XimR4EC5AqlnWaDdXFe+T77hrcXVbr
         nkMSc7bUk+1q4etDlBOhfZt1We8e4u+DLwANqvUyFrNPY8Hh1LYViF/CPhGEJoe2bM5T
         RDPcMLyR/C24aSV1kC322zZ0WTjD5gfe6TdoHuO3yNl0W/O6Kp5t6oGIwTnYrwxYlYhD
         /PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BxcrYWi2/zE468jtMoNVRd3yXKcF+nb28PtV3FLssFM=;
        b=ZeiYL3NXlwjrrItodwMyauubrk5OrtVsnPSfxhGg5YQyLJxQExh+Mb8pNzXaRfJRur
         V7xm1azEg1dRZvYhfNFz5BT9Bb6GZKRJgyL+H8FjlfVBndV3WgeqLHm14VYuYGKG4svV
         h0Xd3IsHpSRbr29QoXMPPf620TOG5ie4O7RWIYkG7yCGuIZdIQyZ74/VukCWbFXW2LEe
         QOX7ZqBuYfKWRoUz1rG/NPeepoAalrfDucYTB5jy2A/njUmSnIX7o5q+p7tKxry9DfgB
         PwAqANrfb+EnJeS60W7AJCBwrNTbGkG/eUSFSkC5jBS9KMu6kQcKHIjZVpUgccYgj3zI
         jAzg==
X-Gm-Message-State: AOAM532deMdTd25SWrEA1alIIqqL5fkenl0UvfnYljrdyTKqnDxTXJdf
        fRu6EMGn7RtA+GJV79Rrim4=
X-Google-Smtp-Source: ABdhPJzr3Er9xOX9bZviGPkAudRxw45iE4bgaCRc9a7TUoHUq6SVhjR57is7McWZp4zcoUFw56C8rQ==
X-Received: by 2002:a05:6602:1407:: with SMTP id t7mr24291446iov.78.1641324299246;
        Tue, 04 Jan 2022 11:24:59 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id q17sm22251075ilm.32.2022.01.04.11.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 11:24:57 -0800 (PST)
Message-ID: <8dfb06d4-480c-ced8-9de0-de3e81014453@gmail.com>
Date:   Tue, 4 Jan 2022 13:24:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <955fcab00528464b5450bd22b45c89ffc2283e39.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BGdr54XgCXw8k1xRCgkwBtDonyODS3O+_nS_QY3SOEFGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/31/21 2:03 PM, Elijah Newren wrote:
> On Fri, Dec 31, 2021 at 2:32 AM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Add tests for missing/incorrect components of custom tab completion for the
>> sparse-checkout command. These tests specifically highlight the following:
>>
>> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>> (it is missing reapply and add).
>> 2. git sparse-checkout --<TAB> does not complete the help option.
>> 3. Options for subcommands are not tab-completable.
>> 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>> both file names and directory names.
> 
> Two thoughts on this last item:
> 
> I completely agree that only directories should be completed in cone
> mode, but completing on both might technically be considered correct
> behavior for non-cone mode.  However, even in non-cone mode, I kind of
> like the idea of encouraging people to sparsify only on directories so
> I'm totally fine with us only tab-completing directories.  (I have a
> bit of a disdain for non-cone mode, though, so my desire to deprecate
> it might be showing through.  At the very least, I'm still thinking we
> should make cone mode the default in each of `sparse-checkout init`,
> `sparse-checkout set`, and `clone --sparse`[1])
> 
> [1] https://lore.kernel.org/git/6e09ab19-7ffb-e58e-7b08-6e560b421c06@gmail.com/
> 
> 
I'm still supportive of this 😊. I'll chat with others who are heavily
involved with sparse-checkout to make sure I have buy-in. If so, I can
pick it up as my next work item.
> Second, and this item is unrelated to your series but your comment
> made me realize it....sparse-checkout unfortunately ignores prefix and
> creates a bad .git/info/sparse-checkout file.  For example:
> 
> $ git init -b main tmp
> $ cd tmp
> $ mkdir -p a/b/c
> $ touch a/b/c/d a/b/c/e
> $ git add a/
> $ git commit -m "initial"
> $ cd a/  # Not at the toplevel anymore
> $ git sparse-checkout set --cone b/c  # So we expect that a/b/c will
> be the specified sparsity path
> $ git -C .. sparse-checkout list
> b/c
> $ cat ../.git/info/sparse-checkout
> /*
> !/*/
> /b/
> !/b/*/
> /b/c/
> $ pwd -P
> pwd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> 
> I think the loss of the current working directory will be fixed by the
> en/keep-cwd directory (currently in next and marked for merging to
> master), but the fact that the wrong paths end up in the
> sparse-checkout file is unfortunate.  It basically means that the
> `set` and `add` subcommands of `sparse-checkout` can only be safely
> run from the toplevel directory.
> 
>> Although these tests currently fail, they will succeed with the
>> sparse-checkout modifications in git-completion.bash in the next commit in
>> this series.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   t/t9902-completion.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 85 insertions(+)
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 518203fbe07..51d0f2d93a1 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1447,6 +1447,91 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>>          EOF
>>   '
>>
>> +test_expect_failure 'sparse-checkout completes subcommands' '
>> +       test_completion "git sparse-checkout " <<-\EOF
>> +       list Z
>> +       init Z
>> +       set Z
>> +       add Z
>> +       reapply Z
>> +       disable Z
>> +       EOF
>> +'
>> +
>> +test_expect_failure 'sparse-checkout completes options' '
>> +       test_completion "git sparse-checkout --" <<-\EOF
>> +       --help Z
>> +       EOF
>> +'
>> +
>> +test_expect_failure 'sparse-checkout completes subcommand options' '
>> +       test_completion "git sparse-checkout init --" <<-\EOF &&
>> +       --cone Z
>> +       --no-cone Z
>> +       --sparse-index Z
>> +       --no-sparse-index Z
>> +       EOF
>> +
>> +       test_completion "git sparse-checkout set --" <<-\EOF &&
>> +       --cone Z
>> +       --no-cone Z
>> +       --sparse-index Z
>> +       --no-sparse-index Z
>> +       --stdin Z
>> +       EOF
>> +
>> +       test_completion "git sparse-checkout reapply --" <<-\EOF &&
>> +       --cone Z
>> +       --no-cone Z
>> +       --sparse-index Z
>> +       --no-sparse-index Z
>> +       EOF
>> +
>> +       test_completion "git sparse-checkout add --" <<-\EOF
>> +       --stdin Z
>> +       EOF
>> +'
>> +
>> +test_expect_failure 'sparse-checkout completes directory names' '
>> +       # set up sparse-checkout repo
>> +       git init sparse-checkout &&
>> +       (
>> +               cd sparse-checkout &&
>> +               mkdir -p folder1/0/1 folder2/0 folder3 &&
>> +               touch folder1/0/1/t.txt &&
>> +               touch folder2/0/t.txt &&
>> +               touch folder3/t.txt &&
>> +               git add . &&
>> +               git commit -am "Initial commit"
>> +       ) &&
>> +
>> +       # initialize sparse-checkout definitions
>> +       git -C sparse-checkout sparse-checkout init --cone &&
>> +       git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
>> +
>> +       # test tab completion
>> +       (
>> +               cd sparse-checkout &&
>> +               test_completion "git sparse-checkout set f" <<-\EOF
>> +               folder1 Z
>> +               folder1/0 Z
>> +               folder1/0/1 Z
>> +               folder2 Z
>> +               folder2/0 Z
>> +               folder3 Z
>> +               EOF
>> +       ) &&
>> +
>> +       (
>> +               cd sparse-checkout/folder1 &&
>> +               test_completion "git sparse-checkout add " <<-\EOF
>> +               ./ Z
>> +               0 Z
>> +               0/1 Z
>> +               EOF
>> +       )
>> +'
>> +
>>   test_expect_success 'git switch - with -d, complete all references' '
>>          test_completion "git switch -d " <<-\EOF
>>          HEAD Z
>> --
>> gitgitgadget
> 
> Patch looks okay to me, but we might want to add some kind of wording
> around the directories-only decision and cone vs. non-cone mode to the
> commit message.

Can do! Stay tuned for v3.
