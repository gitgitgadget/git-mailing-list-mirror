Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABA1C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhLGQtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhLGQtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:49:14 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFDC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:45:44 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso18771112ots.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EQSxvnLdJNAO9HavkYpG5Ng+o9l7nvKb9wQxgCVxdq0=;
        b=EONPj/yebOW3sMeGyse4VfYHgaBSlFUp/ljta6YEcHrh8xNFn/WMvOtYP+ynveMbkZ
         0834sKVSne/1XS79gO8ufX1KGT/1ChOPO3y+/NLLS4GACx1p5SmDDeL/N6UGxRndnxL5
         paxR8Kthl408ZFNF9l/yhppcnA1XXmk3fEodn3zbN00dVy0u+Ye0GF8yBxLWcD0Gp1PH
         asDc75fHQLZGAGBRzz/TdD9n1MdpwpOCal7quLEhPZjrC5SFM2mlyhat8AUT3i0qiabD
         qgLghyiDV2wEH0CZyB0ONwTBGZMVZTgpmvZHGhAsLJYEAxilD8D2Og2Xh6yPZrzluuhF
         hYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EQSxvnLdJNAO9HavkYpG5Ng+o9l7nvKb9wQxgCVxdq0=;
        b=04LG6xdNzlK1+k23i46yi8+3HYejmNAzk4Tbuzx1KesFySDfsMMF4Xo1q/7ZNkbuoJ
         Wqdu4PEymaMw+8M0Dfkrg5Hy8u8QpCRXMONpMsdfSVisYWPJq3NYVahUQos/TEjWPik1
         dlrlHplMDffO3p+eXhTEd0hMkPs8drPiWRn3TxKw81nxtz5YDRzV2+NT4ukWQb7hlJn2
         1jg2OgSCZuQbjJQEgTmaaFxHNWVbztTZd5zCDrVoTnpjb733rFXQWkLcDnip+bcoCM3u
         YBANvE/iGVEH9w9GNuUa3T5FyUTOTCziR5MnEUBMj1mIufy28ArQjlwtXddx4D7w+cED
         xQ3A==
X-Gm-Message-State: AOAM531FwKwCCe1z36c4t8uyqkYe25h89Yx7X/prZGumNxWo+UeZBp/z
        TtI6X71KaUR37pyMfnbsJ0Q=
X-Google-Smtp-Source: ABdhPJydGFlE590KE0lgiRBvsGqeaRv0cN+pYRUZebv7dx4NM6oLBkhfDV2UDRch3WDiDUUwWCREug==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr8622363oti.332.1638895542893;
        Tue, 07 Dec 2021 08:45:42 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id w24sm18739ots.10.2021.12.07.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:45:42 -0800 (PST)
Message-ID: <ab6a6e5d-d1a4-4122-5f4e-de4a840af681@gmail.com>
Date:   Tue, 7 Dec 2021 11:45:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/6] git-sparse-checkout.txt: update to document that set
 handles init
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <95d3df78b2ffe2e0d6234f326f8f7acbd2b67301.1638648020.git.gitgitgadget@gmail.com>
 <9e4e34c9-5485-c10d-48b6-a1a6f5e12486@github.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9e4e34c9-5485-c10d-48b6-a1a6f5e12486@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2021 4:48 PM, Victoria Dye wrote:
> Elijah Newren via GitGitGadget wrote:

>> +'init'::
>> +	Deprecated command that behaves like `set` with no specified paths.
>> +	May be removed in the future.
> 
> I'm on board with deprecating `init`, but one usage that's not covered by
> the updated `set` is toggling the sparse index *without* modifying the
> patterns. That likely won't matter to most users, but ones that assume `git
> sparse-checkout set --[no-]sparse-index` works the same way as `git
> sparse-checkout init --[no-]sparse-index` would find themselves losing their
> existing pattern set.
> 
> Maybe `--[no-]sparse-index` should be added to `git sparse-checkout
> reapply`? For changing settings without updating patterns, that probably
> makes more sense than `init` or `set` anyway. If adding that option is
> outside the scope of what you want to do in this series, though, I'd be
> happy with a note somewhere in this documentation explicitly noting that
> `set` (unlike `init`) will change your patterns, even when toggling
> `index.sparse` (or `core.sparseCheckoutCone`).

I like 'reapply' as a good place for that functionality. Hopefully it
won't be long before the sparse index is on by default, but it will
still be good to have a user-facing way to toggle it, when necessary.

Thanks,
-Stolee
