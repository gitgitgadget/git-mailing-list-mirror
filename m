Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F99C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC94860F23
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhJWUaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 16:30:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55717 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhJWUai (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 16:30:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADC2FE9298;
        Sat, 23 Oct 2021 16:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3j+nYt0hm1YFNgkL61hLVgGi3tt8NjHigGjORz
        v32s8=; b=IqwXTc/BQVwGHF9i1VxitS9IxJEFFMSH7UdyiY+jqlDzhrdOiuE6rX
        jSP67ZUCaqD/lFf2e9Wq3GwdCma7UUGqhExwIrAqOMO6xGoA3VEi3+/JzVamrSDe
        9xE5U/H4WANi48pTJ/6YZWqsHNNCDnHVYprP1EZI6sjm0UdqxqX+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5838E9297;
        Sat, 23 Oct 2021 16:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 147CDE9296;
        Sat, 23 Oct 2021 16:28:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 10/11] pack-bitmap-write.c: don't return without
 stop_progress()
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g>
Date:   Sat, 23 Oct 2021 13:28:16 -0700
In-Reply-To: <xmqqpmrykys9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Oct 2021 11:39:34 -0700")
Message-ID: <xmqqilxncwpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1D244C0-343F-11EC-9CA0-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Looks good :) Just a note that this is in
>> "ab/only-single-progress-at-once" already in case you didn't spot it.
>>
>> That series is marked for "next?" (with a question mark) by Junio in the
>> latest what's cooking, so *hint* *hint* for any last minute review :)
>
> I wonder if it would help contributors if we give them a simple rule
> to follow before sending their patches out:
>
>  - You develop on an appropriate base (either on maint, or master,
>    or a merge of selected topics in flight you absolutely have to
>    depend on) as usual.
>
>  - You test merge the result to 'seen' and to 'next'.  If you do not
>    get heavy conflicts and the tests pass, you are OK.
>
>  - Otherwise, you study what is conflicting, and should review it
>    before you submit your topic.

Addendum to this third step.

     ... Also, if you chose to depend on other topics when you
     decided on the base in the first step, giving them your review
     would be a good way to show others that _you_ understand the
     code that you are building on top of, which in turn may give
     others confidence in your topic.

Thanks.
