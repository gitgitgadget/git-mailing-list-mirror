Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51847C433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179352332A
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgLWPFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:05:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56628 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgLWPFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 10:05:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AAFA116C44;
        Wed, 23 Dec 2020 10:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=28LAZgDnbAQ7cTkwikR+U4dI1Fk=; b=rVxXbxCvgstC8nsi4XVm
        PvYq0go1UJV41G1/NwRlf27x/+AcaOapgXRwTmo5I6oDw0gM9DYKoJkm2o0sAYoY
        eLZgGEZjB3ER8qtGFtQBW7Qrgn82GyVT+/NatPsO9siMRfoR+NfgmssTArO9hMA1
        LhhRcM+7ABxCd91B0L0+TTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=w/fzx5Rq1FoMXwtgsmi3jUKExmjMJfBE+NXNyNLNT8BYhp
        jiWA4NZKGo3gY2SP5pAxgxSOBbBXeLK0K+r9chtefRjpc4bybt4ehGei9Rz+kNkV
        0ds1thuX8AuH/k3siR4uuTARTu1V6mnkhxkS9vm04R+lYZ6kUatDCSCMZRKSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71632116C43;
        Wed, 23 Dec 2020 10:04:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FB38116C42;
        Wed, 23 Dec 2020 10:04:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Subject: Nobody is THE one making contribution
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
        <5fdc7a7d3a933_f4673208d0@natae.notmuch>
        <20201219001358.GA153461@ellen>
        <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
        <20201221042501.GA146725@ellen>
        <5fe033e0ec278_96932089d@natae.notmuch>
        <20201221073633.GA157132@ellen>
        <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
        <5fe134eeaec71_11498208f9@natae.notmuch>
        <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
        <5fe2c64bd3790_17f6720897@natae.notmuch>
        <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
        <5fe2d89c212e8_18dc12083e@natae.notmuch>
Date:   Wed, 23 Dec 2020 07:04:23 -0800
Message-ID: <xmqqzh248sy0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2574CA2A-4530-11EB-A69F-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> > But I'm not going to pretend I'm fine with a change I disagree with; I'm
>> > not. Especially when nobody is paying me to do this.
>> ...
>> >> The community needs to do its part in making you and everyone else
>> >> feel welcome. At the same time you need to do your part in making
>> >> contributors, especially the new ones, feel welcome and appreciated.
>> >> Being overly critical can turn developers away from the project.
>> >
>> > Who are you talking about? I'm the one who made the contribution.
>> 
>> What does the "change you disagree with" you mention above refer to?
>> Changes suggested by reviewers to add per-tool knob?
>
> Yes.

If so, please realize that this is a team effort.  You are not THE
one making contribution.  Everybody else also is.  You are building
on top of others' code, others are helping you to improve your
patches with their input, and others can and will later build on top
of what you have done.

If you are not fine with a change others will make on top of what
you did, well, tough.  It's not like by sending a patch you lick a
corner of the cake and make it untouchable by others.

Just as you said, you can agree to disagree and move on.  Once a
rough concensus is reached that the work on top of what you did is a
good direction to go, it would not get us anywhere to repeat the
same opinion over and over again to block it.

