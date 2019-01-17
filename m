Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DD561F453
	for <e@80x24.org>; Thu, 17 Jan 2019 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAQP1D (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 10:27:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34154 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQP1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so11762325qtp.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=5dj86O/auJ9U36Y+oTPCjyWBzil08vzBYsv2t1IW/q8=;
        b=CD51TT00xDjSt0ldmAu3WTEds2dol1h4QOU1djUOVjrCQIQU1aD/6m16ahzNNu5y3y
         LbgpAww9WW5/48nTjg7/aTEEuV1eK015VtUBf0rhgNl9VxtDRQAtmZN4/udfoIOrlA96
         WEHPT/YbiepFKvw1Rm8w+wBShjgrezaAIOX6GVPkGJcg9UiU4lBWyxHughSFzvgLlmE8
         ziZ32UMFrHjfGL55SdHP4pbyydRW8LcCyWy3gbgusUmtWumvZRaG/mpBqojyWGfcZ+XY
         a3vzs6e18kB2cxEQLYMS9X8Y8EhCcPri5O8yitJFztmBpO+/ntuDTtuslh8RD4zoXJ9Z
         EjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5dj86O/auJ9U36Y+oTPCjyWBzil08vzBYsv2t1IW/q8=;
        b=n+iOKcAMX90gzrJB8LAu5CYGCBTFRRGCZCwSqD+kgRA8i7MGwrZ5nx8cXjA0ffU74Y
         dZruVqyBtYeJx3LMkdaourdcuobfwx+0hLWvXq/MKSBi3bGfozMdyiCvhNR/wgNuyCte
         mVIQB94ZnglneBGuojWWRDEXG1nKDYJV4G/2Q3ilDyaLvXY3uPoivWkL3Rg0FxUsEErJ
         OJAw1ZhsrFKuDl13O61g/O+3fEH3JJtcX5dhdK7hthMmTbMwRzxfC9X+Xlwr9JnY7jTK
         ZMNttcNlCQkwtNtU1va6DZO5a18VcVM0PLzhBUWEl3sVchRZE0rlZv4LpvtyD+JU5QBL
         626A==
X-Gm-Message-State: AJcUuke8JN/+nicRBjl8I3V/fNad4nozFGgXyYSYWnomY3VAUXeo96/f
        5KdHwK/gqKSubT4AwT4Ufr8L7ioT
X-Google-Smtp-Source: ALg8bN4PbMdVrdoiSNW0mR0j41SjW5sgsHlo5FkX3nAzG+PQtVQS+nzPlkiNdktGLoGQYwOJRxMG1w==
X-Received: by 2002:ac8:7016:: with SMTP id x22mr11615604qtm.325.1547738821803;
        Thu, 17 Jan 2019 07:27:01 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c447:1d70:84f9:bac9? ([2001:4898:8010:0:ad7d:1d70:84f9:bac9])
        by smtp.gmail.com with ESMTPSA id b51sm64394848qtb.32.2019.01.17.07.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:27:01 -0800 (PST)
Subject: Re: [PATCH v3 0/9] Create 'expire' and 'repack' verbs for
 git-multi-pack-index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
 <pull.92.v3.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3aa0a7ea-6c30-2c61-0815-2b9ab8304564@gmail.com>
Date:   Thu, 17 Jan 2019 10:27:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've seen comments about some leftover uses of the word 'verb' instead 
of 'subcommand'. I can definitely clean those up, but I'm hoping that 
more comments could be made on the technical aspects of this series.

Thanks,
-Stolee
