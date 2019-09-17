Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607141F463
	for <e@80x24.org>; Tue, 17 Sep 2019 10:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfIQKrm (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 06:47:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45928 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfIQKrl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 06:47:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so3382301qkb.12
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7yT0MuaJI68EorfQNgWeQnXpvY/BruvdXhCRksuE10M=;
        b=OpQRiC8tPia8/Pi+2yEuVu1KlEGtAxADGPnt3BpmLYwJJpBn6DycumsLVvqiCaOP2W
         0oWzJqvH2QG+WIb6kMxbA7mgrOhWSLVoIsRxnSdijSTRsv5CreR00rGx1NCP9+Y7tz16
         j4F35XTmDITc2G4IaAfiYDHzugR1ahKiYa5Vp99oq0sNFyGKOcupjfNsoCRtnQvYjuba
         WlW//Y87RKBYPihywmNOfDVUX7P6Lbv6wBqQ0ucSDtRrtgL40JjRMQ5qnCEVfSMLFH9y
         8D3XXhoTHqvUfxU7xna6JY9fNUu4/33YEaQ5Ykgq8L7Q0cUYX39AvAk2Q2SXJ/kME0KN
         8nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7yT0MuaJI68EorfQNgWeQnXpvY/BruvdXhCRksuE10M=;
        b=fXkFJ8hA2vlwnMKRIXOLaIseIdOC2ZAd78X++Qm2VtOohmXcHmWNIlihnAjwvmPb75
         6KcOMd/sXxDt5yyfTpnypcsNExW0xXB2mFlDYHYF308rh0L8TsWyqkGELZgGpTbI6QuP
         dCDAoG3ozRKWRMKLpIFmEuWU5ousCVYQDXG5VkHt576vfPlEBS7LRBvNxRJ4jrCAZRN4
         17s9MNBpDrIu3WZjKdyv2r7DOy7BYi3ApHQipq/qgFelTqHRVAEs6MC4thCQGIv+K6bw
         fj92QGeCXkYScmA3SwDf/31BaZgXgniMETAzEFpJ02bKwYGU5xfNkMgNoZfcS3lBMhW1
         Jnbg==
X-Gm-Message-State: APjAAAXRDsEdpghG4kRd5djjP5n+z2oH9++UTXUaiQD0lZM70G9bRlon
        nsbi37NLkP79FdxDc2vMp2k=
X-Google-Smtp-Source: APXvYqxqZBrGoQJpe0eHYq6Q9oopP4AvGEffImOWyxAlhZISyWERwCItgQwg81z2eoa6MUm4OFV0kg==
X-Received: by 2002:a37:6291:: with SMTP id w139mr2998653qkb.268.1568717260703;
        Tue, 17 Sep 2019 03:47:40 -0700 (PDT)
Received: from [10.0.1.21] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i1sm823570qkk.88.2019.09.17.03.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 03:47:40 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] commit-graph: add --[no-]progress to write and
 verify.
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
References: <pull.315.git.gitgitgadget@gmail.com>
 <pull.315.v2.git.gitgitgadget@gmail.com>
 <47cc99bd151db67fe2ee0f91bb98b3eb7e55786d.1566836997.git.gitgitgadget@gmail.com>
 <20190916223607.GE6190@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7a9581ea-dc90-5ce1-fc3b-578c6dbf6efc@gmail.com>
Date:   Tue, 17 Sep 2019 06:47:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190916223607.GE6190@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 9/16/2019 6:36 PM, SZEDER Gábor wrote:
> On Mon, Aug 26, 2019 at 09:29:58AM -0700, Garima Singh via GitGitGadget wrote:
>> From: Garima Singh <garima.singh@microsoft.com>
>>
>> Add --[no-]progress to git commit-graph write and verify.
>> The progress feature was introduced in 7b0f229
>> ("commit-graph write: add progress output", 2018-09-17) but
>> the ability to opt-out was overlooked.
> 
>> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
>> index 99f4ef4c19..4fc3fda9d6 100755
>> --- a/t/t5324-split-commit-graph.sh
>> +++ b/t/t5324-split-commit-graph.sh
>> @@ -319,7 +319,7 @@ test_expect_success 'add octopus merge' '
>>  	git merge commits/3 commits/4 &&
>>  	git branch merge/octopus &&
>>  	git commit-graph write --reachable --split &&
>> -	git commit-graph verify 2>err &&
>> +	git commit-graph verify --progress 2>err &&
> 
> Why is it necessary to use '--progress' here?  It should not be
> necessary, because the commit message doesn't mention that it changed
> the default behavior of 'git commit-graph verify'...

It does change the default when stderr is not a terminal window. If we
were not redirecting to a file, this change would not be necessary.
 
>>  	test_line_count = 3 err &&
> 
> Having said that, this test should not check the number of progress
> lines in the first place; see the recent discussion:
> 
> https://public-inbox.org/git/ec14865f-98cb-5e1a-b580-8b6fddaa6217@gmail.com/

True, this is an old issue. I think it never got corrected because
your reply sounded like the issue doesn't exist in the normal test
suite, only in a private branch where you changed the behavior of
GIT_TEST_GETTEXT_POISON.

If we still think that should be fixed, it should not be a part of
this series, but should be a separate one that focuses on just
those changes.

Thanks,
-Stolee
