Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB6C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhKVTre (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhKVTrc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 14:47:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85704C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:44:25 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r26so39930528oiw.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 11:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YPW9OZZO9cjga4CKBRbhY9aiPtvphSZJgjLthy2EXtI=;
        b=GvcImJ6nHgKjcXVtuoliYmFqHFMTq8UUOwdsU1MUfml6SVBg9JvIa+Bfi5zKIckBvt
         rdpdUVyKVrOYEt+UyYHTr2lrDZC2kbm7L3gi0Uu8b3BFaTugOY6cvV+ir7K+KV066iHR
         /sIF4BqAVDT+T9VqgLsuPnpFGYwyttW9Sv1+w1MJep76ZS0k3/Q00DNzqDlzWNMUUKhF
         4mgtKqAoDlnBAnVDzjbm43S8SOSXU3kYMVh5Bllu5OVIs/0aGkjcTUK2Eh879/nTUz6k
         OIizLPDcjgysBr4bvrTcLQtWyYAZopTqWehy6biQZvNub/VyjeikMDsXrqJf+cebRY1/
         x3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YPW9OZZO9cjga4CKBRbhY9aiPtvphSZJgjLthy2EXtI=;
        b=7qgYrTkqUpsr5tCqcVsHbIIzItkeaFMczgk63bFCOalopduWN8RI09q5Lrq2lVcBHY
         Y3joDuC7YztNBb12bASTiUfiUXggWgIMJwpBzR8kXyUss43GuOHDNNvs/wf8h1IT0Lh3
         6kvC52fZUTqhFQ4hjLti7+gGfByk9rTKHpLP24oF7YLK4D7UAt58nzL+XeG7+D6CfGAB
         m14A9yQq1y+bRtTiCE3iDLn3YQ0mVJjnv29Pj8PK1vseqEkamIwnmf944zVfYkdYoUfB
         SHAsH5kSD6EkzbqTaa9dZc/bYU1fK1YY6K8e0+fXX2Z3GXF+KO7ON3RMnHbh5bwoXP5O
         D4rQ==
X-Gm-Message-State: AOAM532QH9tpAVFb+KFIj3wc6wGVhaCaBQxX4mHWxv/ufj7X6i818HjG
        mB8a2eZjMJzsY7Jos4K3zOs=
X-Google-Smtp-Source: ABdhPJy43OcNNPsMkq7TxXJNmccTjjKAAwUCkqmK7/VcFrGne0Y9DkVMRPmTfPEQ7heddIu76VV+Sg==
X-Received: by 2002:a05:6808:23c3:: with SMTP id bq3mr24279357oib.124.1637610264595;
        Mon, 22 Nov 2021 11:44:24 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:2589:dd13:53fe:46f9? ([2600:1700:e72:80a0:2589:dd13:53fe:46f9])
        by smtp.gmail.com with ESMTPSA id b1sm1774785otj.5.2021.11.22.11.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 11:44:24 -0800 (PST)
Message-ID: <191b2db8-1be4-d6a4-1cf6-eaefaf373dd2@gmail.com>
Date:   Mon, 22 Nov 2021 14:44:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/22/2021 1:36 PM, Elijah Newren wrote:
> On Tue, Nov 16, 2021 at 7:38 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Existing callers to 'git ls-files' are expecting file names, not
>> directories. It is best to expand a sparse index to show all of the
>> contained files in this case.
>>
>> However, expert users may want to inspect the contents of the index
>> itself including which directories are sparse. Add a --sparse option to
>> allow users to request this information.
>>
>> During testing, I noticed that options such as --modified did not affect
>> the output when the files in question were outside the sparse-checkout
>> definition. Tests are added to document this preexisting behavior and
>> how it remains unchanged with the sparse index and the --sparse option.
> 
> Sure, 'git diff' and 'git status' don't show anything for such files
> either; we're being consistent.  However, this feels like it's
> normalizing an erroneous condition, possibly starting to cement one of
> the bigger UI problems we have the sparse-checkout (and sparse-index):
> 
> I assert that: Having tracked files be SKIP_WORKTREE despite having a
> file present in the working directory is typically an *error*, and one
> that we need to help users prevent/discover/recover-from.

I do think we need to tread carefully here, since some users use
'git update-index --skip-worktree' to mark a file in their
worktree as "ignored" so they can change it from HEAD without it
ever being staged. This is usually independent of the sparse-
checkout feature, so you might want to focus your efforts to paths
that exist in the worktree but are outside of the sparse-checkout
patterns.

> * I've seen users get into this condition by doing the equivalent of
> either 'git sparse-checkout disable' or 'git sparse-checkout set
> $NEW_PATHS' and then hit Ctrl-C in the middle of its operation.
> * Users also just occasionally copy files from other places (maybe
> even `git show REVISION:FILE >FILE`), and potentially edit.
> 
> In either of the above cases:
> * There is no command provided for discovering these files; not diff,
> status, ls-files, or anything
> * There is no command provided for correcting the problem; not clean,
> not reset, or anything.  They have to do it by hand
> * There are ample opportunities for the error to propagate and grow,
> due to the fact that these files will not be reported or updated.[1]
> 
> [1] For example, the user may first either switch to another branch or
> resets to some other commit.  Neither of those operations update these
> erroneous present-despite-SKIP_WORKTREE files.  And there will still
> be nothing that reports them.  But now the files are out-of-date with
> respect to the new commit.  Now if the user disables or changes the
> sparse checkout, they suddenly have several "changed" files in their
> working tree -- which they didn't touch.  In the best case, they run
> diff or status or something and notice the files and then correct it,
> and just get perplexed at where the changes came from.  But with
> enough users, some percentage of them are just going to commit (some
> of) those changes.  When someone else asks why they modified those
> files, they'll (correctly, as it turns out) claim they never did and
> that no program on their system did.  They might even think those
> files weren't part of the commit and claim that git modified the
> commit behind their back, which would be wrong, but there won't be any
> reasonable logs to check to prove what happened.
> 
> 
> I know this issue is out of scope for your series here, but the
> addition of testcases that purposely set up an erroneous condition
> makes it feel like we're trying to normalize that situation and not
> treat it like an error, and are perhap undercutting future attempts to
> try to fix it.  I'd rather have it explicitly stated that we're
> setting up an erroneous condition in our tests, in order to make sure
> we handle it as best as we can so far -- in a manner in line with diff
> and grep -- but also note that later solutions to this deeper issue
> may affect one or more of these commands.

I appreciate the attention to this scenario, but I also think
that a patch series whose goal is to change how we react when
in this case already needs to make a case for changing the
behavior. Having tests that exist documenting the previous
behavior form a good basis for "it did this before, but now it
will do this," which hopefully further justifies the change.

Personally, I think of _every_ test as "this is what the code
does right now" and the purpose of a test is to show that we
don't change things _unintentionally_. Every test can be changed
if there is sufficient evidence that it should.

>> @@ -838,6 +844,7 @@ test_expect_success 'sparse-index is not expanded' '
>>         init_repos &&
>>
>>         ensure_not_expanded status &&
>> +       ensure_not_expanded ls-files --sparse &&
> 
> Do we also want a
>     ensure_not_expanded ls-files &&
> ?  We don't expect ls-files to write a new index file in any scenario, right?

When the index is sparse, 'git ls-files' will expand before
listing all of the contents, to avoid listing a sparse
directory entry. One way to avoid ensure_full_index() would
be to do trickery with read_tree_at() whenever we find a
sparse directory entry and use the callback to output what
ls-files would have written. However, that's pretty much the
same amount of work as what ensure_full_index() is doing, so
there is likely little benefit to complicating the code for
this reason.

>>         ensure_not_expanded commit --allow-empty -m empty &&
>>         echo >>sparse-index/a &&
>>         ensure_not_expanded commit -a -m a &&
>> @@ -942,6 +949,46 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
>>         ensure_not_expanded pull full base
>>  '
>>
>> +test_expect_success 'ls-files' '
>> +       init_repos &&
>> +
>> +       # Behavior agrees by default. Sparse index is expanded.
>> +       test_all_match git ls-files &&
>> +
>> +       # With --sparse, the sparse index data changes behavior.
>> +       git -C sparse-index ls-files --sparse >sparse-index-out &&
>> +       grep "^folder1/\$" sparse-index-out &&
>> +       grep "^folder2/\$" sparse-index-out &&
>> +
>> +       # With --sparse and no sparse index, nothing changes.
>> +       git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
>> +       grep "^folder1/0/0/0\$" sparse-checkout-out &&
>> +       ! grep "/\$" sparse-checkout-out &&
> 
> I'd be tempted to split the test up to this point from the rest of the test.

Every instance of "init_repos" adds to the cost of this test script,
so when possible I'd err on the side of grouping them. It also keeps
test able to isolate with "--run=1,<N>".

>> +
>> +       write_script edit-content <<-\EOF &&
>> +       mkdir folder1 &&
>> +       echo content >>folder1/a
>> +       EOF
>> +       run_on_sparse ../edit-content &&
> 
> As above, since folder1/a is a tracked file, I'd rather we explicitly
> called out that we're intentionally setting up an erroneous condition.
> 
>> +
>> +       # ls-files does not notice modified files whose
>> +       # cache entries are marked SKIP_WORKTREE.
> 
> ...nor does diff, status, etc., as per my lengthy comment from the
> beginning of the email.

I think the existence of this comment points out that "this is
such a strange situation that it requires explanation." A slight
comment change such as

	# In this strange situation where a tracked file
	# exists in the worktree but is marked with the
	# SKIP_WORKTREE bit in the index, Git ignores the
	# worktree contents.

That both points out that this case is unusual, but also that
ls-files isn't the only command that does this.
> Other than my concerns about careful messages with erroneous
> conditions (and the minor question about also having a
> ensure_not_expanded without the --sparse flag), the patch looks good
> to me.
 
Thanks for your careful read!
-Stolee
