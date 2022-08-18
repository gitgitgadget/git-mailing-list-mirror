Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BD0C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245582AbiHRRj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiHRRj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:39:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEE51A38
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:39:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C07721BF04C;
        Thu, 18 Aug 2022 13:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ab4tO5TDhCzHaUjGGhu7Q9suoO2FLcQ1UYr74q
        NyDQI=; b=BiJPvWQLO0lryfPonWL7YstzLuqmZbJuy0CgcN18MoE8SpajEvhEKG
        vP3wNjJMbCKkxhwN0eY1kdDAxkXYmKijQMRX2caieD4iVWwtno+bdgwUxiKhxfJP
        UhAjZrrk7NK2cdq8wsTjdiiHB661zFE5NT4YI8ZZVanXjVyCOQb4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A749E1BF04B;
        Thu, 18 Aug 2022 13:39:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1F4D1BF04A;
        Thu, 18 Aug 2022 13:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/* (was Re: What's cooking in git.git (Aug 2022, #06; Wed, 17))
References: <xmqq7d36s31e.fsf@gitster.g>
        <fbcb87f4-00fa-3371-e108-a104be7ae501@github.com>
Date:   Thu, 18 Aug 2022 10:39:19 -0700
In-Reply-To: <fbcb87f4-00fa-3371-e108-a104be7ae501@github.com> (Derrick
        Stolee's message of "Thu, 18 Aug 2022 11:00:18 -0400")
Message-ID: <xmqqilmppi2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B11D25AA-1F1C-11ED-88F6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 8/17/2022 10:23 PM, Junio C Hamano wrote:
>
>> * ds/bundle-uri-clone (2022-08-10) 5 commits
>>  - clone: --bundle-uri cannot be combined with --depth
>>  - bundle-uri: add support for http(s):// and file://
>>  - clone: add --bundle-uri option
>>  - bundle-uri: create basic file-copy logic
>>  - remote-curl: add 'get' capability
>> 
>>  Implement "git clone --bundle-uri".
>>  source: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
>
> This series has been stable for a while. Please consider merging it
> to 'next' when you are ready.

I think earlier rounds of this series were fairly well reviewed and
the interdiff in the cover letter has nothing questionable.

>> * ds/decorate-filter-tweak (2022-08-05) 11 commits
>>  - fetch: use ref_namespaces during prefetch
>>  - maintenance: stop writing log.excludeDecoration
>>  - log: create log.initialDecorationSet=all
>>  - log: add --clear-decorations option
>>  - log: add default decoration filter
>>  - log-tree: use ref_namespaces instead of if/else-if
>>  - refs: use ref_namespaces for replace refs base
>>  - refs: add array of ref namespaces
>>  - t4207: test coloring of grafted decorations
>>  - t4207: modernize test
>>  - refs: allow "HEAD" as decoration filter
>> 
>>  The namespaces used by "log --decorate" from "refs/" hierarchy by
>>  default has been tightened.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
>
> This has been stable for a few What's Cooking mails. Should be
> ready to go.

This one I am not as confident as the other one, though.  I actually
was thinking that this may be getting stale, not stable, without any
further "I read it once again and this round looks good" X-<.  Let
me see if I can find time to read it over before I decide.

Thanks.



