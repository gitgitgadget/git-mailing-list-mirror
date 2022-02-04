Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 00:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356214AbiBDAhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 19:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiBDAhj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 19:37:39 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C02C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 16:37:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id e28so3668945pfj.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AL9z8F0GVeoERP3tywaah8DRVFLTwpGeFhv1nOduEmE=;
        b=UeYTRc5Ew8bRZFngdtT7N8GNthR3ZkHQ+2t7Q1m8O1LFL2QZFaDqj/6jOWq5jXZnOu
         pof4R4I3zQTC5D7eQ+rwP+6LODrrwmkIskzx1cRKRORnSjOPEPsh9yZuRFI5IiM3bTrw
         JClGiW32hOK5FKEM5whV5BygB4qo2l3x4wSDVQaX5BX6FJS9bWlb1/hEgnwjs0eDlmZe
         Ot5SRl2sxHE5DIpg64u2cn4WRkniHTTL1dY4gkAe39bSo6gT51IyNwBB+u3htnaJamFJ
         uyBpkHLEQPzAYFBN7oxG20jjiJzQfDGJZSwt2quUp0Y9h1uoKz+JxutDrPVD/7NCsFSD
         F3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AL9z8F0GVeoERP3tywaah8DRVFLTwpGeFhv1nOduEmE=;
        b=mDPtKuTUOTJpP7WYTj9oUu8z9XvPn32yGUauOYjIXEe4kUy80JU+/zN2r3khCI/cp2
         Ej7DTwkniBNHE0oXPonsyQZOg+czPA4gMcyUV8ipdoS1IRkSlaqNFDdnKP1eO70PNy4e
         hMPfZJ894Ls6cIk4oqCqrrjTLpTZ7uvchJyEULMoEGpNum5k4WL0mkO3mMTii9CFhS1V
         GRq9YD5plhGNTnP5tDmc9MHRCq98OTb7cTAjpXOixos2C2HT1zOq7/mYZoOdVFvdr+RI
         0XrpwRm6skosJEKCblR7x3dqTgkZ1D5nwKnZP3S5ZMSoLANJQQvFRHo/izJlhd/0YKta
         KTSg==
X-Gm-Message-State: AOAM531b5wjspd00UfTEFGfu5JdsOjdC5FKR1YmmS7ZEiDyKN1Y8aE99
        oLhfz89sy6Mche6HdRUk7Gc=
X-Google-Smtp-Source: ABdhPJw3g3yJpfcxO+V09G5gXdcP2YAjXFhSLZC0o5nuogmmGgJ4P+sos+PImZdEviOmvajk8asx0g==
X-Received: by 2002:a05:6a00:170d:: with SMTP id h13mr662414pfc.39.1643935058076;
        Thu, 03 Feb 2022 16:37:38 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id d8sm10957730pjz.32.2022.02.03.16.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 16:37:37 -0800 (PST)
Message-ID: <d7e0898f-6a4f-3688-2c55-8da412531edc@gmail.com>
Date:   Thu, 3 Feb 2022 16:37:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 3/3] completion: handle unusual characters for
 sparse-checkout
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
 <CABPp-BFD51BTsG7gQFD4BuqVLLBV2iJOKnrnya89otoGonzVvA@mail.gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <CABPp-BFD51BTsG7gQFD4BuqVLLBV2iJOKnrnya89otoGonzVvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 3:58 PM, Elijah Newren wrote:
> On Thu, Feb 3, 2022 at 12:44 PM Lessley Dennington via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Lessley Dennington <lessleydennington@gmail.com>
>>
>> Update the __gitcomp_directories method to de-quote and handle unusual
>> characters in directory names. Although this initially involved an attempt
>> to re-use the logic in __git_index_files, this method removed
>> subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
>> logic was placed directly in the __gitcomp_directories method.
>>
>> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
>> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
>> ---
>>   contrib/completion/git-completion.bash | 50 +++++++++++++-------------
>>   t/t9902-completion.sh                  | 28 +++++++++++++++
>>   2 files changed, 52 insertions(+), 26 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c5c8df6b6e5..c47e9ce09b2 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2988,32 +2988,30 @@ _git_show_branch ()
>>
>>   __gitcomp_directories ()
>>   {
>> -     local _tmp_dir _tmp_completions
>> -
>> -     # Get the directory of the current token; this differs from dirname
>> -     # in that it keeps up to the final trailing slash.  If no slash found
>> -     # that's fine too.
>> -     [[ "$cur" =~ .*/ ]]
>> -     _tmp_dir=$BASH_REMATCH
>> -
>> -     # Find possible directory completions, adding trailing '/' characters
>> -     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
>> -         sed -e s%$%/%)"
>> -
>> -     if [[ -n "$_tmp_completions" ]]; then
>> -         # There were some directory completions, so find ones that
>> -         # start with "$cur", the current token, and put those in COMPREPLY
>> -         local i=0 c IFS=$' \t\n'
>> -         for c in $_tmp_completions; do
>> -             if [[ $c == "$cur"* ]]; then
>> -                 COMPREPLY+=("$c")
>> -             fi
>> -         done
>> -     elif [[ "$cur" =~ /$ ]]; then
>> -         # No possible further completions any deeper, so assume we're at
>> -         # a leaf directory and just consider it complete
>> -         __gitcomp_direct_append "$cur "
>> -     fi
>> +       local _tmp_dir _tmp_completions _found=0
>> +
>> +       # Get the directory of the current token; this differs from dirname
>> +       # in that it keeps up to the final trailing slash.  If no slash found
>> +       # that's fine too.
>> +       [[ "$cur" =~ .*/ ]]
>> +       _tmp_dir=$BASH_REMATCH
>> +
>> +       # Find possible directory completions, adding trailing '/' characters,
>> +       # de-quoting, and handling unusual characters.
>> +       while IFS= read -r -d $'\0' c ; do
>> +               # If there are directory completions, find ones that start
>> +               # with "$cur", the current token, and put those in COMPREPLY
>> +               if [[ $c == "$cur"* ]]; then
>> +                       COMPREPLY+=("$c/")
>> +                       _found=1
>> +               fi
>> +       done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
>> +
>> +       if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
>> +               # No possible further completions any deeper, so assume we're at
>> +               # a leaf directory and just consider it complete
>> +               __gitcomp_direct_append "$cur "
>> +       fi
> 
> The indentation changes are distracting and make the patch harder to
> review.  Could you either remove those, or apply the indentation
> changes to patch 2 so that it starts with the right indentation?

I've also corrected this as part of the fix I'm about to submit.
> 
> I'm slightly surprised that __gitcomp_direct_append handles the
> quoting for us, but the testcases below seem to cover it, so that's
> cool.
>
> Anyway, looks pretty clever to me; I was worried this was going to
> require a much bigger change.
> 
>>   }
>>
>>   _git_sparse_checkout ()
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index b38a7302249..7f63d6057be 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1508,6 +1508,34 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
>>          )
>>   '
>>
>> +# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes in paths
>> +test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with special characters' '
>> +       # reset sparse-checkout
>> +       git -C sparse-checkout sparse-checkout disable &&
>> +       (
>> +               cd sparse-checkout &&
>> +               mkdir "directory with spaces" &&
>> +               mkdir "$(printf "directory\twith\ttabs")" &&
>> +               mkdir "directory\with\backslashes" &&
>> +               mkdir "directory-with-áccent" &&
>> +               >"directory with spaces/randomfile" &&
>> +               >"$(printf "directory\twith\ttabs")/randomfile" &&
>> +               >"directory\with\backslashes/randomfile" &&
>> +               >"directory-with-áccent/randomfile" &&
>> +               git add . &&
>> +               git commit -m "Add directories containing unusual characters" &&
>> +               git sparse-checkout set --cone "directory with spaces" \
>> +                       "$(printf "directory\twith\ttabs")" "directory\with\backslashes" \
>> +                       "directory-with-áccent" &&
>> +               test_completion "git sparse-checkout add dir" <<-\EOF
>> +               directory with spaces/
>> +               directory       with    tabs/
>> +               directory\with\backslashes/
>> +               directory-with-áccent/
>> +               EOF
>> +       )
>> +'
> 
> I'm glad you tested with lots of special characters -- spaces, tabs,
> backslashes, and accents.  Newlines might also be nice, but probably
> makes the test hard.  Anyway, looks good to me, other than the
> indentation change.
> 
>> +
>>   test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
>>          # reset sparse-checkout repo to non-cone mode
>>          git -C sparse-checkout sparse-checkout disable &&
>> --
>> gitgitgadget
