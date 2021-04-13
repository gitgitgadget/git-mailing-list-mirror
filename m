Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ACC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF672613C4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhDMTTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 15:19:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52416 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhDMTTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 15:19:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07A68137863;
        Tue, 13 Apr 2021 15:18:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kxpDloOT/YKT/tD74Lmwkldx/iI=; b=djUHVR
        rG8TWaIFaQgo+kLt/yeknuy4wUeM7u9HFPD2wgeib7kcWldwWJrpf2S3V7E0H4pw
        j0LIR5QSG2Bs6dkTNvpyJDFA288lZLtmI/9y0BWUqzRJD1zJaQa8EAkElt07cavW
        tVRfyRafWWqTzYM708AU/77EPosFJRlO1mqKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kV6mT9W+Q3ttoOijQ/LW36ph7f7fGZjb
        CZOJwJKzGSauZxFt/8IBfs/caQs+w8QLqwf/6HW8/1upDgMPD7ZopnNmuWXhPaEo
        4cqAzlOJ3I7isZxNEQQ90+CZZB21zDkjJpM3rGPGM8tBW2NGFMvbMMAVFZO4/NcS
        CjHVYK9+/N8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F2E3D137862;
        Tue, 13 Apr 2021 15:18:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 44D87137861;
        Tue, 13 Apr 2021 15:18:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
        <xmqqsg3vb51n.fsf@gitster.g>
        <CAP8UFD1r2kUaKbjFcRn_FGxz5=hvwY+DHdmPKR61cNdHzBe26A@mail.gmail.com>
        <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
Date:   Tue, 13 Apr 2021 12:18:36 -0700
In-Reply-To: <CAOLTT8TB9UF5z-51pLxdkRUxo5-w2+_U_e1wpDAdzBBmT3Og7w@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 13 Apr 2021 20:02:47 +0800")
Message-ID: <xmqq35vum1rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CBD36E8-9C8D-11EB-B341-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> It might be desirable to make it easier for people to migrate from
>> ".command" to ".cmd". I agree this is debatable, but I don't see a big
>> downside in it. Maybe, if no argument was passed at all the first time
>> the command is called instead of the empty string, the command could
>> then know that it's called for the first time. I am not sure this
>> would be very helpful in practice though.
>>
>
> If i'm not wrong, Christan meant that this command must run so it's
> "consistency", and Junio thinks this "consistency" is not needed.

My stance actually is a bit stronger than that.  I suspect that
running the command without argument once even when no --trailer on
the command line asks for that <key> is a misfeature, if not a bug
(only because it is now documented by 1/2 as such---before that, at
least I did not read the document that way).  And unless it is shown
that it is not a misfeature but is a useful behaviour with an example
use case that benefits from it, I would prefer not to replicate it
in the ".cmd".

> It is true that there is not much harm in keeping `.cmd` at the behavior
> of `.command` now.

It is far from "there is not much harm".  It misses the whole point
of the exercise.

Only replacing the first occurrence and not the second and
subsequent occurrence is not what we are keeping in ".cmd".

Replacing in an unsafe way with respect to the command line syntax
is not what we are keeping in ".cmd".

That is because these two are misfeatures if not bugs (only because
they are documented).

In fact, the only reason why we are introducing .cmd is so that we
can deprecate .command and get rid of its misfeatures while keeping
only good bits.

So I am waiting to hear why it is not a misfeature.  If it is not,
then surely I am fine to keep it for now and add a workaround later,
but until that happens, I do not think "commit --trailer" can be
used as a way to allow end-users emulate "-s" for their favorite
trailer like helped-by, acked-by, etc.




