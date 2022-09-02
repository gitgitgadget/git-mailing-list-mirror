Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A461EECAAD2
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 04:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiIBEAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 00:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiIBEAj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 00:00:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBC51A19
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 21:00:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h188so869369pgc.12
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zOKjUZAHy+75Ho8Il5anCaBAYxiqk8NgaeJqd9EGghk=;
        b=HGBT0iiU0KdWDRgtnB/BpzY5uP3eZ64roNQmMEEwAuofSd7yxWig9OH+B7av6489wJ
         snowRRSUHo3UU9YuVD9Gug7a+z5r3ZQ5YjsxlBdvr92ut03vt7t0/68IL0z8qQ+Iuw3Q
         xG+iN5Bk/v2X8CdXYMonOWiojI4dMDNh5xXiFxkKPJUlXHFeY8YnZMjt1IewC4BLytJE
         5TkhCIeJZG6QalS7bPqFB7W4fywtbkwSQeSVD5JvSOTl84O7htQL7VKxxiCgMdzsiS2A
         2MVp6GEMUlNaaNlf6xjo/zDAjHUtF3ai6+dO6E6NVYol/YrdTJauDawayJnN1gpLP8Bs
         Otqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zOKjUZAHy+75Ho8Il5anCaBAYxiqk8NgaeJqd9EGghk=;
        b=S6eS+NyRgkARPTEi7MM7PFA++uFVmAREDxt0tl6wiJ1hw3KZ5+E6/2XOl2WhvS9mzI
         VzWRZhsUdnEYw8Ka4ylj82ImpM/H5oEoo+hGPisxDTjRX7HZ9s02we21ImSfqYL9ArSd
         4B/NSEkS8ne6vvoWxhk1j3sUf3P9QQcssSGupll1KW9ZbSSQC8B2uyIc20adFUDT/kZF
         5wMuo4MmfUvzBo3gRvs6os3BqizIKJ1UQMEYtEFWZznyzGDaBVx24Todg/1NlcO6+wnQ
         fGkF650SvSuM0sQVdd6OXPZ9kCTna9M0isGL0DTfQRN8N6mL6DZGYwD6Aaq6PSO6qBos
         Ei9A==
X-Gm-Message-State: ACgBeo2YEVd02rReetOAB+T3YLSy2mVjR1La3EZfqBKXbWNqp4cuSUEf
        +QD4j+dMJsvbqcgHTnTFYh2p
X-Google-Smtp-Source: AA6agR7HIxp9uDpMWulb/pp7+hiyVzozbgU1zdkVrV+asjDR7LswbzA6V8otvIb41cf2mYs0E8wDPA==
X-Received: by 2002:a63:6f0c:0:b0:42a:55fb:60c5 with SMTP id k12-20020a636f0c000000b0042a55fb60c5mr28810078pgc.192.1662091235250;
        Thu, 01 Sep 2022 21:00:35 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ab9200b001750792f20asm381895plr.238.2022.09.01.21.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 21:00:35 -0700 (PDT)
Message-ID: <72f6661d-be02-dbb8-7110-b8de6bac77f6@github.com>
Date:   Thu, 1 Sep 2022 21:00:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 7/8] t/perf: add 'GIT_PERF_USE_SCALAR' run option
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <96e08a95265ea66839b439ce8abc50b34395aaa3.1661961746.git.gitgitgadget@gmail.com>
 <60p9nos4-n576-qqq2-p8n9-969sro247141@tzk.qr>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <60p9nos4-n576-qqq2-p8n9-969sro247141@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Hi Victoria,
> 
> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a 'GIT_PERF_USE_SCALAR' environment variable (and corresponding perf
>> config 'useScalar') to register a repository created with any of:
>>
>> * test_perf_fresh_repo
>> * test_perf_default_repo
>> * test_perf_large_repo
>>
>> as a Scalar enlistment. This is intended to allow a developer to test the
>> impact of Scalar on already-defined performance scenarios.
> 
> Great idea!
> 
>> [...]
>> @@ -130,7 +137,11 @@ test_perf_fresh_repo () {
>>  	"$MODERN_GIT" init -q "$repo" &&
>>  	(
>>  		cd "$repo" &&
>> -		test_perf_do_repo_symlink_config_
>> +		test_perf_do_repo_symlink_config_ &&
>> +		if test_bool_env "$GIT_PERF_USE_SCALAR" false
>> +		then
>> +			"$MODERN_SCALAR" register
> 
> Do we need to unregister anything here? My guess is that no, the "global"
> config we're using in tests is "$TRASH_DIRECTORY/.gitconfig", and the side
> effect of scheduling the maintenance task won't matter in practice. But I
> might have missed something and we may want to have an explicit
> `unregister` step.
> 
> What's your take on this?

As you guessed, a '.gitconfig' is created in the trash directory of each
test containing the Scalar registration and I haven't seen any issues
arising from the scheduled maintenance, so I don't think an 'unregister' is
necessary. However, while verifying that, I noticed that the registration
wasn't happening *at all* because 'test_bool_env' is currently being used
incorrectly. The fix is straightforward - I'll make sure to correct it in
the next version.

Thanks!

> 
> Ciao,
> Dscho
> 
>> +		fi
>>  	)
>>  }

