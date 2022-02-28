Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837BC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiB1Sd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 13:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiB1ScF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 13:32:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3CF11AD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:15:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b8so11850382pjb.4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xvhMGYPq3Z4YETVnK5DjOGvo5m/No5Mmm0eI3qsH1uU=;
        b=Ky5FA7heAM+hNw0TyHORQdhRo0DT11h2Jz5ne5biZ5yVF1GQbGAfI8YJlN9vQn6Z9+
         NjnQPQ2mAqooH1fFJ5JZ0O/HPH1/4gwkxAhHiLWxGAODfNVud6Z7a5QJx4cz3iuZqi/7
         244z6ymYetK8Rym+zRxk8LBmNslDVkXNTh5z2VInMYwW155O03iJvmKYWnHeith8wpkq
         Zq54nRHIRP6s+ymbBDG3gNRRT0imhcpFDBgjUYKPavMhzyBQE0VeZmFBGCdN+VOq0I/H
         oIdOvGSKg1qbuF5VEiBQDQ3lMoa7N5vJDHAqLNdDKIRdKZ607skFEjABR3Wm3mGqARhe
         4iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xvhMGYPq3Z4YETVnK5DjOGvo5m/No5Mmm0eI3qsH1uU=;
        b=CILzDFBXe4Ks2RPbNVbiZUcRQQL/0X6e0SoGIkdAH99yaaiU6JbtBqt9P1wFGCPCAU
         ZXGelDqTlsWsh/5kWxJNQGI6DVWk3Ooyvvdp5UN8B49zbc7lnYBSCtMIJgbxg3hHUOhi
         yJmY/w6W5xo8nH4TnGD/1RtOq9shtowAEkxrjlhgXt0zQhHOm2RMEkR1H+Ucakq+fRxk
         I4ciW3xDcU/I3olC8YxoDZd142/0cxfi9FdZBNZjE2FSUPApOTHxJki6ADaKXm9DB+uD
         cQ7TTBeWT6TWNpuRikNAbRLoPxlxGF9IK+DQt+av8nNJFuQRhcTjwoDIBKgTZNP5LEP2
         SmIw==
X-Gm-Message-State: AOAM531EpyGVKF+t1L7eJxzxZilVZuh4OZDXBEYqjDXGVoS44pm2IosU
        NoHgOmOD+gibrpeA75sLHkp9
X-Google-Smtp-Source: ABdhPJyuEuMriMZ4AFDCoZlwtK5vzWsrinJsmZqh4V8ZBpbWm8jIgmYx1AwpLa4iyZmblReDz87nmQ==
X-Received: by 2002:a17:90a:2f41:b0:1bc:46ce:6364 with SMTP id s59-20020a17090a2f4100b001bc46ce6364mr17768034pjd.159.1646072095235;
        Mon, 28 Feb 2022 10:14:55 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm14308727pfl.148.2022.02.28.10.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:14:54 -0800 (PST)
Message-ID: <472bdb5f-4bf2-4d62-3dd5-bb6ba4f4162a@github.com>
Date:   Mon, 28 Feb 2022 10:14:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
 <CABPp-BF4jtEzyUBEymhFJxaGOMRaUs-XyBdr89Fs7E_ehnwWMg@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BF4jtEzyUBEymhFJxaGOMRaUs-XyBdr89Fs7E_ehnwWMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
>> emphasis is placed on interactions with files outside the sparse cone, e.g.
>> merges with out-of-cone conflicts.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  t/perf/p2000-sparse-operations.sh        |  1 +
>>  t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>
>> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
>> index 2a7106b9495..382716cfca9 100755
>> --- a/t/perf/p2000-sparse-operations.sh
>> +++ b/t/perf/p2000-sparse-operations.sh
>> @@ -117,6 +117,7 @@ test_perf_on_all git diff
>>  test_perf_on_all git diff --cached
>>  test_perf_on_all git blame $SPARSE_CONE/a
>>  test_perf_on_all git blame $SPARSE_CONE/f3/a
>> +test_perf_on_all git read-tree -mu HEAD
>>  test_perf_on_all git checkout-index -f --all
>>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index b1dcaa0e642..9d58da4e925 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
>>         test_cmp expect sparse-checkout-out
>>  '
>>
>> +test_expect_success 'read-tree --merge with files outside sparse definition' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout -b test-branch update-folder1 &&
>> +       for MERGE_TREES in "base HEAD update-folder2" \
>> +                          "update-folder1 update-folder2" \
>> +                          "update-folder2"
>> +       do
>> +               # Clean up and remove on-disk files
>> +               test_all_match git reset --hard HEAD &&
>> +               test_sparse_match git sparse-checkout reapply &&
>> +
>> +               # Although the index matches, without --no-sparse-checkout, outside-of-
>> +               # definition files will not exist on disk for sparse checkouts
>> +               test_all_match git read-tree -mu $MERGE_TREES &&
>> +               test_all_match git status --porcelain=v2 &&
>> +               test_path_is_missing sparse-checkout/folder2 &&
>> +               test_path_is_missing sparse-index/folder2 &&
>> +
>> +               test_all_match git read-tree --reset -u HEAD &&
>> +               test_all_match git status --porcelain=v2 &&
>> +
>> +               test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
>> +               test_all_match git status --porcelain=v2 &&
>> +               test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
>> +               test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
>> +       done
>> +'
>> +
>> +test_expect_success 'read-tree --merge with edit/edit conflicts in sparse directories' '
>> +       init_repos &&
>> +
>> +       # Merge of multiple changes to same directory (but not same files) should
>> +       # succeed
>> +       test_all_match git read-tree -mu base rename-base update-folder1 &&
>> +       test_all_match git status --porcelain=v2 &&
>> +
>> +       test_all_match git reset --hard &&
>> +
>> +       test_all_match git read-tree -mu rename-base update-folder2 &&
>> +       test_all_match git status --porcelain=v2 &&
>> +
>> +       test_all_match git reset --hard &&
>> +
>> +       test_all_match test_must_fail git read-tree -mu base update-folder1 rename-out-to-in &&
>> +       test_all_match test_must_fail git read-tree -mu rename-out-to-in update-folder1
>> +'
>> +
>> +test_expect_success 'read-tree --prefix outside sparse definition' '
>> +       init_repos &&
>> +
>> +       # Cannot read-tree --prefix with a single argument when files exist within
>> +       # prefix
> 
> Given the comments in the cover letter about --prefix needing special
> work, it's not clear to me whether the below is expected behavior or
> current-but-buggy behavior that you are testing and documenting.
> Could you clarify?
> 

It's expected - per 'Documentation/git-read-tree.txt':

	The command will refuse to overwrite entries that already
	existed in the original index file.

I'll update the comment to make that clearer. Thanks!

>> +       test_all_match test_must_fail git read-tree --prefix=folder1/ -u update-folder1 &&
>> +
>> +       test_all_match git read-tree --prefix=folder2/0 -u rename-base &&
>> +       test_path_is_missing sparse-checkout/folder2 &&
>> +       test_path_is_missing sparse-index/folder2 &&
>> +
>> +       test_all_match git read-tree --reset -u HEAD &&
>> +       test_all_match git read-tree --prefix=folder2/0 -u --no-sparse-checkout rename-base &&
>> +       test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
>> +       test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
>> +'
>> +
>> +test_expect_success 'read-tree --merge with directory-file conflicts' '
>> +       init_repos &&
>> +
>> +       test_all_match git checkout -b test-branch rename-base &&
>> +
>> +       # Although the index matches, without --no-sparse-checkout, outside-of-
>> +       # definition files will not exist on disk for sparse checkouts
>> +       test_sparse_match git read-tree -mu rename-out-to-out &&
>> +       test_sparse_match git status --porcelain=v2 &&
>> +       test_path_is_missing sparse-checkout/folder2 &&
>> +       test_path_is_missing sparse-index/folder2 &&
>> +
>> +       test_sparse_match git read-tree --reset -u HEAD &&
>> +       test_sparse_match git status --porcelain=v2 &&
>> +
>> +       test_sparse_match git read-tree -mu --no-sparse-checkout rename-out-to-out &&
>> +       test_sparse_match git status --porcelain=v2 &&
>> +       test_cmp sparse-checkout/folder2/0/1 sparse-index/folder2/0/1
>> +'
>> +
>>  test_expect_success 'merge, cherry-pick, and rebase' '
>>         init_repos &&
>>
>> --
>> gitgitgadget
>>

