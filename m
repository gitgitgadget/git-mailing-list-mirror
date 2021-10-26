Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB3BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809A26109D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhJZRaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhJZRaH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 13:30:07 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ADC061243
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 10:27:43 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id r15so15909572qkp.8
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aHUTEoD5aHVZvZdIQc80IE+6He/KRi5rp/0A8H0UCyA=;
        b=Gk8FKspaESPdPRoNGIN2FVm1+fqIBRWcov+2oIHcJD4q+Stf/MOCZD+lWPoPMsmxdA
         TIBiyqnSjBVhpFYe3EcWp5adFFEl+iODlYLd501IE9GfEM01/XqQQ4L8ef4y2da2xska
         s+xku+4ZaFzyx+eJzGhMd4Fwc+5Vt9zZp7SkIVV54jZWO12M6UdIf/mMnfnV8fSzvL4e
         7OfSgt6TEQecCzkY5T3iCSjBv2sLN4P7fkjRKJo9pbXl/ZfBBMcBWkDJkwP00POGG0Pc
         a6yTOpJFyIxesAYDXn2hKQBf0eWo1n74xjSkpfabvHWp8ZefJ46dgPN/V80Sy3TUlyX8
         6fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aHUTEoD5aHVZvZdIQc80IE+6He/KRi5rp/0A8H0UCyA=;
        b=e0NY5BCDwK4f9Q0wC3ClzUS5NBkqVslSvCucErY4VScmM9IIQ6TPg0QcTBE4/Kud3D
         tKcBUxNuK/Ax+BPpk+/Bf12NWeQBrf83Megbd2/sEhCrb4FxJTh6lHFWDbeSc9AYPpry
         WZ8u+nnOL3sf1xqoKamRTcr72mO+NcA4/gaAsyhTnSMa4H3Wtf17F4pOpQlUpojBCcJ2
         54XTga27+Z7oyU0b8pApzw8XynyomSp53JSGzEt6qL1jPYrYuQaLO3rHvhbLtGrTCmyd
         OISdt/l9J1cCaN8Zcdhc5hyVnL7pEpQffAjsCjm1pAtX7DrpvVNDCR59LCN3AgTy7n+q
         67UQ==
X-Gm-Message-State: AOAM532beZSS6wMcJAEsVbhtvideCjb1HbarJ/D+ixhFrGs2H0j3pLFM
        gr/tbiVMJPSMiDISczpsBihTZB6IfAKx
X-Google-Smtp-Source: ABdhPJw710SJZjRNJgyUE+BblUp0qenGs0FDD42/nOlC3GKcbqj+IWoMsW4FYTwSTPAE8H3y7luXrA==
X-Received: by 2002:a37:ae43:: with SMTP id x64mr20295418qke.55.1635269262857;
        Tue, 26 Oct 2021 10:27:42 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id x15sm11421587qkp.113.2021.10.26.10.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 10:27:42 -0700 (PDT)
Message-ID: <664f452a-e57e-bb19-78ea-1712f1d0de07@github.com>
Date:   Tue, 26 Oct 2021 13:27:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
References: <xmqq5ytkzbt7.fsf@gitster.g>
 <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
 <211026.86h7d3zvao.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <211026.86h7d3zvao.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Oct 26 2021, Derrick Stolee wrote:
> 
>> On 10/25/2021 11:48 PM, Junio C Hamano wrote:
>>
>>> * vd/sparse-reset (2021-10-11) 8 commits
>>>  - unpack-trees: improve performance of next_cache_entry
>>>  - reset: make --mixed sparse-aware
>>>  - reset: make sparse-aware (except --mixed)
>>>  - reset: integrate with sparse index
>>>  - reset: expand test coverage for sparse checkouts
>>>  - sparse-index: update command for expand/collapse test
>>>  - reset: preserve skip-worktree bit in mixed reset
>>>  - reset: rename is_missing to !is_in_reset_tree
>>>  (this branch is used by ld/sparse-diff-blame.)
>>>
>>>  Various operating modes of "git reset" have been made to work
>>>  better with the sparse index.
>>>
>>>  Needs review.
>>
>> This topic had good review in its first three versions, and the
>> current v4 has had one response that doesn't seem to have actionable
>> changes. Could you re-evaluate if the "needs review" label is still
>> appropriate?
> 
> [CC-ing Emily, the author of that one response]
> 
> Per [1] I think it should be "expecting a re-roll", unless I'm wrong
> about Victoria's "I can add that in my next version[...]" there, or
> missed some subsequent exchange not in that thread.
> 

I am planning to re-roll with that test update, but I wanted to give it some
time to see if other reviews came in. I'll send a new version tomorrow at
the latest.

> Or maybe it should be marked for "next", I haven't reviewed the latest
> version myself, just trying to help by filling in the gap about what the
> label should be, if not "needs review"...
> 
> 1. https://lore.kernel.org/git/16fbc2dc-6fdd-ed0d-ebc6-3b0566142879@github.com
>
