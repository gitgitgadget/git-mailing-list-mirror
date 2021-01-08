Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783F7C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A723A7B
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 19:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbhAHTtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 14:49:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65276 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbhAHTtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 14:49:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CEEB954CB;
        Fri,  8 Jan 2021 14:48:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0RaNy21+4VUTh9QR2BqAOjCsAfk=; b=G1Xaec
        opRwvSwwEQpchaT/taQt6GZek2QEEIdew+gSfAdwE5d43NrvTNDc1Xh4HBPCWaF2
        cS+ecVD92CTbbe3xjhBnrlJbM8gGHeVlWlZv2X7oJWZINTKvdt5w7zBlaoc+w3v1
        D/Vfn5vwoFM8VmMbxPgrvNd5qPszea0SJ0ifw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bRXDy2ftbNi/D/4yOi6tPehdyD2sV+9j
        97iIYxzuf8do3X5w9QbkYNoHTf83eODXNzrpC97S0rXaAWOFjtZTfB+VczAUPvsG
        bYrGiYN9x8MpKo/aFzW2ziltp9Q9M8WiRgidgnhATJENxxY9w/O+hma2iilnvwNp
        TH86N/+5Gh0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43CD0954C9;
        Fri,  8 Jan 2021 14:48:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3D60954C7;
        Fri,  8 Jan 2021 14:48:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was
 Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
        <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
        <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
        <87wnwordzh.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
        <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
Date:   Fri, 08 Jan 2021 11:48:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 8 Jan 2021 15:56:20 +0100
        (CET)")
Message-ID: <xmqq8s93i506.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C038F9E-51EA-11EB-B7F5-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But I don't see how that would make this process more inviting to new
> contributors.

Appearing to be inviting should not be our primary goal.  

Instead, the goal should be to make it easier to contribute quality
patches.  By doing so, the smooth experience may attract more new
people, which may end up to be "inviting" in the end, but that is as
a side effect.

> BTW I get the sense that many Git mailing list regulars have this idea
> that making the review process easier for one-time contributors would
> invite too many low-quality contributions.

I don't get such a sense at all.

Sure, if GGG or any other mechanism encourages spamming the list
with low-quality patches, that may harm our productivity, but that
is not what we are doing.  And I do not see how it can be a source
of low-quality contributions to send patches that by default do not
CC them to random people when the sender does not know when it is
appropriate to do so.  Sure, if the patches asked for attention from
appropriate reviewers (the maintainer included), it might get more
responses, but we more often review patches that are only sent to
the list than those that are sent directly to us via Cc _anyway_.

On the other hand, inviting more new people to CC reviewers whose
mailboxes are already full when the patches are not yet ready would
harm productivity of recipients of such patches.

One attribute of a quality patch is that it is CC'ed to the right
people and at the right time.
