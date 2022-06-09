Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE6C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 19:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiFITjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 15:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiFITjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 15:39:41 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F29E26C
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 12:39:40 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n11so3328883iod.4
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 12:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0SZDhGqCZe8GLd3HJN9lpqeFznBa7BPUf7KPi1/s9JQ=;
        b=XuJjqsDLtzNTEWDq+fgv4IDG9KjQx+rDNwacZZyS6Xy53niT5gPjMEvvmG7ZEroBiW
         LMgSYu8bGIGPXj1fn1dOlznbmi3LQAAUX4tonjUmfyPUKRaGra8v0Dy3J9q2YzPdV2Kk
         P9Zew1qaPboS2D7P/ViAFVVWr6KpuoReFmLMIuINfX8oTkgJ4DcbY7OG/G95AYWn4xIT
         XutgwllY3/8XRcCqrXprh1HFi3/l6C8OSsqhN7p2IAj15DdxckePPAZc7KgwN9FTQZfR
         p78ewXJtrhBANt8EdA/0Fs9lFIDNXdZWnA/XbmPmElKa9cl/znS7yzCZ3CsBQbWfyO1d
         0ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0SZDhGqCZe8GLd3HJN9lpqeFznBa7BPUf7KPi1/s9JQ=;
        b=EjL6j/Z6ibFQqWuV8rdt0tpE+AnttNi2fKxPPIrFNj6wYKNV1kK2Xnot/YwJiKTC8C
         ZUcOB33QKPTSrnIWC8o0WnBjbTnBFI7xivOtKj6kDJevnou19ZuFr8iB+eUHvqc7tfe0
         OxoYwOWH/KgMC/vyXB3ocQcKtaMELzed64Dz75fftPKCRWXRp/tJxI6WZEVUOj0SoHqp
         iv21HvridhL/AZKqlVbUm9Ec93BXsKTpaSh/iqpkXVzyIm+gU2vymoGGTj3Q4i9EsYHC
         qVFcoCm/jnqTnmWty52suo4cx8p8FS+UGpaq4TaHMxIewatabH2TL3/h5lqLzMD/qpp7
         dUnw==
X-Gm-Message-State: AOAM533JoAraZTcHzqDng1ALVWI/tBb1FwVaKvqtf7L8kSeUJxOQnOdw
        lcxSwN2RshSgkr89LuRCLG1g
X-Google-Smtp-Source: ABdhPJzcO6kod54Am3Ze6ZXaS2BHeAsDGI0+qbjasaPwfV+qx6fCzx+O+a5mUBSaKSKwv1n5fceRYQ==
X-Received: by 2002:a05:6602:48a:b0:65b:413f:a66c with SMTP id y10-20020a056602048a00b0065b413fa66cmr19810352iov.137.1654803579702;
        Thu, 09 Jun 2022 12:39:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:495e:d490:1505:7440? ([2600:1700:e72:80a0:495e:d490:1505:7440])
        by smtp.gmail.com with ESMTPSA id k10-20020a92b70a000000b002d1eb84e4fasm10692818ili.83.2022.06.09.12.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 12:39:39 -0700 (PDT)
Message-ID: <1ad2435b-f6a5-dc17-1ee1-ffa8c127f04a@github.com>
Date:   Thu, 9 Jun 2022 15:39:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
 <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
 <xmqq5ylarhsg.fsf@gitster.g>
 <3d67b69b-fac8-3171-92dc-303ea672efbf@github.com>
 <xmqqk09plnze.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqk09plnze.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2022 1:56 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>> Ævar's observation that bundles also add ref tips to the packfile is
>> the key to breaking down this concern: these ref tips give us a way
>> to negotiate the difference between what the client already has
>> (including the bundles downloaded from a bundle provider) and what it
>> wants from the origin Git server. This all happens without any change
>> necessary to the origin Git server.
>>
>> And thus, this bundle URI design came about. It takes all of the best
>> things about the GVFS Cache Server but then layers refs on top of the
>> time-based prefetch packfiles so a normal Git client can do that
>> "catch-up fetch" afterwards.
> 
> Yup.  My observation was that (1) you would need ref tips in some
> way, (2) you are conveying not just "here are the set of bundle
> files", but "this bundle file has these associated attributes" (like
> .timestamp, and .uri to fetch it from), in the table-of-contents the
> clients are expected to obtain anyway, hence (3) you could, but you
> do not need to, use bundle as a way to convey "packfile contents
> plus refs" to the clients (iow, instead you can use packfile and
> then report these refs information in the table-of-contents as more
> "associated attributes" to the items listed in the table-of-contents).
...
> Starting from "bundle URI standard" document at the beginning of the
> thread, if we replace all the mentions of "bundle file" with
> "packfile" in it, and then add .positiveRefs and .negativeRefs to
> each "packfile" (renamed from "bundle file") as additional
> "packfile.<id>.*" (renamed from "bundle.<id>.*") attributes, without
> changing anything else, the result would be feature equivalent to
> the original "bundle URI standard", I would think, but without
> having to wrap a packfile in a bundle file?
> 
>> I hope I am going in the right direction here, but I likely
>> misunderstood some of your proposed alternatives.
> 
> I wasn't seriously "proposing" an alternative.  It was just that it
> looked wasteful to go to a separate format (i.e. bundle) when packfiles
> should suffice, as you would be adding extra information that is not
> in bundles via the table-of-contents anyway, and what is given by a
> bundle that is missing in a packfile is only the refs information,
> which should be trivial to add to the table-of-contents.
 
Ok, I've trimmed your latest reply to focus on the main point:
"Why bundles?"

You are right that we could use a table of contents to list the
metadata that we need (that is currently stored in the bundle
header) except for one case: the single bundle. If the provider
wants to skip the table of contents/bundle list and only provide
one file that bootstraps clones, then we need something more than
just a packfile.

This could be remedied by _requiring_ the table of contents with
the ref list, but it does lead to separation of the packfile from
the important ref information.

Further, the provider might want to cover a large number of refs,
not just the default ref. That would increase the size of the
table of contents more than necessary.

With these things in mind, I do still think bundles are a good
way to store and share this data.

Thanks,
-Stolee
