Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601F1EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 21:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFWVds (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjFWVdn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 17:33:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA51BD8
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 14:33:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 237AF1950A;
        Fri, 23 Jun 2023 17:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2g/fwX9tSHXQYW5FqqBIKi2L3hCBtmQKLP6+Zy
        q/Y0I=; b=hCkdWl5XOGZevV7iNI0atc1LEvYWitSnSv0auJdtGdXGQ5OjpXPAj2
        yLgwf2UorjmJ9QmrKLglOyjXyMUFy3gS4HkfiyiZWSeFkanvjfh9onnNCd9qDhjj
        AwyfMjL6ZyQWk51PYR93utwj4MBTYtn8WcXXK1RRuXNU2k/3riX2w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C38019509;
        Fri, 23 Jun 2023 17:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E60319508;
        Fri, 23 Jun 2023 17:33:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnf?= =?utf-8?Q?j=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/12] config: remove global state from config iteration
References: <20230623210217.3259337-1-jonathantanmy@google.com>
Date:   Fri, 23 Jun 2023 14:33:37 -0700
In-Reply-To: <20230623210217.3259337-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 23 Jun 2023 14:02:17 -0700")
Message-ID: <xmqqfs6hamoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D80BE0A-120D-11EE-AE97-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I've reviewed them in its current shape, but it seems to cause too
>> > many conflicts even when merged to 'next', let alone 'seen', with
>> > interactions with topics in flight:
>> >
>> >  * ds/add-i-color-configuration-fix (easy)
>> >  * ps/fetch-cleanups (easy but messy)
>> >  * vd/worktree-config-is-per-repository (moderately messy)
>> 
>> Ah, sorry. I ran some trial merges against these before I sent out v3,
>> but I forgot as I sent this out. Not queueing this version sounds fine.
>> 
>> > some of which may have graduated to 'master' in the meantime, so it
>> > might not be a bad idea to rebase on a more recent 'master' after
>> > you collect and adjust for review comments on v3.
>> 
>> Sounds good. I suppose it would also be worthwhile to base it on
>> conflicting topics queued for 'next'.
>
> Glen, if you can, rebase the patches *before* updating them based on my
> comments so that it's easier for reviewers to see if my comments have
> been addressed. (My comments are minor, so they should still be relevant
> even after rebasing.)
>
> Overall the patch set looks good aside from some minor comments that
> I've given as replies to the patches.

Thanks for a quick review (and thank you, Glen, for working on it).

