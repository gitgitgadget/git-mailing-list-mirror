Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A0C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 20:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFHUSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 16:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiFHUSF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 16:18:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A793289AA
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 13:18:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id s26so10234053ioa.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Akm3qXm7Ub0J2V1nJ2rwHqKjFkYwHIRfGCoi7sOni4g=;
        b=ILAegfLcB6Nr7MmU6vgh37/HZvaAF51/OoPHRWXrZ4//l37mqfaKWAc0NIiBsQrrdL
         +d634uQOhfasqG7oWwcuu+ewZb4fSnlwMn0CNa2orIUtuJNlRPxC7hC46gilFb2ZDRUS
         va5eGD00/GjQIratpdGj8BvX6y9lpC/0fQFvEKBTZlFMmZPldzF8bQn49iDWqKsjR2QD
         4kVGK7+En1p1Sm86a2lR5EfbUac8vtpxZ6uKVWo/X99SKeK27gGbZmFsalTFWrw+aqsc
         0hMFn9IO4I8GZZsINttWb2Kh977VsB9wVs89j+dby5klHcg5V9e0MHW2ToQkH8iyC9Xl
         fKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Akm3qXm7Ub0J2V1nJ2rwHqKjFkYwHIRfGCoi7sOni4g=;
        b=hGR9RAP4tOvwvBfZ0f1QKuxMKeogOx9IfYSURDv+JzUDWnEUUkWt+YFGS53k6V9wq4
         bku+c+EP2LNwcuZ798WCyrSnz8yqAnLC5VmpqKcAAm6sBe3LqKQ4R5gG/zWcWZ43AkHP
         6QqgejGaj1pR/3PyOXas/p1IjSep4mpzupHW9DZKo5JGv/TWQYpdZF8Tw/fJnvbdtXcv
         jd36AvTVOHL2t0Ynz0JXx0Wr7ivg94oovsXxv+qhdLO/FqON+uIA/BX4jmF2u0FUJiUB
         n4dhk6RdxddCnSuAX01snajwnfoKeZ+jBKDrKowD7vepueS9Ipfxp5usVoW2nz2gIe2q
         Ooew==
X-Gm-Message-State: AOAM533wbODGueNg8eKetjitSUYdPtFjBr2/LKltjeRJMO09c9/hoGwj
        oGgZElrFHbMuUIDGm3FG/QV2
X-Google-Smtp-Source: ABdhPJzLj2AiIF5o7BDTremdFj6sUgLB9f8TgInuzZcFcBUHJUpru+bSMSFNliCXryu0eKoFE3+IGA==
X-Received: by 2002:a05:6638:371e:b0:331:bc34:c3b1 with SMTP id k30-20020a056638371e00b00331bc34c3b1mr7631335jav.68.1654719483782;
        Wed, 08 Jun 2022 13:18:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d9403000000b0066579afd3cbsm8627012ion.50.2022.06.08.13.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:18:03 -0700 (PDT)
Message-ID: <42863c70-0cc5-ce64-f8b9-a75cb6e1343c@github.com>
Date:   Wed, 8 Jun 2022 16:18:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: ds/rebase-update-refs (was Re: What's cooking in git.git (Jun 2022,
 #02; Tue, 7))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <xmqqwndsrm99.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwndsrm99.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2022 9:12 PM, Junio C Hamano wrote:

> * ds/rebase-update-refs (2022-06-07) 7 commits
>  - rebase: add rebase.updateRefs config option
>  - sequencer: implement 'update-refs' command
>  - rebase: add --update-refs option
>  - sequencer: add update-refs command
>  - sequencer: define array with enum values
>  - branch: add branch_checked_out() helper
>  - log-tree: create for_each_decoration()
> 
>  "git rebase" learns "--update-refs" to update the refs that point
>  at commits being rewritten so that they point at the corresponding
>  commits in the rewritten history.
> 
>  source: <3d7d3f656b4e93e8caa0d18d29c318ede956d1d7.1654634569.git.gitgitgadget@gmail.com>

One patch here generated enough subtleties to justify its own
topic [1]. In addition, Philip's feedback presented interesting
motivation to change the direction of this feature.

[1] https://lore.kernel.org/git/pull.1254.git.1654718942.gitgitgadget@gmail.com

I recommend ejecting this topic. I'll come back with a new
version of it (based on [1]) after the 2.37.0 release window.

Thanks,
-Stolee
