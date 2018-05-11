Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA861F406
	for <e@80x24.org>; Fri, 11 May 2018 03:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbeEKDHn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 23:07:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56085 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEKDHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 23:07:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so480712wmg.5
        for <git@vger.kernel.org>; Thu, 10 May 2018 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7bC9YkEmboi8k69uZj7hFuiI60T7D+ota1HGhqZw6m8=;
        b=XJ2m4kOTiHPL8A9nL1iIM8qlx0iaazTBDEVoAz2Wazw1SA26KdnNRU3YKjd5oDwC4T
         fr/WA7qUmyYZ6WvAKQnWM8AWj9F9wVt+6THALzCcaCR6IaegDKkOCwGvAzEQ8CSZksVv
         +SXynWCwWCyVUs+NHvQnHXYSR7nwt54g6S79OmE4jnTzwKoiOWgDOxZObu6rElnRZE/s
         9j8+Anj2DNaQzV4vSfKGa7ANE0gVzLZ26quFANN8YRcJKSXSdCPojTFn3mxrZj+8Xq8O
         NwZOw486dLERPBxqZimqnxZu3VAzX9932TwqCwyWA77stQb9m95g4eA34iW/NlduWyvg
         D8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7bC9YkEmboi8k69uZj7hFuiI60T7D+ota1HGhqZw6m8=;
        b=SHlWUiSyiYwAjMbTjY4YRWh1Kcj1aIZVNVY5YFR8CtfRaD0Yue/w9ndVexQfbx+E8W
         jaGMiTG2McepmaE3EuzJlADMFvYljQEt4C2ZUKO0vBPnZbEV/Lte013j7Uvj9BoifSRw
         BgwBVevTSXkeZ5CwdeT1FAMM4lT6m7kLAqh1sVGGXu9IofN1SgZ8sMtz8gSxFETfDALu
         FYzHD3SmTCu8bLU3u60No/wGEUKieqgoRvvNnscPDwIGXgtfxoD9e5oeAYh4wZKnElAD
         BaJQc7sb4AhaVTHmfd/z+d+ZYzIteyfFfgwhqLdaaSOmdKZXWdNs4EKNP5Zi19wam8/O
         Tl4Q==
X-Gm-Message-State: ALKqPwfbEQonA19q1XC8l+5HlSDFMkYD3/UwXmepFG8gQDGVCjiktMUU
        pjRu1vb7GBONLvhxvPq1NjjprbYX
X-Google-Smtp-Source: AB8JxZqOFjb9vCVCry6gs9c2kyqlcClKa/Tht03GI+jVqeE4yrkc+lM3LSqHSOI9gBB1dck4HjbX8A==
X-Received: by 2002:a1c:6b57:: with SMTP id g84-v6mr644142wmc.127.1526008061097;
        Thu, 10 May 2018 20:07:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 38-v6sm3869544wry.61.2018.05.10.20.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 20:07:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 2/6] sha1-array.h: align function arguments
References: <20180501184016.15061-10-avarab@gmail.com>
        <20180510124303.6020-3-avarab@gmail.com>
        <20180510150615.GA6462@sigill.intra.peff.net>
Date:   Fri, 11 May 2018 12:07:39 +0900
In-Reply-To: <20180510150615.GA6462@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 10 May 2018 11:06:15 -0400")
Message-ID: <xmqqvabuhouc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 10, 2018 at 12:42:59PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> The arguments weren't lined up with the opening parenthesis. Fixes up
>> code added in aae0caf19e ("sha1-array.h: align function arguments",
>> 2018-04-30).
>
> I think that's this patch. :)
>
> Presumably you meant 910650d2f8 (Rename sha1_array to oid_array,
> 2017-03-31)?

Sharp eyes.  I couldn't quite tell from a cursory read of the blame
output, until I realized that the original before that culprit were
aligned and the renaming was what made them out of alignment.

But then "fixes up code added in" is not quite right, either.  It is
what the commit should have touched but didn't ;-)

Thanks.
