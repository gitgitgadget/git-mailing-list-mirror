Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D694B1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIFAK7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 20:10:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44340 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeIFAK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 20:10:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so9506446qtk.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cgXx0n4qovhtK7cREeTTX5/iPEICyqhzmVNcQIn9KDc=;
        b=OscBNmFDnobogtyoSvbx2mjdUg1xdpFgwTsMZLi7ZxAXyIkPnXEAkd93BwGCN5dhL+
         /D12EBYetAkV4pEDNoUNtI7YmI5UFJewr3HP/2hj8/icZA7eb/e7mZMq07wi7OGT6SaO
         TRPcw2RB4kHaFD/nuzSq/njvQ8TW+3snGnukzGQQgIKsgpwe8wtOt0MfBMaqeAu+pMHV
         tiDSOqKleA1p0cBYXsia/pY+BpKeMY07bUDx5UOAwnBy/8OOCPJhAsCI+4q0Gj9LayXB
         XI3RwclUWPHIQePCF9pqWplZk1ZGTuhlPc3kYly+KvoNniPL7r9+Hr8AFw0XOhnQfskB
         BZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cgXx0n4qovhtK7cREeTTX5/iPEICyqhzmVNcQIn9KDc=;
        b=HO6NtxJMzh1CzgZVA/Zj7mrlbfHx1Tsta7Ez2ayFkeXAWI99qe+cdBAOEkISzv2kLv
         gP2U2qsX8H9muvIcO9GtwxF2Yw44KiMzlCrQBEeTAfd9CRqzIK4fRfDJyA1d52e8MCbL
         Zc3cvhAK1fz1sJ5EBeRL5jrj8wCZsvbyRsELc8rYS/v3/AiF6USq8HAwnBcmksg6pHEw
         w3bSx7zqgsSH+iZAGv2s2ZpEEZfFzgr6BUA04ESoMfpRqqT1eXx2b2dhvn+WJ6gXJbwS
         a/FnJZ57O756KZOvABYipQijuiVGylWrlPpQnmhQX08pt3+GFHHPa7eXMBqA7sVqSzZV
         NqNQ==
X-Gm-Message-State: APzg51B1ZxlzUucirD4DTvR+RCno9WEveyAyZDVOqu2M1A6ZVWf4GY/j
        LSl7aI78+sX7EJspdKq6xI8=
X-Google-Smtp-Source: ANB0Vda0j5wrtCecKSzQJ9jzgQoERICMhsiYeIgVcEwbXODgBYmIZh2f4WJogzHxMRA5zRLaghGQ9Q==
X-Received: by 2002:ac8:30eb:: with SMTP id w40-v6mr34497869qta.176.1536176360596;
        Wed, 05 Sep 2018 12:39:20 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id d138-v6sm1486757qke.18.2018.09.05.12.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:38:31 -0700 (PDT)
Subject: Re: [PATCH 01/11] multi-pack-index: add 'verify' verb
To:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.34.git.gitgitgadget@gmail.com>
 <8dc38afe2b4d73e940daf9a0ff7f9c0a38802d95.1536158789.git.gitgitgadget@gmail.com>
 <CAPig+cR4vEcMBe4REd4Z=WMG-MR4PUnyNNBxoJacUXzB8ho6fg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <81279be3-6d9a-ae39-a5e9-399fd4be2a23@gmail.com>
Date:   Wed, 5 Sep 2018 15:37:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR4vEcMBe4REd4Z=WMG-MR4PUnyNNBxoJacUXzB8ho6fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2018 2:59 PM, Eric Sunshine wrote:
> On Wed, Sep 5, 2018 at 10:46 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The multi-pack-index builtin writes multi-pack-index files, and
>> uses a 'write' verb to do so. Add a 'verify' verb that checks this
>> file matches the contents of the pack-indexes it replaces.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
>> @@ -5,7 +5,7 @@
>>   static char const * const builtin_multi_pack_index_usage[] = {
>> -       N_("git multi-pack-index [--object-dir=<dir>] write"),
>> +       N_("git multi-pack-index [--object-dir=<dir>] [write|verify]"),
> Nit: The square brackets make the verb optional. You probably want
> parenthesis to indicate that one or the other is required:
>
>      git multi-pack-index [--object-dir=<dir>] (write|verify)
Thanks for catching this mistake! This would be easy to miss and keep 
around forever.
