Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45131F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIEXn2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:43:28 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:38797 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeIEXn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:43:28 -0400
Received: by mail-qt0-f181.google.com with SMTP id x7-v6so9436436qtk.5
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pis9p4e3t6OEqTtinX6AJEhVS7SKz3F5NZq5UbwoyrU=;
        b=mVaHQEEa/yrsq+xHuLt5Rs/yyVxmWEBbnT25CBDgx4ChgIkZs8yklB2Qo9Yw2RN0tD
         8ElNDvBwQV3ef8moEcT8fEYysAGuO4492gO7D5rC32SBwJDHu0P/TlIL95piam9Bn55c
         UZv70klUo3hr8nY6d8LRAY684BON37s/1x4ZO6hF1oan5DKIL/oEsU53XA/p2K+Gf7q/
         rTPGqt3t0y8bXgWYP9xLrRZ0bvyNJdkLvZejvzgaTp0O4LX5JCwbMQNs4gKT1B9wIx9P
         gxOMSaOlmdyZvW82dRRe8j08+9DLM5Gj4PgqisNjupsweZ1Cgt+ImtA5XEzCXG2XF0jf
         j+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pis9p4e3t6OEqTtinX6AJEhVS7SKz3F5NZq5UbwoyrU=;
        b=gvd/6xEeudLAI3rvSFf4CJvSWQlL4LUAQvTzdW/f6b++niwpY+fOUbiIDyDEsqstaE
         wL79uwc7oNdzvdYpytqOmy/rG8JwcVu7p1F/vbOtQunrtcDZbdhQ5oby6xYINa5mV4Th
         SZ84dpvemeO/FsJOHIqphn4lDJ/eSGgOwrtuMe7KTVT5EDMM1KUQ+dm3DP36+hCV/0gu
         BIZeqmEriV+PAl53W794k/0y2Tyqs2TJJ6KhGAzAbCWPccUi8fc9yxa2nlzZOt+Dh7/m
         I3nhfC4+cgC/mslsWAAFw0rZX/iv7Ttm3zCSHDbFvi8l5Syni0Onj7DnQk78ITCieptl
         OUBQ==
X-Gm-Message-State: APzg51AVz3GLrX6m8Z8WovLOOnA0c0RFpDSTy0k18gVknsnliBrDtrXO
        w55o2/0X4rgiCIEWPrd96Bo=
X-Google-Smtp-Source: ANB0VdYHYC23dHT3eDg2qf+vf8QiRJyemndGcOiKHDA8sAUO8xMCBLXuOEBXifkAjlAre9b8WsOkFQ==
X-Received: by 2002:aed:2285:: with SMTP id p5-v6mr35746724qtc.48.1536174716169;
        Wed, 05 Sep 2018 12:11:56 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u72-v6sm1773925qki.89.2018.09.05.12.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:11:54 -0700 (PDT)
Subject: Re: [PATCH 04/11] multi-pack-index: verify packname order
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.34.git.gitgitgadget@gmail.com>
 <37ee24c82bf88611808ec3bb1c36eef439c809db.1536158789.git.gitgitgadget@gmail.com>
 <CAGZ79kY7_RJfJomkpob85A4ubvXJt3BR8njkaozLgi-6ytxB9w@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <da7eaf92-57f6-8129-149d-4260d84b4eb0@gmail.com>
Date:   Wed, 5 Sep 2018 15:11:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY7_RJfJomkpob85A4ubvXJt3BR8njkaozLgi-6ytxB9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2018 2:15 PM, Stefan Beller wrote:
> On Wed, Sep 5, 2018 at 7:46 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The final check we make while loading a multi-pack-index is that
>> the packfile names are in lexicographical order. Make this error
>> be a die() instead.
> What is the advantage of having a die() here?
> Would the midx work under normal operation when
> not sorted correctly?
>
> This sounds like a hack for easy testability in this context,
> so could you clarify why this helps the regular user?

The multi-pack-index will not work as expected, since 
midx_contains_pack() may provide incorrect results, and thus we will add 
the "missing" packfiles to the packed_git linked list.

This _should_ be a die(), as something unexpected occurred (the file 
doesn't match the format specification).

