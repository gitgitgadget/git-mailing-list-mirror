Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6967C43334
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiGHTBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiGHTBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 15:01:16 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B11EAFF
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 12:01:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E62F144D9A;
        Fri,  8 Jul 2022 15:01:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tIElzTI04lrOeMisw258uARM4qbACbjaqADsC8
        QFdh0=; b=wRJmRAEzEUXu+MJq4GJx81mvyL8CrH645H/rKIJ+3yF1nXw3LkKGrI
        08ibzkkT+3aeaivlKl/fyR76b9bBEYvfkKrua1UHyAWUZaP3KHICP8psLla9rj0M
        CQJD/kc8QGHU4nje2yAHL+yKWrbizUiOTSH1u8BHn1WV4PjRL4G2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1F57144D98;
        Fri,  8 Jul 2022 15:01:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BEBC144D97;
        Fri,  8 Jul 2022 15:01:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj?= =?utf-8?Q?=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 1/5] Documentation/git-config.txt: add SCOPES section
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <5c58db3bb2189f3b4193a682aa3b43f3bfa95796.1657234914.git.gitgitgadget@gmail.com>
        <xmqq4jzsxze4.fsf@gitster.g>
        <kl6l5yk77d4b.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 08 Jul 2022 12:01:06 -0700
In-Reply-To: <kl6l5yk77d4b.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Fri, 08 Jul 2022 10:01:08 -0700")
Message-ID: <xmqq1quvwhsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 536203AA-FEF0-11EC-81A1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> Problem inherited from the original, but I suspect that rephrasing
>> "not available" to "missing" (or "does not exist") may make it
>> easier to follow.
>> ...
>
> The only change I'd suggest is to expand "missing" -> "missing or
> unreadable". The original wording is "not available", which could be
> interpreted to cover both cases. We'd obviously also have to amend
> "not available or readable" accordingly.

Probably.  I wonder if we should document that we at least warn when
a file we are expected to read exists but is not readable (instead
of simply saying "is ignored"), but other than that I agree with you.

> Thanks! Shall I apply your suggestions, or were you planning to apply
> them yourself?

Definitely not the latter ;-)
