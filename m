Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C8C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhKVWsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:48:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhKVWsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:48:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A027155D75;
        Mon, 22 Nov 2021 17:45:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4H0KbWR4xuviRSswYTV6qaoNBzZAX+MKUj7M74
        jeVxQ=; b=jgQrQfvsmiA80OJEeMxU4z0Jj/ecj/m/xkwfruWZ8tfxkuSXW9Qf3j
        7L2WHaWUAAMbeprQpxIHGA5F/YP9K71aFwf994UptzECR1/22NYi+4AqMiCuqQz7
        npxX99j5wZxQLsoWHwsjQsVwMhBtg5FBHOuGhZ1DqRWK9l4kXpPPQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0250C155D73;
        Mon, 22 Nov 2021 17:45:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6A181155D71;
        Mon, 22 Nov 2021 17:45:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: preparing for 2.34.1
References: <xmqqr1b8gkhg.fsf@gitster.g>
        <6cc0bc51-cc28-989c-d666-75b707f2c080@gmail.com>
Date:   Mon, 22 Nov 2021 14:45:03 -0800
In-Reply-To: <6cc0bc51-cc28-989c-d666-75b707f2c080@gmail.com> (Derrick
        Stolee's message of "Mon, 22 Nov 2021 16:50:32 -0500")
Message-ID: <xmqqilwjbyj4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5941B38-4BE5-11EC-BD80-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/22/21 12:37 PM, Junio C Hamano wrote:
>> There are a few topics [*] to fix regressions introduced in the
>> previous cycle, which should be in 2.34.1 and I've merged them to
>> 'master'. I hope we can merge them to 'maint' (which now point at
>> 2.34) and tag 2.34.1 in a few days.
>> 
>> After that, in yet another few days, we will see most of the stalled
>> topics ejected from the tree, the tip of 'next' rewound, and we will
>> start the cycle toward 2.35 by starting to take new topics, by the
>> beginning of the next week at the latest.
>
> There is a patch deep in a thread [1] that is a regression
> in 2.34.0 that would be good to include in this release. It
> fixes a sparse-checkout bug via a simple revert (plus a new
> test).
>
> Sorry that the patch was buried deep and was easy to miss.
>
> [1] https://lore.kernel.org/git/72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com/

Instead of these notes, it would be much easier for people to
realize that this (and previous) week is mostly about regression
fixing and it is not welcome to drown the list with new patches, if
you just resent the patch with 

    Subject: [PATCH/regression] fix blah

I would say.

Having said that, thanks for a reminder.  I did read it, but
apparently forgot to include it in the list of things needed for
'master' when I prepared it last night.

