Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E7AC1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfHARve (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:51:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44768 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHARve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:51:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so40100477qtg.11
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xo2kfgfRF0stD4sW/iIEoamLYLiE8XeeU73qXabbUSo=;
        b=MywcbVngxif9xhBCbnoPEGgyxDFjMsGM9cX8pZ4rPda4KCKRjTEEc14ZkpsZKNYMOG
         gJZhmrOkz9NaMZ9OnrMlePVFzIu4buyH8T6gEyDzAIYRm2DUQn9DUZnD9YfkTbFdPS87
         y08119fjS/++cIC6C5/ukqAku1sZ5oKOdRBDL9L2JbieYyDn4QfLuytjTwuEuzKkUyqp
         NtCjlIEnirq7MoKq18eEujQ1PV89zR7qaNDuswLrxWUi/3uF+mwyk7MVF9Om/kMRIaOm
         mMBmu4q32qWGVHytLAY3qqcIHOOINObuU+8XUxVCsobKkEp/sf1OlcRFLjVxV7tQpax1
         4bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xo2kfgfRF0stD4sW/iIEoamLYLiE8XeeU73qXabbUSo=;
        b=XQu4OITlOZUq9T5ETipVI1axScoDDz1I7nS1BF/kF5OBvgvrPYms6oyrRjaj5YIfNZ
         316wohdzOLCzBZlAJ03Rt0dgLV2szEaMwmj5WTgPdHFc80U6lrT1iG9KM2Krjzj46Vm7
         lED+T1/w6RcxTlmRDYlXC0X661U9tapIXVbcQyl7Fg3BMzxMbeiucUl7dvAQoNM91Mxq
         p0F1k8BJISMgV7fuioMu62bEFqcwCKVVSZhBVUtaWRXqC+HBmCsjTumkYhTooT8DrJcG
         PWXMpuLODXgdt+Zeu2WYdpqliSzoIURvm4XDCW86a4eyKTN07HsZIvjJWUtHsIoOmeNY
         bzDQ==
X-Gm-Message-State: APjAAAUfWnphOd2ekCjAXp1e8uCG2qRSvRbLygA8xPM7ah4KuNgcHokD
        UzSJheHmziuq0N0y+puFRN7Betl8Coc=
X-Google-Smtp-Source: APXvYqyFrDVziXE5yxtxkBuuPprb1arNKYdTVlzl8dqw+gBcgmBGqVPTX7IXuzk1YNJXfHV1bamlJQ==
X-Received: by 2002:a0c:ae6d:: with SMTP id z42mr93316223qvc.8.1564681893345;
        Thu, 01 Aug 2019 10:51:33 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4870:3e0f:c9e6:7998? ([2001:4898:a800:1012:f9a3:3e0f:c9e6:7998])
        by smtp.gmail.com with ESMTPSA id g3sm28914733qkk.125.2019.08.01.10.51.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:51:32 -0700 (PDT)
Subject: Re: [PATCH 1/3] t5510-fetch: run non-httpd-specific test before
 sourcing 'lib-httpd.sh'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
 <20190801155309.15276-2-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45604ef6-7332-13ed-76ab-24e930723212@gmail.com>
Date:   Thu, 1 Aug 2019 13:51:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190801155309.15276-2-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/1/2019 11:53 AM, SZEDER Gábor wrote:
> 't5510-fetch.sh' sources 'lib-httpd.sh' near the end to run a
> httpd-specific test, but 'lib-httpd.sh' skips all the rest of the test
> script if the dependencies for running httpd tests are not fulfilled.
> Alas, recently cdbd70c437 (fetch: add --[no-]show-forced-updates
> argument, 2019-06-18) appended a non-httpd-specific test at the end,
> and this test is then skipped as well when httpd tests can't be run.
> 
> Move this new test earlier in the test script, before 'lib-httpd.sh'
> is sourced, so it will be run even when httpd tests aren't.
> 
> Also add a comment at the end of this test script to warn against
> adding non-httpd-specific tests at the end, in the hope that it will
> help prevent similar issues in the future.

I appreciate this comment! Not only will it help authors, it will help
reviewers who only see a slice of the test file during review.

Thanks,
-Stolee
