Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1351F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeGLN25 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:28:57 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35618 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeGLN25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:28:57 -0400
Received: by mail-qk0-f193.google.com with SMTP id u21-v6so15387979qku.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lZOGKpM9HQTivKI+zwBffdkT16zmSFAKs3oT0vYYb5U=;
        b=N9CKvxaFPyjlD5JIJLdSZVwbmTTMcNJQtX+6cXf1Z+ET3cLXALxhmkGQtVZ8C1DY+w
         aer1rWhtA3OekM30XVqqui9esNv2dpkrIyhk+3+HquwsP8b00W1wy5/I11PFu7gdcz1o
         lqV8L0oLyzr2AXaSJ66n0WsCBz/TxaPY7YRgrkwh8musLHtqemXz4BywRoMUxBjEgivb
         Rixr/LOtDFCYrnGRtlH22WUVb3N82bmPRAjtYRY3BzIIsBdxCm0ZGtTq6JnU+wvAy9eE
         Mr+hcGda/A1HEw2qf/Yn2ZpUHmk49Y5WfkAHu8+Uef+suDjz3b4Hd6H+MBXTDyAbXqLN
         3Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lZOGKpM9HQTivKI+zwBffdkT16zmSFAKs3oT0vYYb5U=;
        b=BKndcGP/cu08SvuA3D49KNhLEGU0YAGKHHu3Kl5yYkdmvFNMrpigymCQVPYIAmwJI7
         pWt+l0Ar9DhDcL+cyW62odiafQlQY08MvrMv7xrmcO0HJMGfNSWxguzNcfN2zSWImopT
         OVo87LLaG3sZhk8wEPij6GK55L/w6I9tbcIY+jECcqUgARAWawh6NBjpcuNusUcUuD4C
         9Z3VkBEING6xc/G5+kTCjLeEPuWZThqgcokheNeLD6MxAx3+syEve9RZL1OlVzCexjOG
         xwyx2tQS5uVNVhv1Oi/JTW1dZTeQ/oa1dVX7RDCzQo7m/gyc+EZhWKXOEItD0eapnIQd
         od4A==
X-Gm-Message-State: AOUpUlFtRkfF3Ow4OphMGuFxnOjpgHkjVd/ey7dEsY+ZRAQyPdhs1ogc
        SI3VUZ/FO9SI6/1DFrgWzu4=
X-Google-Smtp-Source: AAOMgpeAL1ee0CHGP09WcIVInkmYHfVm0Zceg45ZAyWICZW4zYjLhldEOQ0VIzc/VN5sykxap+hX9g==
X-Received: by 2002:a37:67d5:: with SMTP id b204-v6mr1660311qkc.108.1531401564034;
        Thu, 12 Jul 2018 06:19:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d4d2:4c73:ca82:12f0? ([2001:4898:8010:0:be08:4c73:ca82:12f0])
        by smtp.gmail.com with ESMTPSA id f97-v6sm4224302qtb.39.2018.07.12.06.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 06:19:23 -0700 (PDT)
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
 <20180706005321.124643-17-dstolee@microsoft.com>
 <CAPig+cTJuvOjyzkmAj5axAkS3q1UyeV03jQk6-oB==KyzbEK_w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2270ec32-f5e3-e23a-5605-f5f0e7a44c46@gmail.com>
Date:   Thu, 12 Jul 2018 09:19:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTJuvOjyzkmAj5axAkS3q1UyeV03jQk6-oB==KyzbEK_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/6/2018 1:39 AM, Eric Sunshine wrote:
> On Thu, Jul 5, 2018 at 8:54 PM Derrick Stolee <stolee@gmail.com> wrote:
>> The core.multiPackIndex config setting controls the multi-pack-
>> index (MIDX) feature. If false, the setting will disable all reads
>> from the multi-pack-index file.
>>
>> Add comparison commands in t5319-multi-pack-index.sh to check
>> typical Git behavior remains the same as the config setting is turned
>> on and off. This currently includes 'git rev-list' and 'git log'
>> commands to trigger several object database reads.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/cache.h b/cache.h
>> @@ -814,6 +814,7 @@ extern char *git_replace_ref_base;
>> +extern int core_multi_pack_index;
>> diff --git a/config.c b/config.c
>> @@ -1313,6 +1313,11 @@ static int git_default_core_config(const char *var, const char *value)
>> +       if (!strcmp(var, "core.multipackindex")) {
>> +               core_multi_pack_index = git_config_bool(var, value);
>> +               return 0;
>> +       }
> This is a rather unusual commit. This new configuration is assigned,
> but it's never actually consulted, which means that it's impossible
> for it to have any impact on functionality, yet tests are being added
> to check whether it _did_ have any impact on functionality. Confusing.
>
> Patch 17 does consult 'core_multi_pack_index', so it's only at that
> point that it could have any impact. This situation would be less
> confusing if you swapped patches 16 and 17 (and, of course, move the
> declaration of 'core_multi_pack_index' to patch 17 with a reasonable
> default value).

You're right that this commit is a bit too aware of the future, but I 
disagree with the recommendation to change it.

Yes, in this commit there is no possible way that these tests could 
fail. The point is that patches 17-23 all change behavior if this 
setting is on, and we want to make sure we do not break at any point 
along that journey (or in future iterations of the multi-pack-index 
feature).

With this in mind, I don't think there is a better commit to place these 
tests.

>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> @@ -61,12 +63,42 @@ test_expect_success 'write midx with one v1 pack' '
>> +midx_git_two_modes() {
>> +       git -c core.multiPackIndex=false $1 >expect &&
>> +       git -c core.multiPackIndex=true $1 >actual &&
>> +       test_cmp expect actual
>> +}
>> +
>> +compare_results_with_midx() {
>> +       MSG=$1
>> +       test_expect_success "check normal git operations: $MSG" '
>> +               midx_git_two_modes "rev-list --objects --all" &&
>> +               midx_git_two_modes "log --raw"
>> +       '
>> +}
> Here, you define midx_git_two_modes() and compare_results_with_midx()...
>
>>   test_expect_success 'write midx with one v2 pack' '
>> -       git pack-objects --index-version=2,0x40 pack/test <obj-list &&
>> -       git multi-pack-index --object-dir=. write &&
>> -       midx_read_expect 1 17 4 .
>> +       git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
>> +       git multi-pack-index --object-dir=$objdir write &&
>> +       midx_read_expect 1 17 4 $objdir
>>   '
>>
>> +midx_git_two_modes() {
>> +       git -c core.multiPackIndex=false $1 >expect &&
>> +       git -c core.multiPackIndex=true $1 >actual &&
>> +       test_cmp expect actual
>> +}
>> +
>> +compare_results_with_midx() {
>> +       MSG=$1
>> +       test_expect_success "check normal git operations: $MSG" '
>> +               midx_git_two_modes "rev-list --objects --all" &&
>> +               midx_git_two_modes "log --raw"
>> +       '
>> +}
> ... and here you define both functions again.

This was a mistake. Thanks for catching it.


Thanks,

-Stolee

