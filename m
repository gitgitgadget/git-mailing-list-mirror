Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEA9C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 02:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245726AbiBUCLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 21:11:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245723AbiBUCLi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 21:11:38 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B641339
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:11:12 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b13so5234332qkj.12
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 18:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nz4Pb4s92H0HRFnEiuDwKqss1obmZWZ+J/LWGsxT0S4=;
        b=fYejoiWugOylrPDvDsBKm9v83ts6LS1qbKUo0pg1OqclEuowtX72UgqA2sFf0u/En6
         HYg3ojYsyEbk8uNZkpAWtVyzK/9rK8C/+cHGgSr4J/WWdu+pn5+VPFVZunmES028Nvy0
         B8oMi7PpLTx9ACalsSrhwGCjn27W0FRheWN0AzU8TF7Qwu2+4DIdjOr9vU6huvfTAPuo
         9KdR1Et/EDI1XfpI0M9H+W1awj+nzgI2q/TX6aYD4vXM3ds9sjbMAckTEHmLGOL3L5e8
         kxlkQiCXvj38S0HsI8AuXrVRjHnGhmyEuS9OIcIztCaG0WzlkJiVC14Bb0WwZ9xLoHRP
         hO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nz4Pb4s92H0HRFnEiuDwKqss1obmZWZ+J/LWGsxT0S4=;
        b=Q62TWjsl7pDqwcKpT5Q3+CeJmneg1GCrM7Xr4taz3JEWUWv6V+z4iOvkCqtXiopcOy
         ux3DiFeR5874tPPa7j+kpoHkU0dAVNaW5Bm5Uv0ZSrX6C6+lgzsI/xICUgCk637r1R5T
         ZOO4F2iAxSX76vZE0wE1Ld+XUn7KtEfCmnnmkDCER/HcZoXvndsdfVlqygPy10HoHJRH
         qsrdqlOcXTqSdo+/O79YVIJoEiyAuqUqjT9ENUVSkZvmQZLC8yeyE3uxsvisLyv68hk0
         3KWRYKAz0gydPymapLBjumOo9dYhM0eDrysseZqh5ad44EgvXAIR6JYdyd0P3Fqc39As
         h+8A==
X-Gm-Message-State: AOAM532QkS1f7VKz4T6IiDvKdxsQ/D4CKinmlo+Q5UtI8EEPxCVXaV2q
        wN3KiYnM28HUKSnx6LAWNGQl
X-Google-Smtp-Source: ABdhPJwy7w8MfWawa2G1ErIa4OaVIDIQURaMfrn/bWWq9VS1XZNCf5xV9X1pYm0RAxM6UtUFdIaEug==
X-Received: by 2002:a05:620a:1091:b0:648:c4a2:1f19 with SMTP id g17-20020a05620a109100b00648c4a21f19mr3965252qkk.205.1645409472007;
        Sun, 20 Feb 2022 18:11:12 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t5sm7244280qkm.59.2022.02.20.18.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Feb 2022 18:11:11 -0800 (PST)
Message-ID: <3aaa0c38-cb14-c50f-92df-e5b4588a4927@github.com>
Date:   Sun, 20 Feb 2022 21:11:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 11/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <91773337675b05b0c0e323211899c64d5b8102e6.1645379667.git.gitgitgadget@gmail.com>
 <YhLCmWlmf+9MbECN@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YhLCmWlmf+9MbECN@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2022 5:37 PM, Taylor Blau wrote:
> On Sun, Feb 20, 2022 at 05:54:27PM +0000, Derrick Stolee via GitGitGadget wrote:
>> @@ -404,14 +404,14 @@ $ git worktree list --verbose
>>  /path/to/linked-worktree              abcd1234 [master]
>>  /path/to/locked-worktree-no-reason    abcd5678 (detached HEAD) locked
>>  /path/to/locked-worktree-with-reason  1234abcd (brancha)
>> -	locked: working tree path is mounted on a portable device
>> +	locked: worktree path is mounted on a portable device
> 
> I thought this might have been an over-zealous find-and-replace, since I
> had assumed that the "locked: working tree path ..." message came from
> Git. But my assumption was wrong, and this is the `<reason>` in `git
> worktree --reason=<reason> <worktree>`.
> 
> So it makes sense to update here along with the rest of these other
> instances.

This is a good catch. It could have easily been over-zealous.

>>  /path/to/prunable-worktree            5678abc1 (detached HEAD)
>>  	prunable: gitdir file points to non-existent location
>>  ------------
>>
>>  Note that the annotation is moved to the next line if the additional
>>  information is available, otherwise it stays on the same line as the
>> -working tree itself.
>> +worktree itself.
>>
>>  Porcelain Format
>>  ~~~~~~~~~~~~~~~~
>> @@ -420,7 +420,7 @@ label and value separated by a single space.  Boolean attributes (like `bare`
>>  and `detached`) are listed as a label only, and are present only
>>  if the value is true.  Some attributes (like `locked`) can be listed as a label
>>  only or with a value depending upon whether a reason is available.  The first
>> -attribute of a working tree is always `worktree`, an empty line indicates the
>> +attribute of a worktree is always `worktree`, an empty line indicates the
>>  end of the record.  For example:
>>
>>  ------------
>> @@ -470,9 +470,9 @@ EXAMPLES
>>  You are in the middle of a refactoring session and your boss comes in and
>>  demands that you fix something immediately. You might typically use
>>  linkgit:git-stash[1] to store your changes away temporarily, however, your
>> -working tree is in such a state of disarray (with new, moved, and removed
>> +worktree is in such a state of disarray (with new, moved, and removed
> 
> This one should probably remain as "working tree", since the example
> being given here is focused on disarray in the working tree itself, not
> in the worktree's metadata.

You're right. Thanks for catching this one.

>>  files, and other bits and pieces strewn around) that you don't want to risk
>> -disturbing any of it. Instead, you create a temporary linked working tree to
>> +disturbing any of it. Instead, you create a temporary linked worktree to
>>  make the emergency fix, remove it when done, and then resume your earlier
>>  refactoring session.
> 
> But this one is in the context of "create a _worktree_", which makes
> sense and should probably be updated as you have done here.

Thanks,
-Stolee
