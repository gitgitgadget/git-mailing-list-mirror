Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE0C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiADTlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiADTli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:41:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D45C061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 11:41:38 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y70so45570396iof.2
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0gZfpQjYjtznnDXy/XbU1Vix56wNjfBQCuYF7jtZ3T0=;
        b=UYm53INjUrpGq2G2ptAvFJDcpbLGDq6noUS6b96+IHlRKh38vlnpqiGjJ+Rvi/TupH
         3Lfdu4bm5LIyFyrIYjuDGKULgjbTkGWWDlIGAXXC5Vc5dBrJknuLN1aISLG7FVBFf55P
         fco/Aw0W1MnJc0P0dw4Eb2JnsfHZdSXaAeUWchZWxcfa6J9RjSh7zt9yIEsWc6w6V1g+
         T01q6jrPzcU5rc+woavQORH0lcmQHk4QNjlpuiAUU9NCiXW/Xye6OVxeyKqbz7LuHK/8
         q1GIRInOQjiXucGm+Ke/Ik0acGfefjJH6W5VnZpdW1GkRiSDTZr1AIlCSJ1Ipkd3F04z
         wlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0gZfpQjYjtznnDXy/XbU1Vix56wNjfBQCuYF7jtZ3T0=;
        b=sj9sLavABNJd0eQhzkdz/fswPLbrNuCo8tRsJUwOjn9SzUHWlTWy2D0NLRohEWMt49
         Kbq6pwY0q3DMN4uJDRwj2WTIVnltOeeTVGIfzn8tFJGfhlzeVUizaU/G/expxSaCtx2q
         8+uAYTEAE3U5QxW1NE3+MIDLESq2tZAQ+8yrhOPnrDaswT8XpenLYPfqFciS8UVoq64v
         498aJNACNFgjM8Y4DIlEQcab0gT1hvE/vKMxEo+AdYrpLO+OYCy4XBZ8Dg8v1QBzfeBz
         qiTHHqB5I/jb49rMv2G+fB7sQdVqcsAoFNqzwK9uCTDtRckVYyNJLJEanI4+IHeS1fY4
         xwPw==
X-Gm-Message-State: AOAM532bbj9aluXhCAAfbddWKp469iJmWpDxldEnizGrhmP8lRAp50FD
        LxISFEjpozX3XF0DnsgWAzqrlBTkk1vtKVXH
X-Google-Smtp-Source: ABdhPJxaxvywv4n2gYt8JgH3eWRfy4RN5a9ilzHxv2Xly/2/94g7cXVsnpTm2XPEyrYdC9w7ER0wqA==
X-Received: by 2002:a05:6602:2ac5:: with SMTP id m5mr23250208iov.156.1641325298023;
        Tue, 04 Jan 2022 11:41:38 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id d11sm23493793ilv.6.2022.01.04.11.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 11:41:37 -0800 (PST)
Message-ID: <676e8408-5ac3-4293-22ee-c43e9bd6916b@gmail.com>
Date:   Tue, 4 Jan 2022 13:41:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/2] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/31/21 4:52 PM, Elijah Newren wrote:
> On Fri, Dec 31, 2021 at 2:33 AM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Fix custom tab completion for sparse-checkout command. This will ensure:
>>
>> 1. The full list of subcommands is provided when users enter git
>> sparse-checkout <TAB>.
>> 2. The --help option is tab-completable.
>> 3. Subcommand options are tab-completable.
>> 4. A list of directories (but not files) is provided when users enter git
>> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>>
>> Failing tests that were added in the previous commit to verify these
>> scenarios are now passing with these updates.
>>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
>>   t/t9902-completion.sh                  |  8 +++---
>>   2 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c82ccaebcc7..7de997ee64e 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2986,24 +2986,38 @@ _git_show_branch ()
>>          __git_complete_revlist
>>   }
>>
>> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
>> +
>>   _git_sparse_checkout ()
>>   {
>> -       local subcommands="list init set disable"
>> +       local subcommands="list init set disable add reapply"
>>          local subcommand="$(__git_find_on_cmdline "$subcommands")"
>> +
>>          if [ -z "$subcommand" ]; then
>> -               __gitcomp "$subcommands"
>> -               return
>> +               case "$cur" in
>> +                       --*)
>> +                               __gitcomp "--help"
>> +                               ;;
>> +                       *)
>> +                               __gitcomp "$subcommands"
>> +                               ;;
>> +               esac
>>          fi
>>
>> -       case "$subcommand,$cur" in
>> -       init,--*)
>> -               __gitcomp "--cone"
>> -               ;;
>> -       set,--*)
>> -               __gitcomp "--stdin"
>> -               ;;
>> -       *)
>> -               ;;
>> +       case "$prev" in
> 
> Shouldn't this be "$subcommand" rather than "$prev"?  I think with
> prev, it will only correctly complete the first path after "set",
> "add", etc.
> 
Good catch, thank you! Fixing in v3.
>> +               set)
>> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>> +                       ;;
>> +               add)
>> +                       __gitcomp "--stdin"
>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
> 
> I was going to make a simple suggestion for making it just complete
> one additional level at a time and leaving out the -r, and then tried
> it out and found out it wasn't simple.  I got something working,
> eventually, but it's slightly ugly...so it probably belongs in a
> separate patch anyway.  If you're curious, it's basically replacing
> the second __gitcomp... call for each of set and add with
> `__gitcomp_directories`, after first defining:
> 
> __gitcomp_directories ()
> {
>      local _tmp_dir _tmp_completions
> 
>      # Get the directory of the current token; this differs from dirname
>      # in that it keeps up to the final trailing slash.  If no slash found
>      # that's fine too.
>      [[ "$cur" =~ .*/ ]]
>      _tmp_dir=$BASH_REMATCH
> 
>      # Find possible directory completions, adding trailing '/' characters
>      _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
>          sed -e s%$%/%)"
> 
>      if [[ -n "$_tmp_completions" ]]; then
>          # There were some directory completions, so find ones that
>          # start with "$cur", the current token, and put those in COMPREPLY
>          local i=0 c IFS=$' \t\n'
>          for c in $_tmp_completions; do
>              if [[ $c == "$cur"* ]]; then
>                  COMPREPLY+=("$c")
>              fi
>          done
>      elif [[ "$cur" =~ /$ ]]; then
>          # No possible further completions any deeper, so assume we're at
>          # a leaf directory and just consider it complete
>          __gitcomp_direct_append "$cur "
>      fi
> }
> 
> But I don't think that needs to be part of this series; I can submit
> it later and hopefully get a completion expert to point out
> better/cleaner ways of what I've done above.
> 
I'm admittedly curious about what made this so difficult. I removed the 
'-r' and updated my tests to expect only directories at one level, and
they passed. But I imagine I'm being too simplistic.
>> +                       ;;
>> +               init|reapply)
>> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts"
>> +                       ;;
>> +               *)
>> +                       ;;
>>          esac
>>   }
>>
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 51d0f2d93a1..4dc93ee0595 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1447,7 +1447,7 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>>          EOF
>>   '
>>
>> -test_expect_failure 'sparse-checkout completes subcommands' '
>> +test_expect_success 'sparse-checkout completes subcommands' '
>>          test_completion "git sparse-checkout " <<-\EOF
>>          list Z
>>          init Z
>> @@ -1458,13 +1458,13 @@ test_expect_failure 'sparse-checkout completes subcommands' '
>>          EOF
>>   '
>>
>> -test_expect_failure 'sparse-checkout completes options' '
>> +test_expect_success 'sparse-checkout completes options' '
>>          test_completion "git sparse-checkout --" <<-\EOF
>>          --help Z
>>          EOF
>>   '
>>
>> -test_expect_failure 'sparse-checkout completes subcommand options' '
>> +test_expect_success 'sparse-checkout completes subcommand options' '
>>          test_completion "git sparse-checkout init --" <<-\EOF &&
>>          --cone Z
>>          --no-cone Z
>> @@ -1492,7 +1492,7 @@ test_expect_failure 'sparse-checkout completes subcommand options' '
>>          EOF
>>   '
>>
>> -test_expect_failure 'sparse-checkout completes directory names' '
>> +test_expect_success 'sparse-checkout completes directory names' '
>>          # set up sparse-checkout repo
>>          git init sparse-checkout &&
>>          (
>> --
>> gitgitgadget
> 
> Patch looks good to me, other than the $prev vs. $subcommand thing.

Thanks!
