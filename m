Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB1AC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhLATd0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbhLATdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:33:09 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06AC0613DD
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 11:29:10 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id m25so25128216qtq.13
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=0QYDieCbIeNKXLqpkHjKz3/uR69A3b/HjTeEU4PBZng=;
        b=dk8O/TbrmlPnRxJOAyS+wnXbfoy39r8husSseTboSVH0J0FRGdPU6gQn0s/ExguI99
         43FO9yS2P1FdJrA7NWFGvRN2KtS4wFDtNj2TOQeCjbITNAc+vt2Eg2aAxmh6KxNpsS1p
         epss/qJ4Smdl1RztuLWszzDYTKHCrmmVDqG8l9+c1bXraN+4VuFkfs2rLFVfhW3GZyxd
         6msw0UBVIvTKBKdktqP35uXN/Sx1lBdEuATHcFHogXPFoeqsC3Cyq2KdHd7fBpL5AtJG
         JKGbliwhQzy771xiUj04eRj05xrt1ulyINztS3j6YIxkaLKBTkhZdS3RDpPV90j5M0Dl
         rmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=0QYDieCbIeNKXLqpkHjKz3/uR69A3b/HjTeEU4PBZng=;
        b=Vg9wuBBHz9lcxSYDUaPKFFoU7yHk1tn83zFwAYSWJz/1RG4aevaREdl0+8SAKLZNsw
         AqDJoYMFMSiHVareVDLavFiTNA/GiLNZZ1LIbjSRoJssOJRYOp/xThiMk6/PdBtGoMOW
         CQ5R+IO5xyoAeC7TcADC1FCr7NC1Peys6Z3xXDIuUel7tHOWp4EX7fJZsITJA22uTlep
         23Hsnj6Qjl/KbyCAapPdgDGSKEVtGN5+q+mIRqQIazQ6atQD7001i37z7zMejqt4d3n/
         uCBk7MTJNpgGAJ10gwTU+gykgmA2+11J05TlCCrhS8G3/8ZiRCj2PLvnV7vDT6m+v+WT
         8s7A==
X-Gm-Message-State: AOAM531Fir9LBYPk6YLQAsamkkPmZjyqGhikf7wuxz8ib3z6PcRreddw
        MI3G9TrVit3mY79IMtahUBBe
X-Google-Smtp-Source: ABdhPJynbOhHPomPPHCMJJAkdggi5AwR8X6yM23D0fi4zmLRYSdO5QK/4uqPUn3Hw1l+SzIEIl9Ung==
X-Received: by 2002:ac8:5991:: with SMTP id e17mr9118975qte.344.1638386949558;
        Wed, 01 Dec 2021 11:29:09 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id t18sm354936qtw.64.2021.12.01.11.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:29:09 -0800 (PST)
Message-ID: <afdf6810-3e73-d0f3-ea02-c78ba6f7b908@github.com>
Date:   Wed, 1 Dec 2021 14:29:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
From:   Victoria Dye <vdye@github.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <xmqqzgpm2xrd.fsf@gitster.g>
 <CABPp-BE=NhC0W7H2uF3LuSNOEXfdLw7KH11YXVz6G53QF6gE8A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BE=NhC0W7H2uF3LuSNOEXfdLw7KH11YXVz6G53QF6gE8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
>> * vd/sparse-reset (2021-11-29) 8 commits
>> ...
>>  Will merge to 'next'.
> 
> There were two tiny issues pointed out at
> https://lore.kernel.org/git/9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com/,
> but it'd be fine to merge the series as-is and consider those as later
> potential improvements.
> 

In the interest of avoiding further delays to (and maintenance burden for)
the other in-flight series dependent on this one, I'd prefer including those
fixups in my next set of sparse index integrations.
