Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 118591F453
	for <e@80x24.org>; Wed, 23 Jan 2019 01:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfAWBTa (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 20:19:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44782 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfAWBT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 20:19:29 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so579403qte.11
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 17:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I/Tz7GlaqwfawjHwy5z29L6eI8oWt3QVJezQlcfBd6M=;
        b=TOW4OfTuFRbLCRaVauTRM1PL783f7rzOw/h8CP5E1jRvxdkGrxlqhUMdbZHFjHSpzT
         hgoi7YNtZ1yCcS7GruuYkEcl8y2qKH/8UHwNzd7Xz/8x3/jRUlVZNKXP1jcaE9rHqLNt
         h4Rs3TCYYq6mAVOhG0pk7AlT0grAbNsXvgD6wg4WcUMlyIG4XakXplUaf38fQ5x9Zerg
         TBKGzv86opBv2QPITdB5N7al5aQ4Pv8uFvp8MjW0EGdzuK9EufWAlMUKqKaGV5uDhJgY
         usJXEVe+F6n79dzxo/dluq5kdu9y2hHwvFmEX8+MICQdf9K7Y15O/l8or5V3umZJV/8H
         BOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I/Tz7GlaqwfawjHwy5z29L6eI8oWt3QVJezQlcfBd6M=;
        b=ryt2ExAjH837JmXroZW2DO+1jGi87HIRSR52QpHd9BN5uq/QXZQv72ND5gCexECTeg
         zw4JoWfjU1bcs9zDyG8xkWLV+4TVALmBPO4bSKCbUp9S3Cw2QfmazXl35FcDD+WZFuZy
         tJQK+YR+TiwfjbEO4WgNnVlx3H0YBs3D8tR4zXuyTrF07KU4yxiLl5LCQygREQWH+xqN
         vwk0+CmUUpuAqGvCbz+0Llz5w/mSanz5UUcVgRrVV/3SCYjMZjlhl4jPcEkWb3UCvmJG
         A8XZqsocSIfFZZ+j8F9+wCHY61+CCFEhoV97/c1QwebqytpgDDEOAGAJegQtg9Wp9QuO
         gITA==
X-Gm-Message-State: AJcUukcjBTKm0samQgeMeRVkI5iQkXDjoW24MXNFroVxfZVmdMnIG0tH
        in+dwNGql2zg6nXyWCrZRos=
X-Google-Smtp-Source: ALg8bN6uUpavE4PIXC8IptAJgttADHC6CjBCHTnE6beYwRMRenavjVUjHqPtp4kPlZ6olD90VvZWwg==
X-Received: by 2002:aed:3324:: with SMTP id u33mr211549qtd.161.1548206368710;
        Tue, 22 Jan 2019 17:19:28 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id v1sm66069006qtj.68.2019.01.22.17.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 17:19:27 -0800 (PST)
Subject: Re: [PATCH 10/14] pack-objects: add trace2 regions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.108.git.gitgitgadget@gmail.com>
 <1aa79cb126ec43dae1c01d3ce740d9b687d69517.1548192131.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <75ceaf05-d479-67f8-3684-c8ba948f2bda@gmail.com>
Date:   Tue, 22 Jan 2019 20:19:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <1aa79cb126ec43dae1c01d3ce740d9b687d69517.1548192131.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/22/2019 4:22 PM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When studying the performance of 'git push' we would like to know
> how much time is spent at various parts of the command. One area
> that could cause performance trouble is 'git pack-objects'.
>
> Add trace2 regions around the three main actions taken in this
> command:
>
> 1. Enumerate objects.
> 2. Prepare pack.
> 3. Write pack-file.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

We've had this patch in our private branch for a while, and is how we 
discovered the need for the sparse push algorithm [1]. We will use it to 
measure it's effectiveness as new Microsoft users onboard to the new 
algorithm.

Thanks,

-Stolee

[1] https://public-inbox.org/git/pull.89.v5.git.gitgitgadget@gmail.com/

