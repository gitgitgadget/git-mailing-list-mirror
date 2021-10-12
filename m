Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56069C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3319060231
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbhJLKTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJLKTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 06:19:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4D9C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:17:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so65355973wra.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H9lYvQsYKohXZaRp3+4MGzeWJIx7cUASTPFFRhMcZMs=;
        b=pkMh0muIcdc3LuJ3URH9JhC/g8HKNJauOAct+SK7+M5of9A5KtAJBoclNr6oujkUzY
         hHEi2rUvUWrHQmcwiUgZITMKllnVMrHRYVUBjAJ2CchrwJSAArVpX3xraeTuvXJfSA8S
         ZDioYjw4YL1Fa4e1SKPiEmsShPE+wUHotZ0lC1OW66XramTIRapPxmiZukVxsZQSLDlZ
         ANzhvx6kc+oNlEOu7wwrew0oYXq4CzXRJ5jBEc7hOQQl84J+MLg0Z4rq0mjAyZD69I5y
         9ZkLJSIbrMx5+pAs9eiTz7c+CKgJ0qkjSJ25ePyjZJLQYeat5psmMSt9AKlwPK+ufGLZ
         /kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H9lYvQsYKohXZaRp3+4MGzeWJIx7cUASTPFFRhMcZMs=;
        b=vlMHAHffpOXIy/asjG4UD2AwQqhM4nWsx3gSYN1sXfA/wEu8nfxffNf/4BdhHTmSnc
         jYHnbsz6+NeWdgC3+6z3SzIvRrkmx93wzyRAXixYtrQXKjaM7HKcp46r9xO7BlLbL4AM
         2a/oCnYkh01KmbNNMrI9l0ahHiywo4mGdxxLUIbeqO55eHTLZtIdSNnBBOollbKxs13L
         2gc9xKBKx01hcrrXFu9f4qCA8klUo4NpufO1HlAA5qID+xKHVZGmk1MEdYAr3GC1t/0c
         fwya25RwOLhuTzNFsCvUbzK1UFbCIvyPsFn5ZSp2L7sdkpjDQ2XKeyfwHy3RBKfweH2A
         OKhw==
X-Gm-Message-State: AOAM533xHsRmsKcd5mBYigLh9qXXhq4hKmLmFQ/I0hnC+pQfozkM3UG5
        dhb7yQ4ENVqiWDz79LQqX9g=
X-Google-Smtp-Source: ABdhPJytoVXzV8EI/nN6D9R9QAY0rV8jR6OCEaiV7OmMXphfVwqHMlYy8oodeqrbq8M0uMVao8csQg==
X-Received: by 2002:adf:bb08:: with SMTP id r8mr31590931wrg.222.1634033852766;
        Tue, 12 Oct 2021 03:17:32 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id a81sm2384257wmd.30.2021.10.12.03.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 03:17:32 -0700 (PDT)
Message-ID: <600e5da3-6b30-4ce6-d8d2-984199d2aa35@gmail.com>
Date:   Tue, 12 Oct 2021 11:17:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
 <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
 <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/2021 18:14, Victoria Dye wrote:
> Phillip Wood wrote:
>> Hi Victoria
>>
>> On 07/10/2021 22:15, Victoria Dye via GitGitGadget wrote:
>>> From: Victoria Dye <vdye@github.com>
>>>
>>> Remove `ensure_full_index` guard on `prime_cache_tree` and update
>>> `prime_cache_tree_rec` to correctly reconstruct sparse directory entries in
>>> the cache tree. While processing a tree's entries, `prime_cache_tree_rec`
>>> must determine whether a directory entry is sparse or not by searching for
>>> it in the index (*without* expanding the index). If a matching sparse
>>> directory index entry is found, no subtrees are added to the cache tree
>>> entry and the entry count is set to 1 (representing the sparse directory
>>> itself). Otherwise, the tree is assumed to not be sparse and its subtrees
>>> are recursively added to the cache tree.
>>
>> I was looking at the callers to prime_cache_tree() this morning and would like to suggest an alternative approach - just delete prime_cache_tree() and all of its callers! As far as I can see it is only ever called after a successful call to unpack_trees() and since 52fca2184d ("unpack-trees: populate cache-tree on successful merge", 2015-07-28) unpack_trees() updates the cache tree for the caller. All the call sites are pretty obvious apart from the one in t/help/test-fast-rebase.c where unpack_trees() is called by merge_switch_to_result()
>>
> 
> It looks like `prime_cache_tree` can be removed mostly without issue, but
> it causes the two last tests in `t4058-diff-duplicates.sh` to fail. Those
> tests document failure cases when dealing with duplicate tree entries [1],
> and it looks like `prime_cache_tree` was creating the appearance of a
> fully-reset index but was still leaving it in a state where subsequent
> operations could fail.
> 
> I'm inclined to say the solution here would be to update the tests to
> document the "new" failure behavior and proceed with removing
> `prime_cache_tree`, because:
> 
> * the test using `git reset --hard` disables `GIT_TEST_CHECK_CACHE_TREE`,
>    indicating that `prime_cache_tree` already wasn't behaving correctly
> * attempting to fix the overarching issues with duplicate tree entries will
>    substantially delay this patch series
> * a duplicate entry fix is largely unrelated to the intended scope of the
>    series

That sounds like a good way forward

Best Wishes

Phillip

> Another option would be to leave `prime_cache_tree` as it is, but with it
> being apparently useless outside of mostly-broken use cases in `t4058`, it
> seems like a waste to keep it around.
> 
> [1] ac14de13b2 (t4058: explore duplicate tree entry handling in a bit more detail, 2020-12-11)
> 

