Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98490C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E161130
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbhJ2Hfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:35:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64177 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhJ2Hfn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 03:35:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 200ED1591EE;
        Fri, 29 Oct 2021 03:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9LhXRKzbEQWu1HyQ1Oyglq9Us+XoeXVl84XEv9
        L+9os=; b=Tl9mRyPyS6MHA9cAhcBs08oEhYwD8uspgQ2ukBZjjTawCtRy8C3iTN
        cEJ+BuWq70EfvHE/CaGmB/KsR8UlA69La3hiE3Tj88A8KRjixtxThAZ2waIfuM3H
        NBWKNEMMDPtUNtgX4r8UXNeBNHcZ7TDSPU6ZIYrSE+1UB/mEHU6GM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 188881591ED;
        Fri, 29 Oct 2021 03:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2E131591EB;
        Fri, 29 Oct 2021 03:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr> <xmqqilxhq774.fsf@gitster.g>
        <20211029001552.GA29647@dcvr>
Date:   Fri, 29 Oct 2021 00:33:10 -0700
In-Reply-To: <20211029001552.GA29647@dcvr> (Eric Wong's message of "Fri, 29
        Oct 2021 00:15:52 +0000")
Message-ID: <xmqqy26cl1zd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78646602-388A-11EC-B41C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> v2 changes:
> * s/GIT_FSYNC/GIT_TEST_FSYNC/
> * disable fsync by default for tests, reduces setup for newcomers
> * fix style nit noted by Eric Sunshine

https://github.com/git/git/runs/4043532265?check_suite_focus=true#step:5:70

Seems to be dying in "git svn" tests somehow.
