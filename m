Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D62E92DA
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586694; cv=none; b=aYRRyM6Msimt2OqF9mzav32+3Md6WNgcvSCVYnZP8yQAwTD72nPayCXhmEHhPmGpmDrxrubgsz6kTMXTdxYf/eu0aqkTbJgWOQB0rRKZx7fhgbW3O54KK2Wc5I5V1CscIiZtProQf9R93HYDRPp4p5GFioansyGiBUjxmgfb7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586694; c=relaxed/simple;
	bh=1NtvXrbQB1kp88eg5TChm+Ik1hrWyTahvokLEYsnGbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeSvdzYOSzSXU6BF0DRYlTHi0WgQv9BtQzg3a2OkA3MaPVpJYtZ52F3xrLuYcjQW63kItgMySR4GyqhTEJGWEKkL8tBXJ4JMpH1SyMjh9d6e9Sh65aDIMPLWBvLYZB/VZkSAe99B2A8+tMPkD4DCXHqb+zTpJU3A77pzIH8ZmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keJOpvuh; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keJOpvuh"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7176c66e99cso51127417b3.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752586691; x=1753191491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCDuILPBo8eIeKvRC68uzaYE6ru5mXHabJXAKB967KM=;
        b=keJOpvuh/JliolL+x0vsObbt51QUql0SDqgsrwl53/qA8yIE6bzyuLQoxwXnXe/8jK
         tuCg2DJ4i92EdAlQEWxxQS+0O3VvqdDUr2tcBnG+h55qnUOKFCuFFZ3dTygspw/IpNxg
         N6LnSTV5oCsDdCHzQFOSRM/UMXxpYhEF296fEi7hVQ2uuMikzn4LCdqAu/5/Kfc82XnF
         fClT26E58wFSp6BnSo2RcKbdMgdRBa0+pL7Lq1/JynY3m5Lo6fTRqHEoFEwH/92asTlj
         V99rHaLREwa8q/fHUSCMg87STCZ1LXIvmWsJb+UtfudRrzh87LVmLZzxeX6i3OrdSnXQ
         ZZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752586691; x=1753191491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCDuILPBo8eIeKvRC68uzaYE6ru5mXHabJXAKB967KM=;
        b=VUC6w7zHYCVdK8N6SfLTKYvfRTfxZ4CnVHj+4z7VJ1IX5VhhRD3Ly5vbgjN9Y4yQyq
         514ejgHqbjlBXDkBk/t6+szvyGyEGPndeuy+FiIVBCVzMbM9KRHsxVDK1qedjV6795hQ
         u1V62U8ch908hBN+j0RQ/V7bGI31V5E2dwIrzvfxmMdx3hgnEK7jxnNw5+ryCSJfk+uZ
         S2dOwD9U5gu5LDF6ClksJ+pSYbvofOE+DIb3N+AaLsQoh/n6wP3VxZFYR8cT+8jBLkZv
         zPjJjvDA2ytPZab12vQlhKC6aTHiwhrRBi10l9RoScdFIhoI85F05AzUn37emsaDG2h+
         mqUw==
X-Forwarded-Encrypted: i=1; AJvYcCVYD13UCgQIYs7J4POePVVmFBwHA3fcNKROte1D3Hxl+3T4MQq/7hY/8BZ99jf2INy2o7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/e84Vge74efR6dE7xso/9hkkz4B7pv1JS/OaFce9+MvlXlU44
	R0E81r6R+ppjWQFpQqmvUR1OH0H16dTmPgaRlCKdqAwMWPkJZ039R+SyP2yVSu4i
X-Gm-Gg: ASbGncsCJyBZrpBJl9qT2cQmSU/yLTs8x4Kmme9Br6sJd4HqU/8CO6SyXqgYstmBfTx
	HUD3kZ6HhmvDUXr6y3sLlsus3d82JpALRECZqoJxHPv9cZZ60lsB0nGIcXASU0Qb6cyyTFJeYcY
	BvnPi2MMngKWSYikD7pVLNGX7ro8nsvtaFMYch8oSynxAuzoCRu86LQ57D8jAj0R9eWwizrP4rf
	5GpywZ0YVuUEit7NIlsmXGL/B6FV/14FRCMhnSoSrsp6ElX6TA7qboYKl0ebYlVBGET6caHgYXx
	tbpKHSJ48J5sptf+uZnfJ3kvFBExj6dIAfCuqQAW+JZPWBsB+eAzPzD0wSGzrfNlMr4y3dw4BJG
	WcjUtRRAd519D91kJLpZ8sDjT5ZYM3j1wICq2qLK8OWb4gSNgBhr9wqIKbfOM7ONV3fZnLtw=
X-Google-Smtp-Source: AGHT+IFWWLptWNMJX581hyI2VxQH1HI02xQcFEQXpcM8ATHejWAQtICga+qZQNnwXJrNVqVqPjcHpg==
X-Received: by 2002:a05:690c:6809:b0:712:c55c:4e49 with SMTP id 00721157ae682-717d5e36ab1mr258107447b3.34.1752586690675;
        Tue, 15 Jul 2025 06:38:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:c0f0:d4a:c33c:836b? ([2600:1700:60ba:9810:c0f0:d4a:c33c:836b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717f2fb86c4sm14356107b3.85.2025.07.15.06.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 06:38:10 -0700 (PDT)
Message-ID: <1af54798-12d0-4ff4-978c-254d9d0312b6@gmail.com>
Date: Tue, 15 Jul 2025 09:38:09 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sparse-checkout: add 'clean' command
To: Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <49418e8ec8a4c3e0ce9c65aa700042b6f3f3f4d7.1751973594.git.gitgitgadget@gmail.com>
 <CABPp-BH_JGbtDsne_tKBoqDr9LzL==gs0E5xyPdbqygyXs8+vA@mail.gmail.com>
 <492244b9-2402-4e8e-8599-8bcd5d27e2f8@gmail.com>
 <CABPp-BFO3Mx9LHPxjbdm2ayvfs2gx9nC9vJnW=zuARgCYrQzNQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFO3Mx9LHPxjbdm2ayvfs2gx9nC9vJnW=zuARgCYrQzNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/9/2025 1:35 PM, Elijah Newren wrote:
> On Wed, Jul 9, 2025 at 9:13 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/8/2025 5:43 PM, Elijah Newren wrote:

>>>> +                                                    This subcommand requires cone-mode
>>>> +       sparse-checkout to be sure that we know which directories are
>>>> +       both tracked and all contained paths are not in the sparse-checkout.
>>>> +       This command can be used to be sure the sparse index works
>>>> +       efficiently.
>>>
>>> So...what does it do when in cone mode and the sparse index is not enabled?
>>
>> It doesn't effect the behavior, since we don't care about the on-disk
>> format and instead use an in-memory sparse index to determine which
>> directories to delete.
>>
>> There could be a benefit for users wanting to clean up extra files in
>> their worktree even if they are not using a sparse index. It is less
>> likely that they will discover that they are in that state if they
>> are not pestered by the index expansion advice message.
> 
> Right, for cone mode without the sparse index turned on, this new
> subcommand seems to be a silent no-op (other than burning some
> computation time),

No, it works without the sparse index off. The sparse index config
is about whether or not Git _writes_ the index in the sparse format.

This command works even if the sparse index is not enabled for the
written format, since we can manipulate the in-memory index for the
purpose of discovering which tracked directories should be sparse
and thus not in the worktree.

> despite the fact that the wording in the manual> might lead users to believe it will do some nice tidying for them.
> When the command spends some time working but doesn't do anything and
> doesn't report anything, the user might then think the command is just
> buggy.  I think the command should probably either (a) do some tidying
> for them, or (b) give them a warning that the command has no effect
> when sparse index is not turned on.  Thoughts?
So your concerns here should not be a problem, since the command
_does_ do the expected action even if index.sparse=false.

>>> I'm worried whether this is safe; if someone does a merge or rebase,
>>> there could be tracked-and-modified/conflicted files outside the
>>> sparse specification in the working tree.
>>
>> The conflicted files will not collapse to sparse directory entries.
>>
>> Does that ease your concern on that front?
> 
> Yes, that does ease my concerns...but it doesn't erase them.
> 
> If someone resolves the conflicted merge or rebase and commits (long
> before running this `git sparse-checkout clean` command), what happens
> to those paths?  Do these materialized paths persist in the worktree
> after the commit?  I know they did at some point in our
> implementation, and the current wording of `git sparse-checkout
> reapply` in the manual certainly suggests such paths may stick around
> until the user takes manual action:
> 
>            Reapply the sparsity pattern rules to paths in the working tree.
>            Commands like merge or rebase can materialize paths to do their
>            work (e.g. in order to show you a conflict), and other
>            sparse-checkout commands might fail to sparsify an individual file
>            (e.g. because it has unstaged changes or conflicts). In such cases,
>            it can make sense to run git sparse-checkout reapply later after
>            cleaning up affected paths (e.g. resolving conflicts, undoing or
>            committing changes, etc.).

I have a TODO to add test cases around this behavior, so we can
have concrete expectations. I'll incorporate them into the existing
test cases around merge conflicts.

This may be another example of Git leaving files around that should
be deleted in order to efficiently work with a sparse index.

> Now, if these paths stick around despite being outside the sparsity
> specification, users may decide to modify them.  And if they have
> modified them and run your command, won't you succeed in collapsing to
> a sparse directory tree?  And then wouldn't this cause unstaged
> changes to be discarded?  (I know this is a rare case, because users
> would probably only merge or rebase changes they made while in their
> sparse-checkout, and thus conflicts would generally be limited to the
> sparse-checkout, but there are at least three ways I can think of that
> conflicts could be triggered outside their sparse checkout, so I think
> it's a realistic scenario that we should think through.)
> 
> Throwing away unstaged changes is something that is usually gated
> behind a forcing flag (e.g. `git reset --hard` or `git checkout
> --force`).  I know, we currently also gate removal of untracked files
> in `git clean` behind a `--force` flag as well and I'm not concerned
> with throwing away untracked files with your command without a forcing
> flag, but I'm just wondering if we should be more careful with
> unstaged changes than with untracked files.
> 
> Perhaps everyone is fine with also throwing away unstaged changes as
> part of this command.  I could be convinced of that.  But if so, that
> should at least be called out rather explicitly in the commit message,
> the documentation, and the tests, whereas currently your patch is
> silent on anything other than untracked and ignored files.
> 
> (Or, if my memory is out-of-date about materialized paths persisting
> after their conflicts are resolved and a commit happens, then it'd
> probably be worth calling that out in the commit message and perhaps
> also updating some wording on the reapply subcommand.)

These are good considerations that I'll explore with tests (or point
to existing tests as I investigate). One thing to keep in mind is
that the SKIP_WORKTREE bit does some amount of ignoring the worktree
by not modifying what is there, and that may include some issues
around reporting the changes in 'status' or staging the changes in
'add'.

A lot of your concerns seem like they would be satisfied by providing
a verbose file-by-file output of what would be deleted and potentially
having --dry-run be the default mode.

>>> Even after resolving such a merge and committing, the paths may remain
>>> around until the user does a 'git sparse-checkout reapply' (I don't
>>> remember details here, but our documentation for reapply certainly
>>> says so), and since the file might stick around, the user may make
>>> further modifications to such a file.
>>>
>>> ...or will the convert_to_sparse() call above fail in all these cases?
>>>  If it does, should it give a better and more useful error message
>>> than "failed to convert index to a sparse index" and rather e.g. "path
>>> %s has modifications; please stage or revert first"?
>>
>> It won't fail. It just won't collapse as far.
> 
> Oh!  Based on this hint, I went and looked up the code for this; it's
> from convert_to_sparse_rec(), right?  I see something interesting
> there; does the present-despite-skipped checks (from 82386b44963f
> (Merge branch 'en/present-despite-skipped', 2022-03-09)) cause this
> collapsing to also fail for unstaged entries?  I.e. this part of
> convert_to_sparse_rec():
> 
>                 if (ce_stage(ce) ||
>                     S_ISGITLINK(ce->ce_mode) ||
>                     !(ce->ce_flags & CE_SKIP_WORKTREE))
>                         can_convert = 0;
> 
> The `ce_stage(ce)` part of it is what prevent it from collapsing when
> there are conflicts, and I think the `!(ce->ce_flags &
> CE_SKIP_WORKTREE))` would prevent it from collapsing any tracked files
> whatsoever, whether modified or not, due to the
> present-despite-skipped checks.  Does that sound right?

This matches my expectations.

> In other words, perhaps your clean command as implemented really does
> only handle untracked and ignored files, and if the user also has
> tracked-but-unmodified or tracked-with-unstaged-changes or
> tracked-with-staged-changes then this command won't actually restore
> performance for them until they _also_ run `git sparse-checkout
> reapply` ?

Worth adding testing to be sure, though I believe 'git sparse-checkout
clean' would help if they stage any changes (resolving conflicts, if
any) and commit those results. The files won't get cleaned by 'git
commit' but the clean operation should work after that.

>> You do make a good point that there could be extra help messages to say
>> that there are uncollapsed directories (detectable by seeing a blob path
>> with the skip-worktree bit on, maybe). I will think on this.
> 
> In order to detect this by the skip-worktree bit, you'd probably need
> to run it as part of the present-despite-skipped checks mentioned
> above (or run it before those checks clear the skip-worktree bit for
> present files).

I'll check in on this as I explore more deeply in the code.

Thanks for the careful review of these fine details!
-Stolee

