Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB7C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355221AbiBNOin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:38:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiBNOim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 09:38:42 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813322F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 06:38:33 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 200so14507527qki.2
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bs6UARb7XEiAcn23BT9YT17S+9ePda1LMVCCjknkzJg=;
        b=LEpS+sw89NmlwQPZwQTDhljNM6ae1drIPyPoocb2iV8mDjs6NMK06LmKKLVAq3iWZQ
         FP9/yYh86uOqytPum1bxsSLPc56dXfvWSD9nyf2Z5rNRXaxae0DANSfPpIC815/2Fbnr
         +sbrFza023YWYfDGjHFlkOaY91ChALt0e5is9S5A1Aiwp2iQ+EjpCDliqpgHV6xO4GfW
         5FjX8qlg92M3jvGJ66HjQjln6iH65N91C8ShpWzb8Zaz+r53hsbW2vdJYx/ISmD9CLnn
         6aobi5awXyOZuX9uhp2xNu1eETfPH8n1UPvMJQpac8BeRCZtSqeYsj1ttvLpirNHLp37
         0KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bs6UARb7XEiAcn23BT9YT17S+9ePda1LMVCCjknkzJg=;
        b=1/gPUyJx5dOkcmogZZ39XmoBYnzlzOvycuKpKr+VvPZATBGqmTzYqEDivw8WUdQLQY
         oYd7URHu4zrfvfs0k6uuH4QaQdw0bCOsYcs3fUowZPd4tCgZIroV92n72cCy+g4covbz
         TZwyMJNW+Rcuk9capyHOeNeXCP0E7nAnjjDEJyvT4cNngg7vUGmiB8z/M8Ip3w6ylBzW
         6N5+gFa5DXMPIB9QycHprXBCioCf/qOkKWAia5BLTdx1dVCJgpomv4NJZ5lzxPsEn2p9
         9js1EDatDzMv1LcUN2DfkT3EmwPRGmicrjQ8sMXlG6b2Bzh5ZbEV3RmxqWWJLNYkW/8O
         WN5g==
X-Gm-Message-State: AOAM531sRimRxIgZ7dI0C17Uo/Rg26nAbLWjJNpFn7W3mBQ44MKiqT0m
        rvZPIZUK7lAVg1bH0MXjp7q8jIU3cuk=
X-Google-Smtp-Source: ABdhPJweF2awdb1da5ojNfGlHiSrZtjUSuKmSL4bJEF+tM5TQOACG7jrTNGKmIHoW0EZqVdXoGdJbA==
X-Received: by 2002:a05:620a:258e:: with SMTP id x14mr7217769qko.21.1644849512652;
        Mon, 14 Feb 2022 06:38:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id az38sm15865439qkb.124.2022.02.14.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:38:32 -0800 (PST)
Message-ID: <d6286f84-642d-7448-0d2e-dd4c20bdb289@gmail.com>
Date:   Mon, 14 Feb 2022 09:38:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [GSoC] Interest in "More Sparse Index Integrations" project idea
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     vdye@github.com, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
References: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/14/2022 7:44 AM, Shaoxuan Yuan wrote:
> Hi Stolee, Victoria, and Community,
> 
> The self-intro was done during my first practice patch [1].

Welcome!
 
> I've been paying attention to the updates to the SoC 2022 ideas
> page. And find your sparse index integrations project quite interesting.

...

> And the main purpose of this message is to first, show my interest
> about this project idea and second, use it as a thread so I can follow up
> some questions during the research process.
> 
> Question: It is a good idea to start looking into the commands listed
> in the idea doc [3] and make some practice patches about sparse index
> integrations?
> 
> [1] https://lore.kernel.org/git/20220123060318.471414-1-shaoxuan.yuan02@gmail.com/
> [2] https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
> [3] https://git.github.io/SoC-2022-Ideas/#more-sparse-index-integrations
 
One thing you can do is look at the history of t1092, which is used by
every patch series that performs these integrations.

$ git log -20 --oneline --graph --show-pulls origin/master -- t/t1092-sparse-checkout-compatibility.sh
* 3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
* 3a9a6ac5d9d t1092: replace 'read-cache --table' with 'ls-files --sparse'
* 78087097b8b ls-files: add --sparse option
* 5a4e0547e23 fetch/pull: use the sparse index
*   8d2c37320bd Merge branch 'ld/sparse-diff-blame'
|\  
| * add4c864b60 blame: enable and test the sparse index
| * 51ba65b5c35 diff: enable and test the sparse index
| * 338e2a9acc8 diff: replace --staged with --cached in t1092 tests
| *   ea6ae410bed Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
| |\  
* | \   e1d92882676 Merge branch 'ds/sparse-deep-pattern-checkout-fix'
|\ \ \  
| * | | 8c5de0d2657 unpack-trees: use traverse_path instead of name
| * | | 1b38efc7a03 t1092: add deeper changes during a checkout
* | | |   62329d336f5 Merge branch 'ds/trace2-regions-in-tests'
|\ \ \ \  
| * | | | 8c4cbad6a3a t/t*: remove custom GIT_TRACE2_EVENT_NESTING
| |/ / /  
* | | |   f0850875fd4 Merge branch 'vd/sparse-reset'
|\ \ \ \  
| | |_|/  
| |/| |   
| * | | 4d1cfc1351f reset: make --mixed sparse-aware
| * | | 20ec2d034cd reset: make sparse-aware (except --mixed)
| * | | 291d77eb3e2 reset: expand test coverage for sparse checkouts
| * | | 86609db9dae sparse-index: update command for expand/collapse test
| * | | 71471b2a7c7 reset: preserve skip-worktree bit in mixed reset

But of course, this doesn't show the full history of the work in
each of these branches, so you can do a history walk from each
merge to get a picture of the full series:

$ git log --oneline --graph 3c0e4178277 -6
*   3c0e4178277 Merge branch 'ds/fetch-pull-with-sparse-index'
|\  
| * 408c51f0b4b test-read-cache: remove --table, --expand options
| * c2a29405105 t1091/t3705: remove 'test-tool read-cache --table'
| * 3a9a6ac5d9d t1092: replace 'read-cache --table' with 'ls-files --sparse'
| * 78087097b8b ls-files: add --sparse option
| * 5a4e0547e23 fetch/pull: use the sparse index

$ git log --oneline --graph 8d2c37320bd -8
*   8d2c37320bd Merge branch 'ld/sparse-diff-blame'
|\  
| * add4c864b60 blame: enable and test the sparse index
| * 51ba65b5c35 diff: enable and test the sparse index
| * 338e2a9acc8 diff: replace --staged with --cached in t1092 tests
| * 44c7e62e51e repo-settings: prepare_repo_settings only in git repos
| * 27a443b8208 test-read-cache: set up repo after git directory
| * 0803f9c7cdf commit-graph: return if there is no git directory
| * e5b17bda8b6 git: ensure correct git directory setup with -h

These are just a couple examples of merged work in this area. Be
sure to look at the full commit messages and diffs to get a feel
for the area. Then, playing around with the list of commands in
the project idea document is a good idea.

There is also a series that is currently waiting to merge [4], for
even more examples.

[4] https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/

Thanks,
-Stolee
