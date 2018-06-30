Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75A6D1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 01:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935961AbeF3BfX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 21:35:23 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38359 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935851AbeF3BfU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 21:35:20 -0400
Received: by mail-qk0-f196.google.com with SMTP id y4-v6so5982258qka.5
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 18:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xYgkCO4AyEYS5yWM2nL23A7HFmiqP5Ct4W7hED0ZXUQ=;
        b=HopiyaskPBU6uWD7qYoLBYe+fk6QrzIaE+W7Pvtuxec/6FokFVPkH7GcMZDIjgcucq
         5Zgtxs/dTOzPJPhnP/ZcUyUTcWGHYNNAnXhfq2ePOxT2YxtwDEz4yxiHakP1BGGmwUfx
         6ZZQq31BJXrQinbEwHq8ItsbzCSMsZd6rrrPGGCrZ8qSSaNYNl5smFq8VE63VydJ0R3O
         h8IKqSnemWoXQQW6NRvXjEXi0v9hf/ebpVhf47u6iDKbLF5eWJ1sSAndfobzmR7MHPb+
         ZnFtrRsAobuHCWhoQ/b/W19qLPm5alf6NS1Cbqa8tUXEuDvVzb3NG8lk0vkFoWB6MCjo
         ulEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xYgkCO4AyEYS5yWM2nL23A7HFmiqP5Ct4W7hED0ZXUQ=;
        b=cCz0vFsZBrTABfA4F1nV0T99ZlQ83M3idj+4gnlPLUhTSK6Cn3yWjfSTdo9lIz4yNO
         DjVF5T8DAF8B2i6O4uCeKl2BEDK5pO2CKDkeYSRZ/O2uZKf20jVTjirKI/WWOkSGVJvs
         Tz7He27coXHS80gUH2nDz7iPyd4NnPDIS66Oo3ZYu5kSIP4W+Zhab+ynV2TSCq6shLL5
         S+aC1o6hVcpX1I57sv/9+Fyi3tcw5l9JO7GCX5sKFbIztKq5VLLEHz+LkqlFpFHjg4c5
         K7KFEbYtEkFmzhQLzA2MrBhJ+T8C032O8T2INVaAogwhijbz/ZYvwFipZheFK3VhG0D7
         mlbg==
X-Gm-Message-State: APt69E32ojuLrMxO08NBhg/Tgp6YdRPnzyLMMsn826YHDIdgd5o5Ed+H
        sv3jOhX6a89ctl9TszbD1KlGzOQD
X-Google-Smtp-Source: AAOMgpfQReajMOTFDqlonbQTaMQDhaUq1rUjdE3v032BWcI+CicKFEeGHvdfo8fTq6J/lGX8/NHm/w==
X-Received: by 2002:a37:14e3:: with SMTP id 96-v6mr15055466qku.116.1530322520134;
        Fri, 29 Jun 2018 18:35:20 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r13-v6sm8192038qti.70.2018.06.29.18.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 18:35:19 -0700 (PDT)
Subject: Re: [RFC PATCH 06/13] commit-reach: move
 can_all_from_reach_with_flag()
To:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <20180629161223.229661-1-dstolee@microsoft.com>
 <20180629161223.229661-7-dstolee@microsoft.com>
 <CAGZ79kYR1yHxkcDTJh7YoNJydkE_WhdL1mdMKL3hDXgEk+gLxw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc1572df-8b56-9010-000f-d1c14a68c016@gmail.com>
Date:   Fri, 29 Jun 2018 21:35:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYR1yHxkcDTJh7YoNJydkE_WhdL1mdMKL3hDXgEk+gLxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2018 5:47 PM, Stefan Beller wrote:
> Hi Derrick,
>
>> +static int reachable(struct commit *from, int with_flag, int assign_flag, time_t min_commit_date)
> [...]
>> +               if (commit->date < min_commit_date)
>> +                       continue;
> [...]
>
>> +int can_all_from_reach_with_flag(struct object_array from,
>> +                                int with_flag, int assign_flag,
>> +                                time_t min_commit_date)
> Can you expand on why we introduce the min_commit_date in the commit message?
> (It looks like a rebase error as I would have expected a move only,
> given the subject)

This is a case where this should have been two steps:

1. Remove dependence on the global 'oldest_have' in upload-pack.c by 
creating the min_commit_date parameter.

2. Move the code from upload-pack.c to commit-reach.c.

Thanks,
-Stolee
