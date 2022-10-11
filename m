Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A7C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 15:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiJKPql (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiJKPqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 11:46:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A45051D
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 08:36:50 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0488E144AB2;
        Tue, 11 Oct 2022 11:01:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kuE+YaYOQZsO
        CbeF/QGygM4BMbDJ45DoKCUbOCBGWI4=; b=ucm40R5i6+yGxfc409A/ioABNb0T
        Cy+Te/1P4PJwN10+TBkV9GepTysRX6jbvzsX0jQXhBjdtMRA4ZrBu0kHXAX1znGg
        eEV/MDGVbKl+p1NGkYP/PbqVJRg6ZxS2XKLc+HyKDuI2VY8i6rfUYvXRr/zIcSZY
        85qGBX9RRh4YpJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED5C7144AB1;
        Tue, 11 Oct 2022 11:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52496144AAD;
        Tue, 11 Oct 2022 11:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] CodingGuidelines: recommend against unportable
 C99 struct syntax
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
        <20221010203800.2154698-1-gitster@pobox.com>
        <20221010203800.2154698-6-gitster@pobox.com>
        <Y0S0Tpn/uCjG9J61@coredump.intra.peff.net>
        <xmqqlepnxl1f.fsf@gitster.g>
        <221011.86bkqipxpv.gmgdl@evledraar.gmail.com>
Date:   Tue, 11 Oct 2022 08:01:44 -0700
In-Reply-To: <221011.86bkqipxpv.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 11 Oct 2022 10:30:34 +0200")
Message-ID: <xmqqh70awgiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F73E810-4975-11ED-AE27-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> FWIW, the use of the word "assignment" here left me scratching my hea=
d.
>>> Reading 33665d98e6b, it is about struct initialization.
>>
>> Thanks, I missed that confusion in the new description.  Perhaps
>> another round of reroll would make the series polished enough?
>
> I could re-roll it, but I also see you extensively fixed it up v.s. my
> version. I think a re-roll here would just be
> s/assignments/initializations/, so if you wanted to squash that in to
> your already extensive squashes...

I do not think there has been that much squashing.  Unless I took a
wrong range-diff in [0/5] of the series, the fix-ups are to reword
the proposed log message for [3/5] and to remove an unrelated hunk
that does "now we allow it, let's use it" which is better done
outside the topic with its own justification (and "it once used to
be there" is not a good justification) in [3/5], plus a three-byte
grammofix in [4/5].

So throwing "assignments" -> "initializations" into the mix is not
too much work for me.

Unless I forget, that is ;-)
