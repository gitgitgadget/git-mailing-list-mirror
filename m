Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D2C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 12:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiCOM6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCOM6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 08:58:41 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6A74E39E
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 05:57:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id w20-20020a4ae9f4000000b003243aa2c71aso4159683ooc.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AyP2ZbhxEFpEP6D9l+yx6RS4Q8I2w0HIMkLnayh/s4A=;
        b=LBdrjwIzbJlbruWd8/Huw7TMmZKirsaAHfEjoNlXh8AkU2HkGtq8IEuSFEKdhgNSbt
         EWC3NI+gEzkDN923F06iK1KuHF9CI4y5hOtKKk0YuzvslY1MH+6pSDuN6SFFQsHkJV+k
         7ckdOWmRi0e1hBPrNZmKZf3V4I1NHERholq/Or7/v/Mmnd0UKdZwQU4tnHLBb6NuGvkh
         J8TghO+BhlsOybR7VnBq0nDz0o6T5gnyP/Yx1ANBLJsA9cq6ZEFESJAjo2NTO9K3qE5U
         65uqRkbcqwvwaWLM7vyFJhpAGoAedxi+9ueYSYdyl6U6KbNxAIQufKQy/96jHxq9zcgC
         Astg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AyP2ZbhxEFpEP6D9l+yx6RS4Q8I2w0HIMkLnayh/s4A=;
        b=CU1rug/H3hghFN/JO2U/O/H4Mn2wlUVHSUQpBBJ18eWpzdApGIpZFJbFAg5kCpjBeO
         bK+EvVAHjFuc0sY1j8z9nYhtczfdm3ASBe1pL4Ohg2wEgH1luQ5gzs/x/i4k7aXKCfMK
         QMcqRRWwARFfucv+CCNaePEqnTsvDPO+4EO3RcgDYRD9G2TP7j54PscU2uhDvp7txwAI
         UYQjn/D34tspjgAUlVfRjUWYRkXcuyKn0Bfnip56FIl/htJr+Y39vTuTWy3qyqPhkQmJ
         QjRrl5FaAoWKW8gcTVtmPHIA4SF+wgoThUCKYUI6AQP+TfxyUvlrRDLjuDB/h0zKADxD
         cIFA==
X-Gm-Message-State: AOAM533J1wiT0jOx4ybdLA6fSbDDhh1YHewJ14OBej0QT1rGgSPwuYLO
        bXpBWiv+c8KZD5PKo58DRwAn
X-Google-Smtp-Source: ABdhPJz31QUcsNk3MeclRkTKAj+oSd13wCBKx6aDXEi9HvQbpQFHbQicstTQy6NkDkfpwCRQaqKe0A==
X-Received: by 2002:a05:6870:82a6:b0:dd:9f36:cdc3 with SMTP id q38-20020a05687082a600b000dd9f36cdc3mr754oae.260.1647349048801;
        Tue, 15 Mar 2022 05:57:28 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p21-20020a4a2f15000000b00320fca09b74sm8829453oop.1.2022.03.15.05.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:57:27 -0700 (PDT)
Message-ID: <4d78dece-1212-5232-a441-683e941016c5@github.com>
Date:   Tue, 15 Mar 2022 08:57:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqa6dsnpj9.fsf@gitster.g>
 <20220315113002.61748-1-chakrabortyabhradeep79@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220315113002.61748-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2022 7:30 AM, Abhradeep Chakraborty wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> I found it quite a roundabout way to look into trace to see if
>> a "fetch" was run to determine if we are doing the right thing.
>>
>> Regardless of whatever mechanism is used to lazily fetch objects
>> that have become necessary from the promisor remotes, what we want
>> to ensure is that the blob object HEAD:new-file.txt is still missing
>> in our object store after running "log --follow", isn't it?  In a
>> future version of "git", our on-demand lazy fetch mechanism may not
>> even invoke "git fetch" under the hood, after all.
>>
>> Don't we have a more direct way to ask "does this object exist in
>> our object store, or is it merely left as a promise?" without
>> triggering a lazy fetching that we can use in this test?  I think
>> such a direct approach is what we want to use in this test.
> 
> I did think of other ways to detect the downloading before. Initially I
> thought of using grep functionality to see if any download related
> messages are printed or not. But I found that `git log` doesn't print
> any download related messages (e.g. like "enumerating ...."). So, I
> dropped that idea.
> 
> The next idea that came into my mind was to detect if the previous file
> (the file from where the new file is renamed) is still missing ( you're
> suggesting the same approach). But the problem I faced with this apprach
> is I didn't find a way to detect if the file is missing.
> 
> I tried to use `git rev-list --objects --missing=print` with `HEAD` and
> first commit hash. But in both cases, I didn't found a missing `[?]` sign
> before ` <blob-hash-ID> file.txt`. That means, both blob objects ( or I
> think the same blob object) exists in the local repo.

Ah! This method really should have worked. And the test as written
is not testing the right thing, because we also skip downloading the
blobs if we already have them.

I think the key issue is that your clone says this:

+	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&

which will do a checkout and download the blobs at tip.

If you add a "--bare" to this clone command, then no blobs should be
downloaded, and your rev-list command should show the missing objects.

> Most probably, this is because the content of these two files are same.
> Blob object is never modified. So, as far as I think, both base trees ( one
> which is pointed by the initial commit and other which is pointed by the latest
> commit) is pointing to the same blob object. As a result, the file is not
> missing. ( I am not sure if git really does it as I said; sorry if I am
> wrong here)
> 
> That's why I asked Derrick to help me detecting the download and he
> suggested me this. It is true that this is not ideal (use of `fetch` may
> change later). But this was the only option that I can go with.
> 
> If you find another/better way or if you think I tried to use `git rev-list
> ...` in the wrong way -  please tell me. I would be very happy.

Hopefully my suggestion to use --bare will help.

Thanks,
-Stolee

