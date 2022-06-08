Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiFHVDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiFHVDc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 17:03:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D271DB1CE
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 14:03:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5662312F5D4;
        Wed,  8 Jun 2022 17:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NNRpyrWY06IKhw/7IvpKbur+EZk/fuSmcZF+HD
        oFT3M=; b=SsZp0QEHzonALFj4fUfce4PKosyrH/Dfv38UadGbnQVyeHrjR/KHoW
        9MDVZlkTPmQ8Zprp40LDOmVEQp3vXER3aV4tcrx5g6uRRVjjEF0N1MYeVzqommNc
        hwH+9JdPBmWSkmp0gBdmdPB3O+p9B/oMzBXqMdI4K2cE5Z/MK59YE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48A9B12F5D3;
        Wed,  8 Jun 2022 17:03:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9DD212F5D2;
        Wed,  8 Jun 2022 17:03:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
        <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
        <xmqqv8theehf.fsf@gitster.g> <xmqqczfpe9ua.fsf@gitster.g>
        <YqD100DRVJoZCC+x@coredump.intra.peff.net>
Date:   Wed, 08 Jun 2022 14:03:27 -0700
In-Reply-To: <YqD100DRVJoZCC+x@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Jun 2022 15:17:39 -0400")
Message-ID: <xmqq1qvyrhpc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 720731AC-E76E-11EC-A4CB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do agree that an environment variable would be a better selector than
> "this code is linked against test-tool". I thought so even back in:
>
>   https://lore.kernel.org/git/20180507090109.GA367@sigill.intra.peff.net/
>
> :) That message also covers the flip-side case discussed earlier in this
> thread: why calling abort() unconditionally in the test suite can be a
> pain.

Nice.  Thanks.
