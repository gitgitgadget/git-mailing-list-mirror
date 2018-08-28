Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4DC1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH2B1P (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:27:15 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37512 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeH2B1P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:27:15 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so3510214qtl.4
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zc+btNKIilm8IIE+xShBjLXXHsmRCRxrYO2SlufJuPE=;
        b=ebV3p2hJB1tagVtjX7c+n078n/LOMUIgV+Sm0u1hnao3Al7rMDf5Z6BAQCE83mqcAn
         7h65/1aL2E4ovRGMAJS1hQaS2Nd9OAeZ/JRKGTECUG8ZdFjL+ZEeC0kI/VMfpiZXLfH7
         +aCKaC2V9ksHTGMeaFxiJBX3Bf+mmBShbfwBfgoia3v5dl6Eq7nkPRlaC3/Xje9EsKyI
         iF8gD9B/xDoGS0I2Ly02OXFp0xzBbVqPglHhW+xJJHj2qqUNkqPgrByO2dUnndRiQuiV
         AFDEW3AvCsl3jomU2jQErAoV8XjDfZffBda2NcQ0n53wSZ9n8e/FxFlq5/z0tUsllnGu
         SrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zc+btNKIilm8IIE+xShBjLXXHsmRCRxrYO2SlufJuPE=;
        b=dpyH3LNETV2Y2tf6fj00Mnl4dLrT58PX8h+bel9hEEiIRecB1eUnl+jllY0wtu/uRN
         VtOh+aeMMy25oqwqIeDL6YgPD1mygX0qGCSvjGUJvomgzYzozxrI6r5lr8Qgvi6iJFM+
         P62xudF6aN71mUurMEZiftD5yVk8nFpmuN3HH4/+7BI/VKPW+UK+SHTzdR07K+gPO/8n
         PieWtX1cCaAqNwOnhrEEnVR76XOYfvJo6BpYOK2/VA1nq1izEYVReHVID1ztCTKBN49X
         Lko+0zAAAguLG43WkLhjIR+BthtFzq0GFvb9G2uex5J6lRHTxu3Zy3/ZOyfZfdx0Zv+8
         BT3w==
X-Gm-Message-State: APzg51DvOJfStxVS0D8u/2xNuDSGGeBgpBp2YG3+xKl+ajCPnn3H3r8E
        9e/2ECWUh4oXhBSumXW0MIw=
X-Google-Smtp-Source: ANB0VdYg2NOlGKyIsNkAZPeh3iNC112s4+OQZ4bMfmzDUfNH4+/cvXfPVqN23+qepGLK+Tdjm5dADA==
X-Received: by 2002:aed:2ce1:: with SMTP id g88-v6mr3819567qtd.285.1535492021382;
        Tue, 28 Aug 2018 14:33:41 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id k15-v6sm1489252qtf.95.2018.08.28.14.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:33:40 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] commit-reach: move commit_contains from
 ref-filter
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <20180720163227.105950-5-dstolee@microsoft.com>
 <20180828212457.GA74687@aiede.svl.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e71b2540-430d-d3e8-0c29-f290a12de4b0@gmail.com>
Date:   Tue, 28 Aug 2018 17:33:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828212457.GA74687@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 5:24 PM, Jonathan Nieder wrote:
> Hi,
>
> Derrick Stolee wrote:
>
>> There are several commit walks in the codebase. Group them together into
>> a new commit-reach.c file and corresponding header. After we group these
>> walks into one place, we can reduce duplicate logic by calling
>> equivalent methods.
>>
>> All methods are direct moves, except we also make the commit_contains()
>> method public so its consumers in ref-filter.c can still call it. We can
>> also test this method in a test-tool in a later commit.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-reach.c | 121 +++++++++++++++++++++++++++++++++++++++++
>>   commit-reach.h |  20 ++++++-
>>   ref-filter.c   | 145 +++----------------------------------------------
>>   3 files changed, 147 insertions(+), 139 deletions(-)
>>
>> diff --git a/commit-reach.c b/commit-reach.c
>> index a6bc4781a6..01d796f011 100644
>> --- a/commit-reach.c
>> +++ b/commit-reach.c
>> @@ -1,8 +1,10 @@
>>   #include "cache.h"
>>   #include "commit.h"
>> +#include "commit-graph.h"
>>   #include "decorate.h"
>>   #include "prio-queue.h"
>>   #include "tree.h"
>> +#include "ref-filter.c"
> Did you mean "ref-filter.h"?
>
> This broke the build here.  Is there some check that we can use to
> prevent it happening again?  I don't think we ever intentionally
> #include a .c file.
Woah! How did that ever work? I definitely built this locally.
