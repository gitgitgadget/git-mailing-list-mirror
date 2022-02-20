Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2EC433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiBTUtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:49:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBTUs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:48:59 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D98DEA2
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:48:37 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q5so8922378oij.6
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e0S0zGow4bvPjnwkHEqHFpyhD4UJ2jl/YEvAV8w04sw=;
        b=jNujAZRNENXhNPvTBlkfByqzU23gyUWvP5RErCr3b2pCKBOy4cPzchHeU2pYyf0aCZ
         /4f47L9qtYWZoQFKM3k0mEVOTRfz8wSYT+nMaUQHf15Pxm73A1yH/gsC1+IPnl8bEK5U
         o53fuRd7FRAHdg2RYOcGRJwckOXjByH0f3cNilkJrY5o/OP/xWFk9FRfPkhH9sDqyPeG
         GmnVuJO2HnSw5EbO7IBA1zovM6xoPFXh+2sfZdp9vvFIe6kXHHnNl75l/oRrVlDT5rPZ
         vwt0eAeOTtVcZVqxZoJHHHYI1/CuWS43fHyv99PpTzovNCW180dJKEeCAVnA80Y6jGxm
         Revg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e0S0zGow4bvPjnwkHEqHFpyhD4UJ2jl/YEvAV8w04sw=;
        b=BUh8y8nBEWO3ylj0+B1q4G0FdyYJ8uuVaIe2eTm+ZgsJnuf6m9oZ8vHbjnaCjf+MDq
         HI8uThKEelVPF6YBaGSnYRl8e60ISLrsHRWEhEhqwbMWR2HcUhOdaBA4XJkvp5Tku4ye
         QKwQ1gjUhYbKc94HVFqy/9aNtQBT7OS2BosljwZcuqfBVqEBBv+q+YPfCqIOa0G/IEl5
         hxoOXLaLkmHqs1UlV7UyGnaQxOHbIwoFTBduTFKYzvI4d0Q0PX5mol2LXB7gUxyOnzCc
         qh+s7Qf9t6Az5SAMTQ/kARCKoxL1zI4wUlqmGKaQodtklSOOuhVaOaStWLm2XPBm5bE9
         3lqQ==
X-Gm-Message-State: AOAM5336grl5ksbKCXsjf5R8UJufjUJG4d0HPfDtjKvnBujegEPpqLwv
        vJPQdCrsf7Wi2coRLMyTW4Js
X-Google-Smtp-Source: ABdhPJx6/OH+ox3aFEQtXdvwWnVMvuNYfvOOrGRfI0AzwasSGJ9DtofV1aBFIAU1S2ETqH7gkPqYYQ==
X-Received: by 2002:a05:6808:10cb:b0:2d5:f40:8665 with SMTP id s11-20020a05680810cb00b002d50f408665mr993656ois.140.1645390117184;
        Sun, 20 Feb 2022 12:48:37 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l40sm4716710otv.12.2022.02.20.12.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 12:48:36 -0800 (PST)
Message-ID: <fcaac95c-013a-f82b-f359-b9b58dc7d2a9@github.com>
Date:   Sun, 20 Feb 2022 15:48:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <avila.jn@gmail.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
 <xmqq7d9puv6l.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d9puv6l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2022 3:42 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> It is helpful to distinguish between a 'working tree' and a 'worktree'.
>> A worktree contains a working tree plus additional metadata. This
>> metadata includes per-worktree refs and worktree-specific config.
>>
>> This is the first of multiple changes to git-worktree.txt, restricted to
>> the DESCRIPTION section.
> 
> Looked almost perfect, except for one and a half iffy parts.
> 
>> -If a working tree is deleted without using `git worktree remove`, then
>> ...
>> +If a worktree is deleted without using `git worktree remove`, then
>>  its associated administrative files, which reside in the repository
>>  (see "DETAILS" below), will eventually be removed automatically (see
> 
> I think this one should be "working tree".  The administrative files
> are integral part of a worktree, but from the point of view of a
> working tree, it is "associated" with it and not part of it.  If you
> delete without using "git worktree remove", that would be done with
> a command like "rm -f", which removes the working tree but not the
> worktree.

Good point. I agree. There is some similar discussion in the COMMANDS
section around moving/renaming/repairing worktrees, so likely similar
thoughts apply there, too.
 
>> -If a linked working tree is stored on a portable device or network share
>> -which is not always mounted, you can prevent its administrative files from
>> -being pruned by issuing the `git worktree lock` command, optionally
>> -specifying `--reason` to explain why the working tree is locked.
>> +If a linked worktree is stored on a portable device or network share which
>> +is not always mounted, you can prevent its administrative files from being
>> +pruned by issuing the `git worktree lock` command, optionally specifying
>> +`--reason` to explain why the worktree is locked.
> 
> This one, because what is on a removal device is the working tree
> half of a worktree that leaves the "administrative files" half still
> on the mothership when it is removed, I think it is OK to call it a
> working tree, but because we defined "a linked worktree" and removed
> the definition of "a linked working tree" earlier, the original as-is
> won't work well.
> 
> "If the working tree portion of a linked worktree is stored on ..."
> may be more correct, but it is a bit mouthful.  I dunno (hence this
> is not even a full "iffy" part, just halfway iffy).

I think the wordy way you say it here is the most correct way.

Another way to approach this is to start at the definition by saying
"We will refer to the location of a worktree to be its associated
working directory, even though its metadata is stored in another
location."

That could allow us to use "worktree" even in these cases, but does
create some overloading of the word.

>>  add <path> [<commit-ish>]::
>>  
>> -Create `<path>` and checkout `<commit-ish>` into it. The new working directory
>> -is linked to the current repository, sharing everything except working
>> -directory specific files such as `HEAD`, `index`, etc. As a convenience,
>> -`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
>> +Create `<path>` and checkout `<commit-ish>` into it. The new worktree
>> +is linked to the current repository, sharing everything except per-worktree
>> +files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
>> +be a bare "`-`", which is synonymous with `@{-1}`.
> 
> The original has the problem, too, but it is unclear what is created
> at <path> by reading only the first sentence, even though the
> mention of "The new worktree" that immediately follows strongly
> hints that we are creating a worktree.
> 
>     Create a new worktree at <path> and ...
> 
> perhaps?  This clarification is not even part of one and a half ;-)

This is a good change.

Thanks,
-Stolee
