Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D337C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiDMQ2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiDMQ2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 12:28:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9397A4F9DF
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:25:43 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x4so2466578iop.7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3ws+Ofg2l//f5uc9SRBtsIPyfG6NrNSFywpyga2db04=;
        b=PePvze6Nqn3kWvAv3qv+xBP8cm6wxTuYN8neZwGOiG/ejnOBr6U54Gd/NJSKyATYem
         fLWOwhDr31WI9Qeys/GafA1tAJjy7SM/fHweUNFTV9zKVDkHb4pNytAzkNgszJRrAS57
         hGxZrp1t/ztdLfj2g8YRKwDQRnLTcCWI9JfmR49b+tdDX4yfb4Qi/Z+ljXMOF0enrJFc
         igg3mUQUvVq5p1qEutqGjkLMTT6AqoJdHw0LxNksTXLZoQwwEVJVBBCkEbY3S9JauXze
         eHbr+iJnosUwxVWyP+70YbjSqBN+OA1LJhHuxNAFSuQGZTY/GAqFN4fsg8KEAtC0jY19
         rFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3ws+Ofg2l//f5uc9SRBtsIPyfG6NrNSFywpyga2db04=;
        b=qFJBdYnTDnIZQNZjrQ0Lnt9g27K9qKW2mTsBq/tp6IaFdfWFKvaqFUz4uX6OanH6OH
         RPUpISjf6ll0AmBYwpg5xpAAo/wHgWQB3vqmhLwaLImgYD58gAe+55yl6BPWRe4SFMeu
         wt1kM3ABIXBnFSFZ2BPvnBbCDS6xG5dc8f+Gyt0cxQaIJZivXa3u/lQtZgU61tYDcYCt
         xA09+YN1V8YJOWIWSJfW0QYYWxULHNsHmec1B09cDdHlfWUY/rYdtURVd8PPtCQYBJ2R
         rKsMVrqm+hZ4F+v3ruAEu4fIyqhiLR5P3JHXdATyCmDd0I+Mb6cZZDJ21SLKHqEDjU2/
         OfdA==
X-Gm-Message-State: AOAM533hDRtgjzWp4ikGF1dqnZAlh0a6r1eC9iGasdi1YVxug9HGT9w7
        wXvwVe+vYYFw+kK3EwfCabcn
X-Google-Smtp-Source: ABdhPJw56skXaP+5WT9o1jRa+98uUJDPTTW9O5W7tI8vi9Z30vHE14ZGz+ozjuPsdtU0EbubvpQGYQ==
X-Received: by 2002:a05:6638:38a3:b0:326:24b9:e196 with SMTP id b35-20020a05663838a300b0032624b9e196mr9479040jav.255.1649867142976;
        Wed, 13 Apr 2022 09:25:42 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm234746iog.15.2022.04.13.09.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 09:25:42 -0700 (PDT)
Message-ID: <e8383303-e82c-dc23-9f28-6ff566021e82@github.com>
Date:   Wed, 13 Apr 2022 12:25:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
 <xmqq35iharig.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35iharig.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/2022 12:15 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is a very fast response to the security release yesterday.
> 
> Wow.  While I were down the whole day yesterday after sending the
> release announcement, it seems a lot have happened X-<.  Does your
> "a very fast" expect only "wow, thanks for a fast reponse", or does
> it also expect "ok, we'll take a deep look with a spoonful of salt
> as it was prepared in haste"?

I tried to do my due diligence here, but I will admit to some amount
of haste being applied due to the many distinct sources that have
motivated the change.

>> The second patch here is an adaptation from a contributor who created a pull
>> request against git/git [1]. I augmented the patch with a test (the test
>> infrastructure is added in patch 1).
>>
>> The third patch is a change to the safe.directory config option to include a
>> possible "*" value to completely opt-out of the check. This will be
>> particularly helpful for cases where users run Git commands within a
>> container. This container workflow always runs as a different user than the
>> host, but also the container does not have access to the host's system or
>> global config files. It's also helpful for users who don't want to set the
>> config for a large number of shared repositories [2].
> 
> Let me take a look how well these integrate into the maintenance
> tracks.
> 
> I would appreciate something that is targetted and narrow that can
> be applied to the oldest maintenance track (2.30.3) and then merged
> upwards, plus niceties on top that does not necessarily have to
> apply to the oldest ones if the surrounding code or tests were
> changed more recently.

The tests that are added are in a new test file, so hopefully
those don't collide with anything.

The changes in setup.c apply within the ensure_valid_ownership()
so should apply to any versions that have the fix.

Thanks,
-Stolee
