Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E677C2BA19
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 03:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56B42072D
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 03:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kz13c5pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbgDPDUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:20:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53904 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbgDPDUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 23:20:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE14866192;
        Wed, 15 Apr 2020 23:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uoUN3qcslX0OnNtAAuFuDhi42H0=; b=kz13c5
        pbdiJWUE+BuBz83csjY0thwKNtZU5FYCYbZAx8H9QugMnqOFefnr4X3UwluJ5cMY
        eyE8X8mYjJfAu0KZfi/t5lL9I3Q6N2YiYTMaxqaWGmy2Jrc7wU0neHYlkBuu+ttN
        mEIUIHtMLgLl3WAZXD3ob50NxJxm1+lV6M4kI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b9lxOnbIdLzwKdanAL8DeC8HPrSagNV1
        mS4Mlu+gbz3TEWcEml8s9kQHmuXHsqqjdc5dVIZks7hdK0uwG4J645nv3CVIbZW1
        zgqDdBceaLfmPcOYYr+9rOBvxmHA4MG1nHmElgQHZnKx0KF7GcND4R8HjQQBKGI/
        AG3CXWA0SQY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5A1166191;
        Wed, 15 Apr 2020 23:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6537166190;
        Wed, 15 Apr 2020 23:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: fixing ci failure of 'pu' with the es/bugreport topic
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
        <xmqq1rovl54d.fsf@gitster.c.googlers.com>
        <20200410174141.GB27699@danh.dev>
        <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
        <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
        <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
Date:   Wed, 15 Apr 2020 20:20:31 -0700
In-Reply-To: <CAJoAoZk9Y9rc7ssfZ6S3pYepK6LpapoSzBAQjL+f7uHXv79HWg@mail.gmail.com>
        (Emily Shaffer's message of "Wed, 15 Apr 2020 18:55:31 -0700")
Message-ID: <xmqqwo6g2k1s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AF4AF06-7F91-11EA-9F9C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Hm, ok. I'll send a reroll squashing this in verbatim tomorrow unless
> I hear otherwise from Dscho? Looks like it's indeed the first one
> (dd763e).
> I'm curious to know how I can check this build method for myself for next time.
>
> (If I misunderstood and I should send a reroll ASAP, please let me
> know; otherwise I already switched off for the evening.)

Nah, I do not think it is all that urgent.  I'd rather wait until we
hear positive "yup, that's the right way to do it" (or "no, you'd do
it this way instead" guidance) to waste an extra round.

Having said that, the topic won't touch 'next' with a known CI
glitch whose fix ought to be straight-forward especially with
help/nod from experts, and as far as I recall, there wasn't any
other outstanding issues for this round, even though we may already
have plans for possible follow-up enhancements, so let's not keep it
hanging unnecessarily longer.  Perhaps we'd all be happy if we can
resolve it before the end of this week or early next week?

Thanks.
