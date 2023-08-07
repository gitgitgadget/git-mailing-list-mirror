Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4869DC001B0
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHGQTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHGQTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:19:14 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B4410D0
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:19:13 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D655228FE;
        Mon,  7 Aug 2023 12:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wpjtNSVYDF2eHOSMWfpg8HOKaX7IwgKuJErfdk
        yvb6k=; b=w+jvfkMUv8Qej1cEuU5KnkDa9H8l8iEp0WZkvrVNx6u2gLd1sBeGJE
        +3TohcDqmXbpGuGzxtMm7fbLJSyTtSq/8/pZhnMd5RYW7BN+PyZ0JNj3wVkKdlFc
        juTC+5SkZf81YIsrIHv5LLucX9yelPGjBO60uDvU4Ei5ejZVfp+Mg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56256228FD;
        Mon,  7 Aug 2023 12:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2A9D228FC;
        Mon,  7 Aug 2023 12:19:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2023, #01; Wed, 2)
References: <xmqqfs518gdh.fsf@gitster.g>
        <CAP8UFD1vuB2kRr890B7GXum9HAMjRep86zy2tE4yE2C3W5QGHA@mail.gmail.com>
        <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com>
Date:   Mon, 07 Aug 2023 09:19:08 -0700
In-Reply-To: <CAP8UFD2Fw+oGz4VK=_i3B_D_VMQqMoXTJPpXRbkDiWjHciEqJw@mail.gmail.com>
        (Christian Couder's message of "Mon, 7 Aug 2023 14:41:04 +0200")
Message-ID: <xmqqv8dqhlkz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23BB4D16-353E-11EE-9F5E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> (Sorry I somehow forgot to put the mailing list in Cc: of this.)

This seems to be a response to an older issue of the report, but I
take it that the status of these two topics haven't changed since
then.

>> > * cc/repack-sift-filtered-objects-to-separate-pack (2023-07-24) 8 commits
>> > ...
>> >  Breaks CI with some environment variables configured.
>> >  cf. <xmqqo7jzh9mh.fsf@gitster.g>
>> >  source: <20230724085909.3831831-1-christian.couder@gmail.com>
>>
>> I am working on this and hope to send a version 4 soon.

Sounds good.  Thanks.

>> > * cc/git-replay (2023-06-03) 15 commits
>> > ...
>> >
>> >  What's the status of this thing?
>> >  source: <20230602102533.876905-1-christian.couder@gmail.com>
>>
>> I have a 2 week long vacation starting soon, so I will likely not have
>> time to work on a new round in the next 3 weeks.

OK.  Enjoy.

>> However in a recent article
>> (https://github.blog/2023-07-27-scaling-merge-ort-across-github/)
>> GitHub says that they are already using git-replay (though not sure
>> it's this exact version or another one), and GitLab plans to use it
>> too.

So there are plenty folks who are capable of reviewing but they are
not interested in giving it to the general public by withholding
their reviews ;-)?


