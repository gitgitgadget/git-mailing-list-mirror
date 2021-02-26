Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B25C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ABA64E4E
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 23:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBZXVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:21:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58921 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZXVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 18:21:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 060B6BAE49;
        Fri, 26 Feb 2021 18:20:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zk5EKfnc+IRz9coqHgJ9kEDxWe8=; b=xtbEaW
        3iLNP+YAhPTpJx8ThsXmfZ1IG9B84SMYX1oo0mi47x4yiw+uGDopTPoi3Q+hy1dU
        yTP65o6CQVleQZDnoXYJIFnMGRllGPBVAxbWY0HcFdAEKX7M0ZOWJIbWvtTJ2DZM
        Ph6RTZZCY8hkm8bD2R+eFkj1Sk5SAsWOuY76Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QfQs/afm4gMdsi+8HOiKtLRyPCcvTevv
        ffeDvmJbbUT9ae9+osKUeaYFuCGVZVsauE7raPYqFQdhD4mnBtPNtYi6iQqmkN7q
        roWDI2GWcCOfTTAtte4Ru+0e6nI3LLFi88ExHobJLdbe2dZDvk9W9mxfS9Pkozwj
        uJ5xG4xgLzI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0F76BAE48;
        Fri, 26 Feb 2021 18:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82E72BAE47;
        Fri, 26 Feb 2021 18:20:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jean-Marie Lemetayer <jeanmarie.lemetayer@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC] new subcommand: git sync
References: <CAAdc0hwmR7BF53_66LNaceLrkFPDphU-y2sLEGB_1YoR5ErQsg@mail.gmail.com>
        <87tupy7sx6.fsf@evledraar.gmail.com> <xmqq35xisbp3.fsf@gitster.g>
Date:   Fri, 26 Feb 2021 15:20:34 -0800
In-Reply-To: <xmqq35xisbp3.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        26 Feb 2021 14:31:36 -0800")
Message-ID: <xmqqlfbaquv1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AB195C6-7889-11EB-B0A0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> so that you can prepare
> ...
> beforehand and then eval the output from the script you wrote with
> "git for-each-ref".

Ehhh, not "eval the output from the script", but "eval the script".
In essense, you use "for-each-ref --format" as a tool to write a
script, and then execute it.
