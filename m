Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EEC433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7388A60F38
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhJ2ShB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:37:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64360 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhJ2ShA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:37:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09C2C15D3BB;
        Fri, 29 Oct 2021 14:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AfEhS/0PD/fJE72B1YydB6VRIPtlpWFwN/NOU
        r8l6w=; b=JQ0XH1ESL8YLGv9Cu61zvi8LT0316/xRoE50D8lEE76W2Uuiex5xdZ
        FrhHeXCd6hAlynJ1FZGHtLBfqV0Ddzr0Mf4c2PhxhAhFJcHpC/ZW0hlOLaisVl7x
        wkqbm0aoxb1VP+yKyGlscfP84JIYZ4kxfqfAW7TLiYiP7V0PX7s60=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E731415D3BA;
        Fri, 29 Oct 2021 14:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A203A15D3B3;
        Fri, 29 Oct 2021 14:34:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 11:34:26 -0700
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 29 Oct 2021 13:59:11
        +0000")
Message-ID: <xmqqk0hvllxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D90CB2C8-38E6-11EC-A3FC-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series came in via the Git for Windows fork
> [https://github.com/git-for-windows/git/pull/3487], and I intend to merge it
> before v2.34.0-rc0, therefore I appreciate every careful review you gentle
> people can spare.

It is way too late for my tree to go in before -rc0, but the patches
in the last round, with the "Changes since v2" description below,
all sound sensible, including the decision to stop here, instead of
doing "everything should be either size_t or intmax_t" conversion.

7/8 did not apply for me to the tip of 'master', but "am -3" wiggled
it in.  You may want to double check the results.

As the primary author of the series, given the cover title matches
the title of one step in the series, seems to be Matt, let me queue
them under mc/clean-smudge-with-llp64 topic.

Thanks.
