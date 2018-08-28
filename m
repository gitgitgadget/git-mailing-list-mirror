Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAC81F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeH2B0W (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:26:22 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34908 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeH2B0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:26:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id 89-v6so2054677qkp.2
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GlBvYX0rAl8SoR/W1a1NucVqCLoYqeKCmqrtdQmIFjA=;
        b=Z6WyAHfXkkOfZXvBYGcd4lY4PII5MVeEcxdHTi+xgx4TF5RvTSp2PejTiRvJBLzuR1
         bhuhWelrBS3EP+W7Va6bkjaKQcYoada7l9f9p1kw/8EoTcfKfAoQhUBid0CiKmQc5nvf
         6dS4eM8bFYe5O8oQtIsgKEGd/BT7y2fSElpleEA6b0ql0lu04UeMX4zQ3Ij+jykWcThW
         BCGroEXOS2fNvcx2WtO4tRT6VdKAmog0+RCIvZ3fs9E955pe5hOKivQjVzXoasjilHfj
         FYfFFlu+kp9PLaM+XN0yk0KRH6bBorK1iurjA1kM4EnyHfxXz88hQmggo4Truq7oZedS
         V7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GlBvYX0rAl8SoR/W1a1NucVqCLoYqeKCmqrtdQmIFjA=;
        b=pYiz7k5dLChc4ekEfrY1DE2/aKo5bmyB2OOdiPbZ7Q6uLoDiKeM3BxnvzD39JuzDsM
         ymt0Oo8kTzy4rv9t7qX8WWHLPKZTAG+XlCBK2zMI5vHDBoOScof3vlVpJYwIqPfSHlXp
         yx2JlhZCzv//4c8AbFc5rJFVjZq9A6BogV3aHFPxlTOZ83iJ9zMeZC0wLuOto2L78ZV4
         U9gpxmZgz3piyyaGEmZRt/HpgO9mcF7TpFYAXBeXr3XtKJ25qIb65bPAXpNeaCZbkRzg
         IVCDQPYCioxVwZRQB5P2q7kCDrgT9xn6UMVB/sSJOEpl7BiveZkA94eqjgRqc5Sr+Lsk
         G1uQ==
X-Gm-Message-State: APzg51B6BHyOKwcqJHBessar6jDHP8GwVuvM6oQsd5n5gDgUlaVMAKwS
        T/LwvnFf0ygoKm2IDGVuLNg=
X-Google-Smtp-Source: ANB0Vda5VFkT/IL8GAN7/WLflozleHYdjhHeZZW/a6VpMCcjutwLkVwgIi6HzWZx6Npy9ETejDlTIQ==
X-Received: by 2002:a37:7607:: with SMTP id r7-v6mr3639468qkc.133.1535491968706;
        Tue, 28 Aug 2018 14:32:48 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r10-v6sm1368971qtj.41.2018.08.28.14.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:32:48 -0700 (PDT)
Subject: Re: [PATCH 0/1] Define GIT_TEST_COMMIT_GRAPH for commit-graph test
 coverage
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
References: <pull.26.git.gitgitgadget@gmail.com>
 <CAGZ79kZ=jsCmxKdcPB+Q1__uO8Z2tXx6OkdyTSM8P3QdNGpKQA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42231d43-c1f7-592f-cec8-0b07eb9f70bc@gmail.com>
Date:   Tue, 28 Aug 2018 17:32:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZ=jsCmxKdcPB+Q1__uO8Z2tXx6OkdyTSM8P3QdNGpKQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 4:37 PM, Stefan Beller wrote:
> On Tue, Aug 28, 2018 at 1:33 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The commit-graph (and multi-pack-index) features are optional data
>> structures that can make Git operations faster. Since they are optional, we
>> do not enable them in most Git tests. The commit-graph is tested in
>> t5318-commit-graph.sh (and t6600-test-reach.sh in ds/reachable), but that
>> one script cannot cover the data shapes present in the rest of the test
>> suite.
>>
>> This patch introduces a new test environment variable, GIT_TEST_COMMIT_GRAPH
>> . Similar to GIT_TEST_SPLIT_INDEX, it enables the commit-graph and writes it
>> with every git commit command.
>> Thanks, Duy, for pointing out this direction
> Did you mean to cc Duy (instead of me)?
> (I'll happily review the patch, too... just asking)

I just added you because you've been on a lot of commit-graph things 
lately. But yes, I forgot to add Duy to the CC list. Added to this message.

Thanks,

-Stolee

