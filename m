Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BC7D1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 23:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965224AbeF1XOV (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 19:14:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33711 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936152AbeF1XOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 19:14:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so543010wma.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LRiZbLt2B8ieOtDEp7PMkIBIKPOiJjCG5gUJN2f9bko=;
        b=CU3RnBk/SKU31U2RJ+rA0d+B42J8UVe7xw5RtVSoSNmLJLozdyAXH73T4way/R/900
         U9A64A+LgOcsbz/7y/wKp54TsGoCzTn9I5npQ/ZQ7bauffMQ5UK0M61ci5Wt8koTJs0r
         8Qm9oKDqmzvooDR5JW8rJyCyLz2aR35JKHBjUxfX2ha9PGe1XqcyQfc8r4Q6D+4qSZed
         DbBwO+QcOEgv+1MEAgD4GHrqk+6v477lzTLsTXdgDko2qfGIprrHgos96x5nVKT5Hnc2
         pQE4WFvyJ+Vf1yv8DFisfH5uJHWSdgjingDr56nRadRqKocpvfFi5CB/EU2Hfom07S3s
         VD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LRiZbLt2B8ieOtDEp7PMkIBIKPOiJjCG5gUJN2f9bko=;
        b=Z161OLjAWmj/F5IHQmu+EEn8byc1pQG+T+fuAxVQyAm7VviNZoFXYjiahSfVj7EKYU
         W7rJRUMiUldeekY07Dn23et7eurBfQ89v06sxgaitK93bcWwI3Mfoxeh34xclyzvAdQy
         mJQ5FqRMtRdMCOAS5wJkXXGOHhTUGAq+zz7DCkKccHWdeoPvjUeLlPPIY4MyhnVMTWCN
         qHndYb8QBZVkEyCc6jZc7nAojZGT6kuxiCcQp8YqGpvYckwz4kVTzbAmQlo29sA+/0oC
         19jUlSKJsmCmUiPBcC9hT31eMggEO64zI1LViZHleJJynr08u0vjp/xHCzD2gV+e3MKP
         l+yQ==
X-Gm-Message-State: APt69E2KUAFHLj1GyPPJ/tbX83i3IacY4wu4GstuxLCfdrs12x6jE31i
        ZkiwKXGkzrIg1W5ucr9vvwDLdYs+
X-Google-Smtp-Source: AAOMgpcXVkIIMfydf0UEqvIRP8My1riFbIUBdDrnonaTOKdtLSSuaEk3idzic20VWKPszBZedU6+rw==
X-Received: by 2002:a1c:b49:: with SMTP id 70-v6mr8938524wml.5.1530227656196;
        Thu, 28 Jun 2018 16:14:16 -0700 (PDT)
Received: from [192.168.0.137] (5-13-221-130.residential.rdsnet.ro. [5.13.221.130])
        by smtp.gmail.com with ESMTPSA id v15-v6sm22078wmc.16.2018.06.28.16.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:14:15 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] stash: Convert some `git stash` commands to a
 builtin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
References: <20180405022810.15796-1-joel@teichroeb.net>
 <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
 <nycvar.QRO.7.76.6.1806270011441.21419@tvgsbejvaqbjf.bet>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <2882d57b-2e98-b3f6-6f85-4e6f8c6feca6@gmail.com>
Date:   Fri, 29 Jun 2018 02:14:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1806270011441.21419@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 27.06.2018 01:12, Johannes Schindelin wrote:

>> Joel Teichroeb (4):
>>    stash: convert apply to builtin
>>    stash: convert drop and clear to builtin
>>    stash: convert branch to builtin
>>    stash: convert pop to builtin
> 
> Were there any changes since v5 in these patches?
> 

There are some changes since v5 based on the reviews.

There are also some changes which were not suggested in the reviews, but 
which I considered to be good (I hope they really are). For example, in 
the previous version of the patch that introduces the `stash--helper`, 
there was no `assert_stash_like()` function (it was part of 
`get_stash_info()`). In v6, it was implemented as a separate function in 
order to keep it more alike to `git-stash.sh` script. Another difference 
was to change `assert_stash_ref()` function type from `int` to `void` 
and call `exit()` inside. This was introduced in order to make it more 
similar with `assert()` from `assert.h`. I do not think of these changes 
to be something of great importance, but I hope they might make the code 
easier to read.

Best,
Paul
