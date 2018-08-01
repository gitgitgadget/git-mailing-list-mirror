Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8FA1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeHAWVC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:21:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33663 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbeHAWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:21:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so11383858pgv.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r8jOOmH6EucQ783QO2+lbvglX5XXicX8WnQ/AJuuMBk=;
        b=rOk6uUQ5bDq1gsgvnOXt9AYT30kM2lAjXjxoxgPKfCyPeeWmVCNw63z80IVpaMOD3U
         6khR5JlhIVi+ldRp6/P9alFGYYE9B089NZ2EAo2CLkfLAMUNakvlHxWKaZhorMn7MMBU
         flGsOMfNkwhnSQsbUoVCKODCjZteuNPPZQJB17ZGHovt+yDDIggLrSYClWucGsqaZw2U
         vJej8qA+ufj6XevAIgI/uyWy+DwAWRKA1aPnWojjDnC1GPgno7lHNBN9wFwoSTbF8X15
         bwv3+FZ50e3TWex8p8289LOrDU34gn6saRarsq3wQDgO4Dq0/YK1rorsOSdrS8c48bHt
         y5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r8jOOmH6EucQ783QO2+lbvglX5XXicX8WnQ/AJuuMBk=;
        b=Ey0rl5vMVd64ggbETIhn1s9NRqMS7nQaQT9voipT5cySXQ7WaHw4JOI6WQEVNKVIhH
         hWOS65FRO0UVSns6tNTkUiTS16Kn+dJvQaQwXv/R7WZwTEMNTFg3hnO4IMdgup1NFhh/
         YmeY7hZCFELY9jHoDOy2+LxqwKLRleZkFEC6UBu/ZJ5Me9YsxLY1Juhg/V2W9ckCOEfA
         az47cQu6iC82DWXT+frHTc9W2MNKbvHpyir0saoTkkuGxP+N46netDeTuR0F+0UGv6C6
         gtoykJ4qeKzN7c08QVW3qyoHoGZaxZDRjIPjXvUTw4Vy0UsVkXe6eiw2bYEqBaUHLbFl
         08tQ==
X-Gm-Message-State: AOUpUlFqdiy2YMSybetos47NIQpV0uAX3Cc2aWMH59JfjCexAaG76Nwz
        D1LZ5RlRLJYOj227euDy6iY=
X-Google-Smtp-Source: AAOMgpeEhb45Lu6VUNJRLf8dQJXJ8T1vM7ZHMBYzn6zL8PyO4VXGy7Kshq6W8PrqEyAUcwJttfd2fA==
X-Received: by 2002:a62:f610:: with SMTP id x16-v6mr28579059pfh.169.1533155609046;
        Wed, 01 Aug 2018 13:33:29 -0700 (PDT)
Received: from [192.168.5.149] (143.120.102.199.static.airbits.net. [199.102.120.143])
        by smtp.gmail.com with ESMTPSA id u1-v6sm32604524pgk.25.2018.08.01.13.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:33:28 -0700 (PDT)
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <CAGZ79kY28vcs5TN9GtKd439vaTt38Qtwv8Lw0zanDaR1OmsTLg@mail.gmail.com>
 <833dea7f-b6dd-b3dd-6282-c0a5f939ecca@gmail.com>
 <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2c5febdb-f6f6-cb92-d959-84505261920d@gmail.com>
Date:   Wed, 1 Aug 2018 16:33:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 6:16 PM, Stefan Beller wrote:
>>>> * Use single rev-parse commands in test output, and pipe the OIDs through 'sort'
> Why do we need to sort them? The order of the answers given by rev-parse
> is the same as the input given and we did not need to sort it before, i.e.
> the unit under test would not give sorted output but some deterministic(?)
> order, which we can replicate as input to rev-parse.
> Am I missing the obvious?
The output of the test program is not always deterministic (or at least, 
the order is determined by the implementation, but not as part of the 
method contract). For example: get_all_merge_bases can return the list 
of merge bases in any order.

By sorting, we can ensure the output values (and their multiplicity) 
match expected.

Thanks,
-Stolee
