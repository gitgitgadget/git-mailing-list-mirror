Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B974C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0C60E95
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJWVdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:33:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59963 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJWVdy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:33:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 471FAE9871;
        Sat, 23 Oct 2021 17:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9BWGBYGUC03U
        m9oFlQfLlD12uC+UfQ/j5YBKjS3pGUU=; b=jK0JmqgCNGqo5nLAt1MkNXMzDCtN
        c92th8wDrnOLybNyCdn+uWPUFMKV+CWkkF6aLBArjIASTXyJxWfIALGZOZjsTdl3
        QcuVjw6/nx2/x+wzQbtbFYW965kFzMk7qKMEMc0zIrilmbAEHp5pF0IgonX9O6QN
        BZ0u3hz200tMIxM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E8EDE986E;
        Sat, 23 Oct 2021 17:31:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97CBCE986D;
        Sat, 23 Oct 2021 17:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: SubmittingPatchs: clarify choice of base and testing
References: <cover.1634787555.git.me@ttaylorr.com>
        <cb30aa67c0023c435cf472303bbf4894c8b2d7ec.1634787555.git.me@ttaylorr.com>
        <211021.86ee8emx57.gmgdl@evledraar.gmail.com>
        <xmqqpmrykys9.fsf@gitster.g> <xmqqilxncwpr.fsf@gitster.g>
        <xmqqa6izcwio.fsf_-_@gitster.g>
        <211023.86bl3fih42.gmgdl@evledraar.gmail.com>
Date:   Sat, 23 Oct 2021 14:31:32 -0700
In-Reply-To: <211023.86bl3fih42.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 23 Oct 2021 22:59:00 +0200")
Message-ID: <xmqq7de3bf7v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 982340DA-3448-11EC-AB9A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Maybe it would be useful to have a CI target that merged to next/master
> and reported how that went? It would have to be a soft failure, as we
> might have an easy merge conflict, or someone's pushing a revision to a
> topic that's already in "next" or "seen" (and might conflict). But
> having it as an FYI might be helpful.

Sorry, but it would defeat the whole point of this suggestion.
Letting CI do it to allow contributors not to worry about other
people's work is the *last* thing I want to encourage.  I want
to see people get in the habit of making trial merges and ensuring
their work works in the wider context than just "my patches work in
'master'---it is not my problem if it does not work when patches
other people already wrote are present".=20

> This seems like a good clarification, but partially unrelated to the
> $subject, i.e. just the last bullet point is directly relevant, the
> first two are new general advice. Perhaps split those out into another
> commit?

Not really.  The original didn't say in what situations you would
want to refer to other commits.  Clarifying that made a three-bullet
list, and all three are equally relevant.

Thanks.
