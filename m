Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C8481F516
	for <e@80x24.org>; Fri, 22 Jun 2018 18:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934006AbeFVSin (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 14:38:43 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:44533 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933820AbeFVSim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 14:38:42 -0400
Received: by mail-qk0-f194.google.com with SMTP id 185-v6so4202378qkk.11
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/ty/ROTonCu8j5TeKSj8Q5r7s6VOXsBv/+qA4XO/ClI=;
        b=fyHYhzYjOSWtB3gGJw0tFeNbA0Zs/gcRdQ6FFZv8qvA5EjZ1tP9giSt5QdmtOBO4fN
         VVFGdFzjeJI6/Y7vli+1jveVs7QaD/+UvwzGHY4rAqTal+qEfbrSgEBqw2Ga4ilW9dSD
         frWxzHuEX459qDSqCfqO5xkcDWo42sJIgbHm9d3qwZvgtXXrgsCqFjKEX5ThwZnf7+CH
         pUZAfWnkQzuXnVfQEnGEIIjrC4eodYtUCTdaWEG4omthuYuV1pW9q+nKRb7Fkk7yIYll
         cVIVLHtAxGS4mNTyoXBw5BWF44SPYcyDhbx4mT7UZZM50PZaK5lgYFNfQ7MlI24ZlRVn
         V9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/ty/ROTonCu8j5TeKSj8Q5r7s6VOXsBv/+qA4XO/ClI=;
        b=FX5XY63k7OcIcqrvYWB1dSERHVZtuCWRklO/zbm50UQrDNZxoXmkD4+cTJe3CYZy5Z
         UxtthZ4vNOtXXOZ0lIU0xSmRIRxhQNWImiyydgzEbIhMTz4Ralbnx5kmddVfNbJmoDtp
         Gdwe7CkcD5OQjxmRuk8v1BKYxk/lzJXaBca0VVvP4poUJoPUzvk4JpFNy2C8kHN7TFaS
         lhMpVqjQMvaS0GIuUUa+av9mWtdCY9GR+2OCK6/yEqUfKfI980EEjIQkgRALZujAp3Qz
         hRI/iFy9x2YI0foEWXQmNpbtSvAAj+AL73R83vk7GguP8l1UE7F4TFgePcBvFEWnPAFX
         7WEw==
X-Gm-Message-State: APt69E1emQP3d84hXQ/TkR0JuHANTIi+JTUvJ6qgTrmQdnhsf76cRM0D
        Vh4JRtjGpaZgBKbQjj2pgTg=
X-Google-Smtp-Source: AAOMgpdiPYTndWDUhEwgWcQvcpvJ3AQ2Lq6DyibVH4B07dUcT0O1ymOSDqFQvz2J6v7WPkp0j7wF6Q==
X-Received: by 2002:a37:1099:: with SMTP id 25-v6mr2308252qkq.52.1529692721562;
        Fri, 22 Jun 2018 11:38:41 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:355a:cab3:6059:73ce? ([2001:4898:8010:0:1e90:cab3:6059:73ce])
        by smtp.gmail.com with ESMTPSA id g57-v6sm6314881qte.52.2018.06.22.11.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:38:40 -0700 (PDT)
Subject: Re: [PATCH 18/23] midx: use midx in abbreviation calculations
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-19-dstolee@microsoft.com>
 <CACsJy8BQ5xxhQ8L9K84KO2EkYELsKKKkdJ0mvc8p427sA8bapQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56acee9d-ff91-94d7-3bbd-4089e8775c14@gmail.com>
Date:   Fri, 22 Jun 2018 14:38:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BQ5xxhQ8L9K84KO2EkYELsKKKkdJ0mvc8p427sA8bapQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2018 2:01 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>> @@ -565,8 +632,11 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>>
>>   static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>>   {
>> +       struct midxed_git *m;
>>          struct packed_git *p;
>>
>> +       for (m = get_midxed_git(the_repository); m; m = m->next)
>> +               find_abbrev_len_for_midx(m, mad);
> If all the packs are in midx, we don't need to run the second loop
> below, do we? Otherwise I don't see why we waste cycles on finding
> abbrev length on midx at all.

We put all packs _at time of writing_ into the midx. More packs may be 
added later that are not in the midx. There are tests in 
t5319-multi-pack-index.sh that verify everything works in this "mixed mode".

It is important that the packfiles are not loaded into the packed_git 
list if they are managed by the midx.

>
>>          for (p = get_packed_git(the_repository); p; p = p->next)
>>                  find_abbrev_len_for_pack(p, mad);
>>   }

