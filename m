Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B5C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D364EE1
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCQR2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:28:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58339 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhCQR1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:27:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCD3A118BCE;
        Wed, 17 Mar 2021 13:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cytbbItQMnO4GfUWORwtUm7gwfU=; b=W6FRry
        db8IIhz0utG/g9cxRJfWXEbzMoQdySKq5/q6fRXcISiKzK8hB/WCMDZJRbYRgXhG
        es51ASza5vx7YqnC9zGJQAJcih6KeVKeaUADibnpAFVbYNyUcbljjUzjn871za1M
        kId4cYR1U4UmYbjY3zuBAPikBkDHdXo5va27Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ayZiTJBZ9Ch+bEiXGQjo6CwCC+5YHwQ+
        P7W33Llaer0+cXR1nJMtnpMd4O5xu6462y+oq1m6k5UexAvpah18gopyJl2ax6rA
        Q1ItGZ5k4TvRqgYV5V8cuQ+DgBH22YgnOyMSRjB4lMpC7fdNdqX8K7SO1rUf3PBd
        JrXhVu9Ru5M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5C0D118BCD;
        Wed, 17 Mar 2021 13:27:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 046C6118BCC;
        Wed, 17 Mar 2021 13:27:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v4] format-patch: allow a non-integral version numbers
References: <pull.885.v3.git.1614859926974.gitgitgadget@gmail.com>
        <pull.885.v4.git.1614928211635.gitgitgadget@gmail.com>
        <CAPig+cSd-e76bOQY8yoZnRDbuQbZ_FNHJ5TV6BC+dAofPmk7DQ@mail.gmail.com>
        <CAOLTT8T14P1VfbbXnXpAV-6GfZ8jXUqqCVaY1Uxs3UtfnFvKvw@mail.gmail.com>
        <CAPig+cRkGvKU8b2vauUZ4=EtTj4DU2e9k0HciTVEz-6-P6X5KQ@mail.gmail.com>
Date:   Wed, 17 Mar 2021 10:27:40 -0700
In-Reply-To: <CAPig+cRkGvKU8b2vauUZ4=EtTj4DU2e9k0HciTVEz-6-P6X5KQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 16 Mar 2021 02:15:04 -0400")
Message-ID: <xmqqtup9y9kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14248F32-8746-11EB-A923-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Yes, it is a very minor modification to diff_title(), changing
> `reroll_count` from int to string.
>
> Moving the parsing into diff_title() also allows you to use the
> simpler name `reroll_count` for the string variable in cmd_fmt_patch()
> rather than the longer `reroll_count_string`; just change
> `reroll_count` from int to string.

It does clarify that the "string" version is the authoritative and
features that depend on being able to learn what the previous
iteration is is available only it is given an integral version
number.

It made a ton of sense when the code allowed an explicit "previous
iteration" to be given by the user also as a string to compute the
previous version with strtol_i() dance, so that diff_title() can be
a mere consumer of both string versions (the current one and the
previous one) without having to worry about how the previous one is
computed.  But without the "previous iteration" string carried
through the codebase as another first-class citizen just like the
"current iteration" string, it does not.

I actually think you would regret not allowing the explicit
"previous iteration" string from the command line and make it
another first-class citizen, but that is a different story.
