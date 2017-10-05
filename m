Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0717720281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdJEMjq (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:39:46 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38467 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdJEMjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:39:46 -0400
Received: by mail-qk0-f196.google.com with SMTP id 17so2943525qkq.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zYHSR1JNAYYpLtkcprWQuFzGoropJ2b6fHMow6KUTYU=;
        b=DSENfA0c7q51al2K6kSlh/Y/WBqVWzgnGjTR0WOZukm0Q45G4x84fZaNj2oTpHC0EK
         RxTHYzO7GkBqg1VBVMvCBFWbyNUv7ZDifbPS8boZa0CsV4veoYgvNtj8WKFB/yzoarHw
         R2FIBrrPoL8G0zDVa99CkPWKiXgbL6Auf3lYjSRxzPHIF3bxG5IZh6Qt+MkAFrA1Ef33
         DovLWnHd80wGAEaJJ844FNPA0iTRpS7krfeTCVVTDy/xE3dalIBoW0X1JX+M0mbxhJDf
         A4v7QbV7A5fTwfOzn7XsDJ2IIF/rX1AVTu7TdD6k3m9Aphdntkzt22PuWpOtr1DIB/kF
         fOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zYHSR1JNAYYpLtkcprWQuFzGoropJ2b6fHMow6KUTYU=;
        b=AjiWP1U52Z0IQ+8ftTI2phz4wwae/sg/xnI8XO0QpeTFU1UMgYH2CvedHhRtBFyzD8
         4HhgoLpg6dXhUK07B1ZXkz6JI/WWPeMgJRvFHJvp2H9/qgcb6uNfDeBrczxQeRB/x0Km
         Z+n1RO0m5BHYOHG3wD9RkQYJZUZWuFJ37MKUhooXWPXeMcLmfwzzcK6bT+2OjurcK7oH
         MIwIoTZu3evdXSJkfDoM1/kokZx48DmfHjesFVUfhBgDzKmszA52ShU/SwLbml6DtArx
         WUfUvhw8v19dtynFJ7dWoRg0LMLTttZUo9bbtUcAmurwgq0oOPyOe9cqEB5EKeHDGc2c
         3MOA==
X-Gm-Message-State: AMCzsaWYX0YfoHeDrpFXwVtmiFo0i4iy+3v4He9T71vkYXOy3r/oVB8i
        lViNp9aylY/p/xhadjArYglsfHzGmf0=
X-Google-Smtp-Source: AOwi7QA7l2sYK7PYhlEaxHOkJKqB4lnfw72xDuK4XJhbTzYBMVsWpCqwD8Eq1VR8sHUyk0yEUPX4vw==
X-Received: by 10.55.128.66 with SMTP id b63mr12269737qkd.61.1507207185308;
        Thu, 05 Oct 2017 05:39:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id z13sm6303987qtb.97.2017.10.05.05.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Oct 2017 05:39:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
 <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
 <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
Date:   Thu, 5 Oct 2017 08:39:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/5/2017 6:00 AM, Jeff King wrote:
> On Thu, Oct 05, 2017 at 06:48:10PM +0900, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> This is weirdly specific. Can we accomplish the same thing with existing
>>> tools?
>>>
>>> E.g., could:
>>>
>>>    git cat-file --batch-all-objects --batch-check='%(objectname)' |
>>>    shuffle |
>>>    head -n 100
>>>
>>> do the same thing?
>>>
>>> I know that "shuffle" isn't available everywhere, but I'd much rather
>>> see us fill in portability gaps in a general way, rather than
>>> introducing one-shot C code that needs to be maintained (and you
>>> wouldn't _think_ that t/helper programs need much maintenance, but try
>>> perusing "git log t/helper" output; they have to adapt to the same
>>> tree-wide changes as the rest of the code).
>> I was thinking about this a bit more, and came to the conclusion
>> that "sort -R" and "shuf" are wrong tools to use.  We would want to
>> measure with something close to real world workload.  for example,
>> letting
>>
>> 	git rev-list --all --objects
>>
>> produce the listof objects in traversal order (i.e. this is very
>> similar to the order in which "git log -p" needs to access the
>> objects) and chomping at the number of sample objects you need in
>> your test would give you such a list.
> Actually, I'd just as soon see timings for "git log --format=%h" or "git
> log --raw", as opposed to patches 1 and 2.
>
> You won't see a 90% speedup there, but you will see the actual
> improvement that real-world users are going to experience, which is way
> more important, IMHO.
>
> -Peff
Thanks for thinking hard about this.

For some real-user context: Some engineers using Git for the Windows 
repo were seeing extremely slow commands, such as 'fetch' or 'commit', 
and when we took a trace we saw most of the time spinning in this 
abbreviation code. Our workaround so far has been to set core.abbrev=40.

I'll run some perf numbers for these commands you recommend, and also 
see if I can replicate some of the pain points that triggered this 
change using the Linux repo.

Thanks,
-Stolee
