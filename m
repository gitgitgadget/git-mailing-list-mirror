Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAACC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 13:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiBPNyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 08:54:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiBPNyT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 08:54:19 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D17D1E8BD3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:54:07 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e79so2264583iof.13
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 05:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Af5rpQBPoNTspUbkQ8RaMfMDUvj8i9CgEP+sbz9TFqw=;
        b=IjbtRE/F4ra/OS2oUxAHha61GA/NEyK2ZPhFHJ98Oav5iwZcSLNd8pmF8leTkUNhJw
         IDttpnk7UnCvOsccuK1++GG8E9sS++037uwLBb/65RhVUaj4tV1v2NpAVsPaVtLtLS6Q
         ahtwhKFYQJYO4/bp6Z0n+qdW2cRx+81yD9yEVz4oiTh/YQxqANj5/kpCIfmU/M3qIZIH
         ERSVsv196x9JLy7TYEpx3CO20l4eEULkvCc/M6saLsM9uD1nvW+IzlocYfAxCCbs0XgE
         a/Mnia2d/jZKKWF0sp4JgsXc6d3TY0p5l0ThZNHYRheQNBWteL/72WTLGonbEdQg7cQR
         Qp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Af5rpQBPoNTspUbkQ8RaMfMDUvj8i9CgEP+sbz9TFqw=;
        b=GClcM3qMSqWWbZEZ9IAtu61JTzGZKFoyICBJdBIRkCOiI/d4ut+8tZXztzt9Rw0YXq
         BKgWG1Y3iRqF+wy7QLXCeBC/Ele3cqPNosPJjNDOw/txAbONGd3wVoSRtSD3UiVhtUlF
         fjy3upSyKZNToTaRnflQjPpZmLhp2jG1NByhqH/tPLVZIjQRTOcq1iEsCpKEI57Xo5OR
         s39B/zXEKSFCJm0ntSYd5+lvgGG+lwiTJAjZjGTbAaUENMpZffrdf4ygbOd0RjlutVSx
         kRb/9NyGJohngNxyKZZnFhOU7EqFJ/oj5GZBu6t76vYwJfND5sTaROjMmEh8fNyz/Doc
         Rcgg==
X-Gm-Message-State: AOAM533+C39Mog8nUuudwSEouQOwVfjgmPpYYBTWSmIIWMrbunMXPHbz
        9VOFFj2db+W0WkFme8vj1w1sCx+x+Caq
X-Google-Smtp-Source: ABdhPJx/jQqafqGhAFhnX/3eLIPoB6qX8IRtN9U6rVx+qn4wtdJamq9XL3mo7HbVKycGFqufFYXbug==
X-Received: by 2002:a02:a793:0:b0:311:c031:ea76 with SMTP id e19-20020a02a793000000b00311c031ea76mr1766776jaj.80.1645019646719;
        Wed, 16 Feb 2022 05:54:06 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p13sm26666459iod.51.2022.02.16.05.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:54:06 -0800 (PST)
Message-ID: <51efdb1e-00f1-e4c0-97df-478cc5982b49@github.com>
Date:   Wed, 16 Feb 2022 08:54:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: ds/sparse-checkout-requires-per-worktree-config (Was: Re: What's
 cooking in git.git (Feb 2022, #04; Tue, 15))
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
References: <xmqqk0dwyrcv.fsf@gitster.g>
 <CABPp-BHxg+KE7W0jLfHC+DfjRyNoigv4qSEgJyehnUZNLUzZCg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BHxg+KE7W0jLfHC+DfjRyNoigv4qSEgJyehnUZNLUzZCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/2022 12:06 AM, Elijah Newren wrote:
> On Tue, Feb 15, 2022 at 12:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * ds/sparse-checkout-requires-per-worktree-config (2022-02-08) 6 commits
>>  - config: make git_configset_get_string_tmp() private
>>  - worktree: copy sparse-checkout patterns and config on add
>>  - sparse-checkout: set worktree-config correctly
>>  - config: add repo_config_set_worktree_gently()
>>  - worktree: create init_worktree_config()
>>  - Documentation: add extensions.worktreeConfig details
>>
>>  "git sparse-checkout" wants to work with per-worktree configration,
>>  but did not work well in a worktree attached to a bare repository.
>>
>>  Will merge to 'next'?
>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>  cf. <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
>>  source: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
> 
> With v6, Eric seems to also be happy with the series (cf.
> <CAPig+cQTRGuuspz2g5LZr4Oh8bQCr4FUDV0tirs+ZPwhtAaJVw@mail.gmail.com>).
> So, I think it's ready to merge down.

I agree. Thanks for the close looks at this.

I think I will send a forward fix that attempts to clear up
the "worktree" versus "working tree" changes across all of
git-worktree.txt and related docs, now that Eric corrected my
interpretation of his comments [1].

Thanks,
-Stolee

[1] https://lore.kernel.org/git/CAPig+cR+n=LQg5AJQgGQXuYStN90-jExWnE45sS1EXo+O8dQgQ@mail.gmail.com/
