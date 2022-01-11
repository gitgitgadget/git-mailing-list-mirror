Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517CC433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 17:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiAKRTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbiAKRSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 12:18:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE1C034007
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:17:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so7055507pji.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 09:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KoXDOZIiNDXsjv/avs9aeC1nGTBJiKP47nNS2+DWt+Y=;
        b=lMr0zOY2oQfNjOQ0Yexk+c0FPH+OO2OckVRI27hUBKoPqL+bH5ra5AzmI8rxMZY59A
         9J5iTBflDRqPjAb0t/si9GeqHLya2qsZ+B4GV29RQDpOULf3hUCSvYoxwZk7CPaz3pKl
         CJk5gal3Tion7IN0k6AVudYJsARkCcmLIiRNRUeXmoIrWdGT6blkF/dCJ/laMfJdOzXT
         9Ywm3uiAHAmKUSMZaECYJVhV1SiaI/2drDNcZI97gSdYrXW/fwDImQ0wXrvQFJ/gjNSp
         UY34lvyqbEt4j709ZK/PyPliSV8fPidM44Sz4uw+fw8dn0Ka3zqsyShghL2CGKZkhcNC
         BDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KoXDOZIiNDXsjv/avs9aeC1nGTBJiKP47nNS2+DWt+Y=;
        b=FiE3Eqal5IeL4ssHwnCGpfUrFQe//4IV5Qnos0hCXhfG0MPfUlqOtXqH2GK79QD79R
         haYw+BgzSB7rxakMrzk5DKNpeRUUS8JGrWPv3BZYsnypV4Bpx6hu0zqMpnPmDXIPiQ9+
         uiORSCalln0NpdGcWxGil6d3lgsbgzVTaXmYVtcRGUqaz5v8OfxBtmKgO2Ll5LJ3lF33
         AhZnprWuqL6yhGkbVzDUfiYq4kXeH8nvQHJKWCJ5qRH/7PrygIA2E1Vh3XosnXrNXMjA
         ClGuNVaS8fIg23HYuNOJ4tg5SMnVONTS/zjV9sikJSVCnL5OmDwKvnw0RH1h4A0jIzZt
         owtw==
X-Gm-Message-State: AOAM5301nVkOppy6oJtZSmtXylMKmcQ2cWpH7LVdZ3qG6TapMZbm2Zwq
        VBqrUEj+bapltGxE2mcXW94=
X-Google-Smtp-Source: ABdhPJzu1sanMDrzYMZpg5m3EzyZ+v9wJH5WODiUx4/UEY3pluEEnMhSJW1KsKoXd5MKxJmO3oCECA==
X-Received: by 2002:a63:9b0a:: with SMTP id r10mr4848650pgd.405.1641921460037;
        Tue, 11 Jan 2022 09:17:40 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:b8d6:f480:77a5:ee68? ([2601:602:9e81:12c0:b8d6:f480:77a5:ee68])
        by smtp.gmail.com with ESMTPSA id t21sm4554534pfg.176.2022.01.11.09.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 09:17:39 -0800 (PST)
Message-ID: <92913af3-7985-0789-eee0-c84601d2a31f@gmail.com>
Date:   Tue, 11 Jan 2022 09:17:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/3] sparse checkout: custom bash completion updates
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/10/22 2:38 PM, Elijah Newren wrote:
> On Mon, Jan 10, 2022 at 10:59 AM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This series is based on en/sparse-checkout-set. It updates custom tab
>> completion for the sparse-checkout command. Specifically, it corrects the
>> following issues with the current method:
>>
>>   1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>>      (it is missing reapply and add).
>>   2. git sparse-checkout --<TAB> does not complete the help option.
>>   3. Options for subcommands are not tab-completable.
>>   4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>>      both file names and directory names.
>>
>> The first commit in this series is a set of failing tests that highlight
>> each of the above issues. The next commit updates the _git_sparse_checkout
>> method in git-completion.bash to enable each of these tests to pass. The
>> final commit modifies the original implementation (which recursively printed
>> prospective directories for completion) to only print directories at the
>> current level for improved performance.
>>
>>
>> Changes since V2
>> ================
>>
>>   * Change use of $prev to $subcommand in _git_sparse_checkout() method in
>>     git-completion.bash.
>>   * State explicitly that directory completion applies in both cone and
>>     non-cone mode in 'sparse-checkout: custom tab completion' commit
>>   * Add new patch with __gitcomp_directories method to improve performance by
>>     only outputting directories at the current level.
>>
>>
>> Changes since V1
>> ================
>>
>>   * Rebase onto en/sparse-checkout-set.
>>   * Add subcommand options (including --no-cone) for set and reapply.
>>   * Extend 'sparse-checkout completes subcommand options' test to validate
>>     new set/reapply subcommand options.
>>   * No longer set index.sparse to false in 'sparse-checkout completes
>>     directory names' test.
>>
>> Thanks, Lessley
>>
>> Lessley Dennington (3):
>>    sparse-checkout: custom tab completion tests
>>    sparse-checkout: custom tab completion
>>    sparse-checkout: limit tab completion to a single level
>>
>>   contrib/completion/git-completion.bash | 68 +++++++++++++++----
>>   t/t9902-completion.sh                  | 94 ++++++++++++++++++++++++++
>>   2 files changed, 150 insertions(+), 12 deletions(-)
>>
>>
>> base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v3
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1108
>>
>> Range-diff vs v2:
>>
>>   1:  955fcab0052 = 1:  bbc2d21e1d1 sparse-checkout: custom tab completion tests
>>   2:  cecf501e076 ! 2:  256e5f034c6 sparse-checkout: custom tab completion
>>       @@ Commit message
>>            2. The --help option is tab-completable.
>>            3. Subcommand options are tab-completable.
>>            4. A list of directories (but not files) is provided when users enter git
>>       -    sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>>       +    sparse-checkout add <TAB> or git sparse-checkout set <TAB>. It is
>>       +    important to note that this will apply for both cone mode and non-cone
>>       +    mode (even though non-cone mode matches on patterns rather than
>>       +    directories).
> 
> I would instead phrase this as "(even though non-cone mode can match
> general gitignore patterns rather than just directories)".
> 
> The basic idea behind the rewording is that I want to highlight that
> the completions we provide are still valid in non-cone mode, they just
> aren't comprehensive.  Since there's no way to provide a comprehensive
> list of possible patterns for non-cone mode, I think what we are
> choosing to provide is a pretty reasonable choice.
> 
Thank you! That is much better wording. Will update in v4 along with any
feedback I get on your function (see below).
>>
>>            Failing tests that were added in the previous commit to verify these
>>            scenarios are now passing with these updates.
>>       @@ contrib/completion/git-completion.bash: _git_show_branch ()
>>        -         ;;
>>        - *)
>>        -         ;;
>>       -+ case "$prev" in
>>       ++ case "$subcommand" in
>>        +         set)
>>        +                 __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
>>        +                 __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>>   -:  ----------- > 3:  aa9ea67180d sparse-checkout: limit tab completion to a single level
> 
> Other than that one nit, patches 1-2 (and the testcases in patch 3) are:
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>
> 
> Since I wrote the new __gitcomp() function in patch 3, it might be
> nice if we can find another reviewer for it. Especially since I've
> only lightly touched the completion code and there might be better
> ways of achieving what I wrote there.
I agree - I'll chat with some folks today to try to find the best person
to take a look.
