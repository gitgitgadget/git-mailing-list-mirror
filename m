Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11D1C20A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 17:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbdITRLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 13:11:23 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:43213 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdITRLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 13:11:21 -0400
Received: by mail-qk0-f174.google.com with SMTP id j5so3394267qkd.0
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jxgOxY4B08EjHhrJifqAl9w2afbpnhHcJ3tCVglLepQ=;
        b=lWR61+30JHsxBsIkUnBjk6+AzMrOsA4kn+6d635fgA2A6pJe3U6fbJt5uWj+HSW4gZ
         rzBdsKKQ2gTc9aJHp5dUXgUia0PDKy3g6xfxOiIwsnlbhfRR/57fACZDBSMT4kU86Nai
         pHRCFjKfn0fx7Q7ivPJepEE3vgVJuPK5vb27Iie2S18a4LokIARlwWK/Rly8LuysFdUr
         osbizZyP6Z7iWpPWDs2kp6jjAg2RjfzQINCSEBvluUcxNpSS3DZKOXhjpoLU51b3LfDJ
         URy3MR3o/onWHw3B67sHwgHreJXbbpq/Yd3hbgH8XZzIVzlaEp30DAg5gl8FxP8c1zIx
         jp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jxgOxY4B08EjHhrJifqAl9w2afbpnhHcJ3tCVglLepQ=;
        b=O7e9nu1o8Aajimw2J5o3ZzfHQXNHCClOoBC4+UOK34mXJH94di35YS3Fm98hUDhWv9
         VVBap8WhEmVW7slgUvsXZnxZ41MYGTIt+SSOprxGg/VonnMrn7+4pIwf69qh2HKzr44d
         8BY7rpUEMvJ5cXiPfhWy6SMa6jYOZ0dT4ppA/9q2g/QwRXHqrggWhGaGqC92k22WC9sF
         EKJkZd+SYCrN2EZxKsqLuQytCwoCGy0fp/Tl7GoNbItBD1bJtZMPUumABGRjclX+gdzE
         8nwPzJP0MhP7OmaF5hRspL1va7W0gvp4pAb9ZZMT7JBZu+2tdcTBHFpys9y11oOaQHg9
         6Csw==
X-Gm-Message-State: AHPjjUgc1aooVhRcFo/OKKBtVKxHr1s3p8z5m5NTw/riYF9Lu6XfXS+x
        N79ws6PzoTJ0wxX5XbqEjKRMALJu
X-Google-Smtp-Source: AOwi7QCQtIcwKc52pPunHsWtv7t+WLEArW5TuxsD3jFrZiYlIrwJpA9vUm09fUbxxp9AiVAE/3nqqQ==
X-Received: by 10.55.148.3 with SMTP id w3mr8279698qkd.26.1505927481091;
        Wed, 20 Sep 2017 10:11:21 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 49sm1609627qtq.1.2017.09.20.10.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Sep 2017 10:11:19 -0700 (PDT)
Subject: Re: [PATCH v6 09/12] split-index: disable the fsmonitor extension
 when running the split index test
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-10-benpeart@microsoft.com>
 <20170919204354.GG75068@aiede.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <43c9d3b2-2895-adcb-6f77-b6967aacf9c8@gmail.com>
Date:   Wed, 20 Sep 2017 13:11:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170919204354.GG75068@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/2017 4:43 PM, Jonathan Nieder wrote:
> Hi,
> 
> Ben Peart wrote:
> 
>> The split index test t1700-split-index.sh has hard coded SHA values for
>> the index.  Currently it supports index V4 and V3 but assumes there are
>> no index extensions loaded.
>>
>> When manually forcing the fsmonitor extension to be turned on when
>> running the test suite, the SHA values no longer match which causes the
>> test to fail.
>>
>> The potential matrix of index extensions and index versions can is quite
>> large so instead disable the extension before attempting to run the test.
> 
> Thanks for finding and diagnosing this problem.
> 
> This feels to me like the wrong fix.  Wouldn't it be better for the
> test not to depend on the precise object ids?  See the "Tips for
> Writing Tests" section in t/README:
> 

I completely agree that a better fix would be to rewrite the test to not 
hard code the SHA values.  I'm sure this will come to bite us again as 
we discuss the migration to a different SHA algorithm.

That said, I think fixing this correctly is outside the scope of this 
patch series.  It has been written this way since it was created back in 
2014 (and patched in 2015 to hard code the V4 index SHA).

If desired, this patch can simply be dropped from the series entirely as 
I doubt anyone other than me will attempt to run it with the fsmonitor 
extension turned on.

> 	                                                         And
> 	such drastic changes to the core GIT that even changes these
> 	otherwise supposedly stable object IDs should be accompanied by
> 	an update to t0000-basic.sh.
> 
> 	However, other tests that simply rely on basic parts of the core
> 	GIT working properly should not have that level of intimate
> 	knowledge of the core GIT internals.  If all the test scripts
> 	hardcoded the object IDs like t0000-basic.sh does, that defeats
> 	the purpose of t0000-basic.sh, which is to isolate that level of
> 	validation in one place.  Your test also ends up needing
> 	updating when such a change to the internal happens, so do _not_
> 	do it and leave the low level of validation to t0000-basic.sh.
> 
> Worse, t1700-split-index.sh doesn't explain where the object ids it
> uses comes from so it is not even obvious to a casual reader like me
> how to fix it.
> 
> See t/diff-lib.sh for some examples of one way to avoid depending on
> the object id computation.  Another way that is often preferable is to
> come up with commands to compute the expected hash values, like
> $(git rev-parse HEAD^{tree}), and use those instead of hard-coded
> values.
> 
> Thanks and hope that helps,
> Jonathan
> 
