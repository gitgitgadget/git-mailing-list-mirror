Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189011F403
	for <e@80x24.org>; Mon,  4 Jun 2018 11:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeFDLaM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 07:30:12 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35372 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbeFDLaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 07:30:11 -0400
Received: by mail-qt0-f181.google.com with SMTP id s9-v6so10475514qtg.2
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 04:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=noBoST1e3PDVoRVFFOkIS8rJF9WMv4ryUwCXZvWOMMQ=;
        b=vdRX3OO73498wJBarj3cL8g3zm0i5cWe0QSfjYFhSBosuF90S7pRgxeKyqY/KKvW7Q
         oUqfxL22maT3onJDkMEuqFCPzYZP7mqnQAdeIccYiK3Y1W4ruAhiAH182ORa/Lu3ZV1g
         CdJpFmY43Kgr99fUovNloTPjHo3QUUnRhiRUOSoL0KomM9f7Nyoqea0vOrtZ2R8S+kSj
         RESj9siZLpaYi5+Ks6JULoiQFs4poWhqRjLGL5ilIanPY3czSWVNGYDVIkeYr9P2Zj+W
         Cz0epbtX7mL9Jr3eshSR8GFLcwHmjI6xkiJb3F42NOAy5jHN8pxCi5C7YbpSoEXrIxed
         +yyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=noBoST1e3PDVoRVFFOkIS8rJF9WMv4ryUwCXZvWOMMQ=;
        b=MUjY+X7CLOeZbi97Ib4Nfyy9JkdppYEo7hzgIY1Dp6L/9I9+xgMVRKPJueIqHCvEym
         G8+Turuqxx9etheYSY/rvK6suxoQs3LIzqalsdQPjnl3EJWHbwUGvCez1dQzQTAG9YAA
         oVWghFPuKn6CBnYj0CCKmvOltxTIkM+/Pccq4bCBRSBbpeiR+XzlsasXe/ZLkFNig29x
         UgwhB7CL5xqth9jJM1h47OCSjEY0ZlqyKezoZ5Qz2BLJbX5tTMT4d+XxXpNHid6G8AHS
         /E0PPdjEHsTJkgHaGsODQ4tGII2Xj1sGgjuXv735nAHrVBIRUyA0rewtRs4NvPD7zqzy
         5t1g==
X-Gm-Message-State: APt69E1Mbx8CczMxxqHQLEQE4BU8RmbV6XZTtLpON7mdx0fEYik92OhU
        w4LJMRsCGEYR3bjNYUG5ym8=
X-Google-Smtp-Source: ADUXVKKf2YnCgWrxJ2AwPZ1aXyKdsTVLbjKfCXWhmH/ld5cKXnDDUzKNPAW/w4e4EWiEZH7xjt8kFw==
X-Received: by 2002:a0c:e74c:: with SMTP id g12-v6mr6149071qvn.203.1528111810297;
        Mon, 04 Jun 2018 04:30:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2d1c:9d08:485:87f2? ([2001:4898:8010:0:1652:9d08:485:87f2])
        by smtp.gmail.com with ESMTPSA id k44-v6sm16886567qtf.74.2018.06.04.04.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 04:30:09 -0700 (PDT)
Subject: Re: [PATCH v3 06/20] commit-graph: add 'verify' subcommand
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
References: <20180511211504.79877-1-dstolee@microsoft.com>
 <20180524162504.158394-1-dstolee@microsoft.com>
 <20180524162504.158394-7-dstolee@microsoft.com> <86y3g4yahm.fsf@gmail.com>
 <4343f593-5650-3b24-54ec-a0d97d5251e9@gmail.com> <86d0x8rimu.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8d0165f3-6e0c-4799-6042-b0570b529b6e@gmail.com>
Date:   Mon, 4 Jun 2018 07:30:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <86d0x8rimu.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/2/2018 5:19 PM, Jakub Narebski wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>> Do we have a way to run individual steps of the test suite? I am
>> unfamiliar with that process.
> The t/README describes three such ways in "Skipping Tests" section:
>
> - GIT_SKIP_TESTS environment variable, which can either can match the
>    "t[0-9]{4}" part to skip the whole test, or t[0-9]{4} followed by
>    ".$number" to say which particular test to skip
>
> - For an individual test suite --run could be used to specify that
>    only some tests should be run or that some tests should be
>    excluded from a run (the latter with '!' prefix).
>
> - 'prove' harness can also run individual tests; one of more useful
>    options is --state, which for example would allow to run only failed
>    tests with --state=failed,save ... if the tests were independent.
>
>> Adding the complexity of storing a copy of the commit-graph file for
>> re-use in a later test is wasted energy right now, because we need to
>> run the steps of the test that create the repo shape with the commits
>> laid out as set earlier in the test. This shape changes as we test
>> different states of the commit-graph (exists and contains all commits,
>> exists and doesn't contain all commits, etc.)
> I think we can solve most of the problem by separating validation tests
> (which all or almost all use the same commit-graph file) and other test;
> putting them in different test scripts.  This means that the more
> complicated case would be limited to the subset of tests.
>
> Anyway, if the setup stages are clearly separated and clearly marked as
> such, we would be able to at least manually skip tests, or manually run
> only a subset of tests.
>
> Test independence is certainly something nice to have, but as the git
> testsuite is not in best shape wrt this, it is not a requirement.

I'm all for making the test suite better. In this case, I will hold that 
for a later series (that is entirely focused on that feature) as I 
expect we will want to discuss the correct pattern in detail.

Thanks,
-Stolee
