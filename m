Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D5C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLEKGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 05:06:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50296 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhLEKGG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 05:06:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E32A0F76A8;
        Sun,  5 Dec 2021 05:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=5WikwmTvoKT/IV8TvdMATcfGyKFGLRti1oZENCL8Ht0=; b=B3Je
        Nvk6o3xZgxZdOusQ3m4TJhOujhZ/SIHlLoFcu/zrMfHJmkVAp5smeiTA1HFpRh4N
        PRPQ0CdTa5Y3UHEc/8fEUXBnxL1FvZck9LK5kT6AK5jYXIbbM655SGM0zmt51wtX
        WGyfi6984lZtdOo2BnsQO60ZRrygs2ZFngUODfk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAA41F76A7;
        Sun,  5 Dec 2021 05:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E7A1F76A6;
        Sun,  5 Dec 2021 05:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v10 00/15] Upstreaming the Scalar command
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
        <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
Date:   Sun, 05 Dec 2021 02:02:37 -0800
Message-ID: <xmqq4k7nmksi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A248176-55B2-11EC-B777-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> From your wording it sounds like the plan might not include moving
> these tests over.  Perhaps it doesn't make sense to move them all
> over, but since they've caught problems in both Scalar and core Git,
> it would be nice to see many of those tests come to Git as well as
> part of a future follow on series.

Yeah, we may be initially queuing this without tests for expediency,
but a production code cannot go forever without CI tests to ensure
continued code health.  People make changes in other parts of the
system Scalar may depend on and unknowingly break some assumption
Scalar makes on it.

