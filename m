Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF0FCCA482
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiGLOTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiGLOTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 10:19:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D5F0B
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 07:19:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1505C1A5C9E;
        Tue, 12 Jul 2022 10:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Eg9OxRrXIjXIlee35ojxFzvBqTZi7o6CdYLks
        gQx0k=; b=CZvkq6GpX96eidejYpeauqhOQ1EsoH16h9z9g9A9sTqzycXqQNAPxa
        dRN5qK+ttLbfY3WyQCfDoJHtbSzucEjWNuVXDDVMD0eYzJ+pWbaM6tV5XU4EeOJz
        /at/bjN4eg3DBvtVC409jJ9yT4xsomrcV0TjNcdcAlt7mUz+rn7nY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CB691A5C9D;
        Tue, 12 Jul 2022 10:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 940B01A5C9C;
        Tue, 12 Jul 2022 10:19:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Han Xin <hanxin.hx@bytedance.com>,
        Michael J Gruber <git@grubix.eu>, chiyutianyi@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org,
        haiyangtand@gmail.com, jonathantanmy@google.com, me@ttaylorr.com,
        ps@pks.im
Subject: Re: [External] Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
        <cover.1656593279.git.hanxin.hx@bytedance.com>
        <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
        <165736941632.704481.18414237954289110814.git@grubix.eu>
        <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
        <xmqqk08jo147.fsf@gitster.g>
        <CAKgqsWVD2108f0PyJGp6mVKp2cGd_V_MiiQO3SAPm+LEHcb2mA@mail.gmail.com>
        <xmqq1quqkiq2.fsf@gitster.g>
        <Ys0WlWFIuhP8b2hb@coredump.intra.peff.net>
Date:   Tue, 12 Jul 2022 07:19:17 -0700
In-Reply-To: <Ys0WlWFIuhP8b2hb@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 12 Jul 2022 02:37:09 -0400")
Message-ID: <xmqqsfn6ifbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DE49B86-01ED-11ED-AE7B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... it's much more likely that a _new_
> bug will cause one. I.e., every test we already carry is a candidate to
> accidentally loop forever in this way. This is just the one we happen to
> have seen. Once fixed, I don't know that it's at any more risk of
> reocurring than any other problem.

Thanks.  

This kind of perspective is why I love to have you on the list.
Once said, it is so obvious but somehow I (or other people) failed
to phrase it so clearly.

Very much appreciated.
