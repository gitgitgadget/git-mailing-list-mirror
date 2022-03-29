Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E150FC433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 23:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiC2XKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiC2XKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 19:10:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801AD14005
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 16:08:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8646319780F;
        Tue, 29 Mar 2022 19:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eYiR7O78VHL1ZCcFHmdg5rz97hluHM9NgoGnGC
        TQ3e0=; b=ueYI7IDKvu8RRJvjWYTw+zyTqD6YIK0dHHNSQO2j031iSts/wckW1T
        XUUDIM5Aw2VKYsbz5vumjtQ3lk7vHlkOA3nRyRYBAbr0K0G0nb2s+FDPgCj+hNu/
        SIu/ITD3koiizBOCx1roLLlU+h0yMUdNk+KiqZ4nc/2ER+cG6zzXU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F22419780E;
        Tue, 29 Mar 2022 19:08:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E912C19780D;
        Tue, 29 Mar 2022 19:08:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #06; Mon, 28)
References: <xmqqo81pxzt4.fsf@gitster.g>
        <20220329225106.GA12169@neerajsi-x1.localdomain>
Date:   Tue, 29 Mar 2022 16:08:22 -0700
In-Reply-To: <20220329225106.GA12169@neerajsi-x1.localdomain> (Neeraj Singh's
        message of "Tue, 29 Mar 2022 15:51:06 -0700")
Message-ID: <xmqqbkxoqrvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2238580E-AFB5-11EC-ACF7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> On Mon, Mar 28, 2022 at 07:22:47PM -0700, Junio C Hamano wrote:
>> 
>> * ns/core-fsyncmethod (2022-03-15) 6 commits
>>   (merged to 'next' on 2022-03-17 at c8a52f8cbe)
>>  + core.fsync: documentation and user-friendly aggregate options
>>  + core.fsync: new option to harden the index
>>  + core.fsync: add configuration parsing
>>  + core.fsync: introduce granular fsync control infrastructure
>>  + core.fsyncmethod: add writeout-only mode
>>  + wrapper: make inclusion of Windows csprng header tightly scoped
>>  (this branch is used by ns/batch-fsync and ps/fsync-refs.)
>> 
>>  Replace core.fsyncObjectFiles with two new configuration variables,
>>  core.fsync and core.fsyncMethod.
>>  source: <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com>
>> 
>
> There's a fix for this series at:
> https://lore.kernel.org/git/pull.1191.git.1648590113062.gitgitgadget@gmail.com/
> <pull.1191.git.1648590113062.gitgitgadget@gmail.com>
>
> The net effect of the bug being fixed is that anyone using the default
> core.fsync config is syncing everything except loose objects.
>
> Apologies for the bug. I noticed it when revising the perf tests and
> debugging the number of fsyncs. I'm submitting a separate patch to
> log fsync info through trace2.

Thanks.  We should have caught it during the review.

Queued.

