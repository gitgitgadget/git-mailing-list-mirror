Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF02D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI0VrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 17:47:04 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:34640 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeI0VrD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 17:47:03 -0400
Received: by mail-qk1-f179.google.com with SMTP id 80-v6so1860084qkj.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Bk/oKARiri7058J1qmN08i/dml+Fcz2IuAkG6rYUyjo=;
        b=kBPbUkd3HduFOj22oSaUh6K/poCaL35E/4FALsnwaQdK/GXUW/dc5RW7wTnOVDZP+I
         UcgEFV5dSBrJnJhue4xUs4wWmZkuUs5/7WoiajWMpKjMFGVIDzYfIYimlV7l3gF+qxex
         1VhIa7Z8k5b19OLclnyY3neMZMyfvkCD3A51waDpOUMloiHlu/l8gCRLBSpWf7v8apAH
         OnarUdkNH1D9f3EEn3ct1hKLfAQg+1n93DfFyTXAAEdSmrxnjJIr90RmH8gC2Q0Kt5V4
         jpiu4shpQFctD90/v4Qi6a9tCZnoFI+mdwB2cntJVwIZIswXuyXIrJsOgrd1CmpDTkHF
         8WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Bk/oKARiri7058J1qmN08i/dml+Fcz2IuAkG6rYUyjo=;
        b=rTBQMFtJJO44euuBZezb2PjgvyDVOsUV5odhjvpo0ox9kYKy4bDsFsI/eggc7Ia4Wr
         RrWaZf8vajejWvrDRy4fPRSTp+830qgB+aT1xRsIiipKDfkSIJyvk7Yoci6RmdFJDBKZ
         2HB8IfQzoxXqwgp9u91LjjDnZ8lM+lwAwaXqchXSUZASNtaUppiqC06ltYZi43mf4cqw
         py2I3l61ZNtcITJNtOXWd+nXmGdjJbqjXfTV2dXhkG494d2h+4Y7g/dw+pkzV0TpRclD
         lmToGzkjd8Z6pGmuYyklEKY7C4shrkNl5DmQbOI3OPFXINuZo2gUL+wZmdQjvP1RBTXI
         yEhA==
X-Gm-Message-State: ABuFfoiSJbVwAx+4yWFiz5NnuIRFu3zjqUUC5pWgx42L1O3rwmcxyAo5
        vQCmGDpv81sYRhxNVjuLMgBKCIqY
X-Google-Smtp-Source: ACcGV635/xWOFukKfm17/zpUxjXGe0FPxEgUv40fcE32maeyM6J+VfmuRrTG2ayypd/TR5lqwa1TYA==
X-Received: by 2002:a37:4904:: with SMTP id w4-v6mr8074049qka.85.1538062095920;
        Thu, 27 Sep 2018 08:28:15 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1455:e436:6b50:1b07? ([2001:4898:8010:0:fd8a:e436:6b50:1b07])
        by smtp.gmail.com with ESMTPSA id i9-v6sm1272738qtp.50.2018.09.27.08.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 08:28:15 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Tuesday, Sept 25)
To:     Ben Peart <peartben@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <4bcd63bf-648d-f3f6-dac8-aabe7ea1e480@gmail.com>
 <d92f18e2-0bbc-e36b-123a-3ed3f44cf418@gmail.com>
 <b46d6363-1709-968e-105a-3f4e8a77155e@gmail.com>
 <20180926184308.GA2253@hank.intra.tgummerer.com>
 <a7228cb5-5085-e1c7-0731-d37b19cdc3bf@gmail.com>
 <225dc2e3-1aa0-ac19-26e6-59b54dfe871c@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07ab14bb-766b-e375-989b-73974ef7fece@gmail.com>
Date:   Thu, 27 Sep 2018 11:28:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <225dc2e3-1aa0-ac19-26e6-59b54dfe871c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2018 11:21 AM, Ben Peart wrote:
>
>
> On 9/26/2018 2:54 PM, Derrick Stolee wrote:
>>
>> GIT_TEST_INDEX_THREADS=1
>>
>
> Because the test repos are so small (ie smaller than 10K files), the 
> test suite already executes as if GIT_TEST_INDEX_THREADS=1 is set (ie 
> single threaded).  I added the test variable so that the 
> multi-threading code could be forced to execute in spite of the 
> default minimum number of files logic.
>
> I'd recommend you set GIT_TEST_INDEX_THREADS=3 instead. (3 because 1 
> thread is used for loading the index extensions and we need 2 or more 
> threads available to exercise multi-threaded loading of the index 
> entries).

According to t/README, GIT_TEST_INDEX_THREADS is a boolean and setting 
it to 1 causes us to use 3 threads:

     GIT_TEST_INDEX_THREADS=<boolean> forces multi-threaded loading of
     the index cache entries and extensions for the whole test suite.

Here is the only consumption of the variable in the product code (in 
read-cache.c):

         /* enable testing with fewer than default minimum of entries */
         if (istate->cache_nr > 1 && nr_threads < 3 && 
git_env_bool("GIT_TEST_INDEX_THREADS", 0))
                 nr_threads = 3;

This was non-obvious to me, and I had originally set it to a larger 
number. I happened to notice the boolean nature while I was looking up 
the rest of the GIT_TEST_* variables.

Thanks,

-Stolee


