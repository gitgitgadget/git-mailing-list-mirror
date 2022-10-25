Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDDC04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 15:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiJYPg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiJYPgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 11:36:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655316EA2E
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 08:36:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F6A01BE9D6;
        Tue, 25 Oct 2022 11:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HiQ2CncR8LxYFqeIl+VK8Pj4A6WT1NcUW6tZz8
        MRm90=; b=fbMIJ+Xw/+4363/toh51GSjlWLu5RpBAz9S/jLWCrf4ZLH6et9Q8pf
        F1XQv5fzByHjoeOHiIMDOnpGliWKebbd7K9/Ye8n0VhwWN7InaNg9wTWdFw2CW8c
        KzMYGYlLoynYiv4pUUio/sTOa4LfeDSSRnl/WEEeAnoaT4ny0/niU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 77FE81BE9D5;
        Tue, 25 Oct 2022 11:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 342B71BE9D4;
        Tue, 25 Oct 2022 11:36:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/8] Trace2 timers and counters and some cleanup
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
        <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
        <0e58bd35-4f40-ce9e-1088-f7c004527aee@github.com>
Date:   Tue, 25 Oct 2022 08:36:13 -0700
In-Reply-To: <0e58bd35-4f40-ce9e-1088-f7c004527aee@github.com> (Derrick
        Stolee's message of "Tue, 25 Oct 2022 08:27:20 -0400")
Message-ID: <xmqq5yg7q5jm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2FA870C-547A-11ED-BC4C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 10/24/2022 9:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> Here is version 4 of this series to add timers and counters to Trace2.
>> 
>> Changes since V3:
>> 
>>  * Fixed typo in the new thread-name documentation.
>>  * Use a simpler NS_TO_SEC() macro for reporting the timer values.
>> 
>> Jeff Hostetler (8):
>>   trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
>>   tr2tls: clarify TLS terminology
>>   api-trace2.txt: elminate section describing the public trace2 API
>>   trace2: rename the thread_name argument to trace2_thread_start
>>   trace2: improve thread-name documentation in the thread-context
>>   trace2: convert ctx.thread_name from strbuf to pointer
>>   trace2: add stopwatch timers
>>   trace2: add global counter mechanism
>
> I re-read the series as well as looked at the range-diffs for the
> previous two versions. I continue to think this is a high-quality
> series and I've used it multiple times in my personal development
> workflow to investigate certain performance things. I'm looking
> forward to this being merged so we can all use it.

I agree with your assessment.  Let's move it forward.

Thanks, all.
