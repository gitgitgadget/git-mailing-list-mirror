Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09E5C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAAB60EBA
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhIHFW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:22:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51498 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhIHFW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 01:22:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A37A147CBC;
        Wed,  8 Sep 2021 01:21:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vya0qL5FB02ZrFk1IK2Q3prl6Xxr1rCRCU3AMx
        5H3K8=; b=QdjPOo7rERW7yznBZdm6ecUR/Tv6x7aOa3b5OP2/MpfPj99h5Irfv9
        RGITTrcAgIP/SJPXzMhXKlRlt+ZCGQGh8xXrI0yrxMUYAyIJJMT/dSqbUhblZnf+
        Qvt05MXrsxAzoe0Kc0QkK4vOAomMukRa46P9V2JWC6z7GeZyasdSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91DB0147CBB;
        Wed,  8 Sep 2021 01:21:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8410147CB9;
        Wed,  8 Sep 2021 01:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Cc:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v5 0/9] Sparse index: delete ignored files outside
 sparse cone
References: <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com>
        <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 22:21:16 -0700
In-Reply-To: <pull.1009.v5.git.1631065353.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Wed, 08 Sep 2021 01:42:24
        +0000")
Message-ID: <xmqqwnnr7icz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98DCE54C-1064-11EC-94B7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in V5
> =============
>
>  * Updated the locality of a cache_entry pointer.
>
>  * Rephrased a comment.
>
>  * Removed the patch adding a config option.
>
>  * I tried, but failed, to create a scenario where the call to
>    cache_tree_update() causes a test to fail. I still think this is valuable
>    as defensive programming for the reasons mentioned in the patch, which is
>    why I didn't remove them here.

OK.  

The 'sg/test-split-index-fix' topic that has been queued in 'seen'
textually depended on the earlier iteration of this topic, so I'll
discard it while replacing this topic.

