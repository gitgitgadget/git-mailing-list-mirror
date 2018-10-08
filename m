Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3935E1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJHV53 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 17:57:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36084 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHV53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 17:57:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id a85-v6so12208416qkg.3
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=gGVoj6ey8rHI7kKnTJk2tfw/+H2d/S5wD2pK0F1qy7w=;
        b=kfSZ5WATen2gWnhDRlMhCvGP6bVC3Y5iqTiAU+u+LIxOdxXeszM8sZ6l8rliJwmYou
         YsKfYnmX3E8lClG2HXKrwTIs8r9CqXmBO3rrYuKj3O1+QqnAt9yneL04nvwFdAnSyhMZ
         93Zj2eyWymko7E4yla3tbBiMnbpPO2qNltJqiwOAegHW5Rh2RrEX9p4NcissnOGLB2bx
         GsI6cwf4ABBZAa59zt49lsapVZVyEF6F2hboigTzx0htMplkomE1ro5iw4X4US70+0hH
         s6MflKap40GIjE5n3Eg7mED8GTOkncXZhPDwstK65YEQ3MD2nASHodr7zPb/PPIk8an9
         iLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gGVoj6ey8rHI7kKnTJk2tfw/+H2d/S5wD2pK0F1qy7w=;
        b=bpp1MLql/fCrVR4PdjonyuVuoCGwUaoPe0QzwetQ6QTQ2l7wh5bAzWoQ57r5JiIBc4
         bwsyoD6fZ08Vfdk29g7aOy0DvxZmIKW9vAb7o4476hkc98hx4YFTLAWEIqioNmgQ9juJ
         djNN1wUXCjOmqJf1gEDJwVbteDqlFY5tttNnr4pvkgn9y9CKu+d8G+hfIHjMH2mjdG/Y
         SeKtfmu4sobSq8nlVJmmCMpuox8/Is8TwWr5LcuWY/+zcomNELZS6liADSttUlcdcsOl
         kXKUJHcDAxT1A/T933DV3PSXJlhR+D8PwYbc5MVvQls9Xi5GNLcGTgZdgxSumBrV1jcW
         ER5A==
X-Gm-Message-State: ABuFfoh7cpirQP6zM3umee/7l/PAB8hu6/0ifcvabFzfzrvEMUflHu+Z
        luEqPwBuLeoblWrCu5U6vvw=
X-Google-Smtp-Source: ACcGV63cbX842PvBKXRC9uXjTiL/8O6PXBXDCrNQtxWdr8WttTxZSY+uDmTGDYYEI0Zr0E6r/KcSeQ==
X-Received: by 2002:a37:8806:: with SMTP id k6-v6mr18742289qkd.119.1539009923982;
        Mon, 08 Oct 2018 07:45:23 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1c56:381e:537f:a878? ([2001:4898:8010:0:58c:381e:537f:a878])
        by smtp.gmail.com with ESMTPSA id o7-v6sm8461541qkc.67.2018.10.08.07.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 07:45:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: define GIT_TEST_COMMIT_GRAPH
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.26.git.gitgitgadget@gmail.com>
 <85d02ac8d8c9a8950ce1a9760a541ff506945de0.1535488400.git.gitgitgadget@gmail.com>
 <87bm84a70p.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a2299be9-0840-da69-ebeb-f64ebe66db5a@gmail.com>
Date:   Mon, 8 Oct 2018 10:45:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87bm84a70p.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2018 9:43 AM, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Aug 28 2018, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The commit-graph feature is tested in isolation by
>> t5318-commit-graph.sh and t6600-test-reach.sh, but there are many
>> more interesting scenarios involving commit walks. Many of these
>> scenarios are covered by the existing test suite, but we need to
>> maintain coverage when the optional commit-graph structure is not
>> present.
>>
>> To allow running the full test suite with the commit-graph present,
>> add a new test environment variable, GIT_TEST_COMMIT_GRAPH. Similar
>> to GIT_TEST_SPLIT_INDEX, this variable makes every Git command try
>> to load the commit-graph when parsing commits, and writes the
>> commit-graph file after every 'git commit' command.
>>
>> There are a few tests that rely on commits not existing in
>> pack-files to trigger important events, so manually set
>> GIT_TEST_COMMIT_GRAPH to false for the necessary commands.
>>
>> There is one test in t6024-recursive-merge.sh that relies on the
>> merge-base algorithm picking one of two ambiguous merge-bases, and
>> the commit-graph feature changes which merge-base is picked.
>>
> The test feature itself seems fine, but this consistently fails ever
> since it got introduced (a reset --hard on the commit merged to msater
> in git.git):
>
>      GIT_TEST_COMMIT_GRAPH=true prove -j$(parallel --number-of-cores) t5500-fetch-pack.sh t6001-rev-list-graft.sh t6050-replace.sh
>      Test Summary Report
>      -------------------
>      t6001-rev-list-graft.sh (Wstat: 256 Tests: 14 Failed: 6)
>        Failed tests:  3, 5, 7, 9, 11, 13
>        Non-zero exit status: 1
>      t6050-replace.sh       (Wstat: 256 Tests: 35 Failed: 9)
>        Failed tests:  12-16, 24-25, 30, 35
>        Non-zero exit status: 1
>      t5500-fetch-pack.sh    (Wstat: 256 Tests: 357 Failed: 1)
>        Failed test:  351
>        Non-zero exit status: 1
>
> This is on Linux/Debian 4.17.0-1-amd64. Can you reproduce this? If not I
> can provide more info (-x output etc..).
I see these failures, too, but I believe they are due to 
ds/commit-graph-with-grafts not being merged to 'next' yet. The purpose 
of that branch is to fix these test breaks. The environment variable got 
merged a lot faster.

I just built & tested the 'jch' branch at 515d82d9 with 
GIT_TEST_COMMIT_GRAPH=1 and they all passed.

Thanks,
-Stolee
