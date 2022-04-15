Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A05C433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 16:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355980AbiDOQ4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiDOQ4R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 12:56:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30E397297
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 09:53:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48127109B85;
        Fri, 15 Apr 2022 12:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lAzlQuOqEYeN
        utdt13SJYl+VpGhnGwRO+ir5V6R6Mi8=; b=sVDAXNKO3leOHOj8kpuKt1KET9rT
        xYWxZ7RMqkAbeG5A1CqClfydeav9Ia9WI5uOjWDMEw20z0neA/OspRPjvMZnCK9Z
        qVY9EqiqQQXbvDeCvd49Qb6SjPyYphla+kNr/3DWErEGdt2wrxNGnymUNFbgEgIk
        /BTcsTvm6d4L68c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FB27109B84;
        Fri, 15 Apr 2022 12:53:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93C5B109B83;
        Fri, 15 Apr 2022 12:53:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
        <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
        <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
        <xmqq4k2w92xo.fsf@gitster.g>
        <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
        <220415.86sfqebhl6.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 09:53:44 -0700
In-Reply-To: <220415.86sfqebhl6.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 15 Apr 2022 15:27:26 +0200")
Message-ID: <xmqqr15ye19j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D1A99AE-BCDC-11EC-916B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think that would be great if you can spend the time, but Junio's
> already pushed out a revert of the topic for the final 2.36.0, can you
> confirm that current "master" solves the issues you had?

Thanks for asking this question, which is lot more urgent and I
should have asked last night before I went to bed.  Yes, Bryan
already said that the revert in 'seen' the previous day made their
system happier, but it certainly helps to know the reverts were OK
at the tip of 'master' without all the other random topics.

> So revert/retry & extra tests etc. can wait until the post-release, and
> likely Patrick will be back to work on it at that time...

Yup.
