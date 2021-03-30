Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D545C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4156619C2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhC3R2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:28:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59721 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhC3R2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 13:28:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FA6F119192;
        Tue, 30 Mar 2021 13:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qhE7FU3B4pRtZqBit/nfFHbxtG0=; b=CUTIGP
        0cJqFvb8UQPp0U0IyA2VKc6ttTldDwaCdHYLVrLk2z/LC7j4u/Tz9QKZh5jfE6YY
        ndhqtXDmAyDwvcVriIKgD+TC58TZ1jOwt/O0Xmk8ROfiRFYcA5gYpkqXfiJiHBVd
        j1jx03AVJLEpjlBtqVRe+4MwTH33z1it8xU9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x0/9xQSsp2BCSXDcewwgaztWRpQdYmVi
        nsJFLGB5ZhkofnxvPZNG7y/dXJ88tOOOtcQu1W18LNLBPDDcOZAmSCb4hYUBUKPp
        p5sCDGHKRjepg0EaIv27wDrTCmIEY4sFjUFOi7mGJ/mB4ycrmByuW171T1NYVWvl
        bnxB7fFuwxs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47C8E119191;
        Tue, 30 Mar 2021 13:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 617AC11918E;
        Tue, 30 Mar 2021 13:28:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
        <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
        <xmqqim59irba.fsf@gitster.g>
        <f0200d12-2c0f-ee36-551f-f8133a4dea20@gmail.com>
Date:   Tue, 30 Mar 2021 10:28:07 -0700
In-Reply-To: <f0200d12-2c0f-ee36-551f-f8133a4dea20@gmail.com> (Chinmoy
        Chakraborty's message of "Tue, 30 Mar 2021 22:08:08 +0530")
Message-ID: <xmqqsg4ceel4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BD547D2-917D-11EB-9AB4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chinmoy Chakraborty <chinmoy12c@gmail.com> writes:

>> [Footnote]
>>
>> *1* The approxidate is useful when a rough "around that time"
>>      specification suffices, e.g. "git log --since='last.week'".  The
>>      user is OK to see commits down to roughly a week old, and would
>>      not be upset if a commit with a timestamp that is 9 days old
>>      shown.
>>
>>      On the other hand, it would be unusual that somebody cares
>>      enough to use "git commit --date" but yet it is OK that the time
>>      recorded is fuzzy.  For that reason alone, I am in general
>>      negative on the direction this patch tries to take us in.
>
> So according to you, is it a relevant/worthwhile change
>
> to add in docs?

That depends on the "docs".

If we do not hint that relative dates are also usable, in addition
to the more common date formats like RFC2822 and ISO8601, for "log
--since" and other options that are used to specify a boundary for
looking up existing things, extending their documentation may be
worth doing.

Giving 'tea' and other oddities at the top as if they are more
important than the formats that is used to give more precise input
for options that are used to specify what timestamp is recorded in
an object the command is about to create would be a change with
negative value.

Thanks.
