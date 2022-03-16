Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F9AC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 18:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357727AbiCPSL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 14:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357725AbiCPSL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 14:11:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC866D95B
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 11:10:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FA4011EBFC;
        Wed, 16 Mar 2022 14:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9IREmB0nRwVSt1kPIjvAi1ZVavaX7cksvI6Man
        fKa3I=; b=pR5FYvDsGKCQBrvyb9sCBdCErWjfNEwqbnNWgtgxd3yucz3zns8oiK
        QI6n93zQHq1Rb0Hg6VQpwFtCSDmXfTgqUrtNm7pD6kMF7NsMEcTHBYQtNmvhXXls
        APGBjkNlrlxybeSEYB/ZH9yvj80WZ/q2GJ9Z6Ol3jY/HcFhqr0Ef4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D0F311EBFB;
        Wed, 16 Mar 2022 14:10:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AE7C11EBF7;
        Wed, 16 Mar 2022 14:10:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
        <xmqqbky6bgw0.fsf@gitster.g>
        <CANQDOdcak1nV1Pr9cmyk9dgEjHOH8Au92pUMskJipUodzskzqQ@mail.gmail.com>
        <xmqq35jhoows.fsf@gitster.g>
        <CANQDOde+3QaTWnNWPQzz85iAGH=M-ZhG-HDR9SP4FCJf+=k43A@mail.gmail.com>
Date:   Wed, 16 Mar 2022 11:10:06 -0700
In-Reply-To: <CANQDOde+3QaTWnNWPQzz85iAGH=M-ZhG-HDR9SP4FCJf+=k43A@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 16 Mar 2022 10:59:45 -0700")
Message-ID: <xmqqpmmllqf5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5108B388-A554-11EC-81D9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

>> Did I get it right, more-or-less?
>
> Yes, that's my understanding as well.

I guess what I wrote would make a useful material for early part of
the log message to help future developers.

Thanks.
