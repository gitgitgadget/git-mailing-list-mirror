Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07A9C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 16:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349320AbiEDQWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 12:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiEDQWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 12:22:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32BD46158
        for <git@vger.kernel.org>; Wed,  4 May 2022 09:18:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60C341A630B;
        Wed,  4 May 2022 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hRTh/J3Ii5XKVPaIZYO7mU7XjEZ9B3nY/3fn/4
        SXMjs=; b=e88XHxeVHguomur5ourqeJIeCLQL68lS4bb8m3Urhl6nv9EnCdysPI
        wXTEik3TeHwtN05/ZUR9w4SK/XsPT5gPAloUc5KkTE6g83rDY1wDoNUM3cRD3bes
        TFyyT9ZAPiQgr4vs8J91kdBRgzo5bGBzUB8n7LPJNMMML9dAHwT4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59F861A630A;
        Wed,  4 May 2022 12:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D610D1A6309;
        Wed,  4 May 2022 12:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: What's cooking in git.git (May 2022, #01; Mon, 2)
References: <xmqqilqnvacd.fsf@gitster.g>
        <0facc01f-ee36-333a-eb25-9c98d616700e@github.com>
Date:   Wed, 04 May 2022 09:18:47 -0700
In-Reply-To: <0facc01f-ee36-333a-eb25-9c98d616700e@github.com> (Derrick
        Stolee's message of "Tue, 3 May 2022 17:19:57 -0400")
Message-ID: <xmqqy1zhmftk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E133EC42-CBC5-11EC-9FA5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 5/2/2022 6:27 PM, Junio C Hamano wrote:
>
>> * ds/sparse-colon-path (2022-04-26) 5 commits
>>  - rev-parse: integrate with sparse index
>>  - object-name: diagnose trees in index properly
>>  - object-name: reject trees found in the index
>>  - show: integrate with the sparse index
>>  - t1092: add compatibility tests for 'git show'
>> 
>>  "git show :<path>" learned to work better with the sparse-index
>>  feature.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
>
> I think this is stable and ready to go. Unless anyone else wanted to
> take a stab at reviewing it. I think we've got good eyes on it already.

Thanks.  I read over the conversions and they all looked sensible.

>> * en/sparse-cone-becomes-default (2022-04-21) 9 commits
>>  - Documentation: some sparsity wording clarifications
>>  - git-sparse-checkout.txt: mark non-cone mode as deprecated
>>  - git-sparse-checkout.txt: flesh out pattern set sections a bit
>>  - git-sparse-checkout.txt: add a new EXAMPLES section
>>  - git-sparse-checkout.txt: shuffle some sections and mark as internal
>>  - git-sparse-checkout.txt: update docs for deprecation of 'init'
>>  - git-sparse-checkout.txt: wording updates for the cone mode default
>>  - sparse-checkout: make --cone the default
>>  - tests: stop assuming --no-cone is the default mode for sparse-checkout
>> 
>>  Deprecate non-cone mode of the sparse-checkout feature.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
>
> This has been quite stable and I'd like to see it merge early in the
> release cycle in case that catches anything during local testing.

This one I am not worried about stability all that much; I am more
worried about breaking those who do not believe in "cone is the
future" and managing their expectations.

Thanks.

