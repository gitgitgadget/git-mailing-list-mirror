Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE2C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 13:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjAYNrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYNrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 08:47:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA51414239
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 05:47:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qx13so47681294ejb.13
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oajbjhUc4rSApnNid70+frIZV9s5lX9woF5j78k2910=;
        b=qXUtSRl5i/IfGl6h9X8erd8hEAF/fDw8qiEplscoOd4101WXMLZ7GeY9v7ZWPPCW2k
         IuhAEgMpyIuMHpNkIFba1W3rNFXl7AR+b/wvykDXQVbiAM0hHnLca9k8AYBCxpsbihTm
         TpPDtrFNM1f+W/KstQ8JFyEDm88DOvDbF0VZbh5cakiPIiV7Daz3Lt+sh/UKlsdh2UGD
         JbluvU4+uELLMkjw0z/kHSqjBwl8S/Q3O8FW3k1xkHWYXu7Dp0qXG6rqCJ+xmiy9zjPO
         HiEpH5eTVNYL6Dqj5IswEyj+TjSQ30yhtcjD4zh3C8zNoceWChi4K/EYR6L9gTnm+pM8
         bTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oajbjhUc4rSApnNid70+frIZV9s5lX9woF5j78k2910=;
        b=auWiDB5eFAOD5zZx0lPa9S8qBPBStWIMdVBMXxkqQSrGNc2mEftELpvKVQWqLHjh8S
         njBbuAPwIdOClABTkkVb7FhLMAV3tpFMKOkR7VTyoIg0I/QVAHRsyjQ+7kpAWLOy3a8d
         x3b8HC+DmC8PiiRTGiuw8WG0xPWZ5TUrOqc/LX3xZbRL7kRAti3uw0aOPdWZ35FVSrXP
         hS5fVNEXz+YXyYK4XMP6BRMOt1teOiFRl3vK6Pa9suxK0jQz8nmpR5VVBRNPf48kUB9j
         gnBYzM3r0hoOBTKbTvBvkYaGzkHLP92FHiVYcCFRjjJlqoBdLaK0kpmJ4rfMIXNMgZW6
         qW7w==
X-Gm-Message-State: AFqh2kqNQ3h7iWuoqMk7Dshg8IYPYApqHV9h6KoCDE5Dzgjb7+a9I0f2
        jR95Ie13K+DwikLuLUuJr/zJqA==
X-Google-Smtp-Source: AMrXdXt+XcIKhYODZRXfYcv1i1Ujkxi/2IU/WCXMfRJFeC8hnw3yY1tIc68Z82VT79oO4li9g3PC2A==
X-Received: by 2002:a17:906:c7cc:b0:7ae:bfec:74c7 with SMTP id dc12-20020a170906c7cc00b007aebfec74c7mr33196788ejb.72.1674654428202;
        Wed, 25 Jan 2023 05:47:08 -0800 (PST)
Received: from [10.45.33.55] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709064ec700b007c08439161dsm2369667ejv.50.2023.01.25.05.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:47:07 -0800 (PST)
Message-ID: <569043fb-9766-037e-c587-1545c2978e7d@unity3d.com>
Date:   Wed, 25 Jan 2023 14:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <7ccf7b17-4448-5ef4-63b1-9073a400e486@github.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <7ccf7b17-4448-5ef4-63b1-9073a400e486@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/01/2023 21.11, Victoria Dye wrote:
> William Sprent via GitGitGadget wrote:
>> From: William Sprent <williams@unity3d.com>
>>
>> There is currently no way to ask git the question "which files would be
>> part of a sparse checkout of commit X with sparse checkout patterns Y".
>> One use-case would be that tooling may want know whether sparse checkouts
>> of two commits contain the same content even if the full trees differ.
>> Another interesting use-case would be for tooling to use in conjunction
>> with 'git update-index --index-info'.
> 
> These types of use cases align nicely with "Behavior A" as described in
> 'Documentation/technical/sparse-checkout.txt' [1]. I think adding a
> '--scope=(sparse|all)' option to 'ls-trees' would be a good way to make
> progress on the goals of that design document as well as serve the needs
> described above.
> 
> [1] https://lore.kernel.org/git/pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com/
> >>
>> 'rev-list --objects --filter=sparse:oid' comes close, but as rev-list is
>> concerned with objects rather than directory trees, it leaves files out
>> when the same blob occurs in at two different paths.
>>
>> It is possible to ask git about the sparse status of files currently in
>> the index with 'ls-files -t'. However, this does not work well when the
>> caller is interested in another commit, intererested in sparsity
>> patterns that aren't currently in '.git/info/sparse-checkout', or when
>> working in with bare repo.
> 
> I'm a bit confused by your described use cases here, though. Right now,
> 'sparse-checkout' is a local repo-only optimization (for performance and/or
> scoping user workspaces), but you seem to be implying a need for
> "sparse-checkout patterns" as a general-purpose data format (like a config
> file or 'rebase-todo') that can be used to manually configure command
> behavior.
> 
> If that is what you're getting at, it seems like a pretty substantial
> expansion to the scope of what we consider "sparse checkout". That's not to
> say it isn't a good idea - I can definitely imagine tooling where this type
> of functionality is useful - just that it warrants careful consideration so
> we don't over-complicate the typical sparse-checkout user experience.
> 

I guess it is sort of what I'm getting at. I want to enable tooling (in 
particular) to be able to interrogate git about sparse checkouts without 
having to checkout a commit and load a set of patterns. There's already 
a deterministic relationship between a (commit * sparse checkout 
patterns) and a list of included files, so I think it makes sense to be 
able to ask git about it.

I agree with your concerns about not over complicating things for the 
average user. I think the cone/non-cone distinctions are already a bit 
hard to grasp (at least it was for me). FWIW, it isn't my intention that 
an average user should use the "explicitly pass patterns to ls-tree" 
functionality. But of course we should still get it right.


>>
>> To fill this gap, add a new argument to ls-tree '--sparse-filter-oid'
>> which takes the object id of a blob containing sparse checkout patterns
>> that filters the output of 'ls-tree'. When filtering with given sparsity
>> patterns, 'ls-tree' only outputs blobs and commit objects that
>> match the given patterns.
> 
> I don't think a blob OID is the best way to specify an arbitrary pattern set
> in this case. OIDs will only be created for blobs that are tracked in Git;
> it's possible that your project tracks potential sparse-checkout patterns in
> Git, but it seems overly restrictive. You could instead specify the file
> with a path on-disk (like the '--file' options in various commands, e.g.
> 'git commit'); if you did need to get that file from the object store, you
> could first get its contents with 'git cat-file'.
> 

I'm fine with changing it to be a file. I picked it to align with

  'git rev-list --filter=sparse:<blob-oid>'

which I think is the only other place in the code base where you can 
query about arbitrary filters. But I agree, it is a bit awkward to use.

>>
>> While it may be valid in some situations to output a tree object -- e.g.
>> when a cone pattern matches all blobs recursively contained in a tree --
>> it is less unclear what should be output if a sparse pattern matches
>> parts of a tree.
>>
>> To allow for reusing the pattern matching logic found in
>> 'path_in_sparse_checkout_1()' in 'dir.c' with arbitrary patterns,
>> extract the pattern matching part of the function into its own new
>> function 'recursively_match_path_with_sparse_patterns()'.
>>
>> Signed-off-by: William Sprent <williams@unity3d.com>
>> ---
>>      ls-tree: add --sparse-filter-oid argument
>>      
>>      I'm resubmitting this change as rebased on top of 'master', as it
>>      conflicted with the topic 'ls-tree.c: clean-up works' 1
>>      [https://public-inbox.org/git/20230112091135.20050-1-tenglong.tl@alibaba-inc.com],
>>      which was merged to 'master' recently.
>>      
>>      This versions also incorporates changes based on the comments made in 2
>>      [https://public-inbox.org/git/CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com/].
>>      
>>      I'm also looping in contributors that have touched ls-tree and/or
>>      sparse-checkouts recently. I hope that's okay.
> 
> Definitely okay, thanks for CC-ing!
> 
> Overall, this is an interesting extension to 'sparse-checkout', and opens up
> some opportunities for expanded tooling. However, at an implementation
> level, I think it's addressing two separate needs ("constrain 'ls-files' to
> display files matching patterns" and "specify sparse patterns not in
> '.git/info/sparse-checkout'") in one option, which makes for a somewhat
> confusing and inflexible user experience. What about instead breaking this
> into two options:
> 
> * --scope=(sparse|all): limits the scope of the files output by ("Behavior
>    A" vs. "Behavior B" from the document linked earlier).
> * --sparse-patterns=<file>: specifies "override" patterns to use instead of
>    those in '.git/info/sparse-checkout' (whether 'sparse-checkout' is enabled
>    for the repository or not).
> 

That makes sense to me. I'll look into making those changes.

> I haven't looked at your implementation in detail yet, but I did want to
> offer a recommendation in case you hadn't considered it: if you want to
> allow the use of patterns from a user-specified specific file, it would be
> nice to do it in a way that fully replaces the "default" sparse-checkout
> settings at the lowest level (i.e., override the values of
> 'core_apply_sparse_checkout', 'core_sparse_checkout_cone', and
> 'get_sparse_checkout_filename()'). Doing it that way would both make it
> easier for other commands to add a '--sparse-patterns' option, and avoid the
> separate code path ('path_in_sparse_checkout_1()' vs.
> 'recursively_match_path_with_sparse_patterns()', for example) when dealing
> with '.git/info/sparse-checkout' patterns vs. manually-specified patterns.
> 

Thanks for the pointers. I'll see what I can do. Do you mean something 
along the line of the following?

    set_sparse_checkout_file(filename);
    init_sparse_checkout_patterns(istate);
    _ = path_in_sparse_checkout_1(some_path, istate, ...);


I do I think I like the explicitness of first loading the pattern_list 
and then passing it to the matching function, though. But maybe it is 
too cumbersome.

>>      
>>      William
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1459%2Fwilliams-unity%2Fls-tree-sparse-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1459/williams-unity/ls-tree-sparse-v2
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1459
> 

