Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6239C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbiAEUUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbiAEUUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:20:24 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA5C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:20:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id t8so414807ilf.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kJANipfpGjfOvIl2vmN/VnfzH9RHdfZkQSdbv5OmGT8=;
        b=EUpMnIP5FGn0W9mFgq9qkXgD/RLMMFzdI8pE66gyQEFCxyvKZBmb3UtF1kGMKArL+f
         /ESFD8XFhoHE82tVQ6quRhXDJNnjEASUSQhAj2J/bOSIy974KxRY/Q2vUvzfyH6OZR1c
         BHsdc1PDLGIWTpsgLuTlpc3POiSAIn30zEaFFtUxKKJQbGVjV04pXvt5zSU/tv7U6/7M
         jg+n5rMN01rwk1lQ+P50bOnbQw6XEjpEFldxEpbvh9i9S9wzfjMUi9HiZ8vbtxSrQfss
         ztIQWZ3ryQKIltyxxoNDsW22RkfVEqcWuGxfejXN1qC7Qp9ePdRIfw+rmJKvBu8d5RLH
         d2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kJANipfpGjfOvIl2vmN/VnfzH9RHdfZkQSdbv5OmGT8=;
        b=HDFmGCvo0IP5ay9LWMHl/o4T4vKtXK3qkewL9NU/6+sh+0jtiQfm/JCd00v11d+kN/
         7XAxnyVegokOxNvTM4bGkO25HruymLZt3QKUh3MSmMMEPvDlbMC20WmLHvj1szG6n9Pi
         MDuPGtJHYMWSb+tzlNx9JaB4ulVmemLS1GJmPzJ78fIsKIpX8FEsI5hiP/r61+4q4Jab
         M5IWyW+hleCTgtuOiI8j3qcjZNBKLCp/lwXjE2oUNpE+4TmFdT2AJCF7KKZ73C3PsedV
         bQzmMeY9721EwPsa3YLbWAfrsq52xYMKPUkZloF169Hp9QUKm11hxJTMMldUg3EhB8Sb
         29jA==
X-Gm-Message-State: AOAM530RFnN5MB9qvsed2IU8uLaADSLU9D0NTZ23lW4l8o9Ej3bHTXq4
        OvMwkZDrKUwdpyMQGN95G1VdzrJayFAwslPB
X-Google-Smtp-Source: ABdhPJydW6aht3qqSnCDVtiEIKr83dH0q5eeQPhVKgOkQGZvJfW/j522V/RHZQ1/Lic/drezaGaxaw==
X-Received: by 2002:a05:6e02:1569:: with SMTP id k9mr24859922ilu.290.1641414023359;
        Wed, 05 Jan 2022 12:20:23 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id y8sm5737353ilu.72.2022.01.05.12.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 12:20:22 -0800 (PST)
Message-ID: <8202614a-022f-b71c-cf88-d5a3788cc150@gmail.com>
Date:   Wed, 5 Jan 2022 14:20:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v2 2/2] sparse-checkout: custom tab completion
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <cecf501e07645b7408dc75f276d477b9b712ab17.1640892413.git.gitgitgadget@gmail.com>
 <CABPp-BG_Jgyr89z_D355Ytzz31J40nBGX=2cr+aXtcf3U1y6Dg@mail.gmail.com>
 <676e8408-5ac3-4293-22ee-c43e9bd6916b@gmail.com>
 <CABPp-BFJF7hyr5onMFQNC7r_x+XfJVn9wXhxyMV6Lu+pxbfyPA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BFJF7hyr5onMFQNC7r_x+XfJVn9wXhxyMV6Lu+pxbfyPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/22 2:42 PM, Elijah Newren wrote:
> On Tue, Jan 4, 2022 at 11:41 AM Lessley Dennington
> <lessleydennington@gmail.com> wrote:
>>
>>
>>
>> On 12/31/21 4:52 PM, Elijah Newren wrote:
>>> On Fri, Dec 31, 2021 at 2:33 AM Lessley Dennington via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>>
>>>> From: Lessley Dennington <lessleydennington@gmail.com>
>>>>
>>>> Fix custom tab completion for sparse-checkout command. This will ensure:
>>>>
>>>> 1. The full list of subcommands is provided when users enter git
>>>> sparse-checkout <TAB>.
>>>> 2. The --help option is tab-completable.
>>>> 3. Subcommand options are tab-completable.
>>>> 4. A list of directories (but not files) is provided when users enter git
>>>> sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
>>>>
>>>> Failing tests that were added in the previous commit to verify these
>>>> scenarios are now passing with these updates.
>>>>
>>>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>>>> ---
>>>>    contrib/completion/git-completion.bash | 38 ++++++++++++++++++--------
>>>>    t/t9902-completion.sh                  |  8 +++---
>>>>    2 files changed, 30 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>>>> index c82ccaebcc7..7de997ee64e 100644
>>>> --- a/contrib/completion/git-completion.bash
>>>> +++ b/contrib/completion/git-completion.bash
>>>> @@ -2986,24 +2986,38 @@ _git_show_branch ()
>>>>           __git_complete_revlist
>>>>    }
>>>>
>>>> +__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
>>>> +
>>>>    _git_sparse_checkout ()
>>>>    {
>>>> -       local subcommands="list init set disable"
>>>> +       local subcommands="list init set disable add reapply"
>>>>           local subcommand="$(__git_find_on_cmdline "$subcommands")"
>>>> +
>>>>           if [ -z "$subcommand" ]; then
>>>> -               __gitcomp "$subcommands"
>>>> -               return
>>>> +               case "$cur" in
>>>> +                       --*)
>>>> +                               __gitcomp "--help"
>>>> +                               ;;
>>>> +                       *)
>>>> +                               __gitcomp "$subcommands"
>>>> +                               ;;
>>>> +               esac
>>>>           fi
>>>>
>>>> -       case "$subcommand,$cur" in
>>>> -       init,--*)
>>>> -               __gitcomp "--cone"
>>>> -               ;;
>>>> -       set,--*)
>>>> -               __gitcomp "--stdin"
>>>> -               ;;
>>>> -       *)
>>>> -               ;;
>>>> +       case "$prev" in
>>>
>>> Shouldn't this be "$subcommand" rather than "$prev"?  I think with
>>> prev, it will only correctly complete the first path after "set",
>>> "add", etc.
>>>
>> Good catch, thank you! Fixing in v3.
>>>> +               set)
>>>> +                       __gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
>>>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>>>> +                       ;;
>>>> +               add)
>>>> +                       __gitcomp "--stdin"
>>>> +                       __gitcomp "$(git ls-tree -d -r HEAD --name-only)"
>>>
>>> I was going to make a simple suggestion for making it just complete
>>> one additional level at a time and leaving out the -r, and then tried
>>> it out and found out it wasn't simple.  I got something working,
>>> eventually, but it's slightly ugly...so it probably belongs in a
>>> separate patch anyway.  If you're curious, it's basically replacing
>>> the second __gitcomp... call for each of set and add with
>>> `__gitcomp_directories`, after first defining:
>>>
>>> __gitcomp_directories ()
>>> {
>>>       local _tmp_dir _tmp_completions
>>>
>>>       # Get the directory of the current token; this differs from dirname
>>>       # in that it keeps up to the final trailing slash.  If no slash found
>>>       # that's fine too.
>>>       [[ "$cur" =~ .*/ ]]
>>>       _tmp_dir=$BASH_REMATCH
>>>
>>>       # Find possible directory completions, adding trailing '/' characters
>>>       _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
>>>           sed -e s%$%/%)"
>>>
>>>       if [[ -n "$_tmp_completions" ]]; then
>>>           # There were some directory completions, so find ones that
>>>           # start with "$cur", the current token, and put those in COMPREPLY
>>>           local i=0 c IFS=$' \t\n'
>>>           for c in $_tmp_completions; do
>>>               if [[ $c == "$cur"* ]]; then
>>>                   COMPREPLY+=("$c")
>>>               fi
>>>           done
>>>       elif [[ "$cur" =~ /$ ]]; then
>>>           # No possible further completions any deeper, so assume we're at
>>>           # a leaf directory and just consider it complete
>>>           __gitcomp_direct_append "$cur "
>>>       fi
>>> }
>>>
>>> But I don't think that needs to be part of this series; I can submit
>>> it later and hopefully get a completion expert to point out
>>> better/cleaner ways of what I've done above.
>>>
>> I'm admittedly curious about what made this so difficult. I removed the
>> '-r' and updated my tests to expect only directories at one level, and
>> they passed. But I imagine I'm being too simplistic.
> 
> I've forgotten some details since last Saturday, but I think the
> problem was that doing that would only ever complete toplevel
> directories; after completing those you could keep tabbing to get a
> deeper directory.  First, let's get a comparison point; ignoring
> sparse-checkout, I can do:
> 
>      cd $GIT_CLONE
>      cd cont<TAB>b<TAB><TAB>
> 
> and the ls line will replace those <TAB>s so that I see
> 
>      ls contrib/buildsystems/Generators
> 
> Now, if we just removed the '-r' from your git-completion.bash
> changes, and then typed
> 
>      git sparse-checkout set cont<TAB>b<TAB><TAB>
> 
> Then you'd see
> 
>      git sparse-checkout set contrib
> 
> and see 'bin-wrappers', 'block-sha1', and 'builtin' as potential
> completions, but not as subdirs of contrib but instead sibling dirs to
> contrib.  That completion rule wouldn't let you look within contrib/.
> My more complicated rule had to avoid calling __gitcomp to avoid
> adding spaces so that completions could continue (but should add them
> if we have tabbed all the way down and there are no more
> subdirectories), had to add trailing '/' characters so that we know
> when we have the full directory name to pass along to ls-tree, and
> then had to manually do the work that __gitcomp would manually do with
> making sure to only provide completions relevant to what has been
> typed so far.
Ah, I see. Thank you so much for the thorough explanation. I know you said
this series could go through without that update, but I feel like it
should probably be added. Don't want to start off with the wrong behavior.
