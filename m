Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02175EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjGYXJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGYXJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:09:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75DE0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:08:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 71F2A3353E;
        Tue, 25 Jul 2023 19:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5yMxw0TiShgSWmBv2ZM2MxGAAWMla8EwixzYgi
        dAjss=; b=f4JqtFQ1ZOdFPQqv9ng4/yTW8FwWiv9Tkr+xc2Dy+UVouoVbj7JLa7
        ks4uVrH40RnqBKrN+A9fnInPtTDw43a4+6XatWejFBtbWCYwuy4y4ubk1U+CE4Fa
        uAjvtiAqRduPsvr5oK3HEGcLE6hv9EuuWtIVnSwpa1uJ4TSh9undo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6913E3353D;
        Tue, 25 Jul 2023 19:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 054393353B;
        Tue, 25 Jul 2023 19:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230705060812.2865188-1-christian.couder@gmail.com>
        <20230705060812.2865188-6-christian.couder@gmail.com>
        <xmqqh6qi1byn.fsf@gitster.g>
        <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
        <xmqqila9p3j8.fsf@gitster.g>
        <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
        <xmqqcz0fnbs8.fsf@gitster.g>
Date:   Tue, 25 Jul 2023 16:08:54 -0700
In-Reply-To: <xmqqcz0fnbs8.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        25 Jul 2023 10:25:43 -0700")
Message-ID: <xmqqo7jzh9mh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ADB1448-2B40-11EE-B2F5-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for walking through the codepaths involved.  We are good
> then.

Sorry, but not so fast.

https://github.com/git/git/actions/runs/5661445152 (seen with this topic)
https://github.com/git/git/actions/runs/5662517690 (seen w/o this topic)

The former fails t7700 in the linux-TEST-vars job, while the latter
passes the same job.

Thanks.

