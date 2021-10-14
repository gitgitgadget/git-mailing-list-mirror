Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E120C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D1A610D0
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 13:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJNNgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJNNgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 09:36:38 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53CC061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 06:34:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r18so19599236wrg.6
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 06:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=PFXTpCLv09L5M+dFFSZrTbEzCVaEa0vyD3OkDYF6k0A=;
        b=kslblJnPy/o+IzRn9Ktlk4W8gSaiFlF+lE+Hl73abybogLCq6u2ywux/8X1Q45Hnch
         a9AIbhTZ97scMYmvNxiuqNyp6v5fXiEmlpMWzyruDhOBzQ1F63se6Kw8p5eUbe0RiZBi
         4aSybCtwn8OcIrFfzajTBKYL0ZB0DyO3qa19BMW6/1ifBn8otP+F8pDwsBHGxPo6E1Jb
         GhcEfehLr3eYdoHKZTLeOaVtxeQlFxvJhrXY6G7TEqDty0m7PoHBogbKoec9ISmYBA7a
         Ql9OuNbBYYa7fEsSpBFEV+44uy2TXZDxln+PSA23LfqyWYkE88MVm+rlclnbs/8eTRt4
         korg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=PFXTpCLv09L5M+dFFSZrTbEzCVaEa0vyD3OkDYF6k0A=;
        b=pM2MK/HC/qxHlIdC6ILZp4KmDuhru1pRg22AnTFuASR1U7W+xJv52XzEB5fMO1PvB2
         a8jEVoIYqTHjE+DCeHQKLB2dhIHkhxqbRqI/kajR4hoBrlYiQ16DzF55N0nTnyNTz26m
         QVgumGw0M0IXD5VJWtjzqcGja70+2ZhK7kBaMQ1Fzo37K6kuVNloEwJ30mY8Zb77mEUw
         f9lLxdRkKsKEDHYqquwh6pz9c64Oxk4yXAmbttycPDV1duzj5snUscKj3ky/DGzHkWmC
         a0v3CXYWsl3/GY8AUz/bHE8pg9XDVx8tyQmgYo3UAU7mlZSrjWusIr/zXq8yXtqVgwOj
         R/vQ==
X-Gm-Message-State: AOAM531uYcmLw86fvImGC1H5TTWf6m25hUcJ525xm72m8b9FbjuggW+j
        Wxr2RwlkvoQyKnC9vmksT6I=
X-Google-Smtp-Source: ABdhPJyzt1j0UXI8/md3yo3d2jNa2kLxXI/QA51Ei5ivkTlRs64/tG9DK32Ex+RInl+01IZrpRyahA==
X-Received: by 2002:adf:a15c:: with SMTP id r28mr6656278wrr.287.1634218472047;
        Thu, 14 Oct 2021 06:34:32 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id v10sm2594873wri.29.2021.10.14.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:34:31 -0700 (PDT)
Message-ID: <6dd3ba9f-7054-93f3-7798-d4a4a211899a@gmail.com>
Date:   Thu, 14 Oct 2021 14:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] sparse index: fix use-after-free bug in
 cache_tree_verify()
Reply-To: phillip.wood@dunelm.org.uk
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1053.v2.git.1633600244854.gitgitgadget@gmail.com>
 <pull.1053.v3.git.1633630041829.gitgitgadget@gmail.com>
 <xmqqee8wpm0u.fsf@gitster.g> <4ccaad06-a1ae-bd1b-f25d-bfa899ffa98f@gmail.com>
 <xmqqwnmnjnn5.fsf@gitster.g>
Content-Language: en-GB-large
In-Reply-To: <xmqqwnmnjnn5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 08/10/2021 20:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 07/10/2021 22:23, Junio C Hamano wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>        * Fixed the spelling of Stolee's name (sorry Stolee)
>>>>        * Added "-q" to the test to prevent a failure on Microsoft's fork[1]
>>>>            [1]
>>>>       https://lore.kernel.org/git/ebbe8616-0863-812b-e112-103680f7298b@gmail.com/
>>> I've seen the exchange, but ...
>>>
>>>> -	for OPERATION in "merge -m merge" cherry-pick rebase
>>>> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply -q" "rebase --merge"
>>>>    	do
>>> ... it looks too strange that only one of them requires a "--quiet"
>>> option.  Is it a possibility to get whoever's fork corrected so that
>>> it behaves sensibly without requiring the "-q" option only for the
>>> particular rebase backend?
>>
>> The issue is caused by a patch that Microsoft is carrying that stops
>> apply from creating paths with the skip-worktree bit set. As they're
>> upstreaming their sparse index and checkout work I expect it will show
>> up on the list sooner or later. I agree the "-q" is odd and it also
>> means the test is weaker but I'm not sure what else we can do.
> 
> Perhaps passing "-q" to the other variant of "rebase" would make it
> clear that (1) we do not want to worry about traces involved in the
> verbose message generation and (2) there is nothing fishy going on
> in only one of the "rebase" backends.

I'm not sure about that. There are really three levels of output from 
rebase - quiet, normal and verbose. I think passing "-q" suppresses 
virtually all the output - there is no indication of which commits have 
been picked. As test appears to be comparing the output of the command 
for the sparse and non-spare case as a proxy for "it behaves the same 
for sparse and non-sparse checkouts/indexes" passing "-q" to rebase 
weakens the test considerably. Stolee indicated [1] that he is happy for 
us to drop the "-q" for the "--apply" case so I'd be inclined to go back 
to your corrected version of V2.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/e281c2e2-2044-1a11-e2bc-5ab3ee92c300@gmail.com/
