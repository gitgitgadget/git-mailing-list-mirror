Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D4291F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfJXUhA (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 16:37:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38134 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfJXUhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 16:37:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id v9so16232848wrq.5
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lQwA8nxW+n71bKCHXkZIU3+CYk44LLXDx7H+sOZDmsQ=;
        b=EMYoJgMlt4W0py3DIigWhZca1OkpcbZtNOCFwbkNGA06lUUI/b/3iVqSxDsG0TuCxi
         jdfhDLviwQhMuRZaETgPGwfAhRv0L5w+w9I9AYPwqqqa5En91NIu8Y2H3nnZ89/pf+oc
         merAvfn73KNFIFiOuBmj8JhCaLEj8/qxmGwWqYdJoj3rRELWF07g8xm32KfSnDjbklds
         rgZi8oBTW0h6OfyesuAMsi9DUpZd327AdUYFVs7/ieK5FLsYLzisj1PyVTWj5GsC29Wz
         CfffP6quv8WCnCoK9qFmMwgKGlU332GcJmAYvvpG3Yss3cIp5pHuOGR63iWmtqqaZNCC
         wfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lQwA8nxW+n71bKCHXkZIU3+CYk44LLXDx7H+sOZDmsQ=;
        b=C4PrMvtbv38MxZd0mgBSFmkn6zvKO7yedz/VX0C0vX9l2GeNWGGKa/Z/SDNlHqwMy5
         ZITvC6OxWHsfEdywhB/ZKDV0EIbCXMqGgUGscGn1/SuU4B4R98A6k4E/VGwsBD+aDTcZ
         E1LntFYvr5pJgzNeD70iSylqqHhVyMPtblrBGdqXrsBu4OeLnD7c2wGf357eurM3C1ZL
         jT7fb5QeTWa4WpojBZJYNpjJYtdx8Vc68RTYmXgfc6Uf3xJh/KkOWeptrO/nYHzVabCu
         9I8jUlbInccV9gTYxBgTspRk5qw0Tg6112dNUxdm3KOOE9TBrLaBhaoRcLoVgZk7qc5A
         ZkMg==
X-Gm-Message-State: APjAAAUHHM2VhYwYVqxAYEm/359bpNutHgzyRpIOfKFqP45HWr37GxPR
        4iGEmAbHCTC1thfqED5iGfc=
X-Google-Smtp-Source: APXvYqyDnOsqIQuw6D/FePaN2lDgWKao2ROk2BiVEg5ER2rRxchoLOp7H+tfS58gEiLqLQFJs4ampA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr5484828wrm.302.1571949418149;
        Thu, 24 Oct 2019 13:36:58 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.gmail.com with ESMTPSA id s13sm3200134wmc.28.2019.10.24.13.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 13:36:57 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/6] rebase -i: support --ignore-date
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <5adde732-173b-d24d-d23f-bb4d043076d7@gmail.com>
 <20191006175747.17340-1-rohit.ashiwal265@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6208a090-09ff-8756-2d9a-1fd7b9be6197@gmail.com>
Date:   Thu, 24 Oct 2019 21:36:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191006175747.17340-1-rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit

On 06/10/2019 18:57, Rohit Ashiwal wrote:
> On Fri, 27 Sep 2019 11:00:58 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> [...]
> 
> Thanks for all the advice and improvements.
> 
>> [...]
>> It's good to see the new test. Did you see Stolee's email [4] about the
>> test coverage of the previous version of this series? You should check
>> that this series tests all the untested non-error handling lines.
>>
>> [4]
>> https://public-inbox.org/git/1ed86989-9ba2-0cd7-b6f7-654d1943b1d7@gmail.com/
> 
> Yes, I've seen it and have improved the test since.

Have you improved it since v4? Stolee's latest email [1] still shows 
push_date() as completely untested. We need a test that gets the 
sequencer to fork git-commit, the easiest way is probably to reword a 
commit. Also the new code for ignoring the date when we fork 'git merge' 
is untested. Having a test that does an octopus merge or sets a merge 
strategy (or merge strategy option) should fix that.

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/ed8e65a2-72e8-210c-d4a4-eacdb5c7b0e8@gmail.com/


> Thanks
> Rohit
> 
