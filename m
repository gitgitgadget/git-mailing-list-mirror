Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91B81F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbeGTRq6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:46:58 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39926 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387763AbeGTRq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:46:58 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so6581281qkg.6
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WE3ln113O0Rkp6kCq0TKGkaFZGpfC9VZ3YtWMphyYZw=;
        b=pHgz4+vbbGCCmQSshHYOE6RaoiGw3Ix4Lv6sLxvP2NOv5+HHFCbDjMjSyVwtseVdis
         T98yJiY/62LizUrE9gdvCeGSYkwVDr5JoW800Wy+Tu3JzPjSxnJ8gBPrX8aKjtxeYaVt
         Jz81xgW5Yu059eNK63UmI+Mn37NMmKJ32PVVXWGUIyF0x8bmrsJ19VP/AJLfJDcjHPNg
         LeB8qzXiSWSt9EmB77R883RHlDar7tMMMnXFgr+DXS8Pr7ZA6HBhUjAcm4zvQ+oVXTB/
         kGP1GSaDLsaq98diF2nJ/41x/4jXCZaUpnLI6YnpAnu1rOXjQ/0h5BoSH7CYe2obKs1V
         OBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WE3ln113O0Rkp6kCq0TKGkaFZGpfC9VZ3YtWMphyYZw=;
        b=EHKBv/9hBIqPo7hfaWCU5xAMSadcDK+4uSu0ZrdYmu9AG/8D6V6Jx8Z80qcnJ6NCs5
         TiUGLooOBKJmM05ud2Ojc/zr1+P5CJ2Rd3a3YQYYzE9/x0nU8dWJaM6ctMCvMUTOyPoD
         3ibV16Wu8blAQ/zl/xHZCQrKbNi4RPUvgNK+EyV0n1EWAn7dPcll15XVKN4uUY+Lh2Sq
         l3lxLf5zCFL9naKtzOS9aQSnB/7Pj8MzUTlo6dp1ZdybALaIWmWv1QrTvTz7DSLJ5o7i
         WdxEe5yHYShjz7JRfxLUdPwiMcd7K81mSa1nEQeOWBxa0jGwEyeLdAwnf83RiMxRdivs
         /a1Q==
X-Gm-Message-State: AOUpUlGpFx4QFpzO0jp21joUhPmT6yG7pf1SltTk6t8GxkcXSJzHJmBJ
        Kyf5UDe2k9P30zOfgLZ0UBH9efbM
X-Google-Smtp-Source: AAOMgpcljCx5SurjIM0QtWIUKsQdSksF1aCokpwLj3KocSDPybcKKO7XjhSpd5dQOEQDq/C8NTLTuQ==
X-Received: by 2002:a37:8b47:: with SMTP id n68-v6mr2532683qkd.27.1532105869263;
        Fri, 20 Jul 2018 09:57:49 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v4-v6sm1639499qth.23.2018.07.20.09.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:57:48 -0700 (PDT)
Subject: Re: [PATCH 5/8] commit-graph: not compatible with replace objects
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.11.git.gitgitgadget@gmail.com>
 <7f596c1718d35539f02828edbf933c8e660f123b.1531926932.git.gitgitgadget@gmail.com>
 <20180718194657.GC7778@sigill.intra.peff.net>
 <f5d2f06d-1736-57e4-edbd-aa638ae34238@gmail.com>
 <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
 <CAGZ79kZatUUO6s6h7uH6K3Ta5a9k-t6xuWeQ0uiAUF0sjp1avg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <16007477-d22a-4a3b-87db-07f11abdfb7f@gmail.com>
Date:   Fri, 20 Jul 2018 12:57:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZatUUO6s6h7uH6K3Ta5a9k-t6xuWeQ0uiAUF0sjp1avg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/2018 12:49 PM, Stefan Beller wrote:
>> Thanks, Peff, for improving the check_replace_refs interaction [1].
>>
>> Since this series now has two dependencies (including Stefan's ref-store
>> fix [2] that I had included in my v1), I'll let those topics settle
>> before I send a new v2.
> FYI: I have not been working on, nor plan to work on (in the short term)
> on the ref store fix series, which needs another abstraction layer IIUC to
> make it easier to integrate such a thing as well as extend the series to all
> functions in the refstore.
>
> Feel free to take over that series partially (and defer the extension for
> all functions in the ref store until later) ?

OK. Thanks for letting me know.

Perhaps I'll give it a try to pass the repository struct in the cbdata 
for the function pointers, as a minimum amount of change option.

Thanks,

-Stolee

