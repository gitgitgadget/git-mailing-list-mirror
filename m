Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480641F453
	for <e@80x24.org>; Tue, 30 Oct 2018 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeJ3XQU (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 19:16:20 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:36527 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeJ3XQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 19:16:19 -0400
Received: by mail-qt1-f181.google.com with SMTP id u34-v6so13627650qth.3
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ye9Jxf5T/0slpUix81jxiILHvrWH1N7K2P4DnIq6xNk=;
        b=qwe49LUoL2oStTcH/gyEv7XWIdl2tW8y7E1OtL0trMRSlVPTZKD+F8jkGeHT7CErol
         L0LmhFMBKSju86pODJEQFOgVlH91T4fKq2frcJ5qjnEauWmvualRaAhLcUl9UTQIJX3b
         nhbYMZe2iyEi3hgz1sIBSD6MQI+kiWFFTwcnRQ9jg/L2YkNsbJKAd8gfXsFjmQ2irMLC
         j7NrjQp6XQMchWzU4YUAyBHulfoV50fta1DsoZvpcbEoIaRR7KEiF/MbQPepOk8QN1Fx
         MaI6tpCljUX17HB5r4zacNJw52wT1ImJnrvXImV5XAEHWNWmREznWPu1cI9FdRy+c5h5
         q9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ye9Jxf5T/0slpUix81jxiILHvrWH1N7K2P4DnIq6xNk=;
        b=Xo9uwk6rAqSJ8tBOUAQEs/4Z7JXUxTHP9xP/veOlxUZm5kNhNkbXTmabQG7FcF8in1
         tEs3Ctz88YhW7gd8+2h39TrpcVeW8M534whsIsJVduCAoMpadzZodevnwkiPzQrpJs37
         2ynTBTu50vt1qFOt0YzRjVQ0OopFCksUGHoTLQrbjYO0KXmAsZdEgbC9co4u+s6ptyxA
         PSySLGETaL+tRtefYvI9yZUXqXFHeMH7FX5zJ3JB/vZra1BjwjYrSMp6/VejQ/QHZPOk
         PlgYInQpuA7keblLD4hWdtyIVYjs6Gka4ySsIOuB/CSPAoDykEXcJEqz+DFCZLy9TLUg
         eerw==
X-Gm-Message-State: AGRZ1gJIsNo+DhNzh3pTFZlMQHLVo8kUHSVjYVN+k5pbaBfDX9i2DYzz
        vLvaGk8aHt6j5rKjkbshU99T5gLM
X-Google-Smtp-Source: AJdET5dmejnFnZf5Y72XEe37OfkMamukIg+SU6uAGtaMvc5hmX+c9YOIrlsJus91vxnahRpHatgDPA==
X-Received: by 2002:ac8:6947:: with SMTP id n7-v6mr2345941qtr.326.1540909357845;
        Tue, 30 Oct 2018 07:22:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:51aa:e8f0:335f:de7c? ([2001:4898:8010:0:3ae0:e8f0:335f:de7c])
        by smtp.gmail.com with ESMTPSA id 14-v6sm20591443qtp.12.2018.10.30.07.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:22:37 -0700 (PDT)
Subject: Re: commit-graph is cool (overcoming add_missing_tags() perf issues)
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <302a9351-6133-f562-8c5a-d688d5cc3c88@gmail.com>
Date:   Tue, 30 Oct 2018 10:22:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BECpSOxudovjbDG_3W9wus102RW+E+qPmd4g3Qyd-QDKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 2:00 PM, Elijah Newren wrote:
> Hi,
>
> Just wanted to give a shout-out for the commit-graph work and how
> impressive it is.  I had an internal report from a user that git
> pushes containing only one new tiny commit were taking over a minute
> (in a moderate size repo with good network connectivity). After
> digging for a while, I noticed three unusual things about the repo[1]:
>    * he had push.followTags set to true
>    * upstream repo had about 20k tags (despite only 55k commits)
>    * his repo had an additional 2.5k tags, but none of these were in
>      the history of the branches he was pushing and thus would not be
>      included in any pushes.
>
> Digging in, almost all the time was CPU-bound and spent in
> add_missing_tags()[2].  If I'm reading the code correctly, it appears
> that function loops over each tag, calling in_merge_bases_many() once
> per tag.  Thus, for his case, we were potentially walking all of
> history of the main branch 2.5k times.  That seemed rather suboptimal.

Elijah,

Do you still have this repo around? Could you by chance test the 
performance with the new algorithm for add_missing_tags() in [1]? 
Specifically, please test it without a commit-graph file, since your 
data shape already makes use of generation numbers pretty well.

Thanks,
-Stolee

[1] https://public-inbox.org/git/pull.60.git.gitgitgadget@gmail.com/T/#t
