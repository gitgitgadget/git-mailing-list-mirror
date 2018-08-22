Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21ABE1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 13:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeHVRF5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 13:05:57 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41562 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeHVRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 13:05:57 -0400
Received: by mail-qt0-f195.google.com with SMTP id t39-v6so1260151qtc.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=dqpimH3tXegYA/nKQ2YsjkHD+7hh0b89NCaoJkFDjaE=;
        b=m1ztO7tEwG8+XPSOMG1wIwlS8AfooYyCtO5HUQM6UDJeAtq4b6wPO+b1749uFyJR+c
         XBGOUZfOWXTHnWm7TVXixcDkd9Qzm7f9FxN/PTLXe+aGb4aX7QdEi+NUxXxtcPyUGm4q
         SKzW1V1x5TZ69BKB03KALwBlfiEwVYZozynNpDKGCQdLFj/inRkrBsmirJj2hgNZ86YT
         WxV+kPchxNLQGQXAgLeh/ifCZi/grK5tSeOuCAdBrtTTUogvC7lRLJI+AVXV0GZ8vfD/
         X5bwHhYCoRPzTzsLGJjSRmBbJDxH6BUtWoGVX2WehAQeP0nYrCANn39hlXHU7EK7INRX
         ZiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dqpimH3tXegYA/nKQ2YsjkHD+7hh0b89NCaoJkFDjaE=;
        b=GsR2gmLTGyJzW3LtykOoZmZLClLDIvf1mrj7HGs7IhPZRm8GYogST3tvxPzIesphNK
         mGwxze99e4lQwqyeNmn037tGvzeHpAj3fPqzoF3iD5xHSI6oSsfAD37TR1wFUB+a53a5
         c6oAeKcQ/0x/N0gCAqNMTKoiZ8sQa0/ZWp+UJ72eEjnlXPvyNqZtuzExoK82vCScjobk
         FBBxU3SdxI8w5TvtiWx6JO8VLYYlxaJKkcotK2FASl0hgBzPh3dObLRTtYHgL35zOIuq
         HB2AJhiarUMZuhaJnnBtqIB520e2+JDZZq/65HP38/6gU4aM0gnf0a1HJTIEJGmDZnlc
         Oy5A==
X-Gm-Message-State: AOUpUlHgaGIt/NNm+EbU0fUaaTZXQeb5TuSo5MoZaNw7PC6ukGC0Y3nI
        370i2iVDXJlhReoqpgpJ/TzOgbkY
X-Google-Smtp-Source: AA+uWPyuQzYZEdoLXDMEztwLdpJJtRZhYU/FpYUZqi7nOabbbMcMNZZeHEyUR81fDABG3mY6YIhvcg==
X-Received: by 2002:aed:257d:: with SMTP id w58-v6mr11113641qtc.110.1534945258366;
        Wed, 22 Aug 2018 06:40:58 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f53-v6sm1154147qtk.40.2018.08.22.06.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 06:40:57 -0700 (PDT)
Subject: Re: [PATCH 3/6] t/perf: add infrastructure for measuring sizes
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20180821184140.GA24165@sigill.intra.peff.net>
 <20180821190654.GC30764@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b071f6a2-2403-0bbb-72a5-695f8c4e724d@gmail.com>
Date:   Wed, 22 Aug 2018 09:40:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180821190654.GC30764@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/21/2018 3:06 PM, Jeff King wrote:
> The main objective of scripts in the perf framework is to
> run "test_perf", which measures the time it takes to run
> some operation. However, it can also be interesting to see
> the change in the output size of certain operations.
>
> This patch introduces test_size, which records a single
> numeric output from the test and shows it in the aggregated
> output (with pretty printing and relative size comparison).

I'm interested in exploring this test_size mechanism. The other area 
that could benefit from size testing is 'git repack', but I don't have 
any plans to change our compression or delta strategies. If we _did_ 
look into that, then using test_size would be a natural fit.

Overall, I really like this series!

Thanks
-Stolee


