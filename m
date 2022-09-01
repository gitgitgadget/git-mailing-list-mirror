Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FDDECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 16:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiIAQV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiIAQVL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 12:21:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DC3718A
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 09:21:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q3so14392171pjg.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pwRBBjsltM8qPdfx/GPDKYxVM1q7czoIiOtSWcAN8Ho=;
        b=KJoNJ7VqcOWYIDt4GU0+EhciV3reUXTxwd48V5L5Pj0Q8tprlgHELJjQYo1ERzj9cf
         rI6Tgrc+tIRKf6w1uImAT0iDJUBkjUGjnVO6BAG8UZC3CXcyywG43jqGmTf7C7/N6R04
         CmyGQ0TkKgRFRavAR3buAwej5Euwh+uonGBhPNi2X4nXItR5ia+fVt+oetUn4S6onIg/
         wKlW8JPbp+kP9aSTafo2dTUf5ymUoPOUSxtplGMsA1o/aOSPfdksyH+G/QaAGwFyPgMk
         CGTO4FWPhGKShKMIQXAR9ZxOT655vixIuu/tqmOfjJM3ZEffMBCikSXUH8kzqlfr26wj
         0vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pwRBBjsltM8qPdfx/GPDKYxVM1q7czoIiOtSWcAN8Ho=;
        b=BXCKEdhpX3Xqj9pWRm66dK1G6ZlCoR2EXXOjPsYxJAGKpPszRoLVSJVFSsHnoZrS1R
         mgG/I19oUzOsx6k80oJ1qJTGB3A4gW4DwBTdbWXoHZ1ncql7Fjk/JZc/YIMLWN4xdDeh
         +iW5lH7HZBpXjbA2ngAhd4qiwjKOulizhPd2jP3X7i0J6QmF6SB8IWM0UpYp/CYaj9cF
         c6uYi/Mef8xD3AsVIdK9/b/BcsWKjzJv5DUE8IZKKGrqxkUzYXTsnbRa4PfqS3V3UPCK
         1MsLFUQrSTLt2FJHloKC932yaxdTZw2qNjKej+sA52G0jCx9UK0qWxHGWsjSt6aIk/7a
         NgCw==
X-Gm-Message-State: ACgBeo0OKTofUqpWSFvhh9tGyvLVT+T69UweJaHhUSmxEZDu8n7M0cor
        pKM0pmB6NXnyhODG257nZRuN
X-Google-Smtp-Source: AA6agR7KH9Q0tPyIfRefnsGPvzUnCru1BIgznwjdN6XCyKICnA1CnuZs06woqSd+SM+Fg5HA4IDWUA==
X-Received: by 2002:a17:90b:1e4a:b0:1f5:4f69:d6b4 with SMTP id pi10-20020a17090b1e4a00b001f54f69d6b4mr9525201pjb.164.1662049262508;
        Thu, 01 Sep 2022 09:21:02 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id mn22-20020a17090b189600b001fd7cde9990sm3663576pjb.0.2022.09.01.09.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:21:02 -0700 (PDT)
Message-ID: <86b7b9a3-8950-da9c-eae1-19ddb22456ec@github.com>
Date:   Thu, 1 Sep 2022 09:21:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 6/8] t/perf: add Scalar performance tests
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
 <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
 <59s7o8n8-5797-q2qo-4q0o-93qppnr92q52@tzk.qr>
 <586fc6ca-b699-14a9-c5a1-10323a1cde0c@github.com>
In-Reply-To: <586fc6ca-b699-14a9-c5a1-10323a1cde0c@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye wrote:
> Johannes Schindelin wrote:
>> Hi Victoria,
>>
>> On Wed, 31 Aug 2022, Victoria Dye via GitGitGadget wrote:
>>
>>> [...]
>>> +
>>> +test_compare_perf () {
>>> +	command="$@"
>>> +	test_perf "$command (scalar)" "
>>> +		(
>>> +			cd scalar-clone/src &&
>>> +			$command
>>> +		)
>>> +	"
>>> +
>>> +	test_perf "$command (non-scalar)" "
>>> +		(
>>> +			cd git-clone &&
>>> +			$command
>>> +		)
>>> +	"
>>> +}
>>> +
>>> +test_compare_perf git status
>>> +test_compare_perf test_commit --append --no-tag A
>>
>> Given the small numbers presented in the commit message, I suspect that
>> even so much as running the command in a subshell might skew the timings
>> at least on Windows, where subshells are very, very expensive.
>>
>> Given that both `git` and `test_commit` understand the `-C <directory>`
>> syntax, this variant would resolve my concern:
>>
>> 	test_compare_perf () {
>> 	     command=$1
>>              shift
>> 	     args="$*"
>>
>> 	     test_perf "$command (scalar)" "
>> 	             $command -C scalar-clone/src $args
>> 	     "
>>
>> 	     test_perf "$command (non-scalar)" "
>> 	             $command -C git-clone $args
>> 	     "
>> 	}
>>
>> What do you think?
> 
> Makes sense to me! Although, out of curiosity, is there a reason you prefer
> "$1 -> shift -> $*" over '$1' and '$@'? 

Whoops, I completely misread your snippet; the 'shift' is necessary to
separate the '$command' out so that we can inject '-C'.

Thanks!

> 
>>
>> Ciao,
>> Dscho
> 

