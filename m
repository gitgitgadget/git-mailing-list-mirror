Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64371F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfA2UuD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:50:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38922 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfA2UuC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 15:50:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id u47so23865290qtj.6
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xe8FXjVb844iAIQ1jKLcBKKVWjZ6vZj1x2QpNE//GkU=;
        b=c5XuulOSX/X3AVSnU0rd58MEJCMzjbNgpzf7uQxYP6tVT/XXLJ82akdsTNKYyFbndn
         itoG5HdbYp6g3zvs0BM6VFY/3Ouo5a1DsnQYByAVr6wTJZbpDIOBj2ayPxDLLZBeeHXh
         qtUYv9lxdcwPs/J6sNf2jw8SWPDYZXR9VJwOUGr7Hk5IG0tWyOT97fwxuvKYjTdCESW6
         CJysO3EO1F3PmOr+KLhm+kwyFrVfn8HpqoMY6pVfc5NB21dKpe7nq75gXS3pQZpcnQFP
         XqbF/QaylMuYpneDu0oSSiWQA24O8OBP1U+RPRE8BoIMPSn/Um8jTckL5fQvcs7mkewl
         lQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xe8FXjVb844iAIQ1jKLcBKKVWjZ6vZj1x2QpNE//GkU=;
        b=JBX5QNeUD3wthJIjBotDNOilYdb/k+FGU+ZyvoUoAeUHCnNaGhROJCfOZalx3UZvy2
         YQauFReEfMcc8+7p1/X39kn2MBXnX39XwDeDQNzNj0ztxfe1uwsgTOa3tEbVUaKrj5Py
         FTxNlu24RynlSyQzb6T+Hq6pKfOBEA27sF7HMCQaq0aV6QL12QRV8qbk1WVnbWBMFTdv
         lAKHo+AVy+AWncKnYPkcHgJaLuV3RgnV6lu8hWl6+W11P+6Cbqasm5/9FaU8oHUVls17
         LlZZGobeQxR/fMv+HPQZB8i1wbyAp+gRXvqC02KI5kWiMQDWvqn+2O29rj5m5qJX3r+y
         gW0A==
X-Gm-Message-State: AJcUukfbvv22m+TEx5l+4ReVHz97MeMRsPJW/AU+Jbcro6aFWfKpPyVY
        ioUMc+vdsxZlpEGGJSJm6ws=
X-Google-Smtp-Source: ALg8bN41qFnSV93yjkhMNhNq4yK8PfItjOeIuM8Uh7M0FpxiR+b9h/y3T2ikI9ksKDXyeZplRCVJug==
X-Received: by 2002:aed:2a1a:: with SMTP id c26mr26903442qtd.147.1548795000865;
        Tue, 29 Jan 2019 12:50:00 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id u4sm57905309qkk.51.2019.01.29.12.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:50:00 -0800 (PST)
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev> <20190129173409.GD13764@szeder.dev>
 <95d30af1-1940-b4db-99e8-2ccca5210bbd@gmail.com>
Message-ID: <795f816d-d870-068a-5595-2fe617339a79@gmail.com>
Date:   Tue, 29 Jan 2019 15:49:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <95d30af1-1940-b4db-99e8-2ccca5210bbd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2019 1:10 PM, Derrick Stolee wrote:
> On 1/29/2019 12:34 PM, SZEDER Gábor wrote:
>> On Tue, Jan 29, 2019 at 04:58:27PM +0100, SZEDER Gábor wrote:
>> And in the related email discussion [1]:
>>
>>   But even though the docs claim it [-j<N>] should be possible,
>>   I've been getting "random" test failures when compiled with coverage
>>   support, that went away with -j1.  So the tests still run with -j1, as
>>   with the first version of the series.
>>
>> So it doesn't seem to be that bad after all, because it's not
>> "completely breaks" but "random test failures".  Still far from ideal,
>> but the original coverage patch is just about 3 weeks short of a
>> decade old, so maybe things have improved since then, and it'd be
>> worth a try to leave GIT_PROVE_OPTS as is and see what happens.
> 
> It would certainly be nice if the build time could be reduced through
> parallel test runs. I've kicked off a build using GIT_PROVE_OPTS="-j12"
> to see what happens.

I did get a failed test with this run:

t0025-crlf-renormalize.sh                 (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1

This was on the 'jch' branch, and an equivalent build with sequential
execution did not have this failure. That's flaky enough for me to stick
to sequential runs.

Thanks,
-Stolee
 
