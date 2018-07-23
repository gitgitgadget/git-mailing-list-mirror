Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABFA21F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbeGWOOE (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:14:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33977 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388091AbeGWOOE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:14:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id b66-v6so344401qkj.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrUw1CoxPf3L7Skp3y39XTwejtSwmJ4oqftgGhNXIjw=;
        b=sEZ3SqmsHXyR58pfCKCXVmynfyFmHuqTVs4vYKerwLzLqC/aY1awIp0SWhXlWLL8YD
         H5rAa2xRcC/9GL7pKYFw5fPaoLnKA91cj269WKDilxOMT05Otj0+vmfYUXVHc4ar1T2p
         I0zX86B3mF31WxCFo0xjqA5HjqBgCY/kYWU6KY0FUlXYgjziVs6UZ9VGSd1oKWwrNMoj
         jf20Gw8mmR8V/zrlrzez0Y+rAXaESvkaoXG8JJzg+aivi6/lO9zLY8+x3lvTkrjv76R8
         r8OT8YEuKa77H7/Fw7cm0qgHk6pjtrxy7+8hjFbZm2MZicOzx6k/z3oy7jXNseEHaded
         meJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrUw1CoxPf3L7Skp3y39XTwejtSwmJ4oqftgGhNXIjw=;
        b=nBqWGaAxO61MrDMPwhznl4k4UKMDI85EmOYNo1NJ5dwbkZc54qujSpEJrDIvKpZANc
         EfKAiMuFhIdUw68tN1SuYza1AWh0Kw+SGcDKBxlmXdzHBF0rS5/zI9NtCpBrQGnecYjQ
         NZW8w4zXYbIcEO9qwlPjeyXr0HZ84FMo55uK0zWbPMLgBPGi2+yEv2PgzN1DUwb4iATA
         VlQ+Yi+FwqmgEg0I7p4y406yW7tb4fEBlNx47b5y/C9RqIifImOM7f6xRa/jIqPoQRFN
         ArjZlDxngjouMmSr4x9viEkXCwChusadWzrcsh3+gMlUmky4hfr3lDCSOIKav2KzKpYM
         7/yA==
X-Gm-Message-State: AOUpUlG+WeglmFFTuqTWYMiHXpqA9I1Ut2h6bl/CZiMT9no6OSMB2Yfo
        YJGBcXi9Hb826tBz+XBdQXY=
X-Google-Smtp-Source: AAOMgpccKFSlj5BFRIqJAuGrga0NBLiqDQHKGiAWhCKR/g1wg8Yj9BCr9pW2Nnr5EcDCHhpktmCKaQ==
X-Received: by 2002:a37:1f5e:: with SMTP id f91-v6mr11045178qkf.234.1532351572821;
        Mon, 23 Jul 2018 06:12:52 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id t3-v6sm7110324qtj.36.2018.07.23.06.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:12:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] t3507: add a testcase showing failure with sparse
 checkout
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>, kewillf@microsoft.com
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <20180721063428.20518-1-newren@gmail.com>
 <20180721063428.20518-2-newren@gmail.com>
 <CAPig+cTjQ74gOt8gJbYUBaTRsHBvqtcmucoVdiudFt2TrhCn+g@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <b56598a1-e543-500a-a39b-cee07fe1e533@gmail.com>
Date:   Mon, 23 Jul 2018 09:12:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTjQ74gOt8gJbYUBaTRsHBvqtcmucoVdiudFt2TrhCn+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/21/2018 3:21 AM, Eric Sunshine wrote:
> On Sat, Jul 21, 2018 at 2:34 AM Elijah Newren <newren@gmail.com> wrote:
>> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
>> @@ -392,4 +392,17 @@ test_expect_success 'commit --amend -s places the sign-off at the right place' '
>> +test_expect_failure 'failed cherry-pick with sparse-checkout' '
>> +       pristine_detach initial &&
>> +       git config core.sparseCheckout true &&
> 
> Should this be test_config()?
> 

I think using test_config() here is fine but...

>> +       echo /unrelated >.git/info/sparse-checkout &&
>> +       git read-tree --reset -u HEAD &&
>> +       test_must_fail git cherry-pick -Xours picked>actual &&
>> +       test_i18ngrep ! "Changes not staged for commit:" actual &&
>> +       echo "/*" >.git/info/sparse-checkout &&
>> +       git read-tree --reset -u HEAD &&
>> +       git config core.sparseCheckout false &&
> 
> See question above.
> 
>> +       rm .git/info/sparse-checkout
> 
> Should this cleanup be done by test_when_finished()?
> 

I think trying to use test_when_finished() for this really degrades the 
readability of the test.  See below:

test_expect_success 'failed cherry-pick with sparse-checkout' '
	pristine_detach initial &&
	test_config core.sparsecheckout true &&
	echo /unrelated >.git/info/sparse-checkout &&
	git read-tree --reset -u HEAD &&
	test_when_finished "echo \"/*\" >.git/info/sparse-checkout && git 
read-tree --reset -u HEAD && rm .git/info/sparse-checkout" &&
	test_must_fail git cherry-pick -Xours picked>actual &&
	test_i18ngrep ! "Changes not staged for commit:" actual
'

Given it takes multiple commands, I'd prefer to keep the setup and 
cleanup of the sparse checkout settings symmetrical.
