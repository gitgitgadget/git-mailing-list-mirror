Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65726C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B04023D1F
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 21:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbgLIV6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 16:58:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59176 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLIV6i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 16:58:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABFA39EBB6;
        Wed,  9 Dec 2020 16:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o9X/9KT5HE8qtnIcaHKZgQkoFX0=; b=s3oEVb
        /UL3he2vAQycxLc2gDM2WLGYRf4w9qk7mv7YNGk6ieFDLFVH3YDvZgBT0oLboqkK
        ZGnUGNdmCI7XR07UtWVG+uU6FZzSifTcin2C1QXR+m0n3yq9SZr54V2skPuDpsM+
        k3wa1nV7dmQB4ri3EaydCi9/ugUYdI/EqKRj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hSfbKlj6Qx8NiAaOT0jZ72tZ3k/N1QTS
        vVb01GCxy41A4wCLJfOFQodG5LSUQwtDTzIUgg0drd1DyuTCgcMQZ3vhj5tg4KIc
        MI9Rd6yEGoVYUBcaXOAVjJZsAi9PgLeM8ss7Olk0lX7D/pIh6K+Jvh6jGGMNrKk7
        Yw1kicVQnC0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A34679EBB5;
        Wed,  9 Dec 2020 16:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 324F69EBB4;
        Wed,  9 Dec 2020 16:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/init-defaultbranch-advice, was Re: What's cooking in git.git
 (Dec 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet>
Date:   Wed, 09 Dec 2020 13:57:56 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 9 Dec 2020 15:11:44 +0100
        (CET)")
Message-ID: <xmqqft4e1w2j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98AA3E2A-3A69-11EB-BD4A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 8 Dec 2020, Junio C Hamano wrote:
>
>> * js/init-defaultbranch-advice (2020-11-24) 4 commits
>>  - init: provide useful advice about init.defaultBranch
>>  - get_default_branch_name(): prepare for showing some advice
>>  - branch -m: allow renaming a yet-unborn branch
>>  - init: document `init.defaultBranch` better
>>
>>  Our users are going to be trained to prepare for future change of
>>  init.defaultBranch configuration variable.
>>
>>  Expecting a reroll.
>>  cf. <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
>>  I think a new advice.defaultBranchName is a bad idea.
>
> Unfortunately, this objection is news to me. Why would it be anything but
> a legitimate interest to say "yeah, whatever, Git, just use the default
> branch name, I'm fine with it"?

Message sent on Nov 24 is a news to you now?

Anyway, I do not think those users who said "I'm fine with it" would
be fine when the switchover happens outside their control.

If they are truly fine, we could invent init.defaultBranch=:random
that chooses a random branch name and point HEAD at it, and make
that the default.  Those who are fine do not really care what name
the initial branch gets would be fine with that as well, but you
would agree that it is an absurd alternative, no?  I find it equally
absurd to say "switch to a new name any time without telling me, I
am fine with it".



