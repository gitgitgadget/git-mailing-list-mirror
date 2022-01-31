Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8640C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 20:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbiAaUDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiAaUDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 15:03:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B3DC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 12:03:49 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x11so13477202plg.6
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7/RKPb/W6bacKFaW3+q441ubKS++b9LNnWr238Omj88=;
        b=S2jfszvcfNOGvY/OdjVMCAjRmHOLghROYnpV0xH/137+wexoCtDV4vv233iyzP8ogU
         Lblvlq683iu3Z2ddCwUgtocvLyVHYid1m+tpljf5LJAJhnHgLaOBS6IgFgZfy82FKFji
         rFZ6NrHqw+9LriPigXn5O5TObZRjAGVp+rtc7b0sSlE+QATSwoS5GIa3Cor29Y4rUcVj
         0SQdH20HVrbsCIvpdwVRv/dE0bBGyJSJ9OyG43SdowCHwhnv1ib2S1k89D9+9qTfU2MF
         3qRBe1se87N/zOemyy7ZeXFB4xyd2miFWolTnTrVGQRfuW1ZcxaeBEl7eqSYsfYFFuse
         Gteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7/RKPb/W6bacKFaW3+q441ubKS++b9LNnWr238Omj88=;
        b=T9loecV/xGSaHQ9nv0Hpzf23VkK8QLZNXEvBsKPUK10+8F3vUbUR3qdIg+Tfsc9eBH
         24oH+1855qyLZRRzcPRKNDKtOW8P6JJAGP1XyggOAEmVK8S5SKF5GbImOEbEzXP7aSrG
         8rx/rmqtWjtWTJgOa34XFse64x+gC/duepR/qtDMYfaJ/bISETuvulB55FKCnsNyisYG
         OD9igYV1D06DMX0nSf/pcDAugPml1+Mva8equuDWD+x8C4OgG8TqN6Xj9t4F2eygKHwz
         QorkJeW/+UFBfSb/1k7H+8XKubLzrbakgVojfgioZ1g1/AZ2gwamipKUooxZW2O8zroQ
         0D3Q==
X-Gm-Message-State: AOAM532zg4plqYCw/DyJexEhchpG/UqpvDY95fPDxj/lTL19HlPjPjrl
        xcztrCFNS/Pt2FfchNkJ7Awfdkq6Iw0=
X-Google-Smtp-Source: ABdhPJyHuH5LHcOjdlLhK9Cz+wLRkzFLsfQwfYgnaty7ap7CGSCtvuiHONGF0GyoQROg/gUJCP+eyg==
X-Received: by 2002:a17:902:c206:: with SMTP id 6mr21307940pll.153.1643659428241;
        Mon, 31 Jan 2022 12:03:48 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:81c0:32f9:3054:dbdd? ([2601:602:9e81:12c0:81c0:32f9:3054:dbdd])
        by smtp.gmail.com with ESMTPSA id me4sm155975pjb.26.2022.01.31.12.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 12:03:47 -0800 (PST)
Message-ID: <82bb12d0-0505-1997-21ba-b9863bfdf2c8@gmail.com>
Date:   Mon, 31 Jan 2022 12:03:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v4 2/3] completion: sparse-checkout updates
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <7d70beb2a6b3967c51d1d7feb34bfb9368066cdb.1643318514.git.gitgitgadget@gmail.com>
 <CABPp-BFG6fD3hDTrG_HZP9qv0qYaHBFxV3idik6YHE53cnFt6Q@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BFG6fD3hDTrG_HZP9qv0qYaHBFxV3idik6YHE53cnFt6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/27/22 5:21 PM, Elijah Newren wrote:
> On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Fix custom tab completion for the sparse-checkout command. This will
>> ensure:
>>
>> 1. The full list of subcommands is provided when users enter git
>> sparse-checkout <TAB>.
>> 2. Subcommand options are tab-completable.
>> 3. A list of directories (but not files) is provided when users enter git
>> sparse-checkout add <TAB> or git sparse-checkout set <TAB> in cone mode
>> only. In non-cone mode, these commands will continue to complete both
>> directory and file names.
>>
>> Failing tests that were added in the previous commit to verify these
>> scenarios are now passing with these updates.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   contrib/completion/git-completion.bash | 15 ++++++++-------
>>   t/t9902-completion.sh                  |  4 ++--
>>   2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c82ccaebcc7..a920cdab201 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2988,21 +2988,22 @@ _git_show_branch ()
>>
>>   _git_sparse_checkout ()
>>   {
>> -       local subcommands="list init set disable"
>> +       local subcommands="list init set disable add reapply"
>>          local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +
>>          if [ -z "$subcommand" ]; then
>>                  __gitcomp "$subcommands"
>>                  return
>>          fi
>>
>>          case "$subcommand,$cur" in
>> -       init,--*)
>> -               __gitcomp "--cone"
>> -               ;;
>> -       set,--*)
>> -               __gitcomp "--stdin"
>> +               *,--*)
>> +                       __gitcomp_builtin sparse-checkout_$subcommand "" "--"
>>                  ;;
>> -       *)
>> +               set,*|add,*)
>> +                       if [ $(__git config core.sparseCheckoutCone) ]; then
>> +                               __git_complete_index_file "--directory"
>> +                       fi
> 
> --directory only affects how untracked files are presented in `git
> ls-files` (which _git_complete_index_file uses), and you're not asking
> for untracked paths at all here.  So you've got a useless flag.
> 
> Testing this commit out, I can verify that it completes on all tracked
> paths in the index.  Perhaps that was an intended intermediate step,
> but if so the commit message needs to be changed since it claims this
> commit is doing something else.
> 
> There's also a problem in that `git sparse-checkout --cone path<TAB>`
> is not using this codepath.  If the user specifies --cone, then we
> should give them cone-mode-style completion the same as if they
> already have the config setting set.  Or, we at least need to mention
> in the commit message that we don't yet correctly check for the
> `--cone` option to get the right style of completion and are leaving
> it for future work.

> 
Thank you for your feedback, it is very helpful. As I've been thinking
about this, it feels like this commit should perhaps be dropped in favor
of the __gitcomp_directories commit (with some modifications per [1]). I
know you initially said to add the __gitcomp_directories commit in
addition to what I had, though, so I wanted to confirm whether removing
this is the right course of action.

[1]: 
https://lore.kernel.org/git/CABPp-BEq9pTqsy_R_SR1DSgUK58ubNR1Gk4G1RoL8wkadyo6zw@mail.gmail.com/
