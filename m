Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8921F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbeGTSE4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:04:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41814 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbeGTSE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:04:56 -0400
Received: by mail-qk0-f196.google.com with SMTP id d22-v6so6606714qkc.8
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=k0xF+L5fMitrmGP7zr4eR/ikNGdWr3Jz0iiEsqcUgB8=;
        b=M7M4bixa+y05P0rlFu7DgkX4YxzYKBVmCm7UaxmZPEQLpOWOkebrV5r7h/HInGLWjb
         KglJv6NBRxoZzlIUKld6ZRPOW985zl+qP32QuiidLiDdRswhr+QMlZsGtzVkGEsfamfO
         XCgY8vaAfVj7Y5Cu8pvrw3P1DoYJVT9XiRZFPWOJpeltU8WXyh5lqD1hgNn/K9xvbg5X
         sUo3aTSKW4PiQByK2UK2CXqcJUhFlvAv5tGxd7cQVlgKl73ctgZKWvTbsKb+WhJfkpU+
         EI3ZQPKo+1gO1+wXI2p9+LjupaSt8c5Y2CRLJXG2ggkLXXdhQrrjSpfgEDotmZJNa/r2
         8AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k0xF+L5fMitrmGP7zr4eR/ikNGdWr3Jz0iiEsqcUgB8=;
        b=hwecRr4amqbVxLvdSy/WNf4QsPtgttfibVIutfHu8ic1j48swpeCETfP9uq67bN2WP
         UQPxdlr1TAAZi3AXms03B3fYmpHtFR+YwxedU8r1M3SoSmCngT922Y8cdLuMe/VH6iiI
         gn7u+3+/LrJw1Ny/PhKgbxCGvZNqsnCferFSuoY3diqKbfVnK560S9cxqvRtUtHeOl3X
         wauJlLz4kJv42IxPmRwtyQBrYkP4u6UxEpD2k9F1q29hUT8Dcg+YG08rzJkymyZDPlRf
         oHECzHPHY8X4blpeCLs3Bb0N3P9mrxCEFMTxj5Y0lmnjVB+Kn5sJDTM/t4xwNSqeDs2U
         XDDQ==
X-Gm-Message-State: AOUpUlGRJ8IKw1mvBu4vhIEIeCfcDzZNzOI45DnrZM/yiIaTyDCA2u6h
        ZEEXAXk7lbaiZH0fsJJJQzs=
X-Google-Smtp-Source: AAOMgpckkGOXG/2gDy476rztdEWhPu+6X/IQs7VMse0VHX4Gm+CTzEpfKAV2z/B4mLEv6jalLF2Ftw==
X-Received: by 2002:a37:cf43:: with SMTP id e64-v6mr2505018qkj.68.1532106942738;
        Fri, 20 Jul 2018 10:15:42 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q83-v6sm1532268qki.67.2018.07.20.10.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 10:15:42 -0700 (PDT)
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
 <CAGZ79kY28vcs5TN9GtKd439vaTt38Qtwv8Lw0zanDaR1OmsTLg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <833dea7f-b6dd-b3dd-6282-c0a5f939ecca@gmail.com>
Date:   Fri, 20 Jul 2018 13:15:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY28vcs5TN9GtKd439vaTt38Qtwv8Lw0zanDaR1OmsTLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 1:10 PM, Stefan Beller wrote:
> Hi Derrick,
>
>> V2 Update: The biggest material change in this version is that we drop the
>> method declarations from commit.h, which requires adding a lot of references
>> to commit-reach.h across the codebase. This change is in a commit on its own.
>> In addition, we have the following smaller changes:
> Is there a remote available to get this series from?

Sure! It's on my fork [1]

[1] https://github.com/derrickstolee/git/tree/reach/refactor


>> * Use 'unsigned int' for the flag variables.
>>
>> * Properly align the here-doc test input data.
>>
>> * Use single rev-parse commands in test output, and pipe the OIDs through 'sort'
>>
>> * Check output of parse_commit()
>>
>> * Update flag documentation in object.h
>>
>> * Add tests for commit_contains() including both algorithms.
>>
>> * Reduce size of "mixed-mode" commit-graph to ensure we start commit walks
>>    'above' the graph and then walk into the commits with generation numbers.
> A range diff would be nice (though I can just look at all patches again
> even if it takes longer).

I can send a diff. It's a bit big because of the indenting changes.

> I notice this is not sent via the GGG, but via git send-email?

GGG can do version updates, but is currently having trouble when the 
branch has conflicts with the target [2]. We will address this issue 
next week, but I wanted to get this version out. Thank you for your 
patience as we work out the kinks.

[2] https://github.com/gitgitgadget/gitgitgadget/issues/25

Thanks,

-Stolee

