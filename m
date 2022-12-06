Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D94C352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 22:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLFWhM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 17:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLFWhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 17:37:11 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDCA48412
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 14:37:10 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t18so5551457pfq.13
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eKf9JEIoLoCoP0HQ5xIr+L5lwLL6QBgQYnG4zcO4UHY=;
        b=GW54eMgEEmbZy/Kpjgh0E5fGVa950GKu2oUhB6VUd3asbpkSYjtnPrh9OUAs/BwdyM
         KLSwiY3yeFtfvLu6HOrnkaziaEg55de+ZiUNJF0jw02sxMAHD8dqTtdWE9uUsesce2jb
         E1hpo/PmTocySHrb5tzfvyWFKBNFOetQVuF2w8e63XvgVVDZmUfkywnCO3LrLGtLItgT
         QEwlSqBGk5NFqBbiUyjC7OQT506eUNkaidk5vZDfdFOvKci+gtpfDk2b70Ayg6F0rd40
         IqWro56LwTFBpf71ljloe8hFJBM4TPpqAk6YPwdBubXuuQpEzQAfhqKj+bhTImOjn7Kj
         h/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKf9JEIoLoCoP0HQ5xIr+L5lwLL6QBgQYnG4zcO4UHY=;
        b=dTk4/R4EsuSVmcJwZ664CF2PrHdQI45JNy+KPrIsGRgPoSR5cvwICVHZ1fxWwRWdPW
         Bob8AvUsYRbzW32FGTVto2Znt22w7HD+3QUpFYDQavGcZeW1Ch2Ol0m0Oiy5BPhAhI9w
         cGvR+rXy14iSwDjFe+qNT5CgSsG4gBfhGDsgAWZYgtFoyNtrVxtMnzjFvODYYnazMM5C
         VXfCxpum4XlZHLR/dsTkowrYkXPcAlmoYOjZj6/SoG6G+brZ5qMPYyXNCBqTSwZh4yKX
         HE3gITXq3Y8/lf7JB16sp1iHMVmPOFnHf/puCFajtOfRGfZ/j2Q3FxHJtTTTHPggr1TR
         YSzg==
X-Gm-Message-State: ANoB5pmav5Pi6jzQLeYeZWi2x047wcb3yQ0+Hdu65lPA5apU6/2eIe4w
        dYFadcNw6/TUZdgko4TROJ8/O/n8lAfewI0=
X-Google-Smtp-Source: AA0mqf5pmZaYIrrkP1MbN0ZUL3f/8tauhHE9UnXXg5Uz9rXFcYNKKc/p3Lo0fNtky0XBROvK6/OMtg==
X-Received: by 2002:a63:3153:0:b0:478:9503:f498 with SMTP id x80-20020a633153000000b004789503f498mr17599630pgx.96.1670366229688;
        Tue, 06 Dec 2022 14:37:09 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0016f196209c9sm13129962pld.123.2022.12.06.14.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 14:37:08 -0800 (PST)
Message-ID: <07d963f0-45f2-ed8e-ea08-bcea14386a4d@github.com>
Date:   Tue, 6 Dec 2022 14:37:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> test_todo() is intended as a fine grained replacement for
> test_expect_failure(). Rather than marking the whole test as failing
> test_todo() is used to mark individual failing commands within a
> test. This approach to writing failing tests allows us to detect
> unexpected failures that are hidden by test_expect_failure().

I love this idea! I've nearly been burned a couple of times by the wrong
line in a 'test_expect_failure' triggering the error (e.g., due to bad
syntax earlier in the test). The added specificity of 'test_todo' will help
both reviewers and people fixing the underlying issues demonstrated by
expected-failing tests.

> 
> Failing commands are reported by the test harness in the same way as
> test_expect_failure() so there is no change in output when migrating
> from test_expect_failure() to test_todo(). If a command marked with
> test_todo() succeeds then the test will fail. This is designed to make
> it easier to see when a command starts succeeding in our CI compared
> to using test_expect_failure() where it is easy to fix a failing test
> case and not realize it.
> 
> test_todo() is built upon test_expect_failure() but accepts commands
> starting with test_* in addition to git. As our test_* assertions use
> BUG() to signal usage errors any such error will not be hidden by
> test_todo().

Should this be so restrictive? I think 'test_todo' would need to handle any
arbitrary command (mostly because of custom functions like
'ensure_not_expanded' in 't1092') to be an easy-to-use drop-in replacement
for 'test_expect_failure'. 

I see there's some related discussion in another subthread [1], but I don't
necessarily think removing restrictions (i.e. that the tested command must
be 'git', 'test_*', etc.) on 'test_todo' requires doing the same for
'test_must_fail' et al. to be internally consistent. On one hand,
'test_todo' could be interpreted as an assertion (like 'test_must_fail'),
where we only want to assert on our code - hence the restrictions. From that
perspective, it would make sense to ease restrictions uniformly on all of
our assertion helpers. 

On the other hand, I'm interpreting 'test_todo' as
'test_expect_failure_on_line_N' - more of a "post-test result interpreter"
than an assertion helper. So because 'test_expect_failure' doesn't require
the failing line to come from a particular command, I don't think
'test_todo' needs to either. That leaves assertion helpers like
'test_must_fail' out of the scope of this change, avoiding any hairiness of
allowing them to assert on arbitrary code.

What do you think?

[1] https://lore.kernel.org/git/221006.86mta8r860.gmgdl@evledraar.gmail.com/

> 
> This commit coverts a few tests to show the intended use of
> test_todo().  A limitation of test_todo() as it is currently
> implemented is that it cannot be used in a subshell.
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
