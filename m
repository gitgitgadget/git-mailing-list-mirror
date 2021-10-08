Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7F2C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB4A60FA0
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhJHRQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHRQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:16:13 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92044C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 10:14:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t63so5389857qkf.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 10:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XCYdMFGVeFWNCBDQZa/WySp0bCrSeSrNYCXGfeN3BpQ=;
        b=Bl6UD+2gcSCphmOTHOc2BiSTTJNSYogAe5uGdLe8Xx6Q66iEoEtB7q9qbJc4oRIJue
         RG/3xGLF4+Y5ZbwPHjGd/lb6jkJtQ1MM06pH2qPTrnW+m2PsbIKALz9agDTnMOnyUKUz
         5ferXhW4G/DS/N4r/nQrpzf4afDO4pXp25pXhlZnEO5s/jJ5GrsOeTxo+SgtNSrrewog
         IvvK3nSPvIPBnkYbIo79brqN8EkwEZyCTyajS6hj/BBa+INN+tTi2O96CIF7zdGoLtvy
         NBQgC/LMae8FBdGAJ7RuGoSugr85Y5xRz8dMzLxJA9fn0AnpfoxzoE/VMroCid9eisQe
         Swyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XCYdMFGVeFWNCBDQZa/WySp0bCrSeSrNYCXGfeN3BpQ=;
        b=geYMDWo8XUC0nc2v+o3sjOAcPCxQSZBKMH2Ep/EGBbhMSDWk3ucBxm36JedyoSUCaG
         gA5C45UTl2PiI/g4nVr12MGB7rVvMMfAC07mnQhrj5ZfubeY1Pax3vdTWy/ttVSxlVM+
         JFqR38JxLYy1ELzb9izVkX361siO7pwVRg7XEgaJdHkyOsaXCcQpLf50F8FW9V9Hw7v/
         KHW9yaALPgHEswfgZHWWg6Rc84tAtzgnmKvdbiXZwokBF2po9AD2Gv4nWVyFOYx71ojx
         KCLMK2VLKN7YCm1lljcLqSkDvYc4avCfcqdvBizz7z3ng8ARiRk5aiSZCY1C0LFEK0NB
         OO0w==
X-Gm-Message-State: AOAM531PAIIJHi7fC08mEQSBSK7pyIat9mNS39UVvxKOyELsWh2At30U
        ySyl9ey4eRXgboPWSo79qgos
X-Google-Smtp-Source: ABdhPJytnUaEeqChuhSIKRjCYjTA3Rlun0dd4CUdf7FN7j8horiU3ON7qx94bwf9+xw5K9xYow54nQ==
X-Received: by 2002:a37:434a:: with SMTP id q71mr4089214qka.222.1633713256200;
        Fri, 08 Oct 2021 10:14:16 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id j23sm2551632qtr.23.2021.10.08.10.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 10:14:15 -0700 (PDT)
Message-ID: <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
Date:   Fri, 8 Oct 2021 13:14:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     phillip.wood@dunelm.org.uk,
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
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> Hi Victoria
> 
> On 07/10/2021 22:15, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Remove `ensure_full_index` guard on `prime_cache_tree` and update
>> `prime_cache_tree_rec` to correctly reconstruct sparse directory entries in
>> the cache tree. While processing a tree's entries, `prime_cache_tree_rec`
>> must determine whether a directory entry is sparse or not by searching for
>> it in the index (*without* expanding the index). If a matching sparse
>> directory index entry is found, no subtrees are added to the cache tree
>> entry and the entry count is set to 1 (representing the sparse directory
>> itself). Otherwise, the tree is assumed to not be sparse and its subtrees
>> are recursively added to the cache tree.
> 
> I was looking at the callers to prime_cache_tree() this morning and would like to suggest an alternative approach - just delete prime_cache_tree() and all of its callers! As far as I can see it is only ever called after a successful call to unpack_trees() and since 52fca2184d ("unpack-trees: populate cache-tree on successful merge", 2015-07-28) unpack_trees() updates the cache tree for the caller. All the call sites are pretty obvious apart from the one in t/help/test-fast-rebase.c where unpack_trees() is called by merge_switch_to_result()
> 

It looks like `prime_cache_tree` can be removed mostly without issue, but
it causes the two last tests in `t4058-diff-duplicates.sh` to fail. Those
tests document failure cases when dealing with duplicate tree entries [1],
and it looks like `prime_cache_tree` was creating the appearance of a
fully-reset index but was still leaving it in a state where subsequent
operations could fail.

I'm inclined to say the solution here would be to update the tests to
document the "new" failure behavior and proceed with removing
`prime_cache_tree`, because:

* the test using `git reset --hard` disables `GIT_TEST_CHECK_CACHE_TREE`,
  indicating that `prime_cache_tree` already wasn't behaving correctly
* attempting to fix the overarching issues with duplicate tree entries will
  substantially delay this patch series
* a duplicate entry fix is largely unrelated to the intended scope of the
  series

Another option would be to leave `prime_cache_tree` as it is, but with it
being apparently useless outside of mostly-broken use cases in `t4058`, it
seems like a waste to keep it around.

[1] ac14de13b2 (t4058: explore duplicate tree entry handling in a bit more detail, 2020-12-11)
