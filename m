Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6757F1F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbeDXUbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 16:31:32 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:39031 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDXUbb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 16:31:31 -0400
Received: by mail-qt0-f172.google.com with SMTP id f1-v6so6790308qtj.6
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2U1cacgWzBRQii7rYJbuLcMHSF+eabqgZ+RRbfxBCvs=;
        b=sXFdIppQ9QaYTiEm5CrwAkes158LXarO1BcOredmCjbwXjvTmSWJHwDiwbumWjlftS
         INqpX+2rLsL6NhyMLISLGgd0iJhHryMZIh4bnMsZJDT2RiRpgK5H/ZLeEB9DV9C/YYuT
         C7hIrLrihw3oekjBKqfiDYleeLQtOlv35l3ALs0XRBIy7T/T6Lr51wVrxhWL/vpjEzT1
         GYdHEHKpR8PIbI+obaU87U7BuyHP5KawM49RXYSDVpfB1STHNMsGwA3sV692AMUYdIBV
         z0UlUPL5VtM5eOviM6EI2W+UO7A/KRekliNm4fHJ4gwwGO77EYnQp/O5drKJ2jBC14wK
         7d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2U1cacgWzBRQii7rYJbuLcMHSF+eabqgZ+RRbfxBCvs=;
        b=eeStl0F/UN5LF4Vsq9BhTvcocRTs02l5TRttYm7dU5Ty3AFQ3ZtgZzSDkEgtlhuMhg
         9oqDTVw5fiz/ztM5Yu/t4Ezsog6eC/Bu35HGw8bzJ8o0zOArSErf1L0uXrQdBlnO2K8+
         0e5Kc8c97ubpcAtGtsFqD88ve4syrlT7gag0Y7H+RjV3WVKVDTBCdJp3ME10JFs/hcBg
         qs6SF+k5GNAa8V3Q7t7995qbZKBt6lWOvaNeHIOVYjjTaHn4Zk0gXZNbfEEhMi5idNN/
         xn/wuK0UJOeS1saZNvVcNBpFOnxdIzUGJONkvW7omm/bCvzB/uuiVyaY+fjMYwF0bxpx
         loIw==
X-Gm-Message-State: ALQs6tCqFOI2gdw9rLSZtm11KMg8mcsnYUfjzRxlmYFT8MsiTa8RpMWk
        K50DIfxS+vkNyrenejSvYt4=
X-Google-Smtp-Source: AB8JxZqIgisqZuEvRmKXWf9bB7co+jGon4GGYVbfhiumVAkJcuVR/65zx2qPbKIFDv4UcJu+oe9yGg==
X-Received: by 2002:aed:22e5:: with SMTP id q34-v6mr22799431qtc.403.1524601890341;
        Tue, 24 Apr 2018 13:31:30 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id g67sm7370551qkb.51.2018.04.24.13.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Apr 2018 13:31:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] merge: Add merge.renames config setting
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com>
 <20180424171124.12064-2-benpeart@microsoft.com>
 <CABPp-BFTywvVFV3Wx1jv9RyoFk_cE7XE8x1neuLVt4qwyw0EMw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <68fa18c0-1dac-f6dc-0c41-fa5722c2c227@gmail.com>
Date:   Tue, 24 Apr 2018 16:31:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BFTywvVFV3Wx1jv9RyoFk_cE7XE8x1neuLVt4qwyw0EMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2018 2:59 PM, Elijah Newren wrote:
> Sorry, I noticed something else I missed on my last reading...
> 
> On Tue, Apr 24, 2018 at 10:11 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index 8746c5e3e8..3be52cd316 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -424,6 +424,7 @@ static void finish(struct commit *head_commit,
>>                  opts.output_format |=
>>                          DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>>                  opts.detect_rename = DIFF_DETECT_RENAME;
>> +               git_config_get_bool("merge.renames", &opts.detect_rename);
>>                  diff_setup_done(&opts);
>>                  diff_tree_oid(head, new_head, "", &opts);
>>                  diffcore_std(&opts);
> 
> Shouldn't this also be turned off if either (a) merge.renames is unset
> and diff.renames is false, or (b) the user specifies -Xno-renames?
> 

This makes me think that I should probably remove the line that 
overrides the detect_rename setting with the merge config setting.  As I 
look at the code, none of the other merge options are reflected in the 
diffstat; instead, all the settings are pretty much hard coded.  Perhaps 
I shouldn't rock that boat.
