Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E81C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 13:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiBYNzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 08:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiBYNzg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 08:55:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463E81E481D
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:55:04 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l25so7434128oic.13
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 05:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vGkjnh3JLh2jv79kMHOzcaB7GVzM8lyO1zSM2n9emE4=;
        b=T2rGvRoTxL4tByauBbkk6b/XPaLiG/Y0l70lwzO+sVE8W9fCKnMYq9rzFCczqAsyWb
         4NkIy9MrsCQlw3IdJ6sn83zEPEiX5ACwWKAyWXnEPs2qsB9fBvMzr0T5ahLT5pZ258UW
         HD/VeYzlUvnWBHzgDZtNCnZc33GuTd2oklv8ZkbNvl8pehOZQG89jGqY+CRXjRKCWjqL
         BcVertmEXgIcf46E+sSq3hnno0rDph9AKN+tl/d72JKYuYVFt5PRgyVUAXNhHGa5GBVh
         FmystGl/rXymGotFvbdARJUJGN8iyHrzQ6mwdnHKL5Ra0wzVflWSMZMiclzUKy+PAgAN
         GwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGkjnh3JLh2jv79kMHOzcaB7GVzM8lyO1zSM2n9emE4=;
        b=UECycsDCA4Y19QjOqdKQq9fiRkcQGcQcAYwImWLvn8ptP+lA+6s1sN2+nlixA1Y/wb
         lGno2IEg6oUwFE8DMhtafKE7taGyrBWU/jRN6/zhYWLsDTvkIYB8pqVUjOtNW1aLjuMk
         rDzo3jcT2FdvT0qMy2Sjj3aJRMDv/H/Yq5BYVnOZ+okVcunkT0rR9UmszXlUUROpji84
         3ky4qrEh1cA4t5YXJBKhSq71B5V0o/SV0qJIXgS6S1LRU2X2mGSe6ODqrM3vR/wkSyS4
         WK5N9uqK/yQAHCCDeqeVQ4tdte6h8HZqdPjXjTUiTkQP3fMn4/XxMyNkLDlaxlZzpsnR
         xZjw==
X-Gm-Message-State: AOAM5323M38MaaELaSRBGLgxJ0aPEhpLG/DBpysLfXfvAO8nwwkYuuLb
        dTPnWEH8K5hpdR1ZZyfgt01G
X-Google-Smtp-Source: ABdhPJzDyaJaLf52kkdXcOMz7jzHvJbA70bl6CoazMmFLnypae3YFx7zeKF1FhWveh/1VCzLk/A99w==
X-Received: by 2002:a05:6808:16a0:b0:2cf:21b5:f63d with SMTP id bb32-20020a05680816a000b002cf21b5f63dmr1627544oib.233.1645797303603;
        Fri, 25 Feb 2022 05:55:03 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm1341687oib.19.2022.02.25.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:55:03 -0800 (PST)
Message-ID: <1322bf87-e61b-5fcd-53eb-c98602efdc07@github.com>
Date:   Fri, 25 Feb 2022 08:55:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/7] Commit-graph: Generation Number v2 Fixes, v3
 implementation
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <xmqqsfs8j60g.fsf@gitster.g> <xmqqwnhjj24x.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwnhjj24x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 6:06 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> I'm submitting these two things together so we can see them all at once, but
>>> I'd be happy to split this into two series. The first four patches are
>>> important bug fixes, so we can consider them as higher-priority.
>>>
>>> Thanks, -Stolee
>>
>> Thanks, will take a look.
> 
> Overall it was a pleasant read, even though my reading hiccupped in
> a few places.  It does look like two separate topics, one of which
> builds on the other.

Thanks. I'll split them. The next version will drop the last three
patches and I'll re-send them after the first four merge down.

Thanks,
-Stolee
