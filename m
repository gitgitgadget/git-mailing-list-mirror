Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983AA1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeGRRdq (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:33:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36667 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbeGRRdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:33:46 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so4647135qtn.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BuUqNT2n9D9QoX7OeMV1c1PgkrJJcAuz6uMJAG9Bo/M=;
        b=pkwQ9oDglRguKJvDkkRlIuZ02i06l8ZE4KwSMsNAoU3kSFr1MgYlKaD+XdaDuJSQlX
         KMGAyINDWo71tCKwPpyPUAVwNN2orV/1Zv2aU+7xsYcPGddCUwFKkogsvMEPZoEbwckZ
         0iFX6y3zA3kJUBJokYperUAKBXn8hmOwAAzxCXck515Czc4T8CiZCz53ic0mTOJiVAYf
         IBUptzWOX3ANiSTKYnnz8dmm5/EZFMKmtni7h+WhJbZ4eY1hxf1VLiY+I6BbnSLx807g
         40NAgUiBOagr1U+NiIGKwgEX+Ebn4Ur3C0pMaHQjoHlMToGsAkoG+xrcd5LazgVBZrN1
         prcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BuUqNT2n9D9QoX7OeMV1c1PgkrJJcAuz6uMJAG9Bo/M=;
        b=oFHlhZNPEARgt0RvSjKUseUSfuXujNEbjiH2EYfTVjIJQuH2fsF6UhBqD70wxIohNx
         9h3PJDZfG7daNQhVLL3TZe30kzi+3U5oW8hGQCR98U+ZXNVy6NqCOqv73KPX/0uXtAw3
         PeGGWifaFAlX4qRgx3IUcMqh8SmniDdIDfLLXfC7p0MWtK1uIomVnOp/mqcM9EKZOyRd
         mO5VOESbA6bXB0UKa2DtiZfDxHdbytdYGliNwC79K/hRGFZ+vERodGWHud9aqY1haPrt
         NuGguTw9R1D9YmI6mwyQzrGXTMnTGmMyQHi0dDZiV3JrsvafPzOv31Ek+BXxGVj1J68x
         CaHg==
X-Gm-Message-State: AOUpUlGJEA3diF+QbEfAY1DCKpctq0NyU5TTjpRc3cOAM9kDnxaZyzoz
        L0GyPsxSUKfyUSY7Sd3KuJ4=
X-Google-Smtp-Source: AAOMgpd3uqm9aWUFkobJdPkKn7YU/81hIXk8+WAymvOietgITE0qoDHsyJoDPC1XkZLvIIJn5q4Vrg==
X-Received: by 2002:ac8:2eaf:: with SMTP id h44-v6mr6333655qta.398.1531932899056;
        Wed, 18 Jul 2018 09:54:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id x7-v6sm3788976qtc.66.2018.07.18.09.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:54:58 -0700 (PDT)
Subject: Re: [PATCH 13/16] test-reach: test can_all_from_reach_with_flags
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <95b11ced4c0355aabf458539a284bb3895d73f6f.1531746012.git.gitgitgadget@gmail.com>
 <CAGZ79kYnVxg2XBWa9ib8Ga7iOPE+10sK=ZPwQAYJXMB+Q8tBAg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6c43ef96-a5ba-990b-518a-1992e0907c60@gmail.com>
Date:   Wed, 18 Jul 2018 12:54:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYnVxg2XBWa9ib8Ga7iOPE+10sK=ZPwQAYJXMB+Q8tBAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2018 5:54 PM, Stefan Beller wrote:
> On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The can_all_from_reach_with_flags method is used by ok_to_give_up in
>> upload-pack.c to see if we have done enough negotiation during a fetch.
>> This method is intentionally created to preserve state between calls to
>> assist with stateful negotiation, such as over SSH.
>>
>> To make this method testable, add a new can_all_from_reach method that
>> does the initial setup and final tear-down. Call the method from
>> 'test-tool reach'.
>>
>> Since this is a many-to-many reachability query, add a new type of input
>> to the 'test-tool reach' input format. Lines "Y:<committish>" create a
>> list of commits to be the reachability targets from the commits in the
>> 'X' list. In the context of fetch negotiation, the 'X' commits are the
>> 'want' commits and the 'Y' commits are the 'have' commits.
> Makes sense. I shortly wondered if we want to s/Y/Z/ as I find X and Z
> more distinguishable than X/Y for reading/skimming.
>
> Thanks,
> Stefan
>
>> +++ b/commit-reach.c
>> @@ -593,3 +593,50 @@ int can_all_from_reach_with_flag(struct object_array *from,
>>          }
>>          return 1;
>>   }
>> +
>> +int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>> +                      int cutoff_by_min_date)
> We'll put this method (that is only used by tests so far) here to
> not clutter the test tool code too much, or do we see more benefits
> from the code
> here? If so, docs would be nice.

We will use it later as we reduce duplicate walk implementations, but I 
can hint at that in the message.


>
>> +++ b/t/t6600-test-reach.sh
>> +test_expect_success 'can_all_from_reach:hit' '
>    [...]
>> +               Y:commit-7-3
>> +               Y:commit-8-1
>> +test_expect_success 'can_all_from_reach:miss' '
> [...]
>> +               Y:commit-8-5
> It would be nice if the difference in the list could be easier
> to spot as a reader. (There is a lot of repetition).
>
> Maybe we can teach "test-tool reach" to ignore input lines
> starting with '#' such that we can annotate the last line in
> the miss case?
>
> Why do we omit 7-3 in the miss case? (might be nice
> for symmetry to keep around)

The X-commit that fails to reach a Y-commit in this second case is 
commit-8-3. That commit can reach both commit-7-3 and commit-8-1, so 
both need to be removed.

Thanks,

-Stolee

