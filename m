Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6CC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 16:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiI1QlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiI1QlO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 12:41:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617B3D4AAD
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 09:41:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F081542AA;
        Wed, 28 Sep 2022 12:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vkT58HUI79Dzba9VDXPK3Ll/cYqf1G/stEnHim
        gFtIM=; b=sy4Xv2en4+ssAAfMzFsv6jk+o7It3nczzi7tD2uPXvLZPYEVgk8ujX
        c96BR2PNhNpQUYaOgcbVP25K627XKhE8oamJUYutzbo2hw4AsNRY4EGtSvNFIfjq
        FIyRbj4ko7vMihE2GfoaD31jYePi46a8haYosQ9RdMuFT8WS2qNZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328461542A9;
        Wed, 28 Sep 2022 12:41:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AF2C1542A8;
        Wed, 28 Sep 2022 12:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: vd/fix-unaligned-read-index-v4, was Re: What's cooking in
 git.git (Sep 2022, #08; Tue, 27)
References: <xmqqtu4s1q1m.fsf@gitster.g>
        <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
        <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
Date:   Wed, 28 Sep 2022 09:41:08 -0700
In-Reply-To: <YzPLBN09zzlTdNgc@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 28 Sep 2022 00:18:12 -0400")
Message-ID: <xmqqv8p7xxi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C1E563C-3F4C-11ED-B3A6-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... I have no objection to adding more comments, but I am
> happy enough without them (like Junio, it may be that I'm overly
> familiar with how I expect our get_be() functions to handle alignment).
> ...
> So it's mostly just a minor annoyance for running the tests; we're
> probably better not to change any code, even trivially, this late in the
> release cycle.

Yup.  I never planned to merge the topic to 'master'.  The finishing
touch I expected was to help Phillip and friends with a bit of
explanation in the log message, and then it would be ready to wait
in 'next' for the next cycle.
